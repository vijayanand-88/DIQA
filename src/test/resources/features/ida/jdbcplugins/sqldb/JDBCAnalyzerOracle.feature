@MLP-4630
Feature:Verification of Oracle Analyzer using Oracle 11g database and plugin validation

  ###############################################PreCondition#############################################

  @jdbc
  Scenario: Create a Table
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage     | queryField                  |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createConstraintTable       |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createTimeStampEmptyTable   |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createDiffDataTypesTable    |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createCheckConstraintTable  |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createUniqueConstraintTable |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createIndexConstraintTable  |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createIndexOnTable          |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createPrimaryKeyTable       |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createForeignKeyTable       |


  @jdbc
  Scenario: Create Table and insert value for data sampling
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage     | queryField    |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createTable   |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | insertRecord1 |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | insertRecord2 |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | insertRecord3 |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | insertRecord4 |


  @jdbc
  Scenario: Create Table with Timestamp and insert records for Verification
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage     | queryField            |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createTimeStampTable  |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | insertTimeStampRecord |


  @jdbc
  Scenario: Create table, procedure and execute the procedure
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage     | queryField          |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createTable1        |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | insertTable1Record1 |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createTable2        |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createProcedure1    |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | executeProcedure1   |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createTable3        |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | insertTable3Record1 |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | insertTable3Record2 |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createView1         |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createTable4        |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createProcedure2    |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | executeProcedure2   |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createTable5        |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | insertTable5Record1 |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createTable6        |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createFunction1     |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | executeFunction1    |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createTable7        |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createView2         |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | createProcedure3    |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | executeProcedure3   |


  @precondition
  Scenario: Update credential payload json for Oracle11g
    Given User update the below "oracle11g credentials" in following files using json path
      | filePath                                                  | username    | password    |
      | ida/jdbcAnalyzerPayloads/Oracle11g/OracleCredentials.json | $..userName | $..password |


  @sanity @positive @regression @IDA_E2E
  Scenario Outline: Add valid Credentials for Oracle11g
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                              | body                                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle11gCredentials        | ida/jdbcAnalyzerPayloads/Oracle11g/OracleCredentials.json        | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle11gCredentials        |                                                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle11gInvalidCredentials | ida/jdbcAnalyzerPayloads/Oracle11g/OracleInvalidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle11gInvalidCredentials |                                                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle11gEmptyCredentials   | ida/jdbcAnalyzerPayloads/Oracle11g/OracleCredentialsEmpty.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle11gEmptyCredentials   |                                                                  | 200           |                  |          |


    ##7047693##
  @webtest @negative
  Scenario: Verify whether the background of the panel is displayed in red when connection is unsuccessful due to invalid / Empty credentials in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute                   |
      | Data Source Type | OracleDBDataSource          |
      | Plugin version   | LATEST                      |
#      | Catalog Name     | Default                  |
      | Credential       | Oracle11gInvalidCredentials |
      | Deployment       | LocalNode                   |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                        |
      | Name      | Oracle11gDS_Test                                 |
      | Label     | Oracle11gDS_Test                                 |
      | URL       | jdbc:oracle:thin:@gechcae-col1.asg.com:1521:col2 |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                 |
      | Credential | Oracle11gEmptyCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


    ##7047694##
  @positve @regression @sanity @webtest
  Scenario: Verify whether the background of the panel is displayed in green when connection is successful in Step1 pop up when user logs in for the first time in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute            |
      | Data Source Type | OracleDBDataSource   |
      | Plugin version   | LATEST               |
#      | Catalog Name     | Default                  |
      | Credential       | Oracle11gCredentials |
      | Deployment       | LocalNode            |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                        |
      | Name      | Oracle11gDS_Test                                 |
      | Label     | Oracle11gDS_Test                                 |
      | URL       | jdbc:oracle:thin:@gechcae-col1.asg.com:1521:col2 |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"


  ##7047695##
  @webtest
  Scenario: Verify whether the background in the Cataloger panel is red when connection is unsuccessful due to Invalid / Empty Credentials
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
      | fieldName   | attribute                   |
      | Type        | Cataloger                   |
      | Plugin      | OracleDBCataloger           |
      | Data Source | Oracle11gDS_Test            |
      | Credential  | Oracle11gInvalidCredentials |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute               |
      | Name      | Oracle11gCataloger_Test |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Configuration Sources Page"
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute                 |
      | Credential | Oracle11gEmptyCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Configuration Sources Page"
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  ##7047696##
  @webtest
  Scenario: Verify whether the background in the Cataloger panel is green when connection is successful due to valid Credentials
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
      | fieldName   | attribute            |
      | Type        | Cataloger            |
      | Plugin      | OracleDBCataloger    |
      | Data Source | Oracle11gDS_Test     |
      | Credential  | Oracle11gCredentials |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute               |
      | Name      | Oracle11gCataloger_Test |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"
    And user "click" on "Save" button in "Add Configuration Sources Page"


  @jdbc @IDA_E2E
  Scenario Outline: SC#1-Create Oracle Cataloger Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                | body                                                                                        | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                                               | ida/jdbcAnalyzerPayloads/Oracle11g/pluginConfiguration/oracleCatalogerWithSchemaConfig.json | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                                               |                                                                                             | 200           | OracleCatalogerWithSchemaFilter |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter |                                                                                             | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter | ida/jdbcAnalyzerPayloads/empty.json                                                         | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter |                                                                                             | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |



  ##6644452##
  @webtest @jdbc @MLP-5641 @MLP-9602 @IDA_E2E
  Scenario: SC#1-Verify the Service(OracleDB) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc11Cataloger" and clicks on search
    And user performs "facet selection" in "Orc11Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE:1521" item from search results


  ##6646191##
  @webtest @jdbc @MLP-5641 @MLP-9602 @IDA_E2E
  Scenario: SC#1-Verify the Database(OracleDB) should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc11Cataloger" and clicks on search
    And user performs "facet selection" in "Orc11Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "COL2" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                                                                                                    | widgetName |
      | Storage type      | OracleOracle Database 11g Enterprise Edition Release 11.2.0.2.0 - 64bit Production With the Partitioning, OLAP, Data Mining and Real Application Testing options |            |
    And user copy metadata value from Item View Page and write to file using below parameters
      | itemName       | COL2                                                    |
      | attributeName  | Technical Data                                          |
      | actualFilePath | ida/jdbcAnalyzerPayloads/actualOracle11gDBTechData.json |
    And user "update" the json file "ida/jdbcAnalyzerPayloads/actualOracle11gDBTechData.json" file for following values
      | jsonPath        | jsonValues | type   |
      | $..['password'] |            | String |
    And user "update" the json file "ida/jdbcAnalyzerPayloads/expectedOracle11gDBTechData.json" file for following values
      | jsonPath        | jsonValues | type   |
      | $..['password'] |            | String |
    Then file content in "ida/jdbcAnalyzerPayloads/expectedOracle11gDBTechData.json" should be same as the content in "ida/jdbcAnalyzerPayloads/actualOracle11gDBTechData.json"


  ##6644453##
  @webtest @jdbc @MLP-5641 @MLP-9602
  Scenario: SC#1-Verify the Schema should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc11Cataloger" and clicks on search
    And user performs "facet selection" in "Orc11Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "COLUSER" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |


  ##6654153##
  @webtest @jdbc @MLP-9602
  Scenario: SC#1-Verify the dependencies appearing properly for VIEW/Triggers/Procedure/Functions
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "V_SEL_ASTERISK_ONLY" and clicks on search
    And user performs "facet selection" in "Orc11Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "COLLECTOR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "definite facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "Type" sort in Item Results page
    And user performs "item click" on "V_SEL_ASTERISK_ONLY" item from search results
    Then user performs click and verify in new window
      | Table        | value | Action                 | RetainPrevwindow | indexSwitch |
      | DEPENDENCIES | FILM  | verify widget contains | No               |             |
    And user enters the search text "TRIGGER1" and clicks on search
    And user performs "facet selection" in "Orc11Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Trigger" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TRIGGER1" item from search results
    Then user performs click and verify in new window
      | Table        | value        | Action                 | RetainPrevwindow | indexSwitch |
      | DEPENDENCIES | TRIGGERTEST  | verify widget contains | No               |             |
      | DEPENDENCIES | TRIGGERTEST1 | verify widget contains | No               |             |
    And user enters the search text "STORE_COMPLETE_ADDRESS" and clicks on search
    And user performs "facet selection" in "Orc11Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "STORE_COMPLETE_ADDRESS" item from search results
    Then user performs click and verify in new window
      | Table        | value          | Action                 | RetainPrevwindow | indexSwitch |
      | DEPENDENCIES | PEOPLEDETAILS  | verify widget contains | No               |             |
      | DEPENDENCIES | PEOPLEDETAILS1 | verify widget contains | No               |             |
    And user enters the search text "INSERTPROC" and clicks on search
    And user performs "facet selection" in "Orc11Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "INSERTPROC" item from search results
    Then user performs click and verify in new window
      | Table        | value      | Action                 | RetainPrevwindow | indexSwitch |
      | DEPENDENCIES | TESTTABLE1 | verify widget contains | No               |             |
      | DEPENDENCIES | TESTTABLE2 | verify widget contains | No               |             |



  ##6628243## ##6477888##
  @webtest @jdbc @MLP-5641 @MLP-9602 @IDA_E2E
  Scenario: SC#1-Verify the Oracle Table should have constraints like Primary Key,Foreign key,Unique Key and Check constraints and Schema has index.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE_CHECK_SUPPLIER_ID" and clicks on search
    And user performs "facet selection" in "Orc11Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | ORACLE_CHECK_SUPPLIER_ID |
    And user performs "item click" on "ORACLE_CHECK_SUPPLIER_ID" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                 | widgetName |
      | checkCondition    | check_id BETWEEN 100 and 9999 |            |
      | Constraint Type   | C                             |            |
      | deferred          | NO                            |            |
      | generatedName     | NO                            |            |
      | validated         | YES                           |            |
      | disabled          | NO                            |            |
      | deferrable        | NO                            |            |
      | rely              | NO                            |            |
    And user enters the search text "ORACLE_SUPPLIER_UNIQUETEST" and clicks on search
    And user performs "facet selection" in "Orc11Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | ORACLE_SUPPLIER_UNIQUETEST |
    And user performs "item click" on "ORACLE_SUPPLIER_UNIQUETEST" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName |
      | Constraint Type   | U             |            |
      | deferred          | NO            |            |
      | generatedName     | NO            |            |
      | validated         | YES           |            |
      | disabled          | NO            |            |
      | deferrable        | NO            |            |
      | rely              | NO            |            |
    And user enters the search text "ORACLEINDEXTEST" and clicks on search
    And user performs "facet selection" in "Orc11Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | ORACLEINDEXTEST |
    And user performs "item click" on "ORACLEINDEXTEST" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName |
      | generatedName     | NO            |            |
      | indexType         | NORMAL        |            |
      | unique            | NO            |            |
    And user enters the search text "PERSON_INFO_PK" and clicks on search
    And user performs "facet selection" in "Orc11Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | PERSON_INFO_PK |
    And user performs "item click" on "PERSON_INFO_PK" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName |
      | Constraint Type   | P             |            |
      | deferred          | NO            |            |
      | generatedName     | NO            |            |
      | validated         | YES           |            |
      | disabled          | NO            |            |
      | deferrable        | NO            |            |
      | rely              | NO            |            |
    And user enters the search text "FK_PERSON_INFO" and clicks on search
    And user performs "facet selection" in "Orc11Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | FK_PERSON_INFO |
    And user performs "item click" on "FK_PERSON_INFO" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName |
      | Constraint Type   | R             |            |
      | deferred          | NO            |            |
      | generatedName     | NO            |            |
      | validated         | YES           |            |
      | disabled          | NO            |            |
      | deferrable        | NO            |            |
      | rely              | NO            |            |


    ##Needs API Implementation##
 ##6628261##
  @webtest @MLP-9602
  Scenario: SC#1-Verify the relationships shows properly between the table and constraint under relationship tab
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "PERSON_INFO_PK" items at top end
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PERSON_INFO_PK" item from search results
    And user verifies the Relationship of "Constraint" and Table for the following values in "ORACLE CATALOG"
      | Constraint     | LinkColumn | Index          |
      | PERSON_INFO_PK | PERSON_ID  | PERSON_INFO_PK |
    And user select "ORACLE CATALOG" catalog and search "FK_PERSON_INFO" items at top end
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FK_PERSON_INFO" item from search results
    And user verifies the Relationship of "Constraint" and Table for the following values in "ORACLE CATALOG"
      | Constraint     | LinkColumn | Parent                        |
      | FK_PERSON_INFO | PERSON_ID  | PERSON_INFO_PK                |
      | FK_PERSON_INFO | PERSON_ID  | ORACLE_PERSON_ADDRESS_DETAILS |
    And user select "ORACLE CATALOG" catalog and search "ORACLE_SUPPLIER_UNIQUETEST" items at top end
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_SUPPLIER_UNIQUETEST" item from search results
    And user verifies the Relationship of "Constraint" and Table for the following values in "ORACLE CATALOG"
      | Constraint                 | LinkColumn  | Index                      |
      | ORACLE_SUPPLIER_UNIQUETEST | SUPPLIER_ID | ORACLE_SUPPLIER_UNIQUETEST |
    And user select "ORACLE CATALOG" catalog and search "ORACLE_SUPPLIER_UNIQUETEST" items at top end
    And user performs "facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_SUPPLIER_UNIQUETEST" item from search results
    And user verifies the Relationship of "Index" and Table for the following values in "ORACLE CATALOG"
      | Index                      | LinkColumn  | ReferencedTable   |
      | ORACLE_SUPPLIER_UNIQUETEST | SUPPLIER_ID | ORACLE_UNIQUETEST |


  ##6644451##
  @webtest @jdbc @MLP-9602
  Scenario: SC#1-Verify the Cluster should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc11Cataloger" and clicks on search
    And user performs "facet selection" in "Orc11Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "gechcae-col1.asg.com" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |


  ##6628585##
  @webtest @jdbc @MLP-9602
  Scenario: SC#1-Verify the breadcrumb hierarchy appears correctly when Oracle cataloger is ran for Oracle Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE_TAG_DETAILS" and clicks on search
    And user performs "facet selection" in "Orc11Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FULL_NAME" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | gechcae-col1.asg.com |
      | ORACLE:1521          |
      | COL2                 |
      | COLLECTOR            |
      | ORACLE_TAG_DETAILS   |
      | FULL_NAME            |


  ##6628260##
  @webtest @jdbc @MLP-9602
  Scenario: SC#1-Verify captions and tool tip text in OracleDBCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
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
      | Type                 |
      | Plugin               |
      | Name                 |
      | Plugin Version       |
      | Business Application |
