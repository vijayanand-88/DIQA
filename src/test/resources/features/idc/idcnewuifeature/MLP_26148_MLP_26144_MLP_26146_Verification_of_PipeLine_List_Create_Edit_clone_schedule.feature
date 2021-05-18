@MLP-26148 @MLP-26144 @e2e
Feature:MLP-26148 MLP-26144: This feature is to verify the list of pipeline configuration and to create, Edit , clone and schedule the configurations

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

  ##7165792##7165793##7165794##7165795##7165796##7165801##7248375#7248376
  @MLP-26144 @webtest @regression @positive
  Scenario:MLP-26144:SC#1:Verify the Add pipeline page with labels and text field and buttons
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Pipelines" in "Landing page"
    And user "click" on "Add Pipeline" button under "Manage Pipelines Table" in Manage Configurations
    And User performs following actions in the Pipeline Configurator Page
      | Actiontype                              | ActionItem           | ItemName                | Section            |
      | Enter Text                              | Pipeline Name        | TestPipeline            |                    |
      | Enter Text                              | Pipeline Description | TestDescriptionPipeline |                    |
      | Expand Accordion and Select Plugin Type | Collector            | New Configurations      | GitCollector       |
      | Expand Accordion and Select Plugin Type | Collector            | New Configurations      | LocalFileCollector |
    And user verifies "Save Button" is "disabled" in "Manage Pipelines page"
    And user verifies whether "New configuration" is "displayed" for "" Item view page
    And User performs following actions in the Pipeline Configurator Page
      | Actiontype                              | ActionItem | ItemName                | Section          |
      | Expand Accordion and Select Plugin Type | Collector  | Existing Configurations | TestGitCollector |
    And user "verifies displayed" in Add Pipelines Page
      | fieldName            | actionItem   | itemName                               |
      | Verify Pipeline Page | GitCollector | Edit the configuration                 |
      | Verify Pipeline Page | GitCollector | Remove the configuration from Pipeline |
    And user verifies "Plugin config Page" is "displayed" in "Pipeline Configurator page"
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem       | itemName               |
      | Verify Pipeline Page | TestGitCollector | Edit the configuration |
    And user "click" on "Close" button in "Manage Configuration page"
    And user "click" in Add Pipelines Page
      | fieldName              | actionItem       | itemName                               |
      | Verify Pipeline Page   | TestGitCollector | Remove the configuration from Pipeline |
      | Remove pipeline config | CANCEL           |                                        |
    And user "verifies displayed" in Add Pipelines Page
      | fieldName                        | actionItem       | itemName |
      | Verify plugin config in pipeline | TestGitCollector |          |
    And user "click" in Add Pipelines Page
      | fieldName              | actionItem       | itemName                               |
      | Verify Pipeline Page   | TestGitCollector | Remove the configuration from Pipeline |
      | Remove pipeline config | REMOVE           |                                        |
    And user "verifies not displayed" in Add Pipelines Page
      | fieldName                        | actionItem       | itemName |
      | Verify plugin config in pipeline | TestGitCollector |          |

    ##7165797##7165799##7165803##
  @MLP-26144 @webtest @regression @positive
  Scenario:MLP-26144:SC#2:Verify the user is able to save the pipeline with existing configurations.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Pipelines" in "Landing page"
    And user "click" on "Add Pipeline" button under "Manage Pipelines Table" in Manage Configurations
    And User performs following actions in the Pipeline Configurator Page
      | Actiontype                              | ActionItem           | ItemName                            | Section          |
      | Enter Text                              | Pipeline Name        | TestPipeline                        |                  |
      | Enter Text                              | Pipeline Description | This pipeline is running Git plugin |                  |
      | Expand Accordion and Select Plugin Type | Collector            | Existing Configurations             | TestGitCollector |
      | Click                                   | Save                 |                                     |                  |
    And User performs following actions in the Manage pipelines Page
      | Actiontype         | ActionItem                | ItemName     | Section |
      | Pipeline Accordion | Verify Pipeline Accordion | TestPipeline |         |

    ##7165798##7165800##
  @MLP-26144 @webtest @regression @positive
  Scenario:MLP-26144:SC#3:Verify the user is able to save the pipeline with new and existing configurations.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Pipelines" in "Landing page"
    And user "click" on "Add Pipeline" button under "Manage Pipelines Table" in Manage Configurations
    And User performs following actions in the Pipeline Configurator Page
      | Actiontype                              | ActionItem           | ItemName                | Section            |
      | Enter Text                              | Pipeline Name        | TestPipeline1           |                    |
      | Enter Text                              | Pipeline Description | TestDescriptionPipeline |                    |
      | Expand Accordion and Select Plugin Type | Collector            | New Configurations      | LocalFileCollector |
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem         | itemName               |
      | Verify Pipeline Page | LocalFileCollector | Edit the configuration |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Node      | InternalNode |
    And user "enter text" in the Add Configuration Page
      | fieldName | attribute   |
      | Name      | PipeLineLFC |
      | root      | C:\temp     |
    And user "click" on "Pipeline plugin Config Save" button in "Add Configuration page"
    And user "click" on "Save" button in "Manage Pipeline page"

    ##7165806##7165807##7165802##7248376
  @MLP-26144 @webtest @regression @positive
  Scenario:MLP-26144:SC#4:Verify the user is able to edit and Clone the pipeline  configurations.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Pipelines" in "Landing page"
    And User performs following actions in the Manage pipelines Page
      | Actiontype         | ActionItem       | ItemName      | Section |
      | Pipeline Accordion | Expand Accordion | TestPipeline1 |         |
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem    | itemName           |
      | Verify Pipeline Page | TestPipeline1 | Clone the pipeline |
    And user "click" on "Save" button in "Manage Pipeline page"
    And user "verifies displayed" in Add Pipelines Page
      | fieldName                        | actionItem         | itemName |
      | Verify plugin config in pipeline | TestPipeline1 Copy |          |

