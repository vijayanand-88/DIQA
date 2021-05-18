Feature:AVRO S3 cataloger sanity run scenarios

  @sanityrun
  Scenario:AvroS3_Update the aws credential Json
    Given User update the below "aws credentials" in following files using json path
      | filePath                            | accessKeyPath             | secretKeyPath             |
      | ida/sanityPayloads/credentials.json | $.AWSReadWrite..accessKey | $.AWSReadWrite..secretKey |


  @sanityrun
  Scenario Outline:AvroS3_Update Credential,Data Source,plugin configuration and run plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                | bodyFile                                      | path                              | response code | response message | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/sanityAVRORWCredential                                        | payloads/ida/sanityPayloads/credentials.json  | $.AWSReadWrite                    | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3DataSource/AVROS3SanityDataSource                         | payloads/ida/sanityPayloads/datasource.json   | $.AVROS3Sanity.configurations.[0] | 204           |                  |                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger/AVROS3SanityConfig                              | payloads/ida/sanityPayloads/pluginconfig.json | $.AVROS3Sanity.configurations     | 204           |                  |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AVROS3SanityConfig |                                               |                                   | 200           | IDLE             | $.[?(@.configurationName=='AVROS3SanityConfig')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AVROS3SanityConfig  |                                               |                                   | 200           |                  |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AVROS3SanityConfig |                                               |                                   | 200           | IDLE             | $.[?(@.configurationName=='AVROS3SanityConfig')].status |


  @sanityrun @webtest
  Scenario:AvroS3_Validate the file counts of each S3 buckets
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AvroS3Explicit" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis  |
      | Directory |
      | Field     |
      | Rule      |
      | File      |
      | Cluster   |
      | Service   |
    And user enters the search text "AvroS3Explicit" and clicks on search
    And user performs "facet selection" in "asg-ida-dev [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get "File count without version" from "S3Cataloger/testFiles/AVRO" in bucket "asg-ida-dev" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page
    And user enters the search text "AvroS3Explicit" and clicks on search
    And user performs "facet selection" in "asg-ida-dev [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Rule" attribute under "Metadata Type" facets in Item Search results page
    And user get "rule count" from "S3Cataloger/testFiles/AVRO" in bucket "asg-ida-dev" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page

  Scenario Outline: AvroS3_:Configure & run the CsvS3Analyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                         | path                            | response code | response message   | jsonPath                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AvroS3Analyzer/demoAvroS3Analyzer                                 | payloads/ida/sanityPayloads/AnalyzersConfig.json | $.avroS3Analyzer.configurations | 204           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AvroS3Analyzer/demoAvroS3Analyzer                                 |                                                  |                                 | 200           | demoAvroS3Analyzer |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/demoAvroS3Analyzer |                                                  |                                 | 200           | IDLE               | $.[?(@.configurationName=='demoAvroS3Analyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AvroS3Analyzer/demoAvroS3Analyzer  |                                                  |                                 | 200           |                    |                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AvroS3Analyzer/demoAvroS3Analyzer |                                                  |                                 | 200           | IDLE               | $.[?(@.configurationName=='demoAvroS3Analyzer')].status |




#  @sanityrun
#  Scenario:AvroS3_Delete Configurations
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type   | url                                                        | body | response code | response message | jsonPath |
#      | application/json | raw   | false | Delete | settings/credentials/sanityAVROCredential                  |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AvroS3DataSource/AVROS3SanityDataSource |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AvroS3Cataloger/AVROS3SanityConfig      |      | 204           |                  |          |
