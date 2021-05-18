@MLP-14104 @MLP-14102 @MLP-15889 @MLP-16162
Feature:MLP-14104 MLP-14102 MLP-15889 MLP-16162: This feature is to verify whether as As an IDA admin, I want to select the day of the log when viewing analyzer log files
  As an Ida Admin I want to filter logs by message type within the log view

  @git
  Scenario: Create Datasource Credentials and Configuration for GitCollector
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                             | username    | password    |
      | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | $..userName | $..password |
    And Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body                                                                 | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                       |                                                                      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |                                                                      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig |                                                                      |               |                  |          |              |          |
      |                  |       |       | Put    | settings/credentials/GitCred                       | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | 200           |                  |          |              |          |
      |                  |       |       | Get    | settings/credentials/GitCred                       |                                                                      | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/GitDS    | idc/IDX_PluginPayloads/MLP-14102_GitCollector_DataSource_Config.json | 204           |                  |          |              |          |
      |                  |       |       | Get    | settings/analyzers/GitCollectorDataSource/GitDS    |                                                                      | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollector/GitCollectorConfig | idc/IDX_PluginPayloads/MLP-14104_GitCollector_Plugin_Config.json     | 204           |                  |          |              |          |

  @git @precondition
  Scenario:SC1#Run the Git Collector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message |
      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           |                  |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorConfig  |      | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           |                  |

  ##6852337##6852338##6852339##6852340##
  @MLP-14104 @webtest @regression @positive
  Scenario:SC#1:MLP-14104: Verify the completion messages with result for all plugin execution actions
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion and click menu option" operation in Manage Configurations panel
      | button    | actionItem | attribute          | itemName                            |
      | LocalNode | Collector  | GitCollectorConfig | Shows the logs of the configuration |
    And user "verifies presence" of following "Log Breadcrumbs" in Manage Configurations Page
      | Manage Configurations        |
      | Log for "GitCollectorConfig" |
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | ANALYSIS-GIT |

  @aws @precondition
  Scenario: Update Avro Cataloger with
    Given User update the below "aws credentials" in following files using json path
      | filePath                                                              | accessKeyPath | secretKeyPath |
      | idc/IDX_PluginPayloads/MLP-14102_AvroCataloger_Credential_Config.json | $..accessKey  | $..secretKey  |

  @jdbc
  Scenario: Create Datasource and Credentials for AvroS3Cataloger
    Given Execute REST API with following parameters
      | Header           | Query | Param | type      | url                                              | body                                                                  | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete    | settings/credentials/AWSS3Credential             |                                                                       |               |                  |          |              |          |
      |                  |       |       | PDeleteut | settings/analyzers/AvroS3DataSource/AvroS3DemoDS |                                                                       |               |                  |          |              |          |
      |                  |       |       | Put       | settings/credentials/AWSS3Credential             | idc/IDX_PluginPayloads/MLP-14102_AvroCataloger_Credential_Config.json | 200           |                  |          |              |          |
      |                  |       |       | Get       | settings/credentials/AWSS3Credential             |                                                                       | 200           |                  |          |              |          |
      |                  |       |       | Put       | settings/analyzers/AvroS3DataSource/AvroS3DemoDS | idc/IDX_PluginPayloads/MLP-14102_AvroCataloger_DataSource_Config.json | 204           |                  |          |              |          |
      |                  |       |       | Get       | settings/analyzers/AvroS3DataSource/AvroS3DemoDS |                                                                       | 200           |                  |          |              |          |

  @git
  Scenario:SC2#Configure the Avro plugin and Run
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body                                                              | response code | response message |
      | application/json | raw   | false | Put          | settings/analyzers/AvroS3Cataloger/AvroS3DemoCataloger1                              | idc/IDX_PluginPayloads/MLP-14102_AvroCataloger_Plugin_Config.json | 204           |                  |
      |                  |       |       | Get          | settings/analyzers/AvroS3Cataloger/AvroS3DemoCataloger1                              |                                                                   | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3DemoCataloger1 |                                                                   | 200           |                  |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AvroS3Cataloger/AvroS3DemoCataloger1  |                                                                   | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AvroS3Cataloger/AvroS3DemoCataloger1 |                                                                   | 200           |                  |


  ##6896434## ##6896436##6896437##6896438####6896440####6896442####6896443##6898581## - combined common scenarios into single scenario #####
  @MLP-14102 @webtest @regression @positive
  Scenario:SC#2:MLP-14102: Verify that the log shows all message types when there no filter is selected.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion and click menu option" operation in Manage Configurations panel
      | button    | actionItem | attribute            | itemName                            |
      | LocalNode | Cataloger  | AvroS3DemoCataloger1 | Shows the logs of the configuration |
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | INFO |
      | WARN |
    And user "select type" in Log Viewer in Manage Configurations
      | fieldName | attribute |
      | WARN      |           |
    And user "verifies not presence" of following "Log text" in Manage Configurations Page
      | INFO |
    And user "select type" in Log Viewer in Manage Configurations
      | fieldName | attribute |
      | WARN      |           |
      | INFO      |           |
    And user "verifies not presence" of following "Log text" in Manage Configurations Page
      | WARN |
    And user "click" on "Type checkbox" in "Manage Configurations Log Viewer"
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | INFO |
      | WARN |
    And user "select type" in Log Viewer in Manage Configurations
      | fieldName | attribute |
      | INFO      |           |
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | WARN |
    And user "click" on "Type checkbox" in "Manage Configurations Log Viewer"
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | INFO |
      | WARN |
    And user verifies the Log Text is displayed according to "latest" time selected in Configurations Log page


  @git
  Scenario:SC4#Config the GitCollector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                | body                                                             | response code | response message |
      | application/json | raw   | false | Put  | settings/analyzers/GitCollector/GitCollectorConfig | idc/IDX_PluginPayloads/MLP-15889_GitCollector_Plugin_Config.json | 204           |                  |
      |                  |       |       | Get  | settings/analyzers/GitCollector/GitCollectorConfig |                                                                  | 200           |                  |


  @git @precondition
  Scenario:SC4#Run the Git Collector first time
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message |
      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           |                  |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorConfig  |      | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           |                  |


  @MLP-15889 @regression @positive
  Scenario:MLP-15889: Run the Git Collector for the second time
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message |
      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           |                  |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorConfig  |      | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           |                  |

  @MLP-15889 @regression @positive
  Scenario:MLP-15889: Run the Git Collector for the third time
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message |
      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           |                  |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorConfig  |      | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           |                  |

  @git
  Scenario:SC5#Config the GitCollector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                     | body                                                                   | response code | response message |
      | application/json | raw   | false | Put  | settings/analyzers/GitCollector/GitCollectorConfigError | idc/IDX_PluginPayloads/MLP-15889_GitCollector_Error_Plugin_Config.json | 204           |                  |
      |                  |       |       | Get  | settings/analyzers/GitCollector/GitCollectorConfigError |                                                                        | 200           |                  |

  @MLP-15889 @regression @positive
  Scenario:SC5# Run the Git Collector with error
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body | response code | response message |
      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfigError |      | 200           |                  |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorConfigError  |      | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfigError |      | 200           |                  |


  ##6898451##6901433##6898471####6898455##6898458##6901356##6901417##
  @MLP-15889 @webtest @regression @positive
  Scenario:SC#6:MLP-15889: Verification of last error log of plugin in log view page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion and click menu option" operation in Manage Configurations panel
      | button    | actionItem | attribute            | itemName                            |
      | LocalNode | Cataloger  | AvroS3DemoCataloger1 | Shows the logs of the configuration |
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel
    And user "verifies presence" of following "Colored border for selected date" in Manage Configurations Page
      | rgba(229, 237, 246, 1) |
    And user "select type" in Log Viewer in Manage Configurations
      | fieldName | attribute |
      | INFO      |           |
    And user "verifies not presence" of following "Log text" in Manage Configurations Page
      | ERROR |
    And user verifies "Calender Icon" is "displayed" in Manage Configurations panel
    And user "verifies presence" of following "Date is greyed when that date has log" in Manage Configurations Page
      |  |
    And user verifies "Day which has no log" is "disabled" in Add Configuration Page
    And user verifies the Log Text is displayed according to "oldest" time selected in Configurations Log page


  ##7095789##
  @MLP-23168 @webtest @regression @positive
  Scenario:SC#1:MLP-23168: While creating plugin configuration, the Advanced Setting - Tags filed should not display the Technology and PII tags
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute          |
      | Type      | Collector          |
      | Plugin    | LocalFileCollector |
    And user "click" on "Advanced Settings" button in Add Configuration Page
    And user "click" in Add Configuration Page in Manage Configurations
      | fieldName                             | attribute |
      | Add Invalid tags in Advanced Settings | PII       |
    And user "verifies not presence" of following "Advanced Setting Tags" in Manage Configurations Page
      | PII |
    And user "click" in Add Configuration Page in Manage Configurations
      | fieldName                             | attribute  |
      | Add Invalid tags in Advanced Settings | Technology |
    And user "verifies not presence" of following "Advanced Setting Tags" in Manage Configurations Page
      | Technology |

  @precondition
  @regression @positive
  Scenario: Configure Git Collector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                      | body                                                                                      | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS          |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/TestGitCollector         |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/credentials/TestGitCredential                   |                                                                                           |               |                  |          |
      |                  |       |       | Put    | settings/credentials/TestGitCredential?allowUpdate=false | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_Username_Pasword_Credential_Config.json | 200           |                  |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/TestGitDS      | idc/IDx_DataSource_Credentials_Payloads/MLP-14658_GitCollectorDS_Config.json              | 204           |                  |          |
      |                  |       |       | Put    | settings/analyzers/GitCollector/TestGitCollector         | idc/IDX_PluginPayloads/MLP-18458_GitCollector_Plugin_Config.json                          | 204           |                  |          |

  ##7095790##
  @MLP-23168 @webtest @regression @positive
  Scenario:SC#2:MLP-23168: While editing plugin configuration, the Advanced Setting - Tags filed should not display the Technology and PII tags
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion and click menu option" operation in Manage Configurations panel
      | button    | actionItem | attribute        | itemName               |
      | LocalNode | Collector  | TestGitCollector | Edit the configuration |
    And user "click" on "Advanced Settings" button in Add Configuration Page
    And user "click" in Add Configuration Page in Manage Configurations
      | fieldName                             | attribute |
      | Add Invalid tags in Advanced Settings | PII       |
    And user "verifies not presence" of following "Advanced Setting Tags" in Manage Configurations Page
      | PII |
    And user "click" in Add Configuration Page in Manage Configurations
      | fieldName                             | attribute  |
      | Add Invalid tags in Advanced Settings | Technology |
    And user "verifies not presence" of following "Advanced Setting Tags" in Manage Configurations Page
      | Technology |

  @cr-data @sanity @positive
  Scenario:Delete Configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                     | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                            |      |               |                  |          |
      |                  |       |       | Delete | settings/credentials/AWSS3Credential                    |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource               |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/AvroS3DataSource                     |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfigError |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig      |      |               |                  |          |


