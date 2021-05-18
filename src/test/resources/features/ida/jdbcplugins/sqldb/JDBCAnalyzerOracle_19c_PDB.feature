@MLP-4630
@MLPQA-20493
@REQ_MLP-7096
Feature:Verification of JDBC Analyzer using Oracle 19c PDB database and plugin validation

  @precondition
  Scenario:SC#1_1_Update credential payload json for Oracle19cPDB
    Given User update the below "Oracle19cPDB credentials" in following files using json path
      | filePath                                                     | username    | password    |
      | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleCredentials.json | $..userName | $..password |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline:SC#1_2_Add valid Credentials for Oracle19cPDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                 | body                                                                    | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusOracleCredentials        | idc/EdiBusPayloads/credentials/EDIBusValidCredentials.json                  | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EDIBusOracleCredentials        |                                                                             | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle19cPDBCredentials        | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleCredentials.json            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle19cPDBCredentials        |                                                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle19cPDBInvalidCredentials | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleInvalidCredentials.json     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle19cPDBInvalidCredentials |                                                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle19cPDBEmptyCredentials   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleCredentialsEmpty.json       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle19cPDBEmptyCredentials   |                                                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root                                  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/businessApplicationCataloger.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root                                  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/businessApplicationAnalyzer.json  | 200           |                  |          |

  ##7046128##
  @webtest @negative
  Scenario:SC#1_3_Verify whether the background of the panel is displayed in red when connection is unsuccessful due to invalid / Empty credentials in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute                      |
      | Data Source Type | OracleDBDataSource             |
      | Credential       | Oracle19cPDBInvalidCredentials |
      | Node             | LocalNode                      |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                                         |
      | Name      | Oracle19cPDBDS_Test                                                               |
      | Label     | Oracle19cPDBDS_Test                                                               |
      | URL       | jdbc:oracle:thin:@diqscanora01v.diq.qa.asgint.loc:1522/pdbdb19c.DIQ.QA.ASGINT.LOC |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                    |
      | Credential | Oracle19cPDBEmptyCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  ##7046131##
  @positve @regression @sanity @webtest
  Scenario:SC#1_4_Verify whether the background of the panel is displayed in green when connection is successful in Step1 pop up when user logs in for the first time in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute               |
      | Data Source Type | OracleDBDataSource      |
      | Credential       | Oracle19cPDBCredentials |
      | Node             | LocalNode               |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                                         |
      | Name      | Oracle19cPDBDS_Test                                                               |
      | Label     | Oracle19cPDBDS_Test                                                               |
      | URL       | jdbc:oracle:thin:@diqscanora01v.diq.qa.asgint.loc:1522/pdbdb19c.DIQ.QA.ASGINT.LOC |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"

  ##7046143##
  @webtest
  Scenario:SC#1_5_Verify whether the background in the Cataloger panel is red when connection is unsuccessful due to Invalid / Empty Credentials
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
      | fieldName   | attribute                      |
      | Type        | Cataloger                      |
      | Plugin      | OracleDBCataloger              |
      | Plugin      | OracleDBCataloger              |
      | Data Source | Oracle19cPDBDS_Test            |
      | Data Source | Oracle19cPDBDS_Test            |
      | Credential  | Oracle19cPDBInvalidCredentials |
      | Credential  | Oracle19cPDBInvalidCredentials |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                  |
      | Name      | Oracle19cPDBCataloger_Test |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Configuration Sources Page"
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute                    |
      | Credential | Oracle19cPDBEmptyCredentials |
      | Credential | Oracle19cPDBEmptyCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Configuration Sources Page"
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  ##7046145##
  @webtest
  Scenario:SC#1_6_Verify whether the background in the Cataloger panel is green when connection is successful due to valid Credentials
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
      | fieldName   | attribute               |
      | Type        | Cataloger               |
      | Plugin      | OracleDBCataloger       |
      | Plugin      | OracleDBCataloger       |
      | Data Source | Oracle19cPDBDS_Test     |
      | Data Source | Oracle19cPDBDS_Test     |
      | Credential  | Oracle19cPDBCredentials |
      | Credential  | Oracle19cPDBCredentials |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                  |
      | Name      | Oracle19cPDBCataloger_Test |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"
    And user "click" on "Save" button in "Add Configuration Sources Page"

  Scenario Outline:SC#2_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                           | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                    | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                | 200           | Oracle19cPDBDS                  |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithSchemaFilter.json | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                | 200           | OracleCatalogerWithSchemaFilter |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                               | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |

#  ##6549303## # Bug id - MLP-24557
#  @sanity @positive @webtest @edibus
#  Scenario:MLP-9043_Verify the OracleDB items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Orc19cPDBCataloger" and clicks on search
#    And user performs "facet selection" in "Orc19cPDBCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Synonym       |
#      | Column        |
#      | UserRole      |
#      | Table         |
#      | Index         |
#      | User          |
#      | Constraint    |
#      | Tablespace    |
#      | File          |
#      | Routine       |
#      | Trigger       |
#      | Schema        |
#      | Analysis      |
#      | Sequence      |
#      | Cluster       |
#      | Configuration |
#      | Database      |
#      | DatabaseLink  |
#      | Service       |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/EDIBUSOracleConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                              | response code | response message | jsonPath                                            |
#      | application/json | raw   | false | Put          | settings/analyzers/EDIBusDataSource                                 | idc/EdiBusPayloads/datasource/EDIBusOracleDS.json | 204           |                  |                                                     |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/EDIBUSOracleConfig.json        | 204           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleDB |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleDB')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleDB  |                                                   | 200           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleDB |                                                   | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleDB')].status |
#    And user enters the search text "EDIBusOracleDB" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusOracleDB%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "Orc19cPDBCataloger" and clicks on search
#    And user performs "facet selection" in "Orc19cPDBCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                     |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                             |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Relational Databases/Oracle |
#      | $..selections.['type_s'][*]                   | Database                                               |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                               | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=Orc19cPDBCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
#    And user enters the search text "Orc19cPDBCataloger" and clicks on search
#    And user performs "facet selection" in "Orc19cPDBCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Schema" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                             |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Relational Databases/Oracle |
#      | $..selections.['type_s'][*]                   | Schema                                                 |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                               | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=Orc19cPDBCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA ) |
#    And user enters the search text "Orc19cPDBCataloger" and clicks on search
#    And user performs "facet selection" in "Orc19cPDBCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                          |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                             |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Relational Databases/Oracle |
#      | $..selections.['type_s'][*]                   | Table                                                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                               | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=Orc19cPDBCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
#    And user enters the search text "Orc19cPDBCataloger" and clicks on search
#    And user performs "facet selection" in "Orc19cPDBCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                             |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Relational Databases/Oracle |
#      | $..selections.['type_s'][*]                   | Column                                                 |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                               | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=Orc19cPDBCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
#    And user enters the search text "Orc19cPDBCataloger" and clicks on search
#    And user performs "facet selection" in "Orc19cPDBCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                             |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @*Oracle≫DEFAULT≫DWR_RDB_SCHEMA≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @*Oracle≫DEFAULT≫DWR_RDB_COLUMN≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @*Oracle≫DEFAULT≫DWR_RDB_TABLE_OR_VIEW≫@* ),AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @*Oracle≫DEFAULT≫DWR_RDB_DATABASE≫@* ),AND,( TYPE = DWR_IDC )      |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @*Oracle≫DEFAULT≫DWR_RDB_DB_SYSTEM≫@* ),AND,( TYPE = DWR_IDC )     |
#
#  @sanity @positive @regression @edibus
#  Scenario:Delete EDI Bus Analysis file
#    Given Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                        | type     | query | param |
#      | SingleItemDelete | Default | bulk/EDIBus/EDIBusOracleDB% | Analysis |       |       |
#

  ##6767916## ##6767915## ##6767912## ##6767895##
  @webtest @jdbc @MLP-5641
  Scenario:SC#2_2_Verify the Database(OracleDB) should have the appropriate metadata information in IDC UI and Database
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                                 | Action                    | query         | ClusterName                     | ServiceName | DatabaseName               | SchemaName        |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.PDBDB19C_DIQ_QA_ASGINT_LOC.Description | metadataValuePresence     | DatabaseQuery | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC |                   |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE12C_SCHEMA1.Lifecycle            | metadataAttributePresence | SchemaQuery   | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "FULL_NAME" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "FULL_NAME" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | diqscanora01v.diq.qa.asgint.loc |
      | ORACLE:1522                     |
      | PDBDB19C.DIQ.QA.ASGINT.LOC      |
      | ORACLE12C_SCHEMA1               |
      | ORACLE_TAG_DETAILS              |
      | FULL_NAME                       |
    And user enters the search text "ORACLE_TAG_DETAILS" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    Then user verify "catalog not contains" any "Constriant" attribute under "Metadata Type" facets

  ##6767917##
  @webtest @jdbc @MLP-9602
  Scenario:SC#2_3_Verify the dependencies appearing properly for VIEW/Triggers/Procedure/Functions
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "OCPPDSVT" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "OCPPDSVT" item from search results
    Then user performs click and verify in new window
      | Table        | value  | Action                 | RetainPrevwindow | indexSwitch |
      | dependencies | OCPPVT | verify widget contains | No               |             |
    And user enters the search text "TRIGGER1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Trigger" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TRIGGER1" item from search results
    Then user performs click and verify in new window
      | Table        | value        | Action                 | RetainPrevwindow | indexSwitch |
      | dependencies | TRIGGERTEST  | verify widget contains | No               |             |
      | dependencies | TRIGGERTEST1 | verify widget contains | No               |             |
    And user enters the search text "OCPPTESTFUNCTION" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OCPPTESTFUNCTION" item from search results
    Then user performs click and verify in new window
      | Table        | value     | Action                 | RetainPrevwindow | indexSwitch |
      | dependencies | OCPPFT2T1 | verify widget contains | No               |             |
      | dependencies | OCPPFT2T2 | verify widget contains | No               |             |
    And user enters the search text "PROT2T" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PROT2T" item from search results
    Then user performs click and verify in new window
      | Table        | value    | Action                 | RetainPrevwindow | indexSwitch |
      | dependencies | OCPPT2T1 | verify widget contains | No               |             |
      | dependencies | OCPPT2T2 | verify widget contains | No               |             |

  ##6767894## ##6477888##
  @jdbc @MLP-5641 @MLP-9602
  Scenario:SC#2_4_Verify the Oracle Table should have constraints like Primary Key,Foreign key,Unique Key and Check constraints and Schema has index.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                                 | Action                | query                     | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename         |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_CHECK_SUPPLIER_ID.Description   | metadataValuePresence | ConstraintQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_CHECK_SUPPLIER_ID   |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_SUPPLIER_UNIQUETEST.Description | metadataValuePresence | ConstraintQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_SUPPLIER_UNIQUETEST |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.PERSON_INFO_PK.Description             | metadataValuePresence | ConstraintQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | PERSON_INFO_PK             |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FK_PERSON_INFO.Description             | metadataValuePresence | ConstraintQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | FK_PERSON_INFO             |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEINDEXTEST.Description            | metadataValuePresence | IndexQuerywithSchema      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLEINDEXTEST            |