#      | Catalog Name     |
      | Data Source          |
      | Credential           |


  ##6650600##
  @webtest @jdbc @MLP-9605
  Scenario: SC#1-Verify captions and tool tip text in OracleDBAnalyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "OracleDBAnalyzer" plugin config list in Plugin Manager page
    And user add button in "ORACLE DB ANALYZER" section
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | NAME              |
      | PLUGIN VERSION    |
      | LABEL             |
      | CATALOG NAME      |
      | SAMPLE DATA COUNT |
      | TOP VALUES        |
      | HISTOGRAM BUCKETS |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | NAME              | Plugin configuration name                            |
      | PLUGIN VERSION    | Required plugin version                              |
      | LABEL             | Plugin configuration extended label and description  |
      | CATALOG NAME      | Catalog name                                         |
      | SAMPLE DATA COUNT | Sample Data maximum count. Max Limit is 1000         |
      | TOP VALUES        | Most popular values in Column of Each Column         |
      | HISTOGRAM BUCKETS | Number of buckets for representing data distribution |


  ##6628258##
  @webtest @jdbc @MLP-9602
  Scenario: SC#1-Verify OracleDBCataloger collects all the different columns of a table when table is created with all possible datatypes
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "verify metadata values" for the following "COLUMNS" values in Item Full View page
      | catalogName    | tableName            | itemName            | Data type               | datatypeName                      |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN  | TIMESTAMP_WITH_TIMEZONE | TIMESTAMP(6) WITH TIME ZONE       |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | FLOATCOLUMN         | FLOAT                   | FLOAT                             |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | BINARYDOUBLECOLUMN  | OTHER                   | BINARY_DOUBLE                     |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | RAWCOLUMN           | VARBINARY               | RAW                               |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | UROWIDCOLUMN        | OTHER                   | UROWID                            |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | DATECOLUMN          | TIMESTAMP               | DATE                              |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN     | TIMESTAMP               | TIMESTAMP(6)                      |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | CLOBCOLUMN          | CLOB                    | CLOB                              |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN     | NVARCHAR                | NVARCHAR2                         |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | NCHARCOLUMN         | NCHAR                   | NCHAR                             |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | CHARCOLUMN          | CHAR                    | CHAR                              |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | VARCHARCOLUMN       | VARCHAR                 | VARCHAR2                          |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN      | VARCHAR                 | VARCHAR2                          |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | BLOBCOLUMN          | BLOB                    | BLOB                              |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | BFILECOLUMN         | OTHER                   | BFILE                             |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | LONGCOLUMN          | LONGVARCHAR             | LONG                              |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN | TIMESTAMP_WITH_TIMEZONE | TIMESTAMP(6) WITH LOCAL TIME ZONE |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | ROWIDCOLUMN         | ROWID                   | ROWID                             |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | BINARYFLOATCOLUMN   | OTHER                   | BINARY_FLOAT                      |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | NUMBERCOLUMN        | DECIMAL                 | NUMBER                            |
      | ORACLE CATALOG | ORACLE_DIFFDATATYPES | NCLOBCOLUMN         | NCLOB                   | NCLOB                             |



  ##6628253##
  @webtest @jdbc @MLP-6902 @MLP-9602
  Scenario: SC#1-Verify proper error message is shown if mandatory fields are not filled in OracleDBCataloger plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "OracleDBCataloger" plugin config list in Plugin Manager page
    And user add button in "ORACLE DB CATALOGER" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | URL                   |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName     | pluginConfigFieldValue |
      | ORACLE DRIVER BUNDLE NAME |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | USER                  |                        |
    And user press "TAB" key using key press event
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | PASSWORD              |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName                 | errorMessage                                        |
      | NAME                      | Name field should not be empty                      |
      | URL                       | URL field should not be empty                       |
      | ORACLE DRIVER BUNDLE NAME | Oracle Driver Bundle Name field should not be empty |
      | USER                      | User field should not be empty                      |
      | PASSWORD                  | Password field should not be empty                  |


  ##6628249##
  @webtest @jdbc @MLP-9602
  Scenario: SC#1-Verify table name alone cannot be provided without a schema name in Oracle Database cataloger filters.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "OracleDBCataloger" plugin config list in Plugin Manager page
    And user add button in "ORACLE DB CATALOGER" section
    And user clicks on Add button near to field "SCHEMA/TABLE FILTERS"
    And user clicks on Add button near to field "TABLE FILTERS"
    And user enter the following values in filter page
      | filterPageFieldName | filterPageFieldValue |
      | TABLE NAME          | QATest               |
    And user click Apply button in "TABLES" page
    And user verify apply button is "disabled" in Plugin Configuration Page


  ##6650597##
  @webtest @jdbc @MLP-9605
  Scenario: SC#1-Verify proper error message is shown if mandatory fields are not filled in OracleDBAnalyzer plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "OracleDBAnalyzer" plugin config list in Plugin Manager page
    And user add button in "ORACLE DB ANALYZER" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  |                        |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | NAME      | Name field should not be empty |


  ##6478515## ##6477895##
  @webtest @jdbc
  Scenario: SC#1-Verify Oracle cataloger throws error when the jdbc url is for databases other than oracle or incorrect
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "PLUGIN MANAGER" dashboard
    And user "Click" on "ANALYSIS PLUGINS" tab in "Plugin Manager" page
    And user "navigates" to "OracleDBCataloger" plugin config list in Plugin Manager page
    And user add button in "ORACLE DB CATALOGER" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue                                 |
      | URL                   | jdbc:postgresql://decheqaperf01v.asg.com:5432/postgres |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                                                                                                    |
      | URL       | UnSupported Oracle JDBC URL Format. Sample Format : jdbc:oracle:thin:@<<hostname>>:<<port>>:<<database or sid>> |
    And user clicks the close button inside the field "PLUGIN CONFIGURATION" panel
    And user add button in "ORACLE DB CATALOGER" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue                         |
      | URL                   | jdbc:test:thin:@gechcae-col1.asg.com:1521:col2 |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                                                                                                    |
      | URL       | UnSupported Oracle JDBC URL Format. Sample Format : jdbc:oracle:thin:@<<hostname>>:<<port>>:<<database or sid>> |


  ##6477896##
  @webtest @jdbc
  Scenario: SC#2-Verify Oracle cataloger does not collect any DB items and log throws error when the driver bundle name is for databases other than oracle
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                   | body                                        | response code | response message                   | jsonPath                                                                | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                     | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                                    |                                                                         | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                  |                                             | 200           | OracleCatalogerWithWrongBundleName |                                                                         |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithWrongBundleName |                                             | 200           | IDLE                               | $.[?(@.configurationName=='OracleCatalogerWithWrongBundleName')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithWrongBundleName  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                                    |                                                                         |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithWrongBundleName |                                             | 200           | IDLE                               | $.[?(@.configurationName=='OracleCatalogerWithWrongBundleName')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "No JDBC connection could be established" in Analysis Log of IDC UI


  ##6477896##
  @webtest @jdbc
  Scenario: SC#3-Verify Oracle cataloger does not collect any DB items and log throws error when the driver name is for databases other than oracle
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                   | body                                        | response code | response message                   | jsonPath                                                                | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                     | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                                    |                                                                         | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                  |                                             | 200           | OracleCatalogerWithWrongDriverName |                                                                         |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithWrongDriverName |                                             | 200           | IDLE                               | $.[?(@.configurationName=='OracleCatalogerWithWrongDriverName')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithWrongDriverName  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                                    |                                                                         |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithWrongDriverName |                                             | 200           | IDLE                               | $.[?(@.configurationName=='OracleCatalogerWithWrongDriverName')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "'com.postgres.jdbc' was not found" in Analysis Log of IDC UI


  ##6477896##
  @webtest @jdbc
  Scenario: SC#4-Verify Oracle cataloger does not collect any DB items and log throws error when the driver version is for databases other than oracle
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                      | body                                        | response code | response message                      | jsonPath                                                                   | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                        | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                                       |                                                                            | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                     |                                             | 200           | OracleCatalogerWithWrongDriverVersion |                                                                            |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithWrongDriverVersion |                                             | 200           | IDLE                                  | $.[?(@.configurationName=='OracleCatalogerWithWrongDriverVersion')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithWrongDriverVersion  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                                       |                                                                            |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithWrongDriverVersion |                                             | 200           | IDLE                                  | $.[?(@.configurationName=='OracleCatalogerWithWrongDriverVersion')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "Bundle oracle.jdbc.OracleDriver not found" in Analysis Log of IDC UI


  ##6628256##
  @webtest @jdbc @MLP-9602
  Scenario: SC#5-Verify OracleDatabaseCataloger scans and collects data properly if the node condition is given
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                    | body                                        | response code | response message                 | jsonPath                                                              | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                      | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                                  |                                                                       | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                   |                                             | 200           | OracleCatalogerWithNodeCondition |                                                                       |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/InternalNode/cataloger/OracleDBCataloger/OracleCatalogerWithNodeCondition |                                             | 200           | IDLE                             | $.[?(@.configurationName=='OracleCatalogerWithNodeCondition')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/InternalNode/cataloger/OracleDBCataloger/OracleCatalogerWithNodeCondition  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                                  |                                                                       |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/InternalNode/cataloger/OracleDBCataloger/OracleCatalogerWithNodeCondition |                                             | 200           | IDLE                             | $.[?(@.configurationName=='OracleCatalogerWithNodeCondition')].status |              |                |
      |                  |       |       | Post            | searches/fulltext/synchronize/ORACLE%20CATALOG                                                         |                                             | 200           |                                  |                                                                       |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "Select All 35 items" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getSchemeList | rowCount     |
    Then Postgres item count for "Field" attribute should be "35"


  ##6650598##
  @webtest @MLP-9605
  Scenario:  SC#6-Verify OracleDBAnalyzer scans and collects data properly if the node condition is given
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                     | body                                | response code | response message                | jsonPath                                                             |
      | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                                     |                                     | 200           | OracleAnalyzerWithNodeCondition |                                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithNodeCondition |                                     | 200           | IDLE                            | $.[?(@.configurationName=='OracleAnalyzerWithNodeCondition')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithNodeCondition  | ida/jdbcAnalyzerPayloads/empty.json | 200           |                                 |                                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithNodeCondition |                                     | 200           | IDLE                            | $.[?(@.configurationName=='OracleAnalyzerWithNodeCondition')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "ORACLE_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Full Name" attribute under "Tags" facets in Item Search results page
    Then results panel "items count" should be displayed as "Select All 1 items" in Item Search results page
    And following item(s) should get displayed in item search results in Subject area page
      | itemName  |
      | FULL_NAME |


  ##6628244##
  @webtest @jdbc @MLP-5641 @MLP-9602
  Scenario: SC#7-Verify the Oracle Table should not have constraints window if the table is not having any constraints.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                        | body                                        | response code | response message                        | jsonPath                                                                     | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                          | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                                         |                                                                              | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                       |                                             | 200           | OracleCatalogerWithSchemaAndTableFilter |                                                                              |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                                         |                                                                              |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "ORACLE_TAG_DETAILS" items at top end
    Then user verify "catalog not contains" any "Constriant" attribute under "Metadata Type" facets


  ##6628257## ##6204189##
  @webtest @jdbc @MLP-9602 @MLP-6281
  Scenario: SC#8-Verify OracleDatabaseCataloger collects DB items like Cluster, Service, Database, Schema,Table, Columns,Constraints,Index,Routine,Views,Triggers when the OracleDatabaseCataloger is run.(No filters)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                | body                                        | response code | response message | jsonPath                                             | endpointType | itemName       |
      | application/json | raw   | false | DeleteAndCreate | settings/catalogs                                                                  | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                  |                                                      | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                               |                                             | 200           | OracleCataloger  |                                                      |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCataloger |                                             | 200           | IDLE             | $.[?(@.configurationName=='OracleCataloger')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCataloger  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                  |                                                      |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCataloger |                                             | 200           | IDLE             | $.[?(@.configurationName=='OracleCataloger')].status |              |                |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" from Catalog list
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField     | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getClusterName | rowCount     |
    Then Postgres item count for "Field" attribute should be "1"
    And user performs "item click" on "gechcae-col1.asg.com" item from search results
    Then user "verify metadata property values" with following expected parameters for item "gechcae-col1.asg.com"
      | ID                         |
      | ORACLE CATALOG.Cluster:::1 |
    And user select "ORACLE CATALOG" from Catalog list
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getServiceMD | rowCount     |
    Then Postgres item count for "Field" attribute should be "1"
    And user performs "item click" on "ORACLE:1521" item from search results
    Then user "verify metadata property values" with following expected parameters for item "ORACLE:1521"
      | ID                         |
      | ORACLE CATALOG.Service:::1 |
    And user select "ORACLE CATALOG" from Catalog list
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField      | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getDatabaseName | rowCount     |
    Then Postgres item count for "Field" attribute should be "1"
    And user performs "item click" on "COL2" item from search results
    Then user "verify metadata property values" with following expected parameters for item "COL2"
      | Storage type                                                                                                                                                     |
      | OracleOracle Database 11g Enterprise Edition Release 11.2.0.2.0 - 64bit Production With the Partitioning, OLAP, Data Mining and Real Application Testing options |
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "COLLECTOR" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField        | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getTableViewList7 | name       | returnstringlist | resultsInList |
    And user "verifies" the "TABLES" Item view page result "retainslist" value with Postgres DB
    And user clicks on close button in the item full view page
    And user performs "item click" on "COLLECTOR" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField    | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getTableList6 | name       | returnstringlist | resultsInList |
    And user "verifies" the "TABLES" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" from Catalog list
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getSchemeList | rowCount     |
    Then Postgres item count for "Field" attribute should be "39"
    And user select "ORACLE CATALOG" catalog and search "HR" items at top end
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField         | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getConstraintCount | rowCount     |
    Then Postgres item count for "Field" attribute should be "20"
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "ORACLE_DIFFDATATYPES [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField     | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getColumnCount | rowCount     |
    Then Postgres item count for "Field" attribute should be "21"
    And user select "ORACLE CATALOG" catalog and search "HR" items at top end
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getIndexCount | rowCount     |
    Then Postgres item count for "Field" attribute should be "41"
    And user performs "facet selection" in "Index" attribute under "Metadata Type" facets in Item Search results page
    And user performs "definite facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField      | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getRoutineCount | rowCount     |
    Then Postgres item count for "Field" attribute should be "2"
    And user performs "definite facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Trigger" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField      | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getTriggerCount | rowCount     |
    Then Postgres item count for "Field" attribute should be "3"



  ##6628259##
  @webtest @jdbc @MLP-9602
  Scenario: SC#8-Verify the technology tags got assigned to all Oracle DB items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verifies presence" of technology tags for the following parameters
      | catalogName    | name           | facet | Tag                         |
      | ORACLE CATALOG | Synonym        | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Column         | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Table          | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Partition      | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Index          | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | DataField      | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | UserRole       | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | User           | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Constraint     | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | DataType       | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Routine        | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Schema         | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Trigger        | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | File           | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | RoutinePackage | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | DatabaseLink   | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Sequence       | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Tablespace     | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | IndexExtension | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Analysis       | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Cluster        | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Configuration  | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Database       | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Service        | Type  | Oracle,Relational Databases |


  @jdbc
  Scenario: SC#9-Start Analyzer Plugin config
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                 | body                                               | response code | response message | jsonPath                                            | endpointType | itemName |
      | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                                 | ida/jdbcAnalyzerPayloads/oracleAnalyzerConfig.json | 204           |                  |                                                     |              |          |
      |                  |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                 |                                                    | 200           | OracleAnalyzer   |                                                     |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzer |                                                    | 200           | IDLE             | $.[?(@.configurationName=='OracleAnalyzer')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzer  | ida/jdbcAnalyzerPayloads/empty.json                | 200           |                  |                                                     |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzer |                                                    | 200           | IDLE             | $.[?(@.configurationName=='OracleAnalyzer')].status |              |          |


  ##6650599##
  @webtest @jdbc @MLP-9605
  Scenario: SC#9-Verify the Technology tag appears properly for analysis item added by OracleDBAnalyzer
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "dynamic item click" on "dataanalyzer" item from search results
    Then the following tags "Oracle,Relational Databases" should get displayed for the column "dataanalyzer"
    Then user "verifies presence" of technology tags for the following parameters
      | catalogName    | name           | facet | Tag                         |
      | ORACLE CATALOG | Synonym        | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Column         | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Table          | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Partition      | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Index          | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | DataField      | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | UserRole       | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | User           | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Constraint     | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | DataType       | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Routine        | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Schema         | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Trigger        | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | File           | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | RoutinePackage | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | DatabaseLink   | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Sequence       | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Tablespace     | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | IndexExtension | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Cluster        | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Configuration  | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Database       | Type  | Oracle,Relational Databases |
      | ORACLE CATALOG | Service        | Type  | Oracle,Relational Databases |


  @webtest @jdbc @MLP-5358
  Scenario: SC#9-verify the Created Table Name in oracleDB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "ORACLE_TAG_DETAILS" items at top end
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_TAG_DETAILS" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getTableType1 | resultsInMap |
    Then following "metadata property values" for item "ORACLE_TAG_DETAILS" should match with postgres values stored in "jsonHashMap"
      | Table Type | Number of rows |


  ##6646193##
  @webtest @jdbc @MLP-5358 @MLP-9605
  Scenario: SC#9-Verify the Column with datatype varchar in Oracle DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "ORACLE_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "FULL_NAME" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at | Last analyzed at |
    Then user "verify metadata property values" with following expected parameters for item "FULL_NAME"
      | characterLength | columnId | columnType | columnUsed | Data type | datatypeName | isEncrypted | Maximum length | Maximum value | Minimum length | Minimum value | Number of non null values | Percentage of non null values | Number of null values | nulls | Number of unique values | Percentage of unique values |
      | 40              | 2        | table      | NO         | VARCHAR   | VARCHAR2     | NO          | 14             | Lionel Messi  | 11             | Alex Ferguson | 4                         | 100                           | 0                     | YES   | 4                       | 100                         |
    Then user "verify unique metadata property values" with following expected parameters for item "FULL_NAME"
      | Length |
      | 40     |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField               | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getColumnAnalyzedDetails | resultsInMap |
    Then following "metadata property values" for item "FULL_NAME" should match with postgres values stored in "map"
      | characterLength | columnId | columnType | columnUsed | Data type | datatypeName | isEncrypted | Maximum length | Maximum value | Minimum length | Minimum value | Number of non null values | Percentage of non null values | Number of null values | nulls | Number of unique values | Percentage of unique values |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField                     | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getColumnAnalyzedUniqueDetails | resultsInMap |
    Then following "metadata property values" for item "FULL_NAME" should match with postgres values stored in "uniquemap"
      | Length |




  ##6646194##
  @webtest @jdbc @MLP-5358 @MLP-9605
  Scenario: SC#9-Verify the Column with datatype decimal in Oracle DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "ORACLE_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLEDB_SALARY" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at | histogram | Last analyzed at |
    Then user "verify metadata property values" with following expected parameters for item "ORACLEDB_SALARY"
      | Average | characterLength | columnId | columnType | columnUsed | dataPrecision | Data type | datatypeName | isEncrypted | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Number of null values | nulls | scale | Standard deviation | Number of unique values | Percentage of unique values | Variance |
      | 95.725  | 0               | 10       | table      | NO         | 6             | DECIMAL   | NUMBER       | NO          | 100.9         | 95.725 | 90.55         | 2                         | 50                            | 2                     | YES   | 2     | 7.318555185280767  | 2                       | 50                          | 53.56125 |
    Then user "verify unique metadata property values" with following expected parameters for item "ORACLEDB_SALARY"
      | Length |
      | 22     |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField                | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getdataTypeDecimalDetails | resultsInMap |
    Then following "metadata property values" for item "ORACLEDB_SALARY" should match with postgres values stored in "map"
      | characterLength | columnId | columnType | columnUsed | dataPrecision | Data type | datatypeName | isEncrypted | Maximum value | Minimum value | Number of non null values | Percentage of non null values | Number of null values | nulls | scale | Number of unique values | Percentage of unique values |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField                      | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getdataTypeUniqueDecimalDetails | resultsInMap |
    Then following "metadata property values" for item "ORACLEDB_SALARY" should match with postgres values stored in "uniquemap"
      | Length |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField                   | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getdataTypeBigDecimalDetails | resultsInMap |
    Then following "metadata property values" for item "ORACLEDB_SALARY" should match with postgres values stored in "hashMapWithBigDecimals"
      | Average | Median | Standard deviation | Variance |


  ##6646197##
  @webtest @jdbc @MLP-5358 @MLP-9605
  Scenario: SC#9-Verify the Column with datatype timestamp in Oracle DB which should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "ORACLE_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLEDB_LOCALTIME" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at | Last analyzed at | Maximum value | Minimum value | Number of unique values | Percentage of unique values |
    Then user "verify metadata property values" with following expected parameters for item "ORACLEDB_LOCALTIME"
      | characterLength | columnId | columnType | columnUsed | Data type | datatypeName | isEncrypted | Number of non null values | Percentage of non null values | Number of null values | nulls | scale |
      | 0               | 11       | table      | NO         | TIMESTAMP | TIMESTAMP(0) | NO          | 4                         | 100                           | 0                     | YES   | 0     |
    Then user "verify unique metadata property values" with following expected parameters for item "ORACLEDB_LOCALTIME"
      | Length |
      | 7      |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField                  | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getdataTypeTimestampDetails | resultsInMap |
    Then following "metadata un property values" for item "ORACLEDB_LOCALTIME" should match with postgres values stored in "map"
      | characterLength | columnId | columnType | columnUsed | Data type | datatypeName | isEncrypted | Maximum value | Minimum value | Number of non null values | Percentage of non null values | Number of null values | nulls | scale | Number of unique values | Percentage of unique values |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField                        | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getdataTypeTimestampUniqueDetails | resultsInMap |
    Then following "metadata un property values" for item "ORACLEDB_LOCALTIME" should match with postgres values stored in "uniquemap"
      | Length |


  ##6646192##
  @webtest @jdbc @MLP-6064 @MLP-9605
  Scenario: SC#9-Verify the data sampling information in OracleDB
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "ITEM AND LIST VIEW MANAGER" dashboard
    And user configure below parameters for item "itemView_Table" from "ITEM AND LIST VIEW MANAGER" list
      | CATALOGS       | SUPPORTED TYPES |
      | ORACLE CATALOG | DataSample      |
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "ORACLE_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_TAG_DETAILS" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GENDER | FULL_NAME      | EMAIL            | STATE | PHONE_NUMBER | EMPLOYEE_ID | POSTAL_CODE | ORACLEDB_SALARY | JOINING_DATE        | SSN         | IP_ADDRESS    |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       | 100.9           | 2013-05-08 17:02:07 | 345-53-3222 | 255.249.255.0 |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       | 90.55           | 2015-08-05 14:05:07 | 345-53-3779 | 255.249.12.0  |
      | m      | Lionel Messi   | lmessi@gmail.com | NY    | 515.123.6666 | 12          | 78576       |                 | 2011-09-14 16:42:57 | 315-53-3222 | 255.83.45.0   |
      | f      | Irina Shayk    | ishayk@gmail.com | VI    | 515.123.2580 | 13          | 48276       |                 | 2008-11-18 17:52:47 | 345-66-3222 | 255.71.255.56 |


  ##6646198##
  @jdbc @webtest @MLP-5359
  Scenario: SC#9-Verify the OracleDBAnalyzer analyze and assign tags for the columns in Oracle DB
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "ORACLE_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Social Security Number" attribute under "Tags" facets in Item Search results page
    Then results panel "items count" should be displayed as "Select All 1 items" in Item Search results page
    And following item(s) should get displayed in item search results in Subject area page
      | itemName |
      | SSN      |


  ##6191722##
  @webtest @jdbc @MLP-5641
  Scenario: SC#9-Verify the count of Schema matched UI and DB
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" from Catalog list
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "items count" should be displayed as "Select All 39 items" in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField    | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getSchemeList | rowCount     |
    Then Postgres item count for "Field" attribute should be "39"



  ##6423391##
  @jdbc @webtest @MLP-7325
  Scenario: SC#9-Verify the data profiling metadata for string,numeric,date,time,timestamp datatypes metrics does not get calculated for empty table(oracle)
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "ORACLE_EMPTY" items at top end
    And user performs "facet selection" in "COLLECTOR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "Name" sort in Item Results page
    And user performs "item click" on "DOB2" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at | Last Catalogued at |
    And user "verify metadata properties" section does not have the following values
      | Number of non null values | Maximum value | Number of non null values | Minimum value |
    And user clicks on close button in the item full view page
    And user performs "item click" on "ID" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at | Last Catalogued at |
    And user "verify metadata properties" section does not have the following values
      | Average | Maximum value | Median | Minimum value |
    And user clicks on close button in the item full view page
    And user performs "item click" on "NAME" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at | Last Catalogued at |
    And user "verify metadata properties" section does not have the following values
      | Maximum length | Maximum value | Minimum length | Minimum value |



  ##6650097##
  @jdbc @webtest @MLP-7325 @MLP-9605
  Scenario: SC#9-Verify the data profiling metadata for date,time,timestamp datatypes and should have the appropriate metadata information in IDC UI and Database(oracle)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "ORACLE_TABLE" items at top end
    And user performs "facet selection" in "COLLECTOR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "Name" sort in Item Results page
    And user performs "item click" on "DOB" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at | Last Catalogued at |
    Then user "verify metadata property values" with following expected parameters for item "DOB"
      | characterLength | columnId | columnType | columnUsed | Data type | datatypeName | isEncrypted | Maximum value         | Minimum value         | Number of non null values | Percentage of non null values | Number of null values | nulls | Number of unique values | Percentage of unique values |
      | 0               | 3        | table      | NO         | TIMESTAMP | DATE         | NO          | 2005-10-20 00:00:00.0 | 2005-10-20 00:00:00.0 | 1                         | 100                           | 0                     | YES   | 1                       | 100                         |
    Then user "verify unique metadata property values" with following expected parameters for item "DOB"
      | Length |
      | 7      |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField            | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getDataTypeMDdetails1 | resultsInMap |
    Then following "metadata property values" for item "DOB" should match with postgres values stored in "map"
      | characterLength | columnId | columnType | columnUsed | Data type | datatypeName | isEncrypted | Maximum value | Minimum value | Number of non null values | Percentage of non null values | Number of null values | nulls | Number of unique values | Percentage of unique values |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField                  | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getDataTypeUniqueMDdetails1 | resultsInMap |
    Then following "metadata property values" for item "DOB" should match with postgres values stored in "uniquemap"
      | Length |
    And user clicks on close button in the item full view page
    And user performs "item click" on "DOB2" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at | Last Catalogued at |
    Then user "verify metadata property values" with following expected parameters for item "DOB2"
      | characterLength | columnId | columnType | columnUsed | Data type | datatypeName | isEncrypted | Maximum value       | Minimum value       | Number of non null values | Percentage of non null values | Number of null values | nulls | scale | Number of unique values | Percentage of unique values |
      | 0               | 4        | table      | NO         | TIMESTAMP | TIMESTAMP(6) | NO          | 2005-05-01 06:14:00 | 2005-05-01 06:14:00 | 1                         | 100                           | 0                     | YES   | 6     | 1                       | 100                         |
    Then user "verify unique metadata property values" with following expected parameters for item "DOB2"
      | Length |
      | 11     |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField            | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getDataTypeMDdetails2 | resultsInMap |
    Then following "metadata property values" for item "DOB2" should match with postgres values stored in "map"
      | characterLength | columnId | columnType | columnUsed | Data type | datatypeName | isEncrypted | Maximum value | Minimum value | Number of non null values | Percentage of non null values | Number of null values | nulls | scale | Number of unique values | Percentage of unique values |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField                  | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getDataTypeUniqueMDdetails2 | resultsInMap |
    Then following "metadata property values" for item "DOB2" should match with postgres values stored in "uniquemap"
      | Length |
    And user clicks on close button in the item full view page
    And user performs "item click" on "DOB3" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at | Last Catalogued at | Maximum value | Minimum value |
    Then user "verify metadata property values" with following expected parameters for item "DOB3"
      | characterLength | columnId | columnType | columnUsed | Data type               | datatypeName                | isEncrypted | Number of non null values | Percentage of non null values | Number of null values | nulls | scale | Number of unique values | Percentage of unique values |
      | 0               | 5        | table      | NO         | TIMESTAMP_WITH_TIMEZONE | TIMESTAMP(6) WITH TIME ZONE | NO          | 1                         | 100                           | 0                     | YES   | 6     | 1                       | 100                         |
    Then user "verify unique metadata property values" with following expected parameters for item "DOB3"
      | Length |
      | 13     |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField            | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getDataTypeMDdetails3 | resultsInMap |
    Then following "metadata property values" for item "DOB3" should match with postgres values stored in "map"
      | characterLength | columnId | columnType | columnUsed | Data type | datatypeName | isEncrypted | Maximum value | Minimum value | Number of non null values | Percentage of non null values | Number of null values | nulls | scale | Number of unique values | Percentage of unique values |
    Then user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField                  | storeResults |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getDataTypeUniqueMDdetails3 | resultsInMap |
    Then following "metadata property values" for item "DOB3" should match with postgres values stored in "uniquemap"
      | Length |


  ##6628245##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario: SC#10-Verify Oracle cataloger scans and collects data if schema name alone is provided in filters(Oracle DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                | body                                                                                        | response code | response message                | jsonPath                                                             |
      | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                                               | ida/jdbcAnalyzerPayloads/Oracle11g/pluginConfiguration/oracleCatalogerWithSchemaConfig.json | 204           |                                 |                                                                      |
      |                  |       |       | Get          | settings/analyzers/OracleDBCataloger                                                               |                                                                                             | 200           | OracleCatalogerWithSchemaFilter |                                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter |                                                                                             | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter  | ida/jdbcAnalyzerPayloads/empty.json                                                         | 200           |                                 |                                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter |                                                                                             | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "SH" items at top end
    And user performs "facet selection" in "SH [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "SH" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField            | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getSchemaFilterIndex1 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "DEMO" items at top end
    And user performs "facet selection" in "DEMO [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DEMO" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getSchemaFilterProcedure1 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "HAS_ROUTINE" Item view page result "retainslist" value with Postgres DB
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getSchemaFilterProcedure2 | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "HAS_ROUTINE" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "COLUSER" items at top end
    And user performs "facet selection" in "COLUSER [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "COLUSER" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField              | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getSchemaFilterFunction | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "HAS_ROUTINE" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "PM" items at top end
    And user performs "facet selection" in "PM [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PM" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField            | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getSchemaFilterIndex2 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "COLLECTOR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "COLLECTOR" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField    | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getTableList1 | name       | returnstringlist | resultsInList |
    And user "verifies" the "TABLES" Item view page result "list" value with Postgres DB


  ##6628246##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario: SC#11-Verify Oracle cataloger scans and collects data if schema name and table name is provided in filters(Oracle DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                        | body                                        | response code | response message | jsonPath                                                                     | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                          | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                  |                                                                              | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                       |                                             | 200           |                  |                                                                              |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter |                                             | 200           | IDLE             | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                  |                                                                              |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter |                                             | 200           | IDLE             | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "ORACLE_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And following item(s) should get displayed in item search results in Subject area page
      | itemName           |
      | ORACLE_TAG_DETAILS |
    And user select "ORACLE CATALOG" catalog and search "HR" items at top end
    And user performs "facet selection" in "HR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "HR" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                  | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getSchema&TableFilterIndex1 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "OE" items at top end
    And user performs "facet selection" in "OE [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OE" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                  | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getSchema&TableFilterIndex2 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "IX" items at top end
    And user performs "facet selection" in "IX [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "IX" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                  | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getSchema&TableFilterIndex3 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "OWBSYS" items at top end
    And user performs "facet selection" in "OWBSYS [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OWBSYS" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                  | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getSchema&TableFilterIndex4 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB


  ##6628250##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario: SC#12-Verify Oracle cataloger scans and collects data if multiple schema names having tables in it are provided in filters(Oracle DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                  | body                                        | response code | response message                                  | jsonPath                                                                               | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                    | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                                                   |                                                                                        | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                                 |                                             | 200           | OracleCatalogerWithMultipleSchemaFilterWithTables |                                                                                        |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemaFilterWithTables |                                             | 200           | IDLE                                              | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemaFilterWithTables')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemaFilterWithTables  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                                                   |                                                                                        |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemaFilterWithTables |                                             | 200           | IDLE                                              | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemaFilterWithTables')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "COLLECTOR" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField    | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getTableList4 | name       | returnstringlist | resultsInList |
    And user "verifies" the "TABLES" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "SH" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "SH" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField    | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getTableList5 | name       | returnstringlist | resultsInList |
    And user "verifies" the "TABLES" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "OE" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OE" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                    | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getMultipleSchema&TableIndex1 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "PM" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PM" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                    | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getMultipleSchema&TableIndex2 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "COLLECTOR" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                    | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getMultipleSchema&TableIndex3 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB


  ##6628248##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario: SC#13-Verify Oracle cataloger scans and collects data if single schema name with multiple table names are provided in filters(Oracle DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                | body                                        | response code | response message                                | jsonPath                                                                             | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                  | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                                                 |                                                                                      | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                               |                                             | 200           | OracleCatalogerwithSchemaAndMultipleTableFilter |                                                                                      |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerwithSchemaAndMultipleTableFilter |                                             | 200           | IDLE                                            | $.[?(@.configurationName=='OracleCatalogerwithSchemaAndMultipleTableFilter')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerwithSchemaAndMultipleTableFilter  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                                                 |                                                                                      |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerwithSchemaAndMultipleTableFilter |                                             | 200           | IDLE                                            | $.[?(@.configurationName=='OracleCatalogerwithSchemaAndMultipleTableFilter')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" from Catalog list
    And user performs "facet selection" in "COLLECTOR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "COLLECTOR" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField    | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getTableList3 | name       | returnstringlist | resultsInList |
    And user "verifies" the "TABLES" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "OE" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OE" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                          | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getSchema&MultipleTableFilterIndex1 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "IX" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "IX" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                          | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getSchema&MultipleTableFilterIndex2 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "COLLECTOR" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                          | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getSchema&MultipleTableFilterIndex3 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "SCOTT" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "SCOTT" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                          | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getSchema&MultipleTableFilterIndex4 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB


  ##6628247## ##6204182##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario: SC#14-Verify Oracle cataloger scans and collects data if multiple schema name alone is provided in filters
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                           | body                                        | response code | response message                           | jsonPath                                                                        | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                             | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                                            |                                                                                 | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                          |                                             | 200           | OracleCatalogerWithMultipleSchemasInFilter |                                                                                 |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter |                                             | 200           | IDLE                                       | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                                            |                                                                                 |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithMultipleSchemasInFilter |                                             | 200           | IDLE                                       | $.[?(@.configurationName=='OracleCatalogerWithMultipleSchemasInFilter')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "HR" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And following item(s) should get displayed in item search results in Subject area page
      | itemName |
      | HR       |
    And user performs "item click" in "HR" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField    | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getTableList2 | name       | returnstringlist | resultsInList |
    And user "verifies" the "TABLES" Item view page result "list" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "SH" items at top end
    And user performs "definite facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" in "SH" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField              | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getMultipleSchemaIndex1 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "HR" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" in "HR" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField               | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getMultipleSchemaTrigger | NAME       | returnstringlist | resultsInList |
    And user "verifies" the "HAS_TRIGGER" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "OE" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" in "OE" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField              | columnName | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getMultipleSchemaIndex2 | INDEX_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_INDEX" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "OE" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" in "OE" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField               | columnName   | queryOperation   | storeResults  |
      | oracle       | STRUCTURED   | json/IDA.json | oracleQueries | getMultipleSchemaSynonym | SYNONYM_NAME | returnstringlist | resultsInList |
    And user "verifies" the "HAS_SYNONYM" Item view page result "retainslist" value with Postgres DB
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And following item(s) should get displayed in item search results in Subject area page
      | itemName  |
      | COLLECTOR |
    And user performs "item click" in "COLLECTOR" attribute under "Metadata Type" facets in Item Search results page
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage     | queryField    | columnName | queryOperation   | storeResults  |
      | APPDBPOSTGRES | STRUCTURED   | json/IDA.json | oracleQueries | getTableList1 | name       | returnstringlist | resultsInList |
    And user "verifies" the "TABLES" Item view page result "list" value with Postgres DB


  ##6628252## ##6204212##
  @webtest @jdbc @MLP-6281 @MLP-9602
  Scenario: SC#15-Verify Oracle cataloger scans and collects data if non existing schema name and table name are provided in filters(Oracle DB)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                                   | body                                        | response code | response message                                   | jsonPath                                                                                | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                                     | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                                                    |                                                                                         | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                                  |                                             | 200           | OracleCatalogerwithNonExistingSchemaAndTableFilter |                                                                                         |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerwithNonExistingSchemaAndTableFilter |                                             | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerwithNonExistingSchemaAndTableFilter')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerwithNonExistingSchemaAndTableFilter  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                                                    |                                                                                         |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerwithNonExistingSchemaAndTableFilter |                                             | 200           | IDLE                                               | $.[?(@.configurationName=='OracleCatalogerwithNonExistingSchemaAndTableFilter')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "ORACLE_INDEXTABLE [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_INDEXTABLE" item from search results
    And user "verify metadata properties" section has following values
      | ID |
    And user "verify metadata properties" section does not have the following values
      | Last catalogued at |
    And user clicks on close button in the item full view page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "C1" item from search results
    Then user "verify metadata properties" section has following values
      | ID |
    Then user "verify metadata properties" section does not have the following values
      | Last catalogued at |


  ##6628255##
  @webtest @jdbc @MLP-6942 @MLP-9602
  Scenario: SC#16-Verify the error message when Configuration credentials are incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                        | body                                        | response code | response message | jsonPath                                                                     | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                          | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                  |                                                                              | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                       |                                             | 200           |                  |                                                                              |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectCredentials |                                             | 200           | IDLE             | $.[?(@.configurationName=='OracleCatalogerWithIncorrectCredentials')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectCredentials  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                  |                                                                              |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectCredentials |                                             | 200           | IDLE             | $.[?(@.configurationName=='OracleCatalogerWithIncorrectCredentials')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "invalid username/password" in Analysis Log of IDC UI


  ##6628254##
  @webtest @jdbc @MLP-9602
  Scenario: SC#17-Verify OracleDatabaseCataloger does not scans and collects and any data if database passed in URL is incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                      | body                                        | response code | response message | jsonPath                                                                   | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                        | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                  |                                                                            | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                     |                                             | 200           |                  |                                                                            |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithWrongDatabaseInURL |                                             | 200           | IDLE             | $.[?(@.configurationName=='OracleCatalogerWithWrongDatabaseInURL')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithWrongDatabaseInURL  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                  |                                                                            |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithWrongDatabaseInURL |                                             | 200           | IDLE             | $.[?(@.configurationName=='OracleCatalogerWithWrongDatabaseInURL')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "No JDBC connection could be established" in Analysis Log of IDC UI


  @webtest @jdbc @MLP-6948
  Scenario: SC#18-Verify the error message when Configuration url is incorrect
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                | body                                        | response code | response message | jsonPath                                                             | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                  | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                  |                                                                      | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                               |                                             | 200           |                  |                                                                      |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectURL |                                             | 200           | IDLE             | $.[?(@.configurationName=='OracleCatalogerWithIncorrectURL')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectURL  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                  |                                                                      |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithIncorrectURL |                                             | 200           | IDLE             | $.[?(@.configurationName=='OracleCatalogerWithIncorrectURL')].status |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" from Catalog list
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "dynamic item click" on "cataloger" item from search results
    And user click on Analysis log link in DATA widget section
    And user "verify analysis log contains" presence of "Caused by: java.net.UnknownHostException:" in Analysis Log of IDC UI



#  @jdbc
#  Scenario Outline: : update policy engine with new tag
#    Given configure a new REST API for the service "PolicyEngine"
#    And user makes a REST Call for Get request with url "policies" and store value of json path"$..[?(@.name=='PII - BusinessGlossary')].id"
#    And user makes a REST Call for GET request with url "policies/dynamicID" and save the response in file "rest/payloads/ida/jdbcAnalyzerPayloads/PIIPolicy.json"
#    And user copy the data from "rest/payloads/ida/jdbcAnalyzerPayloads/PIIPolicy.json" file to "rest/payloads/ida/jdbcAnalyzerPayloads/PIIPolicyUpdate.json" file
#    And user add new object "values" to file "rest/payloads/ida/jdbcAnalyzerPayloads/PIIPolicyUpdate.json" with following params using json path "$.actions"
#      | jsonNode     | jsonValue                                                                                                |
#      | namePattern  |                                                                                                          |
#      | matchEmpty   | false                                                                                                    |
#      | typePattern  |                                                                                                          |
#      | minimumRatio | 0.7                                                                                                      |
#      | matchFull    | true                                                                                                     |
#      | dataPattern  | \\\d{4}[\\\/\\\-](0?[1-9]\|1[012])[\\\/\\\-](0?[1-9]\|[12][0-9]\|3[01]) [0-2][0-9]:[0-5][0-9]:[0-5][0-9] |
#      | tags         | Date                                                                                                     |
#    And user "add" the json file "ida/jdbcAnalyzerPayloads/PIIPolicyUpdate.json" file for following values
#      | jsonPath       | jsonKey | jsonValues               |
#      | $.actions.[11] | id      | structured_data_analysis |
#    And endpoint for "<ServiceName>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Header      | Query | Param | type | url                | body                                          | response code | response message |
#      | PolicyEngine | multiHeader |       |       | Put  | policies/dynamicID | ida/jdbcAnalyzerPayloads/PIIPolicyUpdate.json | 200           |                  |


#  @jdbc @webtest @MLP-5359
#  Scenario: Verify the newly created Tag is assigned to an Item
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type            | url                                                                                                        | body                                        | response code | response message                        | jsonPath                                                                     | endpointType | itemName       |
#      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                          | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                                         |                                                                              | catalog      | ORACLE CATALOG |
#      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                       |                                             | 200           | OracleCatalogerWithSchemaAndTableFilter |                                                                              |              |                |
#      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |              |                |
#      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter  |                                             | 200           |                                         |                                                                              |              |                |
#      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |              |                |
#      |                  |       |       | Get             | settings/analyzers/OracleDBAnalyzer                                                                        |                                             | 200           | OracleAnalyzer                          |                                                                              |              |                |
#      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzer                        |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzer')].status                          |              |                |
#      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzer                         |                                             | 200           |                                         |                                                                              |              |                |
#      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzer                        |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzer')].status                          |              |                |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "ORACLE CATALOG" from Catalog list
#    And user performs "facet selection" in "Date" attribute under "Tags" facets in Item Search results page
#    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
#    And following item(s) should get displayed in item search results in Subject area page
#      | itemName     |
#      | JOINING_DATE |


#  @jdbc
#  Scenario Outline: update the policy pattern tag
#    Given configure a new REST API for the service "PolicyEngine"
#    And user makes a REST Call for Get request with url "policies" and store value of json path"$..[?(@.name=='PII - BusinessGlossary')].id"
#    And user "update" the json file "ida/jdbcAnalyzerPayloads/PIIPolicyUpdate.json" file for following values
#      | jsonPath                           | jsonValues                               |
#      | $..[?(@.tags=='Date')].dataPattern | (m\|M\|male\|Male\|f\|F\|female\|Female) |
#    And endpoint for "<ServiceName>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Header      | Query | Param | type | url                | body                                          | response code | response message |
#      | PolicyEngine | multiHeader |       |       | Put  | policies/dynamicID | ida/jdbcAnalyzerPayloads/PIIPolicyUpdate.json | 200           |                  |


#  @jdbc @webtest @MLP-5359
#  Scenario: Verify the updated Tag is assigned to an Item
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type            | url                                                                                                        | body                                        | response code | response message                        | jsonPath                                                                     | endpointType | itemName       |
#      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                          | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                                         |                                                                              | catalog      | ORACLE CATALOG |
#      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                       |                                             | 200           | OracleCatalogerWithSchemaAndTableFilter |                                                                              |              |                |
#      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |              |                |
#      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter  |                                             | 200           |                                         |                                                                              |              |                |
#      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |              |                |
#      |                  |       |       | Get             | settings/analyzers/OracleDBAnalyzer                                                                        |                                             | 200           | OracleAnalyzer                          |                                                                              |              |                |
#      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzer                        |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzer')].status                          |              |                |
#      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzer                         |                                             | 200           |                                         |                                                                              |              |                |
#      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzer                        |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzer')].status                          |              |                |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "ORACLE CATALOG" from Catalog list
#    And user performs "facet selection" in "Date" attribute under "Tags" facets in Item Search results page
#    Then results panel "items count" should be displayed as "1 item was found" in Item Search results page
#    And following item(s) should get displayed in item search results in Subject area page
#      | itemName |
#      | GENDER   |

#  @jdbc
#  Scenario Outline: user reset the default policy engine tags
#    Given configure a new REST API for the service "PolicyEngine"
#    And user makes a REST Call for Get request with url "policies" and store value of json path"$..[?(@.name=='PII - BusinessGlossary')].id"
#    And endpoint for "<ServiceName>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Header       | Query | Param | type | url                | body                                    | response code | response message |
#      | PolicyEngine | Content-Type |       |       | Put  | policies/dynamicID | ida/jdbcAnalyzerPayloads/PIIPolicy.json | 200           |                  |


#  ##6271719##
#  @jdbc @webtest @MLP-5359
#  Scenario: Verify the removed Tag is not present after Analyzing
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type            | url                                                                                                        | body                                        | response code | response message                        | jsonPath                                                                     | endpointType | itemName       |
#      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                          | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                                         |                                                                              | catalog      | ORACLE CATALOG |
#      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                       |                                             | 200           | OracleCatalogerWithSchemaAndTableFilter |                                                                              |              |                |
#      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |              |                |
#      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter  |                                             | 200           |                                         |                                                                              |              |                |
#      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |              |                |
#      |                  |       |       | Get             | settings/analyzers/OracleDBAnalyzer                                                                        |                                             | 200           | OracleAnalyzer                          |                                                                              |              |                |
#      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzer                        |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzer')].status                          |              |                |
#      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzer                         |                                             | 200           |                                         |                                                                              |              |                |
#      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzer                        |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzer')].status                          |              |                |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "ORACLE CATALOG" from Catalog list
#    Then user verify "catalog not contains" any "Date" attribute under "Tags" facets


  ##6651867##
  @webtest @jdbc @MLP-9605
  Scenario: SC#19-Verify OracleDbAnalyzer does data sampling when sampling count is varied.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type            | url                                                                                                        | body                                        | response code | response message                        | jsonPath                                                                     | endpointType | itemName       |
      | application/json |       |       | DeleteAndCreate | settings/catalogs                                                                                          | ida/jdbcAnalyzerPayloads/oracleCatalog.json | 204           |                                         |                                                                              | catalog      | ORACLE CATALOG |
      |                  |       |       | Get             | settings/analyzers/OracleDBCataloger                                                                       |                                             | 200           | OracleCatalogerWithSchemaAndTableFilter |                                                                              |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter  | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                                         |                                                                              |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |              |                |
      |                  |       |       | Get             | settings/analyzers/OracleDBAnalyzer                                                                        |                                             | 200           | OracleAnalyzerWithMinSampleDataCount    |                                                                              |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMinSampleDataCount  |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzerWithMinSampleDataCount')].status    |              |                |
      |                  |       |       | Post            | /extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMinSampleDataCount   | ida/jdbcAnalyzerPayloads/empty.json         | 200           |                                         |                                                                              |              |                |
      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleAnalyzerWithMinSampleDataCount  |                                             | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzerWithMinSampleDataCount')].status    |              |                |
      |                  |       |       | Post            | searches/fulltext/synchronize/ORACLE%20CATALOG                                                             |                                             | 200           |                                         |                                                                              |              |                |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "ITEM AND LIST VIEW MANAGER" dashboard
    And user configure below parameters for item "itemView_Table" from "ITEM AND LIST VIEW MANAGER" list
      | CATALOGS       | SUPPORTED TYPES |
      | ORACLE CATALOG | DataSample      |
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "ORACLE_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_TAG_DETAILS" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GENDER | FULL_NAME      | EMAIL            | STATE | PHONE_NUMBER | EMPLOYEE_ID | POSTAL_CODE | ORACLEDB_SALARY | JOINING_DATE        | SSN         | IP_ADDRESS    |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       | 100.9           | 2013-05-08 17:02:07 | 345-53-3222 | 255.249.255.0 |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       | 90.55           | 2015-08-05 14:05:07 | 345-53-3779 | 255.249.12.0  |



  ##6767888##
  @webtest
  Scenario: SC#19-Verify OracleDbAnalyzer does data sampling,data profiling and pattern matching properly when analyzer is run on the cataloged item which has filters.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user select "ORACLE CATALOG" catalog and search "COLLECTOR" items at top end
    And user performs "facet selection" in "ORACLE_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_TAG_DETAILS" item from search results
    And user "verify metadata properties" section has following values
      | Last analyzed at | Last catalogued at |
    Then user "verify metadata property values" with following expected parameters for item "ORACLE_TAG_DETAILS"
      | Table Type |
      | TABLE      |
    And user clicks on close button in the item full view page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLEDB_LOCALTIME" item from search results
    Then user "verify metadata properties" section has following values
      | Last catalogued at | Last analyzed at | Maximum value | Minimum value | columnUsed | Number of unique values | Percentage of unique values |
    Then user "verify metadata property values" with following expected parameters for item "ORACLEDB_LOCALTIME"
      | characterLength | columnId | columnType | Data type | datatypeName | isEncrypted | Number of non null values | Percentage of non null values | Number of null values | nulls | scale |
      | 0               | 11       | table      | TIMESTAMP | TIMESTAMP(0) | NO          | 4                         | 100                           | 0                     | YES   | 0     |
    And user select "ORACLE CATALOG" catalog and search "TABLE_PRIMARY" items at top end
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TABLE_PRIMARY" item from search results
    And user "verify metadata properties" section has following values
      | ID | Table Type |
    And user "verify metadata properties" section does not have the following values
      | Last analyzed at | Last catalogued at |
    And user clicks on close button in the item full view page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "SUPPLIER_ID" item from search results
    And user "verify metadata properties" section has following values
      | ID |
    And user "verify metadata properties" section does not have the following values
      | Last analyzed at | Last catalogued at |


  @jdbc
  Scenario: SC#20-Create OracleDB PostProcessor Plugin config and start it
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                | body                                                                                        | response code | response message                | jsonPath                                                             |
      | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                                               | ida/jdbcAnalyzerPayloads/Oracle11g/pluginConfiguration/oracleCatalogerWithSchemaConfig.json | 204           |                                 |                                                                      |
      |                  |       |       | Get          | settings/analyzers/OracleDBCataloger                                                               |                                                                                             | 200           | OracleCatalogerWithSchemaFilter |                                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter |                                                                                             | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter  | ida/jdbcAnalyzerPayloads/empty.json                                                         | 200           |                                 |                                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter |                                                                                             | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |
      |                  |       |       | Put          | settings/analyzers/OracleDBPostProcessor                                                           | ida/jdbcAnalyzerPayloads/OraclePostProcessorConfig.json                                     | 204           |                                 |                                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/dataanalyzer/OracleDBPostProcessor/OraclePostProcessor   |                                                                                             | 200           | IDLE                            | $.[?(@.configurationName=='OraclePostProcessor')].status             |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/dataanalyzer/OracleDBPostProcessor/OraclePostProcessor    | ida/jdbcAnalyzerPayloads/empty.json                                                         | 200           |                                 |                                                                      |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/dataanalyzer/OracleDBPostProcessor/OraclePostProcessor   |                                                                                             | 200           | IDLE                            | $.[?(@.configurationName=='OraclePostProcessor')].status             |



  ##6654828##
  @webtest @MLP-9604
  Scenario: SC#20-Verify OraclePostProcessor generates lineage for Table to Table(through procedure)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "ITEM AND LIST VIEW MANAGER" dashboard
    And user configure below parameters for item "itemView_Table" from "ITEM AND LIST VIEW MANAGER" list
      | CATALOGS       | SUPPORTED TYPES |
      | ORACLE CATALOG | LineageHop      |
    And user select "ORACLE CATALOG" catalog and search "PROT2T" items at top end
    And user performs "facet selection" in "COLLECTOR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PROT2T" item from search results
    Then user verifies the lineage for "PROT2T" in "ORACLE CATALOG" catalog with following values
      | Table    | Type    | getSourceJsonPath                   | getTargetJsonPath                   | getLineageHopName                       | mode | payloadFile                                       | dir                              | LineageNames                  |
      | OCPPT2T1 | Routine | $..edges.[?(@.mode=='COPY')].source | $..edges.[?(@.mode=='COPY')].target | $..[?(@.caption=='Lineage Hops')]..name | COPY | ida/jdbcAnalyzerPayloads/OraclePostProcessor.json | $..edges.[?(@.mode=='COPY')].dir | LINEAGE SOURCE,LINEAGE TARGET |
    Then user verifies the "source" content in "SQLSource"
      | tabName    | DATA             |
      | jsonPath   | json/IDA.json    |
      | queryPage  | oracleQueries    |
      | queryField | createProcedure1 |



  ##6654879##
  @webtest @MLP-9604
  Scenario: SC#20-Verify OraclePostProcessor generates lineage for View to Table(through procedure)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "ITEM AND LIST VIEW MANAGER" dashboard
    And user configure below parameters for item "itemView_Table" from "ITEM AND LIST VIEW MANAGER" list
      | CATALOGS       | SUPPORTED TYPES |
      | ORACLE CATALOG | LineageHop      |
    And user select "ORACLE CATALOG" catalog and search "PROV2T" items at top end
    And user performs "facet selection" in "COLLECTOR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PROV2T" item from search results
    Then user verifies the lineage for "PROV2T" in "ORACLE CATALOG" catalog with following values
      | Table   | Type    | getSourceJsonPath                   | getTargetJsonPath                   | getLineageHopName                       | mode | payloadFile                                       | dir                              | LineageNames                  |
      | OCPPV2T | Routine | $..edges.[?(@.mode=='COPY')].source | $..edges.[?(@.mode=='COPY')].target | $..[?(@.caption=='Lineage Hops')]..name | COPY | ida/jdbcAnalyzerPayloads/OraclePostProcessor.json | $..edges.[?(@.mode=='COPY')].dir | LINEAGE SOURCE,LINEAGE TARGET |
    Then user verifies the "source" content in "SQLSource"
      | tabName    | DATA             |
      | jsonPath   | json/IDA.json    |
      | queryPage  | oracleQueries    |
      | queryField | createProcedure2 |
    And user select "ORACLE CATALOG" catalog and search "OCPPVIEW" items at top end
    And user performs "facet selection" in "COLLECTOR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OCPPVIEW" item from search results
    Then user verifies the lineage for "OCPPVIEW" in "ORACLE CATALOG" catalog with following values
      | Table | Type  | getSourceJsonPath                   | getTargetJsonPath                   | getLineageHopName                       | mode | payloadFile                                       | dir                              | LineageNames          |
      |       | Table | $..edges.[?(@.mode=='VIEW')].source | $..edges.[?(@.mode=='VIEW')].target | $..[?(@.caption=='Lineage Hops')]..name | VIEW | ida/jdbcAnalyzerPayloads/OraclePostProcessor.json | $..edges.[?(@.mode=='VIEW')].dir | LINEAGEDOWN,LINEAGEUP |



  ##6654902##
  @webtest @MLP-9604
  Scenario: SC#20-Verify OraclePostProcessor generates lineage for Table to Table(through function)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "ITEM AND LIST VIEW MANAGER" dashboard
    And user configure below parameters for item "itemView_Table" from "ITEM AND LIST VIEW MANAGER" list
      | CATALOGS       | SUPPORTED TYPES |
      | ORACLE CATALOG | LineageHop      |
    And user select "ORACLE CATALOG" catalog and search "OCPPTESTFUNCTION" items at top end
    And user performs "facet selection" in "COLLECTOR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OCPPTESTFUNCTION" item from search results
    Then user verifies the lineage for "OCPPTESTFUNCTION" in "ORACLE CATALOG" catalog with following values
      | Table     | Type    | getSourceJsonPath                   | getTargetJsonPath                   | getLineageHopName                       | mode | payloadFile                                       | dir                              | LineageNames                  |
      | OCPPFT2T2 | Routine | $..edges.[?(@.mode=='COPY')].source | $..edges.[?(@.mode=='COPY')].target | $..[?(@.caption=='Lineage Hops')]..name | COPY | ida/jdbcAnalyzerPayloads/OraclePostProcessor.json | $..edges.[?(@.mode=='COPY')].dir | LINEAGE SOURCE,LINEAGE TARGET |
    Then user verifies the "source" content in "SQLSource"
      | tabName    | DATA            |
      | jsonPath   | json/IDA.json   |
      | queryPage  | oracleQueries   |
      | queryField | createFunction1 |



  ##6656269##
  @webtest @MLP-9604
  Scenario: SC#20-Verify OraclePostProcessor generates lineage for View to Table(through procedure having dynamic sql)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "Click" on "Administration" dashboard
    And user "Click" on "ITEM AND LIST VIEW MANAGER" dashboard
    And user configure below parameters for item "itemView_Table" from "ITEM AND LIST VIEW MANAGER" list
      | CATALOGS       | SUPPORTED TYPES |
      | ORACLE CATALOG | LineageHop      |
    And user select "ORACLE CATALOG" catalog and search "PRODSV2T" items at top end
    And user performs "facet selection" in "COLLECTOR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PRODSV2T" item from search results
    Then user verifies the lineage for "PRODSV2T" in "ORACLE CATALOG" catalog with following values
      | Table     | Type    | getSourceJsonPath                   | getTargetJsonPath                   | getLineageHopName                       | mode | payloadFile                                       | dir                              | LineageNames                  |
      | OCPPDSV2T | Routine | $..edges.[?(@.mode=='COPY')].source | $..edges.[?(@.mode=='COPY')].target | $..[?(@.caption=='Lineage Hops')]..name | COPY | ida/jdbcAnalyzerPayloads/OraclePostProcessor.json | $..edges.[?(@.mode=='COPY')].dir | LINEAGE SOURCE,LINEAGE TARGET |
    Then user verifies the "source" content in "SQLSource"
      | tabName    | DATA             |
      | jsonPath   | json/IDA.json    |
      | queryPage  | oracleQueries    |
      | queryField | createProcedure3 |
    And user select "ORACLE CATALOG" catalog and search "OCPPDSVT" items at top end
    And user performs "facet selection" in "COLLECTOR [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OCPPDSVT" item from search results
    Then user verifies the lineage for "OCPPDSVT" in "ORACLE CATALOG" catalog with following values
      | Table | Type  | getSourceJsonPath                   | getTargetJsonPath                   | getLineageHopName                       | mode | payloadFile                                       | dir                              | LineageNames          |
      |       | Table | $..edges.[?(@.mode=='VIEW')].source | $..edges.[?(@.mode=='VIEW')].target | $..[?(@.caption=='Lineage Hops')]..name | VIEW | ida/jdbcAnalyzerPayloads/OraclePostProcessor.json | $..edges.[?(@.mode=='VIEW')].dir | LINEAGEDOWN,LINEAGEUP |


  @jdbc
  Scenario: SC#21-Delete Plugin Configuration
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                  | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/OracleDBCataloger |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/OracleDBAnalyzer  |      | 204           |                  |          |


  @jdbc
  Scenario: SC#21-Drop Index on Table
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage     | queryField       |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | dropIndexOnTable |


  @jdbc
  Scenario: SC#21-Drop Procedure, View, Functions and tables
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage     | queryField     |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | dropProcedure1 |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | dropTable1     |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | dropTable2     |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | dropProcedure2 |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | dropTable3     |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | dropView1      |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | dropTable4     |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | dropFunction1  |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | dropTable5     |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | dropTable6     |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | dropTable7     |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | dropView2      |
      | oracle             | EXECUTEQUERY | json/IDA.json | oracleQueries | dropProcedure3 |


  @jdbc
  Scenario: SC#21-Drop Table using Name
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation | Schema | Table                         | Database |
      | oracle             | DROP      |        | TABLE_PRIMARY                 |          |
      | oracle             | DROP      |        | ORACLE_EMPTY                  |          |
      | oracle             | DROP      |        | ORACLE_TAG_DETAILS            |          |
      | oracle             | DROP      |        | ORACLE_TABLE                  |          |
      | oracle             | DROP      |        | ORACLE_DIFFDATATYPES          |          |
      | oracle             | DROP      |        | ORACLE_CHECKTEST              |          |
      | oracle             | DROP      |        | ORACLE_UNIQUETEST             |          |
      | oracle             | DROP      |        | ORACLE_INDEXTABLE             |          |
      | oracle             | DROP      |        | ORACLE_PERSON_ADDRESS_DETAILS |          |
      | oracle             | DROP      |        | ORACLE_PERSON_INFO            |          |


  @jdbc
  Scenario: SC#21-Delete Catalog
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/catalogs/ORACLE%20CATALOG |      | 204           |                  |          |