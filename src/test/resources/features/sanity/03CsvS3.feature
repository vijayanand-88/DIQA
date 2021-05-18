Feature:CSV S3 cataloger sanity run scenarios


  @sanityrun
  Scenario:CsvS3_Update the aws credential Json
    Given User update the below "aws credentials" in following files using json path
      | filePath                            | accessKeyPath             | secretKeyPath             |
      | ida/sanityPayloads/credentials.json | $.AWSReadWrite..accessKey | $.AWSReadWrite..secretKey |

  @sanityrun
  Scenario Outline:CsvS3_Update Credential,Data Source,plugin configuration and run plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                      | path                             | response code | response message | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/sanityCSVRWCredential                                       | payloads/ida/sanityPayloads/credentials.json  | $.AWSReadWrite                   | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3DataSource/CSVS3SanityDataSource                         | payloads/ida/sanityPayloads/datasource.json   | $.CSVS3Sanity.configurations.[0] | 204           |                  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Cataloger/CSVS3SanityConfig                              | payloads/ida/sanityPayloads/pluginconfig.json | $.CSVS3Sanity.configurations     | 204           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CSVS3SanityConfig |                                               |                                  | 200           | IDLE             | $.[?(@.configurationName=='CSVS3SanityConfig')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/CSVS3SanityConfig  |                                               |                                  | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/CSVS3SanityConfig |                                               |                                  | 200           | IDLE             | $.[?(@.configurationName=='CSVS3SanityConfig')].status |


  @sanityrun @webtest
  Scenario:CsvS3_Validate the file counts of each S3 buckets
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CsvS3Explicit" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis  |
      | Directory |
      | Field     |
      | Rule      |
      | File      |
      | Cluster   |
      | Service   |
    And user enters the search text "CsvS3Explicit" and clicks on search
    And user performs "facet selection" in "asg-ida-dev-versions [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get "File count without version" from "S3Cataloger/demo/CSV" in bucket "asg-ida-dev-versions" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page
    And user enters the search text "CsvS3Explicit" and clicks on search
    And user performs "facet selection" in "asg-ida-dev-versions [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Rule" attribute under "Metadata Type" facets in Item Search results page
    And user get "rule count" from "S3Cataloger/demo/CSV" in bucket "asg-ida-dev-versions" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page


  Scenario Outline: CsvS3_:Configure & run the CsvS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | bodyFile                                         | path                           | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CsvS3Analyzer/democsvS3Analyzer                                 | payloads/ida/sanityPayloads/AnalyzersConfig.json | $.csvS3Analyzer.configurations | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/CsvS3Analyzer/democsvS3Analyzer                                 |                                                  |                                | 200           | democsvS3Analyzer |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/democsvS3Analyzer |                                                  |                                | 200           | IDLE              | $.[?(@.configurationName=='democsvS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CsvS3Analyzer/democsvS3Analyzer  |                                                  |                                | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CsvS3Analyzer/democsvS3Analyzer |                                                  |                                | 200           | IDLE              | $.[?(@.configurationName=='democsvS3Analyzer')].status |




#  @sanityrun
#  Scenario:CsvS3_Delete Configurations
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type   | url                                                      | body | response code | response message | jsonPath |
#      | application/json | raw   | false | Delete | settings/credentials/sanityCSVCredential                 |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/CsvS3DataSource/CSVS3SanityDataSource |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/CsvS3Cataloger/CSVS3SanityConfig      |      | 204           |                  |          |