###########################################RelationShip Verification#######################################

 ##6767911##
  @webtest @MLP-9602
  Scenario:SC#3_1_Verify the relationships shows properly between the table and constraint under relationship tab
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PERSON_INFO_PK" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PERSON_INFO_PK" item from search results
    Then user performs click and verify in new window
      | Table   | value          | Action                 | RetainPrevwindow | indexSwitch |
      | index   | PERSON_INFO_PK | verify widget contains | No               |             |
      | columns | PERSON_ID      | verify widget contains | No               |             |
    And user enters the search text "FK_PERSON_INFO" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FK_PERSON_INFO" item from search results
    Then user performs click and verify in new window
      | Table   | value                         | Action                 | RetainPrevwindow | indexSwitch |
      | parent  | PERSON_INFO_PK                | verify widget contains | No               |             |
      | parent  | ORACLE_PERSON_ADDRESS_DETAILS | verify widget contains | No               |             |
      | columns | PERSON_ID                     | verify widget contains | No               |             |
    And user enters the search text "ORACLE_SUPPLIER_UNIQUETEST" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_SUPPLIER_UNIQUETEST" item from search results
    Then user performs click and verify in new window
      | Table   | value                      | Action                 | RetainPrevwindow | indexSwitch |
      | index   | ORACLE_SUPPLIER_UNIQUETEST | verify widget contains | No               |             |
      | columns | SUPPLIER_ID                | verify widget contains | No               |             |
    And user enters the search text "ORACLE_SUPPLIER_UNIQUETEST" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_SUPPLIER_UNIQUETEST" item from search results
    Then user performs click and verify in new window
      | Table           | value             | Action                 | RetainPrevwindow | indexSwitch |
      | referencedTable | ORACLE_UNIQUETEST | verify widget contains | No               |             |
      | columns         | SUPPLIER_ID       | verify widget contains | No               |             |

  Scenario Outline:SC#3_2_user retrieves ids for specific item name
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>"
    Examples:
      | database      | catalog | name                       | type       | targetFile                                                                 |
      | APPDBPOSTGRES | Default | PERSON_INFO_PK             | Constraint | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/constraintIDs.json |
      | APPDBPOSTGRES | Default | FK_PERSON_INFO             | Constraint | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/constraintIDs.json |
      | APPDBPOSTGRES | Default | ORACLE_SUPPLIER_UNIQUETEST | Constraint | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/constraintIDs.json |
      | APPDBPOSTGRES | Default | ORACLE_SUPPLIER_UNIQUETEST | Index      | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/indexIDs.json      |

  Scenario Outline:SC#3_3_user copy the id to payload
    Given user copy the id from "<file>" to "<payloadFile>" with "<type>" using "<jsonPath>"
    Examples:
      | file                                                                       | payloadFile                                                                            | type       | jsonPath                      |
      | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/constraintIDs.json | Constant.REST_DIR/response/Oracle19cPDB/payloads/person_info_pk.json                   | Constraint | $..PERSON_INFO_PK             |
      | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/constraintIDs.json | Constant.REST_DIR/response/Oracle19cPDB/payloads/fk_person_info.json                   | Constraint | $..FK_PERSON_INFO             |
      | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/constraintIDs.json | Constant.REST_DIR/response/Oracle19cPDB/payloads/oracle_supplier_uniquetest.json       | Constraint | $..ORACLE_SUPPLIER_UNIQUETEST |
      | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/indexIDs.json      | Constant.REST_DIR/response/Oracle19cPDB/payloads/oracle_supplier_uniquetest_index.json | Index      | $..ORACLE_SUPPLIER_UNIQUETEST |

  Scenario Outline:SC#3_4_user get the response of lineage edges and store the lineage values in file
    Given user hits "<request>" with "<url>" "<body>" for id from "<file>" "<type>" using "<path>" and verify "<statusCode>" and store response of "<jsonPath>" in "<targetFile>" for "<name>"
    Examples:
      | request | url                                                                                       | body | file                                                                       | type | path                          | statusCode | jsonPath   | targetFile                                                                                    | name                       |
      | Get     | searches/Default/query/queryDiagramOut/Default.Constraint:::DYN?what=id,type,name,catalog |      | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/constraintIDs.json | List | $..PERSON_INFO_PK             | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/person_info_pk.json                   | PERSON_INFO_PK             |
      | Get     | searches/Default/query/queryDiagramOut/Default.Constraint:::DYN?what=id,type,name,catalog |      | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/constraintIDs.json | List | $..FK_PERSON_INFO             | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/fk_person_info.json                   | FK_PERSON_INFO             |
      | Get     | searches/Default/query/queryDiagramOut/Default.Constraint:::DYN?what=id,type,name,catalog |      | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/constraintIDs.json | List | $..ORACLE_SUPPLIER_UNIQUETEST | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/oracle_supplier_uniquetest.json       | ORACLE_SUPPLIER_UNIQUETEST |
      | Get     | searches/Default/query/queryDiagramOut/Default.Index:::DYN?what=id,type,name,catalog      |      | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/indexIDs.json      | List | $..ORACLE_SUPPLIER_UNIQUETEST | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/oracle_supplier_uniquetest_index.json | ORACLE_SUPPLIER_UNIQUETEST |

  Scenario Outline:SC#3_5_user retrieve the name of id for each value stored in lineage data file
    Given user gets the name for each id stored in "<LineageFile>" under "<Name>" and replace the id with name
    Examples:
      | LineageFile                                                                                   | Name                       |
      | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/person_info_pk.json                   | PERSON_INFO_PK             |
      | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/fk_person_info.json                   | FK_PERSON_INFO             |
      | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/oracle_supplier_uniquetest.json       | ORACLE_SUPPLIER_UNIQUETEST |
      | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/oracle_supplier_uniquetest_index.json | ORACLE_SUPPLIER_UNIQUETEST |

  Scenario:SC#3_6_Copy the file and remove the id value
    Given user copy the data from "rest/response/Oracle19cPDB/actualJsonFiles/person_info_pk.json" file to "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/person_info_pk.json" file
    And user copy the data from "rest/response/Oracle19cPDB/actualJsonFiles/fk_person_info.json" file to "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/fk_person_info.json" file
    And user copy the data from "rest/response/Oracle19cPDB/actualJsonFiles/oracle_supplier_uniquetest.json" file to "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/oracle_supplier_uniquetest.json" file
    And user copy the data from "rest/response/Oracle19cPDB/actualJsonFiles/oracle_supplier_uniquetest_index.json" file to "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/oracle_supplier_uniquetest_index.json" file
    And user "update" the json file "ida/jdbcAnalyzerPayloads/Oracle19cPDB/person_info_pk.json" file for following values
      | jsonPath | jsonValues | type   |
      | $..id    |            | String |
    And user "update" the json file "ida/jdbcAnalyzerPayloads/Oracle19cPDB/fk_person_info.json" file for following values
      | jsonPath | jsonValues | type   |
      | $..id    |            | String |
    And user "update" the json file "ida/jdbcAnalyzerPayloads/Oracle19cPDB/oracle_supplier_uniquetest.json" file for following values
      | jsonPath | jsonValues | type   |
      | $..id    |            | String |
    And user "update" the json file "ida/jdbcAnalyzerPayloads/Oracle19cPDB/oracle_supplier_uniquetest_index.json" file for following values
      | jsonPath | jsonValues | type   |
      | $..id    |            | String |
    And user copy the data from "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/person_info_pk.json" file to "rest/response/Oracle19cPDB/actualJsonFiles/person_info_pk.json" file
    And user copy the data from "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/fk_person_info.json" file to "rest/response/Oracle19cPDB/actualJsonFiles/fk_person_info.json" file
    And user copy the data from "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/oracle_supplier_uniquetest.json" file to "rest/response/Oracle19cPDB/actualJsonFiles/oracle_supplier_uniquetest.json" file
    And user copy the data from "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/oracle_supplier_uniquetest_index.json" file to "rest/response/Oracle19cPDB/actualJsonFiles/oracle_supplier_uniquetest_index.json" file

  Scenario Outline:SC#3_7_user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                    | actualJson                                                                                    |
      | Constant.REST_DIR/response/Oracle19cPDB/expectedJsonFiles/person_info_pk.json                   | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/person_info_pk.json                   |
      | Constant.REST_DIR/response/Oracle19cPDB/expectedJsonFiles/fk_person_info.json                   | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/fk_person_info.json                   |
      | Constant.REST_DIR/response/Oracle19cPDB/expectedJsonFiles/oracle_supplier_uniquetest.json       | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/oracle_supplier_uniquetest.json       |
      | Constant.REST_DIR/response/Oracle19cPDB/expectedJsonFiles/oracle_supplier_uniquetest_index.json | Constant.REST_DIR/response/Oracle19cPDB/actualJsonFiles/oracle_supplier_uniquetest_index.json |

#######################################################################################################################

  @webtest
  Scenario:SC#4_1_Verify captions text in OracleDataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute          |
      | Data Source Type | OracleDBDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Data Source Type*     |
      | Name*                 |
      | Label                 |
      | URL*                  |
      | Driver Bundle Name*   |
      | Driver Bundle Version |
      | Driver Name           |
      | Credential*           |
      | Node                  |

  ##6767910##
  @webtest @jdbc @MLP-9602
  Scenario:SC#4_2_Verify captions and tool tip text in OracleDBCataloger
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
      | fieldName | attribute         |
      | Type      | Cataloger         |
      | Plugin    | OracleDBCataloger |
      | Plugin    | OracleDBCataloger |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Type*                |
      | Plugin*              |
      | Name*                |
      | Label                |
      | Business Application |
      | Schema/Table Filters |
      | Data Source*         |
      | Credential*          |

  ##6767930##
  @webtest @jdbc @MLP-9605
  Scenario:SC#4_3_Verify captions and tool tip text in OracleDBAnalyzer
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
      | Type      | Dataanalyzer     |
      | Plugin    | OracleDBAnalyzer |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Type*                |
      | Plugin*              |
      | Name*                |
      | Label                |
      | Business Application |

  ##6767908##
  @jdbc @MLP-9602
  Scenario:SC#4_4_Verify OracleDBCataloger collects all the different columns of a table when table is created with all possible datatypes
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath              | Action                | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename   | columnName/FieldName |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.TIMESTAMP6TZCOLUMN  | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FLOATCOLUMN         | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.BINARYDOUBLECOLUMN  | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYDOUBLECOLUMN   |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.RAWCOLUMN           | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | RAWCOLUMN            |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.UROWIDCOLUMN        | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | UROWIDCOLUMN         |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DATECOLUMN          | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.TIMESTAMPCOLUMN     | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.CLOBCOLUMN          | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CLOBCOLUMN           |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.NVARCHAR2COLUMN     | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.NCHARCOLUMN         | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.CHARCOLUMN          | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.VARCHARCOLUMN       | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHARCOLUMN        |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.VARCHAR2COLUMN      | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.BLOBCOLUMN          | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BLOBCOLUMN           |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.BFILECOLUMN         | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BFILECOLUMN          |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.LONGCOLUMN          | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | LONGCOLUMN           |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.TIMESTAMP6LTZCOLUMN | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ROWIDCOLUMN         | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | ROWIDCOLUMN          |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.BINARYFLOATCOLUMN   | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYFLOATCOLUMN    |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.NUMBERCOLUMN        | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.NCLOBCOLUMN         | metadataValuePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCLOBCOLUMN          |

  ##6767903##
  @webtest @jdbc @MLP-6902 @MLP-9602
  Scenario:SC#5_1_Verify proper error message is shown if mandatory fields are not filled in OracleDBCataloger plugin configuration
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
      | fieldName | attribute         |
      | Type      | Cataloger         |
      | Plugin    | OracleDBCataloger |
      | Plugin    | OracleDBCataloger |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  @webtest @jdbc
  Scenario:SC#5_2_Verify proper error message is shown if mandatory fields are not filled in OracleDBDataSource plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute          |
      | Data Source Type | OracleDBDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName          | attribute |
      | Name               |           |
      | URL                |           |
      | Driver Bundle Name | A         |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName          | errorMessage                                 |
      | Name               | Name field should not be empty               |
      | URL                | URL field should not be empty                |
      | Driver Bundle Name | Driver Bundle Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  ##6767900##
  @webtest @jdbc @MLP-9602
  Scenario:SC#5_3_Verify table name alone cannot be provided without a schema name in Oracle Database cataloger filters.
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
      | fieldName | attribute         |
      | Type      | Cataloger         |
      | Plugin    | OracleDBCataloger |
      | Plugin    | OracleDBCataloger |
    And user clicks on Add button near to field "Schema/Table Filters"
    And user clicks on Add button near to field "Table Filters"
    And user "enter text" in Add Data Source Page
      | fieldName  | attribute |
      | Table Name | QATest    |
    And user performs following actions in the sidebar
      | actionType | actionItem |
      | click      | Add Button |
    And user verifies "Add Button" is "disabled" in "Add Configuration pop up"

  ##7072922##
  @webtest @jdbc @MLP-14019
  Scenario:SC#5_4_Verify proper error message is thrown in UI if Sample Data count/Top Values/Histogram Buckets values are not provided within valid range in OracleDBAnalyzer
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
      | Type      | Dataanalyzer     |
      | Plugin    | OracleDBAnalyzer |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample data count     | 1001                   |
    And user press "TAB" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName         | validationMessage                                          |
      | Sample data count | Value of Sample data count should not be greater than 1000 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample data count     | 9                      |
    And user press "TAB" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName         | validationMessage                                       |
      | Sample data count | Value of Sample data count should not be lesser than 10 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            | 4                      |
    And user press "TAB" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName  | validationMessage                               |
      | Top values | Value of Top values should not be lesser than 5 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            | 31                     |
    And user press "TAB" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName  | validationMessage                                 |
      | Top values | Value of Top values should not be greater than 30 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     | 4                      |
    And user press "TAB" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName         | validationMessage                                      |
      | Histogram buckets | Value of Histogram buckets should not be lesser than 5 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     | 21                     |
    And user press "TAB" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName         | validationMessage                                        |
      | Histogram buckets | Value of Histogram buckets should not be greater than 20 |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  ##6767927##
  @webtest @jdbc @MLP-9605
  Scenario:SC#5_5_Verify proper error message is shown if mandatory fields are not filled in OracleDBAnalyzer plugin configuration
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
      | Type      | Dataanalyzer     |
      | Plugin    | OracleDBAnalyzer |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |

  ##6478515## ##6477895##
  @webtest @jdbc
  Scenario:SC#5_6_Verify Oracle datasource throws error when the jdbc url is for databases other than oracle or incorrect
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute          |
      | Data Source Type | OracleDBDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                              |
      | URL       | jdbc:postgresql://decheqaperf01v.asg.com:5432/postgres |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                                                                                                    |
      | URL       | UnSupported Oracle JDBC URL Format. Sample Format : jdbc:oracle:thin:@<<hostname>>:<<port>>:<<database or sid>> |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                      |
      | URL       | jdbc:test:thin:@gechcae-col1.asg.com:1521:col2 |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                                                                                                    |
      | URL       | UnSupported Oracle JDBC URL Format. Sample Format : jdbc:oracle:thin:@<<hostname>>:<<port>>:<<database or sid>> |

  @sanity @positive @regression
  Scenario:SC#5_7_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                              | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter% | Analysis |       |       |

