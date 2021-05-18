@MLP-27778
Feature:
  MLP-27778 - Integrate informatica exporter plugin into DD
  MLP-25497 - Rochade based scan and import plugins for informatica
  MLP-25499 - To create DD plugins for rochade based Post processor and reconcile informatica plugins

  ##########################################Informatica Exporter###############################################################################################################

  #7196286
  @webtest
  Scenario:SC01#Verify error message is displayed when mandatory fields are not entered in Exporter plugin configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | CAE-JS     |
    And user "click" on "Add Configuration" button under "CAE-JS" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                      |
      | Type      | Collector                      |
      | Plugin    | Scanner_for_Informatica_Export |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name*     | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName           | attribute |
      | PowerCenter client* | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName               | attribute |
      | PowerCenter repository* | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName              | attribute |
      | PowerCenter host name* | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName                | attribute |
      | PowerCenter port number* | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName              | attribute |
      | PowerCenter user name* | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName             | attribute |
      | User security domain* | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName      | attribute |
      | User password* | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName              | attribute |
      | Export folders filter* | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName                | attribute |
      | Export workflows filter* | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName                | validationMessage                                 |
      | Name*                    | Name field should not be empty                    |
      | PowerCenter client*      | PowerCenter client field should not be empty      |
      | PowerCenter repository*  | PowerCenter repository field should not be empty  |
      | PowerCenter host name*   | PowerCenter host name field should not be empty   |
      | PowerCenter port number* | PowerCenter port number field should not be empty |
      | PowerCenter user name*   | PowerCenter user name field should not be empty   |
      | User security domain*    | User security domain field should not be empty    |
      | User password*           | User password field should not be empty           |
      | Export folders filter*   | Export folders filter field should not be empty   |
      | Export workflows filter* | Export workflows filter field should not be empty |

    #7196287
  @webtest
  Scenario:SC02#Verify tool tip is displayed for all the fields in Exporter plugin configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | CAE-JS     |
    And user "click" on "Add Configuration" button under "CAE-JS" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                      |
      | Type      | Collector                      |
      | Plugin    | Scanner_for_Informatica_Export |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                    |
      | PowerCenter client*      |
      | PowerCenter repository*  |
      | PowerCenter host name*   |
      | PowerCenter port number* |
      | PowerCenter user name*   |
      | User security domain*    |
      | User password*           |
      | Export folders filter*   |
      | Export workflows filter* |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                     | Plugin configuration name                           |
      | Label                    | Plugin configuration extended label and description |
      | Business Application     | Business Application                                |
      | PowerCenter client*      | Path to Informatica PowerCenter client bin folder   |
      | PowerCenter repository*  | Informatica PowerCenter repository                  |
      | PowerCenter host name*   | Informatica PowerCenter host name                   |
      | PowerCenter port number* | Informatica PowerCenter port number                 |
      | PowerCenter user name*   | Informatica PowerCenter user name                   |
      | User security domain*    | User security domain                                |
      | User password*           | User password                                       |
      | Export connections       | Enable to export connections                        |
      | Export folders           | Enable to export folders                            |
      | Export workflows         | Enable to export workflows                          |
      | Export folders filter*   | Filter for selecting folders to export              |
      | Export workflows filter* | Filter for selecting workflows to export            |
      | Exclude folders filter   | Filter for selecting folders to exclude             |
      | Exclude workflows filter | Filter for selecting workflows to exclude           |

  #7196288
  Scenario Outline:SC03# Run Informatica exporter plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                     | bodyFile                                                          | path                  | response code | response message            | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Export                                                       | payloads/ida/InformaticaScannerPayloads/ExporterPluginConfig.json | $.LoggingLevel_Severe | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Export                                                       |                                                                   |                       | 200           | Informatica_Exporter_Severe |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                      |                                                                   |                       | 200           | UP                          | $.nodeStatus                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Severe |                                                                   |                       | 200           | IDLE                        | $.[?(@.configurationName=='Informatica_Exporter_Severe')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Severe  |                                                                   |                       | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Severe |                                                                   |                       | 200           | IDLE                        | $.[?(@.configurationName=='Informatica_Exporter_Severe')].status |

  #7196297 #7196288
  @webtest
  Scenario: SC03# - Verify the log details when "Logging Level" in Exporter plugin config is "SEVERE"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Exporter_Severe" and clicks on search
    Then the following tags "ROC,Informatica" should get displayed for the column "collector/Scanner_for_Informatica_Export/Informatica_Exporter_Severe"
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Export/Informatica_Exporter_Severe%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName | fileType |
      | log      | Content  |

    #7196970
  Scenario:SC3#Verify logging enhancements after the plugin run
    Given Analysis log "collector/Scanner_for_Informatica_Export/Informatica_Exporter_Severe%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | logCode       | pluginName                     | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0019 |                                |                |
      | INFO | Plugin Name:Scanner_for_Informatica_Export, Plugin Type:collector, Plugin Version:1.1.0, Node Name:CAE-JS, Host Name:DIQDATAINTEL01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:Informatica_Exporter_Severe                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0071 | Scanner_for_Informatica_Export | Plugin Version |
      | INFO | Plugin Scanner_for_Informatica_Export Configuration: ---  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: name: "Informatica_Exporter_Severe"  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: pluginVersion: "LATEST"  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: label:  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: : ""  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: catalogName: "Default"  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: eventClass: null  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: eventCondition: null  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: nodeCondition: "name==\"CAE-JS\""  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: maxWorkSize: 100  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: tags: []  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: pluginType: "collector"  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: dataSource: null  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: credential: null  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: businessApplicationName: null  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: dryRun: false  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: schedule: null  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: filter: null  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: InfaSecurityDomain: "Native"  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: ClassPath: "${rochade.project.home};${rochade.home}/scaninformatica/V226/lib/scanInfa2.jar;${rochade.home}/bin/ScanLogging.jar;"  2020-09-16 18:33:09.573 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: InfaExportFolders: true  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: InfaHost: "DIDSCANINF01V"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: RochadeBin: "${rochade.home}/bin"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: RochadePath: "${rochade.home}"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: PropertiesAndOutputPath: "${rochade.project.home}"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: type: "Collector"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: LogLevel: "SEVERE"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: InfaClient: "C:/Informatica/10.4.0/clients/PowerCenterClient/client/bin"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: InfaPort: "6005"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: InfaExportConnections: true  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: InfaExportFoldersFilter: ".*"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: JavaMemory: "1400m"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: pluginName: "Scanner_for_Informatica_Export"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: InfaExcludeFoldersFilter: ""  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: ScannerBin: "${rochade.home}/scaninformatica/V226/lib"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: InfaPassword: "4q19IDK2VYr/bR4v56e9R1DtUk5GvWsgK9ts8nZ0LWpoyPIb71UOf0kbjL8kODWaceDzt0jvjLZ+I+c53fm8Fg=="  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: InfaRepository: "6005"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: InfaExportWorkflowsFilter: ".*"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: InfaUser: "Training"  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: InfaExportWorkflows: true  2020-09-16 18:33:09.589 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Export Configuration: InfaExcludeWorkflowsFilter: "" | ANALYSIS-0073 | Scanner_for_Informatica_Export |                |
      | INFO | Plugin Scanner_for_Informatica_Export Start Time:2020-09-14 14:38:40.668, End Time:2020-09-14 14:38:41.239, Processed Count:0, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0072 | Scanner_for_Informatica_Export |                |
      | INFO | Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:00.571)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | ANALYSIS-0075 |                                |                |

  Scenario:SC3:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                  | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Export/Informatica_Exporter_Severe% | Analysis |       |       |

  #7196289
  Scenario Outline:SC04# Run Informatica exporter plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                      | bodyFile                                                          | path                   | response code | response message             | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Export                                                        | payloads/ida/InformaticaScannerPayloads/ExporterPluginConfig.json | $.LoggingLevel_Warning | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Export                                                        |                                                                   |                        | 200           | Informatica_Exporter_Warning |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                       |                                                                   |                        | 200           | UP                           | $.nodeStatus                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Warning |                                                                   |                        | 200           | IDLE                         | $.[?(@.configurationName=='Informatica_Exporter_Warning')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Warning  |                                                                   |                        | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Warning |                                                                   |                        | 200           | IDLE                         | $.[?(@.configurationName=='Informatica_Exporter_Warning')].status |

  @webtest
  Scenario: SC04# - Verify the log details when "Logging Level" in Exporter plugin config is "WARNING"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Exporter_Warning" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Export/Informatica_Exporter_Warning%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName | fileType |
      | log      | Content  |

  Scenario:SC4:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                   | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Export/Informatica_Exporter_Warning% | Analysis |       |       |

    #7196290
  Scenario Outline:SC05# Run Informatica exporter plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                   | bodyFile                                                          | path                | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Export                                                     | payloads/ida/InformaticaScannerPayloads/ExporterPluginConfig.json | $.LoggingLevel_Info | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Export                                                     |                                                                   |                     | 200           | Informatica_Exporter_Info |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                    |                                                                   |                     | 200           | UP                        | $.nodeStatus                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Info |                                                                   |                     | 200           | IDLE                      | $.[?(@.configurationName=='Informatica_Exporter_Info')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Info  |                                                                   |                     | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Info |                                                                   |                     | 200           | IDLE                      | $.[?(@.configurationName=='Informatica_Exporter_Info')].status |

  @webtest
  Scenario: SC05# - Verify the log details when "Logging Level" in Exporter plugin config is "INFO"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Exporter_Info" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Export/Informatica_Exporter_Info%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                   | fileType |
      | Exporter_scaninfa_Log.html | Content  |

  Scenario:SC5:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Export/Informatica_Exporter_Info% | Analysis |       |       |

    #7196291
  Scenario Outline:SC06# Run Informatica exporter plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                     | bodyFile                                                          | path                  | response code | response message            | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Export                                                       | payloads/ida/InformaticaScannerPayloads/ExporterPluginConfig.json | $.LoggingLevel_Config | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Export                                                       |                                                                   |                       | 200           | Informatica_Exporter_Config |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                      |                                                                   |                       | 200           | UP                          | $.nodeStatus                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Config |                                                                   |                       | 200           | IDLE                        | $.[?(@.configurationName=='Informatica_Exporter_Config')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Config  |                                                                   |                       | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Config |                                                                   |                       | 200           | IDLE                        | $.[?(@.configurationName=='Informatica_Exporter_Config')].status |

  @webtest
  Scenario: SC06# - Verify the log details when "Logging Level" in Exporter plugin config is "CONFIG"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Exporter_Config" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Export/Informatica_Exporter_Config%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                   | fileType |
      | Exporter_scaninfa_Log.html | Content  |

  Scenario:SC6:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                  | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Export/Informatica_Exporter_Config% | Analysis |       |       |

    #7196292
  Scenario Outline:SC07# Run Informatica exporter plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                   | bodyFile                                                          | path                | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Export                                                     | payloads/ida/InformaticaScannerPayloads/ExporterPluginConfig.json | $.LoggingLevel_Fine | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Export                                                     |                                                                   |                     | 200           | Informatica_Exporter_Fine |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                    |                                                                   |                     | 200           | UP                        | $.nodeStatus                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Fine |                                                                   |                     | 200           | IDLE                      | $.[?(@.configurationName=='Informatica_Exporter_Fine')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Fine  |                                                                   |                     | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Fine |                                                                   |                     | 200           | IDLE                      | $.[?(@.configurationName=='Informatica_Exporter_Fine')].status |

  @webtest
  Scenario: SC07# - Verify the log details when "Logging Level" in Exporter plugin config is "FINE"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Exporter_Fine" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Export/Informatica_Exporter_Fine%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                   | fileType |
      | Exporter_scaninfa_Log.html | Content  |

  Scenario:SC7:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Export/Informatica_Exporter_Fine% | Analysis |       |       |

    #7196293
  Scenario Outline:SC08# Run Informatica exporter plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                    | bodyFile                                                          | path                 | response code | response message           | jsonPath                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Export                                                      | payloads/ida/InformaticaScannerPayloads/ExporterPluginConfig.json | $.LoggingLevel_Finer | 204           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Export                                                      |                                                                   |                      | 200           | Informatica_Exporter_Finer |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                     |                                                                   |                      | 200           | UP                         | $.nodeStatus                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Finer |                                                                   |                      | 200           | IDLE                       | $.[?(@.configurationName=='Informatica_Exporter_Finer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Finer  |                                                                   |                      | 200           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Finer |                                                                   |                      | 200           | IDLE                       | $.[?(@.configurationName=='Informatica_Exporter_Finer')].status |

  @webtest
  Scenario: SC08# - Verify the log details when "Logging Level" in Exporter plugin config is "FINER"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Exporter_Finer" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Export/Informatica_Exporter_Finer%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                   | fileType |
      | Exporter_scaninfa_Log.html | Content  |

  Scenario:SC8:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Export/Informatica_Exporter_Finer% | Analysis |       |       |

    #7196294
  Scenario Outline:SC09# Run Informatica exporter plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                     | bodyFile                                                          | path                  | response code | response message            | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Export                                                       | payloads/ida/InformaticaScannerPayloads/ExporterPluginConfig.json | $.LoggingLevel_Finest | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Export                                                       |                                                                   |                       | 200           | Informatica_Exporter_Finest |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                      |                                                                   |                       | 200           | UP                          | $.nodeStatus                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Finest |                                                                   |                       | 200           | IDLE                        | $.[?(@.configurationName=='Informatica_Exporter_Finest')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Finest  |                                                                   |                       | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Finest |                                                                   |                       | 200           | IDLE                        | $.[?(@.configurationName=='Informatica_Exporter_Finest')].status |

  @webtest
  Scenario: SC09# - Verify the log details when "Logging Level" in Exporter plugin config is "FINEST"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Exporter_Finest" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Export/Informatica_Exporter_Finest%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                   | fileType |
      | Exporter_scaninfa_Log.html | Content  |

  Scenario:SC9:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                  | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Export/Informatica_Exporter_Finest% | Analysis |       |       |

    #7196295
  Scenario Outline:SC10# Run Informatica exporter plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                  | bodyFile                                                          | path               | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Export                                                    | payloads/ida/InformaticaScannerPayloads/ExporterPluginConfig.json | $.LoggingLevel_All | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Export                                                    |                                                                   |                    | 200           | Informatica_Exporter_All |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                   |                                                                   |                    | 200           | UP                       | $.nodeStatus                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_All |                                                                   |                    | 200           | IDLE                     | $.[?(@.configurationName=='Informatica_Exporter_All')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_All  |                                                                   |                    | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_All |                                                                   |                    | 200           | IDLE                     | $.[?(@.configurationName=='Informatica_Exporter_All')].status |

  @webtest
  Scenario: SC10# - Verify the log details when "Logging Level" in Exporter plugin config is "ALL"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Exporter_All" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Export/Informatica_Exporter_All%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                   | fileType |
      | Exporter_scaninfa_Log.html | Content  |

  Scenario:SC10:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                               | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Export/Informatica_Exporter_All% | Analysis |       |       |

    #7196296
  Scenario Outline:SC11# Run Informatica exporter plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                  | bodyFile                                                          | path               | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Export                                                    | payloads/ida/InformaticaScannerPayloads/ExporterPluginConfig.json | $.LoggingLevel_Off | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Export                                                    |                                                                   |                    | 200           | Informatica_Exporter_Off |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                   |                                                                   |                    | 200           | UP                       | $.nodeStatus                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Off |                                                                   |                    | 200           | IDLE                     | $.[?(@.configurationName=='Informatica_Exporter_Off')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Off  |                                                                   |                    | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Export/Informatica_Exporter_Off |                                                                   |                    | 200           | IDLE                     | $.[?(@.configurationName=='Informatica_Exporter_Off')].status |

  @webtest
  Scenario: SC11# - Verify the log details when "Logging Level" in Exporter plugin config is "OFF"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Exporter_Off" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Export/Informatica_Exporter_Off%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName | fileType |
      | log      | Content  |

  Scenario:SC11:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                               | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Export/Informatica_Exporter_Off% | Analysis |       |       |

    #############################################Informatica Scan#############################################################################################################################

  #7197287
  @webtest
  Scenario:SC11#Verify error message is displayed when mandatory fields are not entered in Informatica scan configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | CAE-JS     |
    And user "click" on "Add Configuration" button under "CAE-JS" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                    |
      | Type      | Collector                    |
      | Plugin    | Scanner_for_Informatica_Scan |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name*     | A         |
    And user press "BACK_SPACE" key using key press event
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName           | attribute |
      | Scanner input path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName           | validationMessage                            |
      | Name*               | Name field should not be empty               |
      | Scanner input path* | Scanner input path field should not be empty |
    And user should scroll to the left of the screen
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName         | attribute |
      | Scan output path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName         | validationMessage                          |
      | Scan output path* | Scan output path field should not be empty |

 #7197288
  @webtest
  Scenario:SC12#Verify tool tip is displayed for all the fields in Informatica Scan plugin configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | CAE-JS     |
    And user "click" on "Add Configuration" button under "CAE-JS" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                    |
      | Type      | Collector                    |
      | Plugin    | Scanner_for_Informatica_Scan |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*               |
      | Scanner input path* |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                 | Plugin configuration name                           |
      | Label                | Plugin configuration extended label and description |
      | Business Application | Business Application                                |
      | Scanner input path*  | Scanner input path to Informatica exported data     |
    And user should scroll to the left of the screen
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Scan output path*          |
      | Informatica scan Arguments |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Scan output path*          | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |
      | Informatica scan Arguments | Overrides default Informatica scan parameters                                                                                                                    |

