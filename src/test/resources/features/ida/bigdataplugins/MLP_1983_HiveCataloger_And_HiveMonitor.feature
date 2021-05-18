@MLP-1983
Feature:MLP-1983: Rework of Catalog Hive to IDA Plugin
  Description: Hive bundle(previously known as IDC Prototype CatalogHive project ) is a set of plugins for gathering metadata, parsing queries and monitoring events in Hive Data Warehouse

  Scenario: SC1#MLP-1983: Verify whether the HiveCataloger can be started.
    Given User update the ambari host in following files using json path
      | filePath                                                                       | jsonPath              | node               |
      | ida/hivePayloads/ambariResolver.json                                           | $..clusterManagerHost | clusterManagerHost |
      | ida/hivePayloads/new_Hive_Cataloger_No_such_database_Configuration.json        | $..clusterManagerHost | clusterManagerHost |
      | ida/hivePayloads/new_Hive_Cataloger_Configuration.json                         | $..clusterManagerHost | clusterManagerHost |
      | ida/hivePayloads/new_Hive_Cataloger_database_with_no_tables_Configuration.json | $..clusterManagerHost | clusterManagerHost |
      | ida/hivePayloads/new_Hive_Cataloger_No_such_database_Configuration.json        | $..clusterManagerHost | clusterManagerHost |
      | ida/hivePayloads/new_Hive_Cataloger_with_50Columns_Configuration.json          | $..clusterManagerHost | clusterManagerHost |
    And user update the json file "ida/hivePayloads/ambariResolver.json" file for following values
      | jsonPath       | jsonValues |
      | $..catalogName | BigData    |

  @MLP-1983 @sanity @positive
  Scenario Outline:SC1#MLP-1983 Update Ambari resolver in IDC Platform
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type | url                               | body                                 | response code | response message |
      | application/json | raw   | false | Put  | settings/analyzers/AmbariResolver | ida/hivePayloads/ambariResolver.json | 204           |                  |
      | application/json |       |       | Get  | settings/analyzers/AmbariResolver |                                      | 200           | BigData          |


  @MLP-1983 @sanity @positive
  Scenario: SC1#MLP-1983: Verify whether the HiveCataloger can be started.
    Given user executes the following Query in the Hive JDBC
      | queryEntry          |
      | DropTable_SalesFact |
      | DropTable_ZoneWest  |
      | DropDatabase        |
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    And supply payload with file name "/ida/hivePayloads/new_Hive_Cataloger_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/HiveCataloger" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And user executes the following Query in the Hive JDBC
      | queryEntry         |
      | CreateHiveDatabase |
      | CreateHiveTable1   |
      | CreateHiveTable2   |
    And supply payload with file name "/ida/hivePayloads/empty.json"
    And user makes a REST Call for POST request with url "extensions/analyzers/start/Cluster Demo/cataloger/HiveCataloger/HiveCataloger"
    Then Status code 200 must be returned
    And sync the test execution for "100" seconds
    And user validates whether the "TEZ" spark Jobs are completed initiated Bigdata Analyzer
#    And user validates whether the "SPARK" spark Jobs are completed initiated Bigdata Analyzer

  @MLP-1983 @sanity @sftp @positive
  Scenario: SC2#MLP-1841:verify the message.log has the entry for running of HiveCataloger.
    Given user connects to the SFTP server and downloads the "messages.log"
    Then user validates the entries in "messages.log"
      | logEntry                           |
      | HiveCatalogerScanInitiated         |
      | HiveCatalogerTagsScannedEntry      |
      | HiveCatalogerDatabaseScanEntry     |
      | HiveCatalogerDatabaseRetrivalEntry |
      | HiveCatalogerTableScanEntry1       |
      | HiveCatalogerFieldSchemaEntry1     |
      | HiveCatalogerTableScanEntry2       |
      | HiveCatalogerFieldSchemaEntry2     |
      | HiveCatalogertoDataAnalyzerEntry   |
