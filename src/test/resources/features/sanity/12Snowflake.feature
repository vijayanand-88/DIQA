Feature: Snowflake DB cataloger,Analyzer and lineage sanity run scenarios

  @sanityrun
  Scenario Outline:Snowflake_Update Credential,Data Source,plugin configuration and run plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile                                      | path                                     | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/snowflakeCredentials                                                      | payloads/ida/sanityPayloads/credentials.json  | $.snowflakeCredentials                   | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBDataSource/sanitySnowflakeDS                                     | payloads/ida/sanityPayloads/datasource.json   | $.snowflakeDataSource.configurations.[0] | 204           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBCataloger/SanitySnowflakeDBConfig                                | payloads/ida/sanityPayloads/pluginconfig.json | $.snowFlakeCataloger.configurations      | 204           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBAnalyzer/SanitySnowflakeAnalyzer                                 | payloads/ida/sanityPayloads/pluginconfig.json | $.snowflakeAnalyzer.configurations       | 204           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/SnowflakeDBPostProcessor/sanitySnowflakePP                                  | payloads/ida/sanityPayloads/pluginconfig.json | $.snowFlakePostProcessor.configurations  | 204           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SanitySnowflakeDBConfig   |                                               |                                          | 200           | IDLE             | $.[?(@.configurationName=='SanitySnowflakeDBConfig')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/SnowflakeDBCataloger/SanitySnowflakeDBConfig    |                                               |                                          | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SnowflakeDBCataloger/SanitySnowflakeDBConfig   |                                               |                                          | 200           | IDLE             | $.[?(@.configurationName=='SanitySnowflakeDBConfig')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SanitySnowflakeAnalyzer |                                               |                                          | 200           | IDLE             | $.[?(@.configurationName=='SanitySnowflakeAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SanitySnowflakeAnalyzer  |                                               |                                          | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/SnowflakeDBAnalyzer/SanitySnowflakeAnalyzer |                                               |                                          | 200           | IDLE             | $.[?(@.configurationName=='SanitySnowflakeAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/lineage/SnowflakeDBPostProcessor/sanitySnowflakePP    |                                               |                                          | 200           | IDLE             | $.[?(@.configurationName=='sanitySnowflakePP')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/lineage/SnowflakeDBPostProcessor/sanitySnowflakePP     |                                               |                                          | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/lineage/SnowflakeDBPostProcessor/sanitySnowflakePP    |                                               |                                          | 200           | IDLE             | $.[?(@.configurationName=='sanitySnowflakePP')].status       |


  @sanityrun @webtest
  Scenario:Snowflake_Validate the data type counts in snowflake cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SnowflakeExplicit" and clicks on search
    And user performs "facet selection" in "asg_partner.us-east-1.snowflakecomputing.com[Cluster]" attribute under "Hierarchy" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage        | queryField               | columnName | queryOperation | facet         | facetValue | count      |
      | SNOWFLAKE    | STRUCTURED   | json/IDA.json | snowFlakeQueries | getSchemaTableCount      | count(*)   | returnValue    | Metadata Type | Table      | fromSource |
      | SNOWFLAKE    | STRUCTURED   | json/IDA.json | snowFlakeQueries | getSchemaColumnCount     | count(*)   | returnValue    | Metadata Type | Column     | fromSource |
      | SNOWFLAKE    | STRUCTURED   | json/IDA.json | snowFlakeQueries | getSchemaConstraintCount | count(*)   | returnValue    | Metadata Type | Constraint | fromSource |
      |              |              |               |                  |                          |            |                | Metadata Type | Schema     | 1          |
      |              |              |               |                  |                          |            |                | Metadata Type | Database   | 1          |
      |              |              |               |                  |                          |            |                | Metadata Type | Cluster    | 1          |
      |              |              |               |                  |                          |            |                | Metadata Type | Host       | 1          |
      |              |              |               |                  |                          |            |                | Metadata Type | Service    | 1          |


  @webtest @sanityrun
  Scenario:Snowflake_Validate Snowflake Analyzer Statistics
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EMPLOYEE_DATA" and clicks on search
    And user performs "facet selection" in "SnowflakeExplicit" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "EMPLOYEE_DATA" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
      | Created by        | PUBLIC        | Description |
      | Number of rows    | 10            | Statistics  |
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | EMPLOYEE_ID | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName |
      | Average                       | 55            | Statistics |
      | Length                        | 38            | Statistics |
      | Maximum value                 | 100           | Statistics |
      | Median                        | 55            | Statistics |
      | Minimum value                 | 10            | Statistics |
      | Number of non null values     | 10            | Statistics |
      | Percentage of non null values | 100           | Statistics |
      | Number of null values         | 0             | Statistics |
      | Standard deviation            | 30.28         | Statistics |
      | Number of unique values       | 10            | Statistics |
      | Percentage of unique values   | 100           | Statistics |
      | Variance                      | 916.67        | Statistics |

  @sanityrun
  Scenario Outline:Snowflake_Retrieve lineage information and compare with expected lineage results
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name            | asg_scopeid | targetFile                      | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | CITYCOMPLEXVIEW |             | response/sanity/lineageIDs.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                      | bodyFile                        | path                              | response code | response message | jsonPath | targetFile                               |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\sanity\lineageIDs.json | $.lineagePayLoads.CITYCOMPLEXVIEW | 200           |                  | edges    | response\sanity\snowflakeactlineage.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                   | JsonPath        |
      | Constant.REST_DIR/response/sanity/snowflakeactlineage.json | CITYCOMPLEXVIEW |
    Then user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                               | actualJson                                                 |
      | Constant.REST_DIR/response/sanity/snowflakeexplineage.json | Constant.REST_DIR/response/sanity/snowflakeactlineage.json |

#  @sanityrun
#  Scenario:Snowflake_Delete Configurations
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type   | url                                                             | body | response code | response message | jsonPath |
#      | application/json | raw   | false | Delete | settings/credentials/snowflakeCredentials                       |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/SnowflakeDBDataSource/sanitySnowflakeDS      |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/SnowflakeDBCataloger/SanitySnowflakeDBConfig |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/SnowflakeDBAnalyzer/SanitySnowflakeAnalyzer  |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/SnowflakeDBPostProcessor/sanitySnowflakePP   |      | 204           |                  |          |
