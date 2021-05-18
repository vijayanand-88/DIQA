Feature: Dynamo DB cataloger and Analyzer sanity run scenarios


  @sanityrun
  Scenario:DynamoDB_Update the aws credential Json
    Given User update the below "DynamoDB Readonly credentials" in following files using json path
      | filePath                            | accessKeyPath                    | secretKeyPath                    |
      | ida/sanityPayloads/credentials.json | $.DynamoDBCredentials..accessKey | $.DynamoDBCredentials..secretKey |

  @sanityrun
  Scenario:DynamoDB_Create new table in Dynamo DB using DynamoDB Util
    Given user connects to AWS Dynamo database and perform the following operation
      | action      | jsonPath                                  |
      | createTable | ida/sanityPayloads/CreateDynamoTable.json |
    And user connects to AWS Dynamo database and perform the following operation
      | action     | tableName | jsonPath                                   |
      | createItem | Demo      | ida/sanityPayloads/CreateTableRecords.json |

  @sanityrun
  Scenario Outline:DynamoDB_Update Credential,Data Source,plugin configuration and run plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                      | path                                    | response code | response message | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       | false | Put          | settings/credentials/dynamoDBCredential                                                    | payloads/ida/sanityPayloads/credentials.json  | $.DynamoDBCredentials                   | 200           |                  |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DynamoDBDataSource/SanityDynamoDBDS                                     | payloads/ida/sanityPayloads/datasource.json   | $.DynamoDBDataSource.configurations.[0] | 204           |                  |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger/SanityDynamoConfig                                    | payloads/ida/sanityPayloads/pluginconfig.json | $.DynamoDBCataloger.configurations      | 204           |                  |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer/SanityDynamoDBAnalyzer                                 | payloads/ida/sanityPayloads/pluginconfig.json | $.DynamoDBAnalyzer.configurations       | 204           |                  |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/SanityDynamoConfig       |                                               |                                         | 200           | IDLE             | $.[?(@.configurationName=='SanityDynamoConfig')].status     |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/SanityDynamoConfig        |                                               |                                         | 200           |                  |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/SanityDynamoConfig       |                                               |                                         | 200           | IDLE             | $.[?(@.configurationName=='SanityDynamoConfig')].status     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/SanityDynamoDBAnalyzer |                                               |                                         | 200           | IDLE             | $.[?(@.configurationName=='SanityDynamoDBAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/SanityDynamoDBAnalyzer  |                                               |                                         | 200           |                  |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/SanityDynamoDBAnalyzer |                                               |                                         | 200           | IDLE             | $.[?(@.configurationName=='SanityDynamoDBAnalyzer')].status |

  @sanityrun @webtest
  Scenario:DynamoDB_Validate the file counts of each S3 buckets
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DynamoDBExplicit" and clicks on search
    And user performs "facet selection" in "DynamoDBExplicit" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis   |
      | Column     |
      | Constraint |
      | Table      |
      | Database   |
      | Service    |
      | Host       |
      | Cluster    |
    And user performs "facet selection" in "AllDataTypes[Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user connects to AWS Dynamo database and perform the following operation
      | action        | tableName    |
      | getColumnList | AllDataTypes |
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | tempStoredValue |

  @sanityrun
  Scenario:DynamoDB_Delete the Tables created in AWS DynamoDB
    Given user connects to AWS Dynamo database and perform the following operation
      | action      | jsonPath                               |
      | deleteTable | ida/sanityPayloads/deleteDynamoDB.json |

#  @sanityrun
#  Scenario Outline:DynamoDB_Deleting the Credentials
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                     | body | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/dynamoDBCredential                 |      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/DynamoDBDataSource/SanityDynamoDBDS  |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/DynamoDBCataloger/SanityDynamoConfig |      | 204           |                  |          |
#
