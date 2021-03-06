@MLP-4630
Feature:Verification of JDBC Analyzer using Oracle 12c CDB database and plugin validation

  ####################################################TestData Creation############################################################

#  @jdbc
#  Scenario:create user/schema
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation            | queryPath     | queryPage        | queryField       |
#      | oracle12c_cdb      | EXECUTEQUERY         | json/IDA.json | oracle12cQueries | createCDBSchema1 |
#      | oracle12c_cdb      | EXECUTEQUERY         | json/IDA.json | oracle12cQueries | createCDBSchema2 |
#      | oracle12c_cdb      | EXECUTELISTOFQUERIES | json/IDA.json | oracle12cQueries | createCDBSchema3 |
#      | oracle12c_cdb      | EXECUTELISTOFQUERIES | json/IDA.json | oracle12cQueries | createCDBSchema4 |
#
#
#  @jdbc
#  Scenario:create tablespace to created user/schema
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation    | queryPath     | queryPage        | queryField           |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | grantCDBTablespace1  |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | grantCDBTablespace2  |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | grantCDB1Tablespace1 |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | grantCDB1Tablespace2 |
#
#
#  @jdbc
#  Scenario:Create Tables, insert record
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation    | queryPath     | queryPage        | queryField                      |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBConstraintTable        |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDB1ConstraintTable       |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTestTable1             |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDB1TestTable1            |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTimeStampEmptyTable    |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDB1TimeStampEmptyTable   |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTestTable2             |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDBRecord5                |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDB1TestTable2            |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDB1Record5               |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBDiffDataTypesTable     |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBCheckConstraintTable   |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBUniqueConstraintTable  |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBIndexConstraintTable   |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBIndexOnTable           |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBPrimaryKeyTable        |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBForeignKeyTable        |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDB1DiffDataTypesTable    |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDB1CheckConstraintTable  |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDB1UniqueConstraintTable |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDB1IndexConstraintTable  |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDB1IndexOnTable          |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDB1PrimaryKeyTable       |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDB1ForeignKeyTable       |
#
#
#  @jdbc
#  Scenario:Create Table and insert value for data sampling
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation    | queryPath     | queryPage        | queryField        |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTable    |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDBRecord1  |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDBRecord2  |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDBRecord3  |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDBRecord4  |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDB1Table   |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDB1Record1 |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDB1Record2 |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDB1Record3 |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDB1Record4 |
#
#
#  @jdbc
#  Scenario:Create Table with Timestamp and insert records for Verification
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation    | queryPath     | queryPage        | queryField                |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTimeStampTable   |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDB1TimeStampTable  |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDBTimeStampRecord  |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDB1TimeStampRecord |
#
#
#  @jdbc
#  Scenario:Create table, procedure and execute the procedure
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation    | queryPath     | queryPage        | queryField             |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTable1        |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDBTable1Record1 |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTable2        |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBProcedure1    |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | executeCDBProcedure1   |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTable3        |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDBTable3Record1 |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDBTable3Record2 |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBView1         |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTable4        |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBProcedure2    |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | executeCDBProcedure2   |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTable5        |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDBTable5Record1 |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTable6        |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBFunction1     |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | executeCDBFunction1    |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTable7        |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBView2         |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBProcedure3    |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | executeCDBProcedure3   |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTable8        |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTable9        |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | createCDBTrigger1      |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | insertCDBTable8Record1 |


  @precondition
  Scenario:SC#1_1_Update credential payload json for Oracle12cCDB
    Given User update the below "oracle12cCDB credentials" in following files using json path
      | filePath                                                     | username    | password    |
      | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleCredentials.json | $..userName | $..password |


  @sanity @positive @regression @IDA_E2E
  Scenario Outline:SC#1_2_Add valid Credentials for Oracle12cCDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                 | body                                                                    | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusOracleCredentials        | idc/EdiBusPayloads/credentials/EDIBusValidCredentials.json                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle12cCDBCredentials        | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleCredentials.json            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle12cCDBCredentials        |                                                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle12cCDBInvalidCredentials | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleInvalidCredentials.json     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle12cCDBInvalidCredentials |                                                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle12cCDBEmptyCredentials   | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleCredentialsEmpty.json       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle12cCDBEmptyCredentials   |                                                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root                                  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/businessApplicationCataloger.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root                                  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/businessApplicationAnalyzer.json  | 200           |                  |          |



  ##7046124##
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
      | Credential       | Oracle12cCDBInvalidCredentials |
      | Node             | LocalNode                      |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                      |
      | Name      | Oracle12cCDBDS_Test                                            |
      | Label     | Oracle12cCDBDS_Test                                            |
      | URL       | jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORCA12C |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                    |
      | Credential | Oracle12cCDBEmptyCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  ##7046130##
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
      | Credential       | Oracle12cCDBCredentials |
      | Node             | LocalNode               |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                      |
      | Name      | Oracle12cCDBDS_Test                                            |
      | Label     | Oracle12cCDBDS_Test                                            |
      | URL       | jdbc:oracle:thin:@DIDORACLE01V.DID.DEV.ASGINT.LOC:1521:ORCA12C |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"


  ##7046132##
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
      | Data Source | Oracle12cCDBDS_Test            |
      | Data Source | Oracle12cCDBDS_Test            |
      | Credential  | Oracle12cCDBInvalidCredentials |
      | Credential  | Oracle12cCDBInvalidCredentials |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                  |
      | Name      | Oracle12cCDBCataloger_Test |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Configuration Sources Page"
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute                    |
      | Credential | Oracle12cCDBEmptyCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Configuration Sources Page"
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  ##7046144##
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
      | Data Source | Oracle12cCDBDS_Test     |
      | Data Source | Oracle12cCDBDS_Test     |
      | Credential  | Oracle12cCDBCredentials |
      | Credential  | Oracle12cCDBCredentials |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                  |
      | Name      | Oracle12cCDBCataloger_Test |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"
    And user "click" on "Save" button in "Add Configuration Sources Page"


  Scenario Outline:SC#2_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                      | response code | response message           | jsonPath                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                               | 204           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                           | 200           | Oracle12cCDBDS             |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithFilters.json | 204           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                           | 200           | OracleCatalogerWithFilters |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                           | 200           | IDLE                       | $.[?(@.configurationName=='OracleCatalogerWithFilters')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                          | 200           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                           | 200           | IDLE                       | $.[?(@.configurationName=='OracleCatalogerWithFilters')].status |