#7197289
  Scenario Outline:SC13# Run Informatica scan plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | bodyFile                                                      | path                  | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Scan                                                   | payloads/ida/InformaticaScannerPayloads/ScanPluginConfig.json | $.LoggingLevel_Severe | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Scan                                                   |                                                               |                       | 200           | Informatica_Scan_Severe |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                |                                                               |                       | 200           | UP                      | $.nodeStatus                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Severe |                                                               |                       | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Scan_Severe')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Severe  |                                                               |                       | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Severe |                                                               |                       | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Scan_Severe')].status |

  #7197298, #7197299
  @webtest
  Scenario: SC13# - Verify the log details when "Logging Level" in Informatica Scan plugin config is "SEVERE"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Scan_Severe" and clicks on search
    Then the following tags "ROC,Informatica,Informatica_Scan_BA" should get displayed for the column "collector/Scanner_for_Informatica_Scan/Informatica_Scan_Severe"
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Scan/Informatica_Scan_Severe%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName | fileType |
      | log      | Content  |

    #7199082
  Scenario:SC13#Verify logging enhancements after the plugin run
    Given Analysis log "collector/Scanner_for_Informatica_Scan/Informatica_Scan_Severe%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | logCode       | pluginName                   | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0019 |                              |                |
      | INFO | Plugin Name:Scanner_for_Informatica_Scan, Plugin Type:collector, Plugin Version:1.1.0, Node Name:CAE-JS, Host Name:DIQDATAINTEL01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:Informatica_Scan_Severe                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0071 | Scanner_for_Informatica_Scan | Plugin Version |
      | INFO | Plugin Scanner_for_Informatica_Scan Configuration: ---  2020-09-16 19:24:35.307 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: name: "Informatica_Scan_Severe"  2020-09-16 19:24:35.307 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: pluginVersion: "LATEST"  2020-09-16 19:24:35.307 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: label:  2020-09-16 19:24:35.307 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: : ""  2020-09-16 19:24:35.307 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: catalogName: "Default"  2020-09-16 19:24:35.307 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: eventClass: null  2020-09-16 19:24:35.307 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: eventCondition: null  2020-09-16 19:24:35.307 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: nodeCondition: "name==\"CAE-JS\""  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: maxWorkSize: 100  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: tags: []  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: pluginType: "collector"  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: dataSource: null  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: credential: null  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: businessApplicationName: "Informatica_Scan_BA"  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: dryRun: false  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: schedule: null  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: filter: null  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: ScanInputPath: "C:\\Users\\Jayasree.v\\Documents\\scan"  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: ClassPath: "${rochade.project.home};${rochade.home}/scaninformatica/V226/lib/scanInfa2.jar;${rochade.home}/bin/ScanLogging.jar;"  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: RochadeBin: "${rochade.home}/bin"  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: JavaMemory: "512m"  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: pluginName: "Scanner_for_Informatica_Scan"  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: RochadePath: "${rochade.home}"  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: ScannerBin: "${rochade.home}/scaninformatica/V226/lib"  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: PropertiesAndOutputPath: "${rochade.project.home}"  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: arguments: []  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: type: "Collector"  2020-09-16 19:24:35.323 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Scan Configuration: LogLevel: "SEVERE" | ANALYSIS-0073 | Scanner_for_Informatica_Scan |                |
      | INFO | Plugin Scanner_for_Informatica_Scan Start Time:2020-09-16 19:24:35.307, End Time:2020-09-16 19:24:36.856, Processed Count:0, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0072 | Scanner_for_Informatica_Scan |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:01.549)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0020 |                              |                |

  Scenario:SC13:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                            | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Scan/Informatica_Scan_Severe% | Analysis |       |       |

    #7197290
  Scenario Outline:SC14# Run Informatica scan plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                | bodyFile                                                      | path                   | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Scan                                                    | payloads/ida/InformaticaScannerPayloads/ScanPluginConfig.json | $.LoggingLevel_Warning | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Scan                                                    |                                                               |                        | 200           | Informatica_Scan_Warning |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                 |                                                               |                        | 200           | UP                       | $.nodeStatus                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Warning |                                                               |                        | 200           | IDLE                     | $.[?(@.configurationName=='Informatica_Scan_Warning')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Warning  |                                                               |                        | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Warning |                                                               |                        | 200           | IDLE                     | $.[?(@.configurationName=='Informatica_Scan_Warning')].status |

  #7197290
  @webtest
  Scenario: SC14# - Verify the log details when "Logging Level" in Informatica Scan plugin config is "WARNING"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Scan_Warning" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Scan/Informatica_Scan_Warning%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                  | fileType |
      | scaninfa_Scanner_Log.html | Content  |

  Scenario:SC14:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Scan/Informatica_Scan_Warning% | Analysis |       |       |

