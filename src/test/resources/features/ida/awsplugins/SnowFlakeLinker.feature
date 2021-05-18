Feature: SnowFlakeLinker: verification of Lineage for SpectrumLinker Plugin and Lineage between the snowflake tables and external tables

  ############################################################Pre condition - Set the Credential for Snowflake, S3, Csv, Avro, Parquet, Json###################################################################################################################

  Scenario Outline: Add valid Credentials for Snowflake, S3, Csv, Avro, Parquet, Json
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                               | body                                                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/SnowFlake_Credentials        | ida/PythonSparkPayloads/MLP-8130_PluginConfig/Snowflake_credentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/AWS_Amazon_Credentials       | ida/AmazonRedshiftPostProcessorPayloads/Amazons3Credentials.json         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Spec_ValidJSONCredentials    | ida/s3JsonPayloads/Credentials/awsJSONS3ValidCredentials.json            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Spec_AWS_CSV_Credentials     | ida/s3CSVPayloads/credentials/awsCredentials.json                        | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Spec_ValidParquetCredentials | ida/s3ParquetPayloads/Credentials/awsParquetS3ValidCredentials.json      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Spec_ValidAVROCredentials    | ida/s3AvroPayloads/Credentials/avroS3ValidCredentials.json               | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/OrcS3_ValidJSONCredentials   | ida/SnowFlakeLinkerPayloads/orcS3ValidCredentials.json                   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root                                | ida/SnowFlakeLinkerPayloads/BussinessApplication.json                    | 200           |                  |          |

    #############################################Running file Catalogers Json, Avro, Parquet#############################################################################################################################################################################################################################################################################################################################################################################################################

  Scenario Outline: SC#1_1 Run the SnowflakeCataloger, File Cataloger (Json, Avro, Parquet) and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                  | response code | response message               | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                          | 204           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                       | 200           | SnowFlakeDS                    |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig.json             | 204           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                       | 200           | SnowflakeJDBCCataloger         |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                                | 200           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3DataSource                                                         | ida/SnowFlakeLinkerPayloads/AmazonJSONS3ValidDataSourceConfig.json    | 204           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3DataSource                                                         |                                                                       | 200           | AmazonJSONS3ValidDataSource    |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                                          | ida/SnowFlakeLinkerPayloads/JsonS3Cataloger.json                      | 204           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger                                                          |                                                                       | 200           | JsonS3Cataloger                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*                           |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='JsonS3Cataloger')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*                            | ida/SnowFlakeLinkerPayloads/empty.json                                | 200           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*                           |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='JsonS3Cataloger')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3DataSource                                                         | ida/SnowFlakeLinkerPayloads/AvroS3ValidDataSourceConfig.json          | 204           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3DataSource                                                         |                                                                       | 200           |                                | AvroS3ValidDataSource                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                                          | ida/SnowFlakeLinkerPayloads/AvroS3Cataloger.json                      | 204           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                                          |                                                                       | 200           | AvroS3Catalog                  |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*                           |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='AvroS3Catalog')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*                            | ida/SnowFlakeLinkerPayloads/empty.json                                | 200           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*                           |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='AvroS3Catalog')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3DataSource                                                      | ida/SnowFlakeLinkerPayloads/AmazonParquetS3ValidDataSourceConfig.json | 204           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3DataSource                                                      |                                                                       | 200           | AmazonParquetS3ValidDataSource |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                       | ida/SnowFlakeLinkerPayloads/ParquetS3Cataloger.json                   | 204           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                       |                                                                       | 200           | ParquetS3Cataloger             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/*                        |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='ParquetS3Cataloger')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*                         | ida/SnowFlakeLinkerPayloads/empty.json                                | 200           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/*                        |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='ParquetS3Cataloger')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_WithoutFilters.json       | 204           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                       | 200           | SnowflakeDBLinker              |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                                | 200           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

  Scenario:SC#1_2 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                               | asg_scopeid | targetFile                                                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | JsonExternalTableSingleFolder      |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | JsonExternalTableMultipleFolder    |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | ParquetExternalTableComplexType    |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | ParquetExternalTableSingleFolder   |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | ParquetExternalTableMultipleFolder |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | AvroExternalTableSingleFolder      |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | AvroExternalTableMultipleFolder    |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                                             | path                                                 | response code | response message | jsonPath | targetFile                                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.JsonExternalTableSingleFolder      | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualFileCatalogersLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.JsonExternalTableMultipleFolder    | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualFileCatalogersLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.ParquetExternalTableComplexType    | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualFileCatalogersLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.ParquetExternalTableSingleFolder   | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualFileCatalogersLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.ParquetExternalTableMultipleFolder | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualFileCatalogersLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.AvroExternalTableSingleFolder      | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualFileCatalogersLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.AvroExternalTableMultipleFolder    | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualFileCatalogersLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                | JsonPath                           |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualFileCatalogersLineagehops.json | JsonExternalTableSingleFolder      |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualFileCatalogersLineagehops.json | JsonExternalTableMultipleFolder    |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualFileCatalogersLineagehops.json | ParquetExternalTableComplexType    |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualFileCatalogersLineagehops.json | ParquetExternalTableSingleFolder   |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualFileCatalogersLineagehops.json | ParquetExternalTableMultipleFolder |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualFileCatalogersLineagehops.json | AvroExternalTableSingleFolder      |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualFileCatalogersLineagehops.json | AvroExternalTableMultipleFolder    |

    ##7125603## ##7125605## ##7125606## ##7125608## ##7125609## ##7125619## ##7125620##
  Scenario Outline:SC#1_3 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                         | actualJson                                                                                              |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/expectedJsonFiles/fileCatalogers_Lineagehops.json | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualFileCatalogersLineagehops.json |

  Scenario Outline: SC#1_4 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                           | jsonpath                    |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json        | $..Cluster.id               |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json      | $..has_Directory.id         |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json        | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json        | $..has_LinkerAnalysis.id    |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN             |           | response/SnowflakeLinker_Lineage/jsonItemIds.json    | $..has_Analysis.id          |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Catalog%DYN               |           | response/SnowflakeLinker_Lineage/avroItemIds.json    | $..has_Analysis.id          |
      | APPDBPOSTGRES | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger%DYN       |           | response/SnowflakeLinker_Lineage/parquetItemIds.json | $..has_Analysis.id          |

  Scenario Outline: SC#1_5 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                   | inputFile                                            |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id               | response/SnowflakeLinker_Lineage/itemIds.json        |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id         | response/SnowflakeLinker_Lineage/s3itemIds.json      |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id | response/SnowflakeLinker_Lineage/itemIds.json        |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json        |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id          | response/SnowflakeLinker_Lineage/jsonItemIds.json    |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id          | response/SnowflakeLinker_Lineage/avroItemIds.json    |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id          | response/SnowflakeLinker_Lineage/parquetItemIds.json |

    ###########################################################Running S3Cataloger alone#########################################################################################################################################

  Scenario Outline: SC#02_1 Run the snowflakeCataloger,s3Cataloger and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                             | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                  | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig.json        | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                  | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                           | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                                                       | ida/SnowFlakeLinkerPayloads/AmazonS3DataSourceConfig.json        | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                                                       |                                                                  | 200           | AmazonS3DataSource     |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                        | ida/SnowFlakeLinkerPayloads/AmazonS3Cataloger_Configuration.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                        |                                                                  | 200           | AmazonS3Cataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*                          | ida/SnowFlakeLinkerPayloads/empty.json                           | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_WithoutFilters.json  | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                  | 200           | SnowflakeDBLinker      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                           | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |


  Scenario:SC#2_3 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                                   | asg_scopeid | targetFile                                                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | JsonExternalTableSingleFolder          |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | JsonExternalTableMultipleFolder        |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | ParquetExternalTableComplexType        |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | ParquetExternalTableSingleFolder       |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | ParquetExternalTableMultipleFolder     |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | AvroExternalTableSingleFolder          |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | AvroExternalTableMultipleFolder        |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CsvExternalTableWithHeaderSinglefolder |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                                             | path                                                     | response code | response message | jsonPath | targetFile                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.JsonExternalTableSingleFolder          | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualS3CatalogersLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.JsonExternalTableMultipleFolder        | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualS3CatalogersLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.ParquetExternalTableComplexType        | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualS3CatalogersLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.ParquetExternalTableSingleFolder       | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualS3CatalogersLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.ParquetExternalTableMultipleFolder     | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualS3CatalogersLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.AvroExternalTableSingleFolder          | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualS3CatalogersLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.AvroExternalTableMultipleFolder        | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualS3CatalogersLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.CsvExternalTableWithHeaderSinglefolder | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualS3CatalogersLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                              | JsonPath                               |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualS3CatalogersLineagehops.json | JsonExternalTableSingleFolder          |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualS3CatalogersLineagehops.json | JsonExternalTableMultipleFolder        |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualS3CatalogersLineagehops.json | ParquetExternalTableComplexType        |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualS3CatalogersLineagehops.json | ParquetExternalTableSingleFolder       |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualS3CatalogersLineagehops.json | ParquetExternalTableMultipleFolder     |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualS3CatalogersLineagehops.json | AvroExternalTableSingleFolder          |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualS3CatalogersLineagehops.json | AvroExternalTableMultipleFolder        |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualS3CatalogersLineagehops.json | CsvExternalTableWithHeaderSinglefolder |


    ##7125604## ##7125607## ##7125614## ##7125617##
  Scenario Outline:SC#2_4 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                       | actualJson                                                                                            |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/expectedJsonFiles/S3Catalogers_Lineagehops.json | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualS3CatalogersLineagehops.json |

  Scenario Outline: SC#2_5 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                      | jsonpath                    |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..Cluster.id               |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json | $..has_Directory.id         |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_LinkerAnalysis.id    |

  Scenario Outline: SC#2_6 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                   | inputFile                                       |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id               | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id         | response/SnowflakeLinker_Lineage/s3itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json   |

    ###########################################################Running CSVS3 with Header True#############################################################################################################################################################

  Scenario Outline: SC#3_1 Run the snowflakeCataloger, CSV S3 and the spectrumLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                            | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                    | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                 | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig.json       | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                 | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                          | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonCSVS3DataSource                                                    | ida/SnowFlakeLinkerPayloads/AmazonCSVS3DataSourceConfig.json    | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonCSVS3DataSource                                                    |                                                                 | 200           | AmazonCSVS3DataSource  |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                                           | ida/SnowFlakeLinkerPayloads/CsvS3Cataloger.json                 | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                                           |                                                                 | 200           | CSVS3Cataloger         |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*                            |                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='CSVS3Cataloger')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*                             | ida/SnowFlakeLinkerPayloads/empty.json                          | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*                            |                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='CSVS3Cataloger')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_WithoutFilters.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                 | 200           | SnowflakeDBLinker      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                          | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |


  Scenario:SC#3_2 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                                            | asg_scopeid | targetFile                                                                 | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CsvExternalTableWithHeaderSinglefolder          |             | response/SnowflakeLinker_Lineage/actualJsonFiles/csvHeaderTrueLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CsvExternalTableWithHeaderMultiplefolder        |             | response/SnowflakeLinker_Lineage/actualJsonFiles/csvHeaderTrueLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CsvExternalTableWithoutHeaderFileFirstRowHeader |             | response/SnowflakeLinker_Lineage/actualJsonFiles/csvHeaderTrueLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                                                   | path                                                              | response code | response message | jsonPath | targetFile                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\csvHeaderTrueLineage.json | $.lineagePayLoads.CsvExternalTableWithHeaderSinglefolder          | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualCSVHeaderTrueLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\csvHeaderTrueLineage.json | $.lineagePayLoads.CsvExternalTableWithHeaderMultiplefolder        | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualCSVHeaderTrueLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\csvHeaderTrueLineage.json | $.lineagePayLoads.CsvExternalTableWithoutHeaderFileFirstRowHeader | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualCSVHeaderTrueLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                               | JsonPath                                        |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderTrueLineagehops.json | CsvExternalTableWithHeaderSinglefolder          |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderTrueLineagehops.json | CsvExternalTableWithHeaderMultiplefolder        |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderTrueLineagehops.json | CsvExternalTableWithoutHeaderFileFirstRowHeader |


    ##7125614## ##7125615## ##7125616##
  Scenario Outline:SC#3_3 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                       | actualJson                                                                                             |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/expectedJsonFiles/CSVHeaderTrueLineagehops.json | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderTrueLineagehops.json |


  Scenario Outline: SC#3_4 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                      | jsonpath                       |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..Cluster.id                  |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json | $..has_Directory.id            |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_CatalogerAnalysis.id    |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_LinkerAnalysis.id       |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CSVS3Cataloger%DYN               |           | response/amazonSpectrum/actual/itemIds.json     | $..has_CSVCatalogerAnalysis.id |

  Scenario Outline: SC#3_5 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                      | inputFile                                       |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id                  | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id            | response/SnowflakeLinker_Lineage/s3itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id       | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CSVCatalogerAnalysis.id | response/amazonSpectrum/actual/itemIds.json     |

    ##########################################################Running CSVS3 with Header False##########################################################################################################################

  Scenario Outline: SC#4_1 Run the snowflakeCataloger, CSV S3 and the spectrumLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                            | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                    | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                 | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig.json       | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                 | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                          | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonCSVS3DataSource                                                    | ida/SnowFlakeLinkerPayloads/AmazonCSVS3DataSourceConfig.json    | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonCSVS3DataSource                                                    |                                                                 | 200           | AmazonCSVS3DataSource  |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                                           | ida/SnowFlakeLinkerPayloads/CsvS3Cataloger2.json                | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                                           |                                                                 | 200           | CSVS3Cataloger         |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*                            |                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='CSVS3Cataloger')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*                             | ida/SnowFlakeLinkerPayloads/empty.json                          | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*                            |                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='CSVS3Cataloger')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_WithoutFilters.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                 | 200           | SnowflakeDBLinker      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                          | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |


  Scenario:SC#4_2 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                                        | asg_scopeid | targetFile                                                                  | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CsvExternalTableWithoutHeaderSingleFolder   |             | response/SnowflakeLinker_Lineage/actualJsonFiles/csvHeaderFalseLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CsvExternalTableWithoutHeaderMultipleFolder |             | response/SnowflakeLinker_Lineage/actualJsonFiles/csvHeaderFalseLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                                                    | path                                                          | response code | response message | jsonPath | targetFile                                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\csvHeaderFalseLineage.json | $.lineagePayLoads.CsvExternalTableWithoutHeaderSingleFolder   | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualCSVHeaderFalseLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\csvHeaderFalseLineage.json | $.lineagePayLoads.CsvExternalTableWithoutHeaderMultipleFolder | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualCSVHeaderFalseLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                | JsonPath                                    |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderFalseLineagehops.json | CsvExternalTableWithoutHeaderSingleFolder   |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderFalseLineagehops.json | CsvExternalTableWithoutHeaderMultipleFolder |


    ##7125612## ##7125613##
  Scenario Outline:SC#4_3 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                        | actualJson                                                                                              |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/expectedJsonFiles/CSVHeaderFalseLineagehops.json | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderFalseLineagehops.json |


  Scenario Outline: SC#4_4 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                      | jsonpath                       |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..Cluster.id                  |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json | $..has_Directory.id            |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_CatalogerAnalysis.id    |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_LinkerAnalysis.id       |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CSVS3Cataloger%DYN               |           | response/amazonSpectrum/actual/itemIds.json     | $..has_CSVCatalogerAnalysis.id |

  Scenario Outline: SC#4_5 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                      | inputFile                                       |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id                  | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id            | response/SnowflakeLinker_Lineage/s3itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id       | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CSVCatalogerAnalysis.id | response/amazonSpectrum/actual/itemIds.json     |

    ###########################################################Running CSVS3 with Header True along with S3 Cataloger###########################################################################################################################

  Scenario Outline: SC#5_1 Run the snowflakeCataloger, s3Cataloger, CSV S3 and the spectrumLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                             | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                  | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig.json        | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                  | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                           | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                                                       | ida/SnowFlakeLinkerPayloads/AmazonS3DataSourceConfig.json        | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                                                       |                                                                  | 200           | AmazonS3DataSource     |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                        | ida/SnowFlakeLinkerPayloads/AmazonS3Cataloger_Configuration.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                        |                                                                  | 200           | AmazonS3Cataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*                          | ida/SnowFlakeLinkerPayloads/empty.json                           | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonCSVS3DataSource                                                    | ida/SnowFlakeLinkerPayloads/AmazonCSVS3DataSourceConfig.json     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonCSVS3DataSource                                                    |                                                                  | 200           | AmazonCSVS3DataSource  |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                                           | ida/SnowFlakeLinkerPayloads/CsvS3Cataloger.json                  | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                                           |                                                                  | 200           | CSVS3Cataloger         |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*                            |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='CSVS3Cataloger')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*                             | ida/SnowFlakeLinkerPayloads/empty.json                           | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*                            |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='CSVS3Cataloger')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_WithoutFilters.json  | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                  | 200           | SnowflakeDBLinker      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                           | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

  Scenario:SC#5_2 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                                            | asg_scopeid | targetFile                                                                 | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CsvExternalTableWithHeaderSinglefolder          |             | response/SnowflakeLinker_Lineage/actualJsonFiles/csvHeaderTrueLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CsvExternalTableWithHeaderMultiplefolder        |             | response/SnowflakeLinker_Lineage/actualJsonFiles/csvHeaderTrueLineage.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CsvExternalTableWithoutHeaderFileFirstRowHeader |             | response/SnowflakeLinker_Lineage/actualJsonFiles/csvHeaderTrueLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                                                   | path                                                              | response code | response message | jsonPath | targetFile                                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\csvHeaderTrueLineage.json | $.lineagePayLoads.CsvExternalTableWithHeaderSinglefolder          | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualCSVHeaderTrueLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\csvHeaderTrueLineage.json | $.lineagePayLoads.CsvExternalTableWithHeaderMultiplefolder        | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualCSVHeaderTrueLineagehops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\csvHeaderTrueLineage.json | $.lineagePayLoads.CsvExternalTableWithoutHeaderFileFirstRowHeader | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualCSVHeaderTrueLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                               | JsonPath                                        |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderTrueLineagehops.json | CsvExternalTableWithHeaderSinglefolder          |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderTrueLineagehops.json | CsvExternalTableWithHeaderMultiplefolder        |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderTrueLineagehops.json | CsvExternalTableWithoutHeaderFileFirstRowHeader |


    ##7125611## ##7125612## ##7125632##
  Scenario Outline:SC#5_3 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                       | actualJson                                                                                             |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/expectedJsonFiles/CSVHeaderTrueLineagehops.json | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderTrueLineagehops.json |


  Scenario Outline: SC#5_4 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                      | jsonpath                       |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..Cluster.id                  |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json | $..has_Directory.id            |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_CatalogerAnalysis.id    |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_LinkerAnalysis.id       |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CSVS3Cataloger%DYN               |           | response/amazonSpectrum/actual/itemIds.json     | $..has_CSVCatalogerAnalysis.id |

  Scenario Outline: SC#5_5 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                      | inputFile                                       |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id                  | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id            | response/SnowflakeLinker_Lineage/s3itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id       | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CSVCatalogerAnalysis.id | response/amazonSpectrum/actual/itemIds.json     |

    ###########################################################Negative Cases#########################################################################################################################################

  ###########################################################Incorrect Clustername in Linker#########################################################################################################################################

  Scenario Outline: SC#6_1 Run the snowflakeCataloger,s3Cataloger and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                              | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                      | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                   | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig.json         | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                   | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                                                       | ida/SnowFlakeLinkerPayloads/AmazonS3DataSourceConfig.json         | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                                                       |                                                                   | 200           | AmazonS3DataSource     |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                        | ida/SnowFlakeLinkerPayloads/AmazonS3Cataloger_Configuration.json  | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                        |                                                                   | 200           | AmazonS3Cataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*                          | ida/SnowFlakeLinkerPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_IncorrectCluster.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                   | 200           | SnowflakeDBLinker      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

    #7125622
  @webtest
  Scenario:SC#6_2 Verify Snowflake linker does not create any lineage when incorrect cluster name is provided in linker.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowflakeDBLinker" and clicks on search
    And user performs "latest analysis click" in Item Results page for "linker/SnowflakeDBLinker/SnowflakeDBLinker%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/SnowflakeDBLinker/SnowflakeDBLinker%" should display below info/error/warning
      | type | logValue                                                                     | logCode                  | pluginName        | removableText |
      | INFO | Found no databases to process linker as clusters to process is null or blank | ANALYSIS-LINKER-MSG-0016 | SnowflakeDBLinker |               |

  Scenario Outline: SC#6_3 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                      | jsonpath                    |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..Cluster.id               |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json | $..has_Directory.id         |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_LinkerAnalysis.id    |

  Scenario Outline: SC#6_4 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                   | inputFile                                       |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id               | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id         | response/SnowflakeLinker_Lineage/s3itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json   |