#           #6549303
#  @sanity @positive @webtest @edibus
#  Scenario:MLP-9043_Verify the OracleDB items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Orc12cCDBCataloger" and clicks on search
#    And user performs "facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Synonym       |
#      | Column        |
#      | UserRole      |
#      | Index         |
#      | Table         |
#      | User          |
#      | Constraint    |
#      | Sequence      |
#      | Routine       |
#      | Schema        |
#      | Tablespace    |
#      | Trigger       |
#      | File          |
#      | DatabaseLink  |
#      | Analysis      |
#      | Cluster       |
#      | Configuration |
#      | Database      |
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
#    And user enters the search text "Orc12cCDBCataloger" and clicks on search
#    And user performs "facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
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
#      |        |       |       | Post | searches/fulltext/Default?query=Orc12cCDBCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
#    And user enters the search text "Orc12cCDBCataloger" and clicks on search
#    And user performs "facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
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
#      |        |       |       | Post | searches/fulltext/Default?query=Orc12cCDBCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA ) |
#    And user enters the search text "Orc12cCDBCataloger" and clicks on search
#    And user performs "facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
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
#      |        |       |       | Post | searches/fulltext/Default?query=Orc12cCDBCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
#    And user enters the search text "Orc12cCDBCataloger" and clicks on search
#    And user performs "facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
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
#      |        |       |       | Post | searches/fulltext/Default?query=Orc12cCDBCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
#    And user enters the search text "Orc12cCDBCataloger" and clicks on search
#    And user performs "facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                             |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @*Oracle???DEFAULT???DWR_RDB_SCHEMA???@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @*Oracle???DEFAULT???DWR_RDB_COLUMN???@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @*Oracle???DEFAULT???DWR_RDB_TABLE_OR_VIEW???@* ),AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @*Oracle???DEFAULT???DWR_RDB_DATABASE???@* ),AND,( TYPE = DWR_IDC )      |
#      | AP-DATA      | ORACLEDB    | 1.0                | (XNAME * *  ~/ @*Oracle???DEFAULT???DWR_RDB_DB_SYSTEM???@* ),AND,( TYPE = DWR_IDC )     |
#
#
#  @sanity @positive @regression @edibus
#  Scenario:Delete EDI Bus Analysis file
#    Given Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                        | type     | query | param |
#      | SingleItemDelete | Default | bulk/EDIBus/EDIBusOracleDB% | Analysis |       |       |


  ##6767916## ##6767915## ##6767912## ##6767895##
  @webtest @jdbc @MLP-5641
  Scenario:SC#2_2_Verify the Database(OracleDB) Metadata,Schema(OracleDB) Metadata,Breadcumb hierarchy and Oracle Table should not have constraints in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORCA12C.DID.DEV.ASGINT.LOC" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                       | widgetName  |
      | Storage type      | Oracle Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production | Description |
      | databaseType      | CDB                                                                                 | Description |
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
    And user enters the search text "ORACLE_TAG_DETAILS" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FULL_NAME" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | DIDORACLE01V.DID.DEV.ASGINT.LOC |
      | ORACLE:1521                     |
      | ORCA12C.DID.DEV.ASGINT.LOC      |
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
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "definite facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OCPPDSVT" item from search results
    Then user performs click and verify in new window
      | Table        | value  | Action                 | RetainPrevwindow | indexSwitch |
      | dependencies | OCPPVT | verify widget contains | No               |             |
    And user enters the search text "TRIGGER1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Trigger" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TRIGGER1" item from search results
    Then user performs click and verify in new window
      | Table        | value        | Action                 | RetainPrevwindow | indexSwitch |
      | dependencies | TRIGGERTEST  | verify widget contains | No               |             |
      | dependencies | TRIGGERTEST1 | verify widget contains | No               |             |
    And user enters the search text "OCPPTESTFUNCTION" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OCPPTESTFUNCTION" item from search results
    Then user performs click and verify in new window
      | Table        | value     | Action                 | RetainPrevwindow | indexSwitch |
      | dependencies | OCPPFT2T1 | verify widget contains | No               |             |
      | dependencies | OCPPFT2T2 | verify widget contains | No               |             |
    And user enters the search text "PROT2T" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PROT2T" item from search results
    Then user performs click and verify in new window
      | Table        | value    | Action                 | RetainPrevwindow | indexSwitch |
      | dependencies | OCPPT2T1 | verify widget contains | No               |             |
      | dependencies | OCPPT2T2 | verify widget contains | No               |             |


  ##6767894## ##6477888##
  @webtest @jdbc @MLP-5641 @MLP-9602
  Scenario:SC#2_4_Verify the Oracle Table should have constraints like Primary Key,Foreign key,Unique Key and Check constraints and Schema has index.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE_CHECK_SUPPLIER_ID" and clicks on search
    And user performs "definite facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | ORACLE_CHECK_SUPPLIER_ID |
    And user performs "item click" on "ORACLE_CHECK_SUPPLIER_ID" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                 | widgetName  |
      | checkCondition    | check_id BETWEEN 100 and 9999 | Description |
      | Constraint Type   | CHECK                         | Description |
      | deferred          | NO                            | Description |
      | generatedName     | NO                            | Description |
      | validated         | YES                           | Description |
      | disabled          | NO                            | Description |
      | deferrable        | NO                            | Description |
      | rely              | NO                            | Description |
    And user enters the search text "ORACLE_SUPPLIER_UNIQUETEST" and clicks on search
    And user performs "definite facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | ORACLE_SUPPLIER_UNIQUETEST |
    And user performs "item click" on "ORACLE_SUPPLIER_UNIQUETEST" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | UNIQUE        | Description |
      | deferred          | NO            | Description |
      | generatedName     | NO            | Description |
      | validated         | YES           | Description |
      | disabled          | NO            | Description |
      | deferrable        | NO            | Description |
      | rely              | NO            | Description |
    And user enters the search text "ORACLEINDEXTEST" and clicks on search
    And user performs "definite facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | ORACLEINDEXTEST |
    And user performs "item click" on "ORACLEINDEXTEST" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | generatedName     | NO            | Description |
      | indexType         | NORMAL        | Description |
      | unique            | NO            | Description |
    And user enters the search text "PERSON_INFO_PK" and clicks on search
    And user performs "definite facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | PERSON_INFO_PK |
    And user performs "item click" on "PERSON_INFO_PK" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | PRIMARY_KEY   | Description |
      | deferred          | NO            | Description |
      | generatedName     | NO            | Description |
      | validated         | YES           | Description |
      | disabled          | NO            | Description |
      | deferrable        | NO            | Description |
      | rely              | NO            | Description |
    And user enters the search text "FK_PERSON_INFO" and clicks on search
    And user performs "definite facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | FK_PERSON_INFO |
    And user performs "item click" on "FK_PERSON_INFO" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | FOREIGN_KEY   | Description |
      | deferred          | NO            | Description |
      | generatedName     | NO            | Description |
      | validated         | YES           | Description |
      | disabled          | NO            | Description |
      | deferrable        | NO            | Description |
      | rely              | NO            | Description |


    ###########################################RelationShip Verification#######################################

  ##6767911##
  @webtest @MLP-9602
  Scenario:SC#3_1_Verify the relationships shows properly between the table and constraint under relationship tab
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PERSON_INFO_PK" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PERSON_INFO_PK" item from search results
    Then user performs click and verify in new window
      | Table   | value          | Action                 | RetainPrevwindow | indexSwitch |
      | index   | PERSON_INFO_PK | verify widget contains | No               |             |
      | columns | PERSON_ID      | verify widget contains | No               |             |
    And user enters the search text "FK_PERSON_INFO" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FK_PERSON_INFO" item from search results
    Then user performs click and verify in new window
      | Table   | value                         | Action                 | RetainPrevwindow | indexSwitch |
      | parent  | PERSON_INFO_PK                | verify widget contains | No               |             |
      | parent  | ORACLE_PERSON_ADDRESS_DETAILS | verify widget contains | No               |             |
      | columns | PERSON_ID                     | verify widget contains | No               |             |
    And user enters the search text "ORACLE_SUPPLIER_UNIQUETEST" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_SUPPLIER_UNIQUETEST" item from search results
    Then user performs click and verify in new window
      | Table   | value                      | Action                 | RetainPrevwindow | indexSwitch |
      | index   | ORACLE_SUPPLIER_UNIQUETEST | verify widget contains | No               |             |
      | columns | SUPPLIER_ID                | verify widget contains | No               |             |
    And user enters the search text "ORACLE_SUPPLIER_UNIQUETEST" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_SUPPLIER_UNIQUETEST" item from search results
    Then user performs click and verify in new window
      | Table           | value             | Action                 | RetainPrevwindow | indexSwitch |
      | referencedTable | ORACLE_UNIQUETEST | verify widget contains | No               |             |
      | columns         | SUPPLIER_ID       | verify widget contains | No               |             |


  Scenario Outline:SC#3_2_user retrieves ids for specific item name
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>"
    Examples:
      | database      | catalog | name                       | type       | targetFile                                                                 |
      | APPDBPOSTGRES | Default | PERSON_INFO_PK             | Constraint | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/constraintIDs.json |
      | APPDBPOSTGRES | Default | FK_PERSON_INFO             | Constraint | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/constraintIDs.json |
      | APPDBPOSTGRES | Default | ORACLE_SUPPLIER_UNIQUETEST | Constraint | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/constraintIDs.json |
      | APPDBPOSTGRES | Default | ORACLE_SUPPLIER_UNIQUETEST | Index      | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/indexIDs.json      |

  Scenario Outline:SC#3_3_user copy the id to payload
    Given user copy the id from "<file>" to "<payloadFile>" with "<type>" using "<jsonPath>"
    Examples:
      | file                                                                       | payloadFile                                                                            | type       | jsonPath                      |
      | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/constraintIDs.json | Constant.REST_DIR/response/Oracle12cCDB/payloads/person_info_pk.json                   | Constraint | $..PERSON_INFO_PK             |
      | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/constraintIDs.json | Constant.REST_DIR/response/Oracle12cCDB/payloads/fk_person_info.json                   | Constraint | $..FK_PERSON_INFO             |
      | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/constraintIDs.json | Constant.REST_DIR/response/Oracle12cCDB/payloads/oracle_supplier_uniquetest.json       | Constraint | $..ORACLE_SUPPLIER_UNIQUETEST |
      | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/indexIDs.json      | Constant.REST_DIR/response/Oracle12cCDB/payloads/oracle_supplier_uniquetest_index.json | Index      | $..ORACLE_SUPPLIER_UNIQUETEST |


  Scenario Outline:SC#3_4_user get the response of lineage edges and store the lineage values in file
    Given user hits "<request>" with "<url>" "<body>" for id from "<file>" "<type>" using "<path>" and verify "<statusCode>" and store response of "<jsonPath>" in "<targetFile>" for "<name>"
    Examples:
      | request | url                                                                                       | body | file                                                                       | type | path                          | statusCode | jsonPath   | targetFile                                                                                    | name                       |
      | Get     | searches/Default/query/queryDiagramOut/Default.Constraint:::DYN?what=id,type,name,catalog |      | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/constraintIDs.json | List | $..PERSON_INFO_PK             | 200        | $..edges.* | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/person_info_pk.json                   | PERSON_INFO_PK             |
      | Get     | searches/Default/query/queryDiagramOut/Default.Constraint:::DYN?what=id,type,name,catalog |      | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/constraintIDs.json | List | $..FK_PERSON_INFO             | 200        | $..edges.* | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/fk_person_info.json                   | FK_PERSON_INFO             |
      | Get     | searches/Default/query/queryDiagramOut/Default.Constraint:::DYN?what=id,type,name,catalog |      | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/constraintIDs.json | List | $..ORACLE_SUPPLIER_UNIQUETEST | 200        | $..edges.* | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/oracle_supplier_uniquetest.json       | ORACLE_SUPPLIER_UNIQUETEST |
      | Get     | searches/Default/query/queryDiagramOut/Default.Index:::DYN?what=id,type,name,catalog      |      | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/indexIDs.json      | List | $..ORACLE_SUPPLIER_UNIQUETEST | 200        | $..edges.* | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/oracle_supplier_uniquetest_index.json | ORACLE_SUPPLIER_UNIQUETEST |


  Scenario Outline:SC#3_5_user retrieve the name of id for each value stored in lineage data file
    Given user gets the name for each id stored in "<LineageFile>" under "<Name>" and replace the id with name
    Examples:
      | LineageFile                                                                                   | Name                       |
      | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/person_info_pk.json                   | PERSON_INFO_PK             |
      | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/fk_person_info.json                   | FK_PERSON_INFO             |
      | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/oracle_supplier_uniquetest.json       | ORACLE_SUPPLIER_UNIQUETEST |
      | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/oracle_supplier_uniquetest_index.json | ORACLE_SUPPLIER_UNIQUETEST |

  Scenario:SC#3_6_Copy the file and remove the id value
    Given user copy the data from "rest/response/Oracle12cCDB/actualJsonFiles/person_info_pk.json" file to "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/person_info_pk.json" file
    And user copy the data from "rest/response/Oracle12cCDB/actualJsonFiles/fk_person_info.json" file to "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/fk_person_info.json" file
    And user copy the data from "rest/response/Oracle12cCDB/actualJsonFiles/oracle_supplier_uniquetest.json" file to "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/oracle_supplier_uniquetest.json" file
    And user copy the data from "rest/response/Oracle12cCDB/actualJsonFiles/oracle_supplier_uniquetest_index.json" file to "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/oracle_supplier_uniquetest_index.json" file
    And user "update" the json file "ida/jdbcAnalyzerPayloads/Oracle12cCDB/person_info_pk.json" file for following values
      | jsonPath | jsonValues | type   |
      | $..id    |            | String |
    And user "update" the json file "ida/jdbcAnalyzerPayloads/Oracle12cCDB/fk_person_info.json" file for following values
      | jsonPath | jsonValues | type   |
      | $..id    |            | String |
    And user "update" the json file "ida/jdbcAnalyzerPayloads/Oracle12cCDB/oracle_supplier_uniquetest.json" file for following values
      | jsonPath | jsonValues | type   |
      | $..id    |            | String |
    And user "update" the json file "ida/jdbcAnalyzerPayloads/Oracle12cCDB/oracle_supplier_uniquetest_index.json" file for following values
      | jsonPath | jsonValues | type   |
      | $..id    |            | String |
    And user copy the data from "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/person_info_pk.json" file to "rest/response/Oracle12cCDB/actualJsonFiles/person_info_pk.json" file
    And user copy the data from "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/fk_person_info.json" file to "rest/response/Oracle12cCDB/actualJsonFiles/fk_person_info.json" file
    And user copy the data from "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/oracle_supplier_uniquetest.json" file to "rest/response/Oracle12cCDB/actualJsonFiles/oracle_supplier_uniquetest.json" file
    And user copy the data from "rest/payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/oracle_supplier_uniquetest_index.json" file to "rest/response/Oracle12cCDB/actualJsonFiles/oracle_supplier_uniquetest_index.json" file


  Scenario Outline:SC#3_7_user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                    | actualJson                                                                                    |
      | Constant.REST_DIR/response/Oracle12cCDB/expectedJsonFiles/person_info_pk.json                   | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/person_info_pk.json                   |
      | Constant.REST_DIR/response/Oracle12cCDB/expectedJsonFiles/fk_person_info.json                   | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/fk_person_info.json                   |
      | Constant.REST_DIR/response/Oracle12cCDB/expectedJsonFiles/oracle_supplier_uniquetest.json       | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/oracle_supplier_uniquetest.json       |
      | Constant.REST_DIR/response/Oracle12cCDB/expectedJsonFiles/oracle_supplier_uniquetest_index.json | Constant.REST_DIR/response/Oracle12cCDB/actualJsonFiles/oracle_supplier_uniquetest_index.json |