#7197291
  Scenario Outline:SC14# Run Informatica scan plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                             | bodyFile                                                      | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Scan                                                 | payloads/ida/InformaticaScannerPayloads/ScanPluginConfig.json | $.LoggingLevel_Info | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Scan                                                 |                                                               |                     | 200           | Informatica_Scan_Info |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                              |                                                               |                     | 200           | UP                    | $.nodeStatus                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Info |                                                               |                     | 200           | IDLE                  | $.[?(@.configurationName=='Informatica_Scan_Info')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Info  |                                                               |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Info |                                                               |                     | 200           | IDLE                  | $.[?(@.configurationName=='Informatica_Scan_Info')].status |

  #7197291
  @webtest
  Scenario: SC15# - Verify the log details when "Logging Level" in Informatica Scan plugin config is "INFO"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Scan_Info" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Scan/Informatica_Scan_Info%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                  | fileType |
      | scaninfa_Scanner_Log.html | Content  |

  Scenario:SC15:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                          | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Scan/Informatica_Scan_Info% | Analysis |       |       |

    #7197292
  Scenario Outline:SC16# Run Informatica scan plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | bodyFile                                                      | path                  | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Scan                                                   | payloads/ida/InformaticaScannerPayloads/ScanPluginConfig.json | $.LoggingLevel_Config | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Scan                                                   |                                                               |                       | 200           | Informatica_Scan_Config |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                |                                                               |                       | 200           | UP                      | $.nodeStatus                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Config |                                                               |                       | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Scan_Config')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Config  |                                                               |                       | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Config |                                                               |                       | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Scan_Config')].status |

  #7197292
  @webtest
  Scenario: SC16# - Verify the log details when "Logging Level" in Informatica Scan plugin config is "CONFIG"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Scan_Config" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Scan/Informatica_Scan_Config%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                  | fileType |
      | scaninfa_Scanner_Log.html | Content  |

  Scenario:SC16:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                            | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Scan/Informatica_Scan_Config% | Analysis |       |       |

    #7197293
  Scenario Outline:SC17# Run Informatica scan plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                             | bodyFile                                                      | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Scan                                                 | payloads/ida/InformaticaScannerPayloads/ScanPluginConfig.json | $.LoggingLevel_Fine | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Scan                                                 |                                                               |                     | 200           | Informatica_Scan_Fine |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                              |                                                               |                     | 200           | UP                    | $.nodeStatus                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Fine |                                                               |                     | 200           | IDLE                  | $.[?(@.configurationName=='Informatica_Scan_Fine')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Fine  |                                                               |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Fine |                                                               |                     | 200           | IDLE                  | $.[?(@.configurationName=='Informatica_Scan_Fine')].status |

  #7197293
  @webtest
  Scenario: SC17# - Verify the log details when "Logging Level" in Informatica Scan plugin config is "FINE"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Scan_Fine" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Scan/Informatica_Scan_Fine%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                  | fileType |
      | scaninfa_Scanner_Log.html | Content  |

  Scenario:SC17:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                          | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Scan/Informatica_Scan_Fine% | Analysis |       |       |

    #7197294
  Scenario Outline:SC18# Run Informatica scan plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | bodyFile                                                      | path                 | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Scan                                                  | payloads/ida/InformaticaScannerPayloads/ScanPluginConfig.json | $.LoggingLevel_Finer | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Scan                                                  |                                                               |                      | 200           | Informatica_Scan_Finer |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                               |                                                               |                      | 200           | UP                     | $.nodeStatus                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Finer |                                                               |                      | 200           | IDLE                   | $.[?(@.configurationName=='Informatica_Scan_Finer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Finer  |                                                               |                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Finer |                                                               |                      | 200           | IDLE                   | $.[?(@.configurationName=='Informatica_Scan_Finer')].status |

  #7197294
  @webtest
  Scenario: SC18# - Verify the log details when "Logging Level" in Informatica Scan plugin config is "FINER"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Scan_Finer" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Scan/Informatica_Scan_Finer%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                  | fileType |
      | scaninfa_Scanner_Log.html | Content  |

  Scenario:SC18:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                           | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Scan/Informatica_Scan_Finer% | Analysis |       |       |

    #7197295
  Scenario Outline:SC19# Run Informatica scan plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | bodyFile                                                      | path                  | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Scan                                                   | payloads/ida/InformaticaScannerPayloads/ScanPluginConfig.json | $.LoggingLevel_Finest | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Scan                                                   |                                                               |                       | 200           | Informatica_Scan_Finest |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                |                                                               |                       | 200           | UP                      | $.nodeStatus                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Finest |                                                               |                       | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Scan_Finest')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Finest  |                                                               |                       | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Finest |                                                               |                       | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Scan_Finest')].status |

  #7197295
  @webtest
  Scenario: SC19# - Verify the log details when "Logging Level" in Informatica Scan plugin config is "FINEST"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Scan_Finest" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Scan/Informatica_Scan_Finest%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                  | fileType |
      | scaninfa_Scanner_Log.html | Content  |

  Scenario:SC19:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                            | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Scan/Informatica_Scan_Finest% | Analysis |       |       |

    #7197297
  Scenario Outline:SC20# Run Informatica scan plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile                                                      | path               | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Scan                                                | payloads/ida/InformaticaScannerPayloads/ScanPluginConfig.json | $.LoggingLevel_Off | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Scan                                                |                                                               |                    | 200           | Informatica_Scan_Off |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                             |                                                               |                    | 200           | UP                   | $.nodeStatus                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Off |                                                               |                    | 200           | IDLE                 | $.[?(@.configurationName=='Informatica_Scan_Off')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Off  |                                                               |                    | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_Off |                                                               |                    | 200           | IDLE                 | $.[?(@.configurationName=='Informatica_Scan_Off')].status |

  #7197297
  @webtest
  Scenario: SC20# - Verify the log details when "Logging Level" in Informatica Scan plugin config is "OFF"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Scan_Off" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Scan/Informatica_Scan_Off%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName | fileType |
      | log      | Content  |

  Scenario:SC20:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Scan/Informatica_Scan_Off% | Analysis |       |       |

    #7197296
  Scenario Outline:SC21# Run Informatica scan plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile                                                      | path               | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Scan                                                | payloads/ida/InformaticaScannerPayloads/ScanPluginConfig.json | $.LoggingLevel_All | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Scan                                                |                                                               |                    | 200           | Informatica_Scan_All |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                             |                                                               |                    | 200           | UP                   | $.nodeStatus                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_All |                                                               |                    | 200           | IDLE                 | $.[?(@.configurationName=='Informatica_Scan_All')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_All  |                                                               |                    | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/collector/Scanner_for_Informatica_Scan/Informatica_Scan_All |                                                               |                    | 200           | IDLE                 | $.[?(@.configurationName=='Informatica_Scan_All')].status |

  #7197296
  @webtest
  Scenario: SC21# - Verify the log details when "Logging Level" in Informatica Scan plugin config is "ALL"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Scan_All" and clicks on search
    And user performs "latest analysis click" in Item Results page for "collector/Scanner_for_Informatica_Scan/Informatica_Scan_All%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                  | fileType |
      | scaninfa_Scanner_Log.html | Content  |

  Scenario:SC21:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | SingleItemDelete | Default | collector/Scanner_for_Informatica_Scan/Informatica_Scan_All% | Analysis |       |       |

