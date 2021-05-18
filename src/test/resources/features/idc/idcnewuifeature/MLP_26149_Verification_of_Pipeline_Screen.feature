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

  #7194846
  @MLP-26149 @webtest @regression @positive
  Scenario:SC#1:MLP-26149: Verify user able to configure a pipeline and the respective pipeline accordion is displayed under the Manage pipelines screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Pipelines" in "Landing page"
    And user "click" on "Add Pipeline" button under "Manage Pipelines Table" in Manage Configurations
    And User performs following actions in the Pipeline Configurator Page
      | Actiontype                              | ActionItem           | ItemName                                        | Section           |
      | Enter Text                              | Pipeline Name        | Pipeline1                                       |                   |
      | Enter Text                              | Pipeline Description | This pipeline is running Amazon redshift plugin |                   |
      | Expand Accordion and Select Plugin Type | Collector            | Existing Configurations                         | TestGitCollector  |
      | Expand Accordion and Select Plugin Type | Cataloger            | Existing Configurations                         | RedShiftCataloger |
      | Expand Accordion and Select Plugin Type | Dataanalyzer         | Existing Configurations                         | RedShiftAnalyzer  |
      | Click                                   | Save                 |                                                 |                   |
    And User performs following actions in the Manage pipelines Page
      | Actiontype         | ActionItem                | ItemName  | Section |
      | Pipeline Accordion | Verify Pipeline Accordion | Pipeline1 |         |

  ##7194848##7194849##7194850##7194851##
  @MLP-26149 @webtest @regression @positive
  Scenario:SC#2:MLP-26149: Verify on expanding the accordion user able to see the options in the header of the accordion
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Pipelines" in "Landing page"
    And User performs following actions in the Manage pipelines Page
      | Actiontype         | ActionItem                 | ItemName                                                                                        | Section   |
      | Pipeline Accordion | Expand Accordion           | Pipeline1                                                                                       |           |
      | Pipeline Accordion | Verify Header Menu options | Edit the pipeline,Clone the pipeline,Schedule the pipeline,Delete the pipeline,Run the pipeline | Pipeline1 |
    And User performs following actions in the Manage pipelines Page
      | Actiontype                          | ActionItem                | ItemName                                        | Section          |
      | Verify Diagram Configuration Values | Status                    | warning                                         | RedShiftAnalyzer |
      | Pipeline Accordion                  | Click Header Menu options | Run the pipeline                                | Pipeline1        |
      | Pipeline Accordion                  | Verify Field Details      | Running..                                       | Status           |
      | Pipeline Accordion                  | Verify Field Details      | This pipeline is running Amazon redshift plugin | Description      |
      | Pipeline Accordion                  | Verify Field Details      | N/A                                             | Scheduled        |

  ##7194852##7194855##7194856##
  @MLP-26149 @webtest @regression @positive
  Scenario:SC#2:MLP-26149: Verify all the deatils are updated in the accordion
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Pipelines" in "Landing page"
    And User performs following actions in the Manage pipelines Page
      | Actiontype         | ActionItem           | ItemName  | Section        |
      | Pipeline Accordion | Expand Accordion     | Pipeline1 |                |
      | Pipeline Accordion | Verify Field Details |           | Last execution |
    And User performs following actions in the Manage pipelines Page
      | Actiontype                          | ActionItem                | ItemName          | Section          |
      | Verify Diagram Configuration Values | Status                    | warning           | RedShiftAnalyzer |
      | Pipeline Accordion                  | Click Header Menu options | Edit the pipeline | Pipeline1        |
    And user verifies the "Diagram Order" for "pipeline1" in "Pipeline Configurator page"
      | TestGitCollector | RedShiftCataloger | RedShiftAnalyzer |

    ##7194857##7194853##
  @MLP-26149 @webtest @regression @positive
  Scenario:SC#3:MLP-26149: Verify running any intermediate plugin should run the consecutive plugins
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Pipelines" in "Landing page"
    And user "click configuration menu buttons" for "Run the Configuration" in "Manage pipelines" Page
    And User performs following actions in the Manage pipelines Page
      | Actiontype         | ActionItem       | ItemName  | Section |
      | Pipeline Accordion | Expand Accordion | Pipeline1 |         |
    And User performs following actions in the Manage pipelines Page
      | Actiontype            | ActionItem           | ItemName              | Section          |
      | Diagram Configuration | Click diagram menu   | Run the configuration | TestGitCollector |
      | Pipeline Accordion    | Verify Field Details | Running..             | Status           |
    And User performs following actions in the Manage pipelines Page
      | Actiontype            | ActionItem         | ItemName                            | Section          |
      | Diagram Configuration | Click diagram menu | Shows the logs of the configuration | TestGitCollector |
    And user "verifies not presence" of following "Log text" in Manage Configurations Page
      | Plugin AmazonRedshiftCataloger Configuration |
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | Plugin GitCollector Configuration |
#
#  @redshift
#  Scenario: MLP-21009:Delete the pipeline and configurations
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type   | url                                                            | body | response code | response message | jsonPath | endpointType | itemName |
#      | application/json | raw   | false | Delete | settings/pipelines/Pipeline1                                   |      |               |                  |          |              |          |
#      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS                |      |               |                  |          |              |          |
#      |                  |       |       | Delete | settings/analyzers/GitCollector/TestGitCollector               |      |               |                  |          |              |          |
#      |                  |       |       | Delete | settings/credentials/TestGitCredential                         |      |               |                  |          |              |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftDataSource/RedshiftDataSource |      |               |                  |          |              |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftCataloger/RedShiftCataloger   |      |               |                  |          |              |          |
#      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftAnalyzer/RedShiftAnalyzer     |      |               |                  |          |              |          |
#      |                  |       |       | Delete | settings/credentials/Redshift_Credentials                      |      |               |                  |          |              |          |
