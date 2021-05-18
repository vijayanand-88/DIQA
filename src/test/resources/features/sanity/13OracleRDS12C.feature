Feature: Oracle 12C RDS cataloger,Analyzer and lineage sanity run scenarios

  @sanityrun
  Scenario Outline:Oracle12C_Update Credential,Data Source,plugin configuration and run plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                          | bodyFile                                      | path                                     | response code | response message | jsonPath                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/oracleRDSCredentials                                                    | payloads/ida/sanityPayloads/credentials.json  | $.oracleCredentials                      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBDataSource/sanityOracle12RDSDS                                    | payloads/ida/sanityPayloads/datasource.json   | $.OracleRDSDataSource.configurations.[0] | 204           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/SanityOracle12RDSCataloger                              | payloads/ida/sanityPayloads/pluginconfig.json | $.oracle12CRDSCataloger.configurations   | 204           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/SanityOracleAnalyzer                                     | payloads/ida/sanityPayloads/pluginconfig.json | $.oracle12CRDSAnalyzer.configurations    | 204           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBPostProcessor/SanityOracle12cRDSPP                                | payloads/ida/sanityPayloads/pluginconfig.json | $.oracle12CRDSPP.configurations          | 204           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/SanityOracle12RDSCataloger |                                               |                                          | 200           | IDLE             | $.[?(@.configurationName=='SanityOracle12RDSCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/SanityOracle12RDSCataloger  |                                               |                                          | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/SanityOracle12RDSCataloger |                                               |                                          | 200           | IDLE             | $.[?(@.configurationName=='SanityOracle12RDSCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/SanityOracleAnalyzer     |                                               |                                          | 200           | IDLE             | $.[?(@.configurationName=='SanityOracleAnalyzer')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/SanityOracleAnalyzer      |                                               |                                          | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/SanityOracleAnalyzer     |                                               |                                          | 200           | IDLE             | $.[?(@.configurationName=='SanityOracleAnalyzer')].status       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/lineage/OracleDBPostProcessor/SanityOracle12cRDSPP  |                                               |                                          | 200           | IDLE             | $.[?(@.configurationName=='SanityOracle12cRDSPP')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/lineage/OracleDBPostProcessor/SanityOracle12cRDSPP   |                                               |                                          | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/lineage/OracleDBPostProcessor/SanityOracle12cRDSPP  |                                               |                                          | 200           | IDLE             | $.[?(@.configurationName=='SanityOracle12cRDSPP')].status       |


  @webtest @sanityrun
  Scenario:Oracle12C_Validate Oracle Analyzer Statistics
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle12CRDSExplicit" and clicks on search
    And user performs "facet selection" in "EMPLOYEES [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "EMPLOYEES" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
      | Number of rows    | 107           | Statistics  |
      | bytes             | 65,536        | Statistics  |
      | totalBytes        | 65,536        | Statistics  |
      | totalBytes        | 65,536        | Statistics  |
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | EMPLOYEE_ID | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DECIMAL       | Description |
      | isEncrypted                   | NO            | Description |
      | columnType                    | table         | Description |
      | columnUsed                    | NO            | Description |
      | characterLength               | 0             | Description |
      | columnId                      | 1             | Description |
      | scale                         | 0             | Description |
      | datatypeName                  | NUMBER        | Description |
      | dataPrecision                 | 6             | Description |
      | Average                       | 153           | Statistics  |
      | Length                        | 22            | Statistics  |
      | Maximum value                 | 206           | Statistics  |
      | Median                        | 153           | Statistics  |
      | Minimum value                 | 100           | Statistics  |
      | Number of non null values     | 107           | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Standard deviation            | 31.03         | Statistics  |
      | Number of unique values       | 107           | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Variance                      | 963           | Statistics  |


  @sanityrun
  Scenario Outline:Oracle12C_user connects to database and retrieves Lineage Hops Ids in order ot find Source and Target Data
    Given user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type       | name   | asg_scopeid | targetFile                        | jsonpath    |
      | APPDBPOSTGRES | ID        | Default | Routine    | PROV2T |             | response/sanity/oraclePROV2T.json | $.RoutineID |
      | APPDBPOSTGRES | LineageID | Default | LineageHop |        |             | response/sanity/oraclePROV2T.json | $.RoutineID |


  @sanityrun
  Scenario Outline:Oracle12C_user retrieves the  Lineage From and Lineage To data for lineage hop ids
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user get source and target name from REST "<url>" for each "<item>" lineage hop ids from "<inputFile>" and store source and target  name in "<outputFile>"
    Examples:
      | url                                                                      | item   | inputFile                         | outputFile                                 |
      | searches/Default/query/queryDiagramOutRecursive/Default.LineageHop:::DYN | PROV2T | response/sanity/oraclePROV2T.json | response/sanity/oracle12ActualLineage.json |

  @sanityrun
  Scenario Outline:Oracle12C_User compares the expected lineage hops information with actual lineage hops
    Then user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                   | actualJson                                                   |
      | Constant.REST_DIR/response/sanity/oracle12ExpectedLineage.json | Constant.REST_DIR/response/sanity/oracle12ActualLineage.json |


#  @sanityrun
#  Scenario:Oracle12C_Delete Configurations
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type   | url                                                             | body | response code | response message | jsonPath |
#      | application/json | raw   | false | Delete | settings/credentials/oracleRDSCredentials                       |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/OracleDBDataSource/sanityOracle12RDSDS       |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/OracleDBCataloger/SanityOracle12RDSCataloger |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/OracleDBAnalyzer/SanityOracleAnalyzer        |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/OracleDBPostProcessor/SanityOracle12cRDSPP   |      | 204           |                  |          |