#    And user validates the entry in "message.log" for "HiveCatalogerDataAnalyzerStartedEntry"
#    And user validates the entry in "message.log" for "HiveCatalogerDataAnalyzerStartedConfirmation"

  @MLP-1983 @sanity @positive
  Scenario:SC3#MLP-1983: Verify whether the Cluster,DbSystem,table and its columns are parsed to Postgres triggered by HiveCataloger
    Given The name of the cluster in Postgres should be "Cluster Demo"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Cluster | ID         | name         |
    And user tries to derive the relation of "Service" from "Cluster Demo"
      | description | schemaName | tableName     | columnName | criteriaName       |
      | SELECT      | BigData    | E_has_Service | ID         | BigData.Cluster__O |
    And user tries to validate whether "HIVE" exists in "Service"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Service | name       | ID           |
    And user tries to derive the relation of "Database" from "HIVE"
      | description | schemaName | tableName      | columnName | criteriaName       |
      | SELECT      | BigData    | E_has_Database | ID         | BigData.Service__O |
    And the database "hivesample" should be present in "HIVE" dbSystem
      | description | schemaName | tableName  | columnName | criteriaName |
      | SELECT      | BigData    | V_Database | name       | ID           |
    And user tries to derive the relation of "tables" from "hivesample"
      | description | schemaName | tableName   | columnName       | criteriaName        |
      | SELECT      | BigData    | E_has_Table | BigData.Table__I | BigData.Database__O |
    And user validates the list of "hivesampleTables" available in the database in postgres
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Table   | name       | ID           |
    And user tries to derive the relation of "columns" from "sales_fact"
      | description | schemaName | tableName    | columnName | criteriaName     |
      | SELECT      | BigData    | E_has_Column | ID         | BigData.Table__O |
    And user validates the list of "sales_fact_Columns" available in the database in postgres
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Column  | name       | ID           |


  @MLP-1983 @sanity @positive
  Scenario:SC4#MLP_1983-User set solr advance search as true via API
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                       | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | settings/preferences/form |      | 200           |                  |          |
    And user makes a REST Call for GET request with url "settings/preferences/form" and save the response in file "rest/payloads/ida/hivePayloads/solrsearchfalse.json"
    And user "update" the json file "ida/hivePayloads/solrsearchfalse.json" file for following values
      | jsonPath                 | jsonValues |
      | $..useAdvancedSolrSyntax | true       |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                       | body                                  | response code | response message | jsonPath |
      |        |       |       | Post | settings/preferences/form | ida/hivePayloads/solrsearchfalse.json | 204           |                  |          |


  @MLP-1983  @webtest @querylogs @sanity @positive
  Scenario:SC5#MLP-1983: Verify whether the Cluster,DbSystem,table and its columns are parsed to IDC UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
#    And user configure the advance search for the login
#    And user "Enable" Support full Solr syntax
    And user searches for the content"Solr_Search_for_ClusterDemo" in the search box
    And user selects the "BigData" from the Catalog
    And user performs "facet selection" in "Cluster" attribute under "Type" facets in Item Search results page
    And user validates the cluster name"Cluster Demo" from IDC UI
    When user validates the existence of the Query under the following tables
      | queryEntry | tableEntry |
      | HIVE       | SERVICES   |
      | hivesample | DATABASES  |
      | sales_fact | TABLES     |
    Then user validates "COLUMNS" for the "sales_fact_Columns" source


  @MLP-1983 @sanity @sftp @positive
  Scenario:SC6#MLP-1983: Verify whether the HiveMonitor triggers the HiveCataloger for a change in metastore.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    And supply payload with file name "/ida/hivePayloads/new_Hive_Monitor_Hive_Cataloger_Configuration.json"
    And user makes a REST Call for PUT request with url "settings/analyzers/HiveCataloger" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And supply payload with file name "/ida/hivePayloads/empty.json"
    When user makes a REST Call for POST request with url "extensions/analyzers/start/Cluster Demo/cataloger/HiveCataloger/HiveCataloger"
    And Status code 200 must be returned
    And supply payload with file name "/ida/hivePayloads/new_Hive_Monitor_Configuration.json"
    And user makes a REST Call for PUT request with url "settings/analyzers/HiveMonitor" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And user executes the following Query in the Hive JDBC
      | queryEntry           |
      | DropTable_healthCare |
      | CreateHiveTable3     |
    And user waits for the delta time to be completed for the monitor to trigger Cataloger
#    And sync the test execution for "30" seconds
    And user connects to the SFTP server and downloads the "messages.log"
    Then user validates the entries in "messages.log"
      | logEntry                       |
      | HiveMonitorState               |
      | HiveMonitorDeltaTimeEntry      |
      | HiveMonitorDatabaseFilterEntry |
      | HiveMonitorChangeEntry         |
      | HiveMonitorScanKickOff         |
      | HiveMonitortoScannerMessage    |
      | HiveMonitorClearEvent          |
    And user validates whether the "TEZ" spark Jobs are completed initiated Bigdata Analyzer

  @MLP-1983 @sanity @positive
  Scenario:SC7#MLP-1983: Verify whether the Cluster,DbSystem,table and its columns are parsed to Postgres triggered by HiveMonitor
    Given The name of the cluster in Postgres should be "Cluster Demo"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Cluster | ID         | name         |
    And user tries to derive the relation of "Service" from "Cluster Demo"
      | description | schemaName | tableName     | columnName | criteriaName       |
      | SELECT      | BigData    | E_has_Service | ID         | BigData.Cluster__O |
    And user tries to validate whether "HIVE" exists in "Service"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Service | name       | ID           |
    And user tries to derive the relation of "Database" from "HIVE"
      | description | schemaName | tableName      | columnName | criteriaName       |
      | SELECT      | BigData    | E_has_Database | ID         | BigData.Service__O |
    And the database "healthcare" should be present in "HIVE" dbSystem
      | description | schemaName | tableName  | columnName | criteriaName |
      | SELECT      | BigData    | V_Database | name       | ID           |
    And user tries to derive the relation of "tables" from "healthcare"
      | description | schemaName | tableName   | columnName       | criteriaName        |
      | SELECT      | BigData    | E_has_Table | BigData.Table__I | BigData.Database__O |
    And user validates the list of "healthCareTables_AfterHiveMonitor" available in the database in postgres
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Table   | name       | ID           |
    And user tries to derive the relation of "columns" from "zone_east"
      | description | schemaName | tableName    | columnName | criteriaName     |
      | SELECT      | BigData    | E_has_Column | ID         | BigData.Table__O |
    And user validates the list of "zone_east_Columns" available in the database in postgres
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Column  | name       | ID           |

  @MLP-1983  @webtest @querylogs @sanity @positive
  Scenario:SC8#MLP-1983: Verify whether the Cluster,DbSystem,table and its columns are parsed to IDC UI after the HiveMonitor triggers HiveCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
