@MLP-24754 @MLP-24752 @MLP-24753
Feature: Validation of Java JDBC Lineage plugin functionality after running Git, Java parser and Java Lineage plugins (JavaJDBCLineageAll.feature)

  # Below bundles should be present for running this Feature
  # Git Bundle
  # DynamoDB Bundle
  # CassandraDB Bundle
  # MongoDB Bundle
  # PostgressDB Bundle
  # SnowflakeDB Bundle
  # Java Bundle
  Scenario:SC#1-Create a dynamoDB table QAEMP5D
    Given user connects to AWS Dynamo database and perform the following operation
      | action      | jsonPath                                                                |
      | createTable | ida/javaJDBCAllPayloads/TestData/DynamoDB/CreateDynamoTableQAEMP5D.json |
    And user connects to AWS Dynamo database and perform the following operation
      | action     | tableName | jsonPath                                                                 |
      | createItem | QAEMP5D   | ida/javaJDBCAllPayloads/TestData/DynamoDB/createDynamoRecordQAEMP5D.json |

  Scenario:SC#1-Create a dynamoDB QAEMPIDD
    Given user connects to AWS Dynamo database and perform the following operation
      | action      | jsonPath                                                                 |
      | createTable | ida/javaJDBCAllPayloads/TestData/DynamoDB/CreateDynamoTableQAEMPIDD.json |
    And user connects to AWS Dynamo database and perform the following operation
      | action     | tableName | jsonPath                                                                  |
      | createItem | QAEMPIDD  | ida/javaJDBCAllPayloads/TestData/DynamoDB/createDynamoRecordQAEMPIDD.json |

  Scenario:SC#1-Create a dynamoDB table QAEMPFILE3D
    Given user connects to AWS Dynamo database and perform the following operation
      | action      | jsonPath                                                                    |
      | createTable | ida/javaJDBCAllPayloads/TestData/DynamoDB/CreateDynamoTableQAEMPFILE3D.json |
    And user connects to AWS Dynamo database and perform the following operation
      | action     | tableName   | jsonPath                                                                     |
      | createItem | QAEMPFILE3D | ida/javaJDBCAllPayloads/TestData/DynamoDB/createDynamoRecordQAEMPFILE3D.json |

  Scenario:SC#1-Create a dynamoDB table QAEMPFILE5D
    Given user connects to AWS Dynamo database and perform the following operation
      | action      | jsonPath                                                                    |
      | createTable | ida/javaJDBCAllPayloads/TestData/DynamoDB/CreateDynamoTableQAEMPFILE5D.json |
    And user connects to AWS Dynamo database and perform the following operation
      | action     | tableName   | jsonPath                                                                     |
      | createItem | QAEMPFILE5D | ida/javaJDBCAllPayloads/TestData/DynamoDB/createDynamoRecordQAEMPFILE5D.json |

  @sanity @positive
  Scenario: SC#1 PreCondition_Cassandra db_Create KeySpace in Cassandra database
    Given user connect to the Cassandra DB database and execute query for the below parameters
      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage          | queryField         | keySpaceName |
      | CASSANDRA    | create    | createKeySpace | json/IDA.json | JavaJDBCQueriesAll | createKeySpaceJDBC | JDBCKeySpace |
    And user connect to the Cassandra DB database and execute query for the below parameters
      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage          | queryField               | tableName     |
      | CASSANDRA    | create    | createTable    | json/IDA.json | JavaJDBCQueriesAll | createTableQAEMPFILE2C   | QAEMPFILE2C   |
      | CASSANDRA    | create    | createTable    | json/IDA.json | JavaJDBCQueriesAll | createTableQAEMPLAMBDA1C | QAEMPLAMBDA1C |

  ################################################ Pre Conditions ##########################################################
  @jdbc
  Scenario: SC#1-Create Required tables for Postgre and Snowflake
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage          | queryField                      |
      | POSTGRES           | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | createSchemaPostgres            |
      | POSTGRES           | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | createTableQAEMPFILE4           |
      | POSTGRES           | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | createTableQAEMPFILE6           |
      | POSTGRES           | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | createTableQAEMP5               |
      | POSTGRES           | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | createTableQAEMPUPDATEPostgres  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | createSchemaSnowflake           |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | createTableQAEMP                |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | createTableQAEMPID              |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | createTableQAEMPLAMBDA2         |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | createTableqasmallsource        |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | createTableQAEMPUPDATESnowflake |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | createTableqasmalltarget        |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | createTableQAEMP4               |


  @precondition
  Scenario: SC#1-Update Git and Snowflake and Postgres credentials with exact values
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                | username                   | password                   |
      | ida/JavaJDBCAllPayloads/javaJDBCLineageCredentials.json | $.gitCredentials..userName | $.gitCredentials..password |
    And User update the below "Postgres Credentials" in following files using json path
      | filePath                                                | username                       | password                       |
      | ida/JavaJDBCAllPayloads/javaJDBCLineageCredentials.json | $.postgreCredentials..userName | $.postgreCredentials..password |
    And User update the below "snowflake credentials" in following files using json path
      | filePath                                                | username                         | password                         |
      | ida/JavaJDBCAllPayloads/javaJDBCLineageCredentials.json | $.snowflakeCredentials..userName | $.snowflakeCredentials..password |

  @sanity @positive @regression
  Scenario Outline: SC#1-Set the Credentials and Datasources for Git and Snowflake and Postgres
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                 | bodyFile                                                         | path                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGitCredentialsJJA                         | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageCredentials.json | $.gitCredentials                 | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidPostgreDBCredentialsJJA                   | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageCredentials.json | $.postgreCredentials             | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidSnowflakeDBCredentialsJJA                 | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageCredentials.json | $.snowflakeCredentials           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidMongoDBCredentialsJJA                     | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageCredentials.json | $.mongoCredentials               | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidCassandraDBCredentialsJJA                 | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageCredentials.json | $.cassandraCredentials           | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidAWSCredentialsJJA                         | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageCredentials.json | $.awsCredentials                 | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource                           | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageDataSources.json | $.gitCollectorDataSource_default | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PostgreSQLDBDataSource                           | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageDataSources.json | $.postgreDBDataSource_default    | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBDataSource                            | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageDataSources.json | $.snowflakeDBDataSource_default  | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CassandraDBDataSource                            | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageDataSources.json | $.cassandraDBDataSource_default  | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/DynamoDBDataSource                               | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageDataSources.json | $.dynamoDBDataSource_default     | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/MongoDBDataSource                                | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageDataSources.json | $.mongoDBDataSource_default      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJJA | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageDataSources.json | $.gitCollectorDataSource         | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PostgreSQLDBDataSource/PostgreSQLDBDataSourceJJA | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageDataSources.json | $.postgreDBDataSource            | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBDataSource/SnowflakeDBDataSourceJJA   | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageDataSources.json | $.snowflakeDBDataSource          | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CassandraDBDataSource/CassandraDBDataSourceJJA   | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageDataSources.json | $.cassandraDBDataSource          | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/DynamoDBDataSource/DynamoDBDataSourceJJA         | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageDataSources.json | $.dynamoDBDataSource             | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/MongoDBDataSource/MongoDBDataSourceJJA           | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineageDataSources.json | $.mongoDBDataSource              | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJJA |                                                                  |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PostgreSQLDBDataSource/PostgreSQLDBDataSourceJJA |                                                                  |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/SnowflakeDBDataSource/SnowflakeDBDataSourceJJA   |                                                                  |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CassandraDBDataSource/CassandraDBDataSourceJJA   |                                                                  |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/DynamoDBDataSource/DynamoDBDataSourceJJA         |                                                                  |                                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/MongoDBDataSource/MongoDBDataSourceJJA           |                                                                  |                                  | 200           |                  |          |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: SC#1-Create Business Application tag for Java JDBC Lineage test for Snowflake and Postgres Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                        | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/JavaJDBCAllPayloads/JavaJDBCAll_BA.json | 200           |                  |          |

  ############################################# PluginRun ##########################################################
  Scenario Outline: SC#2-Configure Catalogers for GitCollector,  Java and Snowflake and Postgres
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                               | bodyFile                                                          | path                       | response code | response message         | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/PostgreSQLDBCataloger/PostgreSQLDBCatalogerJJA | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineagePluginConifg.json | $.postgreDBCataloger       | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/PostgreSQLDBCataloger/PostgreSQLDBCatalogerJJA |                                                                   |                            | 200           | PostgreSQLDBCatalogerJJA |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCatalogerJJA   | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineagePluginConifg.json | $.snowflakeDBCataloger     | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCatalogerJJA   |                                                                   |                            | 200           | SnowflakeDBCatalogerJJA  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CassandraDBCataloger/CassandraDBCatalogerJJA   | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineagePluginConifg.json | $.cassandraDBCataloger     | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CassandraDBCataloger/CassandraDBCatalogerJJA   |                                                                   |                            | 200           | CassandraDBCatalogerJJA  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/DynamoDBCataloger/DynamoDBCatalogerJJA         | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineagePluginConifg.json | $.dynamoDBCataloger        | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/DynamoDBCataloger/DynamoDBCatalogerJJA         |                                                                   |                            | 200           | DynamoDBCatalogerJJA     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/MongoDBCataloger/MongoDBCatalogerJJA           | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineagePluginConifg.json | $.mongoDBCataloger         | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/MongoDBCataloger/MongoDBCatalogerJJA           |                                                                   |                            | 200           | MongoDBCatalogerJJA      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/GitCollector/GitCollectorJJA                   | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineagePluginConifg.json | $.GitCollector             | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/GitCollector/GitCollectorJJA                   |                                                                   |                            | 200           | GitCollectorJJA          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaParser/JavaParserJJA                       | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineagePluginConifg.json | $.JavaParser               | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaParser/JavaParserJJA                       |                                                                   |                            | 200           | JavaParserJJA            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaLinker/JavaLinkerJJA                       | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineagePluginConifg.json | $.JavaLinker               | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaLinker/JavaLinkerJJA                       |                                                                   |                            | 200           | JavaLinkerJJA            |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaIOLinker/JavaIOLinkerJJA                   | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineagePluginConifg.json | $.JavaIOLinker             | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaIOLinker/JavaIOLinkerJJA                   |                                                                   |                            | 200           | JavaIOLinkerJJA          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJADryRun       | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineagePluginConifg.json | $.JavaJDBCLineageDryRun    | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJADryRun       |                                                                   |                            | 200           | JavaJDBCLineageJJADryRun |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJA             | payloads/ida/JavaJDBCAllPayloads/javaJDBCLineagePluginConifg.json | $.JavaJDBCLineageActualRun | 204           |                          |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJA             |                                                                   |                            | 200           | JavaJDBCLineageJJA       |          |

  @MLP-24754 @sanity @positive @regression
  Scenario Outline: SC#2-Run the Plugin configurations for Snowflake and Postgres Cataloger, Git, Java Parser, Java Linker, JavaIOLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile | path | response code | response message | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJJA                   |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollectorJJA')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorJJA                    |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorJJA                   |          |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollectorJJA')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreSQLDBCatalogerJJA |          |      | 200           | IDLE             | $.[?(@.configurationName=='PostgreSQLDBCatalogerJJA')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreSQLDBCatalogerJJA  |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/PostgreSQLDBCataloger/PostgreSQLDBCatalogerJJA |          |      | 200           | IDLE             | $.[?(@.configurationName=='PostgreSQLDBCatalogerJJA')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCatalogerJJA   |          |      | 200           | IDLE             | $.[?(@.configurationName=='SnowflakeDBCatalogerJJA')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCatalogerJJA    |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeDBCatalogerJJA   |          |      | 200           | IDLE             | $.[?(@.configurationName=='SnowflakeDBCatalogerJJA')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/CassandraDBCatalogerJJA   |          |      | 200           | IDLE             | $.[?(@.configurationName=='CassandraDBCatalogerJJA')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/CassandraDBCatalogerJJA    |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/CassandraDBCatalogerJJA   |          |      | 200           | IDLE             | $.[?(@.configurationName=='CassandraDBCatalogerJJA')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/DynamoDBCatalogerJJA         |          |      | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBCatalogerJJA')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/DynamoDBCatalogerJJA          |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/DynamoDBCatalogerJJA         |          |      | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBCatalogerJJA')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/MongoDBCataloger/MongoDBCatalogerJJA           |          |      | 200           | IDLE             | $.[?(@.configurationName=='MongoDBCatalogerJJA')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/MongoDBCataloger/MongoDBCatalogerJJA            |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/MongoDBCataloger/MongoDBCatalogerJJA           |          |      | 200           | IDLE             | $.[?(@.configurationName=='MongoDBCatalogerJJA')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJJA                          |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaParserJJA')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/parser/JavaParser/JavaParserJJA                           |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/parser/JavaParser/JavaParserJJA                          |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaParserJJA')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaLinker/JavaLinkerJJA                          |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaLinkerJJA')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/JavaLinker/JavaLinkerJJA                           |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaLinker/JavaLinkerJJA                          |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaLinkerJJA')].status            |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaIOLinker/JavaIOLinkerJJA                      |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaIOLinkerJJA')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/JavaIOLinker/JavaIOLinkerJJA                       |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/JavaIOLinker/JavaIOLinkerJJA                      |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaIOLinkerJJA')].status          |

  ############################################# PluginRun - DryRunTrue ##########################################################
  @MLP-24754 @sanity @positive @regression
  Scenario Outline: SC#3-Configure and run the plugin config for JavaJDBCLineage with dryRun true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                    | bodyFile | path | response code | response message | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJADryRun |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaJDBCLineageJJADryRun')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJADryRun  |          |      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJADryRun |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaJDBCLineageJJADryRun')].status |

  #7153174#
  @webtest @MLP-24754 @sanity @positive @regression
  Scenario: SC#3:UI_Validation: Verify JavaJDBCLineage plugin functionality with dry run as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JavaJDBCLineageJJADryRun" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/JavaJDBCLineage/JavaJDBCLineageJJADryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 1             | Description |
    Then Analysis log "lineage/JavaJDBCLineage/JavaJDBCLineageJJADryRun%" should display below info/error/warning
      | type | logValue                                                                                    | logCode       | pluginName      | removableText |
      | INFO | Plugin JavaJDBCLineage running on dry run mode                                              | ANALYSIS-0069 | JavaJDBCLineage |               |
      | INFO | Plugin JavaJDBCLineage processed 16 items on dry run mode and not written to the repository | ANALYSIS-0070 | JavaJDBCLineage |               |

  ############################################# PluginRun - DryRun False ##########################################################
  @MLP-24754 @sanity @positive @regression
  Scenario Outline: SC#4-Configure and run the plugin config for JavaJDBCLineage with dryRun false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile | path | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJA |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaJDBCLineageJJA')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJA  |          |      | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/JavaJDBCLineage/JavaJDBCLineageJJA |          |      | 200           | IDLE             | $.[?(@.configurationName=='JavaJDBCLineageJJA')].status |


  ############################################# LoggingEnhancements #############################################
  #7153174#
  @sanity @positive @MLP-24754 @webtest
  Scenario: SC#4 Verify JavaJDBCLineage collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tag_JavaJDBCAll" and clicks on search
    And user performs "facet selection" in "tag_JavaJDBCAll" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/JavaJDBCLineage/JavaJDBCLineageJJA%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 16            | Description |
      | Number of errors          | 1             | Description |
    Then Analysis log "lineage/JavaJDBCLineage/JavaJDBCLineageJJA%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:JavaJDBCLineage, Plugin Type:lineage, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:23dce01a6877, Plugin Configuration name:JavaJDBCLineageJJA                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0071 | JavaJDBCLineage | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: ---  2020-08-31 15:51:15.885 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: name: "JavaJDBCLineageJJA"  2020-08-31 15:51:15.885 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: pluginVersion: "LATEST"  2020-08-31 15:51:15.885 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: label:  2020-08-31 15:51:15.885 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: : "JavaJDBCLineageJJA"  2020-08-31 15:51:15.885 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: catalogName: "Default"  2020-08-31 15:51:15.885 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: eventClass: null  2020-08-31 15:51:15.885 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: eventCondition: null  2020-08-31 15:51:15.885 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: nodeCondition: "name==\"LocalNode\""  2020-08-31 15:51:15.885 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: maxWorkSize: 100  2020-08-31 15:51:15.885 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: tags:  2020-08-31 15:51:15.885 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: - "tag_JavaJDBCAll"  2020-08-31 15:51:15.885 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: pluginType: "lineage"  2020-08-31 15:51:15.885 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: dataSource: null  2020-08-31 15:51:15.885 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: credential: null  2020-08-31 15:51:15.886 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: businessApplicationName: "test_BA_JavaJDBCAll"  2020-08-31 15:51:15.886 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: dryRun: false  2020-08-31 15:51:15.886 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: schedule: null  2020-08-31 15:51:15.886 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: filter: null  2020-08-31 15:51:15.886 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: pluginName: "JavaJDBCLineage"  2020-08-31 15:51:15.886 INFO  - ANALYSIS-0073: Plugin JavaJDBCLineage Configuration: type: "Lineage" | ANALYSIS-0073 | JavaJDBCLineage |                |
      | INFO | Plugin JavaJDBCLineage Start Time:2020-05-27 05:59:59.126, End Time:2020-05-27 06:00:25.097, Processed Count:16, Errors:1, Warnings:608                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0072 | JavaJDBCLineage |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0020 |                 |                |

  ####################### API Lineage verification #############################################
  #7153167# #7153168# #7153169# #7153170# #7153171# #7153172# #7153173# #7186333# #7186334# #7186336#
  @MLP-24754 @MLP-24752 @MLP-24753 @regression @positive
  Scenario Outline:SC#5:API Lineage ID retrieval: user connects to database and retrieves Lineage Hops Ids in order to find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive               | catalog | type       | name                                         | asg_scopeid | targetFile                                                            | jsonpath                |
      | APPDBPOSTGRES | ClassID               | Default | Class      | InsertSubQuery                               |             | response/java/javaJDBCLineage/all/Lineage/InsertSubQuery_1.json       |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/InsertSubQuery_1.json       |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMP, QAEMPID]           |             | response/java/javaJDBCLineage/all/Lineage/InsertSubQuery_1.json       | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/InsertSubQuery_1.json       | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | InsertSubQuery                               |             | response/java/javaJDBCLineage/all/Lineage/InsertSubQuery_2.json       |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/InsertSubQuery_2.json       |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP4]                  |             | response/java/javaJDBCLineage/all/Lineage/InsertSubQuery_2.json       | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/InsertSubQuery_2.json       | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | RowsetWithDiffFunction                       |             | response/java/javaJDBCLineage/all/Lineage/RowsetWithDiffFunction.json |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | runRowSet                                    |             | response/java/javaJDBCLineage/all/Lineage/RowsetWithDiffFunction.json |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | runRowSet_SQL_Q_ROWSET_1_[QAEMP5]            |             | response/java/javaJDBCLineage/all/Lineage/RowsetWithDiffFunction.json | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/RowsetWithDiffFunction.json | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | FilesHandle4                                 |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle4.json           |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle4.json           |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PS_1_[QAEMPFILE4]                 |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle4.json           | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle4.json           | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | FilesHandle6                                 |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle6_1.json         |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle6_1.json         |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PS_1_[QAEMPFILE6]                 |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle6_1.json         | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle6_1.json         | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | FilesHandle6                                 |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle6_2.json         |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle6_2.json         |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMPFILE6]               |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle6_2.json         | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle6_2.json         | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | LambdaExp2                                   |             | response/java/javaJDBCLineage/all/Lineage/LambdaExp2.json             |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/LambdaExp2.json             |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PS_1_[QAEMPLAMBDA2]               |             | response/java/javaJDBCLineage/all/Lineage/LambdaExp2.json             | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/LambdaExp2.json             | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SeparateSourceSQL                            |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_1.json    |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_1.json    |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_V_1PSTMT_1_[qasmalltarget]        |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_1.json    | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_1.json    | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SeparateSourceSQL                            |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_2.json    |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_2.json    |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_V_2PSTMT_1_[QAEMPUPDATE]          |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_2.json    | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_2.json    | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SeparateSourceSQL                            |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_3.json    |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | getResultSet                                 |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_3.json    |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | getResultSet_SQL_Q_V2_STMT_1_[QAEMPID]       |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_3.json    | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_3.json    | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SeparateSourceSQL                            |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_4.json    |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | getResultSet                                 |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_4.json    |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | getResultSet_SQL_Q_V1_STMT_1_[qasmallsource] |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_4.json    | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_4.json    | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | UpdatewithConcat                             |             | response/java/javaJDBCLineage/all/Lineage/UpdatewithConcat_1.json     |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/UpdatewithConcat_1.json     |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMPUPDATE]              |             | response/java/javaJDBCLineage/all/Lineage/UpdatewithConcat_1.json     | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/UpdatewithConcat_1.json     | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | UpdatewithConcat                             |             | response/java/javaJDBCLineage/all/Lineage/UpdatewithConcat_2.json     |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/UpdatewithConcat_2.json     |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP5]                  |             | response/java/javaJDBCLineage/all/Lineage/UpdatewithConcat_2.json     | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/UpdatewithConcat_2.json     | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | GetFromTwoTables                             |             | response/java/javaJDBCLineage/all/Lineage/GetFromTwoTables_1.json     |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/GetFromTwoTables_1.json     |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAJOIN3M]                |             | response/java/javaJDBCLineage/all/Lineage/GetFromTwoTables_1.json     | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/GetFromTwoTables_1.json     | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | GetFromTwoTables                             |             | response/java/javaJDBCLineage/all/Lineage/GetFromTwoTables_2.json     |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/GetFromTwoTables_2.json     |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAJOIN1M, QAJOIN2M]       |             | response/java/javaJDBCLineage/all/Lineage/GetFromTwoTables_2.json     | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/GetFromTwoTables_2.json     | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | RowsetInsert                                 |             | response/java/javaJDBCLineage/all/Lineage/RowsetInsert_1.json         |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/RowsetInsert_1.json         |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_ROWSET_1_[QAEMPM]                 |             | response/java/javaJDBCLineage/all/Lineage/RowsetInsert_1.json         | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/RowsetInsert_1.json         | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | RowsetInsert                                 |             | response/java/javaJDBCLineage/all/Lineage/RowsetInsert_2.json         |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/RowsetInsert_2.json         |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP1M]                 |             | response/java/javaJDBCLineage/all/Lineage/RowsetInsert_2.json         | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/RowsetInsert_2.json         | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SynonymProg8                                 |             | response/java/javaJDBCLineage/all/Lineage/SynonymProg8_1.json         |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/SynonymProg8_1.json         |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[EMPX]                     |             | response/java/javaJDBCLineage/all/Lineage/SynonymProg8_1.json         | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/SynonymProg8_1.json         | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | SynonymProg8                                 |             | response/java/javaJDBCLineage/all/Lineage/SynonymProg8_2.json         |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/SynonymProg8_2.json         |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMP1M]                 |             | response/java/javaJDBCLineage/all/Lineage/SynonymProg8_2.json         | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/SynonymProg8_2.json         | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | FilesHandle2                                 |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle2.json           |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle2.json           |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMPFILE2C]              |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle2.json           | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle2.json           | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | LambdaExp1                                   |             | response/java/javaJDBCLineage/all/Lineage/LambdaExp1.json             |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/LambdaExp1.json             |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMPLAMBDA1C]            |             | response/java/javaJDBCLineage/all/Lineage/LambdaExp1.json             | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/LambdaExp1.json             | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | DirectLineagePrep                            |             | response/java/javaJDBCLineage/all/Lineage/DirectLineagePrep.json      |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/DirectLineagePrep.json      |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PSTMT_1_[QAEMPIDD, QAEMP5D]       |             | response/java/javaJDBCLineage/all/Lineage/DirectLineagePrep.json      | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/DirectLineagePrep.json      | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | FilesHandle3                                 |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle3.json           |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle3.json           |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_Q_STMT_1_[QAEMPFILE3D]              |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle3.json           | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle3.json           | $.tableIDinsideFunction |
      | APPDBPOSTGRES | ClassID               | Default | Class      | FilesHandle5                                 |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle5.json           |                         |
      | APPDBPOSTGRES | FunctionID            | Default |            | main                                         |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle5.json           |                         |
      | APPDBPOSTGRES | TableIDinsideFunction | Default |            | main_SQL_U_PS_1_[QAEMPFILE5D]                |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle5.json           | $.functionID            |
      | APPDBPOSTGRES | LineageID             | Default | LineageHop |                                              |             | response/java/javaJDBCLineage/all/Lineage/FilesHandle5.json           | $.tableIDinsideFunction |


  #7153167# #7153168# #7153169# #7153170# #7153171# #7153172# #7153173# #7186333# #7186334# #7186336#
  @MLP-24754 @MLP-24752 @MLP-24753 @regression @positive
  Scenario Outline: SC#5:API Lineage From To retrieval: User retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get multiple source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                   | inputFile                                                             | outputFile                                                                    |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | InsertSubQuery_1       | response/java/javaJDBCLineage/all/Lineage/InsertSubQuery_1.json       | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | InsertSubQuery_2       | response/java/javaJDBCLineage/all/Lineage/InsertSubQuery_2.json       | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RowsetWithDiffFunction | response/java/javaJDBCLineage/all/Lineage/RowsetWithDiffFunction.json | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesHandle4           | response/java/javaJDBCLineage/all/Lineage/FilesHandle4.json           | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesHandle6_1         | response/java/javaJDBCLineage/all/Lineage/FilesHandle6_1.json         | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesHandle6_2         | response/java/javaJDBCLineage/all/Lineage/FilesHandle6_2.json         | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | LambdaExp2             | response/java/javaJDBCLineage/all/Lineage/LambdaExp2.json             | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SeparateSourceSQL_1    | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_1.json    | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SeparateSourceSQL_2    | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_2.json    | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SeparateSourceSQL_3    | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_3.json    | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SeparateSourceSQL_4    | response/java/javaJDBCLineage/all/Lineage/SeparateSourceSQL_4.json    | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | UpdatewithConcat_1     | response/java/javaJDBCLineage/all/Lineage/UpdatewithConcat_1.json     | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | UpdatewithConcat_2     | response/java/javaJDBCLineage/all/Lineage/UpdatewithConcat_2.json     | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | GetFromTwoTables_1     | response/java/javaJDBCLineage/all/Lineage/GetFromTwoTables_1.json     | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | GetFromTwoTables_2     | response/java/javaJDBCLineage/all/Lineage/GetFromTwoTables_2.json     | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RowsetInsert_1         | response/java/javaJDBCLineage/all/Lineage/RowsetInsert_1.json         | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | RowsetInsert_2         | response/java/javaJDBCLineage/all/Lineage/RowsetInsert_2.json         | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SynonymProg8_1         | response/java/javaJDBCLineage/all/Lineage/SynonymProg8_1.json         | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | SynonymProg8_2         | response/java/javaJDBCLineage/all/Lineage/SynonymProg8_2.json         | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesHandle2           | response/java/javaJDBCLineage/all/Lineage/FilesHandle2.json           | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesHandle2           | response/java/javaJDBCLineage/all/Lineage/FilesHandle2.json           | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | DirectLineagePrep      | response/java/javaJDBCLineage/all/Lineage/DirectLineagePrep.json      | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesHandle3           | response/java/javaJDBCLineage/all/Lineage/FilesHandle3.json           | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | FilesHandle5           | response/java/javaJDBCLineage/all/Lineage/FilesHandle5.json           | response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json |

  #7153167# #7153168# #7153169# #7153170# #7153171# #7153172# #7153173# #7186333# #7186334# #7186336#
  @MLP-24754 @MLP-24752 @MLP-24753  @regression @positive
  Scenario Outline: SC#5:API Lineage Hops Final Validation: Lineage Hops Final Validation using API
    Given expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                           | actual_json                                                                                     | item                   |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | InsertSubQuery_1       |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | InsertSubQuery_2       |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | RowsetWithDiffFunction |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | FilesHandle4           |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | FilesHandle6_1         |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | FilesHandle6_2         |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | LambdaExp2             |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | SeparateSourceSQL_1    |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | SeparateSourceSQL_2    |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | SeparateSourceSQL_3    |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | SeparateSourceSQL_4    |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | UpdatewithConcat_1     |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | UpdatewithConcat_2     |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | RowsetWithDiffFunction |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | GetFromTwoTables_1     |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | GetFromTwoTables_2     |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | RowsetInsert_1         |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | RowsetInsert_2         |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | SynonymProg8_1         |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | SynonymProg8_2         |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | FilesHandle2           |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | FilesHandle2           |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | DirectLineagePrep      |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | FilesHandle3           |
      | ida/JavaJDBCAllPayloads/expectedJavaJDBCLineageAll.json | Constant.REST_DIR/response/java/javaJDBCLineage/all/Lineage/JavaJDBCLineageAllSourceTarget.json | FilesHandle5           |

  #7153170#
  @webtest @MLP-24754 @sanity @positive
  Scenario: SC#6-Verify Lineage Hops in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And login must be successful for all users
    And user enters the search text "tag_JavaJDBCAll" and clicks on search
    And user performs "facet selection" in "tag_JavaJDBCAll" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Class" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "LambdaExp2" item from search results
    Then user performs click and verify in new window
      | Table     | value                          | Action               | RetainPrevwindow | indexSwitch |
      | Functions | main                           | click and switch tab | No               |             |
      | Tables    | main_SQL_U_PS_1_[QAEMPLAMBDA2] | click and switch tab | No               |             |
    Then user performs click and verify in new window
      | Table        | value                                  | Action                       | RetainPrevwindow | indexSwitch | filePath                                                     | jsonPath       |
      | Lineage Hops | /C:/Lambda/FirstNameLists.txt => set_1 | click and verify lineagehops | Yes              | 0           | ida/JavaJDBCAllPayloads/LineageMetadata/lineageMetadata.json | $.LineageHop_1 |
      | Lineage Hops | set_1 => FNAME                         | click and verify lineagehops | Yes              | 0           | ida/JavaJDBCAllPayloads/LineageMetadata/lineageMetadata.json | $.LineageHop_2 |

  ############################################# Technology tags and Explicit tags verification #############################################
  #7153174#
  @webtest @MLP-24754 @sanity @positive
  Scenario: SC#7-Verify the technology tags and explicit tags got assigned to the Cataloged items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                           | fileName                          | userTag                           |
      | Default     | SourceTree | Metadata Type | tag_JavaJDBCAll,Java,test_BA_JavaJDBCAll      | SeparateSourceSQL                 | tag_JavaJDBCAll                   |
      | Default     | Class      | Metadata Type | tag_JavaJDBCAll,Java,test_BA_JavaJDBCAll      | SeparateSourceSQL                 | tag_JavaJDBCAll                   |
      | Default     | Function   | Metadata Type | tag_JavaJDBCAll,Java,JDBC,test_BA_JavaJDBCAll | runRowSet                         | runRowSe                          |
      | Default     | Table      | Metadata Type | tag_JavaJDBCAll,Java,JDBC,test_BA_JavaJDBCAll | runRowSet_SQL_Q_ROWSET_1_[QAEMP5] | runRowSet_SQL_Q_ROWSET_1_[QAEMP5] |

  ############################################# Post Conditions ##########################################################
  @jdbc
  Scenario: PostConditions-Delete required tables in Snowflake, Postgres DB, DynamoDB and Cassandra
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage          | queryField          |
      | POSTGRES           | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | dropSchemaPostgres  |
      | SNOWFLAKE          | EXECUTEQUERY | json/IDA.json | JavaJDBCQueriesAll | dropSchemaSnowflake |
    And user connects to AWS Dynamo database and perform the following operation
      | action      | jsonPath                                                                |
      | deleteTable | ida/javaJDBCAllPayloads/TestData/DynamoDB/CreateDynamoTableQAEMP5D.json |
    And user connects to AWS Dynamo database and perform the following operation
      | action      | jsonPath                                                                 |
      | deleteTable | ida/javaJDBCAllPayloads/TestData/DynamoDB/CreateDynamoTableQAEMPIDD.json |
    And user connects to AWS Dynamo database and perform the following operation
      | action      | jsonPath                                                                    |
      | deleteTable | ida/javaJDBCAllPayloads/TestData/DynamoDB/CreateDynamoTableQAEMPFILE3D.json |
    And user connects to AWS Dynamo database and perform the following operation
      | action      | jsonPath                                                                    |
      | deleteTable | ida/javaJDBCAllPayloads/TestData/DynamoDB/CreateDynamoTableQAEMPFILE5D.json |
    And user connect to the Cassandra DB database and execute query for the below parameters
      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage          | queryField       | keySpaceName |
      | CASSANDRA    | Drop      | dropKeySpace   | json/IDA.json | JavaJDBCQueriesAll | dropKeySpaceJDBC | jdbckeyspace |

  Scenario Outline: PostConditions: RetrieveItemIDs- User retrieves the item ids of different items and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                          | type    | targetFile                                            | jsonpath                             |
      | APPDBPOSTGRES | Default | javaspark_lineage                                             | Project | response/java/javaJDBCLineage/all/actual/itemIds.json | $..Project.id                        |
      | APPDBPOSTGRES | Default | decheqaperf01v.asg.com                                        |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..Postgres_Cluster.id               |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com                  |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..Snowflake_Cluster.id              |
      | APPDBPOSTGRES | Default | 10.33.6.117                                                   |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..Cassandra_Cluster.id              |
      | APPDBPOSTGRES | Default | Domain=amazonaws.com;Region=us-east-1;                        |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..Dynamo_Cluster.id                 |
      | APPDBPOSTGRES | Default | 10.33.6.130                                                   |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..Mongo_Cluster.id                  |
      | APPDBPOSTGRES | Default | test_BA_JavaJDBCAll                                           |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..has_BA.id                         |
      | APPDBPOSTGRES | Default | collector/GitCollector/GitCollectorJJA%DYN                    |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..Git_Analysis.id                   |
      | APPDBPOSTGRES | Default | cataloger/PostgreSQLDBCataloger/PostgreSQLDBCatalogerJJA/%DYN |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..Postgress_Analysis.id             |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeDBCatalogerJJA/%DYN   |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..Snowflake_Analysis.id             |
      | APPDBPOSTGRES | Default | cataloger/CassandraDBCataloger/CassandraDBCatalogerJJA/%DYN   |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..Cassandra_Analysis.id             |
      | APPDBPOSTGRES | Default | cataloger/DynamoDBCataloger/DynamoDBCatalogerJJA/%DYN         |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..Dynamo_Analysis.id                |
      | APPDBPOSTGRES | Default | cataloger/MongoDBCataloger/MongoDBCatalogerJJA/%DYN           |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..Mongo_Analysis.id                 |
      | APPDBPOSTGRES | Default | parser/JavaParser/JavaParserJJA%DYN                           |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..JParser_Analysis.id               |
      | APPDBPOSTGRES | Default | linker/JavaLinker/JavaLinkerJJA%DYN                           |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..JLinker_Analysis.id               |
      | APPDBPOSTGRES | Default | linker/JavaIOLinker/JavaIOLinkerJJA%DYN                       |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..JIOLinker_Analysis.id             |
      | APPDBPOSTGRES | Default | lineage/JavaJDBCLineage/JavaJDBCLineageJJA%DYN                |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..JavaJDBCLineage_Analysis.id       |
      | APPDBPOSTGRES | Default | lineage/JavaJDBCLineage/JavaJDBCLineageJJADryRun%DYN          |         | response/java/javaJDBCLineage/all/actual/itemIds.json | $..JavaJDBCLineageDryRun_Analysis.id |


  @cr-data @postcondition @sanity @positive
  Scenario Outline: PostConditions: ItemDeletion- User deletes the collected item from database using dynamic id stored in json 1
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                            | inputFile                                             |
      | items/Default/Default.Project:::dynamic             | 204          | $..Project.id                        | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Postgres_Cluster.id               | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Snowflake_Cluster.id              | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Cassandra_Cluster.id              | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Dynamo_Cluster.id                 | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Cluster:::dynamic             | 204          | $..Mongo_Cluster.id                  | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_BA.id                         | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Git_Analysis.id                   | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Postgress_Analysis.id             | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Snowflake_Analysis.id             | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Cassandra_Analysis.id             | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Dynamo_Analysis.id                | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..Mongo_Analysis.id                 | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JParser_Analysis.id               | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JLinker_Analysis.id               | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JIOLinker_Analysis.id             | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaJDBCLineage_Analysis.id       | response/java/javaJDBCLineage/all/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..JavaJDBCLineageDryRun_Analysis.id | response/java/javaJDBCLineage/all/actual/itemIds.json |

  Scenario: PostConditions: Delete all the External Packages with respect to Java JDBC Lineage
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name | type            | query | param |
      | MultipleIDDelete | Default |      | ExternalPackage |       |       |

  @sanity @positive @regression
  Scenario Outline: PostConditions: Delete Configurations the following Plugins for Git, MSSQL Cataloger, Java Parser, Java Linker, JavaJDBCLineage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                 | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidGitCredentialsJJA                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidPostgreDBCredentialsJJA                   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidSnowflakeDBCredentialsJJA                 |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidCassandraDBCredentialsJJA                 |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidAWSCredentialsJJA                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/ValidMongoDBCredentialsJJA                     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/GitCollectorDataSourceJJA |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollectorJJA                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PostgreSQLDBDataSource/PostgreSQLDBDataSourceJJA |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SnowflakeDBDataSource/SnowflakeDBDataSourceJJA   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CassandraDBDataSource/CassandraDBDataSourceJJA   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/DynamoDBDataSource/DynamoDBDataSourceJJA         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/MongoDBDataSource/MongoDBDataSourceJJA           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/PostgreSQLDBCataloger/PostgreSQLDBCatalogerJJA   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SnowflakeDBCataloger/SnowflakeDBCatalogerJJA     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CassandraDBCataloger/CassandraDBCatalogerJJA     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/DynamoDBCataloger/DynamoDBCatalogerJJA           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/MongoDBCataloger/MongoDBCatalogerJJA             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaParser/JavaParserJJA                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaLinker/JavaLinkerJJA                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaIOLinker/JavaIOLinkerJJA                     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJADryRun         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JavaJDBCLineage/JavaJDBCLineageJJA               |      | 204           |                  |          |
