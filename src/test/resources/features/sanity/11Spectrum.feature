Feature:Amazon Spectrum cataloger,Analyzer and linker sanity run scenarios


  @sanityrun
  Scenario:Spectrum_Update credential payload json for Amazon Redshift
    Given User update the below "redshift credentials" in following files using json path
      | filePath                                           | username    | password    |
      | ida/AmazonRedShiftPayloads/CredentialsSuccess.json | $..userName | $..password |

  @sanityrun
  Scenario Outline:Spectrum_Update Credential,Data Source,plugin configuration and run plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | bodyFile                                      | path                                       | response code | response message | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/sanitySpectrumCredential                                                    | payloads/ida/sanityPayloads/credentials.json  | $.SpectrumCredentials                      | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonSpectrumDataSource/SanitySpectrumDataSource                             | payloads/ida/sanityPayloads/datasource.json   | $.SpectrumDataSource.configurations.[0]    | 204           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonSpectrumCataloger/SanitySpectrumCataloger                               | payloads/ida/sanityPayloads/pluginconfig.json | $.SpectrumConfig.configurations            | 204           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SanitySpectrumCataloger  |                                               |                                            | 200           | IDLE             | $.[?(@.configurationName=='SanitySpectrumCataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonSpectrumCataloger/SanitySpectrumCataloger   |                                               |                                            | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonSpectrumCataloger/SanitySpectrumCataloger  |                                               |                                            | 200           | IDLE             | $.[?(@.configurationName=='SanitySpectrumCataloger')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonSpectrumAnalyzer/SanitySpectrumAnalyzer                                 | payloads/ida/sanityPayloads/pluginconfig.json | $.SpectrumALConfig.configurations          | 204           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/SanitySpectrumAnalyzer |                                               |                                            | 200           | IDLE             | $.[?(@.configurationName=='SanitySpectrumAnalyzer')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/SanitySpectrumAnalyzer  |                                               |                                            | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonSpectrumAnalyzer/SanitySpectrumAnalyzer |                                               |                                            | 200           | IDLE             | $.[?(@.configurationName=='SanitySpectrumAnalyzer')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/credentials/SpecCSVCredentials                                                          | payloads/ida/sanityPayloads/credentials.json  | $.S3Credentials                            | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvS3DataSource/spectrumcsvdatasource                                         | payloads/ida/sanityPayloads/datasource.json   | $.spectrumcsvdatasource.configurations.[0] | 204           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/CsvS3Cataloger/SanitySpecCSVS3Cataloger                                       | payloads/ida/sanityPayloads/pluginconfig.json | $.spectrumcsvConfig.configurations         | 204           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/SanitySpecCSVS3Cataloger          |                                               |                                            | 200           | IDLE             | $.[?(@.configurationName=='SanitySpecCSVS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CsvS3Cataloger/SanitySpecCSVS3Cataloger           |                                               |                                            | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CsvS3Cataloger/SanitySpecCSVS3Cataloger          |                                               |                                            | 200           | IDLE             | $.[?(@.configurationName=='SanitySpecCSVS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonSpectrumLinker/SanitySpectrumCSVLinker                                  | payloads/ida/sanityPayloads/pluginconfig.json | $.SpectrumLinker.configurations            | 204           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/SanitySpectrumCSVLinker        |                                               |                                            | 200           | IDLE             | $.[?(@.configurationName=='SanitySpectrumCSVLinker')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/linker/AmazonSpectrumLinker/SanitySpectrumCSVLinker         |                                               |                                            | 200           |                  |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/linker/AmazonSpectrumLinker/SanitySpectrumCSVLinker        |                                               |                                            | 200           | IDLE             | $.[?(@.configurationName=='SanitySpectrumCSVLinker')].status  |


  @sanityrun @webtest
  Scenario: Spectrum_Validate the data type counts in Spectrum cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SpectrumExplicit" and clicks on search
    And user performs "facet selection" in "Redshift Spectrum" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage                      | queryField                | columnName        | queryOperation | facet         | facetValue | count      |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | AmazonSpectrumCatalogerQueries | getSchemaTableCountSanity | count(schemaname) | returnValue    | Metadata Type | Table      | fromSource |
      |              |              |               |                                |                           |                   |                | Metadata Type | Schema     | 3          |
      |              |              |               |                                |                           |                   |                | Metadata Type | Cluster    | 1          |
      |              |              |               |                                |                           |                   |                | Metadata Type | Host       | 1          |
      |              |              |               |                                |                           |                   |                | Metadata Type | Service    | 1          |
      |              |              |               |                                |                           |                   |                | Metadata Type | Database   | 1          |
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Column   |
      | Table    |
      | Analysis |
      | Database |
      | Cluster  |
      | Service  |
      | Schema   |
      | Host     |

  @webtest @sanityrun
  Scenario: Spectrum_Validate Spectrum Analyzer Statistics
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "exttagdetails" and clicks on search
    And user performs "facet selection" in "SpectrumExplicit" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "exttagdetails" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                          | widgetName  |
      | Location          | s3://asgredshiftworlddata/Redshift-Data/extTagdetails/ | Description |
      | Table Type        | EXTERNAL                                               | Description |
      | Number of rows    | 4                                                      | Statistics  |
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | email | click and switch tab | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue    | widgetName |
      | Maximum length                | 16               | Statistics |
      | Maximum value                 | lmessi@gmail.com | Statistics |
      | Minimum length                | 16               | Statistics |
      | Minimum value                 | cambie@gmail.com | Statistics |
      | Number of non null values     | 4                | Statistics |
      | Percentage of non null values | 100              | Statistics |
      | Number of null values         | 0                | Statistics |
      | Number of unique values       | 4                | Statistics |
      | Percentage of unique values   | 100              | Statistics |


  @sanityrun
  Scenario Outline:Spectrum_Retrieve lineage information and compare with expected lineage results
    Given user retrieves all lineage hops values for below parameters
      | database      | retrive              | catalog | type  | lineageFlow  | name  | asg_scopeid | targetFile                      | jsonpath |
      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Table | Table-->hops | city2 |             | response/sanity/lineageIDs.json |          |
    And user hits the following API with given parameters and store the api response in file
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                      | bodyFile                        | path                    | response code | response message | jsonPath | targetFile                              |
      | IDC         | TestSystemUser | application/json |       |       | Post | lineages/Default?dir=BOTH&lineageDepth=0&exclude=MULTIHOP&excludeUnusedViewColumns=false | response\sanity\lineageIDs.json | $.lineagePayLoads.city2 | 200           |                  | edges    | response\sanity\spectrumactlineage.json |
    And user retrieves the name of each id stored in files with below parameters
      | fileName                                                  | JsonPath |
      | Constant.REST_DIR/response/sanity/spectrumactlineage.json | city2    |
    Then user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                              | actualJson                                                |
      | Constant.REST_DIR/response/sanity/spectrumexplineage.json | Constant.REST_DIR/response/sanity/spectrumactlineage.json |

#  @sanityrun
#  Scenario:Spectrum_Delete Configurations
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type   | url                                                                  | body | response code | response message | jsonPath |
#      | application/json | raw   | false | Delete | settings/credentials/sanitySpectrumCredential                        |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/credentials/SpecCSVCredentials                              |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonSpectrumDataSource/SanitySpectrumDataSource |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonSpectrumCataloger/SanitySpectrumCataloger   |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonSpectrumAnalyzer/SanitySpectrumAnalyzer     |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/CsvS3DataSource/SanityGlueLinker                  |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/CsvS3Cataloger/SanityGlueLinker                   |      | 204           |                  |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonSpectrumLinker/SanityGlueLinker             |      | 204           |                  |          |