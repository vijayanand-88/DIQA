Feature:JSON S3 cataloger sanity run scenarios


  @sanityrun
  Scenario:JsonS3_Update the aws credential Json
    Given User update the below "aws credentials" in following files using json path
      | filePath                            | accessKeyPath | secretKeyPath |
      | ida/sanityPayloads/credentials.json | $..accessKey  | $..secretKey  |

  @sanityrun
  Scenario Outline:JsonS3_Update Credential,Data Source,plugin configuration and run plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | bodyFile                                      | path                              | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/sanityJSONRWCredential                                        | payloads/ida/sanityPayloads/credentials.json  | $.AWSReadWrite                    | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3DataSource/JSONS3SanityDataSource                         | payloads/ida/sanityPayloads/datasource.json   | $.JSONS3Sanity.configurations.[0] | 204           |                  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger/JSONS3SanityConfig                              | payloads/ida/sanityPayloads/pluginconfig.json | $.JSONS3Sanity.configuration      | 204           |                  |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JSONS3SanityConfig |                                               |                                   | 200           | IDLE             | $.[?(@.configurationName=='JSONS3SanityConfig')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/JSONS3SanityConfig  |                                               |                                   | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/JSONS3SanityConfig |                                               |                                   | 200           | IDLE             | $.[?(@.configurationName=='JSONS3SanityConfig')].status |


  @sanityrun @webtest
  Scenario:JsonS3_Validate the file counts of each S3 buckets
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3Explicit" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis  |
      | Directory |
      | Field     |
      | Rule      |
      | File      |
      | Cluster   |
      | Service   |
    And user enters the search text "JsonS3Explicit" and clicks on search
    And user performs "facet selection" in "asg-ida-dev [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get "File count without version" from "S3Cataloger/testFiles/JSON" in bucket "asg-ida-dev" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page
    And user enters the search text "JsonS3Explicit" and clicks on search
    And user performs "facet selection" in "asg-ida-dev [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Rule" attribute under "Metadata Type" facets in Item Search results page
    And user get "rule count" from "S3Cataloger/testFiles/JSON" in bucket "asg-ida-dev" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page

  Scenario Outline: JsonS3_:Configure & run the CsvS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                         | path                            | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/JsonS3Analyzer/demojsonS3Analyzer                                 | payloads/ida/sanityPayloads/AnalyzersConfig.json | $.jsonS3Analyzer.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/JsonS3Analyzer/demojsonS3Analyzer                                 |                                                  |                                 | 200           | demojsonS3Analyzer |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/demojsonS3Analyzer |                                                  |                                 | 200           | IDLE               | $.[?(@.configurationName=='demojsonS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/JsonS3Analyzer/demojsonS3Analyzer  |                                                  |                                 | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/JsonS3Analyzer/demojsonS3Analyzer |                                                  |                                 | 200           | IDLE               | $.[?(@.configurationName=='demojsonS3Analyzer')].status |



#  @sanityrun
#  Scenario:JsonS3_Delete Configurations
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type   | url                                                        | body | response code | response message | jsonPath |
#      | application/json | raw   | false | Delete | settings/credentials/sanityJSONCredential                  |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/JsonS3DataSource/JSONS3SanityDataSource |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/JsonS3Cataloger/JSONS3SanityConfig      |      | 204           |                  |          |