#    And user configure the advance search for the login
#    And user "Enable" Support full Solr syntax
    And user searches for the content"Solr_Search_for_ClusterDemo" in the search box
    And user selects the "BigData" from the Catalog
    And user validates the cluster name"Cluster Demo" from IDC UI
    When user validates the existence of the Query under the following tables
      | queryEntry | tableEntry |
      | HIVE       | SERVICES   |
      | healthcare | DATABASES  |
      | zone_east  | TABLES     |
    Then user validates "COLUMNS" for the "zone_east_Columns" source


  @MLP-1983  @sanity @sftp @negative
  Scenario:SC9#MLP-1983: Verify whether the HiveCataloger results when the database which does exist is parsed
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    And supply payload with file name "/ida/hivePayloads/new_Hive_Cataloger_No_such_database_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/HiveCataloger" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And supply payload with file name "/ida/hivePayloads/empty.json"
    And user makes a REST Call for POST request with url "extensions/analyzers/start/Cluster Demo/cataloger/HiveCataloger/HiveCataloger"
    Then Status code 200 must be returned
    And user validates whether the "TEZ" spark Jobs are completed initiated Bigdata Analyzer
    And user connects to the SFTP server and downloads the "messages.log"
    And user validates the entries in "messages.log"
      | logEntry                     |
      | HiveCatalogerNoDatabaseEntry |

  @MLP-1983 @sanity @sftp @negative
  Scenario:SC10#MLP-1983: Verify whether the HiveCataloger results when the database parsed doesn't have tables in it
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    And supply payload with file name "/ida/hivePayloads/new_Hive_Cataloger_database_with_no_tables_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/Hive_Cataloger" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And user executes the following Query in the Hive JDBC
      | queryEntry          |
      | CreateHiveDatabase2 |
    And supply payload with file name "/ida/hivePayloads/empty.json"
    And user makes a REST Call for POST request with url "extensions/analyzers/start/Cluster Demo/cataloger/HiveCataloger/HiveCataloger"
    Then Status code 200 must be returned
    And user validates whether the "TEZ" spark Jobs are completed initiated Bigdata Analyzer
    And user connects to the SFTP server and downloads the "messages.log"
    And user validates the entries in "messages.log"
      | logEntry                          |
      | HiveCatalogerDataBaseWithNoTables |
    And user executes the following Query in the Hive JDBC
      | queryEntry        |
      | DropHiveDatabase2 |

  @MLP-1983 @sanity @sftp @regression @webtest
  Scenario:SC11#Verification of Hive Catalog behavior  when 50 Columns are added to table
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    And supply payload with file name "/ida/hivePayloads/new_Hive_Cataloger_with_50Columns_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/HiveCataloger" with the following query param
      | raw | false |
    And Status code 204 must be returned
    And user executes the following Query in the Hive JDBC
      | queryEntry      |
      | CreateHiveBDADB |
      | CreateBDATable2 |
    And supply payload with file name "/ida/hivePayloads/empty.json"
    And user makes a REST Call for POST request with url "extensions/analyzers/start/Cluster Demo/cataloger/HiveCataloger/HiveCataloger"
    Then Status code 200 must be returned
    And sync the test execution for "30" seconds
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "hivebdasample" and clicks on search
    And user checks the checkbox for "hivebdasample [Database]" in facet "Parent hierarchy"
    And user selects the "Column" from the Type
    Then user verifies "50" items found
    And user executes the following Query in the Hive JDBC
      | queryEntry    |
      | DropBDATable2 |
      | DropHiveBDADB |


  @MLP-1983 @sanity @positive
  Scenario:SC12#MLP_1983-User set solr advance search as false via API
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                       | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | settings/preferences/form |      | 200           |                  |          |
    And user makes a REST Call for GET request with url "settings/preferences/form" and save the response in file "rest/payloads/ida/solrsearchfalse.json"
    And user "update" the json file "ida/hivePayloads/solrsearchfalse.json" file for following values
      | jsonPath                 | jsonValues |
      | $..useAdvancedSolrSyntax | false      |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                       | body                                  | response code | response message | jsonPath |
      |        |       |       | Post | settings/preferences/form | ida/hivePayloads/solrsearchfalse.json | 204           |                  |          |
