Feature:Amazon Redshift cataloger,Analyzer and Post Processor sanity run scenarios


  @sanityrun
  Scenario:Redshift_Update credential payload json for Amazon Redshift
    Given User update the below "redshift credentials" in following files using json path
      | filePath                                           | username    | password    |
      | ida/AmazonRedShiftPayloads/CredentialsSuccess.json | $..userName | $..password |

  @sanityrun
  Scenario Outline:Redshift_Update Credential,Data Source,plugin configuration and run Redshift plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | bodyFile                                      | path                                    | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/sanityRedshiftCredential                                                    | payloads/ida/sanityPayloads/credentials.json  | $.RedshiftCredentials                   | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonRedshiftDataSource/sanityRedshiftDataSource                             | payloads/ida/sanityPayloads/datasource.json   | $.RedshiftDataSource.configurations.[0] | 204           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonRedshiftCataloger/SanityRedShiftGLCataloger                             | payloads/ida/sanityPayloads/pluginconfig.json | $.RedshiftDataConfig.configurations     | 204           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/SanityRedShiftCataloger  |                                               |                                         | 200           | IDLE             | $.[?(@.configurationName=='SanityRedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/SanityRedShiftCataloger   |                                               |                                         | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/SanityRedShiftCataloger  |                                               |                                         | 200           | IDLE             | $.[?(@.configurationName=='SanityRedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonRedshiftAnalyzer/SanityRedshiftAnalyzer                                 | payloads/ida/sanityPayloads/pluginconfig.json | $.RedshiftALDataConfig.configurations   | 204           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/SanityRedshiftAnalyzer |                                               |                                         | 200           | IDLE             | $.[?(@.configurationName=='SanityRedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/SanityRedshiftAnalyzer  |                                               |                                         | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/SanityRedshiftAnalyzer |                                               |                                         | 200           | IDLE             | $.[?(@.configurationName=='SanityRedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonRedshiftPostProcessor/SanityRedshiftPP                                  | payloads/ida/sanityPayloads/pluginconfig.json | $.RedshiftPostProcessor.configurations  | 204           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/lineage/AmazonRedshiftPostProcessor/SanityRedshiftPP    |                                               |                                         | 200           | IDLE             | $.[?(@.configurationName=='SanityRedshiftPP')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/lineage/AmazonRedshiftPostProcessor/SanityRedshiftPP     |                                               |                                         | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/lineage/AmazonRedshiftPostProcessor/SanityRedshiftPP    |                                               |                                         | 200           | IDLE             | $.[?(@.configurationName=='SanityRedshiftPP')].status        |


  @sanityrun @webtest
  Scenario:Redshift_Validate the data type counts in redshift cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "RedshiftExplicit" and clicks on search
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField               | columnName        | queryOperation | facet         | facetValue | count      |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getMutliSchemaTableCount | count(schemaname) | returnValue    | Metadata Type | Table      | fromSource |
      |              |              |               |                          |                          |                   |                | Metadata Type | Schema     | 3          |
      |              |              |               |                          |                          |                   |                | Metadata Type | Cluster    | 1          |
      |              |              |               |                          |                          |                   |                | Metadata Type | Host       | 1          |
      |              |              |               |                          |                          |                   |                | Metadata Type | Service    | 1          |
      |              |              |               |                          |                          |                   |                | Metadata Type | Database   | 1          |
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Column     |
      | Table      |
      | Analysis   |
      | Database   |
      | Constraint |
      | Cluster    |
      | Service    |
      | Schema     |
      | Host       |

  @webtest @sanityrun
  Scenario:Redshift_Validate Redshift Analyzer Statistics
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "citycomplexview" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "citycomplexview" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW          | Description |
      | Created by        | master        | Description |
      | Number of rows    | 18            | Statistics  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | VARCHAR | city  | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName |
      | Length                        | 256           | Statistics |
      | Maximum length                | 14            | Statistics |
      | Maximum value                 | Utrecht       | Statistics |
      | Minimum length                | 4             | Statistics |
      | Minimum value                 | Amsterdam     | Statistics |
      | Number of non null values     | 18            | Statistics |
      | Percentage of non null values | 100           | Statistics |
      | Number of null values         | 0             | Statistics |
      | Number of unique values       | 11            | Statistics |
      | Percentage of unique values   | 61.11         | Statistics |

  @sanityrun
  Scenario Outline:Redshift_Retrieve lineage information and compare with expected lineage results
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name                         | asg_scopeid | targetFile                      | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | viewfromsingletablewithcondt |             | response/sanity/lineageIDs.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                     | bodyFile                        | path                                           | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=OUT&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\sanity\lineageIDs.json | $.lineagePayLoads.viewfromsingletablewithcondt | 200           |                  | edges    | response\sanity\redshiftactlineage.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath                     |
      | Constant.REST_DIR/response/sanity/redshiftactlineage.json | viewfromsingletablewithcondt |
    Then user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                              | actualJson                                                |
      | Constant.REST_DIR/response/sanity/redshiftexplineage.json | Constant.REST_DIR/response/sanity/redshiftactlineage.json |

#  @sanityrun
#  Scenario:Redshift_Delete Configurations
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type   | url                                                                  | body | response code | response message | jsonPath |
#      | application/json | raw   | false | Delete | settings/credentials/sanityRedshiftCredential                        |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftDataSource/sanityRedshiftDataSource |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftCataloger/SanityRedShiftCataloger   |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftAnalyzer/SanityRedshiftAnalyzer     |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftPostProcessor/SanityRedshiftPP      |      | 204           |                  |          |
