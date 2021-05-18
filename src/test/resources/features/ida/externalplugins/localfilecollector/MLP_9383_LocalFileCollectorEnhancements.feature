Feature: Feature to validate the collection of Files from Docker container through the Local File Collector plugin

  TestcaseId_5706724 - Run Local File Collector Plugin and Verify Logs and Metadata

#  @LFC @IDA_E2E
#  Scenario: SC1 - Copying files from local to docker machine for "Basic Functionality"
#    Given user connects to the SFTP server for below parameters
#      | sftpHost   | sftpPort   | sftpUser   | sftpPw         | sftpAction   | localDir                           | remoteDir                   |
#      | dockerHost | dockerPort | dockerUser | dockerPassword | uploadFolder | ida/localFileCollectorPayloads/LCL | /home/becubic_build@asg.com |
#    And user connects to the sftp server and runs docker commands
#      | command | Filename |
#      | LFC     | idc_core |

  @webtest
  Scenario:Verify captions and tool tip text in LFC config
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute          |
      | Type      | Collector          |
      | Plugin    | LocalFileCollector |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                |
      | Label                |
      | root*                |
      | Business Application |
      | projectDepth         |

  @webtest @jdbc
  Scenario:Verify proper error message is shown if mandatory fields are not filled in LFC plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute          |
      | Type      | Collector          |
      | Plugin    | LocalFileCollector |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
      | root      | root field should not be empty |

  @LFC @IDA_E2E
  Scenario: SC1 - Create Local localFileCollector Plugin config and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                  | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                    | ida/localFileCollectorPayloads/Configurations/TestcaseId_5706724.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                    |                                                                       | 200           | BasicFunctionality |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/BasicFunctionality |                                                                       | 200           | IDLE               | $.[?(@.configurationName=='BasicFunctionality')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/BasicFunctionality  |                                                                       | 200           | IDLE               |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/BasicFunctionality |                                                                       | 200           | IDLE               | $.[?(@.configurationName=='BasicFunctionality')].status |

#TestcaseId_6621182 - Verify whether the project which are cataloged from LFC directorial structure instead of flat file structure
  @webtest @LFC
  Scenario: SC1 - Collecting the repository and validating the source count in IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/BasicFunctionality%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 0             | Description |
      | Number of processed items | 10            | Description |
    And user verifies "Processed Items" table should have following values
      | fileName                       | fileType  |
      | lfc_testfiles                  | Project   |
      | resources                      | Directory |
      | examples                       | Directory |
      | python                         | Directory |
      | file1.parquet                  | File      |
      | users.parquet                  | File      |
      | SnowFlake_df_multiple_write.py | File      |
      | CascadingDataFrames.py         | File      |
      | namesAndFavColors.parquet      | File      |
      | SparkReadWrite.py              | File      |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "collector/LocalFileCollector/BasicFunctionality/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                           | logCode       | pluginName         | removableText  |
      | INFO | Plugin started                                                                                                                                                                     | ANALYSIS-0019 |                    |                |
      | INFO | Plugin Name:LocalFileCollector, Plugin Type:collector, Plugin Version:1.0.0.SNAPSHOT, Node Name:InternalNode, Host Name:2dd09a954f6b, Plugin Configuration name:BasicFunctionality | ANALYSIS-0071 | LocalFileCollector | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin LocalFileCollector Configuration: ---  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: name: "BasicFunctionality"  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: pluginVersion: "LATEST"  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: label:  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:   : "BasicFunctionality"  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: catalogName: "Default"  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: eventClass: null  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: eventCondition: null  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: nodeCondition: "type=='internal'"  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: maxWorkSize: 100  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: tags:  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: - "LFC"  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: pluginType: "COLLECTOR"  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: dataSource: null  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: credential: null  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: businessApplicationName: null  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: dryRun: false  2020-08-20 09:58:31.418 INFO  - ANALYSIS-0073: Plugin LocalFileCollector Configuration: schedule: null  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: filter:  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:   filters: []  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:   deltaTime: null  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:   extraFilters:  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:     filefilters:  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:     - class: "com.asg.dis.common.analysis.dom.FileFilter"  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:       label:  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:         : "DemoFilter"  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:       tags: null  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:       fileMode: "include"  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:       objectType: "file"  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:       expressionType: "simple"  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:       expressions:  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:       - ""  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration:   maxHits: null  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: contentAnalyzerPlugin: "UnstructuredDataAnalyzer"  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: root: "/lfc_testfiles"  2020-03-12 05:58:58.241 INFO - ANALYSIS-0073: Plugin LocalFileCollector Configuration: incrementalRun: true | ANALYSIS-0073 | LocalFileCollector |                |
      | INFO | Plugin LocalFileCollector Start Time:2020-03-02 06:55:55.916, End Time:2020-03-02 06:56:01.436, Processed Count:10, Errors:0, Warnings:0                                           | ANALYSIS-0072 | LocalFileCollector |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.520)                                                                                                                     | ANALYSIS-0020 |                    |                |

