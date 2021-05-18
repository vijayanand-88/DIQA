@MLP-20549
Feature: Glue linker plugin which can link Glue tables to external file

  #################################PreConditions################################
  @MLP-20549 @GlueLinker
  Scenario: SC1#Update AWS secret key and access from config file
    Given User update the below "aws credentials" in following files using json path
      | filePath                                                         | accessKeyPath                           | secretKeyPath                           |
      | ida/amazonGlueLinkerPayloads/Credentials/awsGlueCredentials.json | $.glueLinkerValidCredentials..accessKey | $.glueLinkerValidCredentials..secretKey |
      | ida/amazonGlueLinkerPayloads/Credentials/awsGlueCredentials.json | $.glueS3Credentials..accessKey          | $.glueS3Credentials..secretKey          |
      | ida/amazonGlueLinkerPayloads/Credentials/awsGlueCredentials.json | $.glueCSVCredentials..accessKey         | $.glueCSVCredentials..secretKey         |
    And User update the below "Glue Readonly credentials" in following files using json path
      | filePath                                                         | accessKeyPath                       | secretKeyPath                       |
      | ida/amazonGlueLinkerPayloads/Credentials/awsGlueCredentials.json | $.glueParquetCredentials..accessKey | $.glueParquetCredentials..secretKey |


  @MLP-20549 @GlueLinker
  Scenario Outline: SC1#-Set the Credentials for AWSGlueDatasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                               | bodyFile                                                                            | path                                           | response code | response message          | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGlueLinkerCredentials                   | payloads/ida/amazonGlueLinkerPayloads/credentials/awsGlueCredentials.json           | $.glueLinkerValidCredentials                   | 200           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/InvalidGlueLinkerCredentials                 | payloads/ida/amazonGlueLinkerPayloads/credentials/awsGlueCredentials.json           | $.glueLinkerInvalidCredentials                 | 200           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EmptyGlueLinkerCredentials                   | payloads/ida/amazonGlueLinkerPayloads/credentials/awsGlueCredentials.json           | $.glueLinkerEmptyCredentials                   | 200           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/InvalidGlueLinkerCredentialsInvalidSecretKey | payloads/ida/amazonGlueLinkerPayloads/credentials/awsGlueCredentials.json           | $.glueLinkerInvalidCredentialsInvalidSecretkey | 200           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGlueLinkerS3Credentials                 | payloads/ida/amazonGlueLinkerPayloads/credentials/awsGlueCredentials.json           | $.glueS3Credentials                            | 200           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidGlueLinkerCSVCredentials                | payloads/ida/amazonGlueLinkerPayloads/credentials/awsGlueCredentials.json           | $.glueCSVCredentials                           | 200           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/ValidParquetCredentials                      | payloads/ida/amazonGlueLinkerPayloads/credentials/awsGlueCredentials.json           | $.glueParquetCredentials                       | 200           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidGlueLinkerCredentials                   |                                                                                     |                                                | 200           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/InvalidGlueLinkerCredentials                 |                                                                                     |                                                | 200           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EmptyGlueLinkerCredentials                   |                                                                                     |                                                | 200           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/InvalidGlueLinkerCredentialsInvalidSecretKey |                                                                                     |                                                | 200           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidGlueLinkerS3Credentials                 |                                                                                     |                                                | 200           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidGlueLinkerCSVCredentials                |                                                                                     |                                                | 200           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/ValidParquetCredentials                      |                                                                                     |                                                | 200           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AWSGlueDataSource                              | payloads/ida/amazonGlueLinkerPayloads/DataSource/AmazonGlueCatalogerDataSource.json | $.AWSGlueDataSource                            | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AWSGlueDataSource                              |                                                                                     |                                                | 200           | AWSGlueDataSource         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonS3DataSource                             | payloads/ida/amazonGlueLinkerPayloads/DataSource/AmazonGlueCatalogerDataSource.json | $.AWSGlueS3DataSource                          | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonS3DataSource                             |                                                                                     |                                                | 200           | AWSGlueLinkerS3DataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CsvS3DataSource                                | payloads/ida/amazonGlueLinkerPayloads/DataSource/AmazonGlueCatalogerDataSource.json | $.AWSGlueCSVDataSource                         | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CsvS3DataSource                                |                                                                                     |                                                | 200           | AmazonGlueCSVDataSource   |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/JsonS3DataSource                               | payloads/ida/amazonGlueLinkerPayloads/DataSource/AmazonGlueCatalogerDataSource.json | $.AWSGlueJsonDataSource                        | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/JsonS3DataSource                               |                                                                                     |                                                | 200           | AWSGlueJsonDataSource     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/ParquetS3DataSource                            | payloads/ida/amazonGlueLinkerPayloads/DataSource/AmazonGlueCatalogerDataSource.json | $.AWSGlueParquetDataSource                     | 204           |                           |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/ParquetS3DataSource                            |                                                                                     |                                                | 200           | AWSGlueParquetDataSource  |          |


  Scenario:Precondition_Create new Database and table in Glue DB using AWSGlueUtil with header csv file
    Given user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                                  |
      | createDatabase | ida/amazonGlueLinkerPayloads/glueData/createDatabase.json |


  Scenario:Precondition_Create a bucket with files for Glue linker plugin
    Given user "Create" a bucket "asgqagluelinkerbucket" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName            | keyPrefix  | dirPath                                              | recursive |
      | asgqagluelinkerbucket | GlueLinker | ida/amazonGlueLinkerPayloads/externalData/GlueLinker | true      |



    #############################################7052936_withheader_CSV_Run###########################################
  Scenario:SC1#_Create new Database and table in Glue DB using AWSGlueUtil with header csv file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                         |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithHeader.json |

  @MLP-20549 @GlueLinker
  Scenario Outline:SC1#_Run Glue,S3,CSV Cataloger and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                | bodyFile                                                                  | path               | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc01_PluginConfig.json | $.AWSGlueCataloger | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                           |                    | 200           | GlueLinkerCataloger |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                  | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc01_PluginConfig.json | $.CsvS3Cataloger   | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CsvS3Cataloger                                  |                                                                           |                    | 200           | CSVGlueCataloger    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                   | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc01_PluginConfig.json | $.AWSGlueLinker    | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                   |                                                                           |                    | 200           | GlueLinker          |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*   |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='CSVGlueCataloger')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*    |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*   |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='CSVGlueCataloger')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*       |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinker')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*       |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinker')].status          |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC1 Verify glue linker creates lineage between glue table and CSV file(with header) and column to field if external location is file.(if CSVS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name       | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | gluelinker |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                         | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.gluelinker | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath   |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath   | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "gluelinker" and clicks on search
    And user performs "facet selection" in "AWSGlueCataloger_BA" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "gluelinker" item from search results
    Then user performs click and verify in new window
      | Table            | value                | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | BasicdatatypesWH.csv | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                          | actual_json                                               | item       |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker |


  @MLP-20549 @GlueLinker
  Scenario:SC1:Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;          | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                   | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/CsvS3Cataloger/CSVGlueCataloger%      | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                | Analysis |       |       |

  Scenario:SC1#User delete the table
    And user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName  |
      | deleteTable | qagluelinkerdatabase | glueLinker |


  ####################################7052937_withoutheader_CSV_Run###########################

  Scenario:SC2#Create new Database and table in Glue DB using AWSGlueUtil without header csv file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                            |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithoutHeader.json |


  @MLP-20549 @GlueLinker
  Scenario Outline:SC2#_Run Glue,S3,CSV Cataloger and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                | bodyFile                                                                  | path               | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc02_PluginConfig.json | $.AWSGlueCataloger | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                           |                    | 200           | GlueLinkerCataloger |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                  | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc02_PluginConfig.json | $.CsvS3Cataloger   | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CsvS3Cataloger                                  |                                                                           |                    | 200           | CSVGlueCataloger    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                   | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc02_PluginConfig.json | $.AWSGlueLinker    | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                   |                                                                           |                    | 200           | GlueLinker          |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*   |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='CSVGlueCataloger')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*    |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*   |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='CSVGlueCataloger')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*       |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinker')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*       |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinker')].status          |


  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC2 Verify glue linker creates lineage between glue table and CSV file(without header) and column to field if external location is file.(if CSVS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name       | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | gluelinker |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                         | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.gluelinker | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath   |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath   | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value                 | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | BasicdatatypesWOH.csv | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                             | actual_json                                               | item       |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpectedWOH.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker |


  @MLP-20549 @GlueLinker
  Scenario:SC2:Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;          | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                   | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/CsvS3Cataloger/CSVGlueCataloger%      | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                | Analysis |       |       |


  Scenario:SC2#User delete the table
    And user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName  |
      | deleteTable | qagluelinkerdatabase | glueLinker |


      #############################################7052938_MultipleCSVFileDirectory_CSV_Run###########################################

  Scenario:SC3#Create new Database and table location with multiple csv files directory in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                            |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithMultipleCSVFilesDirectory.json |

  @MLP-20549 @GlueLinker
  Scenario Outline:SC3#_Run Glue,S3,CSV Cataloger and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                | bodyFile                                                                  | path               | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc03_PluginConfig.json | $.AWSGlueCataloger | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                           |                    | 200           | GlueLinkerCataloger |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                  | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc03_PluginConfig.json | $.CsvS3Cataloger   | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CsvS3Cataloger                                  |                                                                           |                    | 200           | CSVGlueCataloger    |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                   | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc03_PluginConfig.json | $.AWSGlueLinker    | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                   |                                                                           |                    | 200           | GlueLinker          |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*   |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='CSVGlueCataloger')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*    |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*   |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='CSVGlueCataloger')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*       |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinker')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*       |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinker')].status          |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC3 Verify glue linker creates lineage between glue table and CSV file(without header) and column to field if external location is file.(if CSVS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name       | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | gluelinker |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                         | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.gluelinker | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath   |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath   | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value            | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | MultipleCSVFiles | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                              | actual_json                                               | item       |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC3.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker |

  @MLP-20549 @GlueLinker
  Scenario:SC3:Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;          | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                   | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/CsvS3Cataloger/CSVGlueCataloger%      | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                | Analysis |       |       |

  Scenario:SC3#User delete the table
    And user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName  |
      | deleteTable | qagluelinkerdatabase | glueLinker |


      #############################################7052939_MultipleCSVFileDirectory_S3_Run###########################################

  Scenario:SC4#Create new Database and table with mutliple csv files directory in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                            |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithMultipleCSVFilesDirectory.json |

  @MLP-20549 @GlueLinker
  Scenario Outline:SC4#_Run Glue,S3,CSV Cataloger and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc04_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc04_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc04_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |


  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC4 Verify glue linker creates lineage between glue table and Directory if external location is directory and directory has multiple CSV file(if S3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name       | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | gluelinker |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                         | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.gluelinker | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath   |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath   | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value            | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | MultipleCSVFiles | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                              | actual_json                                               | item       |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC4.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker |


  @MLP-20549 @GlueLinker
  Scenario:SC4:Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;             | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                   | Analysis |       |       |

  Scenario:SC4#User delete the table
    And user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName  |
      | deleteTable | qagluelinkerdatabase | glueLinker |


      #############################################7052940_withheader_S3_CSV_Run###########################################
  @MLP-20549 @GlueLinker
  Scenario:SC5#_Create new Database and table in Glue DB using AWSGlueUtil with header csv file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                         |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithHeader.json |


  @MLP-20549 @GlueLinker
  Scenario Outline:SC5#_Run Glue,S3,CSV Cataloger and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc05_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc05_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                   | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc05_PluginConfig.json | $.CsvS3Cataloger    | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CsvS3Cataloger                                   |                                                                           |                     | 200           | CSVGlueCataloger      |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc05_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*    |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='CSVGlueCataloger')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*     |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*    |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='CSVGlueCataloger')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |


  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC5# Verify glue linker creates lineage between glue table and CSV file(with header) and column to field if external location is file.(if S3cataloger and CSVS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name       | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | gluelinker |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                         | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.gluelinker | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath   |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath   | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value                | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | BasicdatatypesWH.csv | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                              | actual_json                                               | item       |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC5.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker |


  @MLP-20549 @GlueLinker
  Scenario:SC5# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;             | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                   | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/CsvS3Cataloger/CSVGlueCataloger%         | Analysis |       |       |

  Scenario:SC5#User delete the table
    And user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName  |
      | deleteTable | qagluelinkerdatabase | glueLinker |


      ####################################7052941 _withoutheader_S3_CSV_Run###########################

  Scenario:SC6#Create new Database and table in Glue DB using AWSGlueUtil without header csv file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                            |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithoutHeader.json |


  @MLP-20549 @GlueLinker
  Scenario Outline:SC6#_Run Glue,S3,CSV Cataloger and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc06_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc06_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                   | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc06_PluginConfig.json | $.CsvS3Cataloger    | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CsvS3Cataloger                                   |                                                                           |                     | 200           | CSVGlueCataloger      |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc06_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*    |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='CSVGlueCataloger')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*     |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*    |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='CSVGlueCataloger')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |


  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC6# Verify glue linker creates lineage between glue table and CSV file(without header) and column to field if external location is file.(if S3cataloger and CSVS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name       | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | gluelinker |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                         | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.gluelinker | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath   |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath   | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value                 | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | BasicdatatypesWOH.csv | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                              | actual_json                                               | item       |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC6.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker |


  @MLP-20549 @GlueLinker
  Scenario:SC6# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;             | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                   | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/CsvS3Cataloger/CSVGlueCataloger%         | Analysis |       |       |

  Scenario:SC6#User delete the table
    And user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName  |
      | deleteTable | qagluelinkerdatabase | glueLinker |


          #############################################7052942_MultipleCSVFileDirectory_S3_CSV_Run###########################################


  Scenario:SC7#Create new Database and table location with multiple files directory in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                            |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithMultipleCSVFilesDirectory.json |

  @MLP-20549 @GlueLinker
  Scenario Outline:SC7#_Run Glue,S3,CSV Cataloger and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc07_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc07_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger                                   | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc07_PluginConfig.json | $.CsvS3Cataloger    | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CsvS3Cataloger                                   |                                                                           |                     | 200           | CSVGlueCataloger      |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc07_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*    |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='CSVGlueCataloger')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/*     |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/*    |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='CSVGlueCataloger')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |


  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC7# Verify glue linker creates lineage between glue table and Directory having multiple CSV files and column to field.(with or without header) if external location is directory.(if S3Cataloger and CSVS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name       | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | gluelinker |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                         | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.gluelinker | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath   |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath   | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value            | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | MultipleCSVFiles | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                              | actual_json                                               | item       |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC7.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluelinker |


  @MLP-20549 @GlueLinker
  Scenario:SC7# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;             | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                   | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/CsvS3Cataloger/CSVGlueCataloger%         | Analysis |       |       |

  Scenario:SC7#User delete the table
    And user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName  |
      | deleteTable | qagluelinkerdatabase | glueLinker |


        ##############################7052943_GlueTable_RedshiftTable_lineage#################################

  @MLP-20549 @GlueLinker
  Scenario:SC8#Create new Database and table in Glue DB using AWSGlueUtil with redshift table connection
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                 |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithRedshiftColumn.json |

  Scenario Outline: SC8#Set the Credentials,Datasource and run glue redshift cataloger plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                           | bodyFile                                                                            | path                        | response code | response message       | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/ValidRedshiftGlueCredentials                                             | payloads/ida/amazonGlueLinkerPayloads/credentials/awsGlueCredentials.json           | $.amazonRedshiftCredentials | 200           |                        |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/ValidRedshiftGlueCredentials                                             |                                                                                     |                             | 200           |                        |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonRedshiftDataSource                                                   | payloads/ida/amazonGlueLinkerPayloads/DataSource/AmazonGlueCatalogerDataSource.json | $.RedshiftDataSource        | 204           |                        |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonRedshiftDataSource                                                   |                                                                                     |                             | 200           | RedshiftGlueDataSource |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueCataloger                                                           | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc08_PluginConfig.json           | $.AWSGlueCataloger          | 204           |                        |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                                           |                                                                                     |                             | 200           | GlueLinkerCataloger    |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonRedshiftCataloger                                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc08_PluginConfig.json           | $.RedshiftGlueCataloger     | 204           |                        |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonRedshiftCataloger                                                    |                                                                                     |                             | 200           | RedShiftGlueCataloger  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                                              | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc08_PluginConfig.json           | $.AWSGlueLinker             | 204           |                        |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                                              |                                                                                     |                             | 200           | GlueLinker             |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*                            |                                                                                     |                             | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*                             |                                                                                     |                             | 200           |                        |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*                            |                                                                                     |                             | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftGlueCataloger |                                                                                     |                             | 200           | IDLE                   | $.[?(@.configurationName=='RedShiftGlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftGlueCataloger  |                                                                                     |                             | 200           |                        |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftGlueCataloger |                                                                                     |                             | 200           | IDLE                   | $.[?(@.configurationName=='RedShiftGlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*                                  |                                                                                     |                             | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*                                   |                                                                                     |                             | 200           |                        |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*                                  |                                                                                     |                             | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinker')].status            |


  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC8#Verify glue linker creates lineage between glue table and Redshift Table and column to column if external location is Table.
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name              | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueredshifttable |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                                | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueredshifttable | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath          |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueredshifttable |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath          | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueredshifttable | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value     | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | customers | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                              | actual_json                                               | item              |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC8.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueredshifttable |


  @MLP-20549 @GlueLinker
  Scenario:SC8# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;                           | Cluster  |       |       |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%                  | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonRedshiftCataloger/RedShiftGlueCataloger%         | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                                 | Analysis |       |       |

  Scenario:SC8#User delete the table
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName         |
      | deleteTable | qagluelinkerdatabase | glueRedshiftTable |



            ##############################7052944 _GlueTable_Dynamo_Table_lineage#################################


  Scenario:SC9# Create a dynamoDB table
    Given user connects to AWS Dynamo database and perform the following operation
      | action      | jsonPath                                                     |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/CreateDynamoTable.json |
    And user connects to AWS Dynamo database and perform the following operation
      | action     | tableName  | jsonPath                                                      |
      | createItem | GlueSource | ida/amazonGlueLinkerPayloads/glueData/CreateDynamoRecord.json |
    And user connects to AWS Dynamo database and perform the following operation
      | action                     | tableName  | jsonPath                                                           | path       |
      | getTableARNAndUpdateToFile | GlueSource | ida/amazonGlueLinkerPayloads/glueData/createTableWithDynamoDB.json | $.location |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                           |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithDynamoDB.json |

  Scenario Outline: SC9#-Set the Credentials,Datasource and run glue redshift cataloger plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | bodyFile                                                                            | path                  | response code | response message     | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/glueDynamoCredentials                                     | payloads/ida/amazonGlueLinkerPayloads/credentials/awsGlueCredentials.json           | $.dynamoDBCredentials | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/glueDynamoCredentials                                     |                                                                                     |                       | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DynamoDBDataSource                                          | payloads/ida/amazonGlueLinkerPayloads/DataSource/AmazonGlueCatalogerDataSource.json | $.DynamoDBDataSource  | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DynamoDBDataSource                                          |                                                                                     |                       | 200           | DynamoGlueDataSource |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueCataloger                                            | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc09_PluginConfig.json           | $.AWSGlueCataloger    | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                            |                                                                                     |                       | 200           | GlueLinkerCataloger  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                           | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc09_PluginConfig.json           | $.DynamoDBCataloger   | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/DynamoDBCataloger                                           |                                                                                     |                       | 200           | DynamoDBGlue         |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                               | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc09_PluginConfig.json           | $.AWSGlueLinker       | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                               |                                                                                     |                       | 200           | GlueLinker           |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*             |                                                                                     |                       | 200           | IDLE                 | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*              |                                                                                     |                       | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*             |                                                                                     |                       | 200           | IDLE                 | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/DynamoDBGlue |                                                                                     |                       | 200           | IDLE                 | $.[?(@.configurationName=='DynamoDBGlue')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/DynamoDBGlue  |                                                                                     |                       | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/*            |                                                                                     |                       | 200           | IDLE                 | $.[?(@.configurationName=='DynamoDBGlue')].status        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*                   |                                                                                     |                       | 200           | IDLE                 | $.[?(@.configurationName=='GlueLinker')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*                    |                                                                                     |                       | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*                   |                                                                                     |                       | 200           | IDLE                 | $.[?(@.configurationName=='GlueLinker')].status          |


  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC9#Verify glue linker creates lineage between glue table and DynamoDB Table and column to column if external location is Table.
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name              | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | gluedynamodbtable |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                                | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.gluedynamodbtable | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath          |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluedynamodbtable |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath          | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluedynamodbtable | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value      | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | GlueSource | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                              | actual_json                                               | item              |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC9.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | gluedynamodbtable |


  @MLP-20549 @GlueLinker
  Scenario:SC9# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;          | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoDBGlue%       | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                | Analysis |       |       |


  Scenario:SC9#Delete the Tables created in AWS DynamoDB
    Given user connects to AWS Dynamo database and perform the following operation
      | action      | jsonPath                                                     |
      | deleteTable | ida/amazonGlueLinkerPayloads/glueData/deleteDynamoTable.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName         |
      | deleteTable | qagluelinkerdatabase | gluedynamodbtable |

                ##############################7052945_GlueTable_AvroS3_lineage#################################


  @MLP-20549 @GlueLinker
  Scenario:SC10#Create new Database and table in Glue DB using AWSGlueUtil with different type in avro file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                   |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithAvroDiffDataType.json |


  @MLP-20549 @GlueLinker
  Scenario Outline:SC10#_Run Glue,Avro S3 Cataloger and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                | bodyFile                                                                            | path               | response code | response message     | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/glueAvroCredentials                           | payloads/ida/amazonGlueLinkerPayloads/credentials/awsGlueCredentials.json           | $.avroCredentials  | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/glueAvroCredentials                           |                                                                                     |                    | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AvroS3DataSource                                | payloads/ida/amazonGlueLinkerPayloads/DataSource/AmazonGlueCatalogerDataSource.json | $.AvroDataSource   | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AvroS3DataSource                                |                                                                                     |                    | 200           | AvroS3GlueDataSource |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueCataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc10_PluginConfig.json           | $.AWSGlueCataloger | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                                     |                    | 200           | GlueLinkerCataloger  |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AvroS3Cataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc10_PluginConfig.json           | $.AvroS3Cataloger  | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AvroS3Cataloger                                 |                                                                                     |                    | 200           | AvroGlueCatalog      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                   | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc10_PluginConfig.json           | $.AWSGlueLinker    | 204           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                   |                                                                                     |                    | 200           | GlueLinker           |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                     |                    | 200           | IDLE                 | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                                     |                    | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                     |                    | 200           | IDLE                 | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*  |                                                                                     |                    | 200           | IDLE                 | $.[?(@.configurationName=='AvroGlueCatalog')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*   |                                                                                     |                    | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*  |                                                                                     |                    | 200           | IDLE                 | $.[?(@.configurationName=='AvroGlueCatalog')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*       |                                                                                     |                    | 200           | IDLE                 | $.[?(@.configurationName=='GlueLinker')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*        |                                                                                     |                    | 200           |                      |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*       |                                                                                     |                    | 200           | IDLE                 | $.[?(@.configurationName=='GlueLinker')].status          |


  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC10#Verify glue linker creates lineage between glue table and Avro file and column to field if external location is file.(if AvroS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name     | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavro |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                       | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavro | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | userDiffDataTypes.avro | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item     |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC10.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |


  @MLP-20549 @GlueLinker
  Scenario:SC10# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;          | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                   | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AvroS3Cataloger/AvroGlueCatalog%      | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                | Analysis |       |       |


  Scenario:SC10#User delete the table
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |

                ##############################7052946_GlueTable_MultipleFiles_Avro_Run#################################
  @MLP-20549 @GlueLinker
  Scenario:SC11#Create new Database and table in Glue DB using AWSGlueUtil with different type in avro file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                             |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithMultipleAvroFilesDirectory.json |


  @MLP-20549 @GlueLinker
  Scenario Outline:SC11#_Run Glue,Avro Cataloger with multiple files and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                | bodyFile                                                                  | path               | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueCataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc11_PluginConfig.json | $.AWSGlueCataloger | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                           |                    | 200           | GlueLinkerCataloger |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AvroS3Cataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc11_PluginConfig.json | $.AvroS3Cataloger  | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AvroS3Cataloger                                 |                                                                           |                    | 200           | AvroGlueCatalog     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                   | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc11_PluginConfig.json | $.AWSGlueLinker    | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                   |                                                                           |                    | 200           | GlueLinker          |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*  |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='AvroGlueCatalog')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*   |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*  |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='AvroGlueCatalog')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*       |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinker')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*       |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinker')].status          |


  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC11#Verify glue linker creates lineage between glue table and Directory having multiple Avro files if external location is directory.(if AvroS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                  | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavromultiplefiles |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                                    | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavromultiplefiles | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath              |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavromultiplefiles |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath              | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavromultiplefiles | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value             | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | MultipleAvroFiles | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item                  |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC11.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavromultiplefiles |


  @MLP-20549 @GlueLinker
  Scenario:SC11# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;          | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                   | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AvroS3Cataloger/AvroGlueCatalog%      | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                | Analysis |       |       |

  Scenario:SC11#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName             |
      | deleteTable | qagluelinkerdatabase | glueAvroMultipleFiles |


                ##############################7052952_GlueTable_MultipleFileDir_S3_Run#################################
  @MLP-20549 @GlueLinker
  Scenario:SC12#Create new Database and table in Glue DB using AWSGlueUtil with different type in avro file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                             |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithMultipleAvroFilesDirectory.json |


  @MLP-20549 @GlueLinker
  Scenario Outline:SC12#_Run Glue,S3 Cataloger with multiple files and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc12_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc12_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc12_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC12#Verify glue linker creates lineage between glue table and Directory if external location is directory and directory has multiple Avro file(if S3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                  | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavromultiplefiles |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                                    | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavromultiplefiles | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath              |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavromultiplefiles |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath              | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavromultiplefiles | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value             | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | MultipleAvroFiles | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item                  |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC11.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavromultiplefiles |


  @MLP-20549 @GlueLinker
  Scenario:SC12# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;             | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                   | Analysis |       |       |


  Scenario:SC12#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName             |
      | deleteTable | qagluelinkerdatabase | glueAvroMultipleFiles |

                ##############################7052953_GlueTable_Avro_S3_Run#################################


  @MLP-20549 @GlueLinker
  Scenario:SC13#Create new Database and table in Glue DB using AWSGlueUtil with avro file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                   |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithAvroDiffDataType.json |


  @MLP-20549 @GlueLinker
  Scenario Outline:SC13#_Run Glue,S3,Avro Cataloger and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc13_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc13_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc13_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AvroS3Cataloger                                  | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc13_PluginConfig.json | $.AvroS3Cataloger   | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AvroS3Cataloger                                  |                                                                           |                     | 200           | AvroGlueCatalog       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*   |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AvroGlueCatalog')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*    |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*   |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AvroGlueCatalog')].status       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |


  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC13#Verify glue linker creates lineage between glue table and Avro file and column to field if external location is file.(if S3cataloger and AvroS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name     | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavro |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                       | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavro | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | userDiffDataTypes.avro | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item     |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC13.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |


  @MLP-20549 @GlueLinker
  Scenario:SC13# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;             | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AvroS3Cataloger/AvroGlueCatalog%         | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                   | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger% | Analysis |       |       |

  Scenario:SC13#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |

              ##############################7052954_GlueTable_MultipleFileDir_S3_AvroRun#################################
  @MLP-20549 @GlueLinker
  Scenario:SC14#Create new Database and table in Glue DB using AWSGlueUtil with different type in avro file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                             |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithMultipleAvroFilesDirectory.json |


  @MLP-20549 @GlueLinker
  Scenario Outline:SC14#_Run Glue,S3 Cataloger with multiple files and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc14_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc14_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc14_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AvroS3Cataloger                                  | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc14_PluginConfig.json | $.AvroS3Cataloger   | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AvroS3Cataloger                                  |                                                                           |                     | 200           | AvroGlueCatalog       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*   |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AvroGlueCatalog')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/*    |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/*   |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AvroGlueCatalog')].status       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |


  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC14#Verify glue linker creates lineage between glue table and Directory having multiple Avro files if external location is directory.(if S3Cataloger and AvroS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                  | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavromultiplefiles |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                                    | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavromultiplefiles | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath              |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavromultiplefiles |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath              | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavromultiplefiles | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value             | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | MultipleAvroFiles | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item                  |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC11.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavromultiplefiles |

  @MLP-20549 @GlueLinker
  Scenario:SC14# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;             | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AvroS3Cataloger/AvroGlueCatalog%         | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                   | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger% | Analysis |       |       |

  Scenario:SC14#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName             |
      | deleteTable | qagluelinkerdatabase | glueavromultiplefiles |


                 ##############################7052955_GlueTable_OrcFile#################################
  @MLP-20549 @GlueLinker
  Scenario:SC15#Create new Database and table in Glue DB using AWSGlueUtil with orc file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                      |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithOrc.json |

  @MLP-20549 @GlueLinker
  Scenario Outline:SC15#_Run Glue,S3,CSV Cataloger and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc15_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc15_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc15_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC15#Verify glue linker creates lineage between glue table and ORC file if external location is file.(if S3cataloger is ran) if external location is a file.
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name     | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavro |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                       | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavro | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value        | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | orcfile1.orc | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item     |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC15.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |

  @MLP-20549 @GlueLinker
  Scenario:SC15# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;             | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                   | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger% | Analysis |       |       |

  Scenario:SC15#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |


                     ##############################7052956_GlueTable_Orc_Directory#################################
  @MLP-20549 @GlueLinker
  Scenario:SC16#Create new Database and table in Glue DB using AWSGlueUtil with Directory having multiple ORC files
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                               |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithOrcDirectory.json |

  @MLP-20549 @GlueLinker
  Scenario Outline:SC16#_Run Glue,S3 and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc15_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc15_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc15_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC16#Verify glue linker creates lineage between glue table and Directory having multiple ORC files if external location is directory.(if S3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name     | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavro |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                       | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavro | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | ORC   | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item     |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC16.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |

  @MLP-20549 @GlueLinker
  Scenario:SC16# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;             | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                   | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger% | Analysis |       |       |

  Scenario:SC16#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |

                      ##############################7053128_GlueTable_Json_File#################################
  @MLP-20549 @GlueLinker
  Scenario:SC17#Create new Database and table in Glue DB using AWSGlueUtil with Json file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                       |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithJson.json |


  @MLP-20549 @GlueLinker
  Scenario Outline:SC17#_Run Glue,S3 and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                | bodyFile                                                                  | path               | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc17_PluginConfig.json | $.AWSGlueCataloger | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                           |                    | 200           | GlueLinkerCataloger |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/JsonS3Cataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc17_PluginConfig.json | $.JsonS3Cataloger  | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/JsonS3Cataloger                                 |                                                                           |                    | 200           | JsonS3GlueCataloger |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                   | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc17_PluginConfig.json | $.AWSGlueLinker    | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                   |                                                                           |                    | 200           | GlueLinker          |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*  |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='JsonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*   |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*  |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='JsonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*       |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinker')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*       |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinker')].status          |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC17# Verify glue linker creates lineage between glue table and Json file and column to field if external location is file.(if JsonS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name     | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavro |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                       | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavro | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value              | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | jsonDataTypes.json | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item     |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC17.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |

  @MLP-20549 @GlueLinker
  Scenario:SC17# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;          | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                   | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/JsonS3Cataloger/JsonS3GlueCataloger%  | Analysis |       |       |

  Scenario:SC17#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |


                         ##############################7053129_GlueTable_Json_File#################################
  @MLP-20549 @GlueLinker
  Scenario:SC18#Create new Database and table in Glue DB using AWSGlueUtil with Json directory
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                          |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithJsonDir.json |


  @MLP-20549 @GlueLinker
  Scenario Outline:SC18#_Run Glue,S3 and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                | bodyFile                                                                  | path               | response code | response message    | jsonPath                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc18_PluginConfig.json | $.AWSGlueCataloger | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                           |                    | 200           | GlueLinkerCataloger |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/JsonS3Cataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc18_PluginConfig.json | $.JsonS3Cataloger  | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/JsonS3Cataloger                                 |                                                                           |                    | 200           | JsonS3GlueCataloger |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                   | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc18_PluginConfig.json | $.AWSGlueLinker    | 204           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                   |                                                                           |                    | 200           | GlueLinker          |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinkerCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*  |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='JsonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*   |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*  |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='JsonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*       |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinker')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                    | 200           |                     |                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*       |                                                                           |                    | 200           | IDLE                | $.[?(@.configurationName=='GlueLinker')].status          |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC18# Verify glue linker creates lineage between glue table and Json file and column to field if external location is file.(if JsonS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name     | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavro |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                       | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavro | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value             | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | MultipleJsonFiles | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item     |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC18.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |

  @MLP-20549 @GlueLinker
  Scenario:SC18# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;          | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                   | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/JsonS3Cataloger/JsonS3GlueCataloger%  | Analysis |       |       |

  Scenario:SC18#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |



                         ##############################7053130_GlueTable_S3_Json_Multiple#################################
  @MLP-20549 @GlueLinker
  Scenario:SC19#Create new Database and table in Glue DB using AWSGlueUtil with Json file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                          |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithJsonDir.json |


  @MLP-20549 @GlueLinker
  Scenario Outline:SC19#_Run Glue,S3 and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc19_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc19_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc19_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC19# Verify glue linker creates lineage between glue table and Directory if external location is directory and directory has multiple Json file(if S3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name     | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavro |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                       | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavro | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value             | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | MultipleJsonFiles | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item     |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC19.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |

  @MLP-20549 @GlueLinker
  Scenario:SC19# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;             | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                   | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/JsonS3Cataloger/JsonS3GlueCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger% | Analysis |       |       |

  Scenario:SC19#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |



                         ##############################7053131_GlueTable_S3_Json_File#################################
  @MLP-20549 @GlueLinker
  Scenario:SC20#Create new Database and table in Glue DB using AWSGlueUtil with Json file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                       |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithJson.json |


  @MLP-20549 @GlueLinker
  Scenario Outline:SC20#_Run Glue,S3 and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc19_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/JsonS3Cataloger                                  | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc19_PluginConfig.json | $.JsonS3Cataloger   | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/JsonS3Cataloger                                  |                                                                           |                     | 200           | JsonS3GlueCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc19_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc19_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*   |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='JsonS3GlueCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*    |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*   |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='JsonS3GlueCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC20# Verify glue linker creates lineage between glue table and Json file and column to field if external location is file.(if S3cataloger and JsonS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name     | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavro |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                       | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavro | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value              | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | jsonDataTypes.json | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item     |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC20.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |

  @MLP-20549 @GlueLinker
  Scenario:SC20# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;             | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                   | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/JsonS3Cataloger/JsonS3GlueCataloger%     | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger% | Analysis |       |       |

  Scenario:SC20#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |



                             ##############################7053132_GlueTable_Json_Dir#################################
  @MLP-20549 @GlueLinker
  Scenario:SC21#Create new Database and table in Glue DB using AWSGlueUtil with Json directory
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                          |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithJsonDir.json |


  @MLP-20549 @GlueLinker
  Scenario Outline:SC21#_Run Glue,S3 and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc20_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/JsonS3Cataloger                                  | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc20_PluginConfig.json | $.JsonS3Cataloger   | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/JsonS3Cataloger                                  |                                                                           |                     | 200           | JsonS3GlueCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc20_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc19_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*   |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='JsonS3GlueCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*    |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*   |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='JsonS3GlueCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC21# Verify glue linker creates lineage between glue table and Directory having multiple Json files if external location is directory.(if S3Cataloger and JsonS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name     | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavro |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                       | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavro | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value             | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | MultipleJsonFiles | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item     |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC21.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |

  @MLP-20549 @GlueLinker
  Scenario:SC21# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;          | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                   | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/JsonS3Cataloger/JsonS3GlueCataloger%  | Analysis |       |       |

  Scenario:SC21#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |

                  ##############################7053172_GlueTable_Parquet#################################
  @MLP-20549 @GlueLinker
  Scenario:SC22#Create new Database and table in Glue DB using AWSGlueUtil with Json directory
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                          |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithParquet.json |

  @MLP-20549 @GlueLinker
  Scenario Outline:SC22#_Run Glue,S3 and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                  | bodyFile                                                                  | path                 | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                  | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc22_PluginConfig.json | $.AWSGlueCataloger   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                  |                                                                           |                      | 200           | GlueLinkerCataloger    |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                     | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc22_PluginConfig.json | $.AWSGlueLinker      | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                     |                                                                           |                      | 200           | GlueLinker             |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/ParquetS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc22_PluginConfig.json | $.ParquetS3Cataloger | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                           |                      | 200           | ParquetS3GlueCataloger |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinkerCataloger')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*    |                                                                           |                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinkerCataloger')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='ParquetS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  |                                                                           |                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='ParquetS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinker')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*          |                                                                           |                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinker')].status             |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC22# Verify glue linker creates lineage between glue table and Parquet file and column to field if external location is file.(if ParquetS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name     | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavro |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                       | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavro | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value             | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | userdata1.parquet | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item     |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC22.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |

  @MLP-20549 @GlueLinker
  Scenario:SC22# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                        | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%      | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                     | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3GlueCataloger% | Analysis |       |       |

  Scenario:SC22#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |

                      ##############################7053173_GlueTable_Parquet#################################
  @MLP-20549 @GlueLinker
  Scenario:SC23#Create new Database and table in Glue DB using AWSGlueUtil with Json directory
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                  |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithMultipleParquet.json |

  @MLP-20549 @GlueLinker
  Scenario Outline:SC23#_Run Glue,S3 and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                  | bodyFile                                                                  | path                 | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                  | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc22_PluginConfig.json | $.AWSGlueCataloger   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                  |                                                                           |                      | 200           | GlueLinkerCataloger    |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                     | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc22_PluginConfig.json | $.AWSGlueLinker      | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                     |                                                                           |                      | 200           | GlueLinker             |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/ParquetS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc22_PluginConfig.json | $.ParquetS3Cataloger | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                           |                      | 200           | ParquetS3GlueCataloger |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinkerCataloger')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*    |                                                                           |                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinkerCataloger')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='ParquetS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  |                                                                           |                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='ParquetS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinker')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*          |                                                                           |                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinker')].status             |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC23# Verify glue linker creates lineage between glue table and Directory having multiple Parquet files if external location is directory.(if ParquetS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name     | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavro |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                       | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavro | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value                | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | ParquetMultipleFiles | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item     |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC23.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |

  @MLP-20549 @GlueLinker
  Scenario:SC23# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                        | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%      | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                     | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3GlueCataloger% | Analysis |       |       |

  Scenario:SC23#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |


        ##############################7053174_GlueTable_Parquet#################################
  @MLP-20549 @GlueLinker
  Scenario:SC24#Create new Database and table in Glue DB using AWSGlueUtil with Json directory
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                  |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithMultipleParquet.json |

  @MLP-20549 @GlueLinker
  Scenario Outline:SC24#_Run Glue,S3 and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc24_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc24_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc24_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC24# Verify glue linker creates lineage between glue table and Directory if external location is directory and directory has multiple parquet file(if S3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name     | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavro |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                       | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavro | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value                | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | ParquetMultipleFiles | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item     |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC24.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |

  @MLP-20549 @GlueLinker
  Scenario:SC24# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;             | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                   | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger% | Analysis |       |       |

  Scenario:SC24#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |


                ##############################7053175_GlueTable_Parquet_7052957_Cluster_withRegion#################################
  @MLP-20549 @GlueLinker
  Scenario:SC25#Create new Database and table in Glue DB using AWSGlueUtil with Parquet file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                          |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithParquet.json |

  @MLP-20549 @GlueLinker
  Scenario Outline:SC25#_Run Glue,S3 and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                  | bodyFile                                                                  | path                 | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                  | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc25_PluginConfig.json | $.AWSGlueCataloger   | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                  |                                                                           |                      | 200           | GlueLinkerCataloger    |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                     | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc25_PluginConfig.json | $.AWSGlueLinker      | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                     |                                                                           |                      | 200           | GlueLinker             |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/ParquetS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc25_PluginConfig.json | $.ParquetS3Cataloger | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                |                                                                           |                      | 200           | ParquetS3GlueCataloger |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc25_PluginConfig.json | $.AmazonS3Cataloger  | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                 |                                                                           |                      | 200           | AmazonS3GlueCataloger  |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinkerCataloger')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*    |                                                                           |                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinkerCataloger')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*   |                                                                           |                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='ParquetS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/ParquetS3Cataloger/*  |                                                                           |                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/ParquetS3Cataloger/* |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='ParquetS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinker')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*          |                                                                           |                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                      | 200           | IDLE                   | $.[?(@.configurationName=='GlueLinker')].status             |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC25# Verify glue linker creates lineage between glue table and parquet file and column to field if external location is file.(if S3cataloger and ParquetS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name     | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavro |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                       | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavro | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value             | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | userdata1.parquet | verify widget contains | No               |             |
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Search Results Page
      | Domain=amazonaws.com;Region=us-east-1; |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item     |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC25.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |

  @MLP-20549 @GlueLinker
  Scenario:SC25# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                        | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%      | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                     | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3GlueCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger%   | Analysis |       |       |

  Scenario:SC25#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |

                  ##############################7053176_7054495_GlueTable_ParquetMultiple_S3_Parquet_InternalNode#################################

  @MLP-20549 @GlueLinker
  Scenario:SC26#Create new Database and table in Glue DB using AWSGlueUtil with Parquet file
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                  |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithMultipleParquet.json |

  @MLP-20549 @GlueLinker
  Scenario Outline:SC26#_Run Glue,S3 and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                     | bodyFile                                                                            | path                            | response code | response message              | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueDataSource                                    | payloads/ida/amazonGlueLinkerPayloads/DataSource/AmazonGlueCatalogerDataSource.json | $.AWSGlueInternalDataSource     | 204           |                               |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueDataSource                                    |                                                                                     |                                 | 200           | AWSGlueInternalDataSource     |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/ParquetS3DataSource                                  | payloads/ida/amazonGlueLinkerPayloads/DataSource/AmazonGlueCatalogerDataSource.json | $.GlueParquetInternalDataSource | 204           |                               |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/ParquetS3DataSource                                  |                                                                                     |                                 | 200           | GlueParquetInternalDataSource |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3DataSource                                   | payloads/ida/amazonGlueLinkerPayloads/DataSource/AmazonGlueCatalogerDataSource.json | $.GlueS3InternalDataSource      | 204           |                               |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3DataSource                                   |                                                                                     |                                 | 200           | GlueS3InternalDataSource      |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueCataloger                                     | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc26_PluginConfig.json           | $.AWSGlueCataloger              | 204           |                               |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                     |                                                                                     |                                 | 200           | GlueLinkerCataloger           |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                        | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc26_PluginConfig.json           | $.AWSGlueLinker                 | 204           |                               |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                        |                                                                                     |                                 | 200           | GlueLinker                    |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/ParquetS3Cataloger                                   | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc26_PluginConfig.json           | $.ParquetS3Cataloger            | 204           |                               |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/ParquetS3Cataloger                                   |                                                                                     |                                 | 200           | ParquetS3GlueCataloger        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc26_PluginConfig.json           | $.AmazonS3Cataloger             | 204           |                               |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                    |                                                                                     |                                 | 200           | AmazonS3GlueCataloger         |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AWSGlueCataloger/*   |                                                                                     |                                 | 200           | IDLE                          | $.[?(@.configurationName=='GlueLinkerCataloger')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/AWSGlueCataloger/*    |                                                                                     |                                 | 200           |                               |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AWSGlueCataloger/*   |                                                                                     |                                 | 200           | IDLE                          | $.[?(@.configurationName=='GlueLinkerCataloger')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonS3Cataloger/*  |                                                                                     |                                 | 200           | IDLE                          | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/AmazonS3Cataloger/*   |                                                                                     |                                 | 200           |                               |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonS3Cataloger/*  |                                                                                     |                                 | 200           | IDLE                          | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/ParquetS3Cataloger/* |                                                                                     |                                 | 200           | IDLE                          | $.[?(@.configurationName=='ParquetS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/ParquetS3Cataloger/*  |                                                                                     |                                 | 200           |                               |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/ParquetS3Cataloger/* |                                                                                     |                                 | 200           | IDLE                          | $.[?(@.configurationName=='ParquetS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/linker/AWSGlueLinker/*         |                                                                                     |                                 | 200           | IDLE                          | $.[?(@.configurationName=='GlueLinker')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/linker/AWSGlueLinker/*          |                                                                                     |                                 | 200           |                               |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/linker/AWSGlueLinker/*         |                                                                                     |                                 | 200           | IDLE                          | $.[?(@.configurationName=='GlueLinker')].status             |

  @MLP-20549 @GlueLinker @webtest
  Scenario Outline:SC26# Verify glue linker creates lineage between glue table and Directory having multiple parquet files if external location is directory.(if S3Cataloger and ParquetS3cataloger is ran)
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name     | asg_scopeid | targetFile                        | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | glueavro |             | response/Lineage/bulkLineage.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                          | path                       | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\Lineage\bulkLineage.json | $.lineagePayLoads.glueavro | 200           |                  | edges    | response\Lineage\actualLineagehops.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |
    And user sort the json file using the following value
      | fileName                                                  | JsonPath | value  |
      | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro | source |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "glueLinker" and clicks on search
    And user performs "facet selection" in "SC1GlueLinkerCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value                | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | ParquetMultipleFiles | verify widget contains | No               |             |
    And expected JSON "<expected_json>" data should be equal to actual "<actual_json>" data for item "<item>"
    Examples:
      | expected_json                                                               | actual_json                                               | item     |
      | Constant.REST_DIR/response/glueLinker/expected/gluelinkerexpected_SC26.json | Constant.REST_DIR/response/Lineage/actualLineagehops.json | glueavro |

  @MLP-20549 @GlueLinker
  Scenario:SC26# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                        | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%      | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                     | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/ParquetS3Cataloger/ParquetS3GlueCataloger% | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger%   | Analysis |       |       |

  Scenario:SC26#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |


       ##############################7054486_GlueLinker_DRyRun#################################
  @MLP-20549 @GlueLinker
  Scenario:SC27#Create new Database and table in Glue DB using AWSGlueUtil with Json directory
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                  |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithMultipleParquet.json |

  @MLP-20549 @GlueLinker
  Scenario Outline:SC27#_Run Glue,S3 and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc27_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc27_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc27_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |

  @MLP-20549 @GlueLinker @webtest
  Scenario:SC27# Verify Gluelinker works properly and collects only analysis item in dry run mode(log should show processed count:2)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AWSGlueLinker" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "linker/AWSGlueLinker/GlueLinker%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName |
      | Number of processed items | 0             | Description   |
      | Number of errors          | 0             | Description   |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "linker/AWSGlueLinker/GlueLinker%" should display below info/error/warning
      | type | logValue                                     | logCode       | pluginName    | removableText |
      | INFO | Plugin AWSGlueLinker running on dry run mode | ANALYSIS-0069 | AWSGlueLinker |               |
    Then user confirm "non presence of window" for the below item types
      | catalogName | facetName | facet         | itemName | windowName  |
      | Default     | Table     | Metadata Type | glueavro | Lineage Hop |

  @MLP-20549 @GlueLinker
  Scenario:SC27# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;             | Cluster  |       |       |
      | SingleItemDelete | Default | amazonaws.com                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%    | Analysis |       |       |
      | SingleItemDelete | Default | linker/AWSGlueLinker/GlueLinker%                   | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger% | Analysis |       |       |

  Scenario:SC27#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName         | tableName |
      | deleteTable | qagluelinkerdatabase | glueavro  |


      ##############################7054493_GlueLinker_InvalidRegion#################################
  @MLP-20549 @GlueLinker
  Scenario:SC28#Create new Database and table in Glue DB using AWSGlueUtil with Json directory
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                                                  |
      | createTable | ida/amazonGlueLinkerPayloads/glueData/createTableWithMultipleParquet.json |

  @MLP-20549 @GlueLinker
  Scenario Outline:SC28#_Run Glue,S3 and Glue linker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | bodyFile                                                                  | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                 | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc28_PluginConfig.json | $.AWSGlueCataloger  | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueCataloger                                 |                                                                           |                     | 200           | GlueLinkerCataloger   |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker                                    | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc28_PluginConfig.json | $.AWSGlueLinker     | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AWSGlueLinker                                    |                                                                           |                     | 200           | GlueLinker            |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                | payloads/ida/amazonGlueLinkerPayloads/pluginConfig/sc28_PluginConfig.json | $.AmazonS3Cataloger | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                           |                     | 200           | AmazonS3GlueCataloger |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*   |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*  |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinkerCataloger')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3GlueCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/*         |                                                                           |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/*        |                                                                           |                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueLinker')].status            |

  @MLP-20549 @GlueLinker @webtest
  Scenario:SC28# Verify glue linker does not generate any lineage if the region given in Invalid and it does not match with the region in which actual tables/files/directory are present.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user confirm "non presence of window" for the below item types
      | catalogName | facetName | facet         | itemName | windowName  |
      | Default     | Table     | Metadata Type | glueavro | Lineage Hop |

  @MLP-20549 @GlueLinker
  Scenario:SC28# Delete all the Clusters and analysis with respect to gluelinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1;             | Cluster  |       |       |
      | MultipleIDDelete | Default | amazonaws.com                                      | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/GlueLinkerCataloger%    | Analysis |       |       |
      | MultipleIDDelete | Default | linker/AWSGlueLinker/GlueLinker%                   | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3GlueCataloger% | Analysis |       |       |

  Scenario:SC28#User delete the table from glue
    Given user connects to AWS Glue database and perform the following operation
      | action         | databaseName         | tableName |
      | deleteTable    | qagluelinkerdatabase | glueavro  |
      | deleteDatabase | qagluelinkerdatabase | glueavro  |

    ##############################PostScenarios#################################
  @aws
  Scenario:SC29#Delete the linker test data bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "GlueLinker" in bucket "asgqagluelinkerbucket"
    Then user "Delete" a bucket "asgqagluelinkerbucket" in amazon storage service


  @RedShift @positve @regression @sanity
  Scenario: Delete plugin Configurations
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                               | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/credentials/ValidGlueLinkerCredentials                   |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/InvalidGlueLinkerCredentials                 |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/EmptyGlueLinkerCredentials                   |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/InvalidGlueLinkerCredentialsInvalidSecretKey |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/ValidGlueLinkerS3Credentials                 |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/ValidGlueLinkerCSVCredentials                |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/ValidParquetCredentials                      |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/glueDynamoCredentials                        |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/ValidRedshiftGlueCredentials                 |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/glueAvroCredentials                          |      | 200           |                  |          |
      |                  |       |       | Delete | settings/analyzers/AWSGlueDataSource                              |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonS3DataSource                             |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/CsvS3DataSource                                |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/JsonS3DataSource                               |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/ParquetS3DataSource                            |      | 204           |                  |          |