###########################################################Incorrect database name in Linker######################################################################################################################################################################################################################################################

  Scenario Outline: SC#7_1 Run the snowflakeCataloger,s3Cataloger and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                               | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                       | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                    | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig.json          | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                    | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                    | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                             | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                    | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                                                       | ida/SnowFlakeLinkerPayloads/AmazonS3DataSourceConfig.json          | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                                                       |                                                                    | 200           | AmazonS3DataSource     |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                        | ida/SnowFlakeLinkerPayloads/AmazonS3Cataloger_Configuration.json   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                        |                                                                    | 200           | AmazonS3Cataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                    | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*                          | ida/SnowFlakeLinkerPayloads/empty.json                             | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                    | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_IncorrectDatabase.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                    | 200           | SnowflakeDBLinker      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                    | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                             | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                    | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

  #7125623
  @webtest
  Scenario:SC#7_2 Verify Snowflake linker does not create any lineage when incorrect Database name is provided in linker.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowflakeDBLinker" and clicks on search
    And user performs "latest analysis click" in Item Results page for "linker/SnowflakeDBLinker/SnowflakeDBLinker%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/SnowflakeDBLinker/SnowflakeDBLinker%" should display below info/error/warning
      | type | logValue                                                                                                           | logCode                  | pluginName        | removableText |
      | INFO | Found no databases to process linker for service Snowflake in cluster asg_partner.us-east-1.snowflakecomputing.com | ANALYSIS-LINKER-MSG-0016 | SnowflakeDBLinker |               |

  Scenario Outline: SC#7_3 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                      | jsonpath                    |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..Cluster.id               |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json | $..has_Directory.id         |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_LinkerAnalysis.id    |

  Scenario Outline: SC#7_4 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                   | inputFile                                       |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id               | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id         | response/SnowflakeLinker_Lineage/s3itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json   |

  ##############################################################Incorrect Schema name in Linker######################################################################################################################################################################################################

  Scenario Outline: SC#8_1 Run the snowflakeCataloger,s3Cataloger and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                             | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                  | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig.json        | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                  | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                           | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                                                       | ida/SnowFlakeLinkerPayloads/AmazonS3DataSourceConfig.json        | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                                                       |                                                                  | 200           | AmazonS3DataSource     |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                        | ida/SnowFlakeLinkerPayloads/AmazonS3Cataloger_Configuration.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                        |                                                                  | 200           | AmazonS3Cataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*                          | ida/SnowFlakeLinkerPayloads/empty.json                           | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_IncorrectSchema.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                  | 200           | SnowflakeDBLinker      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                           | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

  #7125624
  @webtest
  Scenario:SC#8_2 Verify Snowflake linker does not create any lineage when incorrect Schema name is provided in linker.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowflakeDBLinker" and clicks on search
    And user performs "latest analysis click" in Item Results page for "linker/SnowflakeDBLinker/SnowflakeDBLinker%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/SnowflakeDBLinker/SnowflakeDBLinker%" should display below info/error/warning
      | type | logValue                                                                                                                                                   | logCode                  | pluginName        | removableText |
      | INFO | Found no tables to process linker for given database or schema, table filter in service Snowflake and cluster asg_partner.us-east-1.snowflakecomputing.com | ANALYSIS-LINKER-MSG-0017 | SnowflakeDBLinker |               |

  Scenario Outline: SC#8_3 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                      | jsonpath                    |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..Cluster.id               |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json | $..has_Directory.id         |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_LinkerAnalysis.id    |

  Scenario Outline: SC#8_4 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                   | inputFile                                       |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id               | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id         | response/SnowflakeLinker_Lineage/s3itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json   |

    ############################################################################################################################################################################################################################

   #7125625
  @webtest
  Scenario:SC9# Verify proper error message is shown in UI when cluster name is not provided in Snowflake linker configuration.
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
      | Type      | Linker            |
      | Plugin    | SnowflakeDBLinker |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Host name | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage                   |
      | Host name | Host name field should not be empty |

    #######################################################Filters in Snowflake Linker Config##########################################################################################################
  #######################################################single schema and table filters in Linker##########################################################################################################

  Scenario Outline: SC#10_1 Run the SnowflakeCataloger, File Cataloger (Json) and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                   | response code | response message            | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                           | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                        | 200           | SnowFlakeDS                 |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig_SingleSchema.json | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                        | 200           | SnowflakeJDBCCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                        | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                                 | 200           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                        | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3DataSource                                                         | ida/SnowFlakeLinkerPayloads/AmazonJSONS3ValidDataSourceConfig.json     | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3DataSource                                                         |                                                                        | 200           | AmazonJSONS3ValidDataSource |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                                          | ida/SnowFlakeLinkerPayloads/JsonS3Cataloger.json                       | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger                                                          |                                                                        | 200           | JsonS3Cataloger             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*                           |                                                                        | 200           | IDLE                        | $.[?(@.configurationName=='JsonS3Cataloger')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*                            | ida/SnowFlakeLinkerPayloads/empty.json                                 | 200           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*                           |                                                                        | 200           | IDLE                        | $.[?(@.configurationName=='JsonS3Cataloger')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_SingleSchemaTable.json     | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                        | 200           | SnowflakeDBLinker           |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                        | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                                 | 200           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                        | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

  Scenario:SC#10_2 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                          | asg_scopeid | targetFile                                                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | JsonExternalTableSingleFolder |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                                             | path                                            | response code | response message | jsonPath | targetFile                                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.JsonExternalTableSingleFolder | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualSingleSchemaTableLinegaeHops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                   | JsonPath                      |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualSingleSchemaTableLinegaeHops.json | JsonExternalTableSingleFolder |

    ##7125633##
  Scenario Outline:SC#10_3 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                           | actualJson                                                                                                 |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/expectedJsonFiles/singleSchemaTableLinegaeHops.json | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualSingleSchemaTableLinegaeHops.json |

  Scenario Outline: SC#10_4 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                        | jsonpath                    |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..Cluster.id               |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json   | $..has_Directory.id         |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..has_LinkerAnalysis.id    |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN             |           | response/SnowflakeLinker_Lineage/jsonItemIds.json | $..has_Analysis.id          |

  Scenario Outline: SC#10_5 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                   | inputFile                                         |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id               | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id         | response/SnowflakeLinker_Lineage/s3itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id          | response/SnowflakeLinker_Lineage/jsonItemIds.json |