#  @sanity @positive @regression @IDA_E2E
#  Scenario Outline: Add valid EDI Credentials for LFC
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                        | body                                                       | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/LFC_EDIBusCredentials | idc/EdiBusPayloads/credentials/EDIBusValidCredentials.json | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/LFC_EDIBusCredentials |                                                            | 200           |                  |          |
#
#
#  #6549303
#  @sanity @positive @webtest @edibus
#  Scenario:SC1:MLP-9043_Verify the LocalFile Collector items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "LFC" and clicks on search
#    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Local Files" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | File      |
#      | Directory |
#      | Analysis  |
#      | Project   |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | LOCALFILE   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/LocalFileConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                              | body                                            | response code | response message | jsonPath                                         |
#      | application/json | raw   | false | Put          | settings/analyzers/EDIBusDataSource                              | idc/EdiBusPayloads/DataSource/EDIBusDS_LFC.json | 204           |                  |                                                  |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                        | idc/EdiBusPayloads/LocalFileConfig.json         | 204           |                  |                                                  |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusLocal |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBusLocal')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusLocal  |                                                 | 200           |                  |                                                  |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusLocal |                                                 | 200           | IDLE             | $.[?(@.configurationName=='EDIBusLocal')].status |
#    And user enters the search text "EDIBusLocal" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusLocal%"
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Number of errors  | 0             | Description |
#    And user enters the search text "LFC" and clicks on search
#    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Local Files" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | LOCALFILE   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                        |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/Local Files |
#      | $..selections.['type_s'][*]                   | File                                              |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=LFC&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | LOCALFILE   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user enters the search text "LFC" and clicks on search
#    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Local Files" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Project" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
#      | AP-DATA      | LOCALFILE   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM ) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                        |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/Local Files |
#      | $..selections.['type_s'][*]                   | Project                                           |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=LFC&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
#      | AP-DATA      | LOCALFILE   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM ) |
#    And user enters the search text "LFC" and clicks on search
#    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Local Files" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Directory" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | LOCALFILE   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY ) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                        |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/Local Files |
#      | $..selections.['type_s'][*]                   | Directory                                         |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=LFC&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | LOCALFILE   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY ) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                 |
#      | AP-DATA      | LOCALFILE   | 1.0                | (XNAME * *  ~/ @*Local@ Files≫DEFAULT≫DWR_DAT_FILE≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | LOCALFILE   | 1.0                | (XNAME * *  ~/ @*Local@ Files≫DEFAULT≫DWR_DAT_DIRECTORY≫@* ),AND,( TYPE = DWR_IDC )   |
#      | AP-DATA      | LOCALFILE   | 1.0                | (XNAME * *  ~/ @*Local@ Files≫DEFAULT≫DWR_DAT_FILE_SYSTEM≫@* ),AND,( TYPE = DWR_IDC ) |

  #TestcaseId_6785601 - Verify Sub dir size, file size , no of sub dir, and no. of files in all levels
  @webtest @LFC
  Scenario: SC1 - Verify directory size, No.of files, size of files, No. of sub directories and size of sub directories in all levels
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "LFC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/BasicFunctionality%"
    Then user performs click and verify in new window
      | Table           | value  | Action               | RetainPrevwindow | indexSwitch |
      | Processed Items | python | click and switch tab | No               |             |
    Then user "verify metadata property values" with following expected parameters for item "python"
      | Directory size | Number of files | Size of files | Number of sub-directories | Size of sub-directories |
      | 4835           | 2               | 2308          | 1                         | 2527                    |
    Then user performs click and verify in new window
      | Table         | value    | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | examples | click and switch tab | No               |             |
    Then user "verify metadata property values" with following expected parameters for item "examples"
      | Directory size | Number of files | Size of files | Number of sub-directories | Size of sub-directories |
      | 2527           | 1               | 1912          | 1                         | 615                     |
    Then user performs click and verify in new window
      | Table         | value     | Action               | RetainPrevwindow | indexSwitch |
      | has_Directory | resources | click and switch tab | No               |             |
    Then user "verify metadata property values" with following expected parameters for item "resources"
      | Directory size | Number of files | Size of files | Number of sub-directories | Size of sub-directories |
      | 615            | 1               | 615           | 0                         | 0                       |

  @sanity @positive
  Scenario:SC#1:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | MultipleIDDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |
      | MultipleIDDelete | Default | lfc_testfiles                  | Project  |       |       |

  @sanity @positive
  Scenario Outline:SC1:Delete Plugin configurations and catalog "BasicFunctionality"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |

#############################################################DRY RUN#############################################################################################

  @LFC
  Scenario:SC2:create plugin configuration for the Dry run functionality
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body                                                      | response code | response message | jsonPath                                     |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                         | ida/localFileCollectorPayloads/Configurations/DryRun.json | 204           |                  |                                              |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                         |                                                           | 200           | Dry_Run          |                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/Dry_Run |                                                           | 200           | IDLE             | $.[?(@.configurationName=='Dry_Run')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/Dry_Run  |                                                           | 200           | IDLE             |                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/Dry_Run |                                                           | 200           | IDLE             | $.[?(@.configurationName=='Dry_Run')].status |

  @webtest @LFC
  Scenario:SC2:Verify the type facet is not visivle for the Local File collector with Dryn run enabled as true
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "LFC" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify not displayed" for listed "Tags" facet in Search results page
      | ItemType      |
      | Full Name     |
      | Address       |
      | Email Address |
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/Dry_Run%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "collector/LocalFileCollector/Dry_Run/%" should display below info/error/warning
      | type | logValue                                          | logCode       | pluginName | removableText |
      | INFO | Plugin LocalFileCollector running on dry run mode | ANALYSIS-0069 |            |               |

  @sanity @positive
  Scenario:SC#2:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis |       |       |

  @sanity @positive
  Scenario Outline:SC2:Delete Plugin configurations and catalog "BasicFunctionality"
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector |      | 204           |                  |          |

##########################################################BussinessApplication & Technology Tag#######################################################

  @aws @precondition
  Scenario:SC3: MLP-1960:Update the aws credential Json
    Given User update the below "aws credentials" in following files using json path
      | filePath                                           | accessKeyPath | secretKeyPath |
      | ida/amazonPayloads/credentials/awsCredentials.json | $..accessKey  | $..secretKey  |

  @webtest
  Scenario:SC3: MLP-7847:Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgqas3testautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName            | keyPrefix                | dirPath                                 | recursive |
      | asgqas3testautomation | AutoTestData/TestFolder1 | ida/amazonPayloads/TestData/TestFolder1 | true      |


#6978888,6918891,6979338,6978892,6978890,6978889
  @sanity @positive @regression @IDA_E2E
  Scenario Outline:SC3: create BussinessApplication tag and run the plugin configuration with the new field for Local File Collector , Git collector and AWS plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | \ida\localFileCollectorPayloads\API_Files\BussinessApplication_onlyPython.json | 200           |                  |          |

  @LFC
  Scenario:SC3:create plugin configuration and Run LFC, Git And AmazonS3
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                         | body                                                                            | response code | response message      | jsonPath                                                   |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                       | ida/localFileCollectorPayloads/Configurations/BusinessApplication_LFC.json      | 204           |                       |                                                            |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                       |                                                                                 | 200           | LocalFileCollector_BA |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/LocalFileCollector_BA |                                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='LocalFileCollector_BA')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/LocalFileCollector_BA  |                                                                                 | 200           | IDLE                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/LocalFileCollector_BA |                                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='LocalFileCollector_BA')].status |
      |                  |       |       | Put          | settings/credentials/SampleCredentialsgit                                                   | ida/localFileCollectorPayloads/Configurations/GitCredentials.json               | 200           |                       |                                                            |
      |                  |       |       | Put          | settings/analyzers/GitCollectorDataSource                                                   | ida/localFileCollectorPayloads/Configurations/gitDatasourceConfig.json          | 204           |                       |                                                            |
      |                  |       |       | Put          | settings/analyzers/GitCollector                                                             | ida/localFileCollectorPayloads/Configurations/BusinessApplication_Git.json      | 204           |                       |                                                            |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                             |                                                                                 | 200           | GitCollector          |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                   |                                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='GitCollector')].status          |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector                    |                                                                                 | 200           | IDLE                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                   |                                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='GitCollector')].status          |
      |                  |       |       | Put          | settings/analyzers/GitCollector                                                             | ida/localFileCollectorPayloads/Configurations/BusinessApplication_Git_NOBA.json | 204           |                       |                                                            |
      |                  |       |       | Get          | settings/analyzers/GitCollector                                                             |                                                                                 | 200           | GitCollector          |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                   |                                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='GitCollector')].status          |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollector                    |                                                                                 | 200           | IDLE                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollector                   |                                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='GitCollector')].status          |
      |                  |       |       | Put          | settings/credentials/AWS_S3Credentials                                                      | ida/amazonPayloads/credentials/awsCredentials.json                              | 200           |                       |                                                            |
      |                  |       |       | Put          | settings/analyzers/AmazonS3DataSource                                                       | ida/amazonPayloads/DataSource/AmazonS3DataSourceConfig.json                     | 204           |                       |                                                            |
      |                  |       |       | Put          | settings/analyzers/AmazonS3Cataloger                                                        | ida/localFileCollectorPayloads/Configurations/BusinessApplication_AmazonS3.json | 204           |                       |                                                            |
      |                  |       |       | Get          | settings/analyzers/AmazonS3Cataloger                                                        |                                                                                 | 200           | AmazonS3Catalog       |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3Catalog')].status       |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*                          |                                                                                 | 200           | IDLE                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/*                         |                                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='AmazonS3Catalog')].status       |
      |                  |       |       | Put          | settings/analyzers/LocalFileCollector                                                       | ida/localFileCollectorPayloads/Configurations/BusinessApplication_LFC.json      | 204           |                       |                                                            |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                       |                                                                                 | 200           | LocalFileCollector_BA |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/LocalFileCollector_BA |                                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='LocalFileCollector_BA')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/LocalFileCollector_BA  |                                                                                 | 200           | IDLE                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/LocalFileCollector_BA |                                                                                 | 200           | IDLE                  | $.[?(@.configurationName=='LocalFileCollector_BA')].status |


