Feature:Amazon S3 cataloger sanity run scenarios


  @sanityrun
  Scenario:AmazonS3_Update the aws credential Json for Amazon S3
    Given User update the below "S3 Readonly credentials" in following files using json path
      | filePath                            | accessKeyPath | secretKeyPath |
      | ida/sanityPayloads/credentials.json | $..accessKey  | $..secretKey  |

  @sanityrun
  Scenario Outline:AmazonS3_Update Credential,Data Source,plugin configuration and run plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                              | bodyFile                                      | path                              | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/sanityS3Credential                                          | payloads/ida/sanityPayloads/credentials.json  | $.S3Credentials                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource/S3SanityDataSource                         | payloads/ida/sanityPayloads/datasource.json   | $.S3DataSource.configurations.[0] | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger/S3SanityConfig                              | payloads/ida/sanityPayloads/pluginconfig.json | $.AmazonS3Sanity.configurations   | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/S3SanityConfig |                                               |                                   | 200           | IDLE             | $.[?(@.configurationName=='S3SanityConfig')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/S3SanityConfig  |                                               |                                   | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/S3SanityConfig |                                               |                                   | 200           | IDLE             | $.[?(@.configurationName=='S3SanityConfig')].status |

  @sanityrun @webtest
  Scenario:AmazonS3_Validate the file counts of each S3 buckets
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "AmazonS3Explicit" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis  |
      | Directory |
      | Rule      |
      | File      |
      | Cluster   |
      | Service   |
    And user performs "facet selection" in "AmazonS3Explicit" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "asg-ida-dev" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get "File count without version" from "S3Cataloger/testFiles/CSV" in bucket "asg-ida-dev" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page
    And user enters the search text "AmazonS3Explicit" and clicks on search
    And user performs "facet selection" in "asg-ida-dev-versions" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get "File count without version" from "S3Cataloger/testFiles/CSV" in bucket "asg-ida-dev-versions" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page
    And user enters the search text "AmazonS3Explicit" and clicks on search
    And user performs "facet selection" in "asg-ida-dev" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Rule" attribute under "Metadata Type" facets in Item Search results page
    And user get "rule count" from "S3Cataloger/testFiles/CSV" in bucket "asg-ida-dev" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page
    And user enters the search text "AmazonS3Explicit" and clicks on search
    And user performs "facet selection" in "asg-ida-dev-versions" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Rule" attribute under "Metadata Type" facets in Item Search results page
    And user get "rule count" from "S3Cataloger/testFiles/CSV" in bucket "asg-ida-dev-versions" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page

#  @sanityrun
#  Scenario:AmazonS3_Delete Configurations
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type   | url                                                      | body | response code | response message | jsonPath |
#      | application/json | raw   | false | Delete | settings/credentials/sanityS3Credential                  |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonS3DataSource/S3SanityDataSource |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonS3Cataloger/S3SanityConfig      |      | 204           |                  |          |