#######################################################multiple/single table filters in Linker##########################################################################################################

  Scenario Outline: SC#11_1 Run the SnowflakeCataloger, File Cataloger (Json,Avro) and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                   | response code | response message            | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloadks/SnowflakeDS.json                          | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                        | 200           | SnowFlakeDS                 |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig_SingleSchema.json | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                        | 200           | SnowflakeJDBCCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                        | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                                 | 200           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                        | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3DataSource                                                         | ida/SnowFlakeLinkerPayloads/AmazonJSONS3ValidDataSourceConfig.json     | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3DataSource                                                         |                                                                        | 200           | AmazonJSONS3ValidDataSource |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                                          | ida/SnowFlakeLinkerPayloads/JsonS3Cataloger.json                       | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger                                                          |                                                                        | 200           | JsonS3Cataloger             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*                           |                                                                        | 200           | IDLE                        | $.[?(@.configurationName=='JsonS3Cataloger')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*                            | ida/SnowFlakeLinkerPayloads/empty.json                                 | 200           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*                           |                                                                        | 200           | IDLE                        | $.[?(@.configurationName=='JsonS3Cataloger')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3DataSource                                                         | ida/SnowFlakeLinkerPayloads/AvroS3ValidDataSourceConfig.json           | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3DataSource                                                         |                                                                        | 200           |                             | AvroS3ValidDataSource                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                                          | ida/SnowFlakeLinkerPayloads/AvroS3Cataloger.json                       | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                                          |                                                                        | 200           | AvroS3Catalog               |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*                           |                                                                        | 200           | IDLE                        | $.[?(@.configurationName=='AvroS3Catalog')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*                            | ida/SnowFlakeLinkerPayloads/empty.json                                 | 200           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*                           |                                                                        | 200           | IDLE                        | $.[?(@.configurationName=='AvroS3Catalog')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_MultipleSchemaTable.json   | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                        | 200           | SnowflakeDBLinker           |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                        | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                                 | 200           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                        | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

  Scenario:SC#11_2 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                          | asg_scopeid | targetFile                                                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | JsonExternalTableSingleFolder |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | AvroExternalTableSingleFolder |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                                             | path                                            | response code | response message | jsonPath | targetFile                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.JsonExternalTableSingleFolder | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualMultipleSchemaTableLinegaeHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.AvroExternalTableSingleFolder | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualMultipleSchemaTableLinegaeHops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                     | JsonPath                      |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualMultipleSchemaTableLinegaeHops.json | JsonExternalTableSingleFolder |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualMultipleSchemaTableLinegaeHops.json | AvroExternalTableSingleFolder |

    ##7125634##
  Scenario Outline:SC#11_3 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                             | actualJson                                                                                                   |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/expectedJsonFiles/multipleSchemaTableLinegaeHops.json | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualMultipleSchemaTableLinegaeHops.json |

  Scenario Outline: SC#11_4 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                        | jsonpath                    |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..Cluster.id               |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json   | $..has_Directory.id         |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..has_LinkerAnalysis.id    |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN             |           | response/SnowflakeLinker_Lineage/jsonItemIds.json | $..has_Analysis.id          |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Catalog%DYN               |           | response/SnowflakeLinker_Lineage/avroItemIds.json | $..has_Analysis.id          |

  Scenario Outline: SC#11_5 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                   | inputFile                                         |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id               | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id         | response/SnowflakeLinker_Lineage/s3itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id          | response/SnowflakeLinker_Lineage/jsonItemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id          | response/SnowflakeLinker_Lineage/avroItemIds.json |

    #######################################################table filters alone filters having multiple repeated in Linker##########################################################################################################

  Scenario Outline: SC#12_1 Run the SnowflakeCataloger, File Cataloger (Parquet) and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                  | response code | response message               | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                          | 204           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                       | 200           | SnowFlakeDS                    |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig.json             | 204           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                       | 200           | SnowflakeJDBCCataloger         |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                                | 200           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3DataSource                                                      | ida/SnowFlakeLinkerPayloads/AmazonParquetS3ValidDataSourceConfig.json | 204           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3DataSource                                                      |                                                                       | 200           | AmazonParquetS3ValidDataSource |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/ParquetS3Cataloger                                                       | ida/SnowFlakeLinkerPayloads/ParquetS3Cataloger.json                   | 204           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/ParquetS3Cataloger                                                       |                                                                       | 200           | ParquetS3Cataloger             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/*                        |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='ParquetS3Cataloger')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*                         | ida/SnowFlakeLinkerPayloads/empty.json                                | 200           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/*                        |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='ParquetS3Cataloger')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_OnlyTables.json           | 204           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                       | 200           | SnowflakeDBLinker              |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                                | 200           |                                |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

  Scenario:SC#12_2 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                               | asg_scopeid | targetFile                                                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | ParquetExternalTableSingleFolder   |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | ParquetExternalTableMultipleFolder |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                                             | path                                                 | response code | response message | jsonPath | targetFile                                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.ParquetExternalTableSingleFolder   | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualTablesLinegaeHops.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.ParquetExternalTableMultipleFolder | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualTablesLinegaeHops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                        | JsonPath                           |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualTablesLinegaeHops.json | ParquetExternalTableSingleFolder   |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualTablesLinegaeHops.json | ParquetExternalTableMultipleFolder |

    ##7125635##
  Scenario Outline:SC#12_3 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                      | actualJson                                                                                      |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/expectedJsonFiles/tableFiltersLinegaeHops.json | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualTablesLinegaeHops.json |

  Scenario Outline: SC#12_4 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                           | jsonpath                    |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json        | $..Cluster.id               |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json      | $..has_Directory.id         |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json        | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json        | $..has_LinkerAnalysis.id    |
      | APPDBPOSTGRES | Default | cataloger/ParquetS3Cataloger/ParquetS3Cataloger%DYN       |           | response/SnowflakeLinker_Lineage/parquetItemIds.json | $..has_Analysis.id          |

  Scenario Outline: SC#12_5 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                   | inputFile                                            |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id               | response/SnowflakeLinker_Lineage/itemIds.json        |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id         | response/SnowflakeLinker_Lineage/s3itemIds.json      |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id | response/SnowflakeLinker_Lineage/itemIds.json        |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json        |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id          | response/SnowflakeLinker_Lineage/parquetItemIds.json |