##########################################Informatica Import##########################################################################################################################################################

  #7199252
  @webtest
  Scenario:SC22#Verify error message is displayed when mandatory fields are not entered in Informatica import configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | CAE-JS     |
    And user "click" on "Add Configuration" button under "CAE-JS" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                      |
      | Type      | Other                          |
      | Plugin    | Scanner_for_Informatica_Import |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name*     | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name*     | Name field should not be empty |
    And user should scroll to the left of the screen
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName         | attribute |
      | Scan output path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName         | validationMessage                          |
      | Scan output path* | Scan output path field should not be empty |

 #7199253
  @webtest
  Scenario:SC23#Verify tool tip is displayed for all the fields in Informatica Import plugin configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | CAE-JS     |
    And user "click" on "Add Configuration" button under "CAE-JS" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                      |
      | Type      | Other                          |
      | Plugin    | Scanner_for_Informatica_Import |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                  |
      | Reset dependency links |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                   | Plugin configuration name                           |
      | Label                  | Plugin configuration extended label and description |
      | Business Application   | Business Application                                |
      | Reset dependency links | Should the dependency links be reset?               |
    And user should scroll to the left of the screen
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Scan output path* |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Scan output path* | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |

#7199254
  Scenario Outline:SC24# Run Informatica Import plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | bodyFile                                                        | path                  | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Import                                                 | payloads/ida/InformaticaScannerPayloads/ImportPluginConfig.json | $.LoggingLevel_Severe | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Import                                                 |                                                                 |                       | 200           | Informatica_Import_Severe |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                |                                                                 |                       | 200           | UP                        | $.nodeStatus                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Severe |                                                                 |                       | 200           | IDLE                      | $.[?(@.configurationName=='Informatica_Import_Severe')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Severe  |                                                                 |                       | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Severe |                                                                 |                       | 200           | IDLE                      | $.[?(@.configurationName=='Informatica_Import_Severe')].status |

  #7199254, #7199263
  @webtest
  Scenario: SC24# - Verify the log details when "Logging Level" in Informatica Import config is "SEVERE"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Import_Severe" and clicks on search
    Then the following tags "ROC,Informatica" should get displayed for the column "other/Scanner_for_Informatica_Import/Informatica_Import_Severe"
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Import/Informatica_Import_Severe%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                   | fileType |
      | scaninfa_importer-log.html | Content  |

    #7199265
  Scenario:SC24#Verify logging enhancements after the plugin run
    Given Analysis log "other/Scanner_for_Informatica_Import/Informatica_Import_Severe%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | logCode       | pluginName                     | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0019 |                                |                |
      | INFO | Plugin Name:Scanner_for_Informatica_Import, Plugin Type:other, Plugin Version:1.1.0, Node Name:CAE-JS, Host Name:DIQDATAINTEL01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:Informatica_Import_Severe                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0071 | Scanner_for_Informatica_Import | Plugin Version |
      | INFO | Plugin Scanner_for_Informatica_Import Configuration: ---  2020-09-18 17:05:42.212 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: name: "Informatica_Import_Severe"  2020-09-18 17:05:42.212 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: pluginVersion: "LATEST"  2020-09-18 17:05:42.212 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: label:  2020-09-18 17:05:42.212 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: : ""  2020-09-18 17:05:42.228 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: catalogName: "Default"  2020-09-18 17:05:42.231 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: eventClass: null  2020-09-18 17:05:42.233 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: eventCondition: null  2020-09-18 17:05:42.234 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: nodeCondition: "name==\"CAE-JS\""  2020-09-18 17:05:42.235 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: maxWorkSize: 100  2020-09-18 17:05:42.236 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: tags: []  2020-09-18 17:05:42.237 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: pluginType: "other"  2020-09-18 17:05:42.237 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: dataSource: null  2020-09-18 17:05:42.239 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: credential: null  2020-09-18 17:05:42.239 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: businessApplicationName: null  2020-09-18 17:05:42.240 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: dryRun: false  2020-09-18 17:05:42.240 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: schedule: null  2020-09-18 17:05:42.241 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: filter: null  2020-09-18 17:05:42.243 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: ClassPath: "${rochade.home}/bin/rochadexml.jar;${rochade.home}/bin/rochade.jar;${rochade.home}/bin/roacccxj.jar;${rochade.home}/bin/ScanLogging.jar"  2020-09-18 17:05:42.244 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: RochadeBin: "${rochade.home}/bin"  2020-09-18 17:05:42.250 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: RochadeServerHost: "${rochade.server}"  2020-09-18 17:05:42.250 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: JavaMemory: "1024m"  2020-09-18 17:05:42.250 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: pluginName: "Scanner_for_Informatica_Import"  2020-09-18 17:05:42.251 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: RochadePath: "${rochade.home}"  2020-09-18 17:05:42.252 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: PropertiesAndOutputPath: "${rochade.project.home}"  2020-09-18 17:05:42.252 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: type: "Other"  2020-09-18 17:05:42.252 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: LogLevel: "SEVERE"  2020-09-18 17:05:42.253 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: RochadeServerPort: "${rochade.port}"  2020-09-18 17:05:42.255 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Import Configuration: ResetDependencyLinks: false | ANALYSIS-0073 | Scanner_for_Informatica_Import |                |
      | INFO | Plugin Scanner_for_Informatica_Import Start Time:2020-09-18 17:05:42.165, End Time:2020-09-18 17:05:49.056, Processed Count:0, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0072 | Scanner_for_Informatica_Import |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:01.549)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0020 |                                |                |

  Scenario:SC24:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                            | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Import/Informatica_Import_Severe% | Analysis |       |       |

    #7199255
  Scenario Outline:SC25# Run Informatica Import plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                | bodyFile                                                        | path                   | response code | response message           | jsonPath                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Import                                                  | payloads/ida/InformaticaScannerPayloads/ImportPluginConfig.json | $.LoggingLevel_Warning | 204           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Import                                                  |                                                                 |                        | 200           | Informatica_Import_Warning |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                 |                                                                 |                        | 200           | UP                         | $.nodeStatus                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Warning |                                                                 |                        | 200           | IDLE                       | $.[?(@.configurationName=='Informatica_Import_Warning')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Warning  |                                                                 |                        | 200           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Warning |                                                                 |                        | 200           | IDLE                       | $.[?(@.configurationName=='Informatica_Import_Warning')].status |

  #7199255
  @webtest
  Scenario: SC25# - Verify the log details when "Logging Level" in Informatica Import config is "WARNING"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Import_Warning" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Import/Informatica_Import_Warning%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                   | fileType |
      | scaninfa_importer-log.html | Content  |

  Scenario:SC25:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Import/Informatica_Import_Warning% | Analysis |       |       |

    #7199256
  Scenario Outline:SC26# Run Informatica Import plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                             | bodyFile                                                        | path                | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Import                                               | payloads/ida/InformaticaScannerPayloads/ImportPluginConfig.json | $.LoggingLevel_Info | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Import                                               |                                                                 |                     | 200           | Informatica_Import_Info |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                              |                                                                 |                     | 200           | UP                      | $.nodeStatus                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Info |                                                                 |                     | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Import_Info')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Info  |                                                                 |                     | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Info |                                                                 |                     | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Import_Info')].status |

  #7199256
  @webtest
  Scenario: SC26# - Verify the log details when "Logging Level" in Informatica Import config is "INFO"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Import_Info" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Import/Informatica_Import_Info%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                   | fileType |
      | scaninfa_importer-log.html | Content  |

  Scenario:SC26:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                          | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Import/Informatica_Import_Info% | Analysis |       |       |

    #7199257
  Scenario Outline:SC27# Run Informatica Import plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | bodyFile                                                        | path                  | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Import                                                 | payloads/ida/InformaticaScannerPayloads/ImportPluginConfig.json | $.LoggingLevel_Config | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Import                                                 |                                                                 |                       | 200           | Informatica_Import_Config |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                |                                                                 |                       | 200           | UP                        | $.nodeStatus                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Config |                                                                 |                       | 200           | IDLE                      | $.[?(@.configurationName=='Informatica_Import_Config')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Config  |                                                                 |                       | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Config |                                                                 |                       | 200           | IDLE                      | $.[?(@.configurationName=='Informatica_Import_Config')].status |

  #7199257
  @webtest
  Scenario: SC27# - Verify the log details when "Logging Level" in Informatica Import config is "CONFIG"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Import_Config" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Import/Informatica_Import_Config%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                   | fileType |
      | scaninfa_importer-log.html | Content  |

  Scenario:SC27:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                            | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Import/Informatica_Import_Config% | Analysis |       |       |

    #7199258
  Scenario Outline:SC28# Run Informatica Import plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                             | bodyFile                                                        | path                | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Import                                               | payloads/ida/InformaticaScannerPayloads/ImportPluginConfig.json | $.LoggingLevel_Fine | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Import                                               |                                                                 |                     | 200           | Informatica_Import_Fine |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                              |                                                                 |                     | 200           | UP                      | $.nodeStatus                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Fine |                                                                 |                     | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Import_Fine')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Fine  |                                                                 |                     | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Fine |                                                                 |                     | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Import_Fine')].status |

  #7199258
  @webtest
  Scenario: SC28# - Verify the log details when "Logging Level" in Informatica Import config is "FINE"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Import_Fine" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Import/Informatica_Import_Fine%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                   | fileType |
      | scaninfa_importer-log.html | Content  |

  Scenario:SC28:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                          | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Import/Informatica_Import_Fine% | Analysis |       |       |

    #7199259
  Scenario Outline:SC29# Run Informatica Import plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | bodyFile                                                        | path                 | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Import                                                | payloads/ida/InformaticaScannerPayloads/ImportPluginConfig.json | $.LoggingLevel_Finer | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Import                                                |                                                                 |                      | 200           | Informatica_Import_Finer |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                               |                                                                 |                      | 200           | UP                       | $.nodeStatus                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Finer |                                                                 |                      | 200           | IDLE                     | $.[?(@.configurationName=='Informatica_Import_Finer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Finer  |                                                                 |                      | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Finer |                                                                 |                      | 200           | IDLE                     | $.[?(@.configurationName=='Informatica_Import_Finer')].status |

  #7199259
  @webtest
  Scenario: SC29# - Verify the log details when "Logging Level" in Informatica Import config is "FINER"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Import_Finer" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Import/Informatica_Import_Finer%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                   | fileType |
      | scaninfa_importer-log.html | Content  |

  Scenario:SC29:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                           | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Import/Informatica_Import_Finer% | Analysis |       |       |

    #7199260
  Scenario Outline:SC30# Run Informatica Import plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | bodyFile                                                        | path                  | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Import                                                 | payloads/ida/InformaticaScannerPayloads/ImportPluginConfig.json | $.LoggingLevel_Finest | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Import                                                 |                                                                 |                       | 200           | Informatica_Import_Finest |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                                |                                                                 |                       | 200           | UP                        | $.nodeStatus                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Finest |                                                                 |                       | 200           | IDLE                      | $.[?(@.configurationName=='Informatica_Import_Finest')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Finest  |                                                                 |                       | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Finest |                                                                 |                       | 200           | IDLE                      | $.[?(@.configurationName=='Informatica_Import_Finest')].status |

  #7199260
  @webtest
  Scenario: SC30# - Verify the log details when "Logging Level" in Informatica Import config is "FINEST"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Import_Finest" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Import/Informatica_Import_Finest%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                   | fileType |
      | scaninfa_importer-log.html | Content  |

  Scenario:SC30:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                            | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Import/Informatica_Import_Finest% | Analysis |       |       |

    #7199261
  Scenario Outline:SC31# Run Informatica Import plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile                                                        | path               | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Import                                              | payloads/ida/InformaticaScannerPayloads/ImportPluginConfig.json | $.LoggingLevel_All | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Import                                              |                                                                 |                    | 200           | Informatica_Import_All |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                             |                                                                 |                    | 200           | UP                     | $.nodeStatus                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_All |                                                                 |                    | 200           | IDLE                   | $.[?(@.configurationName=='Informatica_Import_All')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_All  |                                                                 |                    | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_All |                                                                 |                    | 200           | IDLE                   | $.[?(@.configurationName=='Informatica_Import_All')].status |

    #7199261
  @webtest
  Scenario: SC31# - Verify the log details when "Logging Level" in Informatica Import config is "ALL"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Import_All" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Import/Informatica_Import_All%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                   | fileType |
      | scaninfa_importer-log.html | Content  |

  Scenario:SC31:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Import/Informatica_Import_All% | Analysis |       |       |

    #7199262
  Scenario Outline:SC32# Run Informatica Import plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile                                                        | path               | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Import                                              | payloads/ida/InformaticaScannerPayloads/ImportPluginConfig.json | $.LoggingLevel_Off | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Import                                              |                                                                 |                    | 200           | Informatica_Import_Off |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                             |                                                                 |                    | 200           | UP                     | $.nodeStatus                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Off |                                                                 |                    | 200           | IDLE                   | $.[?(@.configurationName=='Informatica_Import_Off')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Off  |                                                                 |                    | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Import/Informatica_Import_Off |                                                                 |                    | 200           | IDLE                   | $.[?(@.configurationName=='Informatica_Import_Off')].status |

    #7199262
  @webtest
  Scenario: SC32# - Verify the log details when "Logging Level" in Informatica Import config is "OFF"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Import_Off" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Import/Informatica_Import_Off%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName | fileType |
      | log      | Content  |

  Scenario:SC32:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Import/Informatica_Import_Off% | Analysis |       |       |