#6978888,6918891,6979338,6978892,6978890,6978889
  @sanity @positive @regression @IDA_E2E
  Scenario Outline:SC4:create BussinessApplication tag and run the plugin configuration with the new field for Local File Collector
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | \ida\localFileCollectorPayloads\API_Files\BussinessApplication_BA.json | 200           |                  |          |

  @LFC
  Scenario:SC4:create plugin configuration and Run LFC
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                         | body                                                                        | response code | response message      | jsonPath                                                   |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                                       | ida/localFileCollectorPayloads/Configurations/BusinessApplication_LFC2.json | 204           |                       |                                                            |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                                       |                                                                             | 200           | LocalFileCollector_BA |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/LocalFileCollector_BA |                                                                             | 200           | IDLE                  | $.[?(@.configurationName=='LocalFileCollector_BA')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/LocalFileCollector_BA  |                                                                             | 200           | IDLE                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/LocalFileCollector_BA |                                                                             | 200           | IDLE                  | $.[?(@.configurationName=='LocalFileCollector_BA')].status |

  @sanity @positive @MLP-7660 @webtest @IDA-10.0
  Scenario:SC3:SC4:Verify the technology tags got assigned to all catalogued items like File,Directory,Analysis, Project...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet | Tag                | fileName      | userTag |
      | Default     | Directory | Type  | Local Files,LFC    | resources     | LFC     |
      | Default     | Project   | Type  | BA,Local Files,LFC | lfc_testfiles | LFC     |
      | Default     | File      | Type  | Local Files,LFC    | users.parquet | LFC     |


    ##  #6689699#
  @sanity @positive
  Scenario Outline:SC5: user get the Dynamic ID's (Source ID) for the plugin LocalFileCollector , GitCollector and Amazon S3
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                    | type                | targetFile                                                     | jsonpath                                 |
      | APPDBPOSTGRES | Default | lfc_testfiles                                           | Project             | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json | $..onlyPython.LCL.has_Directory.id       |
      | APPDBPOSTGRES | Default | onlyPython                                              | BusinessApplication | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json | $..BusinessApplication_Tag.onlyPython.id |
      | APPDBPOSTGRES | Default | BA                                                      | BusinessApplication | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json | $..BusinessApplication_Tag.BA.id         |
      | APPDBPOSTGRES | Default | collector/LocalFileCollector/LocalFileCollector_BA/%DYN |                     | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json | $..onlyPython.LCL..has_Analysis.id       |
      | APPDBPOSTGRES | Default | pythonanalyzerdemo                                      | Project             | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json | $..onlyPython.Git_BA.has_Directory.id    |
      | APPDBPOSTGRES | Default | collector/GitCollector/%DYN                             |                     | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json | $..onlyPython.Git_BA..has_Analysis.id    |
      | APPDBPOSTGRES | Default | asgqas3testautomation                                   | Directory           | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json | $..onlyPython.AmazonS3.has_Directory.id  |
      | APPDBPOSTGRES | Default | cataloger/AmazonS3Cataloger/%DYN                        |                     | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json | $..onlyPython.AmazonS3..has_Analysis.id  |

  @sanity @positive
  Scenario Outline:SC6: user hits the Business Application ID and store it in a seperate file
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                                      | responseCode | inputJson                                | inputFile                                                      | outPutFile                                                                      | outPutJson |
      | components/Default/item/Default.BusinessApplication:::dynamic/?pages=ALL | 200          | $..BusinessApplication_Tag.onlyPython.id | payloads/ida/localFileCollectorPayloads/API_Files/itemIds.json | payloads/ida/localFileCollectorPayloads/API_Files/onlyPythonfiles_response.json |            |

  @sanity @positive
  Scenario Outline:SC7: user retrieves the metadata of each item for a catalog
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                      | body                                                                     | response code | response message | filePath                                                                        | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=onlyPython&limitFacet=2500&offset=0&limit=2500 | payloads/ida/localFileCollectorPayloads/API_Files/BA_Input_LFC.json      | 200           |                  | payloads/ida/localFileCollectorPayloads/API_Files/onlyPythonfiles_LFC.json      |          |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=onlyPython&limitFacet=2500&offset=0&limit=2500 | payloads/ida/localFileCollectorPayloads/API_Files/BA_Input_Git.json      | 200           |                  | payloads/ida/localFileCollectorPayloads/API_Files/onlyPythonfiles_Git.json      |          |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=onlyPython&limitFacet=2500&offset=0&limit=2500 | payloads/ida/localFileCollectorPayloads/API_Files/BA_Input_AmazonS3.json | 200           |                  | payloads/ida/localFileCollectorPayloads/API_Files/onlyPythonfiles_AmazonS3.json |          |


    #6978888,6918891,6979338,6978892,6978890,6978889
  @MLP-13399 @sanity @positive @IDA_E2E
  Scenario Outline:SC8: Validate the Total count of Type's matches from user defined data to the UI API BA Response for LFC , Git and AmazonS3 plugin
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                       | actualValues                                                                    | valueType  | expectedJsonPath                     | actualJsonPath                                                                                      |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.GitCollector.Data_Elements          | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='GitCollector')].totalCount       |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.GitCollector.Directory              | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='GitCollector')]..Directory       |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.GitCollector.Project                | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='GitCollector')]..Project         |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.GitCollector.File                   | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='GitCollector')]..File            |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.LocalFileCollector_BA.Data_Elements | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='LocalFileCollector')].totalCount |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.LocalFileCollector_BA.Directory     | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='LocalFileCollector')]..Directory |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.LocalFileCollector_BA.Project       | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='LocalFileCollector')]..Project   |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.LocalFileCollector_BA.File          | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='LocalFileCollector')]..File      |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.LocalFileCollector_BA.Analysis      | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='LocalFileCollector')]..Analysis  |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.AmazonS3.Data_Elements | $.data[6]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='AmazonS3Cataloger')].totalCount |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.AmazonS3.Directory     | $.data[6]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='AmazonS3Cataloger')]..Directory |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.AmazonS3.Cluster       | $.data[6]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='AmazonS3Cataloger')]..Cluster   |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.AmazonS3.File          | $.data[6]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='AmazonS3Cataloger')]..File      |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.AmazonS3.Service       | $.data[6]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='AmazonS3Cataloger')]..Service   |
      | payloads\ida\localFileCollectorPayloads\API_Files\BA_Metavalues.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | intCompare | $..onlyPython.AmazonS3.Analysis      | $.data[6]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='AmazonS3Cataloger')]..Analysis  |

    #6978888,6918891,6979338,6978892,6978890,6978889
  @MLP-13399 @sanity @positive @IDA_E2E
  Scenario Outline:SC9: validate the DataElements from BA Response to Search results Response API for the plugin LFC , Git and AmazonS3
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                  | actualValues                                                                    | valueType  | expectedJsonPath                                                                                    | actualJsonPath                                   |
      | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_LFC.json      | intCompare | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='LocalFileCollector')].totalCount | $.count                                          |
      | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_LFC.json      | intCompare | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='LocalFileCollector')]..File      | $..type_s.values.[?(@.value=='File')].count      |
      | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_LFC.json      | intCompare | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='LocalFileCollector')]..Project   | $..type_s.values.[?(@.value=='Project')].count   |
      | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_LFC.json      | intCompare | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='LocalFileCollector')]..Directory | $..type_s.values.[?(@.value=='Directory')].count |
      | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_Git.json      | intCompare | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='GitCollector')].totalCount       | $.count                                          |
      | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_Git.json      | intCompare | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='GitCollector')]..File            | $..type_s.values.[?(@.value=='File')].count      |
      | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_Git.json      | intCompare | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='GitCollector')]..Project         | $..type_s.values.[?(@.value=='Project')].count   |
      | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_Git.json      | intCompare | $.data[5]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='GitCollector')]..Directory       | $..type_s.values.[?(@.value=='Directory')].count |
      | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_AmazonS3.json | intCompare | $.data[6]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='AmazonS3Cataloger')].totalCount | $.count                                          |
      | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_AmazonS3.json | intCompare | $.data[6]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='AmazonS3Cataloger')]..File      | $..type_s.values.[?(@.value=='File')].count      |
      | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_AmazonS3.json | intCompare | $.data[6]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='AmazonS3Cataloger')]..Directory | $..type_s.values.[?(@.value=='Directory')].count |
      | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_AmazonS3.json | intCompare | $.data[6]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='AmazonS3Cataloger')]..Cluster   | $..type_s.values.[?(@.value=='Cluster')].count   |
      | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_response.json | payloads\ida\localFileCollectorPayloads\API_Files\onlyPythonfiles_AmazonS3.json | intCompare | $.data[6]..[?(@.caption=='Data Statistics')].data.[?(@.pluginName=='AmazonS3Cataloger')]..Service   | $..type_s.values.[?(@.value=='Service')].count   |


  Scenario Outline:SC10:user deletes the item from database using dynamic id stored in json "Business Application"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                                | inputFile                                                      |
      | items/Default/Default.Project:::dynamic             | 204          | $..onlyPython.LCL.has_Directory.id       | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json |
      | items/Default/Default.Project:::dynamic             | 204          | $..onlyPython.Git_BA.has_Directory.id    | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json |
      | items/Default/Default.Directory:::dynamic           | 204          | $..onlyPython.AmazonS3.has_Directory.id  | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..onlyPython.LCL..has_Analysis.id       | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..onlyPython.Git_BA..has_Analysis.id    | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json |
      | items/Default/Default.Analysis:::dynamic            | 204          | $..onlyPython.AmazonS3..has_Analysis.id  | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_Tag.onlyPython.id | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_Tag.BA.id         | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json |


       ##  #6689699#
  Scenario Outline:SC11: user get the Dynamic ID's (Analysis ID) for the plugin LocalFileCollector and GitCollector 2nd run
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                    | type | targetFile                                                     | jsonpath                              |
      | APPDBPOSTGRES | Default | collector/LocalFileCollector/LocalFileCollector_BA/%DYN |      | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json | $..onlyPython.LCL..has_Analysis.id    |
      | APPDBPOSTGRES | Default | collector/GitCollector/%DYN                             |      | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json | $..onlyPython.Git_BA..has_Analysis.id |

  Scenario Outline:SC12:user deletes the item from database using dynamic id stored in json for the second run of LFC and Git
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                             | inputFile                                                      |
      | items/Default/Default.Analysis:::dynamic | 204          | $..onlyPython.LCL..has_Analysis.id    | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json |
      | items/Default/Default.Analysis:::dynamic | 204          | $..onlyPython.Git_BA..has_Analysis.id | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json |

           ##  #6689699#
  Scenario Outline:SC13: user get the Dynamic ID's (Analysis ID) for the plugin LocalFileCollector 3rd run
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                    | type | targetFile                                                     | jsonpath                           |
      | APPDBPOSTGRES | Default | collector/LocalFileCollector/LocalFileCollector_BA/%DYN |      | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json | $..onlyPython.LCL..has_Analysis.id |

  Scenario Outline:SC14: user deletes the item from database using dynamic id stored in json for the third run of LFC
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson                          | inputFile                                                      |
      | items/Default/Default.Analysis:::dynamic | 204          | $..onlyPython.LCL..has_Analysis.id | payloads\ida\localFileCollectorPayloads\API_Files\itemIds.json |

  ##############################################Halt Error Cases#######################################################

  @LFC
  Scenario:SC5:Create Local localFileCollector Plugin config with invalid root folder name and run it
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body                                                                 | response code | response message | jsonPath                                      |
      | application/json | raw   | false | Put          | settings/analyzers/LocalFileCollector                                          | ida/localFileCollectorPayloads/Configurations/Halt_Error_Config.json | 204           |                  |                                               |
      |                  |       |       | Get          | settings/analyzers/LocalFileCollector                                          |                                                                      | 200           | LFC_Halt         |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/LFC_Halt |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='LFC_Halt')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/collector/LocalFileCollector/LFC_Halt  |                                                                      | 200           | IDLE             |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/collector/LocalFileCollector/LFC_Halt |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='LFC_Halt')].status |

  #7063152
  @webtest @LFC
  Scenario: SC5- Verify Halt error is displaying in analysis logs for invalid root folder is given in LFC configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Halt" and clicks on search
    And user performs "facet selection" in "Halt" attribute under "Tags" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "collector/LocalFileCollector/LFC_Halt%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "collector/LocalFileCollector/LFC_Halt/%" should display below info/error/warning
      | type | logValue                                                                        | logCode             | pluginName | removableText |
      | HALT | ANALYSIS-LOCAL-0003: Root Directory /home/root does not exist or cannot be read | ANALYSIS-LOCAL-0003 |            |               |

  #7063153 #7064212
  @webtest @regression @positive
  Scenario:SC5:Verification of error message on Manage configuration by clicking the Error icon
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | InternalNode |
    And user waits for the final status to be reflected after "1500" milliseconds
    And user performs "click" operation in Manage Configurations panel
      | button      | actionItem         |
      | Open Plugin | LocalFileCollector |
    And user performs "click" operation in Manage Configurations panel
      | button     | actionItem |
      | Error Icon | LFC_Halt   |
    And user verifies "Error tooltip" is "displayed" in Manage Configurations panel
    And user "verifies presence" of following "Text in Error tooltip" in Manage Configurations Page
      | ANALYSIS-LOCAL-0003: Root Directory /home/root does not exist or cannot be read |

  #7064214
  @webtest @regression @positive
  Scenario:SC5:verify error message is clearing by clicking the clear and clear all links
    Given  User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | InternalNode |
    And user waits for the final status to be reflected after "1500" milliseconds
    And user performs "click" operation in Manage Configurations panel
      | button      | actionItem         |
      | Open Plugin | LocalFileCollector |
    And user performs "click" operation in Manage Configurations panel
      | button     | actionItem |
      | Error Icon | LFC_Halt   |
    And user performs "click" operation in Manage Configurations panel
      | button | actionItem |
      | Clear  | LFC_Halt   |

  @sanity @positive
  Scenario:SC#5:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type                | query | param |
      | SingleItemDelete | Default | collector/LocalFileCollector/% | Analysis            |       |       |
      | SingleItemDelete | Default | onlyPython                     | BusinessApplication |       |       |
      | SingleItemDelete | Default | BA                             | BusinessApplication |       |       |

  #######################################################################################################################################################

  Scenario Outline: Delete Plugin configurations and credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                       | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/LocalFileCollector     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollector           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3Cataloger      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GitCollectorDataSource |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/SampleCredentialsgit |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/AWS_S3Credentials    |      | 200           |                  |          |

  @aws
  Scenario:SC1#Delete the version bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqas3testautomation"
    Then user "Delete" a bucket "asgqas3testautomation" in amazon storage service