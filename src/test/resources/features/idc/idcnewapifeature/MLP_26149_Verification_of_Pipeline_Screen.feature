@MLP-26149
Feature:MLP-26149:As a user, I need an option to Configure the Pipeline from the Diagram displayed in the Accordion Details section under Manage Pipeline Screen

  @redshift
  Scenario: Update AWS username and password from config file
    Given User update the below "redshift credentials" in following files using json path
      | filePath                                                       | username                             | password                             |
      | idc/IDx_DataSource_Credentials_Payloads/amazonCredentials.json | $.redshiftValidCredentials..userName | $.redshiftValidCredentials..password |

  @redshift
  Scenario: MLP-21009:Delete the Credentials
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                       | body | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/credentials/Redshift_Credentials |      |               |                  |          |              |          |

  @redshift
  Scenario Outline: Set the Credentials for Redshift and amazons3 Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | bodyFile                                                                     | path                       | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Redshift_Credentials   | payloads/idc/IDx_DataSource_Credentials_Payloads/amazonCredentials.json      | $.redshiftValidCredentials | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftDataSource | payloads/idc/IDx_DataSource_Credentials_Payloads/AmazonDataSourceConfig.json | $.RedshiftDataSource       | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonRedshiftDataSource |                                                                              |                            | 200           | RedshiftDataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftCataloger  | payloads/idc/IDX_PluginPayloads/AmazonPluginConfig.json                      | $.AmazonRedshiftCataloger  | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonRedshiftCataloger  |                                                                              |                            | 200           | RedShiftCataloger  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftAnalyzer   | payloads/idc/IDX_PluginPayloads/AmazonPluginConfig.json                      | $.AmazonRedshiftAnalyzer   | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonRedshiftAnalyzer   |                                                                              |                            | 200           | RedShiftAnalyzer   |          |

  @Git
  Scenario: Configure Git Collector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                      | body                                                                                      | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS          |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/TestGitCollector         |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/credentials/TestGitCredential                   |                                                                                           |               |                  |          |
      |                  |       |       | Put    | settings/credentials/TestGitCredential?allowUpdate=false | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_Username_Pasword_Credential_Config.json | 200           |                  |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/TestGitDS      | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_GitCollectorDS_Config.json              | 204           |                  |          |
      |                  |       |       | Put    | settings/analyzers/GitCollector/TestGitCollector         | idc/IDX_PluginPayloads/MLP-18458_GitCollector_Plugin_Config.json                          | 204           |                  |          |

  @Git
  Scenario: Put call for creating new pipeline
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                            | body                                                         | response code | response message | jsonPath    |
      | application/json |       |       | Put  | settings/pipelines/Pipeline2?allowUpdate=false | idc/IDX_PluginPayloads/MLP-26149_Pipeline_Configuration.json | 200           | Pipeline2        | $..['name'] |
      |                  |       |       | Get  | settings/pipelines/Pipeline2                   |                                                              | 200           | Pipeline2        | $..['name'] |
      |                  |       |       | Get  | settings/pipelines                             |                                                              | 200           | Pipeline2        |             |

  @redshift
  Scenario: MLP-21009:Delete the pipeline and configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                              | body | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/pipelines/Pipeline2                     |      | 200           |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS  |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/TestGitCollector |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/TestGitCredential           |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftDataSource      |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftCataloger       |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftAnalyzer        |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/Redshift_Credentials        |      |               |                  |          |              |          |