######################################################################################################################

  @webtest
  Scenario:SC#4_1_Verify captions  text in OracleDataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source" button in Manage Data Sources
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
  @webtest @jdbc @MLP-9602
  Scenario:SC#4_4_Verify OracleDBCataloger collects all the different columns of a table when table is created with all possible datatypes
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE_DIFFDATATYPES" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_DIFFDATATYPES" item from search results
    Then user performs click and verify in new window
      | Table   | value               | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath              | metadataSection |
      | Columns | TIMESTAMP6TZCOLUMN  | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.TIMESTAMP6TZCOLUMN  | Description     |
      | Columns | FLOATCOLUMN         | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.FLOATCOLUMN         | Description     |
      | Columns | BINARYDOUBLECOLUMN  | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.BINARYDOUBLECOLUMN  | Description     |
      | Columns | RAWCOLUMN           | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.RAWCOLUMN           | Description     |
      | Columns | UROWIDCOLUMN        | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.UROWIDCOLUMN        | Description     |
      | Columns | DATECOLUMN          | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.DATECOLUMN          | Description     |
      | Columns | TIMESTAMPCOLUMN     | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.TIMESTAMPCOLUMN     | Description     |
      | Columns | CLOBCOLUMN          | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.CLOBCOLUMN          | Description     |
      | Columns | NVARCHAR2COLUMN     | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.NVARCHAR2COLUMN     | Description     |
      | Columns | NCHARCOLUMN         | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.NCHARCOLUMN         | Description     |
      | Columns | CHARCOLUMN          | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.CHARCOLUMN          | Description     |
      | Columns | VARCHARCOLUMN       | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.VARCHARCOLUMN       | Description     |
      | Columns | VARCHAR2COLUMN      | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.VARCHAR2COLUMN      | Description     |
      | Columns | BLOBCOLUMN          | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.BLOBCOLUMN          | Description     |
      | Columns | BFILECOLUMN         | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.BFILECOLUMN         | Description     |
      | Columns | LONGCOLUMN          | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.LONGCOLUMN          | Description     |
      | Columns | TIMESTAMP6LTZCOLUMN | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.TIMESTAMP6LTZCOLUMN | Description     |
      | Columns | ROWIDCOLUMN         | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.ROWIDCOLUMN         | Description     |
      | Columns | BINARYFLOATCOLUMN   | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.BINARYFLOATCOLUMN   | Description     |
      | Columns | NUMBERCOLUMN        | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.NUMBERCOLUMN        | Description     |
      | Columns | NCLOBCOLUMN         | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.NCLOBCOLUMN         | Description     |


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
    And user clicks on Add button near to field "Schema/Table Filters"
    And user clicks on Add button near to field "Table Filters"
    And user "enter text" in Add Data Source Page
      | fieldName  | attribute |
      | Table Name | QATest    |
    And user performs following actions in the sidebar
      | actionType | actionItem |
      | click      | Add Button |
    And user verifies "Add Button" is "disabled" in "Add Configuration pop up"


  ##6767927##
  @webtest @jdbc @MLP-9605
  Scenario:SC#5_4_Verify proper error message is shown if mandatory fields are not filled in OracleDBAnalyzer plugin configuration
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
  Scenario:SC#5_5_Verify Oracle Datasource throws error when the jdbc url is for databases other than oracle or incorrect
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


  ##7072922##
  @webtest @jdbc
  Scenario:SC#5_6_Verify proper error message is thrown in UI if Sample Data count/Top Values/Histogram Buckets values are not provided within valid range in OracleDBAnalyzer
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


  @sanity @positive @regression
  Scenario:SC#5_7_Delete Cluster and OracleDBCataloger  Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                         | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithFilters% | Analysis |       |       |


  @webtest
  Scenario:SC#6_1_Verify the Dry run feature for the OracleDB Cataloger
    Given user "update" the json file "ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleCataloger_DryRun.json" file for following values
      | jsonPath  | jsonValues | type    |
      | $..dryRun | true       | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                              | response code | response message | jsonPath                                                    |
      | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json       | 204           |                  |                                                             |
      |                  |       |       | Get          | settings/analyzers/OracleDBDataSource                               |                                                                   | 200           |                  | Oracle12cCDBDS                                              |
      |                  |       |       | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleCataloger_DryRun.json | 204           |                  |                                                             |
      |                  |       |       | Get          | settings/analyzers/OracleDBCataloger                                |                                                                   | 200           |                  | OracleCataloger_DryRun                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OracleCataloger_DryRun')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                  | 200           |                  |                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OracleCataloger_DryRun')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc12cCDBCataloger" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OracleDBCataloger/OracleCataloger_DryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "cataloger/OracleDBCataloger/OracleCataloger_DryRun%" should display below info/error/warning
      | type | logValue                                                                                     | logCode       | pluginName        | removableText |
      | INFO | Plugin OracleDBCataloger running on dry run mode                                             | ANALYSIS-0069 | OracleDBCataloger |               |
      | INFO | Plugin OracleDBCataloger processed 0 items on dry run mode and not written to the repository | ANALYSIS-0070 | OracleDBCataloger |               |
      | INFO | Plugin completed                                                                             | ANALYSIS-0020 |                   |               |


  @webtest
  Scenario:SC#6_2_Verify the Dry run feature for the OracleDB Analyzer
    Given user "update" the json file "ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleAnalyzer_DryRun.json" file for following values
      | jsonPath  | jsonValues | type    |
      | $..dryRun | true       | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                   | body                                                             | response code | response message | jsonPath                                                   |
      | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleAnalyzer_DryRun.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                  | 200           |                  | OracleAnalyzer_DryRun                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='OracleAnalyzer_DryRun')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                 | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='OracleAnalyzer_DryRun')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "OracleDBAnalyzer" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/OracleDBAnalyzer/OracleAnalyzer_DryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "dataanalyzer/OracleDBAnalyzer/OracleAnalyzer_DryRun%" should display below info/error/warning
      | type | logValue                                                                                    | logCode       | pluginName       | removableText |
      | INFO | Plugin OracleDBAnalyzer running on dry run mode                                             | ANALYSIS-0069 | OracleDBAnalyzer |               |
      | INFO | Plugin OracleDBAnalyzer processed 0 items on dry run mode and not written to the repository | ANALYSIS-0070 | OracleDBAnalyzer |               |
      | INFO | Plugin completed                                                                            | ANALYSIS-0020 |                  |               |


  @sanity @positive @regression
  Scenario:SC#6_4_Delete Cluster and OracleDBCataloger,OracleDBAnalyzer and OracleDBPostProcessor  Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                      | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/OracleDBCataloger/OracleCataloger_DryRun%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzer_DryRun% | Analysis |       |       |


    ##6477896##
  Scenario Outline:SC#7_1_Run the Plugin configurations for wrong driver bundle name the Oracle12CDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                              | response code | response message                   | jsonPath                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSourceWithWrongBundleName.json                    | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                   | 200           | Oracle12cCDBDSwrongBundleName      |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithWrongBundleName.json | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                   | 200           | OracleCatalogerWithWrongBundleName |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                   | 200           | IDLE                               | $.[?(@.configurationName=='OracleCatalogerWithWrongBundleName')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                  | 200           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                   | 200           | IDLE                               | $.[?(@.configurationName=='OracleCatalogerWithWrongBundleName')].status |


  ##6477896##
  @webtest @jdbc
  Scenario:SC#7_2_Verify Oracle cataloger does not collect any DB items and log throws error when the driver bundle name is for databases other than oracle
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OracleDBCataloger/OracleCatalogerWithWrongBundleName%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 2             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/OracleDBCataloger/OracleCatalogerWithWrongBundleName%" should display below info/error/warning
      | type  | logValue                                                          | logCode            | pluginName        | removableText |
      | INFO  | Plugin started                                                    | ANALYSIS-0019      |                   |               |
      | ERROR | No Driver class returned: Bundle org.postgresql.jdbc42 not found? | ANALYSIS-JDBC-0002 | OracleDBCataloger |               |
      | ERROR | No JDBC connection could be established                           | ANALYSIS-JDBC-0003 | OracleDBCataloger |               |


  @sanity @positive @regression
  Scenario:SC#7_3_Delete OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                            | type     | query | param |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithWrongBundleName% | Analysis |       |       |


  Scenario Outline:SC#8_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                              | response code | response message                   | jsonPath                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSourceWithWrongDriverName.json                    | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                   | 200           | Oracle12cCDBDSwrongDriverName      |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithWrongDriverName.json | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                   | 200           | OracleCatalogerWithWrongDriverName |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                   | 200           | IDLE                               | $.[?(@.configurationName=='OracleCatalogerWithWrongDriverName')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                  | 200           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                   | 200           | IDLE                               | $.[?(@.configurationName=='OracleCatalogerWithWrongDriverName')].status |


  ##6477896##
  @webtest @jdbc
  Scenario:SC#8_2_Verify Oracle cataloger does not collect any DB items and log throws error when the driver name is for databases other than oracle
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OracleDBCataloger/OracleCatalogerWithWrongDriverName%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 2             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
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


  Scenario Outline:SC#9_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                 | response code | response message                      | jsonPath                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSourceWithWrongDriverVersion.json                    | 204           |                                       |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                      | 200           | Oracle12cCDBDSwrongDriverVersion      |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithWrongDriverVersion.json | 204           |                                       |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                      | 200           | OracleCatalogerWithWrongDriverVersion |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                      | 200           | IDLE                                  | $.[?(@.configurationName=='OracleCatalogerWithWrongDriverVersion')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                     | 200           |                                       |                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                      | 200           | IDLE                                  | $.[?(@.configurationName=='OracleCatalogerWithWrongDriverVersion')].status |


  ##6477896##
  @webtest @jdbc
  Scenario:SC#9_2_Verify Oracle cataloger does not collect any DB items and log throws error when the driver version is for databases other than oracle
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OracleDBCataloger/OracleCatalogerWithWrongDriverVersion%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 2             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
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


  Scenario Outline:SC#10_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger in Internal Node
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                    | body                                                                                             | response code | response message              | jsonPath                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSourceInternalNode.json                          | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                  |                                                                                                  | 200           | Oracle12cCDBDSInternalNode    |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                   | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerInternalNodeConfig.json | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                   |                                                                                                  | 200           | OracleCatalogerInInternalNode |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/OracleDBCataloger/* |                                                                                                  | 200           | IDLE                          | $.[?(@.configurationName=='OracleCatalogerInInternalNode')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                 | 200           |                               |                                                                    |
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
      | Schema    | 8     |


  Scenario Outline:SC#11_1_Run the Plugin configurations for Analyzer for Oracle12CDB in InternalNode
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                      | body                                                                                            | response code | response message             | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                      | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleAnalyzerInternalNodeConfig.json | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                      |                                                                                                 | 200           | OracleAnalyzerInInternalNode |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                 | 200           | IDLE                         | $.[?(@.configurationName=='OracleAnalyzerInInternalNode')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                 | 200           | IDLE                         | $.[?(@.configurationName=='OracleAnalyzerInInternalNode')].status |


  #6767928##
  @webtest @MLP-9605
  Scenario:SC#11_2_Verify OracleDBAnalyzer scans and collects data properly if the node condition is given
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE_TAG_DETAILS" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FULL_NAME" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |


  @sanity @positive @regression
  Scenario:SC#11_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                        | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                             | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerInInternalNode%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerInInternalNode% | Analysis |       |       |


  Scenario Outline:SC#12_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                       | response code | response message            | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                                | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                            | 200           | Oracle12cCDBDS              |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithNoFilter.json | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                            | 200           | OracleCatalogerWithNoFilter |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                            | 200           | IDLE                        | $.[?(@.configurationName=='OracleCatalogerWithNoFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                           | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                            | 200           | IDLE                        | $.[?(@.configurationName=='OracleCatalogerWithNoFilter')].status |


  ##6767907## ##6204189##
  @webtest @jdbc @MLP-9602 @MLP-6281
  Scenario:SC#12_2_Verify OracleDatabaseCataloger collects DB items like Cluster, Service, Database, Schema,Table, Columns,Constraints,Index,Routine,Views,Triggers when the OracleDatabaseCataloger is run.(No filters)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Cluster   | 1     |
    And user performs "item click" on "DIDORACLE01V.DID.DEV.ASGINT.LOC" item from search results
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Service   | 1     |
    And user performs "item click" on "ORACLE:1521" item from search results
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORCA12C.DID.DEV.ASGINT.LOC" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                       | widgetName  |
      | Storage type      | Oracle Oracle Database 12c Enterprise Edition Release 12.2.0.1.0 - 64bit Production | Description |
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | OCPPVT               | verify widget contains | No               |             |
      | Tables | OCPPV2T              | verify widget contains | No               |             |
      | Tables | OCPPVIEW             | verify widget contains | No               |             |
      | Tables | ORACLE_TAG_DETAILS   | verify widget contains | No               |             |
      | Tables | ORACLE_DIFFDATATYPES | verify widget contains | No               |             |
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType  | count |
      | Table      | 26    |
      | Constraint | 10    |
    And user enters the search text "ORACLE_DIFFDATATYPES" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 21    |
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Index     | 10    |
      | Routine   | 4     |
      | Trigger   | 1     |


  @webtest @jdbc
  Scenario:SC#12_3_Verify OracleDB cataloger scans and collects data if schema name and table names are not provided in filters and Log enhancement and the Processed Items are Verified
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc12cCDBCataloger" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType      | count |
      | Synonym        | 6207  |
      | Column         | 830   |
      | UserRole       | 89    |
      | Constraint     | 107   |
      | Index          | 74    |
      | Table          | 166   |
      | User           | 50    |
      | Sequence       | 9     |
      | Routine        | 8     |
      | DataField      | 3     |
      | IndexExtension | 2     |
      | Schema         | 9     |
      | Partition      | 8     |
      | Tablespace     | 5     |
      | Trigger        | 5     |
      | File           | 4     |
      | Cluster        | 1     |
      | Configuration  | 1     |
      | Database       | 1     |
      | DatabaseLink   | 2     |
      | Service        | 1     |
    And user enters the search text "Orc12cCDBCataloger" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value              | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_TAG_DETAILS | verify widget contains | No               |             |
      | Tables | ORACLE_TAG_DETAILS | click and switch tab   | No               |             |
    And user enters the search text "OracleDBCataloger" and clicks on search
    And user performs "facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OracleDBCataloger/OracleCatalogerWithNoFilter%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | DIDORACLE01V.DID.DEV.ASGINT.LOC |
      | ORACLE:1521                     |


  ##6767909##
  @webtest @jdbc @MLP-9602
  Scenario:SC#12_4_Verify the technology tags got assigned to all Oracle DB items like Cluster,Service,Database...etc
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Orc12cCDBCataloger,Oracle,Oracle12C_CDB_Cat" should get displayed for the column "cataloger/OracleDBCataloger"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name          | facet         | Tag                                         | fileName                           | userTag            |
      | Default     | Synonym       | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | V$MAP_SUBELEMENT                   | Oracle             |
      | Default     | Schema        | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | PUBLIC                             | Orc12cCDBCataloger |
      | Default     | Service       | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | ORACLE:1521                        | Orc12cCDBCataloger |
      | Default     | Database      | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | ORCA12C.DID.DEV.ASGINT.LOC         | Orc12cCDBCataloger |
      | Default     | Column        | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | DOB2                               | Orc12cCDBCataloger |
      | Default     | Table         | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | ORACLE_TAG_DETAILS                 | Orc12cCDBCataloger |
      | Default     | Index         | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | PRIMARY_PK                         | Orc12cCDBCataloger |
      | Default     | UserRole      | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | EM_EXPRESS_ALL                     | Orc12cCDBCataloger |
      | Default     | User          | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | REMOTE_SCHEDULER_AGENT             | Orc12cCDBCataloger |
      | Default     | Constraint    | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | PRIMARY_PK                         | Orc12cCDBCataloger |
      | Default     | Routine       | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | PROT2T                             | Orc12cCDBCataloger |
      | Default     | Trigger       | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | TRIGGER1                           | Orc12cCDBCataloger |
      | Default     | File          | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | C:\APP\ORADATA\ORCA12C\USERS01.DBF | Orc12cCDBCataloger |
      | Default     | DatabaseLink  | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | DBMS_CLRDBLINK                     | Orc12cCDBCataloger |
      | Default     | Sequence      | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | EMPLOYEES_SEQ                      | Orc12cCDBCataloger |
      | Default     | Tablespace    | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | SYSTEM                             | Orc12cCDBCataloger |
      | Default     | Cluster       | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | DIDORACLE01V.DID.DEV.ASGINT.LOC    | Orc12cCDBCataloger |
      | Default     | Configuration | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat | init.ora                           | Orc12cCDBCataloger |


  Scenario Outline:SC#13_1_Run the Plugin configurations for Analyzer in Oracle12CDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                          | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleAnalyzer.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                               | 200           | OracleAnalyzer   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='OracleAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                              | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='OracleAnalyzer')].status |


  ##6767929##
  @webtest @jdbc @MLP-9605
  Scenario:SC#13_2_Verify the Technology tag appears properly analysis item added by OracleDBAnalyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Orc12cCDBCataloger,Oracle,Oracle12C_CDB_Cat" should get displayed for the column "cataloger/OracleDBCataloger"
    Then the following tags "Orc12cCDBAnalyzer,Oracle,Oracle12C_CDB_AY," should get displayed for the column "dataanalyzer/OracleDBAnalyzer"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name   | facet         | Tag                                                                            | fileName           | userTag |
      | Default     | Column | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_AY,Oracle12C_CDB_Cat,Orc12cCDBAnalyzer | REGION_ID          | Oracle  |
      | Default     | Table  | Metadata Type | Oracle,Orc12cCDBCataloger,Oracle12C_CDB_AY,Oracle12C_CDB_Cat,Orc12cCDBAnalyzer | ORACLE_PERSON_INFO | Oracle  |


  @webtest @jdbc @MLP-5358
  Scenario:SC#13_3_verify the Created Table Name in oracleDB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TRIGGERTEST" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TRIGGERTEST" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
      | Number of rows    | 1             | Statistics  |


  ##6767920## ##7072924##
  @webtest @jdbc @MLP-5358 @MLP-9605
  Scenario:SC#13_4_Verify the Column with datatype varchar in Oracle DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "FULL_NAME" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FULL_NAME" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
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
    And user enters the search text "OCPPDSVT" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "OCPPDSVT [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OCPPDSVT" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | GRADE | click and switch tab | No               |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 5             | Statistics  |
      | Maximum value                 | three         | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | five          | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |



  ##6767921## ##7072924##
  @webtest @jdbc @MLP-5358 @MLP-9605
  Scenario:SC#13_5_Verify the Column with datatype decimal in Oracle DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLEDB_SALARY" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLEDB_SALARY" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 95.72         | Statistics  |
      | Length                        | 22            | Statistics  |
      | Median                        | 95.72         | Statistics  |
      | Maximum value                 | 100.9         | Statistics  |
      | Variance                      | 53.56         | Statistics  |
      | Minimum value                 | 90.55         | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 50            | Statistics  |
      | Number of null values         | 2             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | Standard deviation            | 7.32          | Statistics  |
    And user enters the search text "OCPPDSVT" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "OCPPDSVT [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OCPPDSVT" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value  | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ROLLNO | click and switch tab | No               |             |          |          |                 |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 150           | Statistics  |
      | Length                        | 0             | Statistics  |
      | Median                        | 150           | Statistics  |
      | Maximum value                 | 200           | Statistics  |
      | Variance                      | 5000          | Statistics  |
      | Minimum value                 | 100           | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 70.71         | Statistics  |


  ##6767922## ##7072924##
  @webtest @jdbc @MLP-5358 @MLP-9605
  Scenario:SC#13_6_Verify the Column with datatype timestamp in Oracle DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLEDB_LOCALTIME" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLEDB_LOCALTIME" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2020-05-07 04:21:58 | Statistics  |
      | Minimum value                 | 2020-05-07 04:21:52 | Statistics  |
      | Number of non null values     | 4                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 4                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user enters the search text "ORACLE_VIEW" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_VIEW" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | DOB   | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |


  ##6767919## ##7072924##
  @webtest @jdbc @MLP-6064 @MLP-9605
  Scenario:SC#13_7_Verify the data sampling information in OracleDB
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE_TAG_DETAILS" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_TAG_DETAILS" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GENDER | FULL_NAME      | EMAIL            | STATE | PHONE_NUMBER | EMPLOYEE_ID | POSTAL_CODE | ORACLEDB_SALARY | JOINING_DATE        | SSN         | IP_ADDRESS    |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       | 100.9           | 2013-05-08 17:02:07 | 345-53-3222 | 255.249.255.0 |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       | 90.55           | 2015-08-05 14:05:07 | 345-53-3779 | 255.249.12.0  |
      | m      | Lionel Messi   | lmessi@gmail.com | NY    | 515.123.6666 | 12          | 78576       |                 | 2011-09-14 16:42:57 | 315-53-3222 | 255.83.45.0   |
      | f      | Irina Shayk    | ishayk@gmail.com | VI    | 515.123.2580 | 13          | 48276       |                 | 2008-11-18 17:52:47 | 345-66-3222 | 255.71.255.56 |

  ##7072924##
  @webtest @jdbc @MLP-6064 @MLP-9605
  Scenario:SC#13_8_Verify the data sampling for view information in OracleDB
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "OCPPVIEW" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OCPPVIEW" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GRADE | NAME  | ROLLNO | SCHOOLNAME |
      | five  | test1 | 100    | school1    |
      | three | test2 | 200    | school2    |


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
  @jdbc @webtest @MLP-7325
  Scenario:SC#13_10_Verify the data profiling metadata for string,numeric,date,time,timestamp datatypes metrics does not get calculated for empty table(oracle)
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE_EMPTY" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_EMPTY" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute         | widgetName |
      | Number of non null values | Statistics |
      | Maximum value             | Statistics |
      | Number of non null values | Statistics |
      | Minimum value             | Statistics |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | ID    | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Average           | Statistics |
      | Maximum value     | Statistics |
      | Median            | Statistics |
      | Minimum value     | Statistics |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | NAME  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |


  ##6767926##
  @jdbc @webtest @MLP-7325 @MLP-9605
  Scenario:SC#13_11_Verify the data profiling metadata for date,time,timestamp datatypes and should have the appropriate metadata information in IDC UI and Database(oracle)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE_TABLE" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_TABLE" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB   | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |


  @sanity @positive @regression
  Scenario:SC#13_12_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                     | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                          | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithNoFilter% | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzer%            | Analysis |       |       |


  Scenario Outline:SC#14_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                           | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                                    | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                | 200           | Oracle12cCDBDS                  |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithSchemaFilter.json | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                | 200           | OracleCatalogerWithSchemaFilter |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                               | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |


  ##6767896##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#14_2_Verify Oracle cataloger scans and collects data if schema name alone is provided in filters(Oracle DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PUBLIC [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettablesFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "retainslist" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                    | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getviewsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "retainslist" value with Postgres DB
    And user "widget presence" on "Constraints" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath             | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.ORACLE_TAG_DETAILS | Description     |
      | Tables | OCPPVIEW           | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.OCPPVIEW           | Description     |
    And user enters the search text "HR" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "C##ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "C##ORACLE12C_SCHEMA1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                        | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromC##Oracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user "widget presence" on "Tables" in Item view page
    Then user performs click and verify in new window
      | Table  | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_DIFFDATATYPES | verify widget contains | No               |             |
      | Tables | TABLE_PRIMARY        | verify widget contains | No               |             |
      | Tables | TABLE_PRIMARY        | click and switch tab   | No               |             |
    And user "section not present" on "Description" in Item view page
    And user "widget presence" on "Columns" in Item view page
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | SUPPLIER_ID | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE_DIFFDATATYPES" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "C##ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_DIFFDATATYPES" item from search results
    And user "widget presence" on "index" in Item view page
    And user "widget presence" on "linkTablespace" in Item view page
    Then user performs click and verify in new window
      | Table   | value       | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | CLOBCOLUMN  | verify widget contains | No               |             |
      | Columns | NCLOBCOLUMN | verify widget contains | No               |             |
      | Columns | BLOBCOLUMN  | verify widget contains | No               |             |
    And user enters the search text "ADMINUSER" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ADMINUSER [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ADMINUSER" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getsequenceFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                   | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getroutinesFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Routine" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Tables | COUNTRIES | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page

  @sanity @positive @regression
  Scenario:SC#14_3_Delete Cluster and OracleDBCataloger  Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                              | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter% | Analysis |       |       |


  Scenario Outline:SC#15_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                   | response code | response message                        | jsonPath                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                                            | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                        | 200           | Oracle12cCDBDS                          |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithSchemaAndTableFilter.json | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                        | 200           | OracleCatalogerWithSchemaAndTableFilter |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                       | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |



  ##6767897##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#15_2_Verify Oracle cataloger scans and collects data if schema name and table name is provided in filters(Oracle DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PUBLIC [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user "widget not present" on "Constraints" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath             | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.ORACLE_TAG_DETAILS | Description     |
      | Tables | OCPPVIEW           | click and switch tab      | Yes              | 0           |                                                             |                      |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value         | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | TABLE_PRIMARY | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "HR" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "C##ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "C##ORACLE12C_SCHEMA1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                        | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromC##Oracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user "widget presence" on "Tables" in Item view page
    Then user performs click and verify in new window
      | Table  | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_DIFFDATATYPES | verify widget contains | No               |             |
      | Tables | TABLE_PRIMARY        | verify widget contains | No               |             |
      | Tables | TABLE_PRIMARY        | click and switch tab   | No               |             |
    And user "section not present" on "Description" in Item view page
    And user "widget presence" on "Columns" in Item view page
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | SUPPLIER_ID | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE_DIFFDATATYPES" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "C##ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_DIFFDATATYPES" item from search results
    And user "widget presence" on "index" in Item view page
    And user "widget presence" on "linkTablespace" in Item view page
    Then user performs click and verify in new window
      | Table   | value       | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | CLOBCOLUMN  | verify widget contains | No               |             |
      | Columns | NCLOBCOLUMN | verify widget contains | No               |             |
      | Columns | BLOBCOLUMN  | verify widget contains | No               |             |
    And user enters the search text "ADMINUSER" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ADMINUSER [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ADMINUSER" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getsequenceFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                   | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getroutinesFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Routine" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Tables | COUNTRIES | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page


  @sanity @positive @regression
  Scenario:SC#15_3_Delete Cluster and OracleDBCataloger  Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter% | Analysis |       |       |


  Scenario Outline:SC#16_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                             | response code | response message                                  | jsonPath                                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                                                      | 204           |                                                   |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                                  | 200           | Oracle12cCDBDS                                    |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithMultipleSchemaFilterWithTables.json | 204           |                                                   |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                                  | 200           | OracleCatalogerWithMultipleSchemaFilterWithTables |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                  | 200           | IDLE                                              | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemaFilterWithTables')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                                 | 200           |                                                   |                                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                  | 200           | IDLE                                              | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemaFilterWithTables')].status |


  ##6767901##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#16_2_Verify Oracle cataloger scans and collects data if multiple schema names having tables in it are provided in filters(Oracle DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PUBLIC [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user "widget presence" on "Constraints" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath             | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.ORACLE_TAG_DETAILS | Description     |
      | Tables | OCPPVIEW           | click and switch tab      | No               | 0           |                                                             |                      |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value         | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath        | metadataSection |
      | Tables | TABLE_PRIMARY | click and verify metadata | No               |             | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.TABLE_PRIMARY | Description     |
    And user enters the search text "ORACLE12C_SCHEMA2" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA2" item from search results
    Then user performs click and verify in new window
      | Table   | value       | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath    | metadataSection |
      | Tables  | BASELINES   | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.BASELINES | Description     |
      | Tables  | BASELINES   | click and switch tab      | No               | 0           |                                                             |             |                 |
      | Columns | EMPLOYEE_ID | verify widget contains    | Yes              |             |                                                             |             |                 |
    And user enters the search text "HR" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "C##ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "C##ORACLE12C_SCHEMA1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                        | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromC##Oracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user "widget presence" on "Tables" in Item view page
    Then user performs click and verify in new window
      | Table  | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_DIFFDATATYPES | verify widget contains | No               |             |
      | Tables | TABLE_PRIMARY        | verify widget contains | No               |             |
      | Tables | TABLE_PRIMARY        | click and switch tab   | No               |             |
    And user "section not present" on "Description" in Item view page
    And user "widget presence" on "Columns" in Item view page
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | SUPPLIER_ID | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE_DIFFDATATYPES" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "C##ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_DIFFDATATYPES" item from search results
    And user "widget presence" on "index" in Item view page
    And user "widget presence" on "linkTablespace" in Item view page
    Then user performs click and verify in new window
      | Table   | value       | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | CLOBCOLUMN  | verify widget contains | No               |             |
      | Columns | NCLOBCOLUMN | verify widget contains | No               |             |
      | Columns | BLOBCOLUMN  | verify widget contains | No               |             |
    And user enters the search text "ADMINUSER" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ADMINUSER [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ADMINUSER" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getsequenceFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                   | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getroutinesFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Routine" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Tables | COUNTRIES | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page

  @sanity @positive @regression
  Scenario:SC#16_3_Delete Cluster and OracleDBCataloger  Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                           | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                                                | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemaFilterWithTables% | Analysis |       |       |


  Scenario Outline:SC#17_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                           | response code | response message                                | jsonPath                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                                                    | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                                | 200           | Oracle12cCDBDS                                  |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerwithSchemaAndMultipleTableFilter.json | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                                | 200           | OracleCatalogerwithSchemaAndMultipleTableFilter |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                | 200           | IDLE                                            | $.[?(@.configurationName=='OracleCatalogerwithSchemaAndMultipleTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                               | 200           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                | 200           | IDLE                                            | $.[?(@.configurationName=='OracleCatalogerwithSchemaAndMultipleTableFilter')].status |


  ##6767899##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#17_2_Verify Oracle cataloger scans and collects data if single schema name with multiple table names are provided in filters(Oracle DB)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PUBLIC [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user "widget presence" on "Constraints" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath             | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.ORACLE_TAG_DETAILS | Description     |
      | Tables | OCPPVIEW           | click and switch tab      | No               | 0           |                                                             |                      |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value         | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath        | metadataSection |
      | Tables | TABLE_PRIMARY | click and verify metadata | No               |             | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.TABLE_PRIMARY | Description     |
    And user enters the search text "HR" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "C##ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "C##ORACLE12C_SCHEMA1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                        | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromC##Oracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user "widget presence" on "Tables" in Item view page
    Then user performs click and verify in new window
      | Table  | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_DIFFDATATYPES | verify widget contains | No               |             |
      | Tables | TABLE_PRIMARY        | verify widget contains | No               |             |
      | Tables | TABLE_PRIMARY        | click and switch tab   | No               |             |
    And user "section not present" on "Description" in Item view page
    And user "widget presence" on "Columns" in Item view page
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | SUPPLIER_ID | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE_DIFFDATATYPES" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "C##ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_DIFFDATATYPES" item from search results
    And user "widget presence" on "index" in Item view page
    And user "widget presence" on "linkTablespace" in Item view page
    Then user performs click and verify in new window
      | Table   | value       | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | CLOBCOLUMN  | verify widget contains | No               |             |
      | Columns | NCLOBCOLUMN | verify widget contains | No               |             |
      | Columns | BLOBCOLUMN  | verify widget contains | No               |             |
    And user enters the search text "ADMINUSER" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ADMINUSER [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ADMINUSER" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getsequenceFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                   | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getroutinesFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Routine" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Tables | COUNTRIES | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page


  @sanity @positive @regression
  Scenario:SC#17_3_Delete Cluster and OracleDBCataloger  Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                         | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                                              | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerwithSchemaAndMultipleTableFilter% | Analysis |       |       |


  Scenario Outline:SC#18_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                      | response code | response message                           | jsonPath                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                                               | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                           | 200           | Oracle12cCDBDS                             |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithMultipleSchemasInFilter.json | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                           | 200           | OracleCatalogerWithMultipleSchemasInFilter |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                          | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status |


  ##6767898## ##6204182##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario:SC#18_2_Verify Oracle cataloger scans and collects data if multiple schema name alone is provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PUBLIC [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettablesFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "retainslist" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                    | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getviewsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "retainslist" value with Postgres DB
    And user "widget presence" on "Constraints" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath             | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.ORACLE_TAG_DETAILS | Description     |
      | Tables | OCPPVIEW           | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.OCPPVIEW           | Description     |
    And user enters the search text "HR" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "C##ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "C##ORACLE12C_SCHEMA1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                        | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromC##Oracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user "widget presence" on "Tables" in Item view page
    Then user performs click and verify in new window
      | Table  | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_DIFFDATATYPES | verify widget contains | No               |             |
      | Tables | TABLE_PRIMARY        | verify widget contains | No               |             |
      | Tables | TABLE_PRIMARY        | click and switch tab   | No               |             |
    And user "section not present" on "Description" in Item view page
    And user "widget presence" on "Columns" in Item view page
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | SUPPLIER_ID | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE_DIFFDATATYPES" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "C##ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_DIFFDATATYPES" item from search results
    And user "widget presence" on "index" in Item view page
    And user "widget presence" on "linkTablespace" in Item view page
    Then user performs click and verify in new window
      | Table   | value       | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | CLOBCOLUMN  | verify widget contains | No               |             |
      | Columns | NCLOBCOLUMN | verify widget contains | No               |             |
      | Columns | BLOBCOLUMN  | verify widget contains | No               |             |
    And user enters the search text "ADMINUSER" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ADMINUSER [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ADMINUSER" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getsequenceFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                   | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getroutinesFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Routine" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Tables | COUNTRIES | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA2" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA2 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA2" item from search results
    Then user performs click and verify in new window
      | Table  | value              | Action                    | RetainPrevwindow | indexSwitch | filePath                                                    | jsonPath             | metadataSection |
      | Tables | ORACLE_TAG_DETAILS | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.ORACLE_TAG_DETAILS | Description     |
      | Tables | BASELINES          | click and verify metadata | Yes              | 0           | ida/jdbcAnalyzerPayloads/Oracle12cCDB/expectedMetadata.json | $.BASELINES          | Description     |


  @sanity @positive @regression
  Scenario:SC#18_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                    | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                                         | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter% | Analysis |       |       |


  Scenario Outline:SC#19_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                              | response code | response message                                   | jsonPath                                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                                                       | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                                   | 200           | Oracle12cCDBDS                                     |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerwithNonExistingSchemaAndTableFilter.json | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                                   | 200           | OracleCatalogerwithNonExistingSchemaAndTableFilter |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerwithNonExistingSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                                  | 200           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerwithNonExistingSchemaAndTableFilter')].status |


  ##6767902## ##6204212##
  @webtest @jdbc @MLP-6281 @MLP-9602 @MLP-13938
  Scenario:SC#19_2_Verify Oracle cataloger scans and collects data if non existing schema name and table name are provided in filters(Oracle DB)
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PUBLIC" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PUBLIC [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PUBLIC" item from search results
    Then user performs click and verify in new window
      | Table       | value          | Action                 | RetainPrevwindow | indexSwitch |
      | has_Synonym | ALL_ALL_TABLES | verify widget contains | No               |             |
    And user "widget presence" on "has_Synonym" in Item view page
    And user "widget not present" on "Tables" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user "widget not present" on "Constraints" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                       | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getroutinesFromOracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Routine" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table   | value              | Action                 | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | ORACLE_PERSON_INFO | click and switch tab   | No               |             |          |          |                 |
      | Columns | PERSON_ID          | verify widget contains |                  |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | OCPPVIEW | click and switch tab | No               | 0           |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table   | value                    | Action                 | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | ORACLE_DIFFDATATYPES     | click and switch tab   | No               |             |          |          |                 |
      | Columns | BLOBCOLUMN               | verify widget contains |                  |             |          |          |                 |
      | Columns | CLOBCOLUMN               | verify widget contains |                  |             |          |          |                 |
      | Columns | NCLOBCOLUMN              | verify widget contains |                  |             |          |          |                 |
      | index   | SYS_IL0000181940C00015$$ | verify widget contains |                  |             |          |          |                 |
      | index   | SYS_IL0000181940C00016$$ | verify widget contains |                  |             |          |          |                 |
      | index   | SYS_IL0000181940C00017$$ | verify widget contains |                  |             |          |          |                 |
    And user enters the search text "HR" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettablesFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getsequenceFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField            | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField              | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromHRSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables | COUNTRIES | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |          |          |                 |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "C##ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "C##ORACLE12C_SCHEMA1" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                        | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromC##Oracle12c_Schema1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user "widget presence" on "Tables" in Item view page
    Then user performs click and verify in new window
      | Table  | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_DIFFDATATYPES | verify widget contains | No               |             |
      | Tables | TABLE_PRIMARY        | verify widget contains | No               |             |
      | Tables | TABLE_PRIMARY        | click and switch tab   | No               |             |
    And user "section not present" on "Description" in Item view page
    And user "widget presence" on "Columns" in Item view page
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | SUPPLIER_ID | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page
    And user enters the search text "ORACLE_DIFFDATATYPES" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "C##ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_DIFFDATATYPES" item from search results
    And user "widget presence" on "index" in Item view page
    And user "widget presence" on "linkTablespace" in Item view page
    Then user performs click and verify in new window
      | Table   | value       | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | CLOBCOLUMN  | verify widget contains | No               |             |
      | Columns | NCLOBCOLUMN | verify widget contains | No               |             |
      | Columns | BLOBCOLUMN  | verify widget contains | No               |             |
    And user enters the search text "ADMINUSER" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ADMINUSER [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ADMINUSER" item from search results
    And user "widget presence" on "Tables" in Item view page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getsequenceFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Sequence" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                   | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getindexsFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Index" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | gettriggersFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Trigger" Item view page result "list" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage           | queryField                     | columnName | queryOperation   | storeResults  |
      | oracle12c_cdb | STRUCTURED   | json/IDA.json | oracle12cCDBQueries | getroutinesFromADMINUSERSchema | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "has_Routine" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Tables | COUNTRIES | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | COUNTRY_ID | click and switch tab | No               |             |
    And user "section not present" on "Description" in Item view page


  @sanity @positive @regression
  Scenario:SC#19_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                                                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerwithNonExistingSchemaAndTableFilter% | Analysis |       |       |


  Scenario Outline:SC#20_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                                   | response code | response message                        | jsonPath                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                                            | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                                        | 200           | Oracle12cCDBDS                          |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithIncorrectCredentials.json | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                                        | 200           | OracleCatalogerWithIncorrectCredentials |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithIncorrectCredentials')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                       | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithIncorrectCredentials')].status |


  ##6767905##
  @webtest @jdbc @MLP-6942 @MLP-9602
  Scenario:SC#20_2_Verify the error message when Configuration credentials are incorrect
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectCredentials%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectCredentials%" should display below info/error/warning
      | type  | logValue                                                                                                                                                                                                     | logCode            | pluginName        | removableText |
      | INFO  | Plugin started                                                                                                                                                                                               | ANALYSIS-0019      |                   |               |
      | ERROR | Plugin OracleDBCataloger reported failure: {"errors":[{"timestamp":"","message":"ANALYSIS-ORACLEDB-0008: OracleDB datasource failed : ORA-01017: invalid username/password; logon denied","cleared":false}]} | ANALYSIS-JDBC-0067 | OracleDBCataloger |               |
      | ERROR | No JDBC connection could be established                                                                                                                                                                      | ANALYSIS-JDBC-0003 | OracleDBCataloger |               |

  @sanity @positive @regression
  Scenario:SC#20_3_Delete Cluster and OracleDBCataloger Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectCredentials% | Analysis |       |       |


  Scenario Outline:SC#21_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                  | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSourceWithWrongDBinURL.json           | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                       | 200           | Oracle12cCDBDSwrongDB  |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWrongDB.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                       | 200           | OracleCatalogerWrongDB |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='OracleCatalogerWrongDB')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='OracleCatalogerWrongDB')].status |


  ##6767904##
  @webtest @jdbc @MLP-9602
  Scenario:SC#21_2_Verify OracleDatabaseCataloger does not scans and collects and any data if database passed in URL is incorrect
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OracleDBCataloger/OracleCatalogerWrongDB%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
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


  Scenario Outline:SC#22_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                                    | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                               | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSourceWrongHost.json                    | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                               |                                                                                         | 200           | Oracle12cCDBDSwrongHost  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWrongHost.json | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                |                                                                                         | 200           | OracleCatalogerWrongHost |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='OracleCatalogerWrongHost')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                        | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/* |                                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='OracleCatalogerWrongHost')].status |


  @webtest @jdbc @MLP-6948
  Scenario:SC#22_2_Verify the error message when Configuration url is incorrect
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OracleDBCataloger/OracleCatalogerWrongHost%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
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


  Scenario Outline:SC#23_1_Run the Plugin configurations for DataSource and run the Oracle12CDB Cataloger and Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                   | response code | response message                        | jsonPath                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                                            | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                        | 200           | Oracle12cCDBDS                          |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithSchemaAndTableFilter.json | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                        | 200           | OracleCatalogerWithSchemaAndTableFilter |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                       | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleAnalyzerWithMinSampleDataCount.json    | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                        | 200           | OracleAnalyzerWithMinSampleDataCount    |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzerWithMinSampleDataCount')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                       | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                        | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzerWithMinSampleDataCount')].status    |



  ##6767931##
  @webtest @jdbc @MLP-9605
  Scenario:SC#23_2_Verify OracleDbAnalyzer does data sampling when sampling count is varied.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE_TAG_DETAILS" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_TAG_DETAILS" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GENDER | FULL_NAME      | EMAIL            | STATE | PHONE_NUMBER | EMPLOYEE_ID | POSTAL_CODE | ORACLEDB_SALARY | JOINING_DATE        | SSN         | IP_ADDRESS    |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       | 100.9           | 2013-05-08 17:02:07 | 345-53-3222 | 255.249.255.0 |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       | 90.55           | 2015-08-05 14:05:07 | 345-53-3779 | 255.249.12.0  |


  ##6767933##
  @webtest @MLP-13938
  Scenario:SC#23_3_Verify OracleDbAnalyzer does data sampling,data profiling and pattern matching properly when analyzer is run on the cataloged item which has filters.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE_TAG_DETAILS" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_TAG_DETAILS" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch |
      | Columns | ORACLEDB_LOCALTIME | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute           | widgetName |
      | Last catalogued at          | Lifecycle  |
      | Last analyzed at            | Lifecycle  |
      | Maximum value               | Statistics |
      | Minimum value               | Statistics |
      | Number of unique values     | Statistics |
      | Percentage of unique values | Statistics |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIMESTAMP     | Description |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of unique values       | 4             | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table  | value              | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_TAG_DETAILS | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName  |
      | Table Type         | Description |
      | Last catalogued at | Lifecycle   |
      | Last analyzed at   | Lifecycle   |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | EMAIL | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |


  @sanity @positive @regression
  Scenario:SC#23_4_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter% | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMinSampleDataCount%  | Analysis |       |       |


  @jdbc
  Scenario Outline:SC#26_1_Run the OracleDB Cataloger and Oracle Analyzer with Schema Filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                      | response code | response message                           | jsonPath                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                                               | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                           | 200           | Oracle12cCDBDS                             |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithMultipleSchemasInFilter.json | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                           | 200           | OracleCatalogerWithMultipleSchemasInFilter |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                          | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleAnalyzerWithSchemaFilter.json             | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                           | 200           | OracleAnalyzerWithSchemaFilter             |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleAnalyzerWithSchemaFilter')].status             |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                          | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                           | 200           | IDLE                                       | $.[?(@.configurationName=='OracleAnalyzerWithSchemaFilter')].status             |


  ##7072909## ##7072910##
  @webtest
  Scenario:SC#26_2_Verify Datasampling for Table and View after running the Oracle Analyzer with SchemaFilter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value              | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_TAG_DETAILS | click and switch tab | Yes              |             |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GENDER | FULL_NAME      | EMAIL            | STATE | PHONE_NUMBER | EMPLOYEE_ID | POSTAL_CODE | ORACLEDB_SALARY | JOINING_DATE        | SSN         | IP_ADDRESS    |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       | 100.9           | 2013-05-08 17:02:07 | 345-53-3222 | 255.249.255.0 |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       | 90.55           | 2015-08-05 14:05:07 | 345-53-3779 | 255.249.12.0  |
      | m      | Lionel Messi   | lmessi@gmail.com | NY    | 515.123.6666 | 12          | 78576       |                 | 2011-09-14 16:42:57 | 315-53-3222 | 255.83.45.0   |
      | f      | Irina Shayk    | ishayk@gmail.com | VI    | 515.123.2580 | 13          | 48276       |                 | 2008-11-18 17:52:47 | 345-66-3222 | 255.71.255.56 |
    And user "navigatesToTab" name "Overview" in item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Tables | OCPPVIEW | click and switch tab | No               |             |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GRADE | NAME  | ROLLNO | SCHOOLNAME |
      | five  | test1 | 100    | school1    |
      | three | test2 | 200    | school2    |
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA2" item from search results
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Tables | BASELINES | click and switch tab | Yes              |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_VIEW2 | click and switch tab | No               |             |
    And user "widget not present" on "dataSamples" in Item view page


  ##7072911## ##7072912##
  @webtest
  Scenario:SC#26_3_Verify data profiling (decimal, varchar and TimeStamp) for Table and View after running the Oracle Analyzer with SchemaFilter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE12C_SCHEMA1" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value              | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_TAG_DETAILS | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | FULL_NAME | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
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
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value           | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ORACLEDB_SALARY | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 95.72         | Statistics  |
      | Length                        | 22            | Statistics  |
      | Median                        | 95.72         | Statistics  |
      | Maximum value                 | 100.9         | Statistics  |
      | Variance                      | 53.56         | Statistics  |
      | Minimum value                 | 90.55         | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 50            | Statistics  |
      | Number of null values         | 2             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | Standard deviation            | 7.32          | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ORACLEDB_LOCALTIME | click and switch tab | No               |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2020-05-07 04:21:58 | Statistics  |
      | Minimum value                 | 2020-05-07 04:21:52 | Statistics  |
      | Number of non null values     | 4                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 4                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | ORACLE_TABLE | click and switch tab | Yes              |             |
      | Columns | DOB          | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | OCPPDSVT | click and switch tab | Yes              |             |          |          |                 |
      | Columns | GRADE    | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 5             | Statistics  |
      | Maximum value                 | three         | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | five          | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value  | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ROLLNO | click and switch tab | No               |             |          |          |                 |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 150           | Statistics  |
      | Length                        | 0             | Statistics  |
      | Median                        | 150           | Statistics  |
      | Maximum value                 | 200           | Statistics  |
      | Variance                      | 5000          | Statistics  |
      | Minimum value                 | 100           | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 70.71         | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | ORACLE_VIEW | click and switch tab | Yes              |             |          |          |                 |
      | Columns | DOB         | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA2" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | BASELINES | click and switch tab | Yes              |             |
      | Columns | EMAIL     | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | ORACLE_VIEW2 | click and switch tab | No               |             |
      | Columns | DOB          | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |

  @sanity @positive @regression
  Scenario:SC#26_4_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                    | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                                         | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter% | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithSchemaFilter%           | Analysis |       |       |


  @jdbc
  Scenario Outline:SC#27_1_Run the OracleDB Cataloger and Oracle Analyzer with Schema and Table Filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                  | response code | response message                       | jsonPath                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                                           | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                       | 200           | Oracle12cCDBDS                         |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithSchemaFilter.json        | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                       | 200           | OracleCatalogerWithSchemaFilter        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                       | 200           | IDLE                                   | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                      | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                       | 200           | IDLE                                   | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleAnalyzerWithSchemaAndTableFilter.json | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                       | 200           | OracleAnalyzerWithSchemaAndTableFilter |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                       | 200           | IDLE                                   | $.[?(@.configurationName=='OracleAnalyzerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                      | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                       | 200           | IDLE                                   | $.[?(@.configurationName=='OracleAnalyzerWithSchemaAndTableFilter')].status |


  ##7072917##
  @webtest
  Scenario:SC#27_2_Verify data sampling and data profiling (Varchar, Decimal and TimeStamp) for a Table when OracleDBAnalyzer run with Schema and Table Filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value              | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_TAG_DETAILS | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GENDER | FULL_NAME      | EMAIL            | STATE | PHONE_NUMBER | EMPLOYEE_ID | POSTAL_CODE | ORACLEDB_SALARY | JOINING_DATE        | SSN         | IP_ADDRESS    |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       | 100.9           | 2013-05-08 17:02:07 | 345-53-3222 | 255.249.255.0 |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       | 90.55           | 2015-08-05 14:05:07 | 345-53-3779 | 255.249.12.0  |
      | m      | Lionel Messi   | lmessi@gmail.com | NY    | 515.123.6666 | 12          | 78576       |                 | 2011-09-14 16:42:57 | 315-53-3222 | 255.83.45.0   |
      | f      | Irina Shayk    | ishayk@gmail.com | VI    | 515.123.2580 | 13          | 48276       |                 | 2008-11-18 17:52:47 | 345-66-3222 | 255.71.255.56 |
    And user "navigatesToTab" name "Overview" in item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value       | Action               | RetainPrevwindow | indexSwitch |
      | Tables | TRIGGERTEST | click and switch tab | Yes              |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value              | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_TAG_DETAILS | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | FULL_NAME | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
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
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value           | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ORACLEDB_SALARY | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 95.72         | Statistics  |
      | Length                        | 22            | Statistics  |
      | Median                        | 95.72         | Statistics  |
      | Maximum value                 | 100.9         | Statistics  |
      | Variance                      | 53.56         | Statistics  |
      | Minimum value                 | 90.55         | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 50            | Statistics  |
      | Number of null values         | 2             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | Standard deviation            | 7.32          | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ORACLEDB_LOCALTIME | click and switch tab | No               |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2020-05-07 04:21:58 | Statistics  |
      | Minimum value                 | 2020-05-07 04:21:52 | Statistics  |
      | Number of non null values     | 4                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 4                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | ORACLE_TABLE | click and switch tab | Yes              |             |
      | Columns | DOB          | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | TRIGGERTEST | click and switch tab | No               |             |
      | Columns | IDADDRESS   | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |


  ##7072919##
  @webtest
  Scenario:SC#27_3_Verify data sampling and data profiling (Varchar, Decimal and TimeStamp) for a View when OracleDBAnalyzer run with Schema and Table Filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Tables | OCPPVIEW | click and switch tab | Yes              |             |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GRADE | NAME  | ROLLNO | SCHOOLNAME |
      | five  | test1 | 100    | school1    |
      | three | test2 | 200    | school2    |
    And user "navigatesToTab" name "Overview" in item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Tables | OCPPDSVT | click and switch tab | Yes              |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | OCPPVIEW | click and switch tab | Yes              |             |          |          |                 |
      | Columns | GRADE    | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 5             | Statistics  |
      | Maximum value                 | three         | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | five          | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value  | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ROLLNO | click and switch tab | No               |             |          |          |                 |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 150           | Statistics  |
      | Length                        | 0             | Statistics  |
      | Median                        | 150           | Statistics  |
      | Maximum value                 | 200           | Statistics  |
      | Variance                      | 5000          | Statistics  |
      | Minimum value                 | 100           | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 70.71         | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | ORACLE_VIEW | click and switch tab | Yes              |             |          |          |                 |
      | Columns | DOB         | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | OCPPDSVT | click and switch tab | No               |             |
      | Columns | GRADE    | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |

  @sanity @positive @regression
  Scenario:SC#27_4_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                  | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                                       | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter%          | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithSchemaAndTableFilter% | Analysis |       |       |


  @jdbc
  Scenario Outline:SC#28_1_Run the OracleDB Cataloger and Oracle Analyzer with Multiple Schema and Table Filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                          | response code | response message                               | jsonPath                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                                                   | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                               | 200           | Oracle12cCDBDS                                 |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithMultipleSchemasInFilter.json     | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                               | 200           | OracleCatalogerWithMultipleSchemasInFilter     |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                              | 200           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleAnalyzerWithMultipleSchemaAndTableFilter.json | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                               | 200           | OracleAnalyzerWithMultipleSchemaAndTableFilter |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleAnalyzerWithMultipleSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                              | 200           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleAnalyzerWithMultipleSchemaAndTableFilter')].status |


  ##7072918##
  @webtest
  Scenario:SC#28_2_Verify data sampling and data profiling (Varchar, Decimal and TimeStamp) for a Table when OracleDBAnalyzer run with Multiple Schema and Table Filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value              | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_TAG_DETAILS | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GENDER | FULL_NAME      | EMAIL            | STATE | PHONE_NUMBER | EMPLOYEE_ID | POSTAL_CODE | ORACLEDB_SALARY | JOINING_DATE        | SSN         | IP_ADDRESS    |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       | 100.9           | 2013-05-08 17:02:07 | 345-53-3222 | 255.249.255.0 |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       | 90.55           | 2015-08-05 14:05:07 | 345-53-3779 | 255.249.12.0  |
      | m      | Lionel Messi   | lmessi@gmail.com | NY    | 515.123.6666 | 12          | 78576       |                 | 2011-09-14 16:42:57 | 315-53-3222 | 255.83.45.0   |
      | f      | Irina Shayk    | ishayk@gmail.com | VI    | 515.123.2580 | 13          | 48276       |                 | 2008-11-18 17:52:47 | 345-66-3222 | 255.71.255.56 |
    And user "navigatesToTab" name "Overview" in item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value       | Action               | RetainPrevwindow | indexSwitch |
      | Tables | TRIGGERTEST | click and switch tab | No               |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA2" item from search results
    Then user performs click and verify in new window
      | Table  | value         | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_TABLE2 | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | DOB                   | DOB2                  | DOB3                    | DOB4                    | ID  | NAME       |
      | 2005-10-20 00:00:00.0 | 2005-05-01 06:14:00.0 | 2005-05-01 00:44:00.742 | 2005-07-01 03:44:00.742 | 200 | Test Name2 |
    And user "navigatesToTab" name "Overview" in item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value     | Action               | RetainPrevwindow | indexSwitch |
      | Tables | BASELINES | click and switch tab | No               |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value              | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_TAG_DETAILS | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | FULL_NAME | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
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
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value           | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ORACLEDB_SALARY | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 95.72         | Statistics  |
      | Length                        | 22            | Statistics  |
      | Median                        | 95.72         | Statistics  |
      | Maximum value                 | 100.9         | Statistics  |
      | Variance                      | 53.56         | Statistics  |
      | Minimum value                 | 90.55         | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 50            | Statistics  |
      | Number of null values         | 2             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | Standard deviation            | 7.32          | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ORACLEDB_LOCALTIME | click and switch tab | No               |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2020-05-07 04:21:58 | Statistics  |
      | Minimum value                 | 2020-05-07 04:21:52 | Statistics  |
      | Number of non null values     | 4                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 4                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | ORACLE_TABLE | click and switch tab | Yes              |             |
      | Columns | DOB          | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | TRIGGERTEST | click and switch tab | No               |             |
      | Columns | IDADDRESS   | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA2" item from search results
    Then user performs click and verify in new window
      | Table  | value         | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_TABLE2 | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | NAME  | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 10            | Statistics  |
      | Maximum value                 | Test Name2    | Statistics  |
      | Minimum length                | 10            | Statistics  |
      | Minimum value                 | Test Name2    | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ID    | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 200           | Statistics  |
      | Length                        | 0             | Statistics  |
      | Median                        | 200           | Statistics  |
      | Maximum value                 | 200           | Statistics  |
      | Variance                      | 0             | Statistics  |
      | Minimum value                 | 200           | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 0             | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB   | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | BASELINES | click and switch tab | No               |             |
      | Columns | GENDER    | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |


  ##7072920##
  @webtest
  Scenario:SC#28_3_Verify data sampling and data profiling (Varchar, Decimal and TimeStamp) for a View when OracleDBAnalyzer run with Multiple Schema and Table Filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Tables | OCPPVIEW | click and switch tab | Yes              |             |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GRADE | NAME  | ROLLNO | SCHOOLNAME |
      | five  | test1 | 100    | school1    |
      | three | test2 | 200    | school2    |
    And user "navigatesToTab" name "Overview" in item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value    | Action               | RetainPrevwindow | indexSwitch |
      | Tables | OCPPDSVT | click and switch tab | Yes              |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA2" item from search results
    Then user performs click and verify in new window
      | Table  | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_VIEW2 | click and switch tab | Yes              |             |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | DOB                   | DOB2                  | DOB3                    | DOB4                    | ID  | NAME       |
      | 2005-10-20 00:00:00.0 | 2005-05-01 06:14:00.0 | 2005-05-01 00:44:00.742 | 2005-07-01 03:44:00.742 | 200 | Test Name2 |
    And user "navigatesToTab" name "Overview" in item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_VIEW3 | click and switch tab | Yes              |             |
    And user "widget not present" on "dataSamples" in Item view page
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value       | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_VIEW | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | NAME  | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 10            | Statistics  |
      | Maximum value                 | Test Name2    | Statistics  |
      | Minimum length                | 10            | Statistics  |
      | Minimum value                 | Test Name2    | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ID    | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 200           | Statistics  |
      | Length                        | 0             | Statistics  |
      | Median                        | 200           | Statistics  |
      | Maximum value                 | 200           | Statistics  |
      | Variance                      | 0             | Statistics  |
      | Minimum value                 | 200           | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 0             | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB   | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | OCPPDSVT | click and switch tab | No               |             |
      | Columns | GRADE    | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA2" item from search results
    Then user performs click and verify in new window
      | Table  | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_VIEW2 | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | NAME  | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 20            | Statistics  |
      | Maximum length                | 10            | Statistics  |
      | Maximum value                 | Test Name2    | Statistics  |
      | Minimum length                | 10            | Statistics  |
      | Minimum value                 | Test Name2    | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ID    | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | Average                       | 200           | Statistics  |
      | Length                        | 0             | Statistics  |
      | Median                        | 200           | Statistics  |
      | Maximum value                 | 200           | Statistics  |
      | Variance                      | 0             | Statistics  |
      | Minimum value                 | 200           | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 0             | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB   | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 7                   | Statistics  |
      | Maximum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Minimum value                 | 2005-10-20 00:00:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue       | widgetName  |
      | Data type                     | TIMESTAMP           | Description |
      | Length                        | 11                  | Statistics  |
      | Maximum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Minimum value                 | 2005-05-01 06:14:00 | Statistics  |
      | Number of non null values     | 1                   | Statistics  |
      | Percentage of non null values | 100                 | Statistics  |
      | Number of null values         | 0                   | Statistics  |
      | Number of unique values       | 1                   | Statistics  |
      | Percentage of unique values   | 100                 | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB3  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Maximum value      | Statistics |
      | Minimum value      | Statistics |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue           | widgetName  |
      | Data type                     | TIMESTAMP_WITH_TIMEZONE | Description |
      | Length                        | 13                      | Statistics  |
      | Number of non null values     | 1                       | Statistics  |
      | Percentage of non null values | 100                     | Statistics  |
      | Number of null values         | 0                       | Statistics  |
      | Number of unique values       | 1                       | Statistics  |
      | Percentage of unique values   | 100                     | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | ORACLE_VIEW3 | click and switch tab | No               |             |
      | Columns | EMAIL        | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |

  @webtest @positive
  Scenario:SC#28_4_Verify the Logging enhancement in OracleDB Cataloger and Analyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc12cCDBCataloger" and clicks on search
    And user performs "facet selection" in "Orc12cCDBCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | logCode       | pluginName        | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0019 |                   |                |
      | INFO | Name:OracleDBCataloger, Plugin Type:cataloger, Plugin Version:1.1.0.RC1-SNAPSHOT, Node Name:LocalNode, Host Name:71437c04b8d2, Plugin Configuration name:OracleCatalogerWithMultipleSchemasInFilter                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0071 | OracleDBCataloger | Plugin Version |
      | INFO | Plugin OracleDBCataloger Configuration: --- 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: name: "OracleCatalogerWithMultipleSchemasInFilter" 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: pluginVersion: "LATEST" 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: label: 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: : "" 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: catalogName: "Default" 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: eventClass: null 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: eventCondition: null 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: nodeCondition: "name==\"LocalNode\"" 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: maxWorkSize: 100 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: tags: 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: - "Orc12cCDBCataloger" 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: pluginType: "cataloger" 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: dataSource: "Oracle12cCDBDS" 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: credential: "Oracle12cCDBCredentials" 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: businessApplicationName: null 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: dryRun: false 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: schedule: null 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: filter: null 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: pluginName: "OracleDBCataloger" 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: schemas: 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: - schema: "ORACLE12C_SCHEMA1" 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: tables: [] 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: - schema: "ORACLE12C_SCHEMA2" 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: tables: [] 2020-10-01 08:17:05.638 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: arguments: [] 2020-10-01 08:17:05.639 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: type: "Cataloger" 2020-10-01 08:17:05.639 INFO - ANALYSIS-0073: Plugin OracleDBCataloger Configuration: properties: [] | ANALYSIS-0073 | OracleDBCataloger |                |
      | INFO | Plugin OracleDBCataloger Start Time:2020-07-03 07:51:06.669, End Time:2020-07-03 07:51:41.340, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0072 | OracleDBCataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:38.361)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0020 |                   |                |
    And user enters the search text "Orc12cCDBAnalyzer" and clicks on search
    And user performs "facet selection" in "Orc12cCDBAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMultipleSchemaAndTableFilter%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMultipleSchemaAndTableFilter%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | logCode       | pluginName       | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0019 |                  |                |
      | INFO | Plugin Name:OracleDBAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.RC1-SNAPSHOT, Node Name:LocalNode, Host Name:71437c04b8d2, Plugin Configuration name:OracleAnalyzerWithMultipleSchemaAndTableFilter                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0071 | OracleDBAnalyzer | Plugin Version |
      | INFO | Plugin OracleDBAnalyzer Configuration: --- 2020-10-01 08:18:57.913 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: name: "OracleAnalyzerWithMultipleSchemaAndTableFilter" 2020-10-01 08:18:57.913 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginVersion: "LATEST" 2020-10-01 08:18:57.913 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: label: 2020-10-01 08:18:57.913 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: : "" 2020-10-01 08:18:57.913 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: catalogName: "Default" 2020-10-01 08:18:57.913 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: eventClass: null 2020-10-01 08:18:57.913 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: eventCondition: null 2020-10-01 08:18:57.913 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: nodeCondition: "name==\"LocalNode\"" 2020-10-01 08:18:57.913 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: maxWorkSize: 100 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: tags: 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - "Orc12cCDBAnalyzer" 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginType: "dataanalyzer" 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: dataSource: null 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: credential: null 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: businessApplicationName: null 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: dryRun: false 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: schedule: null 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: filter: null 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: histogramBuckets: 100 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: database: "ORCA12C.DID.DEV.ASGINT.LOC" 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginName: "OracleDBAnalyzer" 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: sampleDataCount: 25 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: schemas: 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - schema: "ORACLE12C_SCHEMA1" 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: tables: 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_TAG_DETAILS" 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_TABLE" 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "OCPPVIEW" 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_VIEW" 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - schema: "ORACLE12C_SCHEMA2" 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: tables: 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_TABLE2" 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_VIEW2" 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: type: "Dataanalyzer" 2020-10-01 08:18:57.914 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: topValues: 10 | ANALYSIS-0073 | OracleDBAnalyzer |                |
      | INFO | Plugin OracleDBAnalyzer Start Time:2020-07-03 07:52:11.318, End Time:2020-07-03 07:52:12.648, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0072 | OracleDBAnalyzer |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:00.264)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0020 |                  |                |

  @webtest @positive
  Scenario:SC#28_5_Verify OracleDB Analyzer plugin Processed Items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc12cCDBAnalyzer" and clicks on search
    And user performs "facet selection" in "Orc12cCDBAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMultipleSchemaAndTableFilter%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | DIDORACLE01V.DID.DEV.ASGINT.LOC |
      | ORACLE:1521                     |

  @sanity @positive @regression
  Scenario:SC#28_6_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                          | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                                               | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter%       | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMultipleSchemaAndTableFilter% | Analysis |       |       |


  ##7072921##
  @jdbc
  Scenario Outline:SC#29_1_Run the OracleDB Cataloger and Oracle Analyzer with Non Existing Schema and Table Filter
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                              | response code | response message                                   | jsonPath                                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                                                       | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                                   | 200           | Oracle12cCDBDS                                     |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithSchemaAndTableAndViewFilter.json     | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                                   | 200           | OracleCatalogerWithSchemaAndTableAndViewFilter     |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableAndViewFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                                  | 200           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableAndViewFilter')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleAnalyzerWithnNonExistingSchemaAndTableFilter.json | 204           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                                   | 200           | OracleAnalyzerWithnNonExistingSchemaAndTableFilter |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleAnalyzerWithnNonExistingSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                                  | 200           |                                                    |                                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                                   | 200           | IDLE                                               | $.[?(@.configurationName=='OracleAnalyzerWithnNonExistingSchemaAndTableFilter')].status |


  ##7072921##
  @webtest
  Scenario:SC#29_2_verify data sampling and data profiling (varchar, decimal and Timestamp) for Table and View When Non Existing schema and Table name provided in OracleDBAnalyzer Filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_TABLE | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user "widget not present" on "dataSamples" in Item view page
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | NAME  | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table  | value       | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_VIEW | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user "widget not present" on "dataSamples" in Item view page
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | NAME  | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |


  @sanity @positive @regression
  Scenario:SC#29_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                              | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                                                   | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableAndViewFilter%       | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithnNonExistingSchemaAndTableFilter% | Analysis |       |       |

  ##7072923##
  @jdbc
  Scenario Outline:SC#30_1_Run the OracleDB Cataloger and Oracle Analyzer With Incorrect Database Name in OracleDBAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                                                                          | response code | response message                               | jsonPath                                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                 | ida/jdbcAnalyzerPayloads/Oracle12cCDB/OracleDataSource.json                                                   | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                 |                                                                                                               | 200           | Oracle12cCDBDS                                 |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleCatalogerWithSchemaAndTableAndViewFilter.json | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                                                               | 200           | OracleCatalogerWithSchemaAndTableAndViewFilter |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableAndViewFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                              | 200           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableAndViewFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/OracleAnalyzerWithIncorrectDatabaseName.json        | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                                                               | 200           | OracleAnalyzerWithIncorrectDatabaseName        |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleAnalyzerWithIncorrectDatabaseName')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  | ida/jdbcAnalyzerPayloads/Oracle12cCDB/empty.json                                                              | 200           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                                                               | 200           | IDLE                                           | $.[?(@.configurationName=='OracleAnalyzerWithIncorrectDatabaseName')].status        |


  ##7072923##
  @webtest
  Scenario:SC#30_2_verify data sampling and data profiling are not done for Table and View When Incorrect Database Name is provided in the OracleDBAnalyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE12C_SCHEMA1" item from search results
    Then user performs click and verify in new window
      | Table  | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_TABLE | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user "widget not present" on "dataSamples" in Item view page
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | NAME  | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table  | value       | Action               | RetainPrevwindow | indexSwitch |
      | Tables | ORACLE_VIEW | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user "widget not present" on "dataSamples" in Item view page
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | NAME  | click and switch tab | No               |             |
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
      | Maximum length    | Statistics |
      | Maximum value     | Statistics |
      | Minimum length    | Statistics |
      | Minimum value     | Statistics |

  @sanity @positive @regression
  Scenario:SC#30_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                        | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                                             | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableAndViewFilter% | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithIncorrectDatabaseName%      | Analysis |       |       |


########################################################## PII Tags ################################################################################

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#31_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | tags/Default/structures                                                              | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OraclePIITags.json                          | $.PIIConfig      | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC33           | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.CatalogConfig  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |                  | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.AnalyzerConfig | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |                  | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

   # 7099421
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#31_2_Verify Tag is set for the column when typePattern(String) and dataPattern/minimumRatio matches with the column type/value ratio in Oracle table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag             |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Email Address | EMAIL     | TAGDETAILS_ALLMATCH |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Gender        | GENDER    | TAGDETAILS_ALLMATCH |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IP Address    | IPADDRESS | TAGDETAILS_ALLMATCH |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,SSN           | SSN       | TAGDETAILS_ALLMATCH |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Full Name     | FULL_NAME | TAGDETAILS_ALLMATCH |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Email Address | EMAIL     | TAGDETAILS_ALLEMPTY |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,SSN           | SSN       | TAGDETAILS_ALLEMPTY |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IP Address    | IPADDRESS | TAGDETAILS_ALLEMPTY |

  # 7099422
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#32_1_Verify Tag is not set for the column when typePattern(other than String) and dataPattern/minimumRatio matches with the column type/value ratio in Oracle table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name   | facet         | Tag          | fileName  | userTag                                     |
      | Default     | Column | Metadata Type | SSNPII       | SSN       | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | EmailPII     | EMAIL     | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | FullNamePII  | FULL_NAME | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | GenderPII    | GENDER    | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | IPAddressPII | IPADDRESS | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | SSNPII       | SSN       | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Column | Metadata Type | EmailPII     | EMAIL     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Column | Metadata Type | FullNamePII  | FULL_NAME | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Column | Metadata Type | GenderPII    | GENDER    | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Column | Metadata Type | IPAddressPII | IPADDRESS | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |


  @sanity @positive @regression @PIITag
  Scenario:SC#32_2_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#33_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC35           | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.CatalogConfig  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |                  | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.AnalyzerConfig | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |                  | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099423
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#33_2_Verify Tag is set for the column when namePattern and dataPattern/minimumRatio matches with the column name/value ratio in Oracle table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                         | fileName  | userTag                                     |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,EmailPII     | EMAIL     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,GenderPII    | GENDER    | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IPAddressPII | IPADDRESS | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,SSNPII       | SSN       | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,FullNamePII  | FULL_NAME | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,EmailPII     | EMAIL     | TAGDETAILS_RatioEqualTo05EmptyFalse         |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,GenderPII    | GENDER    | TAGDETAILS_RatioEqualTo05EmptyFalse         |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IPAddressPII | IPADDRESS | TAGDETAILS_RatioEqualTo05EmptyFalse         |


 #7099424
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#34_1_Verify Tag is not set for the column when namePattern(does not match) and dataPattern/minimumRatio that does not matches with the column name/value ratio in Oracle table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name   | facet         | Tag           | fileName  | userTag             |
      | Default     | Column | Metadata Type | SSN           | SSN       | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | Email Address | EMAIL     | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | Full Name     | FULL_NAME | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | Gender        | GENDER    | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | IP Address    | IPADDRESS | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | SSN           | SSN       | TAGDETAILS_ALLEMPTY |
      | Default     | Column | Metadata Type | Email Address | EMAIL     | TAGDETAILS_ALLEMPTY |
      | Default     | Column | Metadata Type | Full Name     | FULL_NAME | TAGDETAILS_ALLEMPTY |
      | Default     | Column | Metadata Type | Gender        | GENDER    | TAGDETAILS_ALLEMPTY |
      | Default     | Column | Metadata Type | IP Address    | IPADDRESS | TAGDETAILS_ALLEMPTY |

  @sanity @positive @regression @PIITag
  Scenario:SC#34_2_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#35_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC37    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.Filter1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.Filter1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099425
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#35_2_Verify Tag is set for the column when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 0.2 - 2 or more rows should have matching column values)- Match Empty is False
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag                              |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Email Address | EMAIL     | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Gender        | GENDER    | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IP Address    | IPADDRESS | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,SSN           | SSN       | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Full Name     | FULL_NAME | TAGDETAILS_Ratiolessthan05EmptyFalse |

  @sanity @positive @regression @PIITag
  Scenario:SC#35_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#36_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC38    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.Filter2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.Filter2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099426
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#36_2_Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag       | fileName  | userTag                                     |
      | Default     | Orc12cCDBAnalyzer | Tags  | SSN       | SSN       | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Gender    | GENDER    | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Full Name | FULL_NAME | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag                                     |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Email Address | EMAIL     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IP Address    | IPADDRESS | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#37_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC39    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099427
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#37_2_Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is True -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag                                     |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Email Address | EMAIL     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Gender        | GENDER    | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IP Address    | IPADDRESS | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,SSN           | SSN       | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Full Name     | FULL_NAME | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |

  @sanity @positive @regression @PIITag
  Scenario:SC#37_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#38_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC40    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.Filter3 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.Filter3 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099428
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#38_2_Verify Tag is set for the column when dataPattern and minimumRatio(1-full match) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 1 - all rows should match) - Match Empty is false
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag             |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Email Address | EMAIL     | TAGDETAILS_ALLMATCH |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Gender        | GENDER    | TAGDETAILS_ALLMATCH |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IP Address    | IPADDRESS | TAGDETAILS_ALLMATCH |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,SSN           | SSN       | TAGDETAILS_ALLMATCH |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Full Name     | FULL_NAME | TAGDETAILS_ALLMATCH |

  @sanity @positive @regression @PIITag
  Scenario:SC#38_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#39_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC41    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.Filter4 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.Filter4 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099429
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#39_2_Verify Tag is set for the column when dataPattern and minimumRatio(equal to 0.5) is passed which has a regexp that matches with the data in column in Oracle table.
  (Ex: 0.5 - 5 or more rows should have matching column values) - Match Empty is false.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag                             |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Email Address | EMAIL     | TAGDETAILS_RatioEqualTo05EmptyFalse |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Gender        | GENDER    | TAGDETAILS_RatioEqualTo05EmptyFalse |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IP Address    | IPADDRESS | TAGDETAILS_RatioEqualTo05EmptyFalse |

  @sanity @positive @regression @PIITag
  Scenario:SC#39_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#40_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC42    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.Filter1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.Filter1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099430
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#40_2_Verify Tag is set for the column when namePattern,typePattern,dataPattern and minimumRatio is passed which has a regexp and minimum ratio that matches with the data in column in Oracle table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag                              |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Email Address | EMAIL     | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Gender        | GENDER    | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IP Address    | IPADDRESS | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,SSN           | SSN       | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Full Name     | FULL_NAME | TAGDETAILS_Ratiolessthan05EmptyFalse |

  @sanity @positive @regression @PIITag
  Scenario:SC#40_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#41_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC43           | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.CatalogConfig  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |                  | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.AnalyzerConfig | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |                  | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099431
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#41_2_Verify Tag is not set for the column when namePattern(does not match),typePattern,dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in column in Oracle table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name   | facet         | Tag           | fileName  | userTag             |
      | Default     | Column | Metadata Type | SSN           | SSN       | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | Email Address | EMAIL     | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | Full Name     | FULL_NAME | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | Gender        | GENDER    | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | IP Address    | IPADDRESS | TAGDETAILS_ALLMATCH |
      | Default     | Column | Metadata Type | SSN           | SSN       | TAGDETAILS_ALLEMPTY |
      | Default     | Column | Metadata Type | Email Address | EMAIL     | TAGDETAILS_ALLEMPTY |
      | Default     | Column | Metadata Type | Full Name     | FULL_NAME | TAGDETAILS_ALLEMPTY |
      | Default     | Column | Metadata Type | Gender        | GENDER    | TAGDETAILS_ALLEMPTY |
      | Default     | Column | Metadata Type | IP Address    | IPADDRESS | TAGDETAILS_ALLEMPTY |

   #7099432
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#42_Verify Tag is not set for the column when namePattern,typePattern(does not match),dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in column in Oracle table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name   | facet         | Tag          | fileName  | userTag                                     |
      | Default     | Column | Metadata Type | SSNPII       | SSN       | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | EmailPII     | EMAIL     | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | FullNamePII  | FULL_NAME | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | GenderPII    | GENDER    | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | IPAddressPII | IPADDRESS | TAGDETAILS_Ratiolessthan05EmptyFalse        |
      | Default     | Column | Metadata Type | SSNPII       | SSN       | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Column | Metadata Type | EmailPII     | EMAIL     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Column | Metadata Type | FullNamePII  | FULL_NAME | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Column | Metadata Type | GenderPII    | GENDER    | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Column | Metadata Type | IPAddressPII | IPADDRESS | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |

    #7099433 #7099437
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#43_1_Verify Tag is not set for the column when namePattern,typePattern,dataPattern and minimumRatio(does not match) is passed which has any of the regexp and ratio that does not matches with the data in column in Oracle table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name   | facet         | Tag             | fileName  | userTag                             |
      | Default     | Column | Metadata Type | OracleSSN       | SSN       | TAGDETAILS_ALLMATCH                 |
      | Default     | Column | Metadata Type | OracleEmail     | EMAIL     | TAGDETAILS_ALLMATCH                 |
      | Default     | Column | Metadata Type | OracleFullName  | FULL_NAME | TAGDETAILS_ALLMATCH                 |
      | Default     | Column | Metadata Type | OracleGender    | GENDER    | TAGDETAILS_ALLMATCH                 |
      | Default     | Column | Metadata Type | OracleIPAddress | IPADDRESS | TAGDETAILS_ALLMATCH                 |
      | Default     | Column | Metadata Type | OracleSSN       | SSN       | TAGDETAILS_RatioEqualTo05EmptyFalse |
      | Default     | Column | Metadata Type | OracleEmail     | EMAIL     | TAGDETAILS_RatioEqualTo05EmptyFalse |
      | Default     | Column | Metadata Type | OracleFullName  | FULL_NAME | TAGDETAILS_RatioEqualTo05EmptyFalse |
      | Default     | Column | Metadata Type | OracleGender    | GENDER    | TAGDETAILS_RatioEqualTo05EmptyFalse |
      | Default     | Column | Metadata Type | OracleIPAddress | IPADDRESS | TAGDETAILS_RatioEqualTo05EmptyFalse |

  @sanity @positive @regression @PIITag
  Scenario:SC#43_2_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#44_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC46    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.Filter6 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.Filter6 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099434
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#44_2_Verify Tag is not set for the column when match empty is true and all the column values in DB are empty.(dataPattern/minimumRatio/MatchEmpty:True/MatchFull:False)
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag             |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Email Address | EMAIL     | TAGDETAILS_ALLEMPTY |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IP Address    | IPADDRESS | TAGDETAILS_ALLEMPTY |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,SSN           | SSN       | TAGDETAILS_ALLEMPTY |

  @sanity @positive @regression @PIITag
  Scenario:SC#44_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#45_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC47    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.Filter5 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.Filter5 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

  # 7099435
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#45_2_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in Oracle table.
  (Ex: 0.6 - 6 or more rows should have matcning column values - dataPattern and minimumRatio passed).
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag       | fileName | userTag                                    |
      | Default     | Orc12cCDBAnalyzer | Tags  | FullMatch | COMMENTS | TAGDETAILS_Ratiogreaterthan05MatchFullTrue |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#45_4_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC47_1  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099435
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#45_5_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in Oracle table.
  (Ex: 0.6 - 6 or more rows should have matcning column values - dataPattern and minimumRatio passed).
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                      | fileName | userTag                                    |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,FullMatch | COMMENTS | TAGDETAILS_Ratiogreaterthan05MatchFullTrue |

  @sanity @positive @regression @PIITag
  Scenario:SC#45_6_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#46_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC48    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.Filter7 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.Filter7 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099436
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#46_2_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the exact data in column in Oracle table.
  (Ex: 0.2 - 2 or more rows should have matcning column values - namePattern,typePattern,dataPattern and minimumRatio passed).
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag       | fileName | userTag                                   |
      | Default     | Orc12cCDBAnalyzer | Tags  | FullMatch | COMMENTS | TAGDETAILS_Ratiolesserthan05MatchFullTrue |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#46_4_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC48_1  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099436
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#46_5_Verify Tag is set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the exact data in column in Oracle table.
  (Ex: 0.2 - 2 or more rows should have matching column values - namePattern,typePattern,dataPattern and minimumRatio passed).
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                      | fileName | userTag                                   |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,FullMatch | COMMENTS | TAGDETAILS_Ratiolesserthan05MatchFullTrue |

  @sanity @positive @regression @PIITag
  Scenario:SC#46_6_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#47_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC49    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.Filter8 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.Filter8 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

 #7099438
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#47_2_Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Oracle View.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag         |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Email Address | EMAIL     | TAGDETAILS_VIEW |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IP Address    | IPADDRESS | TAGDETAILS_VIEW |

  @sanity @positive @regression @PIITag
  Scenario:SC#47_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#48_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC50    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.Filter8 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.Filter8 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099439
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#48_2_Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Oracle View.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is True -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag         |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Email Address | EMAIL     | TAGDETAILS_VIEW |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Gender        | GENDER    | TAGDETAILS_VIEW |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IP Address    | IPADDRESS | TAGDETAILS_VIEW |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,SSN           | SSN       | TAGDETAILS_VIEW |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Full Name     | FULL_NAME | TAGDETAILS_VIEW |

  @sanity @positive @regression @PIITag
  Scenario:SC#48_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |


  @sanity @positive @regression @PIITag
  Scenario Outline:SC#49_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC51    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.Filter2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.Filter2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

    #7099440
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#49_2_Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Oracle CDB.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag                                     |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Email Address | EMAIL     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IP Address    | IPADDRESS | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |

  @sanity @positive @regression @PIITag
  Scenario:SC#49_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @sanity @positive @regression @PIITag
  Scenario Outline:SC#50_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                                                                | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/policyEngine/OracleDBTag.json                            | $.SC52    | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBCatalogerTagsConfig.json | $.Filter2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                                                                         |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/ida/jdbcAnalyzerPayloads/Oracle12cCDB/pluginConfiguration/Oracle12CCDBAnalyzerTagsConfig.json  | $.Filter2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                                                                         |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                                                                         |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                                                                         |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |

     #7099441
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#50_2_Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Oracle CDB.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is True -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                                                                          | fileName  | userTag                                     |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Email Address | EMAIL     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Gender        | GENDER    | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,IP Address    | IPADDRESS | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,SSN           | SSN       | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |
      | Default     | Orc12cCDBAnalyzer | Tags  | Orc12cCDBAnalyzer,Oracle,Orc12cCDBCataloger,Oracle12C_CDB_Cat,Oracle12C_CDB_AY,Full Name     | FULL_NAME | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue |

  @sanity @positive @regression @PIITag
  Scenario:SC#50_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type                | query | param |
      | SingleItemDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                 | Cluster             |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis            |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis            |       |       |
      | SingleItemDelete | Default | Oracle12C_CDB_Cat                               | BusinessApplication |       |       |
      | SingleItemDelete | Default | Oracle12C_CDB_AY                                | BusinessApplication |       |       |


  @jdbc
  Scenario Outline:SC#51_Delete Plugin Configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                 | body | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/EDIBusOracleCredentials        |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/EDIBusDataSource                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Oracle12cCDBCredentials        |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Oracle12cCDBInvalidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Oracle12cCDBEmptyCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBDataSource               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBCataloger                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBAnalyzer                 |      | 204           |                  |          |



#  @jdbc
#  Scenario:Drop Index on Table
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation    | queryPath     | queryPage        | queryField          |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | dropCDBIndexOnTable |
#
#
#  @jdbc
#  Scenario:Drop Procedure, View, Functions and tables
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation    | queryPath     | queryPage        | queryField        |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | dropCDBProcedure1 |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | dropCDBTable1     |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | dropCDBTable2     |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | dropCDBProcedure2 |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | dropCDBTable3     |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | dropCDBView1      |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | dropCDBTable4     |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | dropCDBFunction1  |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | dropCDBTable5     |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | dropCDBTable6     |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | dropCDBTable7     |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | dropCDBView2      |
#      | oracle12c_cdb      | EXECUTEQUERY | json/IDA.json | oracle12cQueries | dropCDBProcedure3 |
#
#
#  @jdbc
#  Scenario:Drop Table
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation | Schema            | Table                         | Database |
#      | oracle12c_cdb      | DROP      | ORACLE12C_SCHEMA1 | TABLE_PRIMARY                 |          |
#      | oracle12c_cdb      | DROP      | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS            |          |
#      | oracle12c_cdb      | DROP      | ORACLE12C_SCHEMA2 | ORACLE_TAG_DETAILS            |          |
#      | oracle12c_cdb      | DROP      | ORACLE12C_SCHEMA2 | BASELINES                     |          |
#      | oracle12c_cdb      | DROP      | ORACLE12C_SCHEMA1 | ORACLE_TABLE                  |          |
#      | oracle12c_cdb      | DROP      | ORACLE12C_SCHEMA1 | ORACLE_EMPTY                  |          |
#      | oracle12c_cdb      | DROP      | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES          |          |
#      | oracle12c_cdb      | DROP      | ORACLE12C_SCHEMA1 | ORACLE_CHECKTEST              |          |
#      | oracle12c_cdb      | DROP      | ORACLE12C_SCHEMA1 | ORACLE_UNIQUETEST             |          |
#      | oracle12c_cdb      | DROP      | ORACLE12C_SCHEMA1 | ORACLE_INDEXTABLE             |          |
#      | oracle12c_cdb      | DROP      | ORACLE12C_SCHEMA1 | ORACLE_PERSON_ADDRESS_DETAILS |          |
#      | oracle12c_cdb      | DROP      | ORACLE12C_SCHEMA1 | ORACLE_PERSON_INFO            |          |
#      | oracle12c_cdb      | DROP      | ORACLE12C_SCHEMA1 | TRIGGERTEST                   |          |
#      | oracle12c_cdb      | DROP      | ORACLE12C_SCHEMA1 | TRIGGERTEST1                  |          |
#
#
#  @jdbc
#  Scenario:Drop Schema
#    Given user connects to the database and performs the following operation
#      | databaseConnection | Operation            | queryPath     | queryPage        | queryField     |
#      | oracle12c_cdb      | EXECUTEQUERY         | json/IDA.json | oracle12cQueries | dropCDBSchema1 |
#      | oracle12c_cdb      | EXECUTEQUERY         | json/IDA.json | oracle12cQueries | dropCDBSchema2 |
#      | oracle12c_cdb      | EXECUTELISTOFQUERIES | json/IDA.json | oracle12cQueries | dropCDBSchema3 |
#      | oracle12c_cdb      | EXECUTELISTOFQUERIES | json/IDA.json | oracle12cQueries | dropCDBSchema4 |