#  Scenario:SC#6_1_Verify the Dry run feature for the OracleDB Cataloger
#    Given user "update" the json file "ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleCataloger_DryRun.json" file for following values
#      | jsonPath  | jsonValues | type    |
#      | $..dryRun | true       | boolean |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                                              | response code | response message | jsonPath                                                    |
#      | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json       | 204           |                  |                                                             |
#      |                  |       |       | Get          | settings/analyzers/OracleDBDataSource                               |                                                                   | 200           |                  | Oracle19cPDBDS                                              |
#      |                  |       |       | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleCataloger_DryRun.json | 204           |                  |                                                             |
#      |                  |       |       | Get          | settings/analyzers/OracleDBCataloger                                |                                                                   | 200           |                  | OracleCataloger_DryRun                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OracleCataloger_DryRun')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                  | 200           |                  |                                                             |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OracleCataloger_DryRun')].status |
#    And Verify the metadata properties of the item types via api call
#      | widgetName  | filePath                                                        | jsonPath               | Action                | query         | TableName/Filename                                             |
#      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.Analysis_4.Description | metadataValuePresence | AnalysisQuery | cataloger/OracleDBCataloger/OracleCataloger_DryRun |
#      Then Analysis log "cataloger/OracleDBCataloger/OracleCataloger_DryRun%" should display below info/error/warning
#      | type | logValue                                                                                     | logCode       | pluginName        | removableText |
#      | INFO | Plugin OracleDBCataloger running on dry run mode                                             | ANALYSIS-0069 | OracleDBCataloger |               |
#      | INFO | Plugin OracleDBCataloger processed 0 items on dry run mode and not written to the repository | ANALYSIS-0070 | OracleDBCataloger |               |
#      | INFO | Plugin completed                                                                             | ANALYSIS-0020 |                   |               |
#
#  Scenario:SC#6_2_Verify the Dry run feature for the OracleDB Analyzer
#    Given user "update" the json file "ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleCataloger_DryRun.json" file for following values
#      | jsonPath  | jsonValues | type    |
#      | $..dryRun | false      | boolean |
#    Given user "update" the json file "ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleAnalyzer_DryRun.json" file for following values
#      | jsonPath  | jsonValues | type    |
#      | $..dryRun | true       | boolean |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                   | body                                                              | response code | response message | jsonPath                                                    |
#      | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json       | 204           |                  |                                                             |
#      |                  |       |       | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                   | 200           |                  | Oracle19cPDBDS                                              |
#      |                  |       |       | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleCataloger_DryRun.json | 204           |                  |                                                             |
#      |                  |       |       | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                   | 200           |                  | OracleCataloger_DryRun                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OracleCataloger_DryRun')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                  | 200           |                  |                                                             |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OracleCataloger_DryRun')].status |
#      |                  |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleAnalyzer_DryRun.json  | 204           |                  |                                                             |
#      |                  |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                   | 200           |                  | OracleAnalyzer_DryRun                                       |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OracleAnalyzer_DryRun')].status  |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                  | 200           |                  |                                                             |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OracleAnalyzer_DryRun')].status  |
#    And Verify the metadata properties of the item types via api call
#      | widgetName  | filePath                                                        | jsonPath               | Action                | query         | TableName/Filename                                             |
#      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.Analysis_4.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/OracleDBAnalyzer/OracleAnalyzer_DryRun |
#    Then Analysis log "dataanalyzer/OracleDBAnalyzer/OracleAnalyzer_DryRun%" should display below info/error/warning
#      | type | logValue                                                                                    | logCode       | pluginName       | removableText |
#      | INFO | Plugin OracleDBAnalyzer running on dry run mode                                             | ANALYSIS-0069 | OracleDBAnalyzer |               |
#      | INFO | Plugin OracleDBAnalyzer processed 0 items on dry run mode and not written to the repository | ANALYSIS-0070 | OracleDBAnalyzer |               |
#      | INFO | Plugin completed                                                                            | ANALYSIS-0020 |                  |               |
#
#  @sanity @positive @regression
#  Scenario:SC#6_3_Delete Cluster and OracleDBCataloger,OracleDBAnalyzer Analysis file
#    Given Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                                                 | type     | query | param |
#      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                      | Cluster  |       |       |
#      | MultipleIDDelete | Default | cataloger/OracleDBCataloger/OracleCataloger_DryRun%  | Analysis |       |       |
#      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzer_DryRun% | Analysis |       |       |

  ##6477896##
  Scenario Outline:SC#7_1_Run the Plugin configurations for wrong driver bundle name the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                              | response code | response message                   | jsonPath                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                                   | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                                   | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSourceWithWrongBundleName.json                    | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                   | 200           | Oracle19cPDBDSwrongBundleName      |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithWrongBundleName.json | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                   | 200           | OracleCatalogerWithWrongBundleName |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                   | 200           | IDLE                               | $.[?(@.configurationName=='OracleCatalogerWithWrongBundleName')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                  | 200           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                   | 200           | IDLE                               | $.[?(@.configurationName=='OracleCatalogerWithWrongBundleName')].status |

  ##6477896##
  @jdbc
  Scenario:SC#7_2_Verify Oracle cataloger does not collect any DB items and log throws error when the driver bundle name is for databases other than oracle
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath               | Action                | query         | TableName/Filename                                             |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.Analysis.Description | metadataValuePresence | AnalysisQuery | cataloger/OracleDBCataloger/OracleCatalogerWithWrongBundleName |
    Then Analysis log "cataloger/OracleDBCataloger/OracleCatalogerWithWrongBundleName%" should display below info/error/warning
      | type  | logValue                                                          | logCode            | pluginName        | removableText |
      | INFO  | Plugin started                                                    | ANALYSIS-0019      |                   |               |
      | ERROR | No Driver class returned: Bundle org.postgresql.jdbc42 not found? | ANALYSIS-JDBC-0001 | OracleDBCataloger |               |
      | ERROR | No JDBC connection could be established                           | ANALYSIS-JDBC-0003 | OracleDBCataloger |               |

  @sanity @positive @regression
  Scenario:SC#7_3_Delete OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                            | type     | query | param |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithWrongBundleName% | Analysis |       |       |

  Scenario Outline:SC#8_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                              | response code | response message                   | jsonPath                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                                   | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                                   | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSourceWithWrongDriverName.json                    | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                   | 200           | Oracle19cPDBDSwrongDriverName      |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithWrongDriverName.json | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                   | 200           | OracleCatalogerWithWrongDriverName |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                   | 200           | IDLE                               | $.[?(@.configurationName=='OracleCatalogerWithWrongDriverName')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                  | 200           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                   | 200           | IDLE                               | $.[?(@.configurationName=='OracleCatalogerWithWrongDriverName')].status |

  ##6477896##
  @jdbc
  Scenario:SC#8_2_Verify Oracle cataloger does not collect any DB items and log throws error when the driver name is for databases other than oracle
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath               | Action                | query         | TableName/Filename                                             |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.Analysis.Description | metadataValuePresence | AnalysisQuery | cataloger/OracleDBCataloger/OracleCatalogerWithWrongDriverName |
    Then Analysis log "cataloger/OracleDBCataloger/OracleCatalogerWithWrongDriverName%" should display below info/error/warning
      | type  | logValue                                              | logCode            | pluginName        | removableText |
      | INFO  | Plugin started                                        | ANALYSIS-0019      |                   |               |
      | ERROR | Error while loading JDBC Driver org.postgresql.jdbc42 | ANALYSIS-JDBC-0001 | OracleDBCataloger |               |
      | ERROR | No JDBC connection could be established               | ANALYSIS-JDBC-0003 | OracleDBCataloger |               |

  @sanity @positive @regression
  Scenario:SC#8_3_Delete OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                            | type     | query | param |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithWrongDriverName% | Analysis |       |       |

  Scenario Outline:SC#9_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                 | response code | response message                      | jsonPath                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                                      | 204           |                                       |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                                      | 204           |                                       |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSourceWithWrongDriverVersion.json                    | 204           |                                       |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                      | 200           | Oracle19cPDBDSwrongDriverVersion      |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithWrongDriverVersion.json | 204           |                                       |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                      | 200           | OracleCatalogerWithWrongDriverVersion |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                      | 200           | IDLE                                  | $.[?(@.configurationName=='OracleCatalogerWithWrongDriverVersion')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                     | 200           |                                       |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                      | 200           | IDLE                                  | $.[?(@.configurationName=='OracleCatalogerWithWrongDriverVersion')].status |

  ##6477896##
  @jdbc
  Scenario:SC#9_2_Verify Oracle cataloger does not collect any DB items and log throws error when the driver version is for databases other than oracle
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath               | Action                | query         | TableName/Filename                                                |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.Analysis.Description | metadataValuePresence | AnalysisQuery | cataloger/OracleDBCataloger/OracleCatalogerWithWrongDriverVersion |
    Then Analysis log "cataloger/OracleDBCataloger/OracleCatalogerWithWrongDriverVersion%" should display below info/error/warning
      | type  | logValue                                                             | logCode            | pluginName        | removableText |
      | INFO  | Plugin started                                                       | ANALYSIS-0019      |                   |               |
      | ERROR | No Driver class returned: Bundle oracle.jdbc.OracleDriver not found? | ANALYSIS-JDBC-0002 | OracleDBCataloger |               |
      | ERROR | No JDBC connection could be established                              | ANALYSIS-JDBC-0003 | OracleDBCataloger |               |

  @sanity @positive @regression
  Scenario:SC#9_3_Delete OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                               | type     | query | param |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithWrongDriverVersion% | Analysis |       |       |

  Scenario Outline:SC#10_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger in Internal Node
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                    | body                                                                                             | response code | response message              | jsonPath                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                   |                                                                                                  | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                                  |                                                                                                  | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSourceInternalNode.json                          | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                  |                                                                                                  | 200           | Oracle19cPDBDSInternalNode    |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerInternalNodeConfig.json | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                   |                                                                                                  | 200           | OracleCatalogerInInternalNode |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/OracleDBCataloger/* |                                                                                                  | 200           | IDLE                          | $.[?(@.configurationName=='OracleCatalogerInInternalNode')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                 | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/OracleDBCataloger/* |                                                                                                  | 200           | IDLE                          | $.[?(@.configurationName=='OracleCatalogerInInternalNode')].status |

  ##6767906##
  @webtest @jdbc @MLP-9602
  Scenario:SC#10_2_Verify OracleDatabaseCataloger scans and collects data properly if the node condition is given
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Schema    | 7     |

  Scenario Outline:SC#11_1_Run the Plugin configurations for Analyzer for Oracle19CPDB in InternalNode
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                      | body                                                                                            | response code | response message             | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                      | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleAnalyzerInternalNodeConfig.json | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                      |                                                                                                 | 200           | OracleAnalyzerInInternalNode |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                 | 200           | IDLE                         | $.[?(@.configurationName=='OracleAnalyzerInInternalNode')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                 | 200           | IDLE                         | $.[?(@.configurationName=='OracleAnalyzerInInternalNode')].status |

  ##6767928##
  @MLP-9605
  Scenario:SC#11_2_Verify OracleDBAnalyzer scans and collects data properly if the node condition is given
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                | Action                    | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | columnName/FieldName |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FULL_NAME.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | FULL_NAME            |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FULL_NAME.Description | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | FULL_NAME            |

  @sanity @positive @regression
  Scenario:SC#11_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                        | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                             | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerInInternalNode%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerInInternalNode% | Analysis |       |       |

  Scenario Outline:SC#12_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                       | response code | response message            | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                            | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                            | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                            | 200           | Oracle19cPDBDS              |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithNoFilter.json | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                            | 200           | OracleCatalogerWithNoFilter |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                            | 200           | IDLE                        | $.[?(@.configurationName=='OracleCatalogerWithNoFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                           | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                            | 200           | IDLE                        | $.[?(@.configurationName=='OracleCatalogerWithNoFilter')].status |

  @webtest @jdbc
  Scenario:SC#12_2_Verify OracleDB cataloger scans and collects data if schema name and table names are not provided in filters and Log enhancement and the Processed Items are Verified
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType      | count |
      | Synonym        | 6492  |
      | Column         | 872   |
      | UserRole       | 89    |
      | Constraint     | 75    |
      | Index          | 58    |
      | Table          | 182   |
      | User           | 50    |
      | Sequence       | 3     |
      | Routine        | 8     |
      | Partition      | 8     |
      | Schema         | 9     |
      | Tablespace     | 5     |
      | DataField      | 3     |
      | Trigger        | 3     |
      | File           | 4     |
      | IndexExtension | 2     |
      | Cluster        | 1     |
      | Database       | 1     |
      | DatabaseLink   | 2     |
      | DataType       | 1     |
      | Service        | 1     |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value              | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_TAG_DETAILS | verify widget contains | No               |             |
      | Tables | ORACLE_TAG_DETAILS | click and switch tab   | No               |             |
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                 | Action                | query         | TableName/Filename                                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.Analysis_3.Description | metadataValuePresence | AnalysisQuery | cataloger/OracleDBCataloger/OracleCatalogerWithNoFilter |
#    And user enters the search text "OracleDBCataloger" and clicks on search
#    And user performs "facet selection" in "Orc19cPDBCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "cataloger/OracleDBCataloger/OracleCatalogerWithNoFilter%"
#    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
#      | diqscanora01v.diq.qa.asgint.loc |
#      | ORACLE:1522                     |

  ##6767907## ##6204189##
  @webtest @jdbc @MLP-9602 @MLP-6281
  Scenario:SC#12_3_Verify OracleDatabaseCataloger collects DB items like Cluster, Service, Database, Schema,Table, Columns,Constraints,Index,Routine,Views,Triggers when the OracleDatabaseCataloger is run.(No filters)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc19cPDBCataloger" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Cluster   | 1     |
    And user performs "item click" on "diqscanora01v.diq.qa.asgint.loc" item from search results
    And user enters the search text "Orc19cPDBCataloger" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Service   | 1     |
    And user performs "item click" on "ORACLE:1522" item from search results
    And user enters the search text "Orc19cPDBCataloger" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Database  | 1     |
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | OCPPVT               | verify widget contains | No               |             |
      | Tables | OCPPV2T              | verify widget contains | No               |             |
      | Tables | OCPPVIEW             | verify widget contains | No               |             |
      | Tables | ORACLE_TAG_DETAILS   | verify widget contains | No               |             |
      | Tables | ORACLE_DIFFDATATYPES | verify widget contains | No               |             |
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType  | count |
      | Table      | 41    |
      | Constraint | 13    |
    And user enters the search text "ORACLE_DIFFDATATYPES" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE_DIFFDATATYPES [Table]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 21    |
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Index     | 12    |
      | Routine   | 4     |
      | Trigger   | 1     |

  ##6767909##
  @webtest @jdbc @MLP-9602
  Scenario:SC#12_4_Verify the technology tags got assigned to all Oracle DB items like Cluster,Service,Database...etc
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName                                             | TableName/Filename            | Column | Tags                                        | Query                       | Action      |
      | diqscanora01v.diq.qa.asgint.loc |             |                            |                                                        |                               |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | ClusterQuery                | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 |                            |                                                        |                               |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | ServiceQuery                | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC |                                                        |                               |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | DatabaseQuery               | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1                                      |                               |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery                 | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1                                      | ORACLE_TAG_DETAILS            |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | TableQuerywithSchema        | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1                                      | ORACLE_TAG_DETAILS            | STATE  | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | ColumnQuerywithSchema       | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1                                      | ORACLEINDEXTEST               |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | IndexQuerywithSchema        | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | HR                                                     | EMP_SALARY_MIN                |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | ConstraintQuerywithSchema   | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1                                      | PROT2T                        |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | RoutineQueryWithoutCluster  | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1                                      | TRIGGER1                      |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | TriggerQueryWithoutCluster  | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1                                      |                               |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | UserQuery                   | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | AQ_ADMINISTRATOR_ROLE                                  |                               |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | UserRoleQuery               | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | SYSAUX                                                 |                               |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | TablespaceQuery             | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | PUBLIC                                                 | DBA_EVALUATION_CONTEXT_TABLES |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SynonymQuerywithSchema      | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | PUBLIC                                                 | DBMS_CLRDBLINK                |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | DatabaseLinkQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | C:\ORACLE\19\APP\ORADATA\ORCL19C\PDBDB19C\SYSTEM01.DBF |                               |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | OracleFileQuery             | TagAssigned |

  Scenario Outline:SC#13_1_Run the Plugin configurations for Analyzer in Oracle19CPDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                          | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleAnalyzer.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                               | 200           | OracleAnalyzer   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='OracleAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                              | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='OracleAnalyzer')].status |

  ##6767929##
  @webtest @jdbc @MLP-9605
  Scenario:SC#13_2_Verify the Technology tag appears properly for analysis item added by OracleDBAnalyzer
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | Column | Tags                                                                           | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |        | Oracle,Orc19cPDBCataloger,Orc19cPDBAnalyzer,Oracle19C_PDB_AY,Oracle19C_PDB_Cat | TableQuerywithSchema  | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | STATE  | Oracle,Orc19cPDBCataloger,Orc19cPDBAnalyzer,Oracle19C_PDB_AY,Oracle19C_PDB_Cat | ColumnQuerywithSchema | TagAssigned |

  @jdbc @MLP-5358
  Scenario:SC#13_3_verify the Created Table Name in oracleDB which should have the appropriate metadata information in IDC UI and Database
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                  | Action                    | query                | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.TRIGGERTEST.Lifecycle   | metadataAttributePresence | TableQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | TRIGGERTEST        |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.TRIGGERTEST.Description | metadataValuePresence     | TableQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | TRIGGERTEST        |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.TRIGGERTEST.Statistics  | metadataValuePresence     | TableQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | TRIGGERTEST        |

  ##6767920## ##7072924##
  @jdbc @MLP-5358 @MLP-9605
  Scenario:SC#13_4_Verify the Column with datatype varchar in Oracle DB which should have the appropriate metadata information in IDC UI and Database for Table and View
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                         | Action                    | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | columnName/FieldName |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Lifecycle   | metadataAttributePresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Description | metadataValuePresence     | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |                      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FULL_NAME.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | FULL_NAME            |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FULL_NAME.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | FULL_NAME            |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FULL_NAME.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | FULL_NAME            |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPDSVT.Lifecycle             | metadataAttributePresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPDSVT.Description           | metadataValuePresence     | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           |                      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.GRADE.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | GRADE                |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.GRADE.Description              | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | GRADE                |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.GRADE.Statistics               | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | GRADE                |

  ##6767921## ##7072924##
  @jdbc @MLP-5358 @MLP-9605
  Scenario:SC#13_5_Verify the Column with datatype decimal in Oracle DB which should have the appropriate metadata information in IDC UI and Database for TABLE and VIEW
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                         | Action                    | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | columnName/FieldName |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Lifecycle   | metadataAttributePresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Description | metadataValuePresence     | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |                      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_SALARY.Lifecycle      | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_SALARY      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_SALARY.Description    | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_SALARY      |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_SALARY.Statistics     | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_SALARY      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPDSVT.Lifecycle             | metadataAttributePresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPDSVT.Description           | metadataValuePresence     | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           |                      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ROLLNO.Lifecycle               | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | ROLLNO               |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ROLLNO.Description             | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | ROLLNO               |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ROLLNO.Statistics              | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | ROLLNO               |

  ##6767922## ##7072924##
  @jdbc @MLP-5358 @MLP-9605
  Scenario:SC#13_6_Verify the Column with datatype timestamp in Oracle DB which should have the appropriate metadata information in IDC UI and Database for Table and View
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                         | Action                    | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | columnName/FieldName |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Lifecycle   | metadataAttributePresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Description | metadataValuePresence     | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |                      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Description | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Statistics  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW.Lifecycle          | metadataAttributePresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW.Description        | metadataValuePresence     | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        |                      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB.Lifecycle                  | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB                  |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB.Description                | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB                  |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB.Statistics                 | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB                  |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB2.Lifecycle                 | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB2                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB2.Description               | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB2                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB2.Statistics                | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB2                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB3.Lifecycle                 | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB3                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB3.Description               | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB3                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB3.Statistics                | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB3                 |

 ##6767919## ##7072924##
  Scenario Outline:SC#13_7_User get the Dynamic ID's (Schema ID) and table "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name              | asg_scopeid        | targetFile                                                    | jsonpath                       |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | $.Tables_id.ORACLE_TAG_DETAILS |

    ##6767919## ##7072924##
  Scenario Outline:SC#13_7_User hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                      | inputFile                                                     | outPutFile                                                                      | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables_id.ORACLE_TAG_DETAILS | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OracleTagDetails.json |            |

    ##6767919## ##7072924##
  Scenario:SC#13_7_Verify the data sampling for table information in OracleDB
    Then file content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OracleTagDetails.json" should be same as the content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Expected/OracleTagDetails.json"

  ##7072924##
  Scenario Outline:SC#13_8_User get the Dynamic ID's (Schema ID) and table "OCPPVIEW"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name              | asg_scopeid | targetFile                                                    | jsonpath             |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | ORACLE12C_SCHEMA1 | OCPPVIEW    | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | $.Tables_id.OCPPVIEW |

    ##7072924##
  Scenario Outline:SC#13_8_User hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson            | inputFile                                                     | outPutFile                                                              | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables_id.OCPPVIEW | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OCPPVIEW.json |            |

    ##7072924##
  Scenario:SC#13_8_Verify the data sampling for view information in OracleDB
    Then file content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OCPPVIEW.json" should be same as the content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Expected/OCPPVIEW.json"

  ##6191722##
  @webtest @jdbc @MLP-5641
  Scenario:SC#13_9_Verify the count of Schema matched UI and DB
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Schema    | 9     |

  ##6423391##
  @jdbc @MLP-7325
  Scenario:SC#13_10_Verify the data profiling metadata for string,numeric,date,time,timestamp datatypes metrics does not get calculated for empty table(oracle)
    Given Verify the metadata properties of the item types via api call
      | widgetName | filePath                                                        | jsonPath                       | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | columnName/FieldName |
      | Statistics | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_EMPTY_DOB2.Statistics | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_EMPTY       | DOB2                 |
      | Lifecycle  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_EMPTY_DOB2.Lifecycle  | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_EMPTY       | DOB2                 |
      | Statistics | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_EMPTY_ID.Statistics   | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_EMPTY       | ID                   |
      | Lifecycle  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_EMPTY_ID.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_EMPTY       | ID                   |
      | Statistics | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_EMPTY_NAME.Statistics | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_EMPTY       | NAME                 |
      | Lifecycle  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_EMPTY_NAME.Lifecycle  | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_EMPTY       | NAME                 |

  ##6767926##
  @jdbc  @MLP-7325 @MLP-9605
  Scenario:SC#13_11_Verify the data profiling metadata for date,time,timestamp datatypes and should have the appropriate metadata information in IDC UI and Database(oracle)
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                        | Action                    | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | columnName/FieldName |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB.Lifecycle    | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB                  |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB.Description  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB                  |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB.Statistics   | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB                  |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB2.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB2                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB2.Description | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB2                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB2.Statistics  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB2                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB3.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB3                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB3.Description | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB3                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB3.Statistics  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB3                 |

  @sanity @positive @regression
  Scenario:SC#13_12_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                     | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                          | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithNoFilter% | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzer%            | Analysis |       |       |

  Scenario Outline:SC#14_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                           | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                                | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                                | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                    | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                | 200           | Oracle19cPDBDS                  |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithSchemaFilter.json | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                | 200           | OracleCatalogerWithSchemaFilter |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                               | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |

  ##6767896##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#14_2_Verify Oracle cataloger scans and collects data if schema name alone is provided in filters(Oracle DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettablesFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "retainslist" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                    | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getviewsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "retainslist" value with Postgres DB
    And user "widget presence" on "Constraints" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                        | jsonPath                         | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Description | Description     |
      | Tables | OCPPVIEW           | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPVIEW                       | Description     |
    And user enters the search text "HR" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
#    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section presence" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section presence" on "Description" in Item view page

  @sanity @positive @regression
  Scenario:SC#14_3_Delete Cluster and OracleDBCataloger  Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                              | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter% | Analysis |       |       |

  Scenario Outline:SC#15_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                   | response code | response message                        | jsonPath                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                                        | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                                        | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                            | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                        | 200           | Oracle19cPDBDS                          |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithSchemaAndTableFilter.json | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                        | 200           | OracleCatalogerWithSchemaAndTableFilter |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                       | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |

  ##6767897##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#15_2_Verify Oracle cataloger scans and collects data if schema name and table name is provided in filters(Oracle DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user "widget presence" on "Constraints" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                        | jsonPath                         | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Description | Description     |
      | Tables | OCPPVIEW           | click and switch tab      | Yes              | 0           |                                                                 |                                  |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value         | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | TABLE_PRIMARY | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "HR" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section presence" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section presence" on "Description" in Item view page

  @sanity @positive @regression
  Scenario:SC#15_3_Delete Cluster and OracleDBCataloger  Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter% | Analysis |       |       |

  Scenario Outline:SC#16_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                             | response code | response message                                  | jsonPath                                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                                                  | 204           |                                                   |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                                                  | 204           |                                                   |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                                      | 204           |                                                   |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                                  | 200           | Oracle19cPDBDS                                    |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithMultipleSchemaFilterWithTables.json | 204           |                                                   |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                                  | 200           | OracleCatalogerWithMultipleSchemaFilterWithTables |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                  | 200           | IDLE                                              | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemaFilterWithTables')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                                 | 200           |                                                   |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                  | 200           | IDLE                                              | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemaFilterWithTables')].status |

  ##6767901##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#16_2_Verify Oracle cataloger scans and collects data if multiple schema names having tables in it are provided in filters(Oracle DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user "widget presence" on "Tables" in Item view page
    Then user performs click and verify in new window
      | Table       | value      | Action                 | RetainPrevwindow | indexSwitch |
      | Constraints | PRIMARY_PK | verify widget contains | No               |             |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                        | jsonPath                         | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Description | Description     |
      | Tables | TABLE_PRIMARY      | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.TABLE_PRIMARY                  | Description     |
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value              | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | ORACLE_PERSON_INFO | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | PERSON_ID | click and switch tab | No               |             |          |          |                 |
    And user enters the search text "ORACLE12C_SCHEMA2" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA2" item from search results
    Then user performs click and verify in new window
      | Table   | value       | Action                    | RetainPrevwindow | indexSwitch | filePath                                                        | jsonPath    | metadataSection |
      | Tables  | BASELINES   | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.BASELINES | Description     |
      | Tables  | BASELINES   | click and switch tab      | No               | 0           |                                                                 |             |                 |
      | Columns | EMPLOYEE_ID | verify widget contains    | Yes              |             |                                                                 |             |                 |
    And user enters the search text "HR" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section presence" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section presence" on "Description" in Item view page

  @sanity @positive @regression
  Scenario:SC#16_3_Delete Cluster and OracleDBCataloger  Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                           | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                                | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemaFilterWithTables% | Analysis |       |       |

  Scenario Outline:SC#17_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                           | response code | response message                                | jsonPath                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                                                | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                                                | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                                    | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                                | 200           | Oracle19cPDBDS                                  |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerwithSchemaAndMultipleTableFilter.json | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                                | 200           | OracleCatalogerwithSchemaAndMultipleTableFilter |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                | 200           | IDLE                                            | $.[?(@.configurationName=='OracleCatalogerwithSchemaAndMultipleTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                               | 200           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                | 200           | IDLE                                            | $.[?(@.configurationName=='OracleCatalogerwithSchemaAndMultipleTableFilter')].status |

  ##6767899##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#17_2_Verify Oracle cataloger scans and collects data if single schema name with multiple table names are provided in filters(Oracle DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user "widget presence" on "Tables" in Item view page
    Then user performs click and verify in new window
      | Table       | value      | Action                 | RetainPrevwindow | indexSwitch |
      | Constraints | PRIMARY_PK | verify widget contains | No               |             |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                        | jsonPath                         | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Description | Description     |
      | Tables | TABLE_PRIMARY      | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.TABLE_PRIMARY                  | Description     |
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value              | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | ORACLE_PERSON_INFO | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | PERSON_ID | click and switch tab | No               |             |          |          |                 |
    And user enters the search text "HR" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section presence" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section presence" on "Description" in Item view page

  @sanity @positive @regression
  Scenario:SC#17_3_Delete Cluster and OracleDBCataloger  Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                         | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                              | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerwithSchemaAndMultipleTableFilter% | Analysis |       |       |

  Scenario Outline:SC#18_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                      | response code | response message                           | jsonPath                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                                           | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                                           | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                               | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                           | 200           | Oracle19cPDBDS                             |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithMultipleSchemasInFilter.json | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                           | 200           | OracleCatalogerWithMultipleSchemasInFilter |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                          | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status |

  ##6767898## ##6204182##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#18_2_Verify Oracle cataloger scans and collects data if multiple schema name alone is provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettablesFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "retainslist" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                    | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getviewsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "retainslist" value with Postgres DB
    And user "widget presence" on "Constraints" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getroutinesFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Routine" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                        | jsonPath                         | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Description | Description     |
      | Tables | OCPPVIEW           | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPVIEW                       | Description     |
    And user enters the search text "ORACLE12C_SCHEMA2" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA2" item from search results
    And user "widget presence" on "Tables" in Item view page
    Then user performs click and verify in new window
      | Table   | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                        | jsonPath                         | metadataSection |
      | Tables  | BASELINES          | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.BASELINES                      | Description     |
      | Tables  | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Description | Description     |
      | Tables  | BASELINES          | click and switch tab      | No               |             |                                                                 |                                  |                 |
      | Columns | EMPLOYEE_ID        | click and switch tab      | No               |             |                                                                 |                                  |                 |
    And user enters the search text "HR" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section presence" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section presence" on "Description" in Item view page

  @sanity @positive @regression
  Scenario:SC#18_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                    | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                         | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter% | Analysis |       |       |

  Scenario Outline:SC#19_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                              | response code | response message                                   | jsonPath                                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                                                   | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                                                   | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                                       | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                                   | 200           | Oracle19cPDBDS                                     |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerwithNonExistingSchemaAndTableFilter.json | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                                   | 200           | OracleCatalogerwithNonExistingSchemaAndTableFilter |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerwithNonExistingSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                                  | 200           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerwithNonExistingSchemaAndTableFilter')].status |

  ##6767902## ##6204212##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#19_2_Verify Oracle cataloger scans and collects data if non existing schema name and table name are provided in filters(Oracle DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table   | value              | Action                 | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | ORACLE_PERSON_INFO | click and switch tab   | Yes              |             |          |          |                 |
      | Columns | PERSON_ID          | verify widget contains |                  |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user navigates to the index "0" to perform actions
    And user "widget presence" on "Tables" in Item view page
    And user "widget presence" on "Constraints" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getroutinesFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Routine" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | OCPPVIEW | click and switch tab | Yes              |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table   | value                    | Action                 | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | ORACLE_DIFFDATATYPES     | click and switch tab   | No               |             |          |          |                 |
      | Columns | BLOBCOLUMN               | verify widget contains |                  |             |          |          |                 |
      | Columns | CLOBCOLUMN               | verify widget contains |                  |             |          |          |                 |
      | Columns | NCLOBCOLUMN              | verify widget contains |                  |             |          |          |                 |
      | index   | SYS_IL0000076336C00015$$ | verify widget contains |                  |             |          |          |                 |
      | index   | SYS_IL0000076336C00016$$ | verify widget contains |                  |             |          |          |                 |
      | index   | SYS_IL0000076336C00017$$ | verify widget contains |                  |             |          |          |                 |
    And user enters the search text "HR" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section presence" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section presence" on "Description" in Item view page

  @sanity @positive @regression
  Scenario:SC#19_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerwithNonExistingSchemaAndTableFilter% | Analysis |       |       |

  Scenario Outline:SC#20_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                   | response code | response message                        | jsonPath                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                                        | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                                        | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                            | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                        | 200           | Oracle19cPDBDS                          |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithIncorrectCredentials.json | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                        | 200           | OracleCatalogerWithIncorrectCredentials |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithIncorrectCredentials')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                       | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithIncorrectCredentials')].status |

  ##6767905##
  @jdbc @MLP-6942 @MLP-9602
  Scenario:SC#20_2_Verify the error message when Configuration credentials are incorrect
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                 | Action                | query         | TableName/Filename                                                  |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.Analysis_2.Description | metadataValuePresence | AnalysisQuery | cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectCredentials |
    Then Analysis log "cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectCredentials%" should display below info/error/warning
      | type  | logValue                                                                                                                                                                                                                                                                   | logCode            | pluginName        | removableText |
      | INFO  | Plugin started                                                                                                                                                                                                                                                             | ANALYSIS-0019      |                   |               |
      | ERROR | Plugin OracleDBCataloger reported failure: {"errors":[{"timestamp":"2021-03-31 06:38:11.114","message":"ANALYSIS-ORACLEDB-0008: OracleDB datasource failed : ANALYSIS-JDBC-0038: Invalid credential configuration name: Oracle19cPDBInvalidCredentials","cleared":false}]} | ANALYSIS-JDBC-0067 | OracleDBCataloger |               |
      | ERROR | No JDBC connection could be established                                                                                                                                                                                                                                    | ANALYSIS-JDBC-0003 | OracleDBCataloger |               |

  @sanity @positive @regression
  Scenario:SC#20_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectCredentials% | Analysis |       |       |

  Scenario Outline:SC#21_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                  | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                       | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                       | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSourceWithWrongDBinURL.json           | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                       | 200           | Oracle19cPDBDSwrongDB  |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWrongDB.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                       | 200           | OracleCatalogerWrongDB |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='OracleCatalogerWrongDB')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='OracleCatalogerWrongDB')].status |

  ##6767904##
  @jdbc @MLP-9602
  Scenario:SC#21_2_Verify OracleDatabaseCataloger does not scans and collects and any data if database passed in URL is incorrect
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                 | Action                | query         | TableName/Filename                                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.Analysis_2.Description | metadataValuePresence | AnalysisQuery | cataloger/OracleDBCataloger/OracleCatalogerWrongDB |
    Then Analysis log "cataloger/OracleDBCataloger/OracleCatalogerWrongDB%" should display below info/error/warning
      | type  | logValue                                                                                                                                                                                                                                                                                               | logCode            | pluginName        | removableText |
      | INFO  | Plugin started                                                                                                                                                                                                                                                                                         | ANALYSIS-0019      |                   |               |
      | ERROR | Plugin OracleDBCataloger reported failure: {"errors":[{"timestamp":"","message":"ANALYSIS-ORACLEDB-0008: OracleDB datasource failed : Listener refused the connection with the following error: ORA-12505, TNS:listener does not currently know of SID given in connect descriptor","cleared":false}]} | ANALYSIS-JDBC-0067 | OracleDBCataloger |               |
      | ERROR | No JDBC connection could be established                                                                                                                                                                                                                                                                | ANALYSIS-JDBC-0003 | OracleDBCataloger |               |

  @sanity @positive @regression
  Scenario:SC#21_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                | type     | query | param |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWrongDB% | Analysis |       |       |

  Scenario Outline:SC#22_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                    | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                         | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                         | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSourceWrongHost.json                    | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                         | 200           | Oracle19cPDBDSwrongHost  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWrongHost.json | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                         | 200           | OracleCatalogerWrongHost |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='OracleCatalogerWrongHost')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                        | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='OracleCatalogerWrongHost')].status |

  @jdbc @MLP-6948
  Scenario:SC#22_2_Verify the error message when Configuration url is incorrect
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                 | Action                | query         | TableName/Filename                                   |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.Analysis_2.Description | metadataValuePresence | AnalysisQuery | cataloger/OracleDBCataloger/OracleCatalogerWrongHost |
    Then Analysis log "cataloger/OracleDBCataloger/OracleCatalogerWrongHost%" should display below info/error/warning
      | type  | logValue                                                                                                                                                                                                                   | logCode            | pluginName        | removableText |
      | INFO  | Plugin started                                                                                                                                                                                                             | ANALYSIS-0019      |                   |               |
      | ERROR | Plugin OracleDBCataloger reported failure: {"errors":[{"timestamp":"","message":"ANALYSIS-ORACLEDB-0008: OracleDB datasource failed : IO Error: The Network Adapter could not establish the connection","cleared":false}]} | ANALYSIS-JDBC-0067 | OracleDBCataloger |               |
      | ERROR | No JDBC connection could be established                                                                                                                                                                                    | ANALYSIS-JDBC-0003 | OracleDBCataloger |               |

  @sanity @positive @regression
  Scenario:SC#22_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWrongHost% | Analysis |       |       |

  Scenario Outline:SC#23_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                   | response code | response message                        | jsonPath                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                  |                                                                                                        | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                                 |                                                                                                        | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                            | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                        | 200           | Oracle19cPDBDS                          |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithSchemaAndTableFilter.json | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                        | 200           | OracleCatalogerWithSchemaAndTableFilter |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                       | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleAnalyzerWithMinSampleDataCount.json    | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                        | 200           | OracleAnalyzerWithMinSampleDataCount    |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzerWithMinSampleDataCount')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                       | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzerWithMinSampleDataCount')].status    |

 ##6767931##
  Scenario Outline:SC#23_2_User get the Dynamic ID's (Schema ID) and table "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name              | asg_scopeid        | targetFile                                                    | jsonpath                       |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | $.Tables_id.ORACLE_TAG_DETAILS |

   ##6767931##
  Scenario Outline:SC#23_2_User hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                      | inputFile                                                     | outPutFile                                                                             | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables_id.ORACLE_TAG_DETAILS | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OracleTagDetails_Filter.json |            |

    ##6767931##
  Scenario:SC#23_2_Verify OracleDbAnalyzer does data sampling when sampling count is varied.
    Then file content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OracleTagDetails_Filter.json" should be same as the content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Expected/OracleTagDetails_Filter.json"

  ##6767933##
  Scenario:SC#23_3_Verify OracleDbAnalyzer does data sampling,data profiling and pattern matching properly when analyzer is run on the cataloged item which has filters.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                         | Action                    | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | columnName/FieldName |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Lifecycle   | metadataAttributePresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Description | metadataValuePresence     | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |                      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Description | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Statistics  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.EMAIL.Lifecycle                | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | EMAIL                |

  @sanity @positive @regression
  Scenario:SC#23_4_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter% | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMinSampleDataCount%  | Analysis |       |       |

  @jdbc
  Scenario Outline:SC#24_1_Run the OracleDB Cataloger and Oracle Analyzer with Schema Filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                      | response code | response message                           | jsonPath                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                  |                                                                                                           | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                                 |                                                                                                           | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                               | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                           | 200           | Oracle19cPDBDS                             |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithMultipleSchemasInFilter.json | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                           | 200           | OracleCatalogerWithMultipleSchemasInFilter |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                          | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleAnalyzerWithSchemaFilter.json             | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                           | 200           | OracleAnalyzerWithSchemaFilter             |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleAnalyzerWithSchemaFilter')].status             |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                          | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleAnalyzerWithSchemaFilter')].status             |

  ##7072909## ##7072910##
  @webtest
  Scenario:SC#24_1_Verify Datasampling for Table and View after running the Oracle Analyzer with SchemaFilter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PDBDB19C.DIQ.QA.ASGINT.LOC" item from search results
    Then user performs click and verify in new window
      | Table   | value             | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA2 | click and switch tab | No               |             |
      | Tables  | BASELINES         | click and switch tab | Yes              |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_VIEW2 | click and switch tab | No               |             |
    And user "widget not present" on "dataSamples" in Item view page

    ##7072909## ##7072910##
  Scenario Outline:SC#24_2_User get the Dynamic ID's (Schema ID) and table "ORACLE_TAG_DETAILS" & "OCPPVIEW"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name              | asg_scopeid        | targetFile                                                    | jsonpath                       |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | $.Tables_id.ORACLE_TAG_DETAILS |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | ORACLE12C_SCHEMA1 | OCPPVIEW           | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | $.Tables_id.OCPPVIEW           |

    ##7072909## ##7072910##
  Scenario Outline:SC#24_2_User hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                      | inputFile                                                     | outPutFile                                                                      | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables_id.ORACLE_TAG_DETAILS | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OracleTagDetails.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables_id.OCPPVIEW           | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OCPPVIEW.json         |            |

    ##7072909## ##7072910##
  Scenario:SC#24_2_Verify the data sampling information for Oracle DB table
    Then file content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OracleTagDetails.json" should be same as the content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Expected/OracleTagDetails.json"
    Then file content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OCPPVIEW.json" should be same as the content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Expected/OCPPVIEW.json"

  ##7072911## ##7072912##
  Scenario:SC#24_3_Verify data profiling (decimal, varchar and TimeStamp) for Table and View after running the Oracle Analyzer with SchemaFilter
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                         | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | columnName/FieldName |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Lifecycle   | metadataAttributePresence    | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Description | metadataValuePresence        | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |                      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FULL_NAME.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | FULL_NAME            |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FULL_NAME.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | FULL_NAME            |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FULL_NAME.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | FULL_NAME            |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_SALARY.Lifecycle      | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_SALARY      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_SALARY.Description    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_SALARY      |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_SALARY.Statistics     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_SALARY      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB.Lifecycle     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB                  |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB                  |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB.Statistics    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB                  |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB2.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB2                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB2.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB2                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB2.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB2                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB3.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB3                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB3.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB3                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB3.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB3                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPDSVT.Lifecycle             | metadataAttributePresence    | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPDSVT.Description           | metadataValuePresence        | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           |                      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.GRADE.Lifecycle                | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | GRADE                |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.GRADE.Description              | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | GRADE                |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.GRADE.Statistics               | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | GRADE                |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ROLLNO.Lifecycle               | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | ROLLNO               |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ROLLNO.Description             | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | ROLLNO               |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ROLLNO.Statistics              | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | ROLLNO               |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW.Lifecycle          | metadataAttributePresence    | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW.Description        | metadataValuePresence        | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        |                      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB.Lifecycle                  | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB                  |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB.Description                | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB                  |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB.Statistics                 | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB                  |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB2.Lifecycle                 | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB2                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB2.Description               | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB2                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB2.Statistics                | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB2                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB3.Lifecycle                 | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB3                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB3.Description               | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB3                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.DOB3.Statistics                | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB3                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.BASELINES_EMAIL.Statistics     | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | BASELINES          | EMAIL                |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.BASELINES_EMAIL.Lifecycle      | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | BASELINES          | EMAIL                |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2__DOB.Statistics   | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | DOB                  |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2__DOB.Lifecycle    | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | DOB                  |

  @sanity @positive @regression
  Scenario:SC#24_4_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                    | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                         | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter% | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithSchemaFilter%           | Analysis |       |       |

  @jdbc
  Scenario Outline:SC#25_1_Run the OracleDB Cataloger and Oracle Analyzer with Schema and Table Filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                  | response code | response message                       | jsonPath                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                  |                                                                                                       | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                                 |                                                                                                       | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                           | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                       | 200           | Oracle19cPDBDS                         |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithSchemaFilter.json        | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                       | 200           | OracleCatalogerWithSchemaFilter        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                       | 200           | IDLE                                   | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                      | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                       | 200           | IDLE                                   | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleAnalyzerWithSchemaAndTableFilter.json | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                       | 200           | OracleAnalyzerWithSchemaAndTableFilter |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                       | 200           | IDLE                                   | $.[?(@.configurationName=='OracleAnalyzerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                      | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                       | 200           | IDLE                                   | $.[?(@.configurationName=='OracleAnalyzerWithSchemaAndTableFilter')].status |

  ##7072917##
  Scenario:SC#25_2_Verify data sampling and data profiling (Varchar, Decimal and TimeStamp) for a Table when OracleDBAnalyzer run with Schema and Table Filter
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                           | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | columnName/FieldName |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Lifecycle     | metadataAttributePresence    | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Description   | metadataValuePresence        | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |                      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FULL_NAME.Lifecycle              | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | FULL_NAME            |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FULL_NAME.Description            | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | FULL_NAME            |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FULL_NAME.Statistics             | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | FULL_NAME            |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_SALARY.Lifecycle        | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_SALARY      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_SALARY.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_SALARY      |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_SALARY.Statistics       | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_SALARY      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Lifecycle     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Statistics    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB                  |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB                  |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB                  |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB2.Lifecycle      | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB2                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB2.Description    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB2                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB2.Statistics     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB2                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB3.Lifecycle      | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB3                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB3.Description    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB3                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB3.Statistics     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB3                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.TRIGGERTEST_IDADDRESS.Statistics | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | TRIGGERTEST        | IDADDRESS            |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.TRIGGERTEST_IDADDRESS.Lifecycle  | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | TRIGGERTEST        | IDADDRESS            |

    ##7072917##
  Scenario Outline:SC#25_2_User get the Dynamic ID's (Schema ID) and table "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name              | asg_scopeid        | targetFile                                                    | jsonpath                       |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | $.Tables_id.ORACLE_TAG_DETAILS |

    ##7072917##
  Scenario Outline:SC#25_2_User hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                      | inputFile                                                     | outPutFile                                                                      | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables_id.ORACLE_TAG_DETAILS | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OracleTagDetails.json |            |

    ##7072917##
  Scenario:SC#25_2_Verify the data sampling information for Oracle DB table
    Then file content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OracleTagDetails.json" should be same as the content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Expected/OracleTagDetails.json"

  ##7072919##
  Scenario:SC#25_3_Verify data sampling and data profiling (Varchar, Decimal and TimeStamp) for a View when OracleDBAnalyzer run with Schema and Table Filter
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                       | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | columnName/FieldName |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPVIEW_GRADE.Lifecycle     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPVIEW           | GRADE                |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPVIEW_GRADE.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPVIEW           | GRADE                |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPVIEW_GRADE.Statistics    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPVIEW           | GRADE                |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPVIEW_ROLLNO.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPVIEW           | ROLLNO               |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPVIEW_ROLLNO.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPVIEW           | ROLLNO               |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPVIEW_ROLLNO.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPVIEW           | ROLLNO               |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB                  |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB                  |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB                  |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB2.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB2                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB2.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB2                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB2.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB2                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB3.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB3                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB3.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB3                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB3.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB3                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPDSVT_GRADE.Statistics    | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | GRADE                |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPDSVT_GRADE.Lifecycle     | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | GRADE                |

    ##7072919##
  Scenario Outline:SC#25_3_User get the Dynamic ID's (Schema ID) and table "OCPPVIEW"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name              | asg_scopeid | targetFile                                                    | jsonpath             |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | ORACLE12C_SCHEMA1 | OCPPVIEW    | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | $.Tables_id.OCPPVIEW |

    ##7072919##
  Scenario Outline:SC#25_3_User hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson            | inputFile                                                     | outPutFile                                                              | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables_id.OCPPVIEW | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OCPPVIEW.json |            |

   ##7072919##
  Scenario:SC#25_3_Verify the data sampling information for Oracle DB table
    Then file content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OCPPVIEW.json" should be same as the content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Expected/OCPPVIEW.json"

  @sanity @positive @regression
  Scenario:SC#25_4_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                  | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                       | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter%          | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithSchemaAndTableFilter% | Analysis |       |       |

  @jdbc
  Scenario Outline:SC#26_1_Run the OracleDB Cataloger and Oracle Analyzer with Multiple Schema and Table Filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                          | response code | response message                               | jsonPath                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                  |                                                                                                               | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                                 |                                                                                                               | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                                   | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                               | 200           | Oracle19cPDBDS                                 |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithMultipleSchemasInFilter.json     | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                               | 200           | OracleCatalogerWithMultipleSchemasInFilter     |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                              | 200           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleAnalyzerWithMultipleSchemaAndTableFilter.json | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                               | 200           | OracleAnalyzerWithMultipleSchemaAndTableFilter |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleAnalyzerWithMultipleSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                              | 200           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleAnalyzerWithMultipleSchemaAndTableFilter')].status |

  ##7072918##
  Scenario:SC#26_2_Verify data sampling and data profiling (Varchar, Decimal and TimeStamp) for a Table when OracleDBAnalyzer run with Multiple Schema and Table Filter
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                           | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | columnName/FieldName |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Lifecycle     | metadataAttributePresence    | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TAG_DETAILS.Description   | metadataValuePresence        | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS |                      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FULL_NAME.Lifecycle              | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | FULL_NAME            |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FULL_NAME.Description            | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | FULL_NAME            |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.FULL_NAME.Statistics             | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | FULL_NAME            |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_SALARY.Lifecycle        | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_SALARY      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_SALARY.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_SALARY      |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_SALARY.Statistics       | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_SALARY      |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Lifecycle     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLEDB_LOCALTIME.Statistics    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | ORACLEDB_LOCALTIME   |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB                  |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB                  |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB                  |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB2.Lifecycle      | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB2                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB2.Description    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB2                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB2.Statistics     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB2                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB3.Lifecycle      | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB3                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB3.Description    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB3                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_DOB3.Statistics     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | DOB3                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_DOB.Lifecycle      | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | DOB                  |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_DOB.Description    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | DOB                  |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_DOB.Statistics     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | DOB                  |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_DOB2.Lifecycle     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | DOB2                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_DOB2.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | DOB2                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_DOB2.Statistics    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | DOB2                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_DOB3.Lifecycle     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | DOB3                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_DOB3.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | DOB3                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_DOB3.Statistics    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | DOB3                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_NAME.Lifecycle     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | NAME                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_NAME.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | NAME                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_NAME.Statistics    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | NAME                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_ID.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | ID                   |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_ID.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | ID                   |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE2_ID.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_TABLE2      | ID                   |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.TRIGGERTEST_IDADDRESS.Statistics | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | TRIGGERTEST        | IDADDRESS            |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.TRIGGERTEST_IDADDRESS.Lifecycle  | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | TRIGGERTEST        | IDADDRESS            |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.BASELINES_GENDER.Statistics      | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | BASELINES          | GENDER               |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.BASELINES_GENDER.Lifecycle       | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | BASELINES          | GENDER               |

    ##7072918##
  Scenario Outline:SC#26_2_User get the Dynamic ID's (Schema ID) and table "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name              | asg_scopeid        | targetFile                                                    | jsonpath                       |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | $.Tables_id.ORACLE_TAG_DETAILS |

   ##7072918##
  Scenario Outline:SC#26_2_User hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                      | inputFile                                                     | outPutFile                                                                      | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables_id.ORACLE_TAG_DETAILS | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OracleTagDetails.json |            |

   ##7072918##
  Scenario:SC#26_2_Verify the data sampling for table information in OracleDB
    Then file content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OracleTagDetails.json" should be same as the content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Expected/OracleTagDetails.json"

  ##7072920##
  Scenario:SC#26_3_Verify data sampling and data profiling (Varchar, Decimal and TimeStamp) for a View when OracleDBAnalyzer run with Multiple Schema and Table Filter
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                        | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | columnName/FieldName |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB.Lifecycle     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB                  |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB                  |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB.Statistics    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB                  |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB2.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB2                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB2.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB2                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB2.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB2                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB3.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB3                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB3.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB3                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_DOB3.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | DOB3                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_NAME.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | NAME                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_NAME.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | NAME                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_NAME.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | NAME                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_ID.Lifecycle      | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | ID                   |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_ID.Description    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | ID                   |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW_ID.Statistics     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | ID                   |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_DOB.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | DOB                  |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_DOB.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | DOB                  |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_DOB.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | DOB                  |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_DOB2.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | DOB2                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_DOB2.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | DOB2                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_DOB2.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | DOB2                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_DOB3.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | DOB3                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_DOB3.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | DOB3                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_DOB3.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | DOB3                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_NAME.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | NAME                 |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_NAME.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | NAME                 |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_NAME.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | NAME                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_ID.Lifecycle     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | ID                   |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_ID.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | ID                   |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW2_ID.Statistics    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW2       | ID                   |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPDSVT_GRADE.Statistics     | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | GRADE                |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.OCPPDSVT_GRADE.Lifecycle      | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | OCPPDSVT           | GRADE                |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW3_EMAIL.Statistics | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW3       | EMAIL                |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW3_EMAIL.Lifecycle  | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_VIEW3       | EMAIL                |

     ##7072920##
  Scenario Outline:SC#26_3_User get the Dynamic ID's (Schema ID) and table "OCPPVIEW" & "ORACLE_VIEW2"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type   | name              | asg_scopeid  | targetFile                                                    | jsonpath                 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | ORACLE12C_SCHEMA1 | OCPPVIEW     | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | $.Tables_id.OCPPVIEW     |
      | APPDBPOSTGRES | AsgScope_ID | Default | Schema | ORACLE12C_SCHEMA2 | ORACLE_VIEW2 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | $.Tables_id.ORACLE_VIEW2 |

    ##7072920##
  Scenario Outline:SC#26_3_User hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                | inputFile                                                     | outPutFile                                                                  | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables_id.OCPPVIEW     | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OCPPVIEW.json     |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables_id.ORACLE_VIEW2 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/items.json | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/ORACLE_VIEW2.json |            |

   ##7072920##
  Scenario:SC#26_3_Verify the data sampling information for Oracle DB table
    Then file content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/OCPPVIEW.json" should be same as the content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Expected/OCPPVIEW.json"
    Then file content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Actual/ORACLE_VIEW2.json" should be same as the content in "ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/Expected/ORACLE_VIEW2.json"

  @positive
  Scenario:SC#26_4_Verify the Logging enhancement in OracleDB Cataloger and Analyzer
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                 | Action                | query         | TableName/Filename                                                           |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.Analysis_3.Description | metadataValuePresence | AnalysisQuery | cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter       |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.Analysis_3.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMultipleSchemaAndTableFilter |
    Then Analysis log "cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | logCode       | pluginName        | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0019 |                   |                |
      | INFO | Plugin Name:OracleDBCataloger, Plugin Type:cataloger, Plugin Version:1.2.0.SNAPSHOT, Node Name:LocalNode, Host Name:68c15896fdc7, Plugin Configuration name:OracleCatalogerWithMultipleSchemasInFilter                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0071 | OracleDBCataloger | Plugin Version |
      | INFO | Plugin OracleDBCataloger Configuration: --- 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: name: "OracleCatalogerWithMultipleSchemasInFilter" 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: pluginVersion: "LATEST" 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: label: 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: : "" 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: catalogName: "Default" 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: eventClass: null 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: eventCondition: null 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: nodeCondition: "name==\"LocalNode\"" 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: maxWorkSize: 100 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: tags: 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: - "Orc19cPDBCataloger" 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: pluginType: "cataloger" 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: dataSource: "Oracle19cPDBDS" 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: credential: "Oracle19cPDBCredentials" 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: businessApplicationName: null 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: schedule: null 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: filter: null 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: dryRun: false 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: pluginName: "OracleDBCataloger" 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: schemas: 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: - schema: "ORACLE12C_SCHEMA1" 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: tables: [] 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: - schema: "ORACLE12C_SCHEMA2" 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: tables: [] 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: arguments: [] 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: type: "Cataloger" 2020-11-22 14:44:59.941 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: properties: [] | ANALYSIS-0073 | OracleDBCataloger |                |
      | INFO | Plugin OracleDBCataloger Start Time:2020-07-01 14:01:50.228, End Time:2020-07-01 14:02:25.089, Processed Count:2, Errors:0, Warnings:1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0072 | OracleDBCataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:38.361)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0020 |                   |                |
    Then Analysis log "dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMultipleSchemaAndTableFilter%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | logCode       | pluginName       | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0019 |                  |                |
      | INFO | Plugin Name:OracleDBAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.2.0.SNAPSHOT, Node Name:LocalNode, Host Name:68c15896fdc7, Plugin Configuration name:OracleAnalyzerWithMultipleSchemaAndTableFilter                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0071 | OracleDBAnalyzer | Plugin Version |
      | INFO | Plugin OracleDBAnalyzer Configuration: --- 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: name: "OracleAnalyzerWithMultipleSchemaAndTableFilter" 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginVersion: "LATEST" 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: label: 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: : "" 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: catalogName: "Default" 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: eventClass: null 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: eventCondition: null 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: nodeCondition: "name==\"LocalNode\"" 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: maxWorkSize: 100 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: tags: 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - "Orc19cPDBAnalyzer" 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginType: "dataanalyzer" 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: dataSource: null 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: credential: null 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: businessApplicationName: null 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: schedule: null 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: filter: null 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: histogramBuckets: 100 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: database: "PDBDB19C.DIQ.QA.ASGINT.LOC" 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: dryRun: false 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginName: "OracleDBAnalyzer" 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: sampleDataCount: 25 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: schemas: 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - schema: "ORACLE12C_SCHEMA1" 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: tables: 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_TAG_DETAILS" 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_TABLE" 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "OCPPVIEW" 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_VIEW" 2020-11-22 14:46:04.687 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - schema: "ORACLE12C_SCHEMA2" 2020-11-22 14:46:04.688 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: tables: 2020-11-22 14:46:04.688 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_TABLE2" 2020-11-22 14:46:04.688 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_VIEW2" 2020-11-22 14:46:04.688 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: type: "Dataanalyzer" 2020-11-22 14:46:04.688 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: topValues: 10 | ANALYSIS-0073 | OracleDBAnalyzer |                |
      | INFO | Plugin OracleDBAnalyzer Start Time:2020-07-01 14:03:00.202, End Time:2020-07-01 14:03:01.572, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0072 | OracleDBAnalyzer |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:00.264)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0020 |                  |                |

  @sanity @positive @regression
  Scenario:SC#26_5_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                          | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                               | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter%       | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMultipleSchemaAndTableFilter% | Analysis |       |       |

  ##7072921##
  @jdbc
  Scenario Outline:SC#27_1_Run the OracleDB Cataloger and Oracle Analyzer with Non Existing Schema and Table Filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                              | response code | response message                                   | jsonPath                                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                  |                                                                                                                   | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                                 |                                                                                                                   | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                                       | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                                   | 200           | Oracle19cPDBDS                                     |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithSchemaAndTableAndViewFilter.json     | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                                   | 200           | OracleCatalogerWithSchemaAndTableAndViewFilter     |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableAndViewFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                                  | 200           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableAndViewFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleAnalyzerWithnNonExistingSchemaAndTableFilter.json | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                                   | 200           | OracleAnalyzerWithnNonExistingSchemaAndTableFilter |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleAnalyzerWithnNonExistingSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                                  | 200           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleAnalyzerWithnNonExistingSchemaAndTableFilter')].status |

  ##7072921##
  Scenario:SC#27_2_verify data sampling and data profiling (varchar, decimal and Timestamp) for Table and View When Non Existing schema and Table name provided in OracleDBAnalyzer Filter
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                       | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | columnName/FieldName |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE.Lifecycle       | metadataAttributePresence    | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE.Description     | metadataValuePresence        | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       |                      |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_NAME.Statistics | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | NAME                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_NAME.Lifecycle  | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | NAME                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW.Lifecycle        | metadataAttributePresence    | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW.Description      | metadataValuePresence        | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        |                      |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW__NAME.Statistics | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | NAME                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW__NAME.Lifecycle  | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | NAME                 |

  @sanity @positive @regression
  Scenario:SC#27_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                              | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                                   | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableAndViewFilter%       | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithnNonExistingSchemaAndTableFilter% | Analysis |       |       |

  ##7072923##
  @jdbc
  Scenario Outline:SC#28_1_Run the OracleDB Cataloger and Oracle Analyzer With Incorrect Database Name in OracleDBAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                          | response code | response message                               | jsonPath                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                  |                                                                                                               | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                                 |                                                                                                               | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                                   | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                               | 200           | Oracle19cPDBDS                                 |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithSchemaAndTableAndViewFilter.json | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                               | 200           | OracleCatalogerWithSchemaAndTableAndViewFilter |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableAndViewFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                              | 200           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableAndViewFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleAnalyzerWithIncorrectDatabaseName.json        | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                               | 200           | OracleAnalyzerWithIncorrectDatabaseName        |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleAnalyzerWithIncorrectDatabaseName')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                              | 200           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleAnalyzerWithIncorrectDatabaseName')].status        |

  ##7072923##
  Scenario:SC#28_2_verify data sampling and data profiling are not done for Table and View When Incorrect Database Name is provided in the OracleDBAnalyzer
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                                        | jsonPath                       | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename | columnName/FieldName |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE.Lifecycle       | metadataAttributePresence    | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE.Description     | metadataValuePresence        | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       |                      |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_NAME.Statistics | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | NAME                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_TABLE_NAME.Lifecycle  | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE       | NAME                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW.Lifecycle        | metadataAttributePresence    | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        |                      |
      | Description | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW.Description      | metadataValuePresence        | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        |                      |
      | Statistics  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW__NAME.Statistics | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | NAME                 |
      | Lifecycle   | ida/jdbcAnalyzerPayloads/Oracle19cPDB/API/expectedMetadata.json | $.ORACLE_VIEW__NAME.Lifecycle  | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_VIEW        | NAME                 |

  @sanity @positive @regression
  Scenario:SC#28_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                        | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                             | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableAndViewFilter% | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithIncorrectDatabaseName%      | Analysis |       |       |

########################################################## PII Tags ################################################################################

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#29_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Delete       | settings/analyzers/OracleDBCataloger                                                 |                                                                                                         |                  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Delete       | settings/analyzers/OracleDBDataSource                                                |                                                                                                         |                  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | tags/Default/structures                                                              | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OraclePIITags.json                          | $.PIIConfig      | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC33           | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.CatalogConfig  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |                  | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.AnalyzerConfig | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |                  | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

  # 7099421
  @positve @regression @sanity @PIITag
  Scenario:SC#29_2_Verify Tag is set for the column when typePattern(String) and dataPattern/minimumRatio matches with the column type/value ratio in Oracle table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename  | Column    | Tags                                                                                         | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Email Address | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | GENDER    | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Gender        | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | SSN       | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,SSN           | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | FULL_NAME | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Full Name     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Email Address | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | SSN       | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,SSN           | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IP Address    | ColumnQuerywithSchema | TagAssigned |

  # 7099422
  @positve @regression @sanity @PIITag
  Scenario:SC#30_1_Verify Tag is not set for the column when typePattern(other than String) and dataPattern/minimumRatio matches with the column type/value ratio in Oracle table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags         | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | SSN       | SSNPII       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | EMAIL     | EmailPII     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | FULL_NAME | FullNamePII  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | GENDER    | GenderPII    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | IPAddressPII | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | SSNPII       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | EmailPII     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | FullNamePII  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | GenderPII    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | IPAddressPII | ColumnQuerywithSchema | TagNotAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#30_2_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#31_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC35           | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.CatalogConfig  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |                  | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.AnalyzerConfig | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |                  | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

  #7099423
  @positve @regression @sanity @PIITag
  Scenario:SC#31_2_Verify Tag is set for the column when namePattern and dataPattern/minimumRatio matches with the column name/value ratio in Oracle table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                                                                                        | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,EmailPII     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,GenderPII    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IPAddressPII | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,SSNPII       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,FullNamePII  | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,EmailPII     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | GENDER    | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,GenderPII    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IPAddressPII | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,SSNPII       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,FullNamePII  | ColumnQuerywithSchema | TagAssigned |

  #7099424
  @positve @regression @sanity @PIITag
  Scenario:SC#32_1_Verify Tag is not set for the column when namePattern(does not match) and dataPattern/minimumRatio that does not matches with the column name/value ratio in Oracle table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename  | Column    | Tags          | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | SSN       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | EMAIL     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | FULL_NAME | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | GENDER    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | IPADDRESS | IP Address    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | SSN       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | EMAIL     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | FULL_NAME | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | GENDER    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | IPADDRESS | IP Address    | ColumnQuerywithSchema | TagNotAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#32_2_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#33_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC37    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.Filter1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.Filter1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099425
  @positve @regression @sanity @PIITag
  Scenario:SC#33_2_Verify Tag is set for the column when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 0.2 - 2 or more rows should have matching column values)- Match Empty is False
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                   | Column    | Tags                                                                                         | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Email Address | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | GENDER    | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Gender        | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | SSN       | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,SSN           | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | FULL_NAME | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Full Name     | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#33_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#34_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC38    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.Filter2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.Filter2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099426
  @positve @regression @sanity @PIITag
  Scenario:SC#34_2_Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                                                                                         | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | SSN                                                                                          | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | Full Name                                                                                    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | Gender                                                                                       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Email Address | ColumnQuerywithSchema | TagAssigned    |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IP Address    | ColumnQuerywithSchema | TagAssigned    |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#35_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                     | path   | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json | $.SC39 | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                              |        | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                              |        | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                              |        | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status |

    #7099427
  @positve @regression @sanity @PIITag
  Scenario:SC#35_2_Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is True -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                                                                                         | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Email Address | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Gender        | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,SSN           | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Full Name     | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#35_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#36_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC40    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.Filter3 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.Filter3 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099428
  @positve @regression @sanity @PIITag
  Scenario:SC#36_2_Verify Tag is set for the column when dataPattern and minimumRatio(1-full match) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 1 - all rows should match) - Match Empty is false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename  | Column    | Tags                                                                                         | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Email Address | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | GENDER    | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Gender        | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | SSN       | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,SSN           | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | FULL_NAME | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Full Name     | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#36_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#37_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC41    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.Filter4 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.Filter4 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

     #7099429
  @positve @regression @sanity @PIITag
  Scenario:SC#37_2_Verify Tag is set for the column when dataPattern and minimumRatio(equal to 0.5) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 0.5 - 5 or more rows should have matching column values) - Match Empty is false.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                  | Column    | Tags                                                                                         | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Email Address | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | GENDER    | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Gender        | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | SSN       | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,SSN           | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | FULL_NAME | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Full Name     | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#37_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#38_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC42    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.Filter1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.Filter1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099430
  @positve @regression @sanity @PIITag
  Scenario:SC#38_2_Verify Tag is set for the column when namePattern,typePattern,dataPattern and minimumRatio is passed which has a regexp and minimum ratio that matches with the data in column in Oracle table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                   | Column    | Tags                                                                                         | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Email Address | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | GENDER    | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Gender        | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | SSN       | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,SSN           | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | FULL_NAME | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Full Name     | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#38_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#39_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC43           | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.CatalogConfig  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |                  | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.AnalyzerConfig | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |                  | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099431
  @positve @regression @sanity @PIITag
  Scenario:SC#39_2_Verify Tag is not set for the column when namePattern(does not match),typePattern,dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in column in Oracle table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename  | Column    | Tags          | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | SSN       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | EMAIL     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | FULL_NAME | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | GENDER    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | IPADDRESS | IP Address    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | SSN       | SSN           | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | EMAIL     | Email Address | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | FULL_NAME | Full Name     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | GENDER    | Gender        | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | IPADDRESS | IP Address    | ColumnQuerywithSchema | TagNotAssigned |

  #7099432
  @positve @regression @sanity @PIITag
  Scenario:SC#40_Verify Tag is not set for the column when namePattern,typePattern(does not match),dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in column in Oracle table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags         | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | SSN       | SSNPII       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | EMAIL     | EmailPII     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | FULL_NAME | FullNamePII  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | GENDER    | GenderPII    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | IPAddressPII | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | SSNPII       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | EmailPII     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | FullNamePII  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | GenderPII    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | IPAddressPII | ColumnQuerywithSchema | TagNotAssigned |

    #7099433 #7099437
  @positve @regression @sanity @PIITag
  Scenario:SC#41_1_Verify Tag is not set for the column when namePattern,typePattern,dataPattern and minimumRatio(does not match) is passed which has any of the regexp and ratio that does not matches with the data in column in Oracle table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                  | Column    | Tags            | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                 | SSN       | OracleSSN       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                 | EMAIL     | OracleEmail     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                 | FULL_NAME | OracleFullName  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                 | GENDER    | OracleGender    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                 | IPADDRESS | OracleIPAddress | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | SSN       | OracleSSN       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | EMAIL     | OracleEmail     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | FULL_NAME | OracleFullName  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | GENDER    | OracleGender    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | IPADDRESS | OracleIPAddress | ColumnQuerywithSchema | TagNotAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#41_2_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#42_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC46    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.Filter6 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.Filter6 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099434
  @positve @regression @sanity @PIITag
  Scenario:SC#42_2_Verify Tag is not set for the column when match empty is true and all the column values in DB are empty.(dataPattern/minimumRatio/MatchEmpty:True/MatchFull:False)
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename  | Column    | Tags                                                                                         | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Email Address | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | SSN       | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,SSN           | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#42_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#43_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC47    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.Filter5 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.Filter5 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099435
  @positve @regression @sanity @PIITag
  Scenario:SC#43_2_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in Oracle table.
  (Ex: 0.6 - 6 or more rows should have matcning column values - dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                         | Column   | Tags      | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | COMMENTS | FullMatch | ColumnQuerywithSchema | TagNotAssigned |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#43_3_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                     | path     | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json | $.SC47_1 | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                              |          | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                              |          | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                              |          | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status |

    #7099435
  @positve @regression @sanity @PIITag
  Scenario:SC#43_4_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in Oracle table.
  (Ex: 0.6 - 6 or more rows should have matcning column values - dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                         | Column   | Tags                                                                                     | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | COMMENTS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,FullMatch | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#43_5_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#44_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC48    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.Filter7 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.Filter7 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099436
  @positve @regression @sanity  @PIITag
  Scenario:SC#44_2_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the exact data in column in Oracle table.
  (Ex: 0.2 - 2 or more rows should have matcning column values - namePattern,typePattern,dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                        | Column   | Tags      | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolesserthan05MatchFullTrue | COMMENTS | FullMatch | ColumnQuerywithSchema | TagNotAssigned |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#44_4_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                     | path     | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json | $.SC48_1 | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                              |          | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                              |          | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                              |          | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status |

     #7099436
  @positve @regression @sanity @PIITag
  Scenario:SC#44_5_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the exact data in column in Oracle table.
  (Ex: 0.2 - 2 or more rows should have matching column values - namePattern,typePattern,dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                        | Column   | Tags                                                                                     | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolesserthan05MatchFullTrue | COMMENTS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,FullMatch | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#44_6_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#45_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC49    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.Filter8 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.Filter8 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

  #7099438
  @positve @regression @sanity @PIITag
  Scenario:SC#45_2_Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Oracle View.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename | Column    | Tags                                                                                         | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_VIEW    | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Email Address | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_VIEW    | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IP Address    | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#45_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#46_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC50    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.Filter8 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.Filter8 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099439
  @positve @regression @sanity @PIITag
  Scenario:SC#46_2_Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Oracle View.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is True -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename | Column    | Tags                                                                                         | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_VIEW    | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Email Address | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_VIEW    | GENDER    | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Gender        | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_VIEW    | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_VIEW    | SSN       | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,SSN           | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_VIEW    | FULL_NAME | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Full Name     | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#46_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#47_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC51    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.Filter2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.Filter2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099440
  @positve @regression @sanity @PIITag
  Scenario:SC#47_2_Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Oracle CDB.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                                                                                         | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Email Address | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IP Address    | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#47_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#48_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/policyEngine/OracleDBTag.json                            | $.SC52    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBCatalogerTagsConfig.json | $.Filter2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/Oracle19CPDBAnalyzerTagsConfig.json  | $.Filter2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099441
  @positve @regression @sanity @PIITag
  Scenario:SC#48_2_Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Oracle CDB.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is True -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                                                                                         | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Email Address | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Gender        | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,IP Address    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,SSN           | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | Orc19cPDBAnalyzer,Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat,Oracle19C_PDB_AY,Full Name     | ColumnQuerywithSchema | TagAssigned |

  @sanity @positive @regression @PIITag
  Scenario:SC#48_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type                | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster             |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis            |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis            |       |       |
      | SingleItemDelete | Default | Oracle19C_PDB_Cat                               | BusinessApplication |       |       |
      | SingleItemDelete | Default | Oracle19C_PDB_AY                                | BusinessApplication |       |       |


    ######################################################### OracleDB Enhancements ################################################################


  Scenario Outline:SC#49_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                       | response code | response message            | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                            | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                            | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                            | 200           | Oracle19cPDBDS              |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithNoFilter.json | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                            | 200           | OracleCatalogerWithNoFilter |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                            | 200           | IDLE                        | $.[?(@.configurationName=='OracleCatalogerWithNoFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                           | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                            | 200           | IDLE                        | $.[?(@.configurationName=='OracleCatalogerWithNoFilter')].status |


  @TEST_MLPQA-20407 @REQ_MLP-34223 @MLPQA-20377 @webtest
  Scenario:SC#49_2_Verify all schemas including system schemas must be collected No filter provided in the configs
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField               | columnName | queryOperation | facet         | facetValue | count      |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getAllSystemSchemasCount | count      | returnValue    | Metadata Type | Schema     | fromSource |
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PDBDB19C.DIQ.QA.ASGINT.LOC" item from search results
    And user "verifies tab section values" has the following values in "Schemas" Tab in Item View page
      | APPQOSSYS                |
      | AUDSYS                   |
      | CTXSYS                   |
      | DBSFWUSER                |
      | DBSNMP                   |
      | DVF                      |
      | DVSYS                    |
      | GSMADMIN_INTERNAL        |
      | HR                       |
      | LBACSYS                  |
      | MDSYS                    |
      | OJVMSYS                  |
      | OLAPSYS                  |
      | ORACLE_TESTSCHEMA        |
      | ORACLE_OCM               |
      | ORACLE12C_SCHEMA1        |
      | ORACLE12C_SCHEMA2        |
      | ORACLE19C_LINEAGESCHEMA1 |
      | ORACLE19C_LINEAGESCHEMA2 |
      | ORDDATA                  |
      | ORDPLUGINS               |
      | ORDSYS                   |
      | OUTLN                    |
      | PUBLIC                   |
      | REMOTE_SCHEDULER_AGENT   |
      | SCH_BOA                  |
      | SI_INFORMTN_SCHEMA       |
      | SYS                      |
      | SYSTEM                   |
      | TEST_TAGGING             |
      | TEST_TAGGING_CAE         |
      | TEST_TAGGING_LINEAGE     |
      | WMSYS                    |
      | XDB                      |


  @TEST_MLPQA-20406 @REQ_MLP-34223 @MLPQA-20377
  Scenario:SC#50_Verify all tags(Technology, Business App, User defined tags) must be added to the items collected by the plugin when OracleDBCataloger ran.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName               | TableName/Filename | Column | Tags                                        | Query       | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | APPQOSSYS                |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | AUDSYS                   |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | CTXSYS                   |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | DBSFWUSER                |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | DBSNMP                   |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | DVF                      |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | DVSYS                    |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | GSMADMIN_INTERNAL        |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | HR                       |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | LBACSYS                  |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | MDSYS                    |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | OJVMSYS                  |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | OLAPSYS                  |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE_TESTSCHEMA        |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE_OCM               |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1        |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2        |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE19C_LINEAGESCHEMA1 |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE19C_LINEAGESCHEMA2 |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORDDATA                  |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORDPLUGINS               |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORDSYS                   |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | OUTLN                    |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | PUBLIC                   |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | REMOTE_SCHEDULER_AGENT   |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | SCH_BOA                  |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | SI_INFORMTN_SCHEMA       |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | SYS                      |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | SYSTEM                   |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING             |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE         |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_LINEAGE     |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | WMSYS                    |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | XDB                      |                    |        | Oracle,Orc19cPDBCataloger,Oracle19C_PDB_Cat | SchemaQuery | TagAssigned |


  @sanity @positive @regression
  Scenario:SC#50_1_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                     | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                          | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithNoFilter% | Analysis |       |       |


  Scenario Outline:SC#51_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                           | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                                | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                                | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                    | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                | 200           | Oracle19cPDBDS                  |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithSchemaFilter.json | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                | 200           | OracleCatalogerWithSchemaFilter |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                               | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |

  @TEST_MLPQA-20408 @REQ_MLP-34223 @MLPQA-20377 @webtest
  Scenario:SC#51_2_Verify all schemas including system schemas must be collected with filter provided in the configs
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField               | columnName | queryOperation | facet         | facetValue | count      |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getAllSystemSchemasCount | count      | returnValue    | Metadata Type | Schema     | fromSource |
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PDBDB19C.DIQ.QA.ASGINT.LOC" item from search results
    And user "verifies tab section values" has the following values in "Schemas" Tab in Item View page
      | APPQOSSYS                |
      | AUDSYS                   |
      | CTXSYS                   |
      | DBSFWUSER                |
      | DBSNMP                   |
      | DVF                      |
      | DVSYS                    |
      | GSMADMIN_INTERNAL        |
      | HR                       |
      | LBACSYS                  |
      | MDSYS                    |
      | OJVMSYS                  |
      | OLAPSYS                  |
      | ORACLE_TESTSCHEMA        |
      | ORACLE_OCM               |
      | ORACLE12C_SCHEMA1        |
      | ORACLE12C_SCHEMA2        |
      | ORACLE19C_LINEAGESCHEMA1 |
      | ORACLE19C_LINEAGESCHEMA2 |
      | ORDDATA                  |
      | ORDPLUGINS               |
      | ORDSYS                   |
      | OUTLN                    |
      | PUBLIC                   |
      | REMOTE_SCHEDULER_AGENT   |
      | SCH_BOA                  |
      | SI_INFORMTN_SCHEMA       |
      | SYS                      |
      | SYSTEM                   |
      | TEST_TAGGING             |
      | TEST_TAGGING_CAE         |
      | TEST_TAGGING_LINEAGE     |
      | WMSYS                    |
      | XDB                      |

  @sanity @positive @regression
  Scenario:SC#51_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                              | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter% | Analysis |       |       |

  Scenario Outline:SC#52_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                              | response code | response message                                   | jsonPath                                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                |                                                                                                                   | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                               |                                                                                                                   | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                                       | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                                   | 200           | Oracle19cPDBDS                                     |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerwithNonExistingSchemaAndTableFilter.json | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                                   | 200           | OracleCatalogerwithNonExistingSchemaAndTableFilter |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerwithNonExistingSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                                                  | 200           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerwithNonExistingSchemaAndTableFilter')].status |


  @TEST_MLPQA-20409 @REQ_MLP-34223 @MLPQA-20377 @webtest
  Scenario:SC#52_2_Verify all schemas including system schemas must be collected Invalid filter provided in the configs
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField               | columnName | queryOperation | facet         | facetValue | count      |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getAllSystemSchemasCount | count      | returnValue    | Metadata Type | Schema     | fromSource |
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PDBDB19C.DIQ.QA.ASGINT.LOC" item from search results
    And user "verifies tab section values" has the following values in "Schemas" Tab in Item View page
      | APPQOSSYS                |
      | AUDSYS                   |
      | CTXSYS                   |
      | DBSFWUSER                |
      | DBSNMP                   |
      | DVF                      |
      | DVSYS                    |
      | GSMADMIN_INTERNAL        |
      | HR                       |
      | LBACSYS                  |
      | MDSYS                    |
      | OJVMSYS                  |
      | OLAPSYS                  |
      | ORACLE_TESTSCHEMA        |
      | ORACLE_OCM               |
      | ORACLE12C_SCHEMA1        |
      | ORACLE12C_SCHEMA2        |
      | ORACLE19C_LINEAGESCHEMA1 |
      | ORACLE19C_LINEAGESCHEMA2 |
      | ORDDATA                  |
      | ORDPLUGINS               |
      | ORDSYS                   |
      | OUTLN                    |
      | PUBLIC                   |
      | REMOTE_SCHEDULER_AGENT   |
      | SCH_BOA                  |
      | SI_INFORMTN_SCHEMA       |
      | SYS                      |
      | SYSTEM                   |
      | TEST_TAGGING             |
      | TEST_TAGGING_CAE         |
      | TEST_TAGGING_LINEAGE     |
      | WMSYS                    |
      | XDB                      |

  @sanity @positive @regression
  Scenario:SC#52_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerwithNonExistingSchemaAndTableFilter% | Analysis |       |       |


  Scenario Outline:SC#53_1_Run the Plugin configurations for DataSource and run the Oracle19CPDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | body                                                                                           | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBCataloger                                                              |                                                                                                | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete       | settings/analyzers/OracleDBDataSource                                                             |                                                                                                | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                                             | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                    | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                                             |                                                                                                | 200           | Oracle19cPDBDS                  |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                                              | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithNoFilter.json     | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                                              |                                                                                                | 200           | OracleCatalogerWithNoFilter     |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithNoFilter     |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithNoFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithNoFilter      | ida/jdbcAnalyzerPayloads/Oracle19cPDB/empty.json                                               | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithNoFilter     |                                                                                                | 200           | RUNNING                         | $.[?(@.configurationName=='OracleCatalogerWithNoFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                                              | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithNoFilter_PDB.json | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                                              |                                                                                                | 200           | OracleCatalogerWithNoFilter_PDB |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*                               |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithNoFilter_PDB')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*                                | ida/jdbcAnalyzerPayloads/Oracle19cCDB/empty.json                                               | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithNoFilter_PDB |                                                                                                | 200           | RUNNING                         | $.[?(@.configurationName=='OracleCatalogerWithNoFilter_PDB')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithNoFilter     |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithNoFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithNoFilter_PDB |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithNoFilter_PDB')].status |


  @TEST_MLPQA-20410 @REQ_MLP-34223 @MLPQA-20377 @webtest
  Scenario:SC#53_2_Verify OraclDBPlugin support concurrent run of same plugin in same node with different run configs
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Technology" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField               | columnName | queryOperation | facet         | facetValue | count      |
      | oracle19c_pdb | STRUCTURED   | json/IDA.json | oracle19cPDBQueries | getAllSystemSchemasCount | count      | returnValue    | Metadata Type | Schema     | fromSource |
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PDBDB19C.DIQ.QA.ASGINT.LOC" item from search results
    And user "verifies tab section values" has the following values in "Schemas" Tab in Item View page
      | APPQOSSYS                |
      | AUDSYS                   |
      | CTXSYS                   |
      | DBSFWUSER                |
      | DBSNMP                   |
      | DVF                      |
      | DVSYS                    |
      | GSMADMIN_INTERNAL        |
      | HR                       |
      | LBACSYS                  |
      | MDSYS                    |
      | OJVMSYS                  |
      | OLAPSYS                  |
      | ORACLE_TESTSCHEMA        |
      | ORACLE_OCM               |
      | ORACLE12C_SCHEMA1        |
      | ORACLE12C_SCHEMA2        |
      | ORACLE19C_LINEAGESCHEMA1 |
      | ORACLE19C_LINEAGESCHEMA2 |
      | ORDDATA                  |
      | ORDPLUGINS               |
      | ORDSYS                   |
      | OUTLN                    |
      | PUBLIC                   |
      | REMOTE_SCHEDULER_AGENT   |
      | SCH_BOA                  |
      | SI_INFORMTN_SCHEMA       |
      | SYS                      |
      | SYSTEM                   |
      | TEST_TAGGING             |
      | TEST_TAGGING_CAE         |
      | TEST_TAGGING_LINEAGE     |
      | WMSYS                    |
      | XDB                      |


  @sanity @positive @regression
  Scenario:SC#53_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                              | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithNoFilter%     | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithNoFilter_PDB% | Analysis |       |       |


  @jdbc
  Scenario Outline:SC#54_Delete Plugin Configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                 | body | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/EDIBusOracleCredentials        |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/EDIBusDataSource                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBCataloger                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBAnalyzer                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBDataSource               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Oracle19cPDBCredentials        |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Oracle19cPDBInvalidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Oracle19cPDBEmptyCredentials   |      | 200           |                  |          |

