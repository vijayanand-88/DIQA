Feature: TeradataDBFileCollector for version 15 plugin validation

# Since the access for the docker machine are removed, files are added manually to the docker container (both idc_core and idc_node)
#  @LFC
#  Scenario: SC1 - Copying files from local to docker machine
#    Given user connects to the SFTP server for below parameters
#      | sftpHost   | sftpPort   | sftpUser   | sftpPw         | sftpAction | localDir                                             | remoteDir                   |
#      | dockerHost | dockerPort | dockerUser | dockerPassword | copyFiles  | ida/localFileCollectorPayloads/LCL/SparkReadWrite.py | /home/becubic_build@asg.com |
#    And user connects to the sftp server and runs docker commands
#      | command | Filename |
#      | LFC     | idc_core |

  @cr-data
  Scenario Outline:SC#1: Create BusinessApplication tag and run the plugin configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/teradataDBFileCollector_V15/Test_BA_TeradataLFC.json | 200           |                  |          |

  ##6864051##
  @webtest @MLP-15256
  Scenario: SC#1- Verify TeradataDBFileCollector plugin Configuration collects the Local files using the Local File Collector Plugin (Internal Node) and verify the Technology tags are collected for (Project, File, Content, Directory)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                               | body                                                                                    | response code | response message      | jsonPath                                                   | endpointType | itemName |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                             | ida/teradataDBFileCollector_V15/PluginConfiguration/sc1LocalFileCollectorConfig.json    | 204           |                       |                                                            |              |          |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                             |                                                                                         | 200           | Teradata_LFC          |                                                            |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBFileCollector                                                        | ida/teradataDBFileCollector_V15/PluginConfiguration/sc1TeradataFileCollectorConfig.json | 204           |                       |                                                            |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBFileCollector                                                        |                                                                                         | 200           | TeradataFileCollector |                                                            |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollector |                                                                                         | 200           | IDLE                  | $.[?(@.configurationName=='TeradataFileCollector')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollector  | ida/teradataDBFileCollector_V15/empty.json                                              | 200           |                       |                                                            |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollector |                                                                                         | 200           | IDLE                  | $.[?(@.configurationName=='TeradataFileCollector')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TeradataFileCollector" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | File      |
      | Analysis  |
      | Directory |
      | Project   |
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 8 items" in Item Search results page
    And user performs "dynamic item click" on "$$TestScript-MERGE" item from search results
    Then user performs click and verify in new window
      | Table | value              | Action               | RetainPrevwindow | indexSwitch |
      | Data  | $$TestScript-MERGE | click and switch tab | No               |             |
    Then user "verify presence" of following "Tag List" in Item View Page
      | Local Files              |
      | SC1TeradataFileCollector |
      | Teradata                 |
      | Test_BA_TeradataLFC      |

  ############################ Logging Enhancements ############################
  @webtest @MLP-15256
  Scenario: SC#1:LoggingEnhancements: Verify TeradataDBFileCollector collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TeradataFileCollector" and clicks on search
    And user performs "facet selection" in "SC1TeradataFileCollector" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/TeradataDBFileCollector/TeradataFileCollector%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 1             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "collector/TeradataDBFileCollector/TeradataFileCollector%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | logCode       | pluginName              | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0019 |                         |                |
      | INFO | Plugin Name:TeradataDBFileCollector, Plugin Type:collector, Plugin Version:1.1.0.SNAPSHOT, Node Name:InternalNode, Host Name:635cca3edef7, Plugin Configuration name:TeradataFileCollector                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0071 | TeradataDBFileCollector | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: ---  2020-08-31 06:11:00.057 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: name: "TeradataFileCollector"  2020-08-31 06:11:00.057 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: pluginVersion: "LATEST"  2020-08-31 06:11:00.058 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: label:  2020-08-31 06:11:00.059 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: : ""  2020-08-31 06:11:00.059 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: catalogName: "Default"  2020-08-31 06:11:00.059 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: eventClass: null  2020-08-31 06:11:00.059 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: eventCondition: null  2020-08-31 06:11:00.060 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: nodeCondition: "name==\"InternalNode\""  2020-08-31 06:11:00.060 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: maxWorkSize: 100  2020-08-31 06:11:00.060 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: tags:  2020-08-31 06:11:00.060 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: - "SC1TeradataFileCollector"  2020-08-31 06:11:00.060 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: pluginType: "collector"  2020-08-31 06:11:00.060 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: dataSource: null  2020-08-31 06:11:00.061 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: credential: null  2020-08-31 06:11:00.061 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: businessApplicationName: "Test_BA_TeradataLFC"  2020-08-31 06:11:00.061 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: dryRun: false  2020-08-31 06:11:00.061 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: schedule: null  2020-08-31 06:11:00.061 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: filter: null  2020-08-31 06:11:00.061 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: pluginName: "TeradataDBFileCollector"  2020-08-31 06:11:00.061 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: collectorPlugin: "LocalFileCollector"  2020-08-31 06:11:00.062 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: collectorPluginConfiguration: "Teradata_LFC"  2020-08-31 06:11:00.062 INFO  - ANALYSIS-0073: Plugin TeradataDBFileCollector Configuration: type: "Collector" | ANALYSIS-0073 | TeradataDBFileCollector |                |
      | INFO | Plugin TeradataDBFileCollector Start Time:2020-07-28 06:46:27.723, End Time:2020-07-28 06:46:28.027, Processed Count:1, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0072 | TeradataDBFileCollector |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0020 |                         |                |


  @webtest @MLP-15256
  Scenario: SC#1:Tags verification: Verify the technology tags, Business Application, Explicit tags got assigned to the analyzed items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                                               | fileName               | userTag                  |
      | Default     | Project   | Metadata Type | SC1TeradataFileCollector,Local Files,Teradata,Test_BA_TeradataLFC | Teradata_LFC_Files     | SC1TeradataFileCollector |
      | Default     | Directory | Metadata Type | SC1TeradataFileCollector,Local Files,Teradata,Test_BA_TeradataLFC | tdscripts              | SC1TeradataFileCollector |
      | Default     | File      | Metadata Type | SC1TeradataFileCollector,Local Files,Teradata,Test_BA_TeradataLFC | $$TestScript-MERGE.sql | SC1TeradataFileCollector |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag        | fileName               | userTag                  |
      | Default     | File | Metadata Type | Data Files | $$TestScript-MERGE.sql | SC1TeradataFileCollector |

  Scenario: SC#1: Delete the items for scenario: TeradataDBFileCollector SC1
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type     | query | param |
      | SingleItemDelete | Default | Teradata_LFC_Files                      | Project  |       |       |
      | MultipleIDDelete | Default | collector/TeradataDBFileCollector/Tera% | Analysis |       |       |

  @webtest @MLP-15256
  Scenario: SC#1- Verify TeradataDBFileCollector plugin Configuration doesn't collects the Local files when dryrun is true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                               | body                                                                                        | response code | response message      | jsonPath                                                   | endpointType | itemName |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                             | ida/teradataDBFileCollector_V15/PluginConfiguration/sc1LocalFileCollectorConfig.json        | 204           |                       |                                                            |              |          |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                             |                                                                                             | 200           | Teradata_LFC          |                                                            |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBFileCollector                                                        | ida/teradataDBFileCollector_V15/PluginConfiguration/sc1TeradataFileCollectorDryRunTrue.json | 204           |                       |                                                            |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBFileCollector                                                        |                                                                                             | 200           | TeradataFileCollector |                                                            |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollector |                                                                                             | 200           | IDLE                  | $.[?(@.configurationName=='TeradataFileCollector')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollector  | ida/teradataDBFileCollector_V15/empty.json                                                  | 200           |                       |                                                            |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollector |                                                                                             | 200           | IDLE                  | $.[?(@.configurationName=='TeradataFileCollector')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1DryRunTrueTeradataFileCollector" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/TeradataDBFileCollector/TeradataFileCollector%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "collector/TeradataDBFileCollector/TeradataFileCollector%" should display below info/error/warning
      | type | logValue                                                                                           | logCode       | pluginName              | removableText |
      | INFO | Plugin TeradataDBFileCollector running on dry run mode                                             | ANALYSIS-0069 | TeradataDBFileCollector |               |
      | INFO | Plugin TeradataDBFileCollector processed 1 items on dry run mode and not written to the repository | ANALYSIS-0070 | TeradataDBFileCollector |               |


  ##6864052##
  @webtest @MLP-15256
  Scenario:SC#2 - Verify TeradataDBFileCollector plugin Configuration does not collect any Local files when the Local File Collector Plugin name is Incorrect in the TeradataDBFileCollector Configuration.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                                  | body                                                                                                       | response code | response message                         | jsonPath                                                                      | endpointType | itemName |
      | application/json | raw   | false | Put          | settings/analyzers/TeradataDBFileCollector                                                                           | ida/teradataDBFileCollector_V15/PluginConfiguration/sc2TeradataFileCollectorConfigWithWrongPluginName.json | 204           |                                          |                                                                               |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBFileCollector                                                                           |                                                                                                            | 200           | TeradataFileCollectorWithWrongPluginName |                                                                               |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollectorWithWrongPluginName |                                                                                                            | 200           | IDLE                                     | $.[?(@.configurationName=='TeradataFileCollectorWithWrongPluginName')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollectorWithWrongPluginName  | ida/teradataDBFileCollector_V15/empty.json                                                                 | 200           |                                          |                                                                               |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollectorWithWrongPluginName |                                                                                                            | 200           | IDLE                                     | $.[?(@.configurationName=='TeradataFileCollectorWithWrongPluginName')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TeradataFileCollectorWithWrongPluginName" and clicks on search
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | File      |
      | Project   |
      | Directory |


  ##6864052##
  @webtest @MLP-15256
  Scenario: SC#3 - Verify TeradataDBFileCollector plugin Configuration does not collect any Local files when the Local File Collector Plugin Configuration name is Incorrect in the TeradataDBFileCollector Configuration.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                                        | body                                                                                                             | response code | response message                               | jsonPath                                                                            | endpointType | itemName |
      | application/json | raw   | false | Put          | settings/analyzers/TeradataDBFileCollector                                                                                 | ida/teradataDBFileCollector_V15/PluginConfiguration/sc3TeradataFileCollectorConfigWithWrongPluginConfigName.json | 204           |                                                |                                                                                     |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBFileCollector                                                                                 |                                                                                                                  | 200           | TeradataFileCollectorWithWrongPluginConfigName |                                                                                     |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollectorWithWrongPluginConfigName |                                                                                                                  | 200           | IDLE                                           | $.[?(@.configurationName=='TeradataFileCollectorWithWrongPluginConfigName')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollectorWithWrongPluginConfigName  | ida/teradataDBFileCollector_V15/empty.json                                                                       | 200           |                                                |                                                                                     |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollectorWithWrongPluginConfigName |                                                                                                                  | 200           | IDLE                                           | $.[?(@.configurationName=='TeradataFileCollectorWithWrongPluginConfigName')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TeradataFileCollectorWithWrongPluginConfigName" and clicks on search
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | File      |
      | Project   |
      | Directory |


  ##6864053##
  @webtest @MLP-15256
  Scenario: SC#4 - Verify TeradataDBFileCollector plugin Configuration does not collect any files when the Local File Collector Plugin Name is Empty in the TeradataDBFileCollector Configuration.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                              | body                                                                                                          | response code | response message                     | jsonPath                                                                  | endpointType | itemName |
      | application/json | raw   | false | Put          | settings/analyzers/TeradataDBFileCollector                                                                       | ida/teradataDBFileCollector_V15/PluginConfiguration/sc4TeradataFileCollectorConfigWithEmptyLFCPluginName.json | 204           |                                      |                                                                           |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBFileCollector                                                                       |                                                                                                               | 200           | TeradataFileCollectorEmptyPluginName |                                                                           |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollectorEmptyPluginName |                                                                                                               | 200           | IDLE                                 | $.[?(@.configurationName=='TeradataFileCollectorEmptyPluginName')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollectorEmptyPluginName  | ida/teradataDBFileCollector_V15/empty.json                                                                    | 200           |                                      |                                                                           |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollectorEmptyPluginName |                                                                                                               | 200           | IDLE                                 | $.[?(@.configurationName=='TeradataFileCollectorEmptyPluginName')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TeradataFileCollectorEmptyPluginName" and clicks on search
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | File      |
      | Project   |
      | Directory |

##6864053##
  @webtest @MLP-15256
  Scenario: SC#4 - Verify TeradataDBFileCollector plugin Configuration does not collect any files when the Local File Collector Plugin Configuration name is Empty in the TeradataDBFileCollector Configuration.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                                        | body                                                                                                                | response code | response message                               | jsonPath                                                                            | endpointType | itemName |
      | application/json | raw   | false | Put          | settings/analyzers/TeradataDBFileCollector                                                                                 | ida/teradataDBFileCollector_V15/PluginConfiguration/sc4TeradataFileCollectorConfigWithEmptyLFCPluginConfigName.json | 204           |                                                |                                                                                     |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBFileCollector                                                                                 |                                                                                                                     | 200           | TeradataFileCollectorWithEmptyPluginConfigName |                                                                                     |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollectorWithEmptyPluginConfigName |                                                                                                                     | 200           | IDLE                                           | $.[?(@.configurationName=='TeradataFileCollectorWithEmptyPluginConfigName')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollectorWithEmptyPluginConfigName  | ida/teradataDBFileCollector_V15/empty.json                                                                          | 200           |                                                |                                                                                     |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/collector/TeradataDBFileCollector/TeradataFileCollectorWithEmptyPluginConfigName |                                                                                                                     | 200           | IDLE                                           | $.[?(@.configurationName=='TeradataFileCollectorWithEmptyPluginConfigName')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TeradataFileCollectorWithEmptyPluginConfigName" and clicks on search
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | File      |
      | Project   |
      | Directory |

  Scenario: SC#4: Delete the items for Negative scenarios
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type     | query | param |
      | MultipleIDDelete | Default | collector/TeradataDBFileCollector/Tera% | Analysis |       |       |


    ##6864054##
  @webtest @MLP-15256 @IDA-E2E
  Scenario: SC#5 - Verify TeradataDBFileCollector plugin Configuration collects the Local files using the Local File Collector (with filters) Plugin (Local Node) and verify the Tech tags for the collected items
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                             | body                                                                                    | response code | response message         | jsonPath                                                    | endpointType | itemName |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                           | ida/teradataDBFileCollector_V15/PluginConfiguration/sc5LocalFileCollectorConfig.json    | 204           |                          |                                                             |              |          |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                           |                                                                                         | 200           | Teradata_LFC_With_Filter |                                                             |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBFileCollector                                                      | ida/teradataDBFileCollector_V15/PluginConfiguration/sc5TeradataFileCollectorConfig.json | 204           |                          |                                                             |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBFileCollector                                                      |                                                                                         | 200           | TeradataFileCollector1   |                                                             |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector1 |                                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='TeradataFileCollector1')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector1  | ida/teradataDBFileCollector_V15/empty.json                                              | 200           |                          |                                                             |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector1 |                                                                                         | 200           | IDLE                     | $.[?(@.configurationName=='TeradataFileCollector1')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TeradataFileCollectorWithFilter" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | File      |
      | Analysis  |
      | Directory |
      | Project   |
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 5 items" in Item Search results page
    And user performs "dynamic item click" on "$$TestScript-MERGE" item from search results
    Then user performs click and verify in new window
      | Table | value                  | Action               | RetainPrevwindow | indexSwitch |
      | Data  | $$TestScript-MERGE.sql | click and switch tab | No               |             |
    Then user "verify presence" of following "Tag List" in Item View Page
      | Local Files                     |
      | Teradata                        |
      | TeradataFileCollectorWithFilter |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                                  | fileName               | userTag                         |
      | Default     | Project   | Metadata Type | TeradataFileCollectorWithFilter,Local Files,Teradata | Teradata_LFC_Files     | TeradataFileCollectorWithFilter |
      | Default     | Directory | Metadata Type | TeradataFileCollectorWithFilter,Local Files,Teradata | tdscripts              | TeradataFileCollectorWithFilter |
      | Default     | File      | Metadata Type | TeradataFileCollectorWithFilter,Local Files,Teradata | $$TestScript-MERGE.sql | TeradataFileCollectorWithFilter |

  Scenario: SC#5: Delete the items for scenario: with filters
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type     | query | param |
      | SingleItemDelete | Default | Teradata_LFC_Files                      | Project  |       |       |
      | MultipleIDDelete | Default | collector/TeradataDBFileCollector/Tera% | Analysis |       |       |

  @IDA-E2E
  Scenario Outline: Set the credential and DataSource for Teradata
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                        | body                                                                | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/TeradataCredentials                   | ida/teradataDBFileCollector_V15/Credential/TeradataCredentials.json | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/TeradataCredentials                   |                                                                     | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/TeradataDBDataSource/TeradataDataSource | ida/teradataDBFileCollector_V15/DataSource/TeradataDataSource.json  | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/TeradataDBDataSource/TeradataDataSource |                                                                     | 200           | TeradataDataSource |          |



    ##6864142##
  @webtest @MLP-15256 @IDA-E2E
  Scenario: SC#6- Verify TeradataDBCataloger runs successfuly post the execution TeradataDBFileCollector and Verify the Technology Tags for Teradata DB items and the collected local files
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                      | body                                                                                            | response code | response message                    | jsonPath                                                                 | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/LocalFileCollector                                                                    |                                                                                                 | 200           | Teradata_LFC_With_Filter            |                                                                          |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBFileCollector                                                               | ida/teradataDBFileCollector_V15/PluginConfiguration/sc6TeradataFileCollectorConfig.json         | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBFileCollector                                                               |                                                                                                 | 200           | TeradataFileCollector2              |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2          |                                                                                                 | 200           | IDLE                                | $.[?(@.configurationName=='TeradataFileCollector2')].status              |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2           | ida/teradataDBFileCollector_V15/empty.json                                                      | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2          |                                                                                                 | 200           | IDLE                                | $.[?(@.configurationName=='TeradataFileCollector2')].status              |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter                               | ida/teradataDBFileCollector_V15/PluginConfiguration/sc6TeradataCatalogerWithDBfilterConfig.json | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                   |                                                                                                 | 200           | TeraDataCatalogerWithDatabaseFilter |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                 | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter  | ida/teradataDBFileCollector_V15/empty.json                                                      | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                 | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC6TeradataFileCollector" and clicks on search
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 5 items" in Item Search results page
    And user enters the search text "SC6TeradataCataloger" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "collector" item from search results
    And user "verify presence" of following "item view section" in Item View Page
      | Tables      |
      | has_Routine |
      | has_Trigger |


    ##6864055##
  @webtest @IDA-E2E @MLP-15256
  Scenario: SC#6 - Verify Teradata Analyzer runs successfully with the collected Teradata DB items and local files
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                     | body                                                                         | response code | response message | jsonPath                                              |
      | application/json | raw   | false | Put          | settings/analyzers/TeradataDBAnalyzer                                                   | ida/teradataDBFileCollector_V15/PluginConfiguration/sc6TeradataAnalyzer.json | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/TeradataDBAnalyzer                                                   |                                                                              | 200           | TeradataAnalyzer |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzer |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='TeradataAnalyzer')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzer  | ida/teradataDBFileCollector_V15/empty.json                                   | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/dataanalyzer/TeradataDBAnalyzer/TeradataAnalyzer |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='TeradataAnalyzer')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TERADATA_TAG_DETAILS" and clicks on search
    And user performs "facet selection" in "SC6TeradataAnalyzer" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "EMPLOYEE_ID" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
      | Standard deviation | Statistics |
      | Variance           | Statistics |

  Scenario: SC#6: Delete the items for scenario: TeradataDBFileCollector ran with cataloger and analyzer
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type     | query | param |
      | SingleItemDelete | Default | Teradata_LFC_Files                      | Project  |       |       |
      | SingleItemDelete | Default | 10.33.6.190                             | Cluster  |       |       |
      | MultipleIDDelete | Default | collector/TeradataDBFileCollector/Tera% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera%     | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/TeradataDBAnalyzer/Tera%   | Analysis |       |       |

    ##6864143##
  @webtest @MLP-15256 @IDA-E2E
  Scenario: SC#7- Verify TeradataDBFileCollector runs successfuly post the execution TeradataDBCataloger and Verify the Technology Tags for Teradata DB items and the collected local files
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                      | body                                                                                            | response code | response message                    | jsonPath                                                                 | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/LocalFileCollector                                                                    |                                                                                                 | 200           | Teradata_LFC_With_Filter            |                                                                          |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter                               | ida/teradataDBFileCollector_V15/PluginConfiguration/sc6TeradataCatalogerWithDBfilterConfig.json | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBFileCollector                                                               | ida/teradataDBFileCollector_V15/PluginConfiguration/sc6TeradataFileCollectorConfig.json         | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                   |                                                                                                 | 200           | TeraDataCatalogerWithDatabaseFilter |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                 | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter  | ida/teradataDBFileCollector_V15/empty.json                                                      | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                 | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBFileCollector                                                               |                                                                                                 | 200           | TeradataFileCollector2              |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2          |                                                                                                 | 200           | IDLE                                | $.[?(@.configurationName=='TeradataFileCollector2')].status              |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2           | ida/teradataDBFileCollector_V15/empty.json                                                      | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2          |                                                                                                 | 200           | IDLE                                | $.[?(@.configurationName=='TeradataFileCollector2')].status              |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC6TeradataFileCollector" and clicks on search
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 5 items" in Item Search results page
    And user enters the search text "SC6TeradataCataloger" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "collector" item from search results
    And user "verify presence" of following "item view section" in Item View Page
      | Tables      |
      | has_Routine |
      | has_Trigger |


  ##6880873##
  @webtest @MLP-15807
  Scenario: SC#8 - Verify the external files are not linked with Terdata Service items if cluster/service are not provided in TeradataFileCollector plugin configuration.
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user confirm "non presence of window" for the below item types
      | catalogName | facetName | facet         | itemName           | windowName |
      | Default     | Project   | Metadata Type | Teradata_LFC_Files | Services   |


#    ##6864056##
#  @webtest  @MLP-15256 @IDA-E2E
#  Scenario: SC#9 - Verify Teradata PostProcessor runs successfully with the collected Teradata DB items and local files
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type            | url                                                                                                    | body                                                                          | response code | response message        | jsonPath                                                     | endpointType | itemName             |
#      | application/json | raw   | false | DeleteAndCreate | settings/catalogs                                                                                      | ida/teradataDBFileCollector_V15/Catalog/sc6TeradataCatalogSC6.json                | 204           |                         |                                                              | catalog      | sc6TeradataFCCatalog |
#      |                  |       |       | Put             | settings/analyzers/TeradataDBPostProcessor                                                             | ida/teradataDBFileCollector_V15/PostProcessor/sc6TeradataPostProcessorConfig.json | 204           |                         |                                                              |              |                      |
#      |                  |       |       | Get             | settings/analyzers/TeradataDBPostProcessor                                                             |                                                                               | 200           | TeradataDBPostProcessor |                                                              |              |                      |
#      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/InternalNode/dataanalyzer/TeradataDBPostProcessor/TeradataDBPostProcessor |                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='TeradataDBPostProcessor')].status |              |                      |
#      |                  |       |       | Post            | /extensions/analyzers/start/InternalNode/dataanalyzer/TeradataDBPostProcessor/TeradataDBPostProcessor  | ida/teradataDBFileCollector_V15/empty.json                                        | 200           |                         |                                                              |              |                      |
#      |                  |       |       | RecursiveGet    | /extensions/analyzers/status/InternalNode/dataanalyzer/TeradataDBPostProcessor/TeradataDBPostProcessor |                                                                               | 200           | IDLE                    | $.[?(@.configurationName=='TeradataDBPostProcessor')].status |              |                      |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user select "sc6TeradataFCCatalog" catalog and search "TabletoTableMergeSql" items at top end
#    And user performs "defintie facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "dynamic item click" on "TabletoTableMergeSql" item from search results
#    And user "verify presence" of following "item view section" in Item View Page
#      | LINEAGE HOPS |
#      | DEPENDENCIES |
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/sc6TeradataFCCatalog"
#    Then Status code 204 must be returned


  Scenario: SC#9: Delete the items for scenario: TeradataDBFileCollector ran with cataloger and postprocessor
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                      | type     | query | param |
      | SingleItemDelete | Default | Teradata_LFC_Files                        | Project  |       |       |
      | SingleItemDelete | Default | 10.33.6.190                               | Cluster  |       |       |
      | MultipleIDDelete | Default | collector/TeradataDBFileCollector/Tera%   | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera%       | Analysis |       |       |
      | MultipleIDDelete | Default | lineage/TeradataDBPostProcessor/Teradata% | Analysis |       |       |


  ##6880863##
  @webtest @MLP-15807 @IDA-E2E
  Scenario: SC#10- Verify the external files are linked with Project item of collected files if valid cluster/service are provided in TeradataFileCollector plugin configuration.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                      | body                                                                                             | response code | response message                    | jsonPath                                                                 | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/LocalFileCollector                                                                    |                                                                                                  | 200           | Teradata_LFC_With_Filter            |                                                                          |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter                               | ida/teradataDBFileCollector_V15/PluginConfiguration/sc10TeradataCatalogerWithDBfilterConfig.json | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBFileCollector                                                               | ida/teradataDBFileCollector_V15/PluginConfiguration/sc10TeradataFileCollectorConfig.json         | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                   |                                                                                                  | 200           | TeraDataCatalogerWithDatabaseFilter |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter  | ida/teradataDBFileCollector_V15/empty.json                                                       | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBFileCollector                                                               |                                                                                                  | 200           | TeradataFileCollector2              |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2          |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeradataFileCollector2')].status              |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2           | ida/teradataDBFileCollector_V15/empty.json                                                       | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2          |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeradataFileCollector2')].status              |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Teradata_LFC_Files" and clicks on search
    And user performs "facet selection" in "SC10TeradataFileCollector" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Project" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Teradata_LFC_Files" item from search results
    And user "verify presence" of following "item view section" in Item View Page
      | Services      |
      | has_Directory |

  Scenario: SC#10: Delete the items for scenario: Verify the external files are linked
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type     | query | param |
      | SingleItemDelete | Default | Teradata_LFC_Files                      | Project  |       |       |
      | SingleItemDelete | Default | 10.33.6.190                             | Cluster  |       |       |
      | MultipleIDDelete | Default | collector/TeradataDBFileCollector/Tera% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera%     | Analysis |       |       |


  ##6880874##
  @webtest @MLP-15807
  Scenario: SC#11- Verify the external files are not linked with Terdata Service items if valid cluster and empty service are  provided in TeradataFileCollector plugin configuration.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                      | body                                                                                             | response code | response message                    | jsonPath                                                                 | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/LocalFileCollector                                                                    |                                                                                                  | 200           | Teradata_LFC_With_Filter            |                                                                          |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter                               | ida/teradataDBFileCollector_V15/PluginConfiguration/sc11TeradataCatalogerWithDBfilterConfig.json | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBFileCollector                                                               | ida/teradataDBFileCollector_V15/PluginConfiguration/sc11TeradataFileCollectorConfig.json         | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                   |                                                                                                  | 200           | TeraDataCatalogerWithDatabaseFilter |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter  | ida/teradataDBFileCollector_V15/empty.json                                                       | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBFileCollector                                                               |                                                                                                  | 200           | TeradataFileCollector2              |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2          |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeradataFileCollector2')].status              |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2           | ida/teradataDBFileCollector_V15/empty.json                                                       | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2          |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeradataFileCollector2')].status              |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user confirm "non presence of window" for the below item types
      | catalogName | facetName | facet         | itemName           | windowName |
      | Default     | Project   | Metadata Type | Teradata_LFC_Files | Services   |

  Scenario: SC#11: Delete the items for scenario: Verify the external files are not linked if empty service name in config
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type     | query | param |
      | SingleItemDelete | Default | Teradata_LFC_Files                      | Project  |       |       |
      | SingleItemDelete | Default | 10.33.6.190                             | Cluster  |       |       |
      | MultipleIDDelete | Default | collector/TeradataDBFileCollector/Tera% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera%     | Analysis |       |       |


  ##6880875##
  @webtest @MLP-15807
  Scenario: SC#12 - Verify the external files are not linked with Terdata Service items if empty cluster and valid service are  provided in TeradataFileCollector plugin configuration.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                      | body                                                                                             | response code | response message                    | jsonPath                                                                 | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/LocalFileCollector                                                                    |                                                                                                  | 200           | Teradata_LFC_With_Filter            |                                                                          |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter                               | ida/teradataDBFileCollector_V15/PluginConfiguration/sc11TeradataCatalogerWithDBfilterConfig.json | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBFileCollector                                                               | ida/teradataDBFileCollector_V15/PluginConfiguration/sc12TeradataFileCollectorConfig.json         | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                   |                                                                                                  | 200           | TeraDataCatalogerWithDatabaseFilter |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter  | ida/teradataDBFileCollector_V15/empty.json                                                       | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBFileCollector                                                               |                                                                                                  | 200           | TeradataFileCollector2              |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2          |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeradataFileCollector2')].status              |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2           | ida/teradataDBFileCollector_V15/empty.json                                                       | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2          |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeradataFileCollector2')].status              |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user confirm "non presence of window" for the below item types
      | catalogName | facetName | facet         | itemName           | windowName |
      | Default     | Project   | Metadata Type | Teradata_LFC_Files | Services   |

  Scenario: SC#12: Delete the items for scenario: Verify the external files are not linked if empty cluster name in config
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type     | query | param |
      | SingleItemDelete | Default | Teradata_LFC_Files                      | Project  |       |       |
      | SingleItemDelete | Default | 10.33.6.190                             | Cluster  |       |       |
      | MultipleIDDelete | Default | collector/TeradataDBFileCollector/Tera% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera%     | Analysis |       |       |


  ##6880876##
  @webtest @MLP-15807
  Scenario: SC#13 - Verify the external files are not linked with Terdata Service items if invalid cluster and valid service are  provided in TeradataFileCollector plugin configuration.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                      | body                                                                                             | response code | response message                    | jsonPath                                                                 | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/LocalFileCollector                                                                    |                                                                                                  | 200           | Teradata_LFC_With_Filter            |                                                                          |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter                               | ida/teradataDBFileCollector_V15/PluginConfiguration/sc13TeradataCatalogerWithDBfilterConfig.json | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBFileCollector                                                               | ida/teradataDBFileCollector_V15/PluginConfiguration/sc13TeradataFileCollectorConfig.json         | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                   |                                                                                                  | 200           | TeraDataCatalogerWithDatabaseFilter |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter  | ida/teradataDBFileCollector_V15/empty.json                                                       | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBFileCollector                                                               |                                                                                                  | 200           | TeradataFileCollector2              |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2          |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeradataFileCollector2')].status              |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2           | ida/teradataDBFileCollector_V15/empty.json                                                       | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2          |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeradataFileCollector2')].status              |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user confirm "non presence of window" for the below item types
      | catalogName | facetName | facet         | itemName           | windowName |
      | Default     | Project   | Metadata Type | Teradata_LFC_Files | Services   |

  Scenario: SC#13: Delete the items for scenario: Verify the external files are not linked if invalid cluster name in config
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type     | query | param |
      | SingleItemDelete | Default | Teradata_LFC_Files                      | Project  |       |       |
      | SingleItemDelete | Default | 10.33.6.190                             | Cluster  |       |       |
      | MultipleIDDelete | Default | collector/TeradataDBFileCollector/Tera% | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera%     | Analysis |       |       |


  ##6880877##
  @webtest @MLP-15807
  Scenario: SC#14 - Verify the external files are not linked with Terdata Service items if valid cluster and invalid service are  provided in TeradataFileCollector plugin configuration.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                                      | body                                                                                             | response code | response message                    | jsonPath                                                                 | endpointType | itemName |
      | application/json | raw   | false | Get          | settings/analyzers/LocalFileCollector                                                                    |                                                                                                  | 200           | Teradata_LFC_With_Filter            |                                                                          |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter                               | ida/teradataDBFileCollector_V15/PluginConfiguration/sc13TeradataCatalogerWithDBfilterConfig.json | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Put          | settings/analyzers/TeradataDBFileCollector                                                               | ida/teradataDBFileCollector_V15/PluginConfiguration/sc14TeradataFileCollectorConfig.json         | 204           |                                     |                                                                          |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBCataloger                                                                   |                                                                                                  | 200           | TeraDataCatalogerWithDatabaseFilter |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter  | ida/teradataDBFileCollector_V15/empty.json                                                       | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/TeradataDBCataloger/TeraDataCatalogerWithDatabaseFilter |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeraDataCatalogerWithDatabaseFilter')].status |              |          |
      |                  |       |       | Get          | settings/analyzers/TeradataDBFileCollector                                                               |                                                                                                  | 200           | TeradataFileCollector2              |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2          |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeradataFileCollector2')].status              |              |          |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2           | ida/teradataDBFileCollector_V15/empty.json                                                       | 200           |                                     |                                                                          |              |          |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/collector/TeradataDBFileCollector/TeradataFileCollector2          |                                                                                                  | 200           | IDLE                                | $.[?(@.configurationName=='TeradataFileCollector2')].status              |              |          |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user confirm "non presence of window" for the below item types
      | catalogName | facetName | facet         | itemName           | windowName |
      | Default     | Project   | Metadata Type | Teradata_LFC_Files | Services   |

  Scenario: SC#14: Delete the items for scenario: Verify the external files are not linked if invalid service name in config
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                    | type                | query | param |
      | SingleItemDelete | Default | Teradata_LFC_Files                      | Project             |       |       |
      | SingleItemDelete | Default | 10.33.6.190                             | Cluster             |       |       |
      | MultipleIDDelete | Default | collector/TeradataDBFileCollector/Tera% | Analysis            |       |       |
      | MultipleIDDelete | Default | cataloger/TeradataDBCataloger/Tera%     | Analysis            |       |       |
      | SingleItemDelete | Default | Test_BA_TeradataLFC                     | BusinessApplication |       |       |


  Scenario Outline: Delete the credential and Plugin Configuration in Teradata
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                        | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/TeradataCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/LocalFileCollector      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/TeradataDBDataSource    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/TeradataDBAnalyzer      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/TeradataDBCataloger     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/TeradataDBFileCollector |      | 204           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/TeradataDBPostProcessor |      | 204           |                  |          |