################################################Informatica linker##################################################################################################################

  #7201324
  @webtest
  Scenario:SC33#Verify error message is displayed when mandatory fields are not entered in Informatica Link configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | CAE-JS     |
    And user "click" on "Add Configuration" button under "CAE-JS" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                    |
      | Type      | Other                        |
      | Plugin    | Scanner_for_Informatica_Link |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name*     | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name*     | Name field should not be empty |
    And user should scroll to the left of the screen
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName         | attribute |
      | Scan output path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName         | validationMessage                          |
      | Scan output path* | Scan output path field should not be empty |

 #7201325
  @webtest
  Scenario:SC34#Verify tool tip is displayed for all the fields in Informatica Link plugin configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | CAE-JS     |
    And user "click" on "Add Configuration" button under "CAE-JS" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                    |
      | Type      | Other                        |
      | Plugin    | Scanner_for_Informatica_Link |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*            |
      | ODBC file path   |
      | DB2CLI file path |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                 | Plugin configuration name                           |
      | Label                | Plugin configuration extended label and description |
      | Business Application | Business Application                                |
      | ODBC file pat        | Path that points to the ODBC file                   |
      | DB2CLI file path     | Path that points to the DB2CLI file                 |
    And user should scroll to the left of the screen
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Scan output path* |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Scan output path* | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |

    #7201326
  Scenario Outline:SC35# Run Informatica Link plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                           | bodyFile                                                      | path                  | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Link                                               | payloads/ida/InformaticaScannerPayloads/LinkPluginConfig.json | $.LoggingLevel_Severe | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Link                                               |                                                               |                       | 200           | Informatica_Link_Severe |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                            |                                                               |                       | 200           | UP                      | $.nodeStatus                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Severe |                                                               |                       | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Link_Severe')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Severe  |                                                               |                       | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Severe |                                                               |                       | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Link_Severe')].status |

  #7201326, #7201335
  @webtest
  Scenario: SC35# - Verify the log details when "Logging Level" in Informatica Link config is "SEVERE"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Link_Severe" and clicks on search
    Then the following tags "ROC,Informatica" should get displayed for the column "other/Scanner_for_Informatica_Link/Informatica_Link_Severe"
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Link/Informatica_Link_Severe%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                 | fileType |
      | scaninfa_linker-log.html | Content  |

    #7201336
  Scenario:SC36#Verify logging enhancements after the plugin run
    Given Analysis log "other/Scanner_for_Informatica_Link/Informatica_Link_Severe%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | logCode       | pluginName                   | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0019 |                              |                |
      | INFO | Plugin Name:Scanner_for_Informatica_Link, Plugin Type:other, Plugin Version:1.1.0, Node Name:CAE-JS, Host Name:DIQDATAINTEL01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:Informatica_Link_Severe                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0071 | Scanner_for_Informatica_Link | Plugin Version |
      | INFO | Plugin Scanner_for_Informatica_Link Configuration: ---  2020-09-20 08:31:48.138 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: name: "Informatica_Link_Severe"  2020-09-20 08:31:48.138 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: pluginVersion: "LATEST"  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: label:  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: : ""  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: catalogName: "Default"  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: eventClass: null  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: eventCondition: null  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: nodeCondition: "name==\"CAE-JS\""  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: maxWorkSize: 100  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: tags: []  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: pluginType: "other"  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: dataSource: null  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: credential: null  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: businessApplicationName: null  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: dryRun: false  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: schedule: null  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: filter: null  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: ClassPath: "${rochade.home}/scaninformatica/V226/lib/ds-utils.jar;${rochade.home}/scaninformatica/V226/lib/linker-common.jar;${rochade.home}/scaninformatica/V226/lib/SQL2XML.jar;${rochade.home}/scaninformatica/V226/lib/InformaticaLinker.jar;${rochade.home}/bin/ScanLogging.jar;${rochade.home}/bin/roacccxj.jar;${rochade.home}/bin/rochade.jar;"  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: RochadeBin: "${rochade.home}/bin"  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: RochadePath: "${rochade.home}"  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: PropertiesAndOutputPath: "${rochade.project.home}"  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: type: "Other"  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: LogLevel: "SEVERE"  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: DB2CLIfile: ""  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: RochadeServerHost: "${rochade.server}"  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: JavaMemory: "8192m"  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: pluginName: "Scanner_for_Informatica_Link"  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: ODBCfile: ""  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: ScannerBin: "${rochade.home}/scaninformatica/V226/binSQL"  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: ScannerLib: "${rochade.home}/scaninformatica/V226/lib"  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: arguments: []  2020-09-20 08:31:48.154 INFO  - ANALYSIS-0073: Plugin Scanner_for_Informatica_Link Configuration: RochadeServerPort: "${rochade.port}" | ANALYSIS-0073 | Scanner_for_Informatica_Link |                |
      | INFO | Plugin Scanner_for_Informatica_Link Start Time:2020-09-20 08:31:48.123, End Time:2020-09-20 08:31:52.904, Processed Count:0, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0072 | Scanner_for_Informatica_Link |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:01.549)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0020 |                              |                |

  Scenario:SC36:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                        | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Link/Informatica_Link_Severe% | Analysis |       |       |

    #7201327
  Scenario Outline:SC37# Run Informatica Link plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | bodyFile                                                      | path                   | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Link                                                | payloads/ida/InformaticaScannerPayloads/LinkPluginConfig.json | $.LoggingLevel_Warning | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Link                                                |                                                               |                        | 200           | Informatica_Link_Warning |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                             |                                                               |                        | 200           | UP                       | $.nodeStatus                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Warning |                                                               |                        | 200           | IDLE                     | $.[?(@.configurationName=='Informatica_Link_Warning')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Warning  |                                                               |                        | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Warning |                                                               |                        | 200           | IDLE                     | $.[?(@.configurationName=='Informatica_Link_Warning')].status |

  #7201327
  @webtest
  Scenario: SC37# - Verify the log details when "Logging Level" in Informatica Link config is "WARNING"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Link_Warning" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Link/Informatica_Link_Warning%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                 | fileType |
      | scaninfa_linker-log.html | Content  |

  Scenario:SC37:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Link/Informatica_Link_Warning% | Analysis |       |       |

    #7201328
  Scenario Outline:SC38# Run Informatica Link plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | bodyFile                                                      | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Link                                             | payloads/ida/InformaticaScannerPayloads/LinkPluginConfig.json | $.LoggingLevel_Info | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Link                                             |                                                               |                     | 200           | Informatica_Link_Info |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                          |                                                               |                     | 200           | UP                    | $.nodeStatus                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Info |                                                               |                     | 200           | IDLE                  | $.[?(@.configurationName=='Informatica_Link_Info')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Info  |                                                               |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Info |                                                               |                     | 200           | IDLE                  | $.[?(@.configurationName=='Informatica_Link_Info')].status |

  #7201328
  @webtest
  Scenario: SC38# - Verify the log details when "Logging Level" in Informatica Link config is "INFO"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Link_Info" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Link/Informatica_Link_Info%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                 | fileType |
      | scaninfa_linker-log.html | Content  |

  Scenario:SC38:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                      | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Link/Informatica_Link_Info% | Analysis |       |       |

    #7201329
  Scenario Outline:SC39# Run Informatica Link plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                           | bodyFile                                                      | path                  | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Link                                               | payloads/ida/InformaticaScannerPayloads/LinkPluginConfig.json | $.LoggingLevel_Config | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Link                                               |                                                               |                       | 200           | Informatica_Link_Config |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                            |                                                               |                       | 200           | UP                      | $.nodeStatus                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Config |                                                               |                       | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Link_Config')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Config  |                                                               |                       | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Config |                                                               |                       | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Link_Config')].status |

  #7201329
  @webtest
  Scenario: SC39# - Verify the log details when "Logging Level" in Informatica Link config is "CONFIG"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Link_Config" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Link/Informatica_Link_Config%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                 | fileType |
      | scaninfa_linker-log.html | Content  |

  Scenario:SC39:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                        | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Link/Informatica_Link_Config% | Analysis |       |       |


    #7201330
  Scenario Outline:SC40# Run Informatica Link plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | bodyFile                                                      | path                | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Link                                             | payloads/ida/InformaticaScannerPayloads/LinkPluginConfig.json | $.LoggingLevel_Fine | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Link                                             |                                                               |                     | 200           | Informatica_Link_Fine |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                          |                                                               |                     | 200           | UP                    | $.nodeStatus                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Fine |                                                               |                     | 200           | IDLE                  | $.[?(@.configurationName=='Informatica_Link_Fine')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Fine  |                                                               |                     | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Fine |                                                               |                     | 200           | IDLE                  | $.[?(@.configurationName=='Informatica_Link_Fine')].status |

  #7201330
  @webtest
  Scenario: SC40# - Verify the log details when "Logging Level" in Informatica Link config is "FINE"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Link_Fine" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Link/Informatica_Link_Fine%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                 | fileType |
      | scaninfa_linker-log.html | Content  |

  Scenario:SC40:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                      | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Link/Informatica_Link_Fine% | Analysis |       |       |

    #7201331
  Scenario Outline:SC41# Run Informatica Link plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                          | bodyFile                                                      | path                 | response code | response message       | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Link                                              | payloads/ida/InformaticaScannerPayloads/LinkPluginConfig.json | $.LoggingLevel_Finer | 204           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Link                                              |                                                               |                      | 200           | Informatica_Link_Finer |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                           |                                                               |                      | 200           | UP                     | $.nodeStatus                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Finer |                                                               |                      | 200           | IDLE                   | $.[?(@.configurationName=='Informatica_Link_Finer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Finer  |                                                               |                      | 200           |                        |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Finer |                                                               |                      | 200           | IDLE                   | $.[?(@.configurationName=='Informatica_Link_Finer')].status |

  #7201331
  @webtest
  Scenario: SC41# - Verify the log details when "Logging Level" in Informatica Link config is "FINER"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Link_Finer" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Link/Informatica_Link_Finer%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                 | fileType |
      | scaninfa_linker-log.html | Content  |

  Scenario:SC41:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                       | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Link/Informatica_Link_Finer% | Analysis |       |       |

