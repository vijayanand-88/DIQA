Feature:Amazon Glue Linker and Lineage sanity run scenarios

  @sanityrun
  Scenario Outline:GlueLinker_Update Credential,Data Source,plugin configuration and run plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | bodyFile                                      | path                                   | response code | response message | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/GlueCSVCredentials                                                           | payloads/ida/sanityPayloads/credentials.json  | $.S3Credentials                        | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvS3DataSource/Gluecsvdatasource                                              | payloads/ida/sanityPayloads/datasource.json   | $.Gluecsvdatasource.configurations.[0] | 204           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger/SanityGlueCSVS3Cataloger                                        | payloads/ida/sanityPayloads/pluginconfig.json | $.gluelinkercsvConfig.configurations   | 204           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonRedshiftDataSource/sanityGLRedshiftDS                                    | payloads/ida/sanityPayloads/datasource.json   | $.GLRedshiftDS.configurations.[0]      | 204           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonRedshiftCataloger/SanityRedShiftGLCataloger                              | payloads/ida/sanityPayloads/pluginconfig.json | $.GLRedshiftDataConfig.configurations  | 204           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/sanityGLCredential                                                           | payloads/ida/sanityPayloads/credentials.json  | $.GlueCredentials                      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueDataSource/SanityGLDS                                                   | payloads/ida/sanityPayloads/datasource.json   | $.AWSGLCataloger.configurations.[0]    | 204           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueCataloger/SanityGLConfig                                                | payloads/ida/sanityPayloads/pluginconfig.json | $.AWSGLCatalogerGC.configurations      | 204           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSCollectorDataSource/SanityGLCDS                                             | payloads/ida/sanityPayloads/datasource.json   | $.AWSGCLinkerDS.configurations.[0]     | 204           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSCollector/SanityGLC                                                         | payloads/ida/sanityPayloads/pluginconfig.json | $.AWSGLCollector.configurations        | 204           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGluePythonParser/SanityGLParser                                             | payloads/ida/sanityPayloads/pluginconfig.json | $.GLPythonParser.configurations        | 204           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGluePythonSparkLineage/SanityGLLineage                                      | payloads/ida/sanityPayloads/pluginconfig.json | $.GLPythonLineage.configurations       | 204           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueLinker/SanityGlueLinker                                                 | payloads/ida/sanityPayloads/pluginconfig.json | $.AWSGlueLinker.configurations         | 204           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/SanityGLConfig                   |                                               |                                        | 200           | IDLE             | $.[?(@.configurationName=='SanityGLConfig')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/SanityGLConfig                    |                                               |                                        | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/SanityGLConfig                   |                                               |                                        | 200           | IDLE             | $.[?(@.configurationName=='SanityGLConfig')].status            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/SanityGlueCSVS3Cataloger           |                                               |                                        | 200           | IDLE             | $.[?(@.configurationName=='SanityGlueCSVS3Cataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/SanityGlueCSVS3Cataloger            |                                               |                                        | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/SanityGlueCSVS3Cataloger           |                                               |                                        | 200           | IDLE             | $.[?(@.configurationName=='SanityGlueCSVS3Cataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/SanityRedShiftGLCataloger |                                               |                                        | 200           | IDLE             | $.[?(@.configurationName=='SanityRedShiftGLCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/SanityRedShiftGLCataloger  |                                               |                                        | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/SanityRedShiftGLCataloger |                                               |                                        | 200           | IDLE             | $.[?(@.configurationName=='SanityRedShiftGLCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/SanityGLC                            |                                               |                                        | 200           | IDLE             | $.[?(@.configurationName=='SanityGLC')].status                 |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/collector/AWSCollector/SanityGLC                             |                                               |                                        | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/SanityGLC                            |                                               |                                        | 200           | IDLE             | $.[?(@.configurationName=='SanityGLC')].status                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/SanityGlueLinker                       |                                               |                                        | 200           | IDLE             | $.[?(@.configurationName=='SanityGlueLinker')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AWSGlueLinker/SanityGlueLinker                        |                                               |                                        | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AWSGlueLinker/SanityGlueLinker                       |                                               |                                        | 200           | IDLE             | $.[?(@.configurationName=='SanityGlueLinker')].status          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/AWSGluePythonParser/SanityGLParser                   |                                               |                                        | 200           | IDLE             | $.[?(@.configurationName=='SanityGLParser')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/parser/AWSGluePythonParser/SanityGLParser                    |                                               |                                        | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/AWSGluePythonParser/SanityGLParser                   |                                               |                                        | 200           | IDLE             | $.[?(@.configurationName=='SanityGLParser')].status            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/AWSGluePythonSparkLineage/SanityGLLineage           |                                               |                                        | 200           | IDLE             | $.[?(@.configurationName=='SanityGLLineage')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/lineage/AWSGluePythonSparkLineage/SanityGLLineage            |                                               |                                        | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/AWSGluePythonSparkLineage/SanityGLLineage           |                                               |                                        | 200           | IDLE             | $.[?(@.configurationName=='SanityGLLineage')].status           |


  @webtest @sanityrun
  Scenario:GlueLinker_Validate Operation is collected in platform
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "GlueLinkerExplicit" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | gwTransformS3toRedshift  |
      | CSV_Parquet_multi_job    |
      | population_redshift_job1 |
      | population_job_2         |
    And user enters the search text "city1_csv" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city1_csv" item from search results
    Then user performs click and verify in new window
      | Table            | value     | Action                 | RetainPrevwindow | indexSwitch |
      | externalLocation | city1.csv | verify widget contains | No               |             |

  @sanityrun
  Scenario Outline:GlueLinker_Retrieve lineage information and compare with expected lineage results
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                  | asg_scopeid | targetFile                      | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | artists_csv           |             | response/sanity/lineageIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | world_dd_demo_artists |             | response/sanity/lineageIDs.json |          |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | population_csv        |             | response/sanity/lineageIDs.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                        | bodyFile                        | path                                    | response code | response message | jsonPath | targetFile                                |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=-%3E&lineageDepth=0&excludeUnusedViewColumns=false    | response/sanity/lineageIDs.json | $.lineagePayLoads.artists_csv           | 200           |                  | edges    | response/sanity/gluelinkeractlineage.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=%3C-&lineageDepth=0&excludeUnusedViewColumns=false    | response/sanity/lineageIDs.json | $.lineagePayLoads.world_dd_demo_artists | 200           |                  | edges    | response/sanity/gluelinkeractlineage.json |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=%3C-%3E&lineageDepth=0&excludeUnusedViewColumns=false | response/sanity/lineageIDs.json | $.lineagePayLoads.population_csv        | 200           |                  | edges    | response/sanity/gluelinkeractlineage.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                    | JsonPath              |
      | Constant.REST_DIR/response/sanity/gluelinkeractlineage.json | artists_csv           |
      | Constant.REST_DIR/response/sanity/gluelinkeractlineage.json | world_dd_demo_artists |
      | Constant.REST_DIR/response/sanity/gluelinkeractlineage.json | population_csv        |
    Then user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                | actualJson                                                  |
      | Constant.REST_DIR/response/sanity/gluelinkerexplineage.json | Constant.REST_DIR/response/sanity/gluelinkeractlineage.json |


#  @sanityrun
#  Scenario:GlueLinker_Delete Configurations
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type   | url                                                                  | body | response code | response message | jsonPath |
#      | application/json | raw   | false | Delete | settings/credentials/GlueCSVCredentials                              |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/credentials/sanityRedshiftCredential                        |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/credentials/sanityGLCredential                              |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/CsvS3DataSource/Gluecsvdatasource                 |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftDataSource/sanityGLRedshiftDS       |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AWSGlueDataSource/SanityGLDS                      |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AWSCollectorDataSource/SanityGLCDS                |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/CsvS3Cataloger/SanityGlueCSVS3Cataloger           |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftCataloger/SanityRedShiftGLCataloger |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AWSGlueCataloger/SanityGLConfig                   |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AWSCollector/SanityGLC                            |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AWSGlueLinker/SanityGlueLinker                    |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AWSGluePythonParser/SanityGLParser                |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AWSGluePythonSparkLineage/SanityGLLineage         |      | 204           |                  |          |
#

#  Scenario: De
#    Given user delete all "Analysis" log with name "cataloger/AmazonRedshiftCataloger%" using database
#    And user delete all "Analysis" log with name "cataloger/AWSGlueCataloger%" using database
#    And user delete all "Analysis" log with name "lineage/AWSGluePythonSparkLineage%" using database
#    And user delete all "Analysis" log with name "parser/AWSGluePythonParser%" using database
#    And user delete all "Analysis" log with name "collector/AWSCollector%" using database
#    And user delete all "Analysis" log with name "linker/AWSGlueLinker%" using database