#######################################################schema/table filters having multiple repeated in Linker##########################################################################################################

  Scenario Outline: SC#13_1 Run the SnowflakeCataloger, File Cataloger (Avro) and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                             | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                  | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig.json        | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                  | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                           | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3DataSource                                                         | ida/SnowFlakeLinkerPayloads/AvroS3ValidDataSourceConfig.json     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3DataSource                                                         |                                                                  | 200           |                        | AvroS3ValidDataSource                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                                          | ida/SnowFlakeLinkerPayloads/AvroS3Cataloger.json                 | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                                          |                                                                  | 200           | AvroS3Catalog          |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*                           |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='AvroS3Catalog')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*                            | ida/SnowFlakeLinkerPayloads/empty.json                           | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*                           |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='AvroS3Catalog')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_RepeatedFilters.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                  | 200           | SnowflakeDBLinker      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/linker/SnowflakeDBLinker/*                         |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/linker/SnowflakeDBLinker/*                          | ida/SnowFlakeLinkerPayloads/empty.json                           | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/linker/SnowflakeDBLinker/*                         |                                                                  | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

  Scenario:SC#13_2 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                          | asg_scopeid | targetFile                                                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | AvroExternalTableSingleFolder |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                                             | path                                            | response code | response message | jsonPath | targetFile                                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.AvroExternalTableSingleFolder | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualRepeatedFiltersLinegaeHops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                 | JsonPath                      |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualRepeatedFiltersLinegaeHops.json | AvroExternalTableSingleFolder |

    ##7125636## ##7125628##
  Scenario Outline:SC#13_3 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                         | actualJson                                                                                               |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/expectedJsonFiles/repeatedFiltersLinegaeHops.json | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualRepeatedFiltersLinegaeHops.json |

  Scenario Outline: SC#13_4 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                        | jsonpath                    |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..Cluster.id               |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json   | $..has_Directory.id         |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..has_LinkerAnalysis.id    |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Catalog%DYN               |           | response/SnowflakeLinker_Lineage/avroItemIds.json | $..has_Analysis.id          |

  Scenario Outline: SC#13_5 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                   | inputFile                                         |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id               | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id         | response/SnowflakeLinker_Lineage/s3itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id          | response/SnowflakeLinker_Lineage/avroItemIds.json |

    #################################################Schema contains both normal and external tables in linker########################################################################

  Scenario Outline: SC#14_1 Run the SnowflakeCataloger, File Cataloger (Avro) and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                  | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                          | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                       | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig.json             | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                       | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                                | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3DataSource                                                         | ida/SnowFlakeLinkerPayloads/AvroS3ValidDataSourceConfig.json          | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3DataSource                                                         |                                                                       | 200           |                        | AvroS3ValidDataSource                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger                                                          | ida/SnowFlakeLinkerPayloads/AvroS3Cataloger.json                      | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AvroS3Cataloger                                                          |                                                                       | 200           | AvroS3Catalog          |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*                           |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AvroS3Catalog')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*                            | ida/SnowFlakeLinkerPayloads/empty.json                                | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*                           |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='AvroS3Catalog')].status          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_NormalExternalTables.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                       | 200           | SnowflakeDBLinker      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                                | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                       | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

    ##7125637##
  @webtest
  Scenario:SC#14_1 Verify snowflakelinker does not create any lineage for normal tables if the schema contains both normal and external tables
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DiffDataTypes" and clicks on search
    And user performs "item click" on "DiffDataTypes" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName  |
      | Location          | Description |
    And user enters the search text "AvroExternalTableSingleFolder" and clicks on search
    And user performs "item click" on "AvroExternalTableSingleFolder" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | EXTERNAL      | Description |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                         | widgetName  |
      | Location          | s3://asgredshiftworlddata/QA/AvroFilesInSingleFolder/ | Description |

  Scenario Outline: SC#14_3 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                        | jsonpath                    |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..Cluster.id               |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json   | $..has_Directory.id         |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..has_LinkerAnalysis.id    |
      | APPDBPOSTGRES | Default | cataloger/AvroS3Cataloger/AvroS3Catalog%DYN               |           | response/SnowflakeLinker_Lineage/avroItemIds.json | $..has_Analysis.id          |

  Scenario Outline: SC#14_4 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                   | inputFile                                         |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id               | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id         | response/SnowflakeLinker_Lineage/s3itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id          | response/SnowflakeLinker_Lineage/avroItemIds.json |

    #############################################################csv cataloger is ran without header and with header options in sequence############################################################################################################

  Scenario Outline: SC#15_1 Run the snowflakeCataloger, CSV S3 and the spectrumLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                              | body                                                            | response code | response message      | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                    | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                 | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig.json       | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                 | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                          | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                 | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonCSVS3DataSource                         | ida/SnowFlakeLinkerPayloads/AmazonCSVS3DataSourceConfig.json    | 204           |                       |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonCSVS3DataSource                         |                                                                 | 200           | AmazonCSVS3DataSource |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                | ida/SnowFlakeLinkerPayloads/CsvS3Cataloger.json                 | 204           |                       |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                 | 200           | CSVS3Cataloger        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='CSVS3Cataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/SnowFlakeLinkerPayloads/empty.json                          | 200           |                       |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='CSVS3Cataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger                                | ida/SnowFlakeLinkerPayloads/CsvS3Cataloger2.json                | 204           |                       |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CsvS3Cataloger                                |                                                                 | 200           | CSVS3Cataloger        |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='CSVS3Cataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*  | ida/SnowFlakeLinkerPayloads/empty.json                          | 200           |                       |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/* |                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='CSVS3Cataloger')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                             | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_WithoutFilters.json | 204           |                       |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                             |                                                                 | 200           | SnowflakeDBLinker     |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/* |                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='SnowflakeDBLinker')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*  | ida/SnowFlakeLinkerPayloads/empty.json                          | 200           |                       |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/* |                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='SnowflakeDBLinker')].status |


  Scenario:SC#15_2 user get all lineage hops id,s and get the source target value from database
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                                            | asg_scopeid | targetFile                                                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CsvExternalTableWithHeaderSinglefolder          |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CsvExternalTableWithHeaderMultiplefolder        |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CsvExternalTableWithoutHeaderFileFirstRowHeader |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CsvExternalTableWithoutHeaderSingleFolder       |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CsvExternalTableWithoutHeaderMultipleFolder     |             | response/SnowflakeLinker_Lineage/actualJsonFiles/fileCatalogers.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                                                             | path                                                              | response code | response message | jsonPath | targetFile                                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.CsvExternalTableWithHeaderSinglefolder          | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualCSVHeaderTrueAndFalseLineage.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.CsvExternalTableWithHeaderMultiplefolder        | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualCSVHeaderTrueAndFalseLineage.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.CsvExternalTableWithoutHeaderFileFirstRowHeader | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualCSVHeaderTrueAndFalseLineage.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.CsvExternalTableWithoutHeaderSingleFolder       | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualCSVHeaderTrueAndFalseLineage.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\SnowflakeLinker_Lineage\actualJsonFiles\fileCatalogers.json | $.lineagePayLoads.CsvExternalTableWithoutHeaderMultipleFolder     | 200           |                  | edges    | response\SnowflakeLinker_Lineage\actualJsonFiles\actualCSVHeaderTrueAndFalseLineage.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                   | JsonPath                                        |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderTrueAndFalseLineage.json | CsvExternalTableWithHeaderSinglefolder          |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderTrueAndFalseLineage.json | CsvExternalTableWithHeaderMultiplefolder        |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderTrueAndFalseLineage.json | CsvExternalTableWithoutHeaderFileFirstRowHeader |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderTrueAndFalseLineage.json | CsvExternalTableWithoutHeaderSingleFolder       |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderTrueAndFalseLineage.json | CsvExternalTableWithoutHeaderMultipleFolder     |


    ##7125638##
  Scenario Outline:SC#15_3 user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                           | actualJson                                                                                                 |
      | Constant.REST_DIR/response/SnowflakeLinker_Lineage/expectedJsonFiles/csvHeaderTrueAndFalseLineage.json | Constant.REST_DIR/response/SnowflakeLinker_Lineage/actualJsonFiles/actualCSVHeaderTrueAndFalseLineage.json |


  Scenario Outline: SC#15_4 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                      | jsonpath                       |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..Cluster.id                  |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json | $..has_Directory.id            |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_CatalogerAnalysis.id    |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json   | $..has_LinkerAnalysis.id       |
      | APPDBPOSTGRES | Default | cataloger/CsvS3Cataloger/CSVS3Cataloger%DYN               |           | response/amazonSpectrum/actual/itemIds.json     | $..has_CSVCatalogerAnalysis.id |

  Scenario Outline: SC#15_5 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                      | inputFile                                       |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id                  | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id            | response/SnowflakeLinker_Lineage/s3itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id       | response/SnowflakeLinker_Lineage/itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CSVCatalogerAnalysis.id | response/amazonSpectrum/actual/itemIds.json     |

    #######################################################Common cases#########################################################################################################################################