#7201332
  Scenario Outline:SC42# Run Informatica Link plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                           | bodyFile                                                      | path                  | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Link                                               | payloads/ida/InformaticaScannerPayloads/LinkPluginConfig.json | $.LoggingLevel_Finest | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Link                                               |                                                               |                       | 200           | Informatica_Link_Finest |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                            |                                                               |                       | 200           | UP                      | $.nodeStatus                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Finest |                                                               |                       | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Link_Finest')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Finest  |                                                               |                       | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Finest |                                                               |                       | 200           | IDLE                    | $.[?(@.configurationName=='Informatica_Link_Finest')].status |

  #7201332
  @webtest
  Scenario: SC42# - Verify the log details when "Logging Level" in Informatica Link config is "FINEST"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Link_Finest" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Link/Informatica_Link_Finest%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                 | fileType |
      | scaninfa_linker-log.html | Content  |

  Scenario:SC42:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                        | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Link/Informatica_Link_Finest% | Analysis |       |       |

#7201333
  Scenario Outline:SC43# Run Informatica Link plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                      | path               | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Link                                            | payloads/ida/InformaticaScannerPayloads/LinkPluginConfig.json | $.LoggingLevel_All | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Link                                            |                                                               |                    | 200           | Informatica_Link_All |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                         |                                                               |                    | 200           | UP                   | $.nodeStatus                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_All |                                                               |                    | 200           | IDLE                 | $.[?(@.configurationName=='Informatica_Link_All')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_All  |                                                               |                    | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_All |                                                               |                    | 200           | IDLE                 | $.[?(@.configurationName=='Informatica_Link_All')].status |

  #7201333
  @webtest
  Scenario: SC43# - Verify the log details when "Logging Level" in Informatica Link config is "ALL"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Link_All" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Link/Informatica_Link_All%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName                 | fileType |
      | scaninfa_linker-log.html | Content  |

  Scenario:SC43:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                     | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Link/Informatica_Link_All% | Analysis |       |       |