##7163597##7163598##7163599##7163601##7163603##7163604##7248376
  @MLP-26148 @webtest @regression @positive
  Scenario:MLP-26148:SC#5:Verify the user is able to view the pipeline descriptions in list view
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Pipelines" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button              | actionItem         |
      | Detail plugin panel | TestPipeline1 Copy |
    And user "verifies displayed" in Add Pipelines Page
      | fieldName          | actionItem     | itemName                |
      | Verify Label Items | Description    | TestDescriptionPipeline |
      | Verify Label Items | Status         | Idle                    |
      | Verify Label Items | Scheduled      | N/A                     |
      | Verify Label Items | Last Execution | N/A                     |
    And user "verifies displayed" in Add Pipelines Page
      | fieldName            | actionItem         | itemName            |
      | Verify Pipeline Page | TestPipeline1 Copy | Delete the pipeline |
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem         | itemName            |
      | Verify Pipeline Page | TestPipeline1 Copy | Delete the pipeline |
    And user "click" on "DELETE" button in "Add Configuration page"
    And user "verifies not displayed" in Add Pipelines Page
      | fieldName                        | actionItem         | itemName |
      | Verify plugin config in pipeline | TestPipeline1 Copy |          |

  ##7163607##
  @MLP-26148 @webtest @regression @positive
  Scenario:MLP-26148:SC#6:Verify the user is able to search pipeline  configurations.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Pipelines" in "Landing page"
    And user "click" on "Search Icon" in Manage Configurations panel
    And user "enters text" in Manage Configurations panel
      | TextBox    | Text         |
      | Search Box | TestPipeline |
    And user "verifies presence" of following "Items displayed for Configuration Filter" in Manage Configurations Page
      | TestPipeline |
    And user "enters text" in Manage Configurations panel
      | TextBox    | Text         |
      | Search Box | TESTPIPELINE |
    And user "verifies presence" of following "Items displayed for Configuration Filter" in Manage Configurations Page
      | TestPipeline |
    And user performs "click" operation in Manage Configurations panel
      | button              | actionItem    |
      | Detail plugin panel | TestPipeline1 |
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem    | itemName            |
      | Verify Pipeline Page | TestPipeline1 | Delete the pipeline |
    And user "click" on "DELETE" button in "Add Configuration page"
    And user performs "click" operation in Manage Configurations panel
      | button              | actionItem   |
      | Detail plugin panel | TestPipeline |
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem   | itemName            |
      | Verify Pipeline Page | TestPipeline | Delete the pipeline |
    And user "click" on "DELETE" button in "Add Configuration page"

  @MLP-26144@regression @positive
  Scenario:MLP-26144: Delete a configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                               | body | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/analyzers/LocalFileCollector/PipeLineLFC |      | 204           |                  |          |              |          |

  @MLP-26146@regression @positive
  Scenario Outline:SC#3 Create Credential and Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                             | body                                                                  | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/GitCred                                                    | /idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/credentials/GitCred                                                    |                                                                       | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollectorDataSource                                       | /idc/IDX_PluginPayloads/MLP-14102_GitCollector_DataSource_Config.json | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollectorDataSource                                       |                                                                       | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector/GitCollectorConfig                              | /idc/IDX_PluginPayloads/MLP-14104_GitCollector_Plugin_Config.json     | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector/GitCollectorConfig                              |                                                                       | 200           | GitCollectorConfig |          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |                                                                       | 200           | IDLE               |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorConfig  |                                                                       | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |                                                                       | 200           | IDLE               |          |

  Scenario Outline:SC#3 Create Pipeline
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                             | body                                      | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/pipelines/TestSchedule | /idc/Pipeline/CreatePipelineSchedule.json | 200           |                  |          |

    ##7179611##7179653##
  @MLP-26146 @webtest @regression @positive
  Scenario:MLP-26146:SC#7:Verify the user is able to schedule the pipeline from manage pipeline.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Pipelines" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button              | actionItem   |
      | Detail plugin panel | TestSchedule |
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem   | itemName              |
      | Verify Pipeline Page | TestSchedule | Schedule the pipeline |
    And user "select dropdown" in Add Data Source Page
      | fieldName          | attribute |
      | Plugin run repeats | Daily     |
      | Starting at        | 2         |
    And user "click" on "Save" button in "Add Schedule pop up"
    And user "verifies displayed" in Add Pipelines Page
      | fieldName          | actionItem | itemName                                                 |
      | Verify Label Items | Scheduled  | This pipeline is scheduled to run every day, at 2:00 AM. |

    ##7179611##7179631##7179659##
  @MLP-26146 @webtest @regression @positive
  Scenario:MLP-26146:SC#8:Verify the user is able to schedule the plugin from manage configurations.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user performs "click" operation in Manage Configurations panel
      | button              | actionItem         |
      | Detail plugin panel | GitCollectorConfig |
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem   | itemName                   |
      | Verify Pipeline Page | TestSchedule | Schedule the configuration |
    And user "select dropdown" in Add Data Source Page
      | fieldName          | attribute |
      | Plugin run repeats | Weekly    |
      | Starting at        | 3         |
    And user "click" on "Save" button in "Add Schedule pop up"
    And user "verifies displayed" in Add Pipelines Page
      | fieldName          | actionItem | itemName                                                    |
      | Verify Label Items | Scheduled  | This pipeline is scheduled to run every Sunday, at 3:00 AM. |

    ##7179611##7179634##
  @MLP-26146 @webtest @regression @positive
  Scenario:MLP-26146:SC#9:Verify the user is able to schedule the plugin from capture tab.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "TestScheduleBA" and clicks on search
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user performs "click" operation in Manage Configurations panel
      | button              | actionItem       |
      | Detail plugin panel | Demo Local Files |
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem   | itemName                   |
      | Verify Pipeline Page | TestSchedule | Schedule the configuration |
    And user "select dropdown" in Add Data Source Page
      | fieldName          | attribute |
      | Plugin run repeats | Monthly   |
      | Repeats every      | 5         |
      | Starting at        | 3         |
    And user "click" on "Save" button in "Add Schedule pop up"
    And user "verifies displayed" in Add Pipelines Page
      | fieldName          | actionItem | itemName                                                                   |
      | Verify Label Items | Scheduled  | This pipeline is scheduled to run every 5th day of the month, at 3:00 AM.. |

  @MLP-26146 @webtest @regression @positive
  Scenario:MLP-26146:SC#10:Verify the user is able to delete the scheduler
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Pipelines" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button              | actionItem   |
      | Detail plugin panel | TestSchedule |
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem   | itemName             |
      | Verify Pipeline Page | TestSchedule | Delete the scheduler |
    And user "click" on "DELETE" button in "Add Configuration page"

    ##7179636##7179655##7179656##7179657##
  @MLP-26146 @webtest @regression @positive
  Scenario:MLP-26146:SC#11:Verify the user is able to view the edit mode and setting of scheduler
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Pipelines" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button              | actionItem   |
      | Detail plugin panel | TestSchedule |
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem   | itemName              |
      | Verify Pipeline Page | TestSchedule | Schedule the pipeline |
    And user performs "click" operation in Manage Configurations panel
      | button         | actionItem |
      | Scheduler Type | advanced   |
      | Scheduler Type | basic      |
      | Scheduler Type | advanced   |
    And user "enter text in Scheudler" in Add Pipelines Page
      | fieldName             | actionItem | itemName |
      | Verify Cron scheduler | second     | 0        |
      | Verify Cron scheduler | minute     | 15       |
      | Verify Cron scheduler | hour       | 7        |
      | Verify Cron scheduler | day        | ?        |
      | Verify Cron scheduler | month      | *        |
      | Verify Cron scheduler | dayOfWeek  | *        |
    And user "click" on "Save" button in "Add Schedule pop up"
    And user "verifies displayed" in Add Pipelines Page
      | fieldName          | actionItem | itemName                                           |
      | Verify Label Items | Scheduled  | This configuration is scheduled to run at 07:15 AM |
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem   | itemName             |
      | Verify Pipeline Page | TestSchedule | Delete the scheduler |
    And user "click" on "DELETE" button in "Add Configuration page"

  ##7191258##7191271##
  @MLP-26702 @webtest @regression @positive
  Scenario:SC#12:MLP-26702: Verify that the log of node level.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user "click" on "Logs of nodes" button under "LocalNode" in Manage Configurations
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | INFO |
    And user "select type" in Log Viewer in Manage Configurations
      | fieldName | attribute |
      | INFO      |           |
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | INFO |

  ##7191273##7191274##
  @MLP-26702 @webtest @regression @positive
  Scenario:SC#13:MLP-26702: Verify that the calender icon  of node level logs.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user "click" on "Logs of nodes" button under "LocalNode" in Manage Configurations
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel
    And user verifies "Calender Icon" is "displayed" in Manage Configurations panel
    And user "verifies presence" of following "Date is greyed when that date has log" in Manage Configurations Page
      |  |
    And user verifies "Day which has no log" is "disabled" in Add Configuration Page

  ##7191279##7191280##
  @MLP-26702 @webtest @regression @positive
  Scenario:SC#13:MLP-26702: Verify that the expand/collapse of filter in logs page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user "click" on "Logs of nodes" button under "LocalNode" in Manage Configurations
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel
    And user performs "click" operation in Manage Configurations panel
      | button                    | actionItem |
      | ExpandCollapse Log filter | Type       |
      | ExpandCollapse Log filter | Time       |
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | INFO |

    ##7198298##7198300##7198301##7198302##
  @MLP-27836 @webtest @regression @positive
  Scenario:SC#14:MLP-27836: Verify refresh icon in BA itemview and Configuration accordion
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user performs following actions in the header
      | actionType | actionItem |
      | click      | Refresh    |
    And user enters the search text "TestScheduleBA" and clicks on search
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user performs following actions in the header
      | actionType | actionItem |
      | click      | Refresh    |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name           | type                | query | param |
      | SingleItemDelete | Default | TestScheduleBA | BusinessApplication |       |       |

  @MLP-26146 @webtest @regression @positive
  Scenario:MLP-26146: Delete a data source and a credential
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/GitCred                       |      |               |                  |          |              |          |


    ##7261317####MLPQA-3306## ##7261318####MLPQA-3305##
  @MLP-29589 @webtest @regression @positive
  Scenario:MLP-29589:SC#1:Verify the Leading and trailing error message in pipeline configurations.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Pipelines" in "Landing page"
    And user "click" on "Add Pipeline" button under "Manage Pipelines Table" in Manage Configurations
    And User performs following actions in the Pipeline Configurator Page
      | Actiontype | ActionItem    | ItemName | Section |
      | Enter Text | Pipeline Name | /\       |         |
    And User performs following actions in the Manage pipelines Page
      | Actiontype         | ActionItem           | ItemName                                   | Section |
      | Pipeline Accordion | Inline Error Message | Invalid item name. Leading/trailing blanks |         |

    ##7261318####MLPQA-3307##
  @MLP-29589 @webtest @regression @positive
  Scenario:MLP-29589:SC#2:Verify the Add icon for new plugin configurations in add pipeline page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Pipelines" in "Landing page"
    And user "click" on "Add Pipeline" button under "Manage Pipelines Table" in Manage Configurations
    And User performs following actions in the Pipeline Configurator Page
      | Actiontype                              | ActionItem           | ItemName                | Section            |
      | Expand Accordion and Select Plugin Type | Collector            | New Configurations      | LocalFileCollector |
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem         | itemName               |
      | Verify Pipeline Page | LocalFileCollector | Add the configuration |

  ##MLPQA-3553##7236655##MLPQA-3554##7236654##MLPQA-3555##MLPQA-3556##7236652##7236653##
  @MLP-26740 @webtest @regression @positive
  Scenario:MLP-26740:SC#1:Verify the user is able to verify search text with new close icon.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Pipelines" in "Landing page"
    And user "click" on "Search Icon" in Manage Configurations panel
    And user "enters text" in Manage Configurations panel
      | TextBox    | Text         |
      | Search Box | TestPipeline |
    And user "verifies displayed" on "Search close Icon" in Manage Configurations panel
    And user "click" on "Search close Icon" in Manage Configurations panel
    And user "verifies not displayed" on "Search Box" in Manage Configurations panel
    And user "click" on "Search Icon" in Manage Configurations panel
    And user "verifies displayed" on "Search Box" in Manage Configurations panel


  ##7261369##MLPQA-3281##7261366##MLPQA-3284##7261373##MLPQA-3278##
  @MLP-29594 @webtest @regression @positive
  Scenario:MLP-29594:SC#1:Verify the created by and modified by in  pipeline page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Pipelines" in "Landing page"
    And user "click" on "Add Pipeline" button under "Manage Pipelines Table" in Manage Configurations
    And User performs following actions in the Pipeline Configurator Page
      | Actiontype                              | ActionItem           | ItemName                | Section            |
      | Enter Text                              | Pipeline Name        | TestPipeline1           |                    |
      | Enter Text                              | Pipeline Description | TestDescriptionPipeline |                    |
      | Expand Accordion and Select Plugin Type | Collector            | New Configurations      | LocalFileCollector |
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem         | itemName               |
      | Verify Pipeline Page | LocalFileCollector | Add the configuration |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute    |
      | Node      | InternalNode |
    And user "enter text" in the Add Configuration Page
      | fieldName | attribute   |
      | Name      | PipeLineLFC |
      | root      | C:\temp     |
    And user "click" on "Pipeline plugin Config Save" button in "Add Configuration page"
    And user "click" on "Save" button in "Manage Pipeline page"
    And user "verifies displayed" in Add Pipelines Page
      | fieldName          | actionItem   | itemName   |
      | Verify Label Items | Created by:  | TestSystem |
      | Verify Label Items | Modified by: | TestSystem |
    And user clicks on logout button
    When user enter credentials for "Becubic User" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Pipelines" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button              | actionItem   |
      | Detail plugin panel | TestPipeline1 |
    And user "click" in Add Pipelines Page
      | fieldName            | actionItem   | itemName          |
      | Verify Pipeline Page | TestPipeline1 | Edit the pipeline |
    And user "click" on "Save" button in "Manage Pipeline page"
    And user "verifies displayed" in Add Pipelines Page
      | fieldName          | actionItem   | itemName   |
      | Verify Label Items | Created by:  | TestSystem |
      | Verify Label Items | Modified by: |  becubic_build  |

 ##7261370##MLPQA-3280##7261367##MLPQA-3283##
  @MLP-29594 @webtest @regression @positive
  Scenario:MLP-29594:SC#2:Verify the created by and modified by in  config page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute          |
      | Type      | Collector          |
      | Plugin    | LocalFileCollector |
    And user "enter text" in the Add Configuration Page
      | fieldName | attribute   |
      | Name      | TestLFC |
      | root      | C:\temp     |
    And user "click" on "ConfigSave" button in "Add Configuration page"
    And user performs "click" operation in Manage Configurations panel
      | button      | actionItem         |
      | Open Plugin | TestLFC |
    And user "verifies displayed" in Add Pipelines Page
      | fieldName          | actionItem   | itemName   |
      | Verify Label Items | Created by:  | TestSystem |
      | Verify Label Items | Modified by: | TestSystem |
    And user clicks on logout button
    When user enter credentials for "Becubic User" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion and click menu option" operation in Manage Configurations panel
      | button    | actionItem | attribute | itemName               |
      | LocalNode | Collector  | TestLFC   | Edit the configuration |
    And user "enter text" in the Add Configuration Page
      | fieldName | attribute   |
      | root      | C:\temp1     |
    And user "click" on "ConfigSave" button in "Add Configuration page"
    And user "verifies displayed" in Add Pipelines Page
      | fieldName          | actionItem   | itemName   |
      | Verify Label Items | Created by:  | TestSystem |
      | Verify Label Items | Modified by: | becubic_build |

  @pipeline
  Scenario: MLP-29594:Delete the pipeline and configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                              | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/pipelines/TestPipeline1 |      |            |                  |          |

  @LocalFile
  Scenario: MLP-29594:Delete the LocalFile Collector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                               | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/LocalFileCollector/TestLFC     |      |               |                  |          |

  @MLP-30340@regression @positive
  Scenario Outline:SC#3  Local File Collector creation
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body                                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                               | /idc/MLP_30340/LocalFileCollector_DeleteConfig.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/LocalFileCollector                                               |                                                                  | 200           |                  |          |

  @MLP-30340 @regression @positive
  Scenario: SC1#:MLP-30340: Add the new Pipeline configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                       | body                            | response code | response message | jsonPath |
      | application/json |       |       | Put  | settings/pipelines/DeleteRestrictPipeline | /idc/MLP_30340/AddPipeline.json | 200           |                  |          |
      |                  |       |       | Get  | settings/pipelines/DeleteRestrictPipeline |                                 | 200           |                  |          |

  ##MLPQA-3266##MLPQA-3267##
  @MLP-30340 @webtest @regression @positive
  Scenario:MLP-30340:SC#1:Verify the plugin delete when added in pipeline config
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "Expand accordion and click menu option" operation in Manage Configurations panel
      | button    | actionItem | attribute                 | itemName              |
      | LocalNode | Collector  | DeleteLocalFile | Delete the configuration |
    And user "click" on "DELETE" button in "Add Configuration page"
    And User performs following actions in the Manage pipelines Page
      | Actiontype       | ActionItem    | ItemName                                                                                                                      | Section |
      | Plugin Accordion | Plugin Error Message | You cannot delete the plugin configuration DeleteLocalFile. This plugin configuration is currently available in one or more pipelines. |         |

  @Git@MLP-30340
  Scenario: Configure Git Collector for Delete scenrarios
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                      | body                                                                                      | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS          |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/TestGitCollector         |                                                                                           |               |                  |          |
      |                  |       |       | Delete | settings/credentials/TestGitCredential                   |                                                                                           |               |                  |          |
      |                  |       |       | Put    | settings/credentials/TestGitCredential?allowUpdate=false | idc/MLP_30340/MLP-14658_Username_Pasword_Credential_Config.json | 200           |                  |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/TestGitDS      | idc/MLP_30340/MLP-14658_GitCollectorDS_Config.json              | 204           |                  |          |
      |                  |       |       | Put    | settings/analyzers/GitCollector/TestGitCollector         | idc/MLP_30340/MLP-18458_GitCollector_Plugin_Config.json                          | 204           |                  |          |

    ##MLPQA-3262##MLPQA-3263##MLPQA-3264##MLPQA-3265##
  @MLP-30340 @webtest @regression @positive
  Scenario:MLP-30340:SC#2:Verify the Data Source and credential delete when added in pipeline config
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Landing page"
    And user "click configuration menu buttons" in "Manage Configurations" Page
      | fieldName              | option    |
      | Delete the data source | TestGitDS |
    And user "click" on "DELETE" button in "Data Sources page"
    And User performs following actions in the Manage pipelines Page
      | Actiontype       | ActionItem           | ItemName                                                                                                                                      | Section |
      | Plugin Accordion | Plugin Error Message | You cannot delete the data source configuration TestGitDS. A plugin configuration is currently available with this data source configuration. |         |
    And user press "ESCAPE" key using key press event
    And user "click" on "Capture and Import Data & Configure" for "Manage Credentials" in "Landing page"
    And user "click configuration menu buttons" in "Manage Configurations" Page
      | fieldName             | option            |
      | Delete the credential | TestGitCredential |
    And user "click" on "DELETE" button in "Credentials page"
    And User performs following actions in the Manage pipelines Page
      | Actiontype       | ActionItem           | ItemName                                                                                                                | Section |
      | Plugin Accordion | Plugin Error Message | You cannot delete the credential TestGitCredential. A plugin configuration is currently available with this credential. |         |