###########################################################DRY RUN##################################################################################################################################################################

  Scenario Outline: SC#16_1 Run the SnowflakeCataloger, File Cataloger (Json) and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                               | response code | response message            | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                       | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                    | 200           | SnowFlakeDS                 |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig.json          | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                    | 200           | SnowflakeJDBCCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                    | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                             | 200           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                    | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3DataSource                                                         | ida/SnowFlakeLinkerPayloads/AmazonJSONS3ValidDataSourceConfig.json | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3DataSource                                                         |                                                                    | 200           | AmazonJSONS3ValidDataSource |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                                          | ida/SnowFlakeLinkerPayloads/JsonS3Cataloger.json                   | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger                                                          |                                                                    | 200           | JsonS3Cataloger             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*                           |                                                                    | 200           | IDLE                        | $.[?(@.configurationName=='JsonS3Cataloger')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*                            | ida/SnowFlakeLinkerPayloads/empty.json                             | 200           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*                           |                                                                    | 200           | IDLE                        | $.[?(@.configurationName=='JsonS3Cataloger')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_DryRun.json            | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                    | 200           | SnowflakeDBLinker           |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                    | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                             | 200           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                    | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

    #Bug id MLP-24577
    ##7125629##
  @webtest
  Scenario: SC16_2# Verify Snowflake linker can run successfully when dry Run is true.
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowflakeDBLinker" and clicks on search
    And user performs "latest analysis click" in Item Results page for "linker/SnowflakeDBLinker/SnowflakeDBLinker/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/SnowflakeDBLinker/SnowflakeDBLinker%" should display below info/error/warning
      | type | logValue                                                                                                                                | logCode       | pluginName        | removableText |
      | INFO | Plugin SnowflakeDBLinker processed 2 items on dry run mode and not written to the repository                                            | ANALYSIS-0070 | SnowflakeDBLinker |               |
      | INFO | Plugin SnowflakeDBLinker Start Time:2020-07-10 03:58:56.127, End Time:2020-07-10 03:58:59.429, Processed Count:2, Errors:0, Warnings:14 | ANALYSIS-0072 | SnowflakeDBLinker |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:03.302)                                                                          | ANALYSIS-0020 | SnowflakeDBLinker |               |

  Scenario Outline: SC#16_3 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                        | jsonpath                    |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..Cluster.id               |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json   | $..has_Directory.id         |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..has_LinkerAnalysis.id    |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN             |           | response/SnowflakeLinker_Lineage/jsonItemIds.json | $..has_Analysis.id          |

  Scenario Outline: SC#16_4 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                   | inputFile                                         |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id               | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id         | response/SnowflakeLinker_Lineage/s3itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id          | response/SnowflakeLinker_Lineage/jsonItemIds.json |

    ####################################################log enhancements/processed items widget#######################################################################################################################################



  Scenario Outline: SC#17_2 Run the SnowflakeCataloger, File Cataloger (Json) and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                               | response code | response message            | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                       | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                    | 200           | SnowFlakeDS                 |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig.json          | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                    | 200           | SnowflakeJDBCCataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                    | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                             | 200           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                    | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3DataSource                                                         | ida/SnowFlakeLinkerPayloads/AmazonJSONS3ValidDataSourceConfig.json | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3DataSource                                                         |                                                                    | 200           | AmazonJSONS3ValidDataSource |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                                          | ida/SnowFlakeLinkerPayloads/JsonS3Cataloger.json                   | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/JsonS3Cataloger                                                          |                                                                    | 200           | JsonS3Cataloger             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*                           |                                                                    | 200           | IDLE                        | $.[?(@.configurationName=='JsonS3Cataloger')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*                            | ida/SnowFlakeLinkerPayloads/empty.json                             | 200           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*                           |                                                                    | 200           | IDLE                        | $.[?(@.configurationName=='JsonS3Cataloger')].status        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_WithoutFilters.json    | 204           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                    | 200           | SnowflakeDBLinker           |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                    | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                             | 200           |                             |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                    | 200           | IDLE                        | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

    ##7125631## ##7143254##
  @webtest
  Scenario: SC17_3# Verify log enhancements/processed items widget and count appears fine in analysis item of Snowflakelinker.
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowflakeDBLinker" and clicks on search
    And user performs "latest analysis click" in Item Results page for "linker/SnowflakeDBLinker/SnowflakeDBLinker/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/SnowflakeDBLinker/SnowflakeDBLinker%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | logCode       | pluginName        | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0019 |                   |                |
      | INFO | Plugin Name:SnowflakeDBLinker, Plugin Type:linker, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:f066aa47283b, Plugin Configuration name:SnowflakeDBLinker                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0071 | SnowflakeDBLinker | Plugin Version |
      | INFO | Plugin SnowflakeDBLinker Configuration: ---  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: name: "SnowflakeDBLinker"  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: pluginVersion: "LATEST"  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: label:  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: : ""  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: catalogName: "Default"  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: eventClass: null  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: eventCondition: null  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: nodeCondition: "name==\"LocalNode\""  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: maxWorkSize: 100  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: tags:  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: - "SnowFlakeLinker_UserDefined"  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: pluginType: "linker"  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: dataSource: null  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: credential: null  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: businessApplicationName: "SnowFlakeLinker_BA"  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: dryRun: false  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: schedule: null  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: filter: null  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: pluginName: "SnowflakeDBLinker"  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: queryBatchSize: 100  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: schemas: []  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: host: "asg_partner.us-east-1.snowflakecomputing.com"  2020-10-01 11:27:35.581 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: DatabaseName: "TEST_DB"  2020-10-01 11:27:35.582 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: runAfter: []  2020-10-01 11:27:35.582 INFO  - ANALYSIS-0073: Plugin SnowflakeDBLinker Configuration: type: "Linker" | ANALYSIS-0073 | SnowflakeDBLinker |                |
      | INFO | Plugin SnowflakeDBLinker Start Time:2020-08-07 10:08:27.347, End Time:2020-08-07 10:08:37.153, Processed Count:2, Errors:0, Warnings:17                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0072 | SnowflakeDBLinker |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:07.309)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0020 |                   |                |

    #######################################################technology tag,BA tag,User defined tag#######################################################################################################################################

  ##7125626##
  @webtest
  Scenario: SC18_1# Verify technology tag,BA tag,User defined tag are added for items processed by linker.
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonExternalTableMultipleFolder" and clicks on search
    Then the following tags "SnowFlake_Linker,SnowFlake_Linker,SnowFlakeLinker_BA,SnowFlakeLinker_UserDefined" should get displayed for the column "JsonExternalTableMultipleFolder"
    And user enters the search text "SnowflakeDBLinker" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SnowFlake_Linker,SnowFlake_Linker,SnowFlakeLinker_BA,SnowFlakeLinker_UserDefined" should get displayed for the column "JsonExternalTableMultipleFolder"

  Scenario Outline: SC#18_2 user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                      | type      | targetFile                                        | jsonpath                    |
      | APPDBPOSTGRES | Default | asg_partner.us-east-1.snowflakecomputing.com              |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..Cluster.id               |
      | APPDBPOSTGRES | Default | asgredshiftworlddata                                      | Directory | response/SnowflakeLinker_Lineage/s3itemIds.json   | $..has_Directory.id         |
      | APPDBPOSTGRES | Default | cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger%DYN |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..has_CatalogerAnalysis.id |
      | APPDBPOSTGRES | Default | linker/SnowflakeDBLinker/SnowflakeDBLinker%DYN            |           | response/SnowflakeLinker_Lineage/itemIds.json     | $..has_LinkerAnalysis.id    |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN             |           | response/SnowflakeLinker_Lineage/jsonItemIds.json | $..has_Analysis.id          |

  Scenario Outline: SC#18_3 user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson                   | inputFile                                         |
      | items/Default/Default.Cluster:::dynamic   | 204          | $..Cluster.id               | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id         | response/SnowflakeLinker_Lineage/s3itemIds.json   |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_CatalogerAnalysis.id | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_LinkerAnalysis.id    | response/SnowflakeLinker_Lineage/itemIds.json     |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id          | response/SnowflakeLinker_Lineage/jsonItemIds.json |

    #################################################Verify plugin version label in advanced settings################################################################################################################################

  #7143228
  @webtest
  Scenario: SC19# Verify technology tag,BA tag,User defined tag are added for items processed by linker.
    And User launch browser and traverse to login page
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
      | Type      | Cataloger            |
      | Plugin    | SnowflakeDBCataloger |
    And user should scroll to the left of the screen
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Plugin version |
##########################################################ORC Format testing #######################################################

  Scenario:Pre-Condition:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%             | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/%                   | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/%             | Analysis |       |       |
      | MultipleIDDelete | Default | linker/SnowflakeDBLinker/%                   | Analysis |       |       |
      | SingleItemDelete | Default | asg_partner.us-east-1.snowflakecomputing.com | Cluster  |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                        | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                | Cluster  |       |       |


  Scenario Outline: Pre-Condition_Run the SnowflakeCataloger, File Cataloger (orc) and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                              | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                      | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                   | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig_ORC.json     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                   | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3DataSource                                                          | ida/SnowFlakeLinkerPayloads/AmazonOrcS3ValidDataSourceConfig.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3DataSource                                                          |                                                                   | 200           | OrcS3DataSource        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger                                                           | ida/SnowFlakeLinkerPayloads/sc1OrcS3Cataloger.json                | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                           |                                                                   | 200           | OrcS3Cataloger         |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger               |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='OrcS3Cataloger')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger                | ida/SnowFlakeLinkerPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger               |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='OrcS3Cataloger')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_WithoutFilters.json   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                   | 200           | SnowflakeDBLinker      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC1 Verify snowflakelinker generated lineage between external table and avro directory if snowflake cataloger/OrcS3cataloger/snowflakelinker plugins are ran.(ORCfiles in single folder)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                         | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OrcExternalTableSingleFolder |             | response/ORC Linker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                                           | response code | response message | jsonPath | targetFile                                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\ORC Linker\bulkLineage.json | $.lineagePayLoads.OrcExternalTableSingleFolder | 200           |                  | edges    | response\ORC Linker\ActualLineage\actualLineagehops_OrcExternalTableSingleFolder.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                | JsonPath                     |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableSingleFolder.json | OrcExternalTableSingleFolder |
    And user sort the json file using the following value
      | fileName                                                                                                | JsonPath                     | value  |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableSingleFolder.json | OrcExternalTableSingleFolder | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Linker" and clicks on search
    And user performs "facet selection" in "SnowFlake_Linker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OrcExternalTableSingleFolder" item from search results
    Then user performs click and verify in new window
      | Table            | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | ORCFilesinSingleFolder | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                               | actual_json                                                                                             | item                         |
      | Constant.REST_DIR/response/ORC Linker/ExpectedLineage/expectedLineagehops_OrcExternalTableSingleFolder.json | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableSingleFolder.json | OrcExternalTableSingleFolder |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC2 Verify snowflakelinker generated lineage between external table and avro directory if snowflake cataloger/OrcS3cataloger/snowflakelinker plugins are ran.(ORCfiles in Multiple folder)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                           | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OrcExternalTableMultipleFolder |             | response/ORC Linker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                                             | response code | response message | jsonPath | targetFile                                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\ORC Linker\bulkLineage.json | $.lineagePayLoads.OrcExternalTableMultipleFolder | 200           |                  | edges    | response\ORC Linker\ActualLineage\actualLineagehops_OrcExternalTableMultipleFolder.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                  | JsonPath                       |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableMultipleFolder.json | OrcExternalTableMultipleFolder |
    And user sort the json file using the following value
      | fileName                                                                                                  | JsonPath                       | value  |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableMultipleFolder.json | OrcExternalTableMultipleFolder | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Linker" and clicks on search
    And user performs "facet selection" in "SnowFlake_Linker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OrcExternalTableMultipleFolder" item from search results
    Then user performs click and verify in new window
      | Table            | value                    | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | ORCFilesinMultipleFolder | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                                 | actual_json                                                                                               | item                           |
      | Constant.REST_DIR/response/ORC Linker/ExpectedLineage/expectedLineagehops_OrcExternalTableMultipleFolder.json | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableMultipleFolder.json | OrcExternalTableMultipleFolder |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC3 Verify snowflakelinker generated lineage between external table and avro directory if snowflake cataloger/OrcS3cataloger/snowflakelinker plugins are ran.(ORCfiles in Combination folder)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                              | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OrcExternalTableCombinationFolder |             | response/ORC Linker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                                                | response code | response message | jsonPath | targetFile                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\ORC Linker\bulkLineage.json | $.lineagePayLoads.OrcExternalTableCombinationFolder | 200           |                  | edges    | response\ORC Linker\ActualLineage\actualLineagehops_OrcExternalTableCombinationFolder.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                     | JsonPath                          |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableCombinationFolder.json | OrcExternalTableCombinationFolder |
    And user sort the json file using the following value
      | fileName                                                                                                     | JsonPath                          | value  |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableCombinationFolder.json | OrcExternalTableCombinationFolder | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Linker" and clicks on search
    And user performs "facet selection" in "SnowFlake_Linker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OrcExternalTableCombinationFolder" item from search results
    Then user performs click and verify in new window
      | Table            | value                       | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | ORCFilesinCombinationFolder | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                                    | actual_json                                                                                                  | item                              |
      | Constant.REST_DIR/response/ORC Linker/ExpectedLineage/expectedLineagehops_OrcExternalTableCombinationFolder.json | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableCombinationFolder.json | OrcExternalTableCombinationFolder |

  Scenario:Post-Condition:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%             | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/%                   | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/%             | Analysis |       |       |
      | MultipleIDDelete | Default | linker/SnowflakeDBLinker/%                   | Analysis |       |       |
      | SingleItemDelete | Default | asg_partner.us-east-1.snowflakecomputing.com | Cluster  |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                        | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                | Cluster  |       |       |

  Scenario Outline: Pre-Condition1:Run the SnowflakeCataloger, AmazonS3 caltaloger ,File Cataloger (orc) and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                              | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                      | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                   | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig_ORC.json     | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                   | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                                                       | ida/SnowFlakeLinkerPayloads/AmazonS3DataSourceConfig.json         | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                                                       |                                                                   | 200           | AmazonS3DataSource     |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                        | ida/SnowFlakeLinkerPayloads/AmazonS3Cataloger_Configuration.json  | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                        |                                                                   | 200           | AmazonS3Cataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*                          | ida/SnowFlakeLinkerPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3DataSource                                                          | ida/SnowFlakeLinkerPayloads/AmazonOrcS3ValidDataSourceConfig.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3DataSource                                                          |                                                                   | 200           | OrcS3DataSource        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger                                                           | ida/SnowFlakeLinkerPayloads/sc1OrcS3Cataloger.json                | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                           |                                                                   | 200           | OrcS3Cataloger         |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger               |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='OrcS3Cataloger')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger                | ida/SnowFlakeLinkerPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger               |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='OrcS3Cataloger')].status         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_OnlyTables_ORC.json   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                   | 200           | SnowflakeDBLinker      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                            | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                   | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC4 Verify snowflakelinker generated lineage between external table and avro directory if snowflake cataloger/s3cataloger/OrcS3cataloger/snowflakelinker plugins are ran.(ORCfiles in single folder)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                         | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OrcExternalTableSingleFolder |             | response/ORC Linker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                                           | response code | response message | jsonPath | targetFile                                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\ORC Linker\bulkLineage.json | $.lineagePayLoads.OrcExternalTableSingleFolder | 200           |                  | edges    | response\ORC Linker\ActualLineage\actualLineagehops_OrcExternalTableSingleFolder1.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                 | JsonPath                     |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableSingleFolder1.json | OrcExternalTableSingleFolder |
    And user sort the json file using the following value
      | fileName                                                                                                 | JsonPath                     | value  |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableSingleFolder1.json | OrcExternalTableSingleFolder | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Linker" and clicks on search
    And user performs "facet selection" in "SnowFlake_Linker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OrcExternalTableSingleFolder" item from search results
    Then user performs click and verify in new window
      | Table            | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | ORCFilesinSingleFolder | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                               | actual_json                                                                                              | item                         |
      | Constant.REST_DIR/response/ORC Linker/ExpectedLineage/expectedLineagehops_OrcExternalTableSingleFolder.json | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableSingleFolder1.json | OrcExternalTableSingleFolder |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC5 Verify snowflakelinker generated lineage between external table and avro directory if snowflake cataloger/s3cataloger/OrcS3cataloger/snowflakelinker plugins are ran.(ORCfiles in Multiple folder)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                           | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OrcExternalTableMultipleFolder |             | response/ORC Linker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                                             | response code | response message | jsonPath | targetFile                                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\ORC Linker\bulkLineage.json | $.lineagePayLoads.OrcExternalTableMultipleFolder | 200           |                  | edges    | response\ORC Linker\ActualLineage\actualLineagehops_OrcExternalTableMultipleFolder1.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                   | JsonPath                       |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableMultipleFolder1.json | OrcExternalTableMultipleFolder |
    And user sort the json file using the following value
      | fileName                                                                                                   | JsonPath                       | value  |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableMultipleFolder1.json | OrcExternalTableMultipleFolder | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Linker" and clicks on search
    And user performs "facet selection" in "SnowFlake_Linker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OrcExternalTableMultipleFolder" item from search results
    Then user performs click and verify in new window
      | Table            | value                    | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | ORCFilesinMultipleFolder | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                                 | actual_json                                                                                                | item                           |
      | Constant.REST_DIR/response/ORC Linker/ExpectedLineage/expectedLineagehops_OrcExternalTableMultipleFolder.json | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableMultipleFolder1.json | OrcExternalTableMultipleFolder |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC6 Verify snowflakelinker generated lineage between external table and avro directory if snowflake cataloger/s3cataloger/OrcS3cataloger/snowflakelinker plugins are ran.(ORCfiles in Combination folder)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                              | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OrcExternalTableCombinationFolder |             | response/ORC Linker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                                                | response code | response message | jsonPath | targetFile                                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\ORC Linker\bulkLineage.json | $.lineagePayLoads.OrcExternalTableCombinationFolder | 200           |                  | edges    | response\ORC Linker\ActualLineage\actualLineagehops_OrcExternalTableCombinationFolder1.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                      | JsonPath                          |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableCombinationFolder1.json | OrcExternalTableCombinationFolder |
    And user sort the json file using the following value
      | fileName                                                                                                      | JsonPath                          | value  |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableCombinationFolder1.json | OrcExternalTableCombinationFolder | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Linker" and clicks on search
    And user performs "facet selection" in "SnowFlake_Linker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OrcExternalTableCombinationFolder" item from search results
    Then user performs click and verify in new window
      | Table            | value                       | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | ORCFilesinCombinationFolder | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                                    | actual_json                                                                                                   | item                              |
      | Constant.REST_DIR/response/ORC Linker/ExpectedLineage/expectedLineagehops_OrcExternalTableCombinationFolder.json | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableCombinationFolder1.json | OrcExternalTableCombinationFolder |

  Scenario:Post-Condition1:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%             | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/%                   | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/%             | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                | Analysis |       |       |
      | MultipleIDDelete | Default | linker/SnowflakeDBLinker/%                   | Analysis |       |       |
      | SingleItemDelete | Default | asg_partner.us-east-1.snowflakecomputing.com | Cluster  |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                        | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                | Cluster  |       |       |

  Scenario Outline: Pre-Condition2:Run the SnowflakeCataloger, s3 cataloger and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                      | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBDataSource                                                    | ida/SnowFlakeLinkerPayloads/SnowflakeDS.json                              | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBDataSource                                                    |                                                                           | 200           | SnowFlakeDS            |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBCataloger                                                     | ida/SnowFlakeLinkerPayloads/SnowflakeCatalogerConfig_ORC.json             | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBCataloger                                                     |                                                                           | 200           | SnowflakeJDBCCataloger |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger  | ida/SnowFlakeLinkerPayloads/empty.json                                    | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SnowflakeJDBCCataloger |                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeJDBCCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                                                       | ida/SnowFlakeLinkerPayloads/AmazonS3DataSourceConfig.json                 | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                                                       |                                                                           | 200           | AmazonS3DataSource     |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                                        | ida/SnowFlakeLinkerPayloads/AmazonS3Cataloger_Configuration.json          | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                        |                                                                           | 200           | AmazonS3Cataloger      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*                          | ida/SnowFlakeLinkerPayloads/empty.json                                    | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3Cataloger')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SnowflakeDBLinker                                                        | ida/SnowFlakeLinkerPayloads/SnowflakeLinker_NormalExternalTables_ORC.json | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SnowflakeDBLinker                                                        |                                                                           | 200           | SnowflakeDBLinker      |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/linker/SnowflakeDBLinker/*                             | ida/SnowFlakeLinkerPayloads/empty.json                                    | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/linker/SnowflakeDBLinker/*                            |                                                                           | 200           | IDLE                   | $.[?(@.configurationName=='SnowflakeDBLinker')].status      |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC7 Verify snowflakelinker generated lineage between external table and avro directory if snowflake cataloger/s3cataloger/snowflakelinker plugins are ran.(ORCfiles in single folder)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                         | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OrcExternalTableSingleFolder |             | response/ORC Linker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                                           | response code | response message | jsonPath | targetFile                                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\ORC Linker\bulkLineage.json | $.lineagePayLoads.OrcExternalTableSingleFolder | 200           |                  | edges    | response\ORC Linker\ActualLineage\actualLineagehops_OrcExternalTableSingleFolder2.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                 | JsonPath                     |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableSingleFolder2.json | OrcExternalTableSingleFolder |
    And user sort the json file using the following value
      | fileName                                                                                                 | JsonPath                     | value  |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableSingleFolder2.json | OrcExternalTableSingleFolder | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Linker" and clicks on search
    And user performs "facet selection" in "SnowFlake_Linker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OrcExternalTableSingleFolder" item from search results
    Then user performs click and verify in new window
      | Table            | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | ORCFilesinSingleFolder | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                                          | actual_json                                                                                              | item                         |
      | Constant.REST_DIR/response/ORC Linker/ExpectedLineage/expectedLineagehops_OrcExternalTableSingleFolder_dirLineage.json | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableSingleFolder2.json | OrcExternalTableSingleFolder |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC8 Verify snowflakelinker generated lineage between external table and avro directory if snowflake cataloger/s3cataloger/snowflakelinker plugins are ran.(ORCfiles in Multiple folder)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                           | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OrcExternalTableMultipleFolder |             | response/ORC Linker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                                             | response code | response message | jsonPath | targetFile                                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\ORC Linker\bulkLineage.json | $.lineagePayLoads.OrcExternalTableMultipleFolder | 200           |                  | edges    | response\ORC Linker\ActualLineage\actualLineagehops_OrcExternalTableMultipleFolder2.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                   | JsonPath                       |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableMultipleFolder2.json | OrcExternalTableMultipleFolder |
    And user sort the json file using the following value
      | fileName                                                                                                   | JsonPath                       | value  |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableMultipleFolder2.json | OrcExternalTableMultipleFolder | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Linker" and clicks on search
    And user performs "facet selection" in "SnowFlake_Linker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OrcExternalTableMultipleFolder" item from search results
    Then user performs click and verify in new window
      | Table            | value                    | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | ORCFilesinMultipleFolder | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                                            | actual_json                                                                                                | item                           |
      | Constant.REST_DIR/response/ORC Linker/ExpectedLineage/expectedLineagehops_OrcExternalTableMultipleFolder_dirLineage.json | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableMultipleFolder2.json | OrcExternalTableMultipleFolder |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC9 Verify snowflakelinker generated lineage between external table and avro directory if snowflake cataloger/s3cataloger/snowflakelinker plugins are ran.(ORCfiles in Combination folder)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                              | asg_scopeid | targetFile                           | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | OrcExternalTableCombinationFolder |             | response/ORC Linker/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                             | path                                                | response code | response message | jsonPath | targetFile                                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\ORC Linker\bulkLineage.json | $.lineagePayLoads.OrcExternalTableCombinationFolder | 200           |                  | edges    | response\ORC Linker\ActualLineage\actualLineagehops_OrcExternalTableCombinationFolder2.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                                                                      | JsonPath                          |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableCombinationFolder2.json | OrcExternalTableCombinationFolder |
    And user sort the json file using the following value
      | fileName                                                                                                      | JsonPath                          | value  |
      | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableCombinationFolder2.json | OrcExternalTableCombinationFolder | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlake_Linker" and clicks on search
    And user performs "facet selection" in "SnowFlake_Linker" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OrcExternalTableCombinationFolder" item from search results
    Then user performs click and verify in new window
      | Table            | value                       | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | ORCFilesinCombinationFolder | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                                                                               | actual_json                                                                                                   | item                              |
      | Constant.REST_DIR/response/ORC Linker/ExpectedLineage/expectedLineagehops_OrcExternalTableCombinationFolder_dirLineage.json | Constant.REST_DIR/response/ORC Linker/ActualLineage/actualLineagehops_OrcExternalTableCombinationFolder2.json | OrcExternalTableCombinationFolder |

    ############################################Common Case for ORC validation in snowflake Linker#######################################

  @webtest
  Scenario:SC#10:Verify processed items widget and count appears fine in analysis item of Snowflake linker.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowFlakeLinker_BA" and clicks on search
    And user performs "latest analysis click" in Item Results page for "linker/SnowflakeDBLinker/SnowflakeDBLinker%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/SnowflakeDBLinker/SnowflakeDBLinker%" should display below info/error/warning
      | type | logValue                                                                                                                               | logCode       | pluginName        | removableText |
      | INFO | Plugin SnowflakeDBLinker Start Time:2020-09-09 12:06:03.676, End Time:2020-09-09 12:06:05.281, Processed Count:2, Errors:0, Warnings:0 | ANALYSIS-0072 | SnowflakeDBLinker |               |

  Scenario:Commoncase#MLP_24889_Verify Technology tag and Explicit tag
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                                  | ServiceName | DatabaseName | SchemaName          | TableName/Filename           | Column   | Tags                       | Query                 | Action      |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | OrcExternalTableSingleFolder | USERNAME | SnowFlake_Linker,Snowflake | ColumnQuerywithSchema | TagAssigned |
      | asg_partner.us-east-1.snowflakecomputing.com | Snowflake   | TEST_DB      | TEST_SNOWSchemaAuto | OrcExternalTableSingleFolder |          | SnowFlake_Linker,Snowflake | TableQuerywithSchema  | TagAssigned |


  Scenario:Post-Condition2:Delete cataloger and Analyzer analysis , tables and BussinessApllication
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type                | query | param |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%             | Analysis            |       |       |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/%                   | Analysis            |       |       |
      | MultipleIDDelete | Default | cataloger/SnowflakeDBCataloger/%             | Analysis            |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/%                | Analysis            |       |       |
      | MultipleIDDelete | Default | linker/SnowflakeDBLinker/%                   | Analysis            |       |       |
      | SingleItemDelete | Default | asg_partner.us-east-1.snowflakecomputing.com | Cluster             |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                        | Cluster             |       |       |
      | SingleItemDelete | Default | amazonaws.com                                | Cluster             |       |       |
      | SingleItemDelete | Default | SnowFlakeLinker_BA                           | BusinessApplication |       |       |

    #########################################################Delete Configurations and Credentials##################################################################################################################################################################################

  Scenario Outline:SC#20_Delete plugin Configurations and credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                               | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Spec_ValidParquetCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Spec_ValidJSONCredentials    |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Spec_ValidAVROCredentials    |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Spec_AWS_CSV_Credentials     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/SnowFlake_Credentials        |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/OrcS3_ValidJSONCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/AWS_Amazon_Credentials       |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonS3DataSource             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AmazonS3Cataloger              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SnowflakeDBDataSource          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SnowflakeDBCataloger           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AvroS3DataSource               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AvroS3Cataloger                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/ParquetS3DataSource            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/ParquetS3Cataloger             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JsonS3DataSource               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/JsonS3Cataloger                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CsvS3DataSource                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CsvS3Cataloger                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OrcS3DataSource                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OrcS3Cataloger                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SnowflakeDBLinker              |      | 204           |                  |          |