#7201334
  Scenario Outline:SC44# Run Informatica Link plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | bodyFile                                                      | path               | response code | response message     | jsonPath                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Link                                            | payloads/ida/InformaticaScannerPayloads/LinkPluginConfig.json | $.LoggingLevel_Off | 204           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Link                                            |                                                               |                    | 200           | Informatica_Link_Off |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                         |                                                               |                    | 200           | UP                   | $.nodeStatus                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Off |                                                               |                    | 200           | IDLE                 | $.[?(@.configurationName=='Informatica_Link_Off')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Off  |                                                               |                    | 200           |                      |                                                           |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Link/Informatica_Link_Off |                                                               |                    | 200           | IDLE                 | $.[?(@.configurationName=='Informatica_Link_Off')].status |

  #7201334
  @webtest
  Scenario: SC44# - Verify the log details when "Logging Level" in Informatica Link config is "OFF"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Link_Off" and clicks on search
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Link/Informatica_Link_Off%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |
    And user verifies "Data" table should have following values
      | fileName | fileType |
      | log      | Content  |

  Scenario:SC44:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                     | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Link/Informatica_Link_Off% | Analysis |       |       |

##############################################Informatica Reconcile######################################################################################################################################################################################

  #7202405
  @webtest
  Scenario:SC45#Verify error message is displayed when mandatory fields are not entered in Informatica Reconcise configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | CAE-JS     |
    And user "click" on "Add Configuration" button under "CAE-JS" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                         |
      | Type      | Other                             |
      | Plugin    | Scanner_for_Informatica_Reconcile |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name*     | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name*     | Name field should not be empty |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName                              | attribute |
      | Repository Seed item (root namespace)* | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName                              | validationMessage                                               |
      | Repository Seed item (root namespace)* | Repository Seed item (root namespace) field should not be empty |
    And user should scroll to the left of the screen
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName         | attribute |
      | Scan output path* | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName         | validationMessage                          |
      | Scan output path* | Scan output path field should not be empty |

