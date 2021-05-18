Feature: MLP-30466 Analyzer support implementation for CAE Oracle PDB
         MLP-30962 Validation for CAE Oracle CDB

      ########################################################## Oracle19c PDB ################################################################################
  ##################################################################### Credentials and DataSources ##############################################################

  Scenario Outline:PreCondition :Configure CAEEntrypointCredentials,CAECredentials,Oracle Credentials and Data Source for CAEEntryPoint and OracleCollector
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                           | bodyFile                                            | path                       | response code | response message    | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/CAEEntryPointCredentials | payloads/ida/CAE_Oracle_PDB/Config/Credentials.json | $.CAEEntryPointCredentials | 200           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/CAEEntryPointCredentials |                                                     |                            | 200           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/CAECredentials           | payloads/ida/CAE_Oracle_PDB/Config/Credentials.json | $.CAECredentials           | 200           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/CAECredentials           |                                                     |                            | 200           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/OracleCredentials        | payloads/ida/CAE_Oracle_PDB/Config/Credentials.json | $.OracleCredentials        | 200           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/OracleCredentials        |                                                     |                            | 200           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource              | payloads/ida/CAE_Oracle_PDB/Config/DataSource.json  | $.CAEDataSource            | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource              |                                                     |                            | 200           | CAEDataSource       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEOracleDataSource        | payloads/ida/CAE_Oracle_PDB/Config/DataSource.json  | $.CAEOracleDataSource      | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEOracleDataSource        |                                                     |                            | 200           | CAEOracleDS         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleDBDataSource         | payloads/ida/CAE_Oracle_PDB/Config/DataSource.json  | $.OracleCDBDataSource      | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleDBDataSource         |                                                     |                            | 200           | OracleCDBDataSource |          |

  #####################################################################  Plugin Configurations ##############################################################

  Scenario Outline:PreCondition :Create plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | bodyFile                                             | path                  | response code | response message    | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDeleteEntryPoint | payloads/ida/CAE_Oracle_PDB/Config/PluginConfig.json | $.CAEDeleteEntryPoint | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDeleteEntryPoint |                                                      |                       | 200           | CAEDeleteEntryPoint |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAECreateEntryPoint | payloads/ida/CAE_Oracle_PDB/Config/PluginConfig.json | $.CAECreateEntryPoint | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAECreateEntryPoint |                                                      |                       | 200           | CAECreateEntryPoint |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleCollector     | payloads/ida/CAE_Oracle_PDB/Config/PluginConfig.json | $.OracleCollector     | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleCollector     |                                                      |                       | 200           | OracleCollector     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEFeed             | payloads/ida/CAE_Oracle_PDB/Config/PluginConfig.json | $.CAEFeeder           | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEFeed             |                                                      |                       | 200           | CAEFeeder           |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDDLoader         | payloads/ida/CAE_Oracle_PDB/Config/PluginConfig.json | $.CAELoader           | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDDLoader         |                                                      |                       | 200           | CAELoader           |          |

    ########################################################## Without schema/table filters for Table ################################################################################

  Scenario Outline:MLP-30466:SC#1_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path                       | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                            | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                            | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                            | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                            | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                            | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                            | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                            | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                            | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                            | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                            | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                            | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                            | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                            | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                            | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                            | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_PDB/Config/AnalyzerConfig.json | $.WithoutSchemaTableFilter | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                            | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                            | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |                            | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                            | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-3094 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#1_2_User get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES","ORACLE_TABLE"and "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                              | asg_scopeid | targetFile                                 | jsonpath                                |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TABLE         |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TABLE         |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TAG_DETAILS   |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TAG_DETAILS   |

  @MLPQA-3094 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#1_2_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                                  | outPutFile                                                       | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TABLE         | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json         |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TAG_DETAILS   | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json   |            |

  @MLPQA-3094 @CAE_Oracle
  Scenario:MLP-30466:SC#1_2_Update the values with null for the dynamic columns for (duplicate schema and duplicate tables)
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json" file for following values
      | jsonPath                | jsonValues | type  |
      | $..sample.values[0].[0] |            | Array |
      | $..sample.values[0].[1] |            | Array |
      | $..sample.values[0].[2] |            | Array |
      | $..sample.values[0].[3] |            | Array |
      | $..sample.values[1].[0] |            | Array |
      | $..sample.values[1].[1] |            | Array |
      | $..sample.values[1].[2] |            | Array |
      | $..sample.values[1].[3] |            | Array |
      | $..sample.values[2].[0] |            | Array |
      | $..sample.values[2].[1] |            | Array |
      | $..sample.values[2].[2] |            | Array |
      | $..sample.values[2].[3] |            | Array |
      | $..sample.values[3].[0] |            | Array |
      | $..sample.values[3].[1] |            | Array |
      | $..sample.values[3].[2] |            | Array |
      | $..sample.values[3].[3] |            | Array |
      | $..sample.values[4].[0] |            | Array |
      | $..sample.values[4].[1] |            | Array |
      | $..sample.values[4].[2] |            | Array |
      | $..sample.values[4].[3] |            | Array |

  @MLPQA-3094 @CAE_Oracle
  Scenario:MLP-30466:SC#1_2_Verify data sampling works fine for String, Numeric, Date, Time, and Timestamp, Complex Types without schema/table filters - Table
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_DIFFDATATYPES.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TABLE.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TAG_DETAILS.json"

  @MLPQA-3093 @CAE_Oracle
  Scenario:MLP-30466:SC#2_1_Verify data profiling works fine for String, Numeric, Date, Time, and Timestamp types without schema/table filters.- Table
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath                                                       | Action                    | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename   | columnName/FieldName |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |

  Scenario:MLP-30466:SC#2_2_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30466:SC#2_2_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

     ########################################################## Only Schema filter for Table ################################################################################

  Scenario Outline:MLP-30466:SC#3_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path               | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                    | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                    | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                    | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                    | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                    | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                    | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                    | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                    | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                    | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                    | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                    | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                    | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                    | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                    | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                    | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_PDB/Config/AnalyzerConfig.json | $.OnlySchemaFilter | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                    | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                    | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |                    | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                    | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-3092 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#3_2_User get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES","ORACLE_TABLE"and "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                              | asg_scopeid | targetFile                                 | jsonpath                                |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TABLE         |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TABLE         |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TAG_DETAILS   |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TAG_DETAILS   |

  @MLPQA-3092 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#3_2_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                                  | outPutFile                                                       | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TABLE         | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json         |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TAG_DETAILS   | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json   |            |

  @MLPQA-3092 @CAE_Oracle
  Scenario:MLP-30466:SC#3_2_Update the values with null for the dynamic columns for (duplicate schema and duplicate tables)
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json" file for following values
      | jsonPath                | jsonValues | type  |
      | $..sample.values[0].[0] |            | Array |
      | $..sample.values[0].[1] |            | Array |
      | $..sample.values[0].[2] |            | Array |
      | $..sample.values[0].[3] |            | Array |
      | $..sample.values[1].[0] |            | Array |
      | $..sample.values[1].[1] |            | Array |
      | $..sample.values[1].[2] |            | Array |
      | $..sample.values[1].[3] |            | Array |
      | $..sample.values[2].[0] |            | Array |
      | $..sample.values[2].[1] |            | Array |
      | $..sample.values[2].[2] |            | Array |
      | $..sample.values[2].[3] |            | Array |
      | $..sample.values[3].[0] |            | Array |
      | $..sample.values[3].[1] |            | Array |
      | $..sample.values[3].[2] |            | Array |
      | $..sample.values[3].[3] |            | Array |
      | $..sample.values[4].[0] |            | Array |
      | $..sample.values[4].[1] |            | Array |
      | $..sample.values[4].[2] |            | Array |
      | $..sample.values[4].[3] |            | Array |

  @MLPQA-3092 @CAE_Oracle
  Scenario:MLP-30466:SC#3_2_Verify data sampling works fine for String, Numeric, Date, Time, and Timestamp, Complex Types with only schema filter.(Table)
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_DIFFDATATYPES.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TABLE.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TAG_DETAILS.json"

  @MLPQA-3091 @CAE_Oracle
  Scenario:MLP-30466:SC#4_1_Verify data profiling works fine for String, Numeric, Date, Time, and Timestamp types with only schema filter.(Table)
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath                                                       | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename        | columnName/FieldName |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES.Lifecycle             | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES      |                      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES_VIEW.Lifecycle        | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES_VIEW |                      |

  Scenario:MLP-30466:SC#4_2_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30466:SC#4_2_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

      ########################################################## Schema/Table Multiple filter for Table ################################################################################

  Scenario Outline:MLP-30466:SC#5_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path                        | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                             | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                             | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                             | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                             | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                             | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_PDB/Config/AnalyzerConfig.json | $.SchemaTableMultipleFilter | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                             | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |                             | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-3090 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#5_2_User get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES","ORACLE_TABLE"and "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                              | asg_scopeid | targetFile                                 | jsonpath                                |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TABLE         |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TABLE         |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TAG_DETAILS   |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TAG_DETAILS   |

  @MLPQA-3090 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#5_2_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                                  | outPutFile                                                       | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TABLE         | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json         |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TAG_DETAILS   | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json   |            |

  @MLPQA-3090 @CAE_Oracle
  Scenario:MLP-30466:SC#5_2_Update the values with null for the dynamic columns for (duplicate schema and duplicate tables)
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json" file for following values
      | jsonPath                | jsonValues | type  |
      | $..sample.values[0].[0] |            | Array |
      | $..sample.values[0].[1] |            | Array |
      | $..sample.values[0].[2] |            | Array |
      | $..sample.values[0].[3] |            | Array |
      | $..sample.values[1].[0] |            | Array |
      | $..sample.values[1].[1] |            | Array |
      | $..sample.values[1].[2] |            | Array |
      | $..sample.values[1].[3] |            | Array |
      | $..sample.values[2].[0] |            | Array |
      | $..sample.values[2].[1] |            | Array |
      | $..sample.values[2].[2] |            | Array |
      | $..sample.values[2].[3] |            | Array |
      | $..sample.values[3].[0] |            | Array |
      | $..sample.values[3].[1] |            | Array |
      | $..sample.values[3].[2] |            | Array |
      | $..sample.values[3].[3] |            | Array |
      | $..sample.values[4].[0] |            | Array |
      | $..sample.values[4].[1] |            | Array |
      | $..sample.values[4].[2] |            | Array |
      | $..sample.values[4].[3] |            | Array |

  @MLPQA-3090 @CAE_Oracle
  Scenario:MLP-30466:SC#5_2_Verify data sampling works fine for String, Numeric, Date, Time, and Timestamp, Complex Types with schema/table multiple filter.
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_DIFFDATATYPES.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TABLE.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TAG_DETAILS.json"

  @MLPQA-3089 @CAE_Oracle
  Scenario:MLP-30466:SC#6_1_Verify data profiling works fine for String, Numeric, Date, Time, and Timestamp types with schema/table multiple filter.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath                                                       | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename        | columnName/FieldName |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES.Lifecycle             | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES      |                      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES_VIEW.Lifecycle        | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES_VIEW |                      |

  Scenario:MLP-30466:SC#6_2_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30466:SC#6_2_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

      ########################################################## Same Table in MultipleSchema filter for Table ################################################################################

  Scenario Outline:MLP-30466:SC#7_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path                            | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                                 | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                                 | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                                 | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                                 | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                                 | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_PDB/Config/AnalyzerConfig.json | $.SameTableMultipleSchemaFilter | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                                 | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |                                 | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-3088 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#7_2_User get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                              | asg_scopeid | targetFile                                 | jsonpath                                |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES |

  @MLPQA-3088 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#7_2_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                                  | outPutFile                                                       | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json |            |

  @MLPQA-3088 @CAE_Oracle
  Scenario:MLP-30466:SC#7_2_Update the values with null for the dynamic columns for (duplicate schema and duplicate tables)
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |

  @MLPQA-3088 @CAE_Oracle
  Scenario:MLP-30466:SC#7_2_Verify data sampling happens properly when table name alone given in filter(table present in more than one schema)
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_DIFFDATATYPES.json"

  @MLPQA-3088 @CAE_Oracle
  Scenario:MLP-30466:SC#7_3_Verify data profiling happens properly when table name alone given in filter(table present in more than one schema)
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath                                                       | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename   | columnName/FieldName |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA1.ORACLE_TABLE.Lifecycle                     | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE         |                      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA1.ORACLE_TAG_DETAILS.Lifecycle               | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS   |                      |

  Scenario:MLP-30466:SC#7_4_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30466:SC#7_4_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

          ########################################################## Schema/Table Multiple Duplicate filters. ################################################################################

  Scenario Outline:MLP-30466:SC#8_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path                                 | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                                      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                                      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                                      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                                      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                                      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_PDB/Config/AnalyzerConfig.json | $.SchemaTableMultipleDuplicateFilter | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                                      | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |                                      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-3087 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#8_2_User get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES","ORACLE_TABLE"and "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                              | asg_scopeid | targetFile                                 | jsonpath                                |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TABLE         |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TABLE         |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TAG_DETAILS   |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TAG_DETAILS   |

  @MLPQA-3087 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#8_2_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                                  | outPutFile                                                       | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TABLE         | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json         |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TAG_DETAILS   | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json   |            |

  @MLPQA-3087 @CAE_Oracle
  Scenario:MLP-30466:SC#8_2_Update the values with null for the dynamic columns for (duplicate schema and duplicate tables)
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json" file for following values
      | jsonPath                | jsonValues | type  |
      | $..sample.values[0].[0] |            | Array |
      | $..sample.values[0].[1] |            | Array |
      | $..sample.values[0].[2] |            | Array |
      | $..sample.values[0].[3] |            | Array |
      | $..sample.values[1].[0] |            | Array |
      | $..sample.values[1].[1] |            | Array |
      | $..sample.values[1].[2] |            | Array |
      | $..sample.values[1].[3] |            | Array |
      | $..sample.values[2].[0] |            | Array |
      | $..sample.values[2].[1] |            | Array |
      | $..sample.values[2].[2] |            | Array |
      | $..sample.values[2].[3] |            | Array |
      | $..sample.values[3].[0] |            | Array |
      | $..sample.values[3].[1] |            | Array |
      | $..sample.values[3].[2] |            | Array |
      | $..sample.values[3].[3] |            | Array |
      | $..sample.values[4].[0] |            | Array |
      | $..sample.values[4].[1] |            | Array |
      | $..sample.values[4].[2] |            | Array |
      | $..sample.values[4].[3] |            | Array |

  @MLPQA-3087 @CAE_Oracle
  Scenario:MLP-30466:SC#8_2_Verify data sampling works fine for String, Numeric, Date, Time, and Timestamp, Complex Types with schema/table multiple duplicate filters.
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_DIFFDATATYPES.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TABLE.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TAG_DETAILS.json"

  @MLPQA-3086 @CAE_Oracle
  Scenario:MLP-30466:SC#9_1_Verify data profiling works fine for String, Numeric, Date, Time, and Timestamp types with schema/table multiple duplicate filters.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath                                                       | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename        | columnName/FieldName |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES.Lifecycle             | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES      |                      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES_VIEW.Lifecycle        | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES_VIEW |                      |

  Scenario:MLP-30466:SC#9_2_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30466:SC#9_2_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

        ########################################################## Database, Schema and Table filters ################################################################################

  Scenario Outline:MLP-30466:SC#10_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path                        | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                             | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                             | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                             | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                             | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                             | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_PDB/Config/AnalyzerConfig.json | $.SchemaTableMultipleFilter | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                             | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |                             | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                             | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-3085 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#10_2_User get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES","ORACLE_TABLE"and "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                              | asg_scopeid | targetFile                                 | jsonpath                                |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TABLE         |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TABLE         |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TAG_DETAILS   |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TAG_DETAILS   |

  @MLPQA-3085 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#10_2_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                                  | outPutFile                                                       | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TABLE         | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json         |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TAG_DETAILS   | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json   |            |

  @MLPQA-3085 @CAE_Oracle
  Scenario:MLP-30466:SC#10_2_Update the values with null for the dynamic columns for (duplicate schema and duplicate tables)
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json" file for following values
      | jsonPath                | jsonValues | type  |
      | $..sample.values[0].[0] |            | Array |
      | $..sample.values[0].[1] |            | Array |
      | $..sample.values[0].[2] |            | Array |
      | $..sample.values[0].[3] |            | Array |
      | $..sample.values[1].[0] |            | Array |
      | $..sample.values[1].[1] |            | Array |
      | $..sample.values[1].[2] |            | Array |
      | $..sample.values[1].[3] |            | Array |
      | $..sample.values[2].[0] |            | Array |
      | $..sample.values[2].[1] |            | Array |
      | $..sample.values[2].[2] |            | Array |
      | $..sample.values[2].[3] |            | Array |
      | $..sample.values[3].[0] |            | Array |
      | $..sample.values[3].[1] |            | Array |
      | $..sample.values[3].[2] |            | Array |
      | $..sample.values[3].[3] |            | Array |
      | $..sample.values[4].[0] |            | Array |
      | $..sample.values[4].[1] |            | Array |
      | $..sample.values[4].[2] |            | Array |
      | $..sample.values[4].[3] |            | Array |

  @MLPQA-3085 @CAE_Oracle
  Scenario:MLP-30466:SC#10_2_Verify data sampling happens properly when the database, schema and table filters are provided.
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_DIFFDATATYPES.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TABLE.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TAG_DETAILS.json"

  @MLPQA-3085 @CAE_Oracle
  Scenario:MLP-30466:SC#10_3_Verify data profiling happens properly when the database, schema and table filters are provided.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath                                                       | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename        | columnName/FieldName |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES.Lifecycle             | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES      |                      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES_VIEW.Lifecycle        | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES_VIEW |                      |

  Scenario:MLP-30466:SC#10_4_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30466:SC#10_4_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

           ##########################################################  More than one database ################################################################################

  Scenario Outline:MLP-30466:SC#11_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path                  | response code | response message   | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                       | 200           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                       | 200           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                       | 200           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                       | 200           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                       | 200           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger                                                     | payloads/ida/CAE_Oracle_PDB/Config/PluginConfig.json   | $.OracleCDBCataloger  | 204           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger                                                     |                                                        |                       | 200           | OracleCDBCataloger |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCDBCataloger     |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='OracleCDBCataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCDBCataloger      |                                                        |                       | 200           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCDBCataloger     |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='OracleCDBCataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_PDB/Config/AnalyzerConfig.json | $.MorethanOneDatabase | 204           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                       | 200           | OracleDBAnalyzer   |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |                       | 200           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-3084 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#11_2_User get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES","ORACLE_TABLE" and "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                              | asg_scopeid | targetFile                                 | jsonpath                                |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TABLE         |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TABLE         |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TAG_DETAILS   |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TAG_DETAILS   |

  @MLPQA-3084 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#11_2_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                                  | outPutFile                                                       | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TABLE         | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json         |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TAG_DETAILS   | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json   |            |

  @MLPQA-3084 @CAE_Oracle
  Scenario:MLP-30466:SC#11_2_Update the values with null for the dynamic columns for (duplicate schema and duplicate tables)
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json" file for following values
      | jsonPath                | jsonValues | type  |
      | $..sample.values[0].[0] |            | Array |
      | $..sample.values[0].[1] |            | Array |
      | $..sample.values[0].[2] |            | Array |
      | $..sample.values[0].[3] |            | Array |
      | $..sample.values[1].[0] |            | Array |
      | $..sample.values[1].[1] |            | Array |
      | $..sample.values[1].[2] |            | Array |
      | $..sample.values[1].[3] |            | Array |
      | $..sample.values[2].[0] |            | Array |
      | $..sample.values[2].[1] |            | Array |
      | $..sample.values[2].[2] |            | Array |
      | $..sample.values[2].[3] |            | Array |
      | $..sample.values[3].[0] |            | Array |
      | $..sample.values[3].[1] |            | Array |
      | $..sample.values[3].[2] |            | Array |
      | $..sample.values[3].[3] |            | Array |
      | $..sample.values[4].[0] |            | Array |
      | $..sample.values[4].[1] |            | Array |
      | $..sample.values[4].[2] |            | Array |
      | $..sample.values[4].[3] |            | Array |

  @MLPQA-3084 @CAE_Oracle
  Scenario:MLP-30466:SC#11_2_Verify data sampling happens properly when more than one database is analyzed.(CAE,DD)
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_DIFFDATATYPES.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TABLE.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TAG_DETAILS.json"

  @MLPQA-3084 @CAE_Oracle
  Scenario:MLP-30466:SC#11_3_Verify data profiling happens properly when more than one database is analyzed.(CAE,DD)
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath                                                       | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename        | columnName/FieldName |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES.Lifecycle             | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES      |                      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES_VIEW.Lifecycle        | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES_VIEW |                      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES.Lifecycle             | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES      |                      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES_VIEW.Lifecycle        | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES_VIEW |                      |

  Scenario:MLP-30466:SC#11_4_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30466:SC#11_4_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OracleDBCataloger/OracleCDBCataloger% | Analysis |       |       |

      ##########################################################  Invalid DB/Schema/Table ################################################################################

  Scenario Outline:MLP-30466:SC#12_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path                         | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                              | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                              | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                              | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                              | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                              | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                              | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                              | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                              | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                              | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                              | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                              | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                              | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                              | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                              | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                              | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_PDB/Config/AnalyzerConfig.json | $.InvalidDBSchemaTableFilter | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                              | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                              | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |                              | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                              | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

   @MLPQA-16812 @CAE_Oracle
  Scenario:MLP-30466:SC#12_2_Verify analysis does not happen when invalid DB or schema or table is provided in analyzer filers.
    Given Verify the metadata properties of the item types via api call
      | widgetName | filePath                                     | jsonPath                                                | Action                       | query                | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename        | columnName/FieldName |
      | Lifecycle  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA1.ORACLE_TABLE.Lifecycle              | metadataAttributeNonPresence | TableQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TABLE              |                      |
      | Lifecycle  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA1.ORACLE_TAG_DETAILS.Lifecycle        | metadataAttributeNonPresence | TableQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_TAG_DETAILS        |                      |
      | Lifecycle  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES.Lifecycle      | metadataAttributeNonPresence | TableQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES      |                      |
      | Lifecycle  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES_VIEW.Lifecycle | metadataAttributeNonPresence | TableQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES_VIEW |                      |
      | Lifecycle  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES.Lifecycle      | metadataAttributeNonPresence | TableQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES      |                      |
      | Lifecycle  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES_VIEW.Lifecycle | metadataAttributeNonPresence | TableQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES_VIEW |                      |

  Scenario:MLP-30466:SC#12_3_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30466:SC#12_4_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  ########################################################## Analyzer in InternalNode ################################################################################

  Scenario Outline:MLP-30466:SC#13_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path             | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_PDB/Config/AnalyzerConfig.json | $.InInternalNode | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                  | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/OracleDBAnalyzer/*                 |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/OracleDBAnalyzer/*                  |                                                        |                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/OracleDBAnalyzer/*                 |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

    @MLPQA-16811 @CAE_Oracle
    Scenario Outline:MLP-30466:SC#13_2_User get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES","ORACLE_TABLE"and "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                              | asg_scopeid | targetFile                                 | jsonpath                                |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TABLE         |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TABLE         |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TAG_DETAILS   |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TAG_DETAILS   |

  @MLPQA-16811 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#13_2_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                                  | outPutFile                                                       | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TABLE         | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json         |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TAG_DETAILS   | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json   |            |

  @MLPQA-16811 @CAE_Oracle
  Scenario:MLP-30466:SC#13_2_Update the values with null for the dynamic columns for (duplicate schema and duplicate tables)
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json" file for following values
      | jsonPath                | jsonValues | type  |
      | $..sample.values[0].[0] |            | Array |
      | $..sample.values[0].[1] |            | Array |
      | $..sample.values[0].[2] |            | Array |
      | $..sample.values[0].[3] |            | Array |
      | $..sample.values[1].[0] |            | Array |
      | $..sample.values[1].[1] |            | Array |
      | $..sample.values[1].[2] |            | Array |
      | $..sample.values[1].[3] |            | Array |
      | $..sample.values[2].[0] |            | Array |
      | $..sample.values[2].[1] |            | Array |
      | $..sample.values[2].[2] |            | Array |
      | $..sample.values[2].[3] |            | Array |
      | $..sample.values[3].[0] |            | Array |
      | $..sample.values[3].[1] |            | Array |
      | $..sample.values[3].[2] |            | Array |
      | $..sample.values[3].[3] |            | Array |
      | $..sample.values[4].[0] |            | Array |
      | $..sample.values[4].[1] |            | Array |
      | $..sample.values[4].[2] |            | Array |
      | $..sample.values[4].[3] |            | Array |

  @MLPQA-16811 @CAE_Oracle
  Scenario:MLP-30466:SC#13_2_Verify data sampling works fine for OracleAnalyzer runs fine in all nodes(Internal Node)
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_DIFFDATATYPES.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TABLE.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TABLE.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TAG_DETAILS.json"

  @MLPQA-16811 @CAE_Oracle
  Scenario:MLP-30466:SC#13_3_Verify data profiling works fine for OracleAnalyzer runs fine in all nodes(Internal Node)
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath                                                       | Action                    | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename   | columnName/FieldName |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |

  Scenario:MLP-30466:SC#13_4_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30466:SC#13_4_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

      ########################################################## Analyzer in CAENode ################################################################################

  Scenario Outline:MLP-30466:SC#14_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path                | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                     | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                     | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                     | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                     | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                     | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_PDB/Config/AnalyzerConfig.json | $.InIBecubicIDANode | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                     | 200           | BecubicIDANode   |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/dataanalyzer/OracleDBAnalyzer/*               |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/dataanalyzer/OracleDBAnalyzer/*                |                                                        |                     | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/dataanalyzer/OracleDBAnalyzer/*               |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-16811 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#14_2_User get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES" and "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                              | asg_scopeid | targetFile                                 | jsonpath                                |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TAG_DETAILS   |             | payloads/ida/CAE_Oracle_PDB/API/items.json | $.Tables.TableName.ORACLE_TAG_DETAILS   |

  @MLPQA-16811 @CAE_Oracle
  Scenario Outline:MLP-30466:SC#14_2_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                                  | outPutFile                                                           | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES_CAE.json |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TAG_DETAILS   | payloads/ida/CAE_Oracle_PDB/API/items.json | payloads\ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json       |            |

  @MLPQA-16811 @CAE_Oracle
  Scenario:MLP-30466:SC#14_2_Update the values with null for the dynamic columns for (duplicate schema and duplicate tables)
    And user "update" the json file "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES_CAE.json" file for following values
      | jsonPath                  | jsonValues | type  |
      | $..sample.values[0].[10]] |            | Array |
      | $..sample.values[0].[11]] |            | Array |
      | $..sample.values[0].[12]] |            | Array |
      | $..sample.values[0].[13]] |            | Array |
      | $..sample.values[1].[10]] |            | Array |
      | $..sample.values[1].[11]] |            | Array |
      | $..sample.values[1].[12]] |            | Array |
      | $..sample.values[1].[13]] |            | Array |
      | $..sample.values[2].[10]] |            | Array |
      | $..sample.values[2].[11]] |            | Array |
      | $..sample.values[2].[12]] |            | Array |
      | $..sample.values[2].[13]] |            | Array |
      | $..sample.values[3].[10]] |            | Array |
      | $..sample.values[3].[11]] |            | Array |
      | $..sample.values[3].[12]] |            | Array |
      | $..sample.values[3].[13]] |            | Array |
      | $..sample.values[4].[10]] |            | Array |
      | $..sample.values[4].[11]] |            | Array |
      | $..sample.values[4].[12]] |            | Array |
      | $..sample.values[4].[13]] |            | Array |

  @MLPQA-16811 @CAE_Oracle
  Scenario:MLP-30466:SC#14_2_Verify data sampling works fine for OracleAnalyzer runs fine in all nodes(CAENode)
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_DIFFDATATYPES_CAE.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_DIFFDATATYPES_CAE.json"
    Then file content in "ida\CAE_Oracle_PDB\API\Actual\ORACLE_TAG_DETAILS.json" should be same as the content in "ida\CAE_Oracle_PDB\API\Expected\ORACLE_TAG_DETAILS.json"

  @MLPQA-16811 @CAE_Oracle
  Scenario:MLP-30466:SC#14_3_Verify data profiling works fine for OracleAnalyzer runs fine in all nodes(CAE Node)
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath                                                       | Action                    | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename   | columnName/FieldName |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |

   ########################################################## Common Cases - Technology Tags/Business Item/Explicit Tag ################################################################################

  @MLPQA-3083 @CAE_Oracle
  Scenario:MLP-30466:SC#15_1_Verify Technology tag , Explicit tag , Bussiness Application tag and File Filter tag
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename   | Column      | Tags                                              | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN | BEC,Oracle,CAE_ORACLE_PDB_AY,CAEORACLEPDBAnalyzer | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES |             | BEC,Oracle,CAE_ORACLE_PDB_AY,CAEORACLEPDBAnalyzer | TableQuerywithSchema  | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 |                      |             | BEC,Oracle,CAE_ORACLE_PDB_AY,CAEORACLEPDBAnalyzer | SchemaQuery           | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC |                   |                      |             | BEC,Oracle,CAE_ORACLE_PDB_AY,CAEORACLEPDBAnalyzer | DatabaseQuery         | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 |                            |                   |                      |             | BEC,Oracle,CAE_ORACLE_PDB_AY,CAEORACLEPDBAnalyzer | ServiceQuery          | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc |             |                            |                   |                      |             | BEC,Oracle,CAE_ORACLE_PDB_AY,CAEORACLEPDBAnalyzer | ClusterQuery          | TagAssigned |

  @webtest @MLPQA-3083 @CAE_Oracle
  Scenario:MLP-30466:SC#15_2_Verify common test cases - Logging Enhancements and Processed Items Widget
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "facet selection" in "CAEORACLEPDBAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer%"
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | diqscanora01v.diq.qa.asgint.loc |
      | ORACLE:1521                     |
    Then Analysis log "dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | logCode       | pluginName       | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0019 |                  |                |
      | INFO | Plugin Name:OracleDBAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.2.0.SNAPSHOT, Node Name:LocalNode, Host Name:fc34d10c37a8, Plugin Configuration name:OracleDBAnalyzer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0071 | OracleDBAnalyzer | Plugin Version |
      | INFO | Plugin OracleDBAnalyzer Configuration: --- 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: name: "OracleDBAnalyzer" 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginVersion: "LATEST" 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: label: 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: : "" 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: auditFields: 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: createdBy: "TestSystem" 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: createdAt: "2020-12-04T11:01:16.07457" 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: modifiedBy: "TestSystem" 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: modifiedAt: "2020-12-04T14:18:15.321683" 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: catalogName: "Default" 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: eventClass: null 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: eventCondition: null 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: nodeCondition: "name==\"LocalNode\"" 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: maxWorkSize: 100 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: tags: 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - "CAEORACLEPDBAnalyzer" 2020-12-04 14:18:36.912 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginType: "dataanalyzer" 2020-12-04 14:18:36.913 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: dataSource: null 2020-12-04 14:18:36.923 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: credential: null 2020-12-04 14:18:36.923 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: businessApplicationName: "CAE_ORACLE_PDB_AY" 2020-12-04 14:18:36.923 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: schedule: null 2020-12-04 14:18:36.923 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: filter: null 2020-12-04 14:18:36.923 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: histogramBuckets: 10 2020-12-04 14:18:36.923 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: database: "PDBDB19C.DIQ.QA.ASGINT.LOC" 2020-12-04 14:18:36.923 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: dryRun: false 2020-12-04 14:18:36.923 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginName: "OracleDBAnalyzer" 2020-12-04 14:18:36.923 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: queryBatchSize: 100 2020-12-04 14:18:36.923 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: sampleDataCount: 25 2020-12-04 14:18:36.923 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: schemas: [] 2020-12-04 14:18:36.923 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: type: "Dataanalyzer" 2020-12-04 14:18:36.923 INFO - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: topValues: 10 | ANALYSIS-0073 | OracleDBAnalyzer |                |
      | INFO | Plugin OracleDBAnalyzer Start Time:2020-12-04 14:18:36.909, End Time:2020-12-04 14:19:00.082, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0072 | OracleDBAnalyzer |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:00.264)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0020 |                  |                |

  Scenario:MLP-30466:SC#15_3_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30466:SC#15_4_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

      ########################################################## Common Cases - Dry Run ################################################################################

  Scenario Outline:MLP-30466:SC#15_5_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path     | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |          | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |          | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |          | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |          | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |          | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_PDB/Config/AnalyzerConfig.json | $.DryRun | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |          | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |          | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-3083 @CAE_Oracle
  Scenario:MLP-30466:SC#15_6_Verify Common test cases - DryRun and Processed Count
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath               | Action                | query         | TableName/Filename                             |
      | Description | ida/CAE_Oracle_PDB/API/ExpectedMetadata.json | $.Analysis.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |
    Then Analysis log "dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                    | logCode       | pluginName       | removableText |
      | INFO | Plugin OracleDBAnalyzer running on dry run mode                                             | ANALYSIS-0069 | OracleDBAnalyzer |               |
      | INFO | Plugin OracleDBAnalyzer processed 0 items on dry run mode and not written to the repository | ANALYSIS-0070 | OracleDBAnalyzer |               |
      | INFO | Plugin completed                                                                            | ANALYSIS-0020 |                  |               |

  @MLPQA-3083 @CAE_Oracle
  Scenario:MLP-30466:SC#15_7_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30466:SC#15_8_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

   ########################################################## PII Tags ################################################################################

  Scenario Outline:MLP-30466:SC#16_1_Create root tag and sub tag for Oracle PDB Anlayzer and Update policy tags for Oracle Anlayzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/CAE_Oracle_PDB/API/PolicyEngine/ORACLE_PDB_TagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/CAE_Oracle_PDB/API/PolicyEngine/ORACLE_PDB_Policy1.json      | 204           |                  |          |

  Scenario Outline:MLP-30466:SC#16_2_Configure OracleAnlayzer on LocalNode and run for (Policy Pattern) scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path                             | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_PDB/Config/AnalyzerConfig.json | $.OracleDBAnalyzer_PolicyPattern | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                                  | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |                                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-3081 @CAE_Oracle
  Scenario:SC#16_3_Verify Tag is set for the column when typePattern(String) and dataPattern/minimumRatio matches with the column type/value ratio in Oracle table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                          | Column    | Tags                           | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_PDB_EmailPII_SC1Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC1Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC1Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC1Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC1Tag  | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_PDB_EmailPII_SC1Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC1Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC1Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | EMAIL     | ORACLE_PDB_EmailPII_SC1Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | GENDER    | ORACLE_PDB_GenderPII_SC1Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC1Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | EMAIL     | ORACLE_PDB_EmailPII_SC1Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | GENDER    | ORACLE_PDB_GenderPII_SC1Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | IPADDRESS | ORACLE_PDB_IPAddressPII_SC1Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | SSN       | ORACLE_PDB_SSNPII_SC1Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | FULL_NAME | ORACLE_PDB_FullNamePII_SC1Tag  | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | EMAIL     | ORACLE_PDB_EmailPII_SC1Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | GENDER    | ORACLE_PDB_GenderPII_SC1Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC1Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | SSN       | ORACLE_PDB_SSNPII_SC1Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | FULL_NAME | ORACLE_PDB_FullNamePII_SC1Tag  | ColumnQuerywithSchema | TagAssigned |

  @MLPQA-3080 @CAE_Oracle
  Scenario:MLP-30466:SC#17_Verify Tag is not set for the column when typePattern(other than String) and dataPattern/minimumRatio matches with the column type/value ratio in OracleDB table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                          | Column    | Tags                           | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_PDB_EmailPII_SC2Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC2Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC2Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC2Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC2Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_PDB_EmailPII_SC2Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | GENDER    | ORACLE_PDB_GenderPII_SC2Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC2Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC2Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC2Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | EMAIL     | ORACLE_PDB_EmailPII_SC2Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | GENDER    | ORACLE_PDB_GenderPII_SC2Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC2Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | SSN       | ORACLE_PDB_SSNPII_SC2Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | FULL_NAME | ORACLE_PDB_FullNamePII_SC2Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | EMAIL     | ORACLE_PDB_EmailPII_SC2Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | GENDER    | ORACLE_PDB_GenderPII_SC2Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | IPADDRESS | ORACLE_PDB_IPAddressPII_SC2Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | SSN       | ORACLE_PDB_SSNPII_SC2Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | FULL_NAME | ORACLE_PDB_FullNamePII_SC2Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | EMAIL     | ORACLE_PDB_EmailPII_SC2Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | GENDER    | ORACLE_PDB_GenderPII_SC2Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC2Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | SSN       | ORACLE_PDB_SSNPII_SC2Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | FULL_NAME | ORACLE_PDB_FullNamePII_SC2Tag  | ColumnQuerywithSchema | TagNotAssigned |

  @MLPQA-3079 @CAE_Oracle
  Scenario:MLP-30466:SC#18_Verify Tag is set for the column when namePattern and dataPattern/minimumRatio matches with the column name/value ratio in OracleDB table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                          | Column    | Tags                           | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_PDB_EmailPII_SC3Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC3Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC3Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC3Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC3Tag  | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_PDB_EmailPII_SC3Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC3Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC3Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | EMAIL     | ORACLE_PDB_EmailPII_SC3Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | GENDER    | ORACLE_PDB_GenderPII_SC3Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC3Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | EMAIL     | ORACLE_PDB_EmailPII_SC3Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | GENDER    | ORACLE_PDB_GenderPII_SC3Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | IPADDRESS | ORACLE_PDB_IPAddressPII_SC3Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | SSN       | ORACLE_PDB_SSNPII_SC3Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | FULL_NAME | ORACLE_PDB_FullNamePII_SC3Tag  | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | EMAIL     | ORACLE_PDB_EmailPII_SC3Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | GENDER    | ORACLE_PDB_GenderPII_SC3Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC3Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | SSN       | ORACLE_PDB_SSNPII_SC3Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | FULL_NAME | ORACLE_PDB_FullNamePII_SC3Tag  | ColumnQuerywithSchema | TagAssigned |

  @MLPQA-3078 @CAE_Oracle
  Scenario:MLP-30466:SC#19_Verify Tag is not set for the column when namePattern(does not match) and dataPattern/minimumRatio that does not matches with the column name/value ratio in OracleDB table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                          | Column    | Tags                           | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_PDB_EmailPII_SC4Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC4Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC4Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC4Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC4Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_PDB_EmailPII_SC4Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | GENDER    | ORACLE_PDB_GenderPII_SC4Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC4Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC4Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC4Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | EMAIL     | ORACLE_PDB_EmailPII_SC4Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | GENDER    | ORACLE_PDB_GenderPII_SC4Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC4Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | SSN       | ORACLE_PDB_SSNPII_SC4Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | FULL_NAME | ORACLE_PDB_FullNamePII_SC4Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | EMAIL     | ORACLE_PDB_EmailPII_SC4Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | GENDER    | ORACLE_PDB_GenderPII_SC4Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | IPADDRESS | ORACLE_PDB_IPAddressPII_SC4Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | SSN       | ORACLE_PDB_SSNPII_SC4Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | FULL_NAME | ORACLE_PDB_FullNamePII_SC4Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | EMAIL     | ORACLE_PDB_EmailPII_SC4Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | GENDER    | ORACLE_PDB_GenderPII_SC4Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC4Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | SSN       | ORACLE_PDB_SSNPII_SC4Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | FULL_NAME | ORACLE_PDB_FullNamePII_SC4Tag  | ColumnQuerywithSchema | TagNotAssigned |

  @MLPQA-3077 @CAE_Oracle
  Scenario:MLP-30466:SC#20_Verify Tag is set for the column when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the data in column in OracleDB table. (Ex: 0.2 - 2 or more rows should have matcning column values)- Match Empty is False
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                   | Column    | Tags                           | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | EMAIL     | ORACLE_PDB_EmailPII_SC5Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | GENDER    | ORACLE_PDB_GenderPII_SC5Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | IPADDRESS | ORACLE_PDB_IPAddressPII_SC5Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | SSN       | ORACLE_PDB_SSNPII_SC5Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | FULL_NAME | ORACLE_PDB_FullNamePII_SC5Tag  | ColumnQuerywithSchema | TagAssigned |

  @MLPQA-3076 @CAE_Oracle
  Scenario:MLP-30466:SC#21_Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in OracleDB table -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                          | Column    | Tags                           | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | EMAIL     | ORACLE_PDB_EmailPII_SC6Tag     | ColumnQuerywithSchema | TagAssigned    |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | IPADDRESS | ORACLE_PDB_IPAddressPII_SC6Tag | ColumnQuerywithSchema | TagAssigned    |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | GENDER    | ORACLE_PDB_GenderPII_SC6Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | SSN       | ORACLE_PDB_SSNPII_SC6Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | FULL_NAME | ORACLE_PDB_FullNamePII_SC6Tag  | ColumnQuerywithSchema | TagNotAssigned |

  @MLPQA-3074 @CAE_Oracle
  Scenario:MLP-30466:SC#22_Verify Tag is set for the column when dataPattern and minimumRatio(1-full match) is passed which has a regexp that matches with the data in column in OracleDB table. (Ex: 1 - all rows should match) - Match Empty is false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename  | Column    | Tags                           | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH | EMAIL     | ORACLE_PDB_EmailPII_SC8Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH | GENDER    | ORACLE_PDB_GenderPII_SC8Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH | IPADDRESS | ORACLE_PDB_IPAddressPII_SC8Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH | SSN       | ORACLE_PDB_SSNPII_SC8Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH | FULL_NAME | ORACLE_PDB_FullNamePII_SC8Tag  | ColumnQuerywithSchema | TagAssigned |

  @MLPQA-3073 @CAE_Oracle
  Scenario:MLP-30466:SC#23_Verify Tag is set for the column when dataPattern and minimumRatio(equal to 0.5) is passed which has a regexp that matches with the data in column in OracleDB table. (Ex: 0.5 - 5 or more rows should have matching column values) - Match Empty is false.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                  | Column    | Tags                           | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE | EMAIL     | ORACLE_PDB_EmailPII_SC9Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE | GENDER    | ORACLE_PDB_GenderPII_SC9Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE | IPADDRESS | ORACLE_PDB_IPAddressPII_SC9Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE | SSN       | ORACLE_PDB_SSNPII_SC9Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE | FULL_NAME | ORACLE_PDB_FullNamePII_SC9Tag  | ColumnQuerywithSchema | TagAssigned |

  @MLPQA-3072 @CAE_Oracle
  Scenario:MLP-30466:SC#24_Verify Tag is set for the column when namePattern,typePattern,dataPattern and minimumRatio is passed which has a regexp and minimum ratio that matches with the data in column in OracleDB table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                   | Column    | Tags                            | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | EMAIL     | ORACLE_PDB_EmailPII_SC10Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | GENDER    | ORACLE_PDB_GenderPII_SC10Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | IPADDRESS | ORACLE_PDB_IPAddressPII_SC10Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | SSN       | ORACLE_PDB_SSNPII_SC10Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | FULL_NAME | ORACLE_PDB_FullNamePII_SC10Tag  | ColumnQuerywithSchema | TagAssigned |

  @MLPQA-3071 @CAE_Oracle
  Scenario:MLP-30466:SC#25_Verify Tag is not set for the column when namePattern(does not match),typePattern,dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in column in OracleDB table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                          | Column    | Tags                            | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_PDB_EmailPII_SC11Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC11Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC11Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC11Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC11Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_PDB_EmailPII_SC11Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | GENDER    | ORACLE_PDB_GenderPII_SC11Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC11Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC11Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC11Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | EMAIL     | ORACLE_PDB_EmailPII_SC11Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | GENDER    | ORACLE_PDB_GenderPII_SC11Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC11Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | SSN       | ORACLE_PDB_SSNPII_SC11Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | FULL_NAME | ORACLE_PDB_FullNamePII_SC11Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | EMAIL     | ORACLE_PDB_EmailPII_SC11Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | GENDER    | ORACLE_PDB_GenderPII_SC11Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | IPADDRESS | ORACLE_PDB_IPAddressPII_SC11Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | SSN       | ORACLE_PDB_SSNPII_SC11Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | FULL_NAME | ORACLE_PDB_FullNamePII_SC11Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | EMAIL     | ORACLE_PDB_EmailPII_SC11Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | GENDER    | ORACLE_PDB_GenderPII_SC11Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC11Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | SSN       | ORACLE_PDB_SSNPII_SC11Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | FULL_NAME | ORACLE_PDB_FullNamePII_SC11Tag  | ColumnQuerywithSchema | TagNotAssigned |

  @MLPQA-3070 @CAE_Oracle
  Scenario:MLP-30466:SC#26_Verify Tag is not set for the column when namePattern(does not match) and dataPattern/minimumRatio that does not matches with the column name/value ratio in OracleDB table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                          | Column    | Tags                            | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_PDB_EmailPII_SC12Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC12Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC12Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC12Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC12Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_PDB_EmailPII_SC12Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | GENDER    | ORACLE_PDB_GenderPII_SC12Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC12Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC12Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC12Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | EMAIL     | ORACLE_PDB_EmailPII_SC12Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | GENDER    | ORACLE_PDB_GenderPII_SC12Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC12Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | SSN       | ORACLE_PDB_SSNPII_SC12Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | FULL_NAME | ORACLE_PDB_FullNamePII_SC12Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | EMAIL     | ORACLE_PDB_EmailPII_SC12Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | GENDER    | ORACLE_PDB_GenderPII_SC12Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | IPADDRESS | ORACLE_PDB_IPAddressPII_SC12Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | SSN       | ORACLE_PDB_SSNPII_SC12Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | FULL_NAME | ORACLE_PDB_FullNamePII_SC12Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | EMAIL     | ORACLE_PDB_EmailPII_SC12Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | GENDER    | ORACLE_PDB_GenderPII_SC12Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC12Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | SSN       | ORACLE_PDB_SSNPII_SC12Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | FULL_NAME | ORACLE_PDB_FullNamePII_SC12Tag  | ColumnQuerywithSchema | TagNotAssigned |

  @MLPQA-3069 @MLPQA-3065 @CAE_Oracle
  Scenario:MLP-30466:SC#27_Verify Tag is not set for the column when namePattern(does not match) and dataPattern/minimumRatio that does not matches with the column name/value ratio in OracleDB table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                          | Column    | Tags                            | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_PDB_EmailPII_SC13Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC13Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC13Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC13Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC13Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_PDB_EmailPII_SC13Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | GENDER    | ORACLE_PDB_GenderPII_SC13Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC13Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC13Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC13Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | EMAIL     | ORACLE_PDB_EmailPII_SC13Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | GENDER    | ORACLE_PDB_GenderPII_SC13Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC13Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | SSN       | ORACLE_PDB_SSNPII_SC13Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | FULL_NAME | ORACLE_PDB_FullNamePII_SC13Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | EMAIL     | ORACLE_PDB_EmailPII_SC13Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | GENDER    | ORACLE_PDB_GenderPII_SC13Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | IPADDRESS | ORACLE_PDB_IPAddressPII_SC13Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | SSN       | ORACLE_PDB_SSNPII_SC13Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | FULL_NAME | ORACLE_PDB_FullNamePII_SC13Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | EMAIL     | ORACLE_PDB_EmailPII_SC13Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | GENDER    | ORACLE_PDB_GenderPII_SC13Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC13Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | SSN       | ORACLE_PDB_SSNPII_SC13Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | FULL_NAME | ORACLE_PDB_FullNamePII_SC13Tag  | ColumnQuerywithSchema | TagNotAssigned |

  @MLPQA-3068 @CAE_Oracle
  Scenario:MLP-30466:SC#28_Verify Tag is set for the column when match empty is true and all the column values in DB are empty.(dataPattern/minimumRatio/MatchEmpty:True/MatchFull:False)
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename  | Column    | Tags                            | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY | EMAIL     | ORACLE_PDB_EmailPII_SC14Tag     | ColumnQuerywithSchema | TagAssigned    |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY | GENDER    | ORACLE_PDB_GenderPII_SC14Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY | IPADDRESS | ORACLE_PDB_IPAddressPII_SC14Tag | ColumnQuerywithSchema | TagAssigned    |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY | SSN       | ORACLE_PDB_SSNPII_SC14Tag       | ColumnQuerywithSchema | TagAssigned    |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY | FULL_NAME | ORACLE_PDB_FullNamePII_SC14Tag  | ColumnQuerywithSchema | TagNotAssigned |

  @MLPQA-3067 @CAE_Oracle
  Scenario:MLP-30466:SC#29_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with DB
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                         | Column   | Tags                           | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05MATCHFULLTRUE | COMMENTS | ORACLE_PDB_FullMatchPII_SC1Tag | ColumnQuerywithSchema | TagNotAssigned |

  @MLPQA-3066 @CAE_Oracle
  Scenario:MLP-30466:SC#30_1_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(lesser than 0.5) matches with OracleDB DB.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                        | Column   | Tags                           | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSERTHAN05MATCHFULLTRUE | COMMENTS | ORACLE_PDB_FullMatchPII_SC3Tag | ColumnQuerywithSchema | TagNotAssigned |

  Scenario Outline:MLP-30466:SC#31_1_Create root tag and sub tag for Oracle PDB Anlayzer and Update policy tags for Oracle Anlayzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | body                                                        | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions | ida/CAE_Oracle_PDB/API/PolicyEngine/ORACLE_PDB_Policy2.json | 204           |                  |          |

  Scenario Outline:MLP-30466:SC#31_2_Configure OracleAnlayzer on LocalNode and run for (Policy Pattern) scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | bodyFile                                               | path                             | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                   | payloads/ida/CAE_Oracle_PDB/Config/AnalyzerConfig.json | $.OracleDBAnalyzer_PolicyPattern | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                        |                                  | 200           | OracleDBAnalyzer |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  |                                                        |                                  | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status |

  @MLPQA-3075 @CAE_Oracle
  Scenario:MLP-30466:SC#31_3_Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in OracleDB table -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                          | Column    | Tags                           | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | EMAIL     | ORACLE_PDB_EmailPII_SC7Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | GENDER    | ORACLE_PDB_GenderPII_SC7Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | IPADDRESS | ORACLE_PDB_IPAddressPII_SC7Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | SSN       | ORACLE_PDB_SSNPII_SC7Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | FULL_NAME | ORACLE_PDB_FullNamePII_SC7Tag  | ColumnQuerywithSchema | TagAssigned |

  @MLPQA-3067 @CAE_Oracle
  Scenario:MLP-30466:SC#32_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with DB
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                         | Column   | Tags                           | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05MATCHFULLTRUE | COMMENTS | ORACLE_PDB_FullMatchPII_SC2Tag | ColumnQuerywithSchema | TagAssigned |

  @MLPQA-3066 @CAE_Oracle
  Scenario:MLP-30466:SC#33_1_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(lesser than 0.5) matches with OracleDB DB.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName               | SchemaName       | TableName/Filename                        | Column   | Tags                           | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSERTHAN05MATCHFULLTRUE | COMMENTS | ORACLE_PDB_FullMatchPII_SC4Tag | ColumnQuerywithSchema | TagAssigned |

  Scenario:MLP-30466:SC#33_2_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30466:SC#33_3_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

   ########################################################## Delete Configurations ################################################################################

  @jdbc
  Scenario Outline:SC#34_Delete Plugin Configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                       | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | tags/Default/structures/ORACLE_PDB_PII                    |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDeleteEntryPoint                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAECreateEntryPoint                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleCollector                        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEFeed                                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDDLoader                            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBCataloger                      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBAnalyzer                       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBDataSource/OracleCDBDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEOracleDataSource/CAEOracleDS        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDataSource/CAEDataSource            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/CAEEntryPointCredentials             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/CAECredentials                       |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/OracleCredentials                    |      | 200           |                  |          |

        ########################################################## Oracle19c CDB ################################################################################

  Scenario Outline:PreCondition :Configure CAEEntrypointCredentials,CAECredentials,Oracle Credentials and Data Source for CAEEntryPoint and OracleCollector of Oracle CDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                           | bodyFile                                            | path                       | response code | response message    | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/CAEEntryPointCredentials | payloads/ida/CAE_Oracle_CDB/Config/Credentials.json | $.CAEEntryPointCredentials | 200           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/CAEEntryPointCredentials |                                                     |                            | 200           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/CAECredentials           | payloads/ida/CAE_Oracle_CDB/Config/Credentials.json | $.CAECredentials           | 200           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/CAECredentials           |                                                     |                            | 200           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/OracleCredentials        | payloads/ida/CAE_Oracle_CDB/Config/Credentials.json | $.OracleCredentials        | 200           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/OracleCredentials        |                                                     |                            | 200           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDataSource              | payloads/ida/CAE_Oracle_CDB/Config/DataSource.json  | $.CAEDataSource            | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDataSource              |                                                     |                            | 200           | CAEDataSource       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEOracleDataSource        | payloads/ida/CAE_Oracle_CDB/Config/DataSource.json  | $.CAEOracleDataSource      | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEOracleDataSource        |                                                     |                            | 200           | CAEOracleDS         |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleDBDataSource         | payloads/ida/CAE_Oracle_CDB/Config/DataSource.json  | $.OraclePDBDataSource      | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleDBDataSource         |                                                     |                            | 200           | OraclePDBDataSource |          |

  #####################################################################  Plugin Configurations ##############################################################

  Scenario Outline:PreCondition :Create plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle CDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | bodyFile                                             | path                  | response code | response message    | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDeleteEntryPoint | payloads/ida/CAE_Oracle_CDB/Config/PluginConfig.json | $.CAEDeleteEntryPoint | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDeleteEntryPoint |                                                      |                       | 200           | CAEDeleteEntryPoint |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAECreateEntryPoint | payloads/ida/CAE_Oracle_CDB/Config/PluginConfig.json | $.CAECreateEntryPoint | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAECreateEntryPoint |                                                      |                       | 200           | CAECreateEntryPoint |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleCollector     | payloads/ida/CAE_Oracle_CDB/Config/PluginConfig.json | $.OracleCollector     | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleCollector     |                                                      |                       | 200           | OracleCollector     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEFeed             | payloads/ida/CAE_Oracle_CDB/Config/PluginConfig.json | $.CAEFeeder           | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEFeed             |                                                      |                       | 200           | CAEFeeder           |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/CAEDDLoader         | payloads/ida/CAE_Oracle_CDB/Config/PluginConfig.json | $.CAELoader           | 204           |                     |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/CAEDDLoader         |                                                      |                       | 200           | CAELoader           |          |


     ########################################################## Same Table in MultipleSchema filter for Table ################################################################################

  Scenario Outline:MLP-30962:SC#1_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle CDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path                            | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                                 | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                                 | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                                 | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                                 | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                                 | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_CDB/Config/AnalyzerConfig.json | $.SameTableMultipleSchemaFilter | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                                 | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |                                 | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                                 | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-3054 @CAE_Oracle
  Scenario Outline:MLP-30962:SC#1_2_User get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                             | asg_scopeid | targetFile                                 | jsonpath                                |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | ORCL19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES |             | payloads/ida/CAE_Oracle_CDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES |

  @MLPQA-3054 @CAE_Oracle
  Scenario Outline:MLP-30962:SC#1_2_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                                  | outPutFile                                                       | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES | payloads/ida/CAE_Oracle_CDB/API/items.json | payloads\ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES.json |            |

  @MLPQA-3054 @CAE_Oracle
  Scenario:MLP-30962:SC#1_2_Update the values with null for the dynamic columns for (duplicate schema and duplicate tables)
    And user "update" the json file "ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |

  @MLPQA-3054 @CAE_Oracle
  Scenario:MLP-30962:SC#1_2_Verify data sampling happens properly when table name alone given in filter(table present in more than one schema)
    Then file content in "ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\CAE_Oracle_CDB\API\Expected\ORACLE_DIFFDATATYPES.json"

  @MLPQA-3054 @CAE_Oracle
  Scenario:MLP-30962:SC#1_3_Verify data profiling happens properly when table name alone given in filter(table present in more than one schema)
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath                                                       | Action                    | query                 | ClusterName                     | ServiceName | DatabaseName              | SchemaName        | TableName/Filename   | columnName/FieldName |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA1.ORACLE_TABLE.Lifecycle                     | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_TABLE         |                      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA1.ORACLE_TAG_DETAILS.Lifecycle               | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_TAG_DETAILS   |                      |

  Scenario:MLP-30962:SC#1_4_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30962:SC#1_4_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

              ########################################################## Schema/Table Multiple Duplicate filters. ################################################################################

  Scenario Outline:MLP-30962:SC#2_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path                                 | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                                      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                                      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                                      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                                      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                                      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_CDB/Config/AnalyzerConfig.json | $.SchemaTableMultipleDuplicateFilter | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                                      | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |                                      | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                                      | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-3053 @CAE_Oracle
  Scenario Outline:MLP-30962:SC#2_2_User get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES" and "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                             | asg_scopeid | targetFile                                 | jsonpath                                |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | ORCL19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES |             | payloads/ida/CAE_Oracle_CDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | ORCL19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TAG_DETAILS   |             | payloads/ida/CAE_Oracle_CDB/API/items.json | $.Tables.TableName.ORACLE_TAG_DETAILS   |

  @MLPQA-3053 @CAE_Oracle
  Scenario Outline:MLP-30962:SC#2_2_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                                  | outPutFile                                                       | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES | payloads/ida/CAE_Oracle_CDB/API/items.json | payloads\ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES.json |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TAG_DETAILS   | payloads/ida/CAE_Oracle_CDB/API/items.json | payloads\ida\CAE_Oracle_CDB\API\Actual\ORACLE_TAG_DETAILS.json   |            |

  @MLPQA-3053 @CAE_Oracle
  Scenario:MLP-30962:SC#2_2_Update the values with null for the dynamic columns for (duplicate schema and duplicate tables)
    And user "update" the json file "ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\CAE_Oracle_CDB\API\Actual\ORACLE_TAG_DETAILS.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[10] |            | Array |
      | $..sample.values[0].[11] |            | Array |
      | $..sample.values[1].[10] |            | Array |
      | $..sample.values[1].[11] |            | Array |
      | $..sample.values[2].[10] |            | Array |
      | $..sample.values[2].[11] |            | Array |
      | $..sample.values[3].[10] |            | Array |
      | $..sample.values[3].[11] |            | Array |

  @MLPQA-3053 @CAE_Oracle
  Scenario:MLP-30962:SC#2_2_Verify data sampling works fine for String, Numeric, Date, Time, and Timestamp, Complex Types with schema/table multiple duplicate filters.
    Then file content in "ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\CAE_Oracle_CDB\API\Expected\ORACLE_DIFFDATATYPES.json"
    Then file content in "ida\CAE_Oracle_CDB\API\Actual\ORACLE_TAG_DETAILS.json" should be same as the content in "ida\CAE_Oracle_CDB\API\Expected\ORACLE_TAG_DETAILS.json"

  @MLPQA-3052 @CAE_Oracle
  Scenario:MLP-30962:SC#3_1_Verify data profiling works fine for String, Numeric, Date, Time, and Timestamp types with schema/table multiple duplicate filters.
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath                                                       | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName              | SchemaName        | TableName/Filename        | columnName/FieldName |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES.Lifecycle             | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES      |                      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES_VIEW.Lifecycle        | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES_VIEW |                      |

  Scenario:MLP-30962:SC#3_2_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30962:SC#3_2_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

              ##########################################################  More than one database ################################################################################

  Scenario Outline:MLP-30962:SC#4_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path                  | response code | response message   | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                       | 200           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                       | 200           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                       | 200           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                       | 200           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                       | 200           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger                                                     | payloads/ida/CAE_Oracle_CDB/Config/PluginConfig.json   | $.OraclePDBCataloger  | 204           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger                                                     |                                                        |                       | 200           | OraclePDBCataloger |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OraclePDBCataloger     |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='OraclePDBCataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OraclePDBCataloger      |                                                        |                       | 200           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OraclePDBCataloger     |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='OraclePDBCataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_CDB/Config/AnalyzerConfig.json | $.MorethanOneDatabase | 204           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                       | 200           | OracleDBAnalyzer   |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |                       | 200           |                    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                       | 200           | IDLE               | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-3050 @CAE_Oracle
  Scenario Outline:MLP-30962:SC#4_2_User get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES" and "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                             | asg_scopeid | targetFile                                 | jsonpath                                |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | ORCL19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES |             | payloads/ida/CAE_Oracle_CDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | ORCL19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TAG_DETAILS   |             | payloads/ida/CAE_Oracle_CDB/API/items.json | $.Tables.TableName.ORACLE_TAG_DETAILS   |

  @MLPQA-3050 @CAE_Oracle
  Scenario Outline:MLP-30962:SC#4_2_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                                  | outPutFile                                                       | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES | payloads/ida/CAE_Oracle_CDB/API/items.json | payloads\ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES.json |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TAG_DETAILS   | payloads/ida/CAE_Oracle_CDB/API/items.json | payloads\ida\CAE_Oracle_CDB\API\Actual\ORACLE_TAG_DETAILS.json   |            |

  @MLPQA-3050 @CAE_Oracle
  Scenario:MLP-30962:SC#4_2_Update the values with null for the dynamic columns for (duplicate schema and duplicate tables)
    And user "update" the json file "ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\CAE_Oracle_CDB\API\Actual\ORACLE_TAG_DETAILS.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[10] |            | Array |
      | $..sample.values[0].[11] |            | Array |
      | $..sample.values[1].[10] |            | Array |
      | $..sample.values[1].[11] |            | Array |
      | $..sample.values[2].[10] |            | Array |
      | $..sample.values[2].[11] |            | Array |
      | $..sample.values[3].[10] |            | Array |
      | $..sample.values[3].[11] |            | Array |

  @MLPQA-3050 @CAE_Oracle
  Scenario:MLP-30962:SC#4_2_Verify data sampling happens properly when more than one database is analyzed.(CAE,DD)
    Then file content in "ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\CAE_Oracle_CDB\API\Expected\ORACLE_DIFFDATATYPES.json"
    Then file content in "ida\CAE_Oracle_CDB\API\Actual\ORACLE_TAG_DETAILS.json" should be same as the content in "ida\CAE_Oracle_CDB\API\Expected\ORACLE_TAG_DETAILS.json"

  @MLPQA-3050 @CAE_Oracle
  Scenario:MLP-30962:SC#4_3_Verify data profiling happens properly when more than one database is analyzed.(CAE,DD)
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath                                                       | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename        | columnName/FieldName |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1    | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES.Lifecycle             | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES      |                      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES_VIEW.Lifecycle        | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC  | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES_VIEW |                      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES.Lifecycle             | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES      |                      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE12C_SCHEMA2.ORACLE_DIFFDATATYPES_VIEW.Lifecycle        | metadataAttributeNonPresence | TableQuerywithSchema  | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA2 | ORACLE_DIFFDATATYPES_VIEW |                      |

  Scenario:MLP-30962:SC#4_4_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30962:SC#4_4_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OracleDBCataloger/OraclePDBCataloger% | Analysis |       |       |

  ########################################################## Analyzer in InternalNode ################################################################################

  Scenario Outline:MLP-30962:SC#5_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path             | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_CDB/Config/AnalyzerConfig.json | $.InInternalNode | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                  | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/OracleDBAnalyzer/*                 |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/OracleDBAnalyzer/*                  |                                                        |                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/OracleDBAnalyzer/*                 |                                                        |                  | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-16809 @CAE_Oracle
  Scenario Outline:MLP-30962:SC#5_2_User get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES" and "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                             | asg_scopeid | targetFile                                 | jsonpath                                |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | ORCL19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES |             | payloads/ida/CAE_Oracle_CDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | ORCL19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TAG_DETAILS   |             | payloads/ida/CAE_Oracle_CDB/API/items.json | $.Tables.TableName.ORACLE_TAG_DETAILS   |

  @MLPQA-16809 @CAE_Oracle
  Scenario Outline:MLP-30962:SC#5_2_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                                  | outPutFile                                                       | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES | payloads/ida/CAE_Oracle_CDB/API/items.json | payloads\ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES.json |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TAG_DETAILS   | payloads/ida/CAE_Oracle_CDB/API/items.json | payloads\ida\CAE_Oracle_CDB\API\Actual\ORACLE_TAG_DETAILS.json   |            |

  @MLPQA-16809 @CAE_Oracle
  Scenario:MLP-30962:SC#5_2_Update the values with null for the dynamic columns for (duplicate schema and duplicate tables)
    And user "update" the json file "ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\CAE_Oracle_CDB\API\Actual\ORACLE_TAG_DETAILS.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[10] |            | Array |
      | $..sample.values[0].[11] |            | Array |
      | $..sample.values[1].[10] |            | Array |
      | $..sample.values[1].[11] |            | Array |
      | $..sample.values[2].[10] |            | Array |
      | $..sample.values[2].[11] |            | Array |
      | $..sample.values[3].[10] |            | Array |
      | $..sample.values[3].[11] |            | Array |

  @MLPQA-16809 @CAE_Oracle
  Scenario:MLP-30962:SC#5_2_Verify data sampling works fine for OracleAnalyzer runs fine in all nodes(Internal Node)
    Then file content in "ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\CAE_Oracle_CDB\API\Expected\ORACLE_DIFFDATATYPES.json"
    Then file content in "ida\CAE_Oracle_CDB\API\Actual\ORACLE_TAG_DETAILS.json" should be same as the content in "ida\CAE_Oracle_CDB\API\Expected\ORACLE_TAG_DETAILS.json"

  @MLPQA-16809 @CAE_Oracle
  Scenario:MLP-30962:SC#5_3_Verify data profiling works fine for OracleAnalyzer runs fine in all nodes(Internal Node)
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath                                                       | Action                    | query                 | ClusterName                     | ServiceName | DatabaseName              | SchemaName        | TableName/Filename   | columnName/FieldName |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |

  Scenario:MLP-30962:SC#5_4_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30962:SC#5_4_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

      ########################################################## Analyzer in CAENode ################################################################################

  Scenario Outline:MLP-30962:SC#6_1_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path                | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                     | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                     | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                     | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                     | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                     | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_CDB/Config/AnalyzerConfig.json | $.InIBecubicIDANode | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                     | 200           | BecubicIDANode   |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/dataanalyzer/OracleDBAnalyzer/*               |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/dataanalyzer/OracleDBAnalyzer/*                |                                                        |                     | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/dataanalyzer/OracleDBAnalyzer/*               |                                                        |                     | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-16809 @CAE_Oracle
  Scenario Outline:MLP-30962:SC#6_2_User get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES" and "ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                             | asg_scopeid | targetFile                                 | jsonpath                                |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | ORCL19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES |             | payloads/ida/CAE_Oracle_CDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | ORCL19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TAG_DETAILS   |             | payloads/ida/CAE_Oracle_CDB/API/items.json | $.Tables.TableName.ORACLE_TAG_DETAILS   |

  @MLPQA-16809 @CAE_Oracle
  Scenario Outline:MLP-30962:SC#6_2_User hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                               | inputFile                                  | outPutFile                                                           | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES | payloads/ida/CAE_Oracle_CDB/API/items.json | payloads\ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES_CAE.json |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TAG_DETAILS   | payloads/ida/CAE_Oracle_CDB/API/items.json | payloads\ida\CAE_Oracle_CDB\API\Actual\ORACLE_TAG_DETAILS.json       |            |

  @MLPQA-16809 @CAE_Oracle
  Scenario:MLP-30962:SC#6_2_Update the values with null for the dynamic columns for (duplicate schema and duplicate tables)
    And user "update" the json file "ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES_CAE.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[10] |            | Array |
      | $..sample.values[0].[11] |            | Array |
      | $..sample.values[0].[12] |            | Array |
      | $..sample.values[0].[13] |            | Array |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[10] |            | Array |
      | $..sample.values[1].[11] |            | Array |
      | $..sample.values[1].[12] |            | Array |
      | $..sample.values[1].[13] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[10] |            | Array |
      | $..sample.values[2].[11] |            | Array |
      | $..sample.values[2].[12] |            | Array |
      | $..sample.values[2].[13] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[10] |            | Array |
      | $..sample.values[3].[11] |            | Array |
      | $..sample.values[3].[12] |            | Array |
      | $..sample.values[3].[13] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[10] |            | Array |
      | $..sample.values[4].[11] |            | Array |
      | $..sample.values[4].[12] |            | Array |
      | $..sample.values[4].[13] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\CAE_Oracle_CDB\API\Actual\ORACLE_TAG_DETAILS.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[10] |            | Array |
      | $..sample.values[0].[11] |            | Array |
      | $..sample.values[1].[10] |            | Array |
      | $..sample.values[1].[11] |            | Array |
      | $..sample.values[2].[10] |            | Array |
      | $..sample.values[2].[11] |            | Array |
      | $..sample.values[3].[10] |            | Array |
      | $..sample.values[3].[11] |            | Array |

  @MLPQA-16809 @CAE_Oracle
  Scenario:MLP-30962:SC#6_2_Verify data sampling works fine for OracleAnalyzer runs fine in all nodes(CAENode)
    Then file content in "ida\CAE_Oracle_CDB\API\Actual\ORACLE_DIFFDATATYPES_CAE.json" should be same as the content in "ida\CAE_Oracle_CDB\API\Expected\ORACLE_DIFFDATATYPES_CAE.json"
    Then file content in "ida\CAE_Oracle_CDB\API\Actual\ORACLE_TAG_DETAILS.json" should be same as the content in "ida\CAE_Oracle_CDB\API\Expected\ORACLE_TAG_DETAILS.json"

  @MLPQA-16809 @CAE_Oracle
  Scenario:MLP-30962:SC#6_3_Verify data profiling works fine for OracleAnalyzer runs fine in all nodes(CAE Node)
    Given Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath                                                       | Action                    | query                 | ClusterName                     | ServiceName | DatabaseName              | SchemaName        | TableName/Filename   | columnName/FieldName |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BFILECOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYDOUBLECOLUMN   |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BINARYFLOATCOLUMN    |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | BLOBCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CHARCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | CLOBCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | DATECOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | LONGCOLUMN           |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCHARCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NCLOBCOLUMN          |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NUMBERCOLUMN         |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | NVARCHAR2COLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | RAWCOLUMN            |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | ROWIDCOLUMN          |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | TIMESTAMPCOLUMN      |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | UROWIDCOLUMN         |
      | Statistics  | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Lifecycle   | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence     | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | VARCHAR2COLUMN       |

        ########################################################## Common Cases - Technology Tags/Business Item/Explicit Tag ################################################################################

  @MLPQA-3049 @CAE_Oracle
  Scenario:MLP-30962:SC#7_1_Verify Technology tag , Explicit tag , Bussiness Application tag and File Filter tag
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName              | SchemaName        | TableName/Filename   | Column      | Tags                                              | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN | BEC,Oracle,CAE_ORACLE_CDB_AY,CAEORACLECDBAnalyzer | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES |             | BEC,Oracle,CAE_ORACLE_CDB_AY,CAEORACLECDBAnalyzer | TableQuerywithSchema  | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 |                      |             | BEC,Oracle,CAE_ORACLE_CDB_AY,CAEORACLECDBAnalyzer | SchemaQuery           | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC |                   |                      |             | BEC,Oracle,CAE_ORACLE_CDB_AY,CAEORACLECDBAnalyzer | DatabaseQuery         | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 |                           |                   |                      |             | BEC,Oracle,CAE_ORACLE_CDB_AY,CAEORACLECDBAnalyzer | ServiceQuery          | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc |             |                           |                   |                      |             | BEC,Oracle,CAE_ORACLE_CDB_AY,CAEORACLECDBAnalyzer | ClusterQuery          | TagAssigned |

  Scenario:MLP-30962:SC#7_2_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30962:SC#7_3_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

      ########################################################## Common Cases - Dry Run ################################################################################

  Scenario Outline:MLP-30962:SC#7_4_Run plugin configurations of CAEDeleteEntryPoint,CAECreateEntryPoint,CAEOracleCollector,CAEFeeder and CAELoader of Oracle PDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path     | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |          | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |          | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |          | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |          | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |          | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_CDB/Config/AnalyzerConfig.json | $.DryRun | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |          | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |          | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |          | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-3049 @CAE_Oracle
  Scenario:MLP-30962:SC#7_5_Verify Common test cases - DryRun and Processed Count
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                     | jsonPath               | Action                | query         | TableName/Filename                             |
      | Description | ida/CAE_Oracle_CDB/API/ExpectedMetadata.json | $.Analysis.Description | metadataValuePresence | AnalysisQuery | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |
    Then Analysis log "dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer%" should display below info/error/warning
      | type | logValue                                                                                    | logCode       | pluginName       | removableText |
      | INFO | Plugin OracleDBAnalyzer running on dry run mode                                             | ANALYSIS-0069 | OracleDBAnalyzer |               |
      | INFO | Plugin OracleDBAnalyzer processed 0 items on dry run mode and not written to the repository | ANALYSIS-0070 | OracleDBAnalyzer |               |
      | INFO | Plugin completed                                                                            | ANALYSIS-0020 |                  |               |

  Scenario:MLP-30962:SC#7_6_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30962:SC#7_7_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

     ########################################################## PII Tags ################################################################################

  Scenario Outline:MLP-30962:SC#8_1_Create root tag and sub tag for Oracle PDB Anlayzer and Update policy tags for Oracle Anlayzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/CAE_Oracle_CDB/API/PolicyEngine/ORACLE_CDB_TagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/CAE_Oracle_CDB/API/PolicyEngine/ORACLE_CDB_policy1.json      | 204           |                  |          |

  Scenario Outline:MLP-30962:SC#8_2_Configure OracleAnlayzer on LocalNode and run for (Policy Pattern) scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | bodyFile                                               | path                             | response code | response message | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint  |                                                        |                                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAEDeleteEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint  |                                                        |                                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/tools/CAECreateEntryPoint/CAECreateEntryPoint |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAECreateEntryPoint')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/OracleCollector/OracleCollector            |                                                        |                                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/OracleCollector/OracleCollector           |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='OracleCollector')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/cae/CAEFeed/CAEFeeder                          |                                                        |                                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/cae/CAEFeed/CAEFeeder                         |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAEFeeder')].status           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/BecubicIDANode/bulk/CAEDDLoader/CAELoader                     |                                                        |                                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/BecubicIDANode/bulk/CAEDDLoader/CAELoader                    |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='CAELoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                                      | payloads/ida/CAE_Oracle_CDB/Config/AnalyzerConfig.json | $.OracleDBAnalyzer_PolicyPattern | 204           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                                      |                                                        |                                  | 200           | OracleDBAnalyzer |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*                     |                                                        |                                  | 200           |                  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/*                    |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status    |

  @MLPQA-3042 @CAE_Oracle
  Scenario:MLP-30962:SC#8_3_Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in OracleDB table -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName              | SchemaName          | TableName/Filename                          | Column    | Tags                           | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | EMAIL     | ORACLE_CDB_EmailPII_SC6Tag     | ColumnQuerywithSchema | TagAssigned    |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | IPADDRESS | ORACLE_CDB_IPAddressPII_SC6Tag | ColumnQuerywithSchema | TagAssigned    |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | GENDER    | ORACLE_CDB_GenderPII_SC6Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | SSN       | ORACLE_CDB_SSNPII_SC6Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | FULL_NAME | ORACLE_CDB_FullNamePII_SC6Tag  | ColumnQuerywithSchema | TagNotAssigned |

  @MLPQA-3038 @CAE_Oracle
  Scenario:MLP-30466:SC#9_Verify Tag is set for the column when namePattern,typePattern,dataPattern and minimumRatio is passed which has a regexp and minimum ratio that matches with the data in column in OracleDB table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName              | SchemaName          | TableName/Filename                   | Column    | Tags                            | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | EMAIL     | ORACLE_CDB_EmailPII_SC10Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | GENDER    | ORACLE_CDB_GenderPII_SC10Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | IPADDRESS | ORACLE_CDB_IPAddressPII_SC10Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | SSN       | ORACLE_CDB_SSNPII_SC10Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE | FULL_NAME | ORACLE_CDB_FullNamePII_SC10Tag  | ColumnQuerywithSchema | TagAssigned |

  @MLPQA-3044 @CAE_Oracle
  Scenario:MLP-30962:SC#10_Verify Tag is not set for the column when namePattern(does not match),typePattern,dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in column in OracleDB table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName              | SchemaName          | TableName/Filename                          | Column    | Tags                            | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_CDB_EmailPII_SC11Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_CDB_GenderPII_SC11Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_CDB_IPAddressPII_SC11Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_CDB_SSNPII_SC11Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_CDB_FullNamePII_SC11Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_CDB_EmailPII_SC11Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | GENDER    | ORACLE_CDB_GenderPII_SC11Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_CDB_IPAddressPII_SC11Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_CDB_SSNPII_SC11Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_CDB_FullNamePII_SC11Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | EMAIL     | ORACLE_CDB_EmailPII_SC11Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | GENDER    | ORACLE_CDB_GenderPII_SC11Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | IPADDRESS | ORACLE_CDB_IPAddressPII_SC11Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | SSN       | ORACLE_CDB_SSNPII_SC11Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSTHAN05EMPTYFALSE        | FULL_NAME | ORACLE_CDB_FullNamePII_SC11Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | EMAIL     | ORACLE_CDB_EmailPII_SC11Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | GENDER    | ORACLE_CDB_GenderPII_SC11Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | IPADDRESS | ORACLE_CDB_IPAddressPII_SC11Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | SSN       | ORACLE_CDB_SSNPII_SC11Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | FULL_NAME | ORACLE_CDB_FullNamePII_SC11Tag  | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | EMAIL     | ORACLE_CDB_EmailPII_SC11Tag     | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | GENDER    | ORACLE_CDB_GenderPII_SC11Tag    | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | IPADDRESS | ORACLE_CDB_IPAddressPII_SC11Tag | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | SSN       | ORACLE_CDB_SSNPII_SC11Tag       | ColumnQuerywithSchema | TagNotAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOEQUALTO05EMPTYFALSE         | FULL_NAME | ORACLE_CDB_FullNamePII_SC11Tag  | ColumnQuerywithSchema | TagNotAssigned |

  @MLPQA-3033 @CAE_Oracle
  Scenario:MLP-30962:SC#11_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with DB
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName              | SchemaName          | TableName/Filename                         | Column   | Tags                           | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05MATCHFULLTRUE | COMMENTS | ORACLE_CDB_FullMatchPII_SC1Tag | ColumnQuerywithSchema | TagNotAssigned |

  @MLPQA-3032 @CAE_Oracle
  Scenario:MLP-30962:SC#12_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(lesser than 0.5) matches with OracleDB DB.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName              | SchemaName          | TableName/Filename                        | Column   | Tags                           | Query                 | Action         |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSERTHAN05MATCHFULLTRUE | COMMENTS | ORACLE_CDB_FullMatchPII_SC3Tag | ColumnQuerywithSchema | TagNotAssigned |

  Scenario Outline:MLP-30466:SC#13_1_Create root tag and sub tag for Oracle CDB Anlayzer and Update policy tags for Oracle Anlayzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | body                                                        | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions | ida/CAE_Oracle_CDB/API/PolicyEngine/ORACLE_CDB_Policy2.json | 204           |                  |          |

  Scenario Outline:MLP-30466:SC#13_2_Configure OracleAnlayzer on LocalNode and run for (Policy Pattern) scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | bodyFile                                               | path                             | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer                                   | payloads/ida/CAE_Oracle_CDB/Config/AnalyzerConfig.json | $.OracleDBAnalyzer_PolicyPattern | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                        |                                  | 200           | OracleDBAnalyzer |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  |                                                        |                                  | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                        |                                  | 200           | IDLE             | $.[?(@.configurationName=='OracleDBAnalyzer')].status |

  @MLPQA-3042 @CAE_Oracle
  Scenario:MLP-30466:SC#13_3_Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in OracleDB table -10 rows , 3 rows empty, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName              | SchemaName          | TableName/Filename                          | Column    | Tags                           | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | EMAIL     | ORACLE_CDB_EmailPII_SC7Tag     | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | GENDER    | ORACLE_CDB_GenderPII_SC7Tag    | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | IPADDRESS | ORACLE_CDB_IPAddressPII_SC7Tag | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | SSN       | ORACLE_CDB_SSNPII_SC7Tag       | ColumnQuerywithSchema | TagAssigned |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05EMPTYFALSETRUE | FULL_NAME | ORACLE_CDB_FullNamePII_SC7Tag  | ColumnQuerywithSchema | TagAssigned |

  @MLPQA-3033 @CAE_Oracle
  Scenario:MLP-30466:SC#14_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with DB
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName              | SchemaName          | TableName/Filename                         | Column   | Tags                           | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOGREATERTHAN05MATCHFULLTRUE | COMMENTS | ORACLE_CDB_FullMatchPII_SC2Tag | ColumnQuerywithSchema | TagAssigned |

  @MLPQA-3032 @CAE_Oracle
  Scenario:MLP-30466:SC#15_1_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(lesser than 0.5) matches with OracleDB DB.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                     | ServiceName | DatabaseName              | SchemaName          | TableName/Filename                        | Column   | Tags                           | Query                 | Action      |
      | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | ORCL19C.DIQ.QA.ASGINT.LOC | C##TEST_TAGGING_CAE | TAGDETAILS_RATIOLESSERTHAN05MATCHFULLTRUE | COMMENTS | ORACLE_CDB_FullMatchPII_SC4Tag | ColumnQuerywithSchema | TagAssigned |

  Scenario:MLP-30466:SC#15_2_Delete DataPackage,DataType,DataField,File,Directory,Project,Service and Analyzer Analysis file of BEC
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type        | query | param |
      | MultipleIDDelete | Default | PROGRAM.ORACLE SQL%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | INCLUDE.COBOL%                                 | DataPackage |       |       |
      | MultipleIDDelete | Default | $$DefaultDataTypes%                            | DataPackage |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataType    |       |       |
      | SingleItemDelete | Default | CHAR                                           | DataType    |       |       |
      | SingleItemDelete | Default | INTEGER                                        | DataType    |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | DataField   |       |       |
      | MultipleIDDelete | Default | SQLCA%                                         | File        |       |       |
      | SingleItemDelete | Default | VISTA_STD                                      | Directory   |       |       |
      | SingleItemDelete | Default | Include File                                   | Directory   |       |       |
      | SingleItemDelete | Default | DEFAULT                                        | Project     |       |       |
      | MultipleIDDelete | Default | $$CAE Analysis                                 | Service     |       |       |
      | MultipleIDDelete | Default | tools/CAEDeleteEntryPoint/CAEDeleteEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | tools/CAECreateEntryPoint/CAECreateEntryPoint% | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/OracleCollector/OracleCollector%           | Analysis    |       |       |
      | MultipleIDDelete | Default | cae/CAEFeed/CAEFeeder%                         | Analysis    |       |       |
      | MultipleIDDelete | Default | bulk/CAEDDLoader/CAELoader%                    | Analysis    |       |       |

  Scenario:MLP-30466:SC#15_3_Delete Cluster,DataType and Analyzer Analysis file of Oracle
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | VARCHAR2                                        | DataType |       |       |
      | SingleItemDelete | Default | FLOAT                                           | DataType |       |       |
      | SingleItemDelete | Default | NUMERIC                                         | DataType |       |       |
      | SingleItemDelete | Default | BLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | CLOB                                            | DataType |       |       |
      | SingleItemDelete | Default | NCLOB                                           | DataType |       |       |
      | SingleItemDelete | Default | RAW                                             | DataType |       |       |
      | SingleItemDelete | Default | ROWID                                           | DataType |       |       |
      | SingleItemDelete | Default | UROWID                                          | DataType |       |       |
      | SingleItemDelete | Default | BFILE                                           | DataType |       |       |
      | SingleItemDelete | Default | NCHAR                                           | DataType |       |       |
      | SingleItemDelete | Default | NVARCHAR2                                       | DataType |       |       |
      | SingleItemDelete | Default | BINARY_FLOAT                                    | DataType |       |       |
      | SingleItemDelete | Default | BINARY_DOUBLE                                   | DataType |       |       |
      | SingleItemDelete | Default | LONG                                            | DataType |       |       |
      | SingleItemDelete | Default | DATE                                            | DataType |       |       |
      | SingleItemDelete | Default | TIMESTAMP                                       | DataType |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

   ########################################################## Delete Configurations ################################################################################

  @jdbc
  Scenario Outline:SC#16_Delete Plugin Configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                       | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | tags/Default/structures/ORACLE_CDB_PII                    |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDeleteEntryPoint                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAECreateEntryPoint                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleCollector                        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEFeed                                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDDLoader                            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBCataloger                      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBAnalyzer                       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBDataSource/OraclePDBDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEOracleDataSource/CAEOracleDS        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDataSource/CAEDataSource            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/CAEEntryPointCredentials             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/CAECredentials                       |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/OracleCredentials                    |      | 200           |                  |          |
