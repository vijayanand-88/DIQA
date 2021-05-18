@MLPQA-20499
Feature: Amazon Glue Lineage feature

  #Stories:  @MLP-16750 @MLP-17939 @MLP-19422 @MLP-20563 @MLP-20564 @MLP-20072 @MLP-20889 @MLP-21056 @MLP-21756 @MLP-21582 @MLP-22320 @MLP-27681

  ####################################################################################################################################
  ####################################################################################################################################
  # Below plugins are required to run this feature
  # RedshiftDB Bundle and Jdbc jar
  # PostgressDB Bundle and Jdbc jar
  # OracleDB Bundle and Jdbc jar
  # DynamoDB Bundle
  # SQLServerDB Bundle and Jdbc jar
  # Amazon S3 Bundle
  # CsvS3 Bundle
  # AvroS3 Bundle
  # JsonS3 Bundle
  # OrcS3 Bundle
  # ParquetS3 Bundle
  # AWS Glue Bundle
  # AWS Collector Bundle
  # Make sure that Redshift, Postgres RDS and SQLServer RDS is up and running in AWS as below
  # OracleRDS    -        SnapshotName:    oralce19-5mar  created on March 10, 2021.  Create with db instance name: oracle19 with   Port: 1521
  # PostgresRDS  -        SnapshotName:    postgresqldb   created on Aug 25, 2020.    Create with db instance name: postgres with   Port 5432
  # SQLServerRDS -        SnapshotName:    sqlserver-5mar created on March 10, 2021.  Create with db instance name: sqlserver with  Port 5432
  ####################################################################################################################################
  ####################################################################################################################################

  @jdbc @pre-condition
  Scenario: SC#1-Create required tables in Redshift DB, Poastgess DB, Oracle DB
    Given user connects to the database and performs the following operation
      | databaseConnection    | Operation    | queryPath     | queryPage          | queryField                         |
      | POSTGRES              | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | createSchemaPostgres               |
      | POSTGRES              | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | createTablePostgres212a            |
      | ORACLE12C             | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | createTableOracle212b              |
      | POSTGRES_RDS          | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | createSchemaPostgresRDS            |
      | POSTGRES_RDS          | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | createTablePostgresRDS             |
      | POSTGRES_RDS          | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | createRecordPostgresRDS            |
      | POSTGRES_RDS          | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | createTablePostgresRDS2            |
      | MSSQL_RDS             | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | createTableSqlserverRDS2           |
      | ORACLE19C_USEAST2_RDS | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | createTableOracleRDS               |


  @pre-condition
  Scenario:SC#1--Create required tables - dynamoDB table
    Given user connects to AWS Dynamo database and perform the following operation
      | action      | jsonPath                                                      |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createDynamoTable.json |
    And user connects to AWS Dynamo database and perform the following operation
      | action     | tableName     | jsonPath                                                       |
      | createItem | AllDataTypes3 | ida/amazonGlueLineagePayloads/TestData/createDynamoRecord.json |

  @cr-data @sanity @aws @pre-condition
  Scenario: SC#1-Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgqatestautomation4" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName           | keyPrefix      | dirPath                                              | recursive |
      | asgqatestautomation4 | SourceFiles    | ida/amazonGlueLineagePayloads/s3Files/SourceFiles    | true      |
      | asgqatestautomation4 | TargetFiles    | ida/amazonGlueLineagePayloads/s3Files/TargetFiles    | true      |
      | asgqatestautomation4 | Targetdata1A   | ida/amazonGlueLineagePayloads/s3Files/Targetdata1A   | true      |
      | asgqatestautomation4 | Targetdata1B   | ida/amazonGlueLineagePayloads/s3Files/Targetdata1B   | true      |
      | asgqatestautomation4 | Targetdata211  | ida/amazonGlueLineagePayloads/s3Files/Targetdata211  | true      |
      | asgqatestautomation4 | Targetdata213  | ida/amazonGlueLineagePayloads/s3Files/Targetdata213  | true      |
      | asgqatestautomation4 | Targetdata214  | ida/amazonGlueLineagePayloads/s3Files/Targetdata214  | true      |
      | asgqatestautomation4 | Targetdata311A | ida/amazonGlueLineagePayloads/s3Files/Targetdata311A | true      |
      | asgqatestautomation4 | Targetdata311B | ida/amazonGlueLineagePayloads/s3Files/Targetdata311B | true      |
      | asgqatestautomation4 | Targetdata312  | ida/amazonGlueLineagePayloads/s3Files/Targetdata312  | true      |
      | asgqatestautomation4 | Targetdata412  | ida/amazonGlueLineagePayloads/s3Files/Targetdata412  | true      |
      | asgqatestautomation4 | TestFiles      | ida/amazonGlueLineagePayloads/s3Files/TestFiles      | true      |
    And user performs following actions in amazon storage service
      | action        | bucketName              | AWSRegion |
      | Create bucket | asg-qa-glue-lineage-rds | US_EAST_2 |
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName              | keyPrefix | dirPath                                            | recursive | AWSRegion |
      | asg-qa-glue-lineage-rds | QA        | ida/amazonGlueLineagePayloads/s3Files_US_EAST_2/QA | true      | US_EAST_2 |

  @sanity @positive @pre-condition
  Scenario: SC#1-Create new Database in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                                   |
      | createDatabase | ida/amazonGlueLineagePayloads/TestData/createDatabase.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTable.json |

  @sanity @positive @pre-condition
  Scenario: SC#1-Create new Database in Glue DB using AWSGlueUtil - Target Table 1
    Given user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                                     |
      | createDatabase | ida/amazonGlueLineagePayloads/TestData/createDatabaseT1.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                  |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableT1.json |

  @sanity @positive @pre-condition
  Scenario: SC#1-Create new Database in Glue DB using AWSGlueUtil - Target Table 12
    Given user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                                      |
      | createDatabase | ida/amazonGlueLineagePayloads/TestData/createDatabaseT12.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                   |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableT12.json |


  @sanity @positive @pre-condition
  Scenario: SC#1-Create new Database in Glue DB using AWSGlueUtil T2 - Target Table 2
    Given user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                                     |
      | createDatabase | ida/amazonGlueLineagePayloads/TestData/createDatabaseT2.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                  |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableT2.json |

  @sanity @positive @pre-condition
  Scenario: SC#1-Create new Database in Glue DB using AWSGlueUtil - SourceDB511
    Given user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                                      |
      | createDatabase | ida/amazonGlueLineagePayloads/TestData/createDatabase511.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                           |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableBrandsTable.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                           |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableFruitsTable.json |

  @sanity @positive @pre-condition
  Scenario: SC#1-Create new Database in Glue DB using AWSGlueUtil - SourceDB511a
    Given user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                                       |
      | createDatabase | ida/amazonGlueLineagePayloads/TestData/createDatabase511a.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                            |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableCompanyTable.json |

  @sanity @positive @pre-condition
  Scenario: SC#1-Create new Database in Glue DB using AWSGlueUtil - SourceDB512
    Given user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                                      |
      | createDatabase | ida/amazonGlueLineagePayloads/TestData/createDatabase512.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                            |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableTitanicTable.json |

  @sanity @positive @pre-condition
  Scenario: SC#1-Create new Database in Glue DB using AWSGlueUtil - SourceDB611
    Given user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                                      |
      | createDatabase | ida/amazonGlueLineagePayloads/TestData/createDatabase611.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                               |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableTitanic611Table.json |


  @sanity @positive @pre-condition
  Scenario: SC#1-Create new Database in Glue DB using AWSGlueUtil - AMSSurvey
    Given user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                                            |
      | createDatabase | ida/amazonGlueLineagePayloads/TestData/createDatabaseAMSSurvey.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                         |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableAMSSurvey.json |


  @sanity @positive @pre-condition
  Scenario: SC#1-Create new Database in Glue DB using AWSGlueUtil - Accounts (Postgres RDS) - US_EAST2
    Given user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                                           | AWSRegion |
      | createDatabase | ida/amazonGlueLineagePayloads/TestData/createDatabaseAccounts.json | US_EAST_2 |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                        | AWSRegion |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableAccounts.json | US_EAST_2 |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                            | AWSRegion |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableSQLServerAcc.json | US_EAST_2 |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                | AWSRegion |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableSQLServerAcc_bkp.json | US_EAST_2 |


  @sanity @positive @pre-condition
  Scenario: SC#1-Create new Database in Glue DB using AWSGlueUtil - Linker SourceDB
    Given user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                                                 |
      | createDatabase | ida/amazonGlueLineagePayloads/TestData/createDatabaseLinkerSourceDB.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                     |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableAids2.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                         |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableAvroFile2.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                               |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableCricketParquet2.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                   |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableAidsColumnArrayJson.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                       |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableOrcFile.json |
    And user connects to AWS Dynamo database and perform the following operation
      | action                     | tableName     | jsonPath                                                            | path       |
      | getTableARNAndUpdateToFile | AllDataTypes3 | ida/amazonGlueLineagePayloads/TestData/createTableAllDataTypes.json | $.location |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                            |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableAllDataTypes.json |

  @sanity @positive @IDA-10.3 @pre-condition
  Scenario: SC#1-Create new Database in Glue DB using AWSGlueUtil - Linker TargetDB
    Given user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                                                 |
      | createDatabase | ida/amazonGlueLineagePayloads/TestData/createDatabaseLinkerTargetDB.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                     |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableAids3.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableRedshiftTable951.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                               |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableAvroFile2Target.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                     |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableCricketParquet2Target.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                         |
      | createTable | ida/amazonGlueLineagePayloads/TestData/createTableAidsColumnArrayJsonTarget.json |


  @sanity @positive @IDA-10.3 @pre-condition
  Scenario: SC1-Create new Job in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                   |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob1.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                   |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob3.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob211.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob212.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob213.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob214.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob215.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob311.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob312.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob411.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob412.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob511.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob512.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob611.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob612.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob711.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob811.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob812.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob813.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob814.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob815.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob911.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob912.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob951.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob952.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob953.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     | AWSRegion |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob954.json | US_EAST_2 |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob955.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     | AWSRegion |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob956.json | US_EAST_2 |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                                     | AWSRegion |
      | createJob | ida/amazonGlueLineagePayloads/TestData/createTestJob957.json | US_EAST_2 |

  @sanity @positive @regression
  Scenario Outline: SC2-create Bussiness Application tag and run the plugin configuration with the new field for Local File Collector and Git collector
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/amazonGlueLineagePayloads/PluginConfiguration/PythonParser_BA.json | 200           |                  |          |


  @pre-condition
  Scenario Outline: SC2-Configure Credentials for Prerequisites: AWS Plugins, Redshift, Oracle, SQLServer and Postgres DB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                               | bodyFile                                                                             | path                      | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidGlueCredentials         | payloads/ida/amazonGlueLineagePayloads/credentials/amazonGlueLineageCredentials.json | $.GlueCredentials         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidGlueCredentials         |                                                                                      |                           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidRedshiftCredentials     | payloads/ida/amazonGlueLineagePayloads/credentials/amazonGlueLineageCredentials.json | $.RedshiftCredentials     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidRedshiftCredentials     |                                                                                      |                           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidSQLServerRDSCredentials | payloads/ida/amazonGlueLineagePayloads/credentials/amazonGlueLineageCredentials.json | $.SQLServerRDSCredentails | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidSQLServerRDSCredentials |                                                                                      |                           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidOracleDBCredentials1    | payloads/ida/amazonGlueLineagePayloads/credentials/amazonGlueLineageCredentials.json | $.oracleCredentials       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidOracleDBCredentials1    |                                                                                      |                           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidOracleDBCredentials2    | payloads/ida/amazonGlueLineagePayloads/credentials/amazonGlueLineageCredentials.json | $.oracleRDSCredentials    | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidOracleDBCredentials2    |                                                                                      |                           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidPostgresDBCredentials1  | payloads/ida/amazonGlueLineagePayloads/credentials/amazonGlueLineageCredentials.json | $.postgresCredentials     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidPostgresDBCredentials1  |                                                                                      |                           | 200           |                  |          |


  @positve @amazon @regression @positive @sanity @IDA-1.1.0
  Scenario Outline: SC2-Configure Datasources for Prerequisites: AWS Plugins, Redshift, Oracle, SQLServer and Postgres DB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                    | bodyFile                                                                                | path                           | response code | response message             | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonS3DataSource/AmazonS3DataSource1              | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.AmazonS3DataSource1          | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonS3DataSource/AmazonS3DataSource1              |                                                                                         |                                | 200           | AmazonS3DataSource1          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonS3DataSource/AmazonS3DataSource2              | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.AmazonS3DataSource2          | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonS3DataSource/AmazonS3DataSource2              |                                                                                         |                                | 200           | AmazonS3DataSource2          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftDataSource/AmazonRedshiftDataSource1  | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.AmazonRedshiftDataSource1    | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonRedshiftDataSource/AmazonRedshiftDataSource1  |                                                                                         |                                | 200           | AmazonRedshiftDataSource1    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PostgreSQLDBDataSource/PostgreSQLDBDataSource1      | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.postgreDBDataSource          | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PostgreSQLDBDataSource/PostgreSQLDBDataSource1      |                                                                                         |                                | 200           | PostgreSQLDBDataSource1      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PostgreSQLDBDataSource/PostgreSQLDBDataSource2      | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.postgreDBDataSource_rds      | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PostgreSQLDBDataSource/PostgreSQLDBDataSource2      |                                                                                         |                                | 200           | PostgreSQLDBDataSource2      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBDataSource/OracleDBDataSource1              | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.oracleDBDataSource           | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBDataSource/OracleDBDataSource1              |                                                                                         |                                | 200           | OracleDBDataSource1          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBDataSource/OracleDBDataSource2              | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.oracleDBRDSDataSource        | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBDataSource/OracleDBDataSource2              |                                                                                         |                                | 200           | OracleDBDataSource2          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CsvS3DataSource/CsvS3DataSource1                    | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.CSVDataSourceWithHeader      | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CsvS3DataSource/CsvS3DataSource1                    |                                                                                         |                                | 200           | CsvS3DataSource1             |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CsvS3DataSource/CsvS3DataSource2                    | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.CSVDataSourceWithoutHeader   | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CsvS3DataSource/CsvS3DataSource2                    |                                                                                         |                                | 200           | CsvS3DataSource2             |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CsvS3DataSource/CsvS3DataSource3                    | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.CSVDataSource_useast2        | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CsvS3DataSource/CsvS3DataSource3                    |                                                                                         |                                | 200           | CsvS3DataSource3             |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JsonS3DataSource/JsonS3DataSource1                  | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.JSONDataSource               | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JsonS3DataSource/JsonS3DataSource1                  |                                                                                         |                                | 200           | JsonS3DataSource1            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AvroS3DataSource/AvroS3DataSource1                  | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.AvroDataSource               | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AvroS3DataSource/AvroS3DataSource1                  |                                                                                         |                                | 200           | AvroS3DataSource1            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OrcS3DataSource/OrcS3DataSource1                    | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.OrcDataSource                | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OrcS3DataSource/OrcS3DataSource1                    |                                                                                         |                                | 200           | OrcS3DataSource1             |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/ParquetS3DataSource/ParquetS3DataSource1            | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.ParquetDataSource            | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/ParquetS3DataSource/ParquetS3DataSource1            |                                                                                         |                                | 200           | ParquetS3DataSource1         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/DynamoDBDataSource/DynamoDBDataSource1              | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.DynamoDBDataSource           | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/DynamoDBDataSource/DynamoDBDataSource1              |                                                                                         |                                | 200           | DynamoDBDataSource1          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SQLServerDBDataSource/SQLServerDBDataSource1        | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.SQLServerRDSDataSource       | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/SQLServerDBDataSource/SQLServerDBDataSource1        |                                                                                         |                                | 200           | SQLServerDBDataSource1       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AWSGlueDataSource/AWSGlueValidDataSource1           | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.AWSGlueValidDataSource1      | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AWSGlueDataSource/AWSGlueValidDataSource1           |                                                                                         |                                | 200           | AWSGlueValidDataSource1      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AWSGlueDataSource/AWSGlueValidDataSource2           | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.AWSGlueValidDataSource2      | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AWSGlueDataSource/AWSGlueValidDataSource2           |                                                                                         |                                | 200           | AWSGlueValidDataSource2      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AWSCollectorDataSource/AWSCollectorValidDataSource1 | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.AWSCollectorValidDataSource1 | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AWSCollectorDataSource/AWSCollectorValidDataSource1 |                                                                                         |                                | 200           | AWSCollectorValidDataSource1 |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AWSCollectorDataSource/AWSCollectorValidDataSource2 | payloads/ida/amazonGlueLineagePayloads/DataSource/AmazonS3FileExtensionsDataSource.json | $.AWSCollectorValidDataSource2 | 204           |                              |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AWSCollectorDataSource/AWSCollectorValidDataSource2 |                                                                                         |                                | 200           | AWSCollectorValidDataSource2 |          |

  @sanity @positive @regression
  Scenario Outline: SC#3-Configure and run the Prerequsite Plugins: AWS Plugins, Redshift, Oracle, SQLServer and Postgres DB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | bodyFile                                                                                        | path                        | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger/AmazonS3Cataloger1                                          | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.AmazonS3Cataloger1        | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger/AmazonS3Cataloger1                                          |                                                                                                 |                             | 200           | AmazonS3Cataloger1       |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger1             |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='AmazonS3Cataloger1')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger1              |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger1             |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='AmazonS3Cataloger1')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger/AmazonS3Cataloger2                                          | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.AmazonS3Cataloger2        | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger/AmazonS3Cataloger2                                          |                                                                                                 |                             | 200           | AmazonS3Cataloger2       |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger2             |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='AmazonS3Cataloger2')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger2              |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger2             |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='AmazonS3Cataloger2')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger/AmazonRedshiftCataloger1                              | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.AmazonRedshiftCataloger1  | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger/AmazonRedshiftCataloger1                              |                                                                                                 |                             | 200           | AmazonRedshiftCataloger1 |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCataloger1 |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='AmazonRedshiftCataloger1')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCataloger1  |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCataloger1 |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='AmazonRedshiftCataloger1')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreSQLDBCataloger1                                  | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.postgreDBCataloger        | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreSQLDBCataloger1                                  |                                                                                                 |                             | 200           | PostgreSQLDBCataloger1   |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreSQLDBCataloger1     |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='PostgreSQLDBCataloger1')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreSQLDBCataloger1      |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreSQLDBCataloger1     |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='PostgreSQLDBCataloger1')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/PostgreSQLDBCataloger/PostgreSQLDBCataloger2                                  | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.postgreDBCataloger_rds    | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/PostgreSQLDBCataloger/PostgreSQLDBCataloger2                                  |                                                                                                 |                             | 200           | PostgreSQLDBCataloger2   |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreSQLDBCataloger2     |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='PostgreSQLDBCataloger2')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreSQLDBCataloger2      |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreSQLDBCataloger2     |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='PostgreSQLDBCataloger2')].status   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger1                                          | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.oracleDBCataloger         | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger1                                          |                                                                                                 |                             | 200           | OracleDBCataloger1       |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger1             |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='OracleDBCataloger1')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger1              |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger1             |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='OracleDBCataloger1')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger2                                          | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.oracleDBCataloger_rds     | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger2                                          |                                                                                                 |                             | 200           | OracleDBCataloger2       |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger2             |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='OracleDBCataloger2')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger2              |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger2             |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='OracleDBCataloger2')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger/CsvS3Cataloger1                                                | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.CsvCatalogerWithHeader    | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger/CsvS3Cataloger1                                                |                                                                                                 |                             | 200           | CsvS3Cataloger1          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger1                   |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='CsvS3Cataloger1')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger1                    |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger1                   |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='CsvS3Cataloger1')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger/CsvS3Cataloger2                                                | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.CsvCatalogerWithoutHeader | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger/CsvS3Cataloger2                                                |                                                                                                 |                             | 200           | CsvS3Cataloger2          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger2                   |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='CsvS3Cataloger2')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger2                    |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger2                   |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='CsvS3Cataloger2')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger/CsvS3Cataloger3                                                | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.CsvCatalogerUSEast2       | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger/CsvS3Cataloger3                                                |                                                                                                 |                             | 200           | CsvS3Cataloger3          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger3                   |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='CsvS3Cataloger3')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger3                    |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CsvS3Cataloger3                   |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='CsvS3Cataloger3')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger1                                              | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.JsonCataloger             | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger1                                              |                                                                                                 |                             | 200           | JsonS3Cataloger1         |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger1                 |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='JsonS3Cataloger1')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger1                  |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JsonS3Cataloger1                 |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='JsonS3Cataloger1')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger/AvroS3Cataloger1                                              | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.AvroCataloger             | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger/AvroS3Cataloger1                                              |                                                                                                 |                             | 200           | AvroS3Cataloger1         |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger1                 |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='AvroS3Cataloger1')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger1                  |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3Cataloger1                 |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='AvroS3Cataloger1')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger1                                                | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.OrcCataloger              | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger1                                                |                                                                                                 |                             | 200           | OrcS3Cataloger1          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger1                   |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='OrcS3Cataloger1')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger1                    |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger1                   |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='OrcS3Cataloger1')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger/ParquetS3Cataloger1                                        | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.ParquetCataloger          | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger/ParquetS3Cataloger1                                        |                                                                                                 |                             | 200           | ParquetS3Cataloger1      |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger1           |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='ParquetS3Cataloger1')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger1            |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/ParquetS3Cataloger1           |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='ParquetS3Cataloger1')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DynamoDBCataloger/DynamoDBCataloger1                                          | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.DynamoDBCataloger         | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DynamoDBCataloger/DynamoDBCataloger1                                          |                                                                                                 |                             | 200           | DynamoDBCataloger1       |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/DynamoDBCataloger1             |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='DynamoDBCataloger1')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/DynamoDBCataloger1              |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/DynamoDBCataloger1             |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='DynamoDBCataloger1')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger/SQLServerDBCataloger1                                    | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.SQLServerRDSCataloger     | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger/SQLServerDBCataloger1                                    |                                                                                                 |                             | 200           | SQLServerDBCataloger1    |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SQLServerDBCataloger1       |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='SQLServerDBCataloger1')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SQLServerDBCataloger1        |                                                                                                 |                             | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SQLServerDBCataloger1       |                                                                                                 |                             | 200           | IDLE                     | $.[?(@.configurationName=='SQLServerDBCataloger1')].status    |

  @sanity @positive @regression
  Scenario Outline: SC#3-Configure and run the the Prerequsite Plugins: AWSGlueCatalgoer and AWSCollector
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | bodyFile                                                                                        | path                | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger/AWSGlueCataloger1                              | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.AWSGlueCataloger1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AWSGlueCataloger/AWSGlueCataloger1                              |                                                                                                 |                     | 200           | AWSGlueCataloger1 |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/AWSGlueCataloger1 |                                                                                                 |                     | 200           | IDLE              | $.[?(@.configurationName=='AWSGlueCataloger1')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/AWSGlueCataloger1  |                                                                                                 |                     | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/AWSGlueCataloger1 |                                                                                                 |                     | 200           | IDLE              | $.[?(@.configurationName=='AWSGlueCataloger1')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger/AWSGlueCataloger2                              | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.AWSGlueCataloger2 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AWSGlueCataloger/AWSGlueCataloger2                              |                                                                                                 |                     | 200           | AWSGlueCataloger2 |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/AWSGlueCataloger2 |                                                                                                 |                     | 200           | IDLE              | $.[?(@.configurationName=='AWSGlueCataloger2')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/AWSGlueCataloger2  |                                                                                                 |                     | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/AWSGlueCataloger2 |                                                                                                 |                     | 200           | IDLE              | $.[?(@.configurationName=='AWSGlueCataloger2')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSCollector/AWSCollector1                                      | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.AWSCollector1     | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AWSCollector/AWSCollector1                                      |                                                                                                 |                     | 200           | AWSCollector1     |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/AWSCollector1         |                                                                                                 |                     | 200           | IDLE              | $.[?(@.configurationName=='AWSCollector1')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/AWSCollector/AWSCollector1          |                                                                                                 |                     | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/AWSCollector1         |                                                                                                 |                     | 200           | IDLE              | $.[?(@.configurationName=='AWSCollector1')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSCollector/AWSCollector2                                      | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.AWSCollector2     | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AWSCollector/AWSCollector2                                      |                                                                                                 |                     | 200           | AWSCollector2     |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/AWSCollector2         |                                                                                                 |                     | 200           | IDLE              | $.[?(@.configurationName=='AWSCollector2')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/AWSCollector/AWSCollector2          |                                                                                                 |                     | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/AWSCollector2         |                                                                                                 |                     | 200           | IDLE              | $.[?(@.configurationName=='AWSCollector2')].status     |

  Scenario Outline: SC#3-Configure and run the AWS Glue Python Parser Dry Run
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                   | bodyFile                                                                                        | path                        | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGluePythonParser/AWSGluePythonParser2                           | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.AWSGluePythonParserDryRun | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AWSGluePythonParser/AWSGluePythonParser2                           |                                                                                                 |                             | 200           | AWSGluePythonParser2 |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/AWSGluePythonParser/AWSGluePythonParser2 |                                                                                                 |                             | 200           | IDLE                 | $.[?(@.configurationName=='AWSGluePythonParser2')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/AWSGluePythonParser/AWSGluePythonParser2  |                                                                                                 |                             | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/AWSGluePythonParser/AWSGluePythonParser2 |                                                                                                 |                             | 200           | IDLE                 | $.[?(@.configurationName=='AWSGluePythonParser2')].status |


  @sanity @positive @webtest
  Scenario: SC3-Verify Dry run for Amazon Glue Lineage plugin
    Then Analysis log "parser/AWSGluePythonParser/AWSGluePythonParser2/%" should display below info/error/warning
      | type | logValue                                                          | logCode       | pluginName | removableText |
      | INFO | Plugin started                                                    | ANALYSIS-0019 |            |               |
      | INFO | ANALYSIS-0069: Plugin AWSGluePythonParser running on dry run mode | ANALYSIS-0069 |            |               |
      | INFO | items on dry run mode and not written to the repository           |               |            |               |


  @sanity @positive @regression
  Scenario Outline: SC4-Configure and run Glue Python Parser and AWS Glue Python Spark Lineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                | bodyFile                                                                                        | path                         | response code | response message           | jsonPath                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGluePythonParser/AWSGluePythonParser1                                        | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.AWSGluePythonParser1       | 204           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AWSGluePythonParser/AWSGluePythonParser1                                        |                                                                                                 |                              | 200           | AWSGluePythonParser1       |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/AWSGluePythonParser/AWSGluePythonParser1              |                                                                                                 |                              | 200           | IDLE                       | $.[?(@.configurationName=='AWSGluePythonParser1')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/AWSGluePythonParser/AWSGluePythonParser1               |                                                                                                 |                              | 200           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/AWSGluePythonParser/AWSGluePythonParser1              |                                                                                                 |                              | 200           | IDLE                       | $.[?(@.configurationName=='AWSGluePythonParser1')].status       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGluePythonSparkLineage/AWSGluePythonSparkLineage1                            | payloads/ida/amazonGlueLineagePayloads/PluginConfiguration/AmazonS3FileExtensionsCataloger.json | $.AWSGluePythonSparkLineage1 | 204           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AWSGluePythonSparkLineage/AWSGluePythonSparkLineage1                            |                                                                                                 |                              | 200           | AWSGluePythonSparkLineage1 |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/AWSGluePythonSparkLineage/AWSGluePythonSparkLineage1 |                                                                                                 |                              | 200           | IDLE                       | $.[?(@.configurationName=='AWSGluePythonSparkLineage1')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/AWSGluePythonSparkLineage/AWSGluePythonSparkLineage1  |                                                                                                 |                              | 200           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/AWSGluePythonSparkLineage/AWSGluePythonSparkLineage1 |                                                                                                 |                              | 200           | IDLE                       | $.[?(@.configurationName=='AWSGluePythonSparkLineage1')].status |

  @webtest @sanity @positive
  Scenario: SC4-Verify Lineage Hops in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "QATest212" and clicks on search
    And user performs "facet selection" in "Function" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "processMain" item from search results
    Then user performs click and verify in new window
      | Table        | value                                             | Action                       | RetainPrevwindow | indexSwitch | filePath                                                           | jsonPath      |
      | Lineage Hops | ds0.age => rc1.age                                | click and verify lineagehops | Yes              | 0           | ida/amazonGlueLineagePayloads/LineageMetadata/lineageMetadata.json | $.QATest212_1 |
      | Lineage Hops | ds0.fare => rc1.fare                              | click and verify lineagehops | Yes              | 0           | ida/amazonGlueLineagePayloads/LineageMetadata/lineageMetadata.json | $.QATest212_2 |
      | Lineage Hops | ds0.passengerid => rc1.passengerid                | click and verify lineagehops | Yes              | 0           | ida/amazonGlueLineagePayloads/LineageMetadata/lineageMetadata.json | $.QATest212_3 |
      | Lineage Hops | ds0.ticket => rc1.ticket                          | click and verify lineagehops | Yes              | 0           | ida/amazonGlueLineagePayloads/LineageMetadata/lineageMetadata.json | $.QATest212_4 |
      | Lineage Hops | train_sm_s2adb_csv.age => ds0.age                 | click and verify lineagehops | Yes              | 0           | ida/amazonGlueLineagePayloads/LineageMetadata/lineageMetadata.json | $.QATest212_5 |
      | Lineage Hops | train_sm_s2adb_csv.fare => ds0.fare               | click and verify lineagehops | Yes              | 0           | ida/amazonGlueLineagePayloads/LineageMetadata/lineageMetadata.json | $.QATest212_6 |
      | Lineage Hops | train_sm_s2adb_csv.passengerid => ds0.passengerid | click and verify lineagehops | Yes              | 0           | ida/amazonGlueLineagePayloads/LineageMetadata/lineageMetadata.json | $.QATest212_7 |
      | Lineage Hops | train_sm_s2adb_csv.ticket => ds0.ticket           | click and verify lineagehops | Yes              | 0           | ida/amazonGlueLineagePayloads/LineageMetadata/lineageMetadata.json | $.QATest212_8 |

  #6941905# #6941908# #6941909# #6941912# #6941915# #6941891# #6941895# #6941899# #6983727# #6983728# #6996606# #6996607# #7063174# #7063192# #7063193# #7063194# #7063195# #7063196# #7063197# #7063198# #7063199# #7063200# #7063201# #7063202# #7063203# #7063204# #7063205# #7063206# #7063159# #7063160# #7063161# #7063162# #7063163# #7063164# #7063165# #7063208# #7069432# #7069433# #7076234# #7076235# #7076237# #7076238# #7076239# #7076240# #7194043# #7194046# #7194047#
  @sanity @positive
  Scenario Outline:SC5-user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type       | name                  | asg_scopeid | targetFile                                  | jsonpath      |
      | APPDBPOSTGRES | ClassID     | Default | Class      | QATest214             |             | response/Lineage/QATest214.json             |               |
      | APPDBPOSTGRES | FunctionID  | Default |            | processMain           |             | response/Lineage/QATest214.json             |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/QATest214.json             | $.functionID  |
      | APPDBPOSTGRES | ClassID     | Default | Class      | QATest1               |             | response/Lineage/QATest1.json               |               |
      | APPDBPOSTGRES | FunctionID  | Default |            | processMain           |             | response/Lineage/QATest1.json               |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/QATest1.json               | $.functionID  |
      | APPDBPOSTGRES | ClassID     | Default | Class      | QATest211             |             | response/Lineage/QATest211.json             |               |
      | APPDBPOSTGRES | FunctionID  | Default |            | processMain           |             | response/Lineage/QATest211.json             |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/QATest211.json             | $.functionID  |
      | APPDBPOSTGRES | ClassID     | Default | Class      | QATest213             |             | response/Lineage/QATest213.json             |               |
      | APPDBPOSTGRES | FunctionID  | Default |            | processMain           |             | response/Lineage/QATest213.json             |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/QATest213.json             | $.functionID  |
      | APPDBPOSTGRES | ClassID     | Default | Class      | QATest212             |             | response/Lineage/QATest212.json             |               |
      | APPDBPOSTGRES | FunctionID  | Default |            | processMain           |             | response/Lineage/QATest212.json             |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/QATest212.json             | $.functionID  |
      | APPDBPOSTGRES | ClassID     | Default | Class      | QATest3               |             | response/Lineage/QATest3.json               |               |
      | APPDBPOSTGRES | FunctionID  | Default |            | processMain           |             | response/Lineage/QATest3.json               |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/QATest3.json               | $.functionID  |
      | APPDBPOSTGRES | ClassID     | Default | Class      | QATest215             |             | response/Lineage/QATest215.json             |               |
      | APPDBPOSTGRES | FunctionID  | Default |            | processMain           |             | response/Lineage/QATest215.json             |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/QATest215.json             | $.functionID  |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage311Job |             | response/Lineage/AutoGlueLineage311Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage311Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage312Job |             | response/Lineage/AutoGlueLineage312Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage312Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage411Job |             | response/Lineage/AutoGlueLineage411Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage411Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage412Job |             | response/Lineage/AutoGlueLineage412Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage412Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage511Job |             | response/Lineage/AutoGlueLineage511Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage511Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage512Job |             | response/Lineage/AutoGlueLineage512Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage512Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage611Job |             | response/Lineage/AutoGlueLineage611Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage611Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage612Job |             | response/Lineage/AutoGlueLineage612Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage612Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage711Job |             | response/Lineage/AutoGlueLineage711Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage711Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage811Job |             | response/Lineage/AutoGlueLineage811Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage811Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage812Job |             | response/Lineage/AutoGlueLineage812Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage812Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage813Job |             | response/Lineage/AutoGlueLineage813Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage813Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage814Job |             | response/Lineage/AutoGlueLineage814Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage814Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage815Job |             | response/Lineage/AutoGlueLineage815Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage815Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage911Job |             | response/Lineage/AutoGlueLineage911Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage911Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage912Job |             | response/Lineage/AutoGlueLineage912Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage912Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage951Job |             | response/Lineage/AutoGlueLineage951Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage951Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage952Job |             | response/Lineage/AutoGlueLineage952Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage952Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage953Job |             | response/Lineage/AutoGlueLineage953Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage953Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage954Job |             | response/Lineage/AutoGlueLineage954Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage954Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage955Job |             | response/Lineage/AutoGlueLineage955Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage955Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage956Job |             | response/Lineage/AutoGlueLineage956Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage956Job.json | $.OperationID |
      | APPDBPOSTGRES | OperationID | Default | Operation  | AutoGlueLineage957Job |             | response/Lineage/AutoGlueLineage957Job.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                       |             | response/Lineage/AutoGlueLineage957Job.json | $.OperationID |


  #6941905# #6941908# #6941909# #6941912# #6941915# #6941891# #6941895# #6941899# #6983727# #6983728# #6996606# #6996607# #7063174# #7063192# #7063193# #7063194# #7063195# #7063196# #7063197# #7063198# #7063199# #7063200# #7063201# #7063202# #7063203# #7063204# #7063205# #7063206# #7063159# #7063160# #7063161# #7063162# #7063163# #7063164# #7063165# #7063208# #7069432# #7069433# #7076234# #7076235# #7076237# #7076238# #7076239# #7076240# #7194043# #7194046# #7194047#
  Scenario Outline: SC5-user retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                  | inputFile                                   | outputFile                                |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | QATest214             | response/Lineage/QATest214.json             | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | QATest1               | response/Lineage/QATest1.json               | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | QATest213             | response/Lineage/QATest213.json             | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | QATest212             | response/Lineage/QATest212.json             | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | QATest211             | response/Lineage/QATest211.json             | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | QATest3               | response/Lineage/QATest3.json               | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | QATest215             | response/Lineage/QATest215.json             | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage311Job | response/Lineage/AutoGlueLineage311Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage312Job | response/Lineage/AutoGlueLineage312Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage411Job | response/Lineage/AutoGlueLineage411Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage412Job | response/Lineage/AutoGlueLineage412Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage511Job | response/Lineage/AutoGlueLineage511Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage512Job | response/Lineage/AutoGlueLineage512Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage611Job | response/Lineage/AutoGlueLineage611Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage612Job | response/Lineage/AutoGlueLineage612Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage711Job | response/Lineage/AutoGlueLineage711Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage811Job | response/Lineage/AutoGlueLineage811Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage812Job | response/Lineage/AutoGlueLineage812Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage813Job | response/Lineage/AutoGlueLineage813Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage814Job | response/Lineage/AutoGlueLineage814Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage815Job | response/Lineage/AutoGlueLineage815Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage911Job | response/Lineage/AutoGlueLineage911Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage912Job | response/Lineage/AutoGlueLineage912Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage951Job | response/Lineage/AutoGlueLineage951Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage952Job | response/Lineage/AutoGlueLineage952Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage953Job | response/Lineage/AutoGlueLineage953Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage954Job | response/Lineage/AutoGlueLineage954Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage955Job | response/Lineage/AutoGlueLineage955Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage956Job | response/Lineage/AutoGlueLineage956Job.json | response/Lineage/LineageSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | AutoGlueLineage957Job | response/Lineage/AutoGlueLineage957Job.json | response/Lineage/LineageSourceTarget.json |

  #6941905# #6941908# #6941909# #6941912# #6941915# #6941891# #6941895# #6941899# #6983727# #6983728# #6996606# #6996607# #7063174# #7063192# #7063193# #7063194# #7063195# #7063196# #7063197# #7063198# #7063199# #7063200# #7063201# #7063202# #7063203# #7063204# #7063205# #7063206# #7063159# #7063160# #7063161# #7063162# #7063163# #7063164# #7063165# #7063208# #7069432# #7069433# #7076234# #7076235# #7076237# #7076238# #7076239# #7076240# #7194043# #7194046# #7194047#
  @MLPQA-20377 @TEST_MLPQA-20498 @TEST_MLPQA-20497  @TEST_MLPQA-20496 @TEST_MLPQA-17266 @7063160 @TEST_MLPQA-17253 @7069432 @TEST_MLPQA-9523 @6941891 @TEST_MLPQA-9522 @6941895 @TEST_MLPQA-9521 @6941899 @TEST_MLPQA-9520 @6941905 @TEST_MLPQA-9519 @691908 @TEST_MLPQA-9518 @6941909 	@TEST_MLPQA-9517 @6941912 @TEST_MLPQA-9516 @6941915 	@TEST_MLPQA-9144 @6983727 @TEST_MLPQA-9143 @6983728 @TEST_MLPQA-9109 @6996606 @TEST_MLPQA-9108 @6996607 @TEST_MLPQA-8650 @7063159 	@TEST_MLPQA-8649  @7063161 @TEST_MLPQA-8648 @7063162 @TEST_MLPQA-8647  @7063163 @TEST_MLPQA-8646  @7063164 @TEST_MLPQA-8645  @7063165 @TEST_MLPQA-8643 @7063174 @TEST_MLPQA-8642  @7063192 @TEST_MLPQA-8641 @7063193 @TEST_MLPQA-8640 @7063194 @TEST_MLPQA-8639 @7063195 @TEST_MLPQA-8638  @7063196 @TEST_MLPQA-8637  @7063197 @TEST_MLPQA-8636 @7063198 @TEST_MLPQA-8635  @7063199 @TEST_MLPQA-8634  @7063200 @TEST_MLPQA-8633 @7063201 @TEST_MLPQA-8632 @7063202 @TEST_MLPQA-8631 @7063203 @TEST_MLPQA-8630 @7063204 @TEST_MLPQA-8629 @7063205 @TEST_MLPQA-8628 @7063206 @TEST_MLPQA-8627 @7063208 @TEST_MLPQA-8510 @7069433 @TEST_MLPQA-8469 @7076234 @TEST_MLPQA-8468 @7076235 @TEST_MLPQA-8466 @7076237 @TEST_MLPQA-8465 @7076238 @TEST_MLPQA-8464 @7076239 @TEST_MLPQA-8463 @7076240 @TEST_MLPQA-4457  @7194043 @TEST_MLPQA-4456  @7194046 @TEST_MLPQA-4455  @7194047
  Scenario Outline: SC5 - Verify Glue Lineage is generated where Target is actual table in Oracle RDS, Postgre RDS, SQLServerRDS
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                              | actual_json                                                 | item                  |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | QATest1               |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | QATest211             |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | QATest215             |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | QATest214             |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | QATest213             |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | QATest212             |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | QATest3               |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage311Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage312Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage411Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage412Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage511Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage512Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage611Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage612Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage711Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage811Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage812Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage813Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage814Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage815Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage911Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage912Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage951Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage952Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage953Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage954Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage955Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage956Job |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLineageMetadata.json | Constant.REST_DIR/response/Lineage/LineageSourceTarget.json | AutoGlueLineage957Job |

  #7076234# #7076235# #7076237# #7076238# #7076239# #7076240# #7194043# #7194046# #7194047#
  Scenario: SC6-User retrieves Lineage data for Lineage hops E2E Validation
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                               | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | aids2                              |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | aids3                              |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | world_atn_gluetable951             |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | alldatatypes3                      |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | cricketparquet2                    |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | avrofile2                          |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | aidscolumnarrayjson                |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | cricketparquet2target              |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | avrofile2target                    |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | aidscolumnarrayjsontarget          |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | dvdrental_accounts_rds             |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | orcfile                            |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | adventureworks_acc_useraccount     |             | response/Lineage/bulkLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | adventureworks_acc_useraccount_bkp |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                                                                                                                              | bodyFile                          | path                                                 | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&what=id,type,name,catalog&lineageDepth=0&exclude=UNDEFINED&exclude=CONTROL&exclude=COPY&exclude=TRANSFORM&exclude=MULTIHOP&exclude=STITCH&excludeUnusedViewColumns=true | response\Lineage\bulkLineage.json | $.lineagePayLoads.aids2                              | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&what=id,type,name,catalog&lineageDepth=0&exclude=UNDEFINED&exclude=CONTROL&exclude=COPY&exclude=TRANSFORM&exclude=MULTIHOP&exclude=STITCH&excludeUnusedViewColumns=true | response\Lineage\bulkLineage.json | $.lineagePayLoads.aids3                              | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&what=id,type,name,catalog&lineageDepth=0&exclude=UNDEFINED&exclude=CONTROL&exclude=COPY&exclude=TRANSFORM&exclude=MULTIHOP&exclude=STITCH&excludeUnusedViewColumns=true | response\Lineage\bulkLineage.json | $.lineagePayLoads.world_atn_gluetable951             | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&what=id,type,name,catalog&lineageDepth=0&exclude=UNDEFINED&exclude=CONTROL&exclude=COPY&exclude=TRANSFORM&exclude=MULTIHOP&exclude=STITCH&excludeUnusedViewColumns=true | response\Lineage\bulkLineage.json | $.lineagePayLoads.alldatatypes3                      | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&what=id,type,name,catalog&lineageDepth=0&exclude=UNDEFINED&exclude=CONTROL&exclude=COPY&exclude=TRANSFORM&exclude=MULTIHOP&exclude=STITCH&excludeUnusedViewColumns=true | response\Lineage\bulkLineage.json | $.lineagePayLoads.cricketparquet2                    | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&what=id,type,name,catalog&lineageDepth=0&exclude=UNDEFINED&exclude=CONTROL&exclude=COPY&exclude=TRANSFORM&exclude=MULTIHOP&exclude=STITCH&excludeUnusedViewColumns=true | response\Lineage\bulkLineage.json | $.lineagePayLoads.avrofile2                          | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&what=id,type,name,catalog&lineageDepth=0&exclude=UNDEFINED&exclude=CONTROL&exclude=COPY&exclude=TRANSFORM&exclude=MULTIHOP&exclude=STITCH&excludeUnusedViewColumns=true | response\Lineage\bulkLineage.json | $.lineagePayLoads.aidscolumnarrayjson                | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&what=id,type,name,catalog&lineageDepth=0&exclude=UNDEFINED&exclude=CONTROL&exclude=COPY&exclude=TRANSFORM&exclude=MULTIHOP&exclude=STITCH&excludeUnusedViewColumns=true | response\Lineage\bulkLineage.json | $.lineagePayLoads.cricketparquet2target              | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&what=id,type,name,catalog&lineageDepth=0&exclude=UNDEFINED&exclude=CONTROL&exclude=COPY&exclude=TRANSFORM&exclude=MULTIHOP&exclude=STITCH&excludeUnusedViewColumns=true | response\Lineage\bulkLineage.json | $.lineagePayLoads.avrofile2target                    | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&what=id,type,name,catalog&lineageDepth=0&exclude=UNDEFINED&exclude=CONTROL&exclude=COPY&exclude=TRANSFORM&exclude=MULTIHOP&exclude=STITCH&excludeUnusedViewColumns=true | response\Lineage\bulkLineage.json | $.lineagePayLoads.aidscolumnarrayjsontarget          | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&what=id,type,name,catalog&lineageDepth=0&exclude=UNDEFINED&exclude=CONTROL&exclude=COPY&exclude=TRANSFORM&exclude=MULTIHOP&exclude=STITCH&excludeUnusedViewColumns=true | response\Lineage\bulkLineage.json | $.lineagePayLoads.dvdrental_accounts_rds             | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&what=id,type,name,catalog&lineageDepth=0&exclude=UNDEFINED&exclude=CONTROL&exclude=COPY&exclude=TRANSFORM&exclude=MULTIHOP&exclude=STITCH&excludeUnusedViewColumns=true | response\Lineage\bulkLineage.json | $.lineagePayLoads.orcfile                            | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&what=id,type,name,catalog&lineageDepth=0&exclude=UNDEFINED&exclude=CONTROL&exclude=COPY&exclude=TRANSFORM&exclude=MULTIHOP&exclude=STITCH&excludeUnusedViewColumns=true | response\Lineage\bulkLineage.json | $.lineagePayLoads.adventureworks_acc_useraccount     | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&what=id,type,name,catalog&lineageDepth=0&exclude=UNDEFINED&exclude=CONTROL&exclude=COPY&exclude=TRANSFORM&exclude=MULTIHOP&exclude=STITCH&excludeUnusedViewColumns=true | response\Lineage\bulkLineage.json | $.lineagePayLoads.adventureworks_acc_useraccount_bkp | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath                           |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | aids2                              |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | aids3                              |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | world_atn_gluetable951             |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | alldatatypes3                      |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | cricketparquet2                    |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | avrofile2                          |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | aidscolumnarrayjson                |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | cricketparquet2target              |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | avrofile2target                    |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | aidscolumnarrayjsontarget          |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | dvdrental_accounts_rds             |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | orcfile                            |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | adventureworks_acc_useraccount     |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | adventureworks_acc_useraccount_bkp |

  #7076234# #7076235# #7076237# #7076238# #7076239# #7076240# #7194043# #7194046# #7194047#
  Scenario Outline: SC6-Lineage Hops End to End Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                    | actual_json                                               | item                               |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLinkerLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | aids2                              |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLinkerLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | aids3                              |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLinkerLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | world_atn_gluetable951             |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLinkerLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | alldatatypes3                      |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLinkerLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | cricketparquet2                    |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLinkerLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | avrofile2                          |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLinkerLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | aidscolumnarrayjson                |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLinkerLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | cricketparquet2target              |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLinkerLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | avrofile2target                    |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLinkerLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | aidscolumnarrayjsontarget          |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLinkerLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | dvdrental_accounts_rds             |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLinkerLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | orcfile                            |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLinkerLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | adventureworks_acc_useraccount     |
      | ida/amazonGlueLineagePayloads/LineageMetadata/ExpectedLinkerLineageMetadata.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | adventureworks_acc_useraccount_bkp |

  @webtest @aws @regression @sanity
  Scenario: SC7-Verify Technology tag appears correctly in Glue Lineage items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AGL1_BA" and clicks on search
    And user performs "facet selection" in "AGL1_BA" attribute under "Business Application" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                   | fileName              | userTag               |
      | Default     | Class      | Metadata Type | Amazon Glue,Python,AGL1,AGL1_BA       | QATest214             | QATest214             |
      | Default     | Function   | Metadata Type | Amazon Glue,Spark,Python,AGL1,AGL1_BA | processMain           | processMain           |
      | Default     | SourceTree | Metadata Type | Amazon Glue,Python,AGL1,AGL1_BA,Spark | AutoGlueLineage214Job | AutoGlueLineage214Job |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag         | fileName              | userTag               |
      | Default     | Class      | Metadata Type | Programming | QATest214             | QATest214             |
      | Default     | Function   | Metadata Type | Programming | processMain           | processMain           |
      | Default     | SourceTree | Metadata Type | Programming | AutoGlueLineage214Job | AutoGlueLineage214Job |

  @webtest @aws @regression @sanity
  Scenario: SC8-Verify logging enhancements
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSGluePythonParser1" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on the items listed contains "AWSGluePythonParser1"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 101           |
      | Number of errors          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "parser/AWSGluePythonParser/AWSGluePythonParser1/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                        | logCode       | pluginName          | removableText  |
      | INFO | Plugin started                                                                                                                                                                  | ANALYSIS-0019 |                     |                |
      | INFO | Plugin Name:AWSGluePythonParser, Plugin Type:parser, Plugin Version:1.0.0.SNAPSHOT, Node Name:LocalNode, Host Name:3539d4abeb4e, Plugin Configuration name:AWSGluePythonParser1 | ANALYSIS-0071 | AWSGluePythonParser | Plugin Version |
      | INFO | PARSING-0001: Parsing file AutoGlueLineage1Job                                                                                                                                  | PARSING-0001  |                     |                |
      | INFO | PARSING-0002: File AutoGlueLineage1Job parsed with no errors                                                                                                                    | PARSING-0002  |                     |                |
      | INFO | ANALYSIS-0072: Plugin AWSGluePythonParser Start Time:2020-03-10 05:55:00.419, End Time:2020-03-10 05:55:02.011, Errors:0 Warnings:0                                             | ANALYSIS-0072 | AWSGluePythonParser |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.651)                                                                                                       | ANALYSIS-0020 |                     |                |

#  #7086498#
#  @sanity @positive @webtest @edibus @Bug-21481 @Bug-22299
#  Scenario:  SC15-Verify the Glue Parser and Glue Items are replicated in EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "AGL1" and clicks on search
#    And user performs "facet selection" in "Amazon Glue" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Column     |
#      | Table      |
#      | Database   |
#      | Class      |
#      | Operation  |
#      | SourceTree |
#      | Connection |
#      | Function   |
#      | Analysis   |
#      | Partition  |
#      | Routine    |
#      | Service    |
#      | Cluster    |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/AmazonGlueConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                   | body                                     | response code | response message | jsonPath                                              |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                             | idc/EdiBusPayloads/AmazonGlueConfig.json | 204           |                  |                                                       |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAmazonGlue |                                          | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAmazonGlue')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusAmazonGlue  |                                          | 200           |                  |                                                       |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAmazonGlue |                                          | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAmazonGlue')].status |
#    And user enters the search text "EDIBusAmazonGlue" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user "click" on "AnalysisItem" containing "EDIBusAmazonGlue"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "AGL1" and clicks on search
#    And user performs "facet selection" in "AGL1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Amazon Glue" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
##    And user gets the items search count
##    And user connects Rochade Server and "compare count" the items in EDI subject area
##      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
##      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_CLASS) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                            |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/ETL/Amazon Glue |
#      | $..selections.['type_s'][*]                   | Class                                 |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                 | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=AGL1&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "verify all EDI items presence in IDP" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_CLASS ) |
#    And user enters the search text "AGL1" and clicks on search
#    And user performs "facet selection" in "AGL1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Amazon Glue" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "SourceTree" attribute under "Type" facets in Item Search results page
##    And user gets the items search count
##    And user connects Rochade Server and "compare count" the items in EDI subject area
##      | databaseName | subjectArea | subjectAreaVersion | query                                                                          |
##      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_CLASS) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                            |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/ETL/Amazon Glue |
#      | $..selections.['type_s'][*]                   | SourceTree                            |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                 | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=AGL1&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
##    And user stores the values in list from response using jsonpath "$..name"
##    And user connects Rochade Server and "verify all EDI items presence in IDP" the items in EDI subject area
##      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
##      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_CLASS ) |
#    And user enters the search text "AGL1" and clicks on search
#    And user performs "facet selection" in "AGL1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Amazon Glue" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Function" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_METHOD) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                            |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/ETL/Amazon Glue |
#      | $..selections.['type_s'][*]                   | Function                              |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                 | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=AGL1&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_OOP_METHOD ) |

  @post-condition
  Scenario: PostCondtion: Delete the analysis items for plugins
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreSQLDBCataloger1/%         | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/PostgreSQLDBCataloger/PostgreSQLDBCataloger2/%         | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/SQLServerDBCataloger/SQLServerDBCataloger1/%           | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger1/%                 | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger2/%                 | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Cataloger1%                  | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Cataloger2%                  | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/AmazonRedshiftCataloger1%      | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger1%                        | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger2%                        | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/CsvS3Cataloger/CsvS3Cataloger3%                        | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AvroS3Cataloger/AvroS3Cataloger1%                      | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger1%                      | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger1/%                       | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/DynamoDBCataloger/DynamoDBCataloger1%                  | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger1%                | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/AWSGlueCataloger1%                    | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/AWSGlueCataloger2%                    | Analysis |       |       |
      | MultipleIDDelete | Default | collector/AWSCollector/AWSCollector1%                            | Analysis |       |       |
      | MultipleIDDelete | Default | collector/AWSCollector/AWSCollector2%                            | Analysis |       |       |
      | MultipleIDDelete | Default | parser/AWSGluePythonParser/AWSGluePythonParser1%                 | Analysis |       |       |
      | MultipleIDDelete | Default | parser/AWSGluePythonParser/AWSGluePythonParser2%                 | Analysis |       |       |
      | MultipleIDDelete | Default | lineage/AWSGluePythonSparkLineage/AWSGluePythonSparkLineage1%    | Analysis |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                                    | Cluster  |       |       |
      | MultipleIDDelete | Default | decheqaperf01v.asg.com                                           | Cluster  |       |       |
      | MultipleIDDelete | Default | postgres.cwwrrytwv1pt.us-east-2.rds.amazonaws.com                | Cluster  |       |       |
      | MultipleIDDelete | Default | DIDORACLE01V.DID.DEV.ASGINT.LOC                                  | Cluster  |       |       |
      | MultipleIDDelete | Default | sqlserver.cwwrrytwv1pt.us-east-2.rds.amazonaws.com               | Cluster  |       |       |
      | MultipleIDDelete | Default | oracle19.cwwrrytwv1pt.us-east-2.rds.amazonaws.com                | Cluster  |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1;                           | Cluster  |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-2;                           | Cluster  |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |


  @cr-data @sanity @positive
  Scenario Outline: PostConditions-Delete the Credentials, Data Sources and Cataloger, Collector, Parser, Lineage plugins Configurations
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                    | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleDBCataloger/OracleDBCataloger1                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleDBCataloger/OracleDBCataloger2                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CsvS3Cataloger/CsvS3Cataloger1                      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CsvS3Cataloger/CsvS3Cataloger2                      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CsvS3Cataloger/CsvS3Cataloger3                      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AvroS3Cataloger/AvroS3Cataloger1                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetS3Cataloger/ParquetS3Cataloger1              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/JsonS3Cataloger/JsonS3Cataloger1                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSGlueCataloger/AWSGlueCataloger1                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSCollector/AWSCollector1                          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSGlueCataloger/AWSGlueCataloger2                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSCollector/AWSCollector2                          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3Cataloger/AmazonS3Cataloger1                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3Cataloger/AmazonS3Cataloger2                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger1                      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonRedshiftCataloger/AmazonRedshiftCataloger1    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSGluePythonParser                                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSGluePythonSparkLineage                           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PostgreSQLDBCataloger/PostgreSQLDBCataloger1        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PostgreSQLDBCataloger/PostgreSQLDBCataloger2        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBCataloger/SQLServerDBCataloger1          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/DynamoDBCataloger/DynamoDBCataloger1                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3DataSource/AmazonS3DataSource1              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3DataSource/AmazonS3DataSource2              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CsvS3DataSource/CsvS3DataSource1                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CsvS3DataSource/CsvS3DataSource2                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CsvS3DataSource/CsvS3DataSource3                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AvroS3DataSource/AvroS3DataSource1                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ParquetS3DataSource/ParquetS3DataSource1            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/JsonS3DataSource/JsonS3DataSource1                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OrcS3DataSource/OrcS3DataSource1                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleDBDataSource/OracleDBDataSource1              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleDBDataSource/OracleDBDataSource2              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PostgreSQLDBDataSource/PostgreSQLDBDataSource1      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/PostgreSQLDBDataSource/PostgreSQLDBDataSource2      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonRedshiftDataSource/AmazonRedshiftDataSource1  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/DynamoDBDataSource/DynamoDBDataSource1              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/SQLServerDBDataSource/SQLServerDBDataSource1        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSGlueDataSource/AWSGlueValidDataSource1           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSCollectorDataSource/AWSCollectorValidDataSource1 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSGlueDataSource/AWSGlueValidDataSource2           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSCollectorDataSource/AWSCollectorValidDataSource2 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidGlueCredentials                              |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidRedshiftCredentials                          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidPostgresDBCredentials1                       |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidOracleDBCredentials1                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidOracleDBCredentials2                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidSQLServerRDSCredentials                      |      | 200           |                  |          |


  @post-condition
  Scenario:  Delete the AGL1_BA tag
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name    | type                | query | param |
      | MultipleIDDelete | Default | AGL1_BA | BusinessApplication |       |       |


  @regression @positive
  Scenario:  PostConditions-Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "SourceFiles" in bucket "asgqatestautomation4"
    And user "Delete" objects in amazon directory "Targetdata1A" in bucket "asgqatestautomation4"
    And user "Delete" objects in amazon directory "Targetdata1B" in bucket "asgqatestautomation4"
    And user "Delete" objects in amazon directory "Targetdata211" in bucket "asgqatestautomation4"
    And user "Delete" objects in amazon directory "Targetdata213" in bucket "asgqatestautomation4"
    And user "Delete" objects in amazon directory "Targetdata214" in bucket "asgqatestautomation4"
    And user "Delete" objects in amazon directory "Targetdata311A" in bucket "asgqatestautomation4"
    And user "Delete" objects in amazon directory "Targetdata311B" in bucket "asgqatestautomation4"
    And user "Delete" objects in amazon directory "Targetdata312" in bucket "asgqatestautomation4"
    And user "Delete" objects in amazon directory "Targetdata412" in bucket "asgqatestautomation4"
    And user "Delete" objects in amazon directory "TestFiles" in bucket "asgqatestautomation4"
    And user "Delete" objects in amazon directory "TargetFiles" in bucket "asgqatestautomation4"
    And user "Delete" a bucket "asgqatestautomation4" in amazon storage service
    And user performs following actions in amazon storage service
      | action         | directoryName | bucketName              | AWSRegion |
      | Delete objects | QA            | asg-qa-glue-lineage-rds | US_EAST_2 |
      | Delete bucket  |               | asg-qa-glue-lineage-rds | US_EAST_2 |

  @sanity @positive @IDA-10.3
  Scenario: PostConditions-Delete Job in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage411Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage412Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage311Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage312Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName             |
      | deleteJob | AutoGlueLineage1Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName             |
      | deleteJob | AutoGlueLineage3Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage211Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage212Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage213Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage214Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage215Job |
    Given user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage511Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage512Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage611Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage612Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage711Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage811Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage812Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage813Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage814Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage815Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage911Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage912Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage951Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage952Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage953Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               | AWSRegion |
      | deleteJob | AutoGlueLineage954Job | US_EAST_2 |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               |
      | deleteJob | AutoGlueLineage955Job |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               | AWSRegion |
      | deleteJob | AutoGlueLineage956Job | US_EAST_2 |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName               | AWSRegion |
      | deleteJob | AutoGlueLineage957Job | US_EAST_2 |

  @sanity @positive @IDA-10.3
  Scenario: PostConditions-Delete Database in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action         | databaseName      |
      | deleteDatabase | autoglues3lineage |
    And user connects to AWS Glue database and perform the following operation
      | action         | databaseName        |
      | deleteDatabase | autoglues3lineaget1 |
    And user connects to AWS Glue database and perform the following operation
      | action         | databaseName         |
      | deleteDatabase | autoglues3lineaget12 |
    And user connects to AWS Glue database and perform the following operation
      | action         | databaseName        |
      | deleteDatabase | autoglues3lineaget2 |
    And user connects to AWS Glue database and perform the following operation
      | action         | databaseName |
      | deleteDatabase | sourcedb511  |
    And user connects to AWS Glue database and perform the following operation
      | action         | databaseName |
      | deleteDatabase | sourcedb511a |
    And user connects to AWS Glue database and perform the following operation
      | action         | databaseName |
      | deleteDatabase | sourcedb512  |
    And user connects to AWS Glue database and perform the following operation
      | action         | databaseName |
      | deleteDatabase | sourcedb611  |
    And user connects to AWS Glue database and perform the following operation
      | action         | databaseName |
      | deleteDatabase | amssurveydb  |
    And user connects to AWS Glue database and perform the following operation
      | action         | databaseName   |
      | deleteDatabase | linkersourcedb |
    And user connects to AWS Glue database and perform the following operation
      | action         | databaseName   |
      | deleteDatabase | linkertargetdb |
    And user connects to AWS Glue database and perform the following operation
      | action         | databaseName | AWSRegion |
      | deleteDatabase | accounts_rds | US_EAST_2 |

  @jdbc
  Scenario: PostConditions-Delete tables in Redshift DB, Postgess DB, Oracle DB, DynamoDB
    Given user connects to the database and performs the following operation
      | databaseConnection    | Operation    | queryPath     | queryPage          | queryField                  |
      | POSTGRES              | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | dropSchemaPostgres          |
      | ORACLE12C             | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | dropTable212BOracle         |
      | ORACLE19C_USEAST2_RDS | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | dropTableOracleRDS          |
      | POSTGRES_RDS          | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | dropSchemaPostgresRDS       |
      | POSTGRES_RDS          | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | dropTablePostgresRDS2       |
      | MSSQL_RDS             | EXECUTEQUERY | json/IDA.json | GlueLineageQueries | dropTableSqlserverRDS2      |
    And user connects to AWS Dynamo database and perform the following operation
      | action      | jsonPath                                                      |
      | deleteTable | ida/amazonGlueLineagePayloads/TestData/deleteDynamoTable.json |