#7202406
  @webtest
  Scenario:SC46#Verify tool tip is displayed for all the fields in Informatica Reconcile plugin configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | CAE-JS     |
    And user "click" on "Add Configuration" button under "CAE-JS" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                         |
      | Type      | Other                             |
      | Plugin    | Scanner_for_Informatica_Reconcile |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                                        |
      | Store RDBMS links for lookup transformations |
      | Reconcile category                           |
      | Repository Seed item (root namespace)*       |
      | Folder Seed item (namespace level 1)         |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name                                         | Plugin configuration name                                                                   |
      | Store RDBMS links for lookup transformations | Store RDBMS links for lookup transformations in dedicated lookup attributes                 |
      | Reconcile category                           | Reconcile category (Informatica repository or folder)                                       |
      | Repository Seed item (root namespace)*       | Specify the repository transformation start item                                            |
      | Folder Seed item (namespace level 1)         | Specify the folder transformation start item (required only for reconcile by folder option) |
    And user should scroll to the left of the screen
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Scan output path* |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Scan output path* | Path that points to the Scan output path. By default, the value is used from environment variable ROCHADE_PROJECT_HOME. You can override the default value here. |

    #7202407
  Scenario Outline:SC47# Run Informatica Reconcile plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | bodyFile                                                           | path                           | response code | response message      | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/Scanner_for_Informatica_Reconcile                                             | payloads/ida/InformaticaScannerPayloads/ReconcilePluginConfig.json | $.Informatica_Reconcile_Config | 204           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/Scanner_for_Informatica_Reconcile                                             |                                                                    |                                | 200           | Informatica_Reconcile |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/CAE-JS                                                               |                                                                    |                                | 200           | UP                    | $.nodeStatus                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Reconcile/Informatica_Reconcile |                                                                    |                                | 200           | IDLE                  | $.[?(@.configurationName=='Informatica_Reconcile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/CAE-JS/other/Scanner_for_Informatica_Reconcile/Informatica_Reconcile  |                                                                    |                                | 200           |                       |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/CAE-JS/other/Scanner_for_Informatica_Reconcile/Informatica_Reconcile |                                                                    |                                | 200           | IDLE                  | $.[?(@.configurationName=='Informatica_Reconcile')].status |

#7202407
  @webtest
  Scenario: SC47# - Verify the Informatica reconcile plugin runs without errors
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica_Reconcile" and clicks on search
    Then the following tags "ROC,Informatica" should get displayed for the column "other/Scanner_for_Informatica_Reconcile/Informatica_Reconcile"
    And user performs "latest analysis click" in Item Results page for "other/Scanner_for_Informatica_Reconcile/Informatica_Reconcile%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 0             | Description |

  Scenario:SC47:Delete Collector Analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                           | type     | query | param |
      | SingleItemDelete | Default | other/Scanner_for_Informatica_Reconcile/Informatica_Reconcile% | Analysis |       |       |

###########################################Running EDI Bus to get the data in DD######################################################################################################################################################################################################################################################

  Scenario Outline:SC48# Set credentials for EDI Bus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ediBusCredentials | ida/InformaticaScannerPayloads/credentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ediBusCredentials |                                                 | 200           |                  |          |

  Scenario Outline:SC48# Run EDI Bus Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                 | body                                          | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource | ida/InformaticaScannerPayloads/EDIBus_DS.json | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource |                                               | 200           | Informatica_EDI_DS |          |

    #7202735
  Scenario Outline:SC48# Run EDI Bus plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                              | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus                                             | ida/InformaticaScannerPayloads/EDIBus_Config.json | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus                                             |                                                   | 200           | Informatica_Data |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | extensions/analyzers/status/InternalNode                              |                                                   | 200           | UP               | $.nodeStatus                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Informatica_Data |                                                   | 200           | IDLE             | $.[?(@.configurationName=='Informatica_Data')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/Informatica_Data  |                                                   | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/Informatica_Data |                                                   | 200           | IDLE             | $.[?(@.configurationName=='Informatica_Data')].status |

  @webtest
  Scenario:SC48_Verify user is able to load data from Rochade to DD platform using technology filter in EDI Bus
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica PowerCenter" and clicks on search
    And user performs "facet selection" in "Informatica PowerCenter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/Informatica_Data%"
    And METADATA widget should have following item values
      | metaDataItem     | metaDataItemValue |
      | Number of errors | 0                 |

  #7202736
  @webtest
  Scenario:SC49_Verify if all item types are loaded from rochade to DD for Informatica data
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Informatica PowerCenter" and clicks on search
    And user performs "facet selection" in "Informatica PowerCenter" attribute under "Tags" facets in Item Search results page
    And user "verify displayed" for listed "Metadata Type" facet in Search results page
      | ItemType  |
      | Service   |
      | Operation |
      | DataField |
      | Table     |
      | DataType  |
      | File      |
    And user enters the search text "Database" and clicks on search
    And user performs "facet selection" in "Informatica PowerCenter" attribute under "Tags" facets in Item Search results page
    And user "verify displayed" for listed "Hierarchy" facet in Search results page
      | ItemType           |
      | $$Db [Database]    |
      | $$Unknown [Schema] |
    And user enters the search text "Datapackage" and clicks on search
    And user performs "facet selection" in "Informatica PowerCenter" attribute under "Tags" facets in Item Search results page
    And user "verify displayed" for listed "Hierarchy" facet in Search results page
      | ItemType                    |
      | $$Informatica [DataPackage] |

    #7202737
  @webtest
  Scenario:SC50_Verify the item attributes and values for item types like Service,File,operations,datapackage,field
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "InfaTraining≫Operation" and clicks on search
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "InfaTraining≫Operation" item from search results
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue    |
      | Description  | Microsoft SQL Server |
    And user enters the search text "/data/infa/source/Employees.xml" and clicks on search
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "/data/infa/source/Employees.xml" item from search results
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Description  |                   |
    And user enters the search text "/data/infa/source/Employees.xml" and clicks on search
    And user performs "facet selection" in "DataType" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "/data/infa/source/Employees.xml" item from search results
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Description  |                   |

    #7202738
  @webtest
  Scenario:SC51_Verify breadcrumb hierarchy for Informatica appears correctly for EDIBus collected items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EMPLOYEES..TRAINING" and clicks on search
    And user performs "item click" on "EMPLOYEES..TRAINING" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | $$Infa≫DB           |
      | $$Db                |
      | $$Unknown           |
      | EMPLOYEES..TRAINING |

  #7208914
  @webtest
  Scenario:SC#52_Verify the backward lineage diagram for the column EMPLOYEE_ID
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "s_PhoneList11 [wf_PhoneList11]" and clicks on search
    And user performs "facet selection" in "Training1≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "S.EMPLOYEES [21598]" item from search results
    Then user performs click and verify in new window
      | Table        | value       | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | EMPLOYEE_ID | click and switch tab | No               |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | mode         | TRANSFORM         |
    Then user performs click and verify in new window
      | Table          | value       | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Source | EMPLOYEE_ID | verify widget contains | No               |             |
      | Lineage Target | EMPLOYEE_ID | verify widget contains | No               |             |

    #7208912
  @webtest
  Scenario:SC#53_Verify the forward lineage diagram for the column DEPT_ID
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SQ_DEPARTMENT [21552]" and clicks on search
    And user performs "facet selection" in "Training≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "SQ_DEPARTMENT [21552]" item from search results
    Then user performs click and verify in new window
      | Table        | value  | Action               | RetainPrevwindow | indexSwitch |
      | Lineage Hops | DEPTID | click and switch tab | No               |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | mode         | TRANSFORM         |
    Then user performs click and verify in new window
      | Table          | value  | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Source | DEPTID | verify widget contains | No               |             |
      | Lineage Target | DEPTID | verify widget contains | No               |             |




