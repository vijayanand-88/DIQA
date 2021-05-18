Feature:Glue Cataloger,AWS Collector and Glue Lineage sanity run scenarios


  @sanityrun
  Scenario:AmazonS3_Update the aws credential Json for Amazon S3
    Given User update the below "aws credentials" in following files using json path
      | filePath                            | accessKeyPath                 | secretKeyPath                 |
      | ida/sanityPayloads/credentials.json | $..GlueCredentials..accessKey | $..GlueCredentials..secretKey |

  @sanityrun
  Scenario Outline:GlueLineage_Update Credential,Data Source,plugin configuration and run plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                      | path                                | response code | response message | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/sanityGCCredential                                                   | payloads/ida/sanityPayloads/credentials.json  | $.GlueCredentials                   | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueDataSource/SanityGCDS                                           | payloads/ida/sanityPayloads/datasource.json   | $.AWSGCCataloger.configurations.[0] | 204           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueCataloger/GCConfig                                              | payloads/ida/sanityPayloads/pluginconfig.json | $.AWSGlueCatalogerGC.configurations | 204           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSCollectorDataSource/SanityGCCDS                                     | payloads/ida/sanityPayloads/datasource.json   | $.AWSCollectorDS.configurations.[0] | 204           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSCollector/SanityGCC                                                 | payloads/ida/sanityPayloads/pluginconfig.json | $.AWSCollector.configurations       | 204           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGluePythonParser/SanityGlueParser                                   | payloads/ida/sanityPayloads/pluginconfig.json | $.GluePythonParser.configurations   | 204           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGluePythonSparkLineage/SanityGlueLineage                            | payloads/ida/sanityPayloads/pluginconfig.json | $.GluePythonLineage.configurations  | 204           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/GCConfig                 |                                               |                                     | 200           | IDLE             | $.[?(@.configurationName=='GCConfig')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/GCConfig                  |                                               |                                     | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/GCConfig                 |                                               |                                     | 200           | IDLE             | $.[?(@.configurationName=='GCConfig')].status          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/SanityGCC                    |                                               |                                     | 200           | IDLE             | $.[?(@.configurationName=='SanityGCC')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/collector/AWSCollector/SanityGCC                     |                                               |                                     | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/SanityGCC                    |                                               |                                     | 200           | IDLE             | $.[?(@.configurationName=='SanityGCC')].status         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/AWSGluePythonParser/SanityGlueParser         |                                               |                                     | 200           | IDLE             | $.[?(@.configurationName=='SanityGlueParser')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/parser/AWSGluePythonParser/SanityGlueParser          |                                               |                                     | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/AWSGluePythonParser/SanityGlueParser         |                                               |                                     | 200           | IDLE             | $.[?(@.configurationName=='SanityGlueParser')].status  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/AWSGluePythonSparkLineage/SanityGlueLineage |                                               |                                     | 200           | IDLE             | $.[?(@.configurationName=='SanityGlueLineage')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/lineage/AWSGluePythonSparkLineage/SanityGlueLineage  |                                               |                                     | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/AWSGluePythonSparkLineage/SanityGlueLineage |                                               |                                     | 200           | IDLE             | $.[?(@.configurationName=='SanityGlueLineage')].status |


  @sanityrun
  Scenario Outline:GlueLineage_user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type       | name                    | asg_scopeid | targetFile                                   | jsonpath      |
      | APPDBPOSTGRES | OperationID | Default | Operation  | gwTransformS3toRedshift |             | response/sanity/gwTransformS3toRedshift.json |               |
      | APPDBPOSTGRES | LineageID   | Default | LineageHop |                         |             | response/sanity/gwTransformS3toRedshift.json | $.OperationID |

  @sanityrun
  Scenario Outline:GlueLineage_user retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item                    | inputFile                                    | outputFile                             |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | gwTransformS3toRedshift | response/sanity/gwTransformS3toRedshift.json | response/sanity/glueActualLineage.json |

  @sanityrun
  Scenario Outline:GlueLineage_User compares the expected lineage hops information with actual lineage hops
    Then user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                          | actualJson                                               |
      | Constant.REST_DIR/response/sanity/glueExpLineage.json | Constant.REST_DIR/response/sanity/glueActualLineage.json |


  @webtest @sanityrun
  Scenario:GlueLineage_Validate Operation is collected in platform
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "gwTransformS3toRedshift" and clicks on search
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | gwTransformS3toRedshift |
    And user enters the search text "GlueLineageExplicit" and clicks on search
    And user performs "facet selection" in "GlueLineageExplicit" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "gwdb [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "gwdb2 [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "asgdevdb [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "spectrum_demodb [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "demodb [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user connects to AWS Glue database and perform the following operation
      | action                    | databaseList    |
      | verifyMutlipleDBTableSize | gwdb            |
      | verifyMutlipleDBTableSize | gwdb2           |
      | verifyMutlipleDBTableSize | asgdevdb        |
      | verifyMutlipleDBTableSize | spectrum_demodb |
      | verifyMutlipleDBTableSize | demodb          |
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user connects to AWS Glue database and perform the following operation
      | action                     | databaseList    |
      | verifyMutlipleDBColumnSize | gwdb            |
      | verifyMutlipleDBColumnSize | gwdb2           |
      | verifyMutlipleDBColumnSize | asgdevdb        |
      | verifyMutlipleDBColumnSize | spectrum_demodb |
      | verifyMutlipleDBColumnSize | demodb          |


#  @sanityrun
#  Scenario:GlueLineage_Delete Configurations
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type   | url                                                            | body | response code | response message | jsonPath |
#      | application/json | raw   | false | Delete | settings/credentials/sanityGCCredential                        |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AWSGlueDataSource/SanityGCDS                |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AWSCollectorDataSource/SanityGCCDS          |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AWSGlueCataloger/GCConfig                   |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AWSCollector/SanityGCC                      |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AWSGluePythonParser/SanityGlueParser        |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AWSGluePythonSparkLineage/SanityGlueLineage |      | 204           |                  |          |
#
