@MLP-23146 @MLP-27617

Feature:Verification of OrcS3 Cataloger Implementation
  Description: MLP-23146 - Orc S3 Cataloger Implementation

  ############################################ Pre Conditions ##########################################################
  @aws
  Scenario: SC#1: Create a bucket and folder with orc files in S3 Amazon storage
    Given user "Create" a bucket "asgqaorcautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName         | keyPrefix   | dirPath                     | recursive |
      | asgqaorcautomation | OrcTestData | ida/s3OrcPayloads/TestData/ | true      |

  Scenario: SC#1: Update credential payload json for OrcS3
    Given User update the below "S3 Readonly credentials" in following files using json path
      | filePath                                                 | accessKeyPath | secretKeyPath |
      | ida/s3OrcPayloads/Credentials/orcS3ValidCredentials.json | $..accessKey  | $..secretKey  |

  ##7190172##
  @sanity @positive
  Scenario Outline: SC#1:Configure the Credentials for OrcS3Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                            | body                                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidOrcS3Credentials     | ida/s3OrcPayloads/Credentials/orcS3ValidCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/IncorrectOrcS3Credentials | ida/s3OrcPayloads/Credentials/orcS3InvalidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EmptyOrcS3Credentials     | ida/s3OrcPayloads/Credentials/orcS3EmptyCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidOrcS3Credentials     |                                                            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/IncorrectOrcS3Credentials |                                                            | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EmptyOrcS3Credentials     |                                                            | 200           |                  |          |

  @sanity @positive @regression
  Scenario Outline: SC#1: Create BusinessApplication tag for OrcS3Cataloger and run the plugin configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/s3OrcPayloads/OrcS3BusinessApplication.json | 200           |                  |          |

  @cr-data @sanity @positive
  Scenario: SC#1: Configure the Orc S3 Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                | body                                                               | response code | response message | jsonPath        |
      | application/json | raw   | false | Put  | settings/analyzers/OrcS3DataSource | ida/s3OrcPayloads/DataSource/AmazonOrcS3ValidDataSourceConfig.json | 204           |                  |                 |
      |                  |       |       | Get  | settings/analyzers/OrcS3DataSource |                                                                    | 200           |                  | OrcS3DataSource |


  #################### UI Validation: DataSource TestConnection, TooltipValidation, Error messages in config creation ####################
  ##7109637##
  @positive @regression @sanity @webtest @MLP-23146
  Scenario:SC#2: Verify Datasource Test Connection for the OrcS3DataSource should be successful when Valid Credentials are used
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Capture And Import Data Icon                       |
      | click       | Capture And Import Data Icon                       |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute       |
      | Data Source Type | OrcS3DataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute            |
      | Name      | OrcS3DataSource_Test |
      | Label     | OrcS3DataSource_Test |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute             |
      | Region     | us-east-1             |
      | Credential | ValidOrcS3Credentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And sync the test execution for "30" seconds
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"

  ##7109648##
  @webtest @MLP-23146 @negative @regression
  Scenario: SC#3: Verify OrcS3DataSource connection is unsuccessful when Invalid AWS credentials/Empty credentials are used.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Capture And Import Data Icon                       |
      | click       | Capture And Import Data Icon                       |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute       |
      | Data Source Type | OrcS3DataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                         |
      | Name      | OrcS3DataSource_InvalidDataSource |
      | Label     | OrcS3DataSource_InvalidDataSource |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                 |
      | Region     | us-east-1                 |
      | Credential | IncorrectOrcS3Credentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute             |
      | Credential | EmptyOrcS3Credentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"

  ##7109648##
  @MLP-23146 @positive @sanity @webtest
  Scenario: SC#4: Verify proper error message is shown if mandatory fields are not filled in OrcS3DataSource plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Capture And Import Data Icon                       |
      | click       | Capture And Import Data Icon                       |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | OrcS3DataSource |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name      | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  ##7110703##
  @MLP-23146 @webtest @positive @regression @sanity
  Scenario: SC#5: Verify captions and tool tip text in OrcS3DataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                                         |
      | mouse hover | Capture And Import Data Icon                       |
      | click       | Capture And Import Data Icon                       |
      | click       | Manage Data Sources                                |
      | click       | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute       |
      | Data Source Type | OrcS3DataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |
      | Node        |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name*       | Plugin configuration name                                                            |
      | Label       | Plugin configuration extended label and description                                  |
      | Credential* | Credential to be used                                                                |
      | Region*     | Geographic area where the Orc resources are available in Amazon S3 for data analysis |

  ##7190168##
  @MLP-27617 @webtest @positive @regression @sanity
  Scenario: SC#6: Verify captions and tool tip text in OrcS3Cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                   |
      | mouse hover | Capture And Import Data Icon |
      | click       | Capture And Import Data Icon |
      | click       | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Type      | Cataloger      |
      | Plugin    | OrcS3Cataloger |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                      |
      | Label                      |
      | Business Application       |
      | Bucket filter              |
      | Bucket names               |
      | S3 Objects filter          |
      | Directory prefixes to scan |
      | Sub Directory filter       |
      | File filter                |
      | Data Source*               |
      | Credential*                |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name*                      | Plugin configuration name                                                                                       |
      | Label                      | Plugin configuration extended label and description                                                             |
      | Business Application       | Business Application                                                                                            |
      | Bucket filter              | Apply filters to S3 buckets.                                                                                    |
      | Bucket names               | Add the bucket names to filter them based on the mode, Include/Exclude. All buckets are included if left empty. |
      | S3 Objects filter          | Apply filters to S3 objects, such as directories, sub-directories and files.                                    |
      | Directory prefixes to scan | Add the directory names/directory path prefixes to filter the S3 objects. Does not support regular expressions. |
      | Sub Directory filter       | Add the sub-directory names to filter the S3 objects. Supports regular expressions.                             |
      | File filter                | Add the file names to filter the S3 objects. Supports regular expressions.                                      |
      | Data Source*               | Data source connection to be used                                                                               |
      | Credential*                | Credential to be used                                                                                           |

  ##7190167##
  @MLP-27617 @positive @sanity @webtest
  Scenario: SC#7: Verify proper error message is shown if mandatory fields are not filled in OrcS3Cataloger plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem                   |
      | mouse hover | Capture And Import Data Icon |
      | click       | Capture And Import Data Icon |
      | click       | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute      |
      | Type      | Cataloger      |
      | Plugin    | OrcS3Cataloger |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name      | A         |
    And user press "BACK_SPACE" key using key press event
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  ######################################## PluginRun - OrcS3Cataloger - DryRun True ########################################
  Scenario Outline: SC#8:Run OrcS3Cataloger with dryrun as true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                      | body                                                                   | response code | response message         | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerDryRunTrue                               | ida/s3OrcPayloads/PluginConfiguration/sc1OrcS3CatalogerDryRunTrue.json | 204           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                        |                                                                        | 200           | OrcS3CatalogerDryRunTrue |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerDryRunTrue |                                                                        | 200           | IDLE                     | $.[?(@.configurationName=='OrcS3CatalogerDryRunTrue')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerDryRunTrue  | ida/empty.json                                                         | 200           |                          |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerDryRunTrue |                                                                        | 200           | IDLE                     | $.[?(@.configurationName=='OrcS3CatalogerDryRunTrue')].status |

  ##7190171##
  @webtest @MLP-27617
  Scenario: SC#8:UI_Validation: Verify OrcS3Cataloger plugin functionality with dry run as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "OrcS3CatalogerDryRunTrue" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OrcS3Cataloger/OrcS3CatalogerDryRunTrue%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "cataloger/OrcS3Cataloger/OrcS3CatalogerDryRunTrue%" should display below info/error/warning
      | type | logValue                                      | logCode       | pluginName     | removableText |
      | INFO | Plugin OrcS3Cataloger running on dry run mode | ANALYSIS-0069 | OrcS3Cataloger |               |

  Scenario: SC#8: Delete the items for scenario: with dry run as true
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3CatalogerDryRunTrue% | Analysis |       |       |

  ######################################## PluginRun - OrcS3Cataloger - DryRun False ########################################
  Scenario Outline: SC#9:Run OrcS3Cataloger with dryrun as false and filter Bucketname Include
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | body                                                         | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3Cataloger                               | ida/s3OrcPayloads/PluginConfiguration/sc1OrcS3Cataloger.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                              |                                                              | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger |                                                              | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  | ida/empty.json                                               | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger |                                                              | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |

  @MLP-27617 @sanity @positive @webtest
  Scenario: SC#9-Verify the facet counts are exact once the Orc S3 items are cataloged.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1OrcS3Cataloger" and clicks on search
    And user performs "facet selection" in "SC1OrcS3Cataloger" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Service   | 1     |
      | Cluster   | 1     |
      | Analysis  | 1     |
      | Directory | 6     |
      | File      | 13    |
      | Field     | 86    |
    And user clicks on logout button

  ######################################## Logging Enhancements ########################################
  ##7190170##
  @webtest @MLP-27617
  Scenario: SC#10:LoggingEnhancements: Verify OrcS3Cataloger collects Analysis item with proper log messages
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1OrcS3Cataloger" and clicks on search
    And user performs "facet selection" in "SC1OrcS3Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OrcS3Cataloger/OrcS3Cataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "cataloger/OrcS3Cataloger/OrcS3Cataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | logCode       | pluginName     | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0019 |                |                |
      | INFO | Plugin Name:OrcS3Cataloger, Plugin Type:cataloger, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:432cb529ffb1, Plugin Configuration name:OrcS3Cataloger                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0071 | OrcS3Cataloger | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: ---  2020-09-03 08:20:05.028 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: name: "OrcS3Cataloger"  2020-09-03 08:20:05.028 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: pluginVersion: "LATEST"  2020-09-03 08:20:05.028 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: label:  2020-09-03 08:20:05.028 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: : ""  2020-09-03 08:20:05.028 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: catalogName: "Default"  2020-09-03 08:20:05.028 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: eventClass: null  2020-09-03 08:20:05.028 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: eventCondition: null  2020-09-03 08:20:05.028 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: nodeCondition: "name==\"LocalNode\""  2020-09-03 08:20:05.028 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: maxWorkSize: 100  2020-09-03 08:20:05.028 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: tags:  2020-09-03 08:20:05.029 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: - "SC1OrcS3Cataloger"  2020-09-03 08:20:05.029 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: pluginType: "cataloger"  2020-09-03 08:20:05.029 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: dataSource: "OrcS3DataSource"  2020-09-03 08:20:05.029 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: credential: "ValidOrcS3Credentials"  2020-09-03 08:20:05.029 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: businessApplicationName: "Test_BA_OrcS3"  2020-09-03 08:20:05.029 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: dryRun: false  2020-09-03 08:20:05.029 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: schedule: null  2020-09-03 08:20:05.029 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: filter: null  2020-09-03 08:20:05.029 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: versionMode: false  2020-09-03 08:20:05.029 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: maxObjectsAmount: 1000  2020-09-03 08:20:05.029 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: pluginName: "OrcS3Cataloger"  2020-09-03 08:20:05.029 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: incremental: true  2020-09-03 08:20:05.029 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: type: "Cataloger"  2020-09-03 08:20:05.030 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: bucketFilter:  2020-09-03 08:20:05.030 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: mode: "INCLUDE"  2020-09-03 08:20:05.030 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: patterns:  2020-09-03 08:20:05.030 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: - "asgqaorcautomation"  2020-09-03 08:20:05.030 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: objectFilter:  2020-09-03 08:20:05.030 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: dirFilter:  2020-09-03 08:20:05.030 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: mode: "INCLUDE"  2020-09-03 08:20:05.030 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: patterns: []  2020-09-03 08:20:05.030 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: fileFilter:  2020-09-03 08:20:05.030 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: mode: "INCLUDE"  2020-09-03 08:20:05.030 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: patterns: []  2020-09-03 08:20:05.030 INFO  - ANALYSIS-0073: Plugin OrcS3Cataloger Configuration: dirPrefixes: [] | ANALYSIS-0073 | OrcS3Cataloger |                |
      | INFO | Plugin OrcS3Cataloger Start Time:2020-09-03 08:20:05.026, End Time:2020-09-03 08:20:20.617, Processed Count:2, Errors:0, Warnings:3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0072 | OrcS3Cataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0020 |                |                |
    And user clicks on logout button

  ##7190136##
  @MLP-27617 @webtest
  Scenario: SC#11: Verify Bucket level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1OrcS3Cataloger" and clicks on search
    And user performs "facet selection" in "SC1OrcS3Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "asgqaorcautomation" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue       | widgetName  |
      | Created by                | aws.saas.dev.di     | Description |
      | Location                  | asgqaorcautomation/ | Description |
      | Directory size            | 0                   | Statistics  |
      | Number of files           | 0                   | Statistics  |
      | Size of files             | 0                   | Statistics  |
      | Number of sub-directories | 1                   | Statistics  |
      | Size of sub-directories   | 0                   | Statistics  |
    And user clicks on logout button

  ##7190137##
  @MLP-27617 @webtest
  Scenario: SC#12: Verify Directory level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1OrcS3Cataloger" and clicks on search
    And user performs "facet selection" in "SC1OrcS3Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OrcTestData" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue                   | widgetName  |
      | Directory size            | 0                               | Statistics  |
      | Number of files           | 0                               | Statistics  |
      | Size of files             | 0                               | Statistics  |
      | Location                  | asgqaorcautomation/OrcTestData/ | Description |
      | Number of sub-directories | 3                               | Statistics  |
      | Size of sub-directories   | 16091                           | Statistics  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Modified          | Lifecycle  |
    And user clicks on logout button

  ##7190138##
  @MLP-27617 @webtest
  Scenario: SC#13: Verify sub directory level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1OrcS3Cataloger" and clicks on search
    And user performs "facet selection" in "SC1OrcS3Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TestOrc" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue                           | widgetName  |
      | Directory size            | 13465                                   | Statistics  |
      | Number of files           | 10                                      | Statistics  |
      | Size of files             | 13465                                   | Statistics  |
      | Location                  | asgqaorcautomation/OrcTestData/TestOrc/ | Description |
      | Number of sub-directories | 1                                       | Statistics  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName  |
      | Modified          | Description |
    And user clicks on logout button

  ##7190139##
  @MLP-27617 @webtest
  Scenario: SC#14: Verify File level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1OrcS3Cataloger" and clicks on search
    And user performs "facet selection" in "SC1OrcS3Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "UsingOrcJar.orc [File]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "UsingOrcJar.orc" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Modified           | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                          | widgetName  |
      | File size         | 583.00 Bytes                                           | Description |
      | Location          | asgqaorcautomation/OrcTestData/TestOrc/UsingOrcJar.orc | Description |

  #Field level metadata
  Scenario Outline: SC#15:User retrieves the item ids of Field items of files: UsingHive.orc
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name     | type | targetFile                              | jsonpath      |
      | APPDBPOSTGRES | Default | boolean1 |      | response/orcS3/actual/fieldItemIds.json | $..Field1.id  |
      | APPDBPOSTGRES | Default | byte1    |      | response/orcS3/actual/fieldItemIds.json | $..Field2.id  |
      | APPDBPOSTGRES | Default | short1   |      | response/orcS3/actual/fieldItemIds.json | $..Field3.id  |
      | APPDBPOSTGRES | Default | int1     |      | response/orcS3/actual/fieldItemIds.json | $..Field4.id  |
      | APPDBPOSTGRES | Default | long1    |      | response/orcS3/actual/fieldItemIds.json | $..Field5.id  |
      | APPDBPOSTGRES | Default | float1   |      | response/orcS3/actual/fieldItemIds.json | $..Field6.id  |
      | APPDBPOSTGRES | Default | double1  |      | response/orcS3/actual/fieldItemIds.json | $..Field7.id  |
      | APPDBPOSTGRES | Default | bytes1   |      | response/orcS3/actual/fieldItemIds.json | $..Field8.id  |
      | APPDBPOSTGRES | Default | string1  |      | response/orcS3/actual/fieldItemIds.json | $..Field9.id  |
      | APPDBPOSTGRES | Default | middle   |      | response/orcS3/actual/fieldItemIds.json | $..Field10.id |
      | APPDBPOSTGRES | Default | list     |      | response/orcS3/actual/fieldItemIds.json | $..Field11.id |
      | APPDBPOSTGRES | Default | map      |      | response/orcS3/actual/fieldItemIds.json | $..Field12.id |

  Scenario Outline: SC#15:User retrieves the metadata of Field type for files: UsingHive.orc
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>" of "<responsePath>"
    Examples:
      | url                                             | responseCode | inputJson    | inputFile                               | outPutFile                               | outPutJson                                               | responsePath                          |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field1.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field1.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field1.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field2.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field2.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field2.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field3.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field3.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field3.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field4.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field4.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field4.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field5.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field5.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field5.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field6.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field6.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field6.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field6.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field7.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field7.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field7.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field7.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field8.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field8.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field8.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field8.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field9.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field9.fieldActualName      | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field9.id  | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field9.fieldActualDataType  | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field10.id | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field10.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field10.id | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field10.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field11.id | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field11.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field11.id | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field11.fieldActualDataType | $..[?(@.caption=='Data type')]..value |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field12.id | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field12.fieldActualName     | $.caption.name                        |
      | components/Default/item/Default.Field:::dynamic | 200          | $.Field12.id | response/orcS3/actual/fieldItemIds.json | response/orcS3/actual/fieldMetadata.json | $..fieldActualMetaData.file1.field12.fieldActualDataType | $..[?(@.caption=='Data type')]..value |

  ##7190140##
  Scenario Outline: SC#15:Validate the Field level metadata results for files: UsingHive.orc
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                     | actualValues                             | valueType     | expectedJsonPath                             | actualJsonPath                                           |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field1.fieldName      | $..fieldActualMetaData.file1.field1.fieldActualName      |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field1.fieldDataType  | $..fieldActualMetaData.file1.field1.fieldActualDataType  |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field2.fieldName      | $..fieldActualMetaData.file1.field2.fieldActualName      |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field2.fieldDataType  | $..fieldActualMetaData.file1.field2.fieldActualDataType  |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field3.fieldName      | $..fieldActualMetaData.file1.field3.fieldActualName      |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field3.fieldDataType  | $..fieldActualMetaData.file1.field3.fieldActualDataType  |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field4.fieldName      | $..fieldActualMetaData.file1.field4.fieldActualName      |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field4.fieldDataType  | $..fieldActualMetaData.file1.field4.fieldActualDataType  |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field5.fieldName      | $..fieldActualMetaData.file1.field5.fieldActualName      |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field5.fieldDataType  | $..fieldActualMetaData.file1.field5.fieldActualDataType  |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field6.fieldName      | $..fieldActualMetaData.file1.field6.fieldActualName      |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field6.fieldDataType  | $..fieldActualMetaData.file1.field6.fieldActualDataType  |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field7.fieldName      | $..fieldActualMetaData.file1.field7.fieldActualName      |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field7.fieldDataType  | $..fieldActualMetaData.file1.field7.fieldActualDataType  |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field8.fieldName      | $..fieldActualMetaData.file1.field8.fieldActualName      |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field8.fieldDataType  | $..fieldActualMetaData.file1.field8.fieldActualDataType  |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field9.fieldName      | $..fieldActualMetaData.file1.field9.fieldActualName      |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field9.fieldDataType  | $..fieldActualMetaData.file1.field9.fieldActualDataType  |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field10.fieldName     | $..fieldActualMetaData.file1.field10.fieldActualName     |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field10.fieldDataType | $..fieldActualMetaData.file1.field10.fieldActualDataType |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field11.fieldName     | $..fieldActualMetaData.file1.field11.fieldActualName     |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field11.fieldDataType | $..fieldActualMetaData.file1.field11.fieldActualDataType |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field12.fieldName     | $..fieldActualMetaData.file1.field12.fieldActualName     |
      | response/orcS3/expected/orcS3ExpectedJsonData.json | response/orcS3/actual/fieldMetadata.json | stringCompare | $..fieldMetaData.file1.field12.fieldDataType | $..fieldActualMetaData.file1.field12.fieldActualDataType |

  ##7190142##
  @MLP-27617 @webtest @MLPQA-18063 @MLPQA-18064
  Scenario: SC#16:Verify OrcS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when OrcS3Cataloger is run with region and Bucketname with Include
    Given user gets amazon bucket "asgqaorcautomation" file count in "OrcTestData/TestOrc" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1OrcS3Cataloger" and clicks on search
    And user performs "facet selection" in "SC1OrcS3Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "TestOrc [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page
    And user enters the search text "SC1OrcS3Cataloger" and clicks on search
    And user performs "facet selection" in "SC1OrcS3Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "OrcTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | OrcTestData |
      | TestOrc     |
      | NonOrc      |
      | version     |
      | Incremental |
    And user enters the search text "SC1OrcS3Cataloger" and clicks on search
    And user performs "facet selection" in "SC1OrcS3Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.orc                                     |
      | incremental.orc                                     |
      | employee.orc                                        |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet         | Tag                                           | fileName     | userTag           |
      | Default     | File | Metadata Type | Test_BA_OrcS3,SC1OrcS3Cataloger,ORC,Amazon S3 | employee.orc | SC1OrcS3Cataloger |
    And user clicks on logout button

  ##7190169##
  @MLP-27617 @webtest @MLPQA-18063 @MLPQA-18064
  Scenario: SC#17:Verify the technology tags got assigned to all S3 Orc catalogued items like Cluster,Service,Database...etc
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                           | fileName           | userTag           |
      | Default     | Directory | Metadata Type | Test_BA_OrcS3,SC1OrcS3Cataloger,ORC,Amazon S3 | asgqaorcautomation | SC1OrcS3Cataloger |
      | Default     | Cluster   | Metadata Type | Test_BA_OrcS3,SC1OrcS3Cataloger,ORC,Amazon S3 | amazonaws.com      | SC1OrcS3Cataloger |
      | Default     | Field     | Metadata Type | Test_BA_OrcS3,SC1OrcS3Cataloger,ORC,Amazon S3 | username           | SC1OrcS3Cataloger |
      | Default     | File      | Metadata Type | Test_BA_OrcS3,SC1OrcS3Cataloger,ORC,Amazon S3 | employee.orc       | SC1OrcS3Cataloger |
      | Default     | Service   | Metadata Type | Test_BA_OrcS3,SC1OrcS3Cataloger,ORC,Amazon S3 | AmazonS3           | SC1OrcS3Cataloger |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag        | fileName           | userTag           |
      | Default     | Cluster   | Metadata Type | Data Files | amazonaws.com      | SC1OrcS3Cataloger |
      | Default     | Directory | Metadata Type | Data Files | asgqaorcautomation | SC1OrcS3Cataloger |
      | Default     | Field     | Metadata Type | Data Files | username           | SC1OrcS3Cataloger |
      | Default     | File      | Metadata Type | Data Files | employee.orc       | SC1OrcS3Cataloger |
      | Default     | Service   | Metadata Type | Data Files | AmazonS3           | SC1OrcS3Cataloger |
    And user enters the search text "SC1OrcS3Cataloger" and clicks on search
    And user performs "facet selection" in "SC1OrcS3Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OrcS3Cataloger/OrcS3Cataloger%"
    Then user "verify presence" of following "Tag List" in Item View Page
      | Test_BA_OrcS3     |
      | SC1OrcS3Cataloger |
      | ORC               |
      | Amazon S3        |
    And user clicks on logout button

  ##7190166##
  @MLP-27617 @webtest
  Scenario: SC#18:Verify breadcrumb hierarchy appears correctly in OrcS3Cataloger cataloged items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1OrcS3Cataloger" and clicks on search
    And user performs "facet selection" in "SC1OrcS3Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "employee.orc" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | amazonaws.com      |
      | AmazonS3           |
      | asgqaorcautomation |
      | OrcTestData        |
      | NonOrc             |
      | employee.orc       |
    And user clicks on logout button

  Scenario: SC#19: Delete the cataloged items from SC1
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaorcautomation                       | Directory |       |       |


  ################################################### Filters ###################################################
  Scenario Outline: SC#20:Run OrcS3Cataloger with filter: File Include
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                    | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerFileInclude                               | ida/s3OrcPayloads/PluginConfiguration/sc2OrcS3CatalogerFileInclude.json | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                         |                                                                         | 200           | OrcS3CatalogerFileInclude |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerFileInclude |                                                                         | 200           | IDLE                      | $.[?(@.configurationName=='OrcS3CatalogerFileInclude')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerFileInclude  | ida/empty.json                                                          | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerFileInclude |                                                                         | 200           | IDLE                      | $.[?(@.configurationName=='OrcS3CatalogerFileInclude')].status |

  ##7190146##
  @MLP-27617 @webtest
  Scenario: SC#20: Verify OrcS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when OrcS3Cataloger is run with region and Bucketname(Include)/File(include)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2OrcS3CatalogerFileInclude" and clicks on search
    And user performs "facet selection" in "SC2OrcS3CatalogerFileInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqaorcautomation |
      | OrcTestData        |
      | TestOrc            |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | NonOrc      |
      | Incremental |
    And user enters the search text "SC2OrcS3CatalogerFileInclude" and clicks on search
    And user performs "facet selection" in "SC2OrcS3CatalogerFileInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | UsingHive.orc |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | baseversion.orc                                     |
      | incremental.orc                                     |
      | employee.orc                                        |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    And user clicks on logout button

  Scenario: SC#20: Delete the cataloged items for scenario: Bucketname(Include)/File(Include)
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaorcautomation                       | Directory |       |       |


  Scenario Outline: SC#21:Run OrcS3Cataloger with filter: File Exclude
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                    | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerFileExclude                               | ida/s3OrcPayloads/PluginConfiguration/sc3OrcS3CatalogerFileExclude.json | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                         |                                                                         | 200           | OrcS3CatalogerFileExclude |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerFileExclude |                                                                         | 200           | IDLE                      | $.[?(@.configurationName=='OrcS3CatalogerFileExclude')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerFileExclude  | ida/empty.json                                                          | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerFileExclude |                                                                         | 200           | IDLE                      | $.[?(@.configurationName=='OrcS3CatalogerFileExclude')].status |

  ##7190147##
  @MLP-27617 @webtest
  Scenario: SC#21: Verify OrcS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when OrcS3Cataloger is run with region and Bucketname(Include)/File(exclude)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC3OrcS3CatalogerFileExclude" and clicks on search
    And user performs "facet selection" in "SC3OrcS3CatalogerFileExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqaorcautomation |
      | OrcTestData        |
      | TestOrc            |
      | Incremental        |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | NonOrc |
    And user enters the search text "SC3OrcS3CatalogerFileExclude" and clicks on search
    And user performs "facet selection" in "SC3OrcS3CatalogerFileExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.orc                                     |
      | incremental.orc                                     |
      | UsingOrcJar.orc                                     |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | UsingHive.orc  |
      | employee.orc   |
      | UsingSpark.orc |
    And user clicks on logout button

  Scenario: SC#21: Delete the cataloged items for scenario: Bucketname(Include)/File(Exclude)
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaorcautomation                       | Directory |       |       |

  Scenario Outline: SC#22:Run OrcS3Cataloger with filter: Bucketname(Include)/Directory
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                  | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerDirectory                               | ida/s3OrcPayloads/PluginConfiguration/sc5OrcS3CatalogerDirectory.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                       |                                                                       | 200           | OrcS3CatalogerDirectory |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerDirectory |                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='OrcS3CatalogerDirectory')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerDirectory  | ida/empty.json                                                        | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerDirectory |                                                                       | 200           | IDLE                    | $.[?(@.configurationName=='OrcS3CatalogerDirectory')].status |

  ##7190143##
  @MLP-27617 @webtest
  Scenario: SC#22: Verify OrcS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when OrcS3Cataloger is run with region and Bucketname(Include)/Directory
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC5OrcS3CatalogerDirectory" and clicks on search
    And user performs "facet selection" in "SC5OrcS3CatalogerDirectory" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqaorcautomation |
      | OrcTestData        |
      | TestOrc            |
      | Incremental        |
    And user enters the search text "SC5OrcS3CatalogerDirectory" and clicks on search
    And user performs "facet selection" in "SC5OrcS3CatalogerDirectory" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.orc                                     |
      | incremental.orc                                     |
      | employee.orc                                        |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    And user clicks on logout button

  Scenario: SC#22: Delete the cataloged items for scenario: Bucketname(Include)/Directory
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaorcautomation                       | Directory |       |       |

  Scenario Outline: SC#23:Run OrcS3Cataloger with filter: Bucketname(Include)/Directory/Sub-Dir(Include)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                      | response code | response message            | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerSubDirInclude                               | ida/s3OrcPayloads/PluginConfiguration/sc6OrcS3CatalogerSubDirInclude.json | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                           |                                                                           | 200           | OrcS3CatalogerSubDirInclude |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerSubDirInclude |                                                                           | 200           | IDLE                        | $.[?(@.configurationName=='OrcS3CatalogerSubDirInclude')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerSubDirInclude  | ida/empty.json                                                            | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerSubDirInclude |                                                                           | 200           | IDLE                        | $.[?(@.configurationName=='OrcS3CatalogerSubDirInclude')].status |

  ##7190144##
  @MLP-27617 @webtest
  Scenario: SC#23: Verify OrcS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when OrcS3Cataloger is run with region and Bucketname(Include)/Directory/Sub-Dir(Include)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC6OrcS3CatalogerSubDirInclude" and clicks on search
    And user performs "facet selection" in "SC6OrcS3CatalogerSubDirInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqaorcautomation |
      | OrcTestData        |
      | TestOrc            |
      | version            |
    And user enters the search text "SC6OrcS3CatalogerSubDirInclude" and clicks on search
    And user performs "facet selection" in "SC6OrcS3CatalogerSubDirInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.orc                                     |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    And user clicks on logout button

  Scenario: SC#23: Delete the cataloged items for scenario: Bucketname(Include)/Directory/Sub-Dir(Include)
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaorcautomation                       | Directory |       |       |

  Scenario Outline: SC#24:Run OrcS3Cataloger with filter: Bucketname(Include)/Directory/Sub-Dir(Exclude)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                         | body                                                                      | response code | response message            | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerSubDirExclude                               | ida/s3OrcPayloads/PluginConfiguration/sc7OrcS3CatalogerSubDirExclude.json | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                           |                                                                           | 200           | OrcS3CatalogerSubDirExclude |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerSubDirExclude |                                                                           | 200           | IDLE                        | $.[?(@.configurationName=='OrcS3CatalogerSubDirExclude')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerSubDirExclude  | ida/empty.json                                                            | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerSubDirExclude |                                                                           | 200           | IDLE                        | $.[?(@.configurationName=='OrcS3CatalogerSubDirExclude')].status |

  ##7190145##
  @MLP-27617 @webtest
  Scenario: SC#24: Verify OrcS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when OrcS3Cataloger is run with region and Bucketname(Include)/Directory/Sub-Dir(Exclude)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC7OrcS3CatalogerSubDirExclude" and clicks on search
    And user performs "facet selection" in "SC7OrcS3CatalogerSubDirExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqaorcautomation |
      | OrcTestData        |
      | NonOrc             |
      | Incremental        |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | TestOrc |
    And user enters the search text "SC7OrcS3CatalogerSubDirExclude" and clicks on search
    And user performs "facet selection" in "SC7OrcS3CatalogerSubDirExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | incremental.orc |
      | employee.orc    |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | baseversion.orc                                     |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    And user clicks on logout button

  Scenario: SC#24: Delete the cataloged items for scenario: Bucketname(Include)/Directory/Sub-Dir(Exclude)
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaorcautomation                       | Directory |       |       |

  Scenario Outline: SC#25:Run OrcS3Cataloger with filter: File Include Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | body                                                                         | response code | response message               | jsonPath                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerFileIncludeRegex                               | ida/s3OrcPayloads/PluginConfiguration/sc8OrcS3CatalogerFileIncludeRegex.json | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                              |                                                                              | 200           | OrcS3CatalogerFileIncludeRegex |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerFileIncludeRegex |                                                                              | 200           | IDLE                           | $.[?(@.configurationName=='OrcS3CatalogerFileIncludeRegex')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerFileIncludeRegex  | ida/empty.json                                                               | 200           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerFileIncludeRegex |                                                                              | 200           | IDLE                           | $.[?(@.configurationName=='OrcS3CatalogerFileIncludeRegex')].status |

  ##7190191##
  @MLP-27617 @webtest
  Scenario: SC#25: Verify OrcS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when OrcS3Cataloger is run with region and Bucketname(Include)/File(include) Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC8OrcS3CatalogerFileIncludeRegex" and clicks on search
    And user performs "facet selection" in "SC8OrcS3CatalogerFileIncludeRegex" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqaorcautomation |
      | OrcTestData        |
      | TestOrc            |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | NonOrc      |
      | Incremental |
    And user enters the search text "SC8OrcS3CatalogerFileIncludeRegex" and clicks on search
    And user performs "facet selection" in "SC8OrcS3CatalogerFileIncludeRegex" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | UsingHive.orc   |
      | UsingSpark.orc  |
      | UsingOrcJar.orc |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | baseversion.orc                                     |
      | incremental.orc                                     |
      | employee.orc                                        |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    And user clicks on logout button

  Scenario: SC#25: Delete the cataloged items for scenario: Bucketname(Include)/File(Include) Regex
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaorcautomation                       | Directory |       |       |

  Scenario Outline: SC#26:Run OrcS3Cataloger with filter: Bucketname(Include)/Directory/Sub-Directory(Include)/File(Include) Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                    | body                                                                                 | response code | response message                       | jsonPath                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerSubDirIncludeFileInclude                               | ida/s3OrcPayloads/PluginConfiguration/sc9OrcS3CatalogerSubDirIncludeFileInclude.json | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                                      |                                                                                      | 200           | OrcS3CatalogerSubDirIncludeFileInclude |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerSubDirIncludeFileInclude |                                                                                      | 200           | IDLE                                   | $.[?(@.configurationName=='OrcS3CatalogerSubDirIncludeFileInclude')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerSubDirIncludeFileInclude  | ida/empty.json                                                                       | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerSubDirIncludeFileInclude |                                                                                      | 200           | IDLE                                   | $.[?(@.configurationName=='OrcS3CatalogerSubDirIncludeFileInclude')].status |

  ##7190154##
  @MLP-27617 @webtest
  Scenario: SC#26: Verify OrcS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when OrcS3Cataloger is run with region and Bucketname(Include)/Directory/Sub-Directory(Include)/File(Include) Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC9OrcS3SubDirFileInclude" and clicks on search
    And user performs "facet selection" in "SC9OrcS3SubDirFileInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqaorcautomation |
      | OrcTestData        |
      | TestOrc            |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | NonOrc      |
      | Incremental |
    And user enters the search text "SC9OrcS3SubDirFileInclude" and clicks on search
    And user performs "facet selection" in "SC9OrcS3SubDirFileInclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | baseversion.orc |
      | incremental.orc |
      | employee.orc    |
    And user clicks on logout button

  Scenario: SC#26: Delete the cataloged items for scenario: Bucketname(Include)/Directory/Sub-Directory(Include)/File(Include) Regex
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaorcautomation                       | Directory |       |       |

  Scenario Outline: SC#27:Run OrcS3Cataloger with filter: Bucketname(Include)/Directory/Sub-Directory(Include)/File(Exclude) Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                    | body                                                                                  | response code | response message                       | jsonPath                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerSubDirIncludeFileExclude                               | ida/s3OrcPayloads/PluginConfiguration/sc10OrcS3CatalogerSubDirIncludeFileExclude.json | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                                      |                                                                                       | 200           | OrcS3CatalogerSubDirIncludeFileExclude |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerSubDirIncludeFileExclude |                                                                                       | 200           | IDLE                                   | $.[?(@.configurationName=='OrcS3CatalogerSubDirIncludeFileExclude')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerSubDirIncludeFileExclude  | ida/empty.json                                                                        | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerSubDirIncludeFileExclude |                                                                                       | 200           | IDLE                                   | $.[?(@.configurationName=='OrcS3CatalogerSubDirIncludeFileExclude')].status |

  ##7190194##
  @MLP-27617 @webtest
  Scenario: SC#27: Verify OrcS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when OrcS3Cataloger is run with region and Bucketname(Include)/Directory/Sub-Directory(Include)/File(Exclude) Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC10OrcS3SubDirFileExclude" and clicks on search
    And user performs "facet selection" in "SC10OrcS3SubDirFileExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqaorcautomation |
      | OrcTestData        |
      | TestOrc            |
      | version            |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | NonOrc      |
      | Incremental |
    And user enters the search text "SC10OrcS3SubDirFileExclude" and clicks on search
    And user performs "facet selection" in "SC10OrcS3SubDirFileExclude" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.orc |
    Then user "verify non presence" of following "Items List" in Item Search Results Page
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | incremental.orc                                     |
      | employee.orc                                        |
    And user clicks on logout button

  Scenario: SC#27: Delete the cataloged items for scenario: Bucketname(Include)/Directory/Sub-Directory(Include)/File(Exclude) Regex
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaorcautomation                       | Directory |       |       |

  Scenario Outline: SC#28:Run OrcS3Cataloger with filter: Bucketname(Include) Regex
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | body                                                                            | response code | response message                 | jsonPath                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerBucketIncludeRegex                               | ida/s3OrcPayloads/PluginConfiguration/sc11OrcS3CatalogerBucketIncludeRegex.json | 204           |                                  |                                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                                |                                                                                 | 200           | OrcS3CatalogerBucketIncludeRegex |                                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerBucketIncludeRegex |                                                                                 | 200           | IDLE                             | $.[?(@.configurationName=='OrcS3CatalogerBucketIncludeRegex')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerBucketIncludeRegex  | ida/empty.json                                                                  | 200           |                                  |                                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerBucketIncludeRegex |                                                                                 | 200           | IDLE                             | $.[?(@.configurationName=='OrcS3CatalogerBucketIncludeRegex')].status |

  ##7190149##
  @MLP-27617 @webtest
  Scenario: SC#28: Verify OrcS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when OrcS3Cataloger is run with region and Bucketname(Include) Regex
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC11OrcS3CatalogerBucketIncludeRegex" and clicks on search
    And user performs "facet selection" in "SC11OrcS3CatalogerBucketIncludeRegex" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "OrcTestData [Directory]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | OrcTestData |
      | TestOrc     |
      | version     |
      | NonOrc      |
      | Incremental |
    And user enters the search text "SC11OrcS3CatalogerBucketIncludeRegex" and clicks on search
    And user performs "facet selection" in "SC11OrcS3CatalogerBucketIncludeRegex" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | baseversion.orc                                     |
      | incremental.orc                                     |
      | employee.orc                                        |
      | UsingHive.orc                                       |
      | UsingSpark.orc                                      |
      | UsingOrcJar.orc                                     |
      | tagdetails_allmatch_orc.orc                         |
      | tagdetails_allempty_orc.orc                         |
      | tagdetails_ratiolessthan05emptyfalse_orc.orc        |
      | tagdetails_ratiogreaterthan05emptyfalsetrue_orc.orc |
      | tagdetails_ratioequalto05emptyfalse_orc.orc         |
      | tagdetails_ratiogreaterthan05matchfulltrue_orc.orc  |
      | tagdetails_ratiolesserthan05matchfulltrue_orc.orc   |
    And user clicks on logout button

  Scenario: SC#28: Delete the cataloged items for scenario: Bucketname(Include) Regex
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaorcautomation                       | Directory |       |       |

  Scenario Outline: SC#29:Run OrcS3Cataloger with filter: NonExistingBucket
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                             | body                                                                           | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerNonExistingBucket                               | ida/s3OrcPayloads/PluginConfiguration/sc12OrcS3CatalogerNonExistingBucket.json | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                               |                                                                                | 200           | OrcS3CatalogerNonExistingBucket |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingBucket |                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OrcS3CatalogerNonExistingBucket')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingBucket  | ida/empty.json                                                                 | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingBucket |                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OrcS3CatalogerNonExistingBucket')].status |

  ##7190178##
  @MLP-27617 @webtest
  Scenario: SC#29: Verify OrcS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when OrcS3Cataloger is run with region and NonExistingBucket
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC12OrcS3CatalogerNonExistingBucket" and clicks on search
    And user performs "facet selection" in "SC12OrcS3CatalogerNonExistingBucket" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service   |
      | Directory |
      | File      |
      | Field     |
      | Cluster   |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingBucket%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingBucket%" should display below info/error/warning
      | type | logValue                        | logCode | pluginName | removableText |
      | INFO | No S3 data available to catalog |         |            |               |
    And user clicks on logout button

  Scenario Outline: SC#30:Run OrcS3Cataloger with filter: NonExistingDirectory
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                | body                                                                              | response code | response message                   | jsonPath                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerNonExistingDirectory                               | ida/s3OrcPayloads/PluginConfiguration/sc13OrcS3CatalogerNonExistingDirectory.json | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                                  |                                                                                   | 200           | OrcS3CatalogerNonExistingDirectory |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingDirectory |                                                                                   | 200           | IDLE                               | $.[?(@.configurationName=='OrcS3CatalogerNonExistingDirectory')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingDirectory  | ida/empty.json                                                                    | 200           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingDirectory |                                                                                   | 200           | IDLE                               | $.[?(@.configurationName=='OrcS3CatalogerNonExistingDirectory')].status |

  ##7190179##
  @MLP-27617 @webtest
  Scenario: SC#30: Verify OrcS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when OrcS3Cataloger is run with region and NonExistingDirectory
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC13OrcS3CatalogerNonExistingDirectory" and clicks on search
    And user performs "facet selection" in "SC13OrcS3CatalogerNonExistingDirectory" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service   |
      | Directory |
      | File      |
      | Field     |
      | Cluster   |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingDirectory%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingDirectory%" should display below info/error/warning
      | type | logValue                        | logCode | pluginName | removableText |
      | INFO | No S3 data available to catalog |         |            |               |
    And user clicks on logout button

  Scenario Outline: SC#31:Run OrcS3Cataloger with filter: NonExistingSubDirectory
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                             | body                                                                           | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerNonExistingSubDir                               | ida/s3OrcPayloads/PluginConfiguration/sc14OrcS3CatalogerNonExistingSubDir.json | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                               |                                                                                | 200           | OrcS3CatalogerNonExistingSubDir |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingSubDir |                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OrcS3CatalogerNonExistingSubDir')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingSubDir  | ida/empty.json                                                                 | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingSubDir |                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OrcS3CatalogerNonExistingSubDir')].status |

  ##7190180##
  @MLP-27617 @webtest
  Scenario: SC#31: Verify OrcS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when OrcS3Cataloger is run with region and NonExistingSubDirectory
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC14OrcS3CatalogerNonExistingSubDir" and clicks on search
    And user performs "facet selection" in "SC14OrcS3CatalogerNonExistingSubDir" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service   |
      | Directory |
      | File      |
      | Field     |
      | Cluster   |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingSubDir%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingSubDir%" should display below info/error/warning
      | type | logValue                        | logCode | pluginName | removableText |
      | INFO | No S3 data available to catalog |         |            |               |
    And user clicks on logout button

  Scenario Outline: SC#32:Run OrcS3Cataloger with filter: NonExistingFile
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                           | body                                                                         | response code | response message              | jsonPath                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerNonExistingFile                               | ida/s3OrcPayloads/PluginConfiguration/sc15OrcS3CatalogerNonExistingFile.json | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                             |                                                                              | 200           | OrcS3CatalogerNonExistingFile |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingFile |                                                                              | 200           | IDLE                          | $.[?(@.configurationName=='OrcS3CatalogerNonExistingFile')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingFile  | ida/empty.json                                                               | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingFile |                                                                              | 200           | IDLE                          | $.[?(@.configurationName=='OrcS3CatalogerNonExistingFile')].status |

  ##7190181##
  @MLP-27617 @webtest
  Scenario: SC#32: Verify OrcS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when OrcS3Cataloger is run with region and NonExistingFile
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC15OrcS3CatalogerNonExistingFile" and clicks on search
    And user performs "facet selection" in "SC15OrcS3CatalogerNonExistingFile" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Service   |
      | Directory |
      | File      |
      | Field     |
      | Cluster   |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingFile%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "cataloger/OrcS3Cataloger/OrcS3CatalogerNonExistingFile%" should display below info/error/warning
      | type | logValue                        | logCode | pluginName | removableText |
      | INFO | No S3 data available to catalog |         |            |               |
    And user clicks on logout button

  Scenario: SC#32: Delete the cataloged items for scenario: NonExistingBucket
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type     | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis |       |       |

  Scenario Outline: SC#33:Run OrcS3Cataloger with specific node condition
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                            | body                                                                            | response code | response message            | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3DataSource                                                             | ida/s3OrcPayloads/DataSource/AmazonOrcS3ValidDataSourceConfigNodeCondition.json | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3DataSource                                                             |                                                                                 | 200           | OrcS3DataSourceInternal     |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerNodeCondition                                  | ida/s3OrcPayloads/PluginConfiguration/sc16OrcS3CatalogerNodeCondition.json      | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                              |                                                                                 | 200           | OrcS3CatalogerNodeCondition |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/InternalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNodeCondition |                                                                                 | 200           | IDLE                        | $.[?(@.configurationName=='OrcS3CatalogerNodeCondition')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | /extensions/analyzers/start/InternalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNodeCondition  | ida/empty.json                                                                  | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | /extensions/analyzers/status/InternalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNodeCondition |                                                                                 | 200           | IDLE                        | $.[?(@.configurationName=='OrcS3CatalogerNodeCondition')].status |

  ##7190165##
  @MLP-27617 @sanity @positive @webtest
  Scenario: SC#33-Verify the facet counts are exact once the Orc S3 items are cataloged in internal node.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC16OrcS3CatalogerNodeCondition" and clicks on search
    And user performs "facet selection" in "SC16OrcS3CatalogerNodeCondition" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Service   | 1     |
      | Cluster   | 1     |
      | Analysis  | 1     |
      | Directory | 6     |
      | File      | 13    |
      | Field     | 86    |
    And user clicks on logout button

  Scenario: SC#33: Delete the cataloged items for scenario: specific node condition
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaorcautomation                       | Directory |       |       |

  @aws
  Scenario:SC#34:Delete the asgqaorcautomation bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "OrcTestData" in bucket "asgqaorcautomation"
    Then user "Delete" a bucket "asgqaorcautomation" in amazon storage service


  Scenario: SC#35: Create a bucket and folder with orc files in S3 Amazon storage & Run OrcS3Cataloger with incremental scan settings as false
    Given user "Create" a bucket "asgqaorcautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName         | keyPrefix       | dirPath                             | recursive |
      | asgqaorcautomation | OrcData/TestOrc | ida/S3OrcPayloads/TestData/TestOrc/ | true      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                                   | response code | response message          | jsonPath                                                       |
      | application/json | raw   | false | Put          | settings/analyzers/OrcS3DataSource                                                        | ida/s3OrcPayloads/DataSource/AmazonOrcS3ValidDataSourceConfig.json     | 204           |                           |                                                                |
      |                  |       |       | Get          | settings/analyzers/OrcS3DataSource                                                        |                                                                        | 200           | OrcS3DataSource           |                                                                |
      |                  |       |       | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerIncremental                               | ida/s3OrcPayloads/PluginConfiguration/sc17OrcS3CatalogerIncrFalse.json | 204           |                           |                                                                |
      |                  |       |       | Get          | settings/analyzers/OrcS3Cataloger                                                         |                                                                        | 200           | OrcS3CatalogerIncremental |                                                                |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerIncremental |                                                                        | 200           | IDLE                      | $.[?(@.configurationName=='OrcS3CatalogerIncremental')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerIncremental  | ida/empty.json                                                         | 200           |                           |                                                                |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerIncremental |                                                                        | 200           | IDLE                      | $.[?(@.configurationName=='OrcS3CatalogerIncremental')].status |

  @MLP-27617 @webtest
  Scenario: SC#35- Verify incremental scan with settings:false works properly with OrcS3Cataloger
    Given user gets amazon bucket "asgqaorcautomation" file count in "OrcData" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC17OrcS3CatalogerIncremental" and clicks on search
    And user performs "facet selection" in "SC17OrcS3CatalogerIncremental" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | incremental.orc |
    And user clicks on logout button

  Scenario: SC#35: Add a folder with orc files in S3 Amazon storage & Run OrcS3Cataloger with incremental scan settings as true
    Given user performs "multiple upload" in amazon storage service with below parameters
      | bucketName         | keyPrefix           | dirPath                                 | recursive |
      | asgqaorcautomation | OrcData/Incremental | ida/S3OrcPayloads/TestData/Incremental/ | false     |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                       | body                                                                  | response code | response message          | jsonPath                                                       |
      | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerIncremental                               | ida/s3OrcPayloads/PluginConfiguration/sc17OrcS3CatalogerIncrTrue.json | 204           |                           |                                                                |
      |                  |       |       | Get          | settings/analyzers/OrcS3Cataloger                                                         |                                                                       | 200           | OrcS3CatalogerIncremental |                                                                |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerIncremental |                                                                       | 200           | IDLE                      | $.[?(@.configurationName=='OrcS3CatalogerIncremental')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerIncremental  | ida/empty.json                                                        | 200           |                           |                                                                |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerIncremental |                                                                       | 200           | IDLE                      | $.[?(@.configurationName=='OrcS3CatalogerIncremental')].status |

  ##7190159##
  @MLP-27617 @webtest
  Scenario: SC#35- Verify incremental scan with settings:true works properly with OrcS3Cataloger
    Given user gets amazon bucket "asgqaorcautomation" file count in "OrcData" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC17OrcS3CatalogerIncremental" and clicks on search
    And user performs "facet selection" in "SC17OrcS3CatalogerIncremental" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page
    Then user "verify presence" of following "Items List" in Search Results Page
      | incremental.orc |
    And user clicks on logout button

  Scenario: SC#35: Delete the cataloged items for scenario: incremental scan
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaorcautomation                       | Directory |       |       |

  @aws
  Scenario:SC#35:Delete the asgqaorcautomation bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "OrcData" in bucket "asgqaorcautomation"
    Then user "Delete" a bucket "asgqaorcautomation" in amazon storage service

  Scenario: SC#36: Create a bucket and folder with orc files in S3 Amazon storage & Run OrcS3Cataloger with version mode settings as true
    Given user "Create" a bucket "asgqaorcautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName         | keyPrefix   | dirPath                     | recursive |
      | asgqaorcautomation | OrcTestData | ida/S3OrcPayloads/TestData/ | true      |
    And user performs "version option enable" in amazon storage service with below parameters
      | bucketName         | status  |
      | asgqaorcautomation | Enabled |
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName         | keyPrefix                   | dirPath                                     | recursive |
      | asgqaorcautomation | OrcTestData/TestOrc/version | ida/S3OrcPayloads/TestData/TestOrc/version/ | true      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                              | body                                                                          | response code | response message                 | jsonPath                                                              |
      | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerVersionIncremental                               | ida/s3OrcPayloads/PluginConfiguration/sc18OrcS3CatalogerVersionIncrFalse.json | 204           |                                  |                                                                       |
      |                  |       |       | Get          | settings/analyzers/OrcS3Cataloger                                                                |                                                                               | 200           | OrcS3CatalogerVersionIncremental |                                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerVersionIncremental |                                                                               | 200           | IDLE                             | $.[?(@.configurationName=='OrcS3CatalogerVersionIncremental')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerVersionIncremental  | ida/empty.json                                                                | 200           |                                  |                                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerVersionIncremental |                                                                               | 200           | IDLE                             | $.[?(@.configurationName=='OrcS3CatalogerVersionIncremental')].status |

  ##7190161##
  @MLP-27617 @webtest
  Scenario: SC#36: Verify file versions are collected correctly when scan mode is set as versions in OrcS3Cataloger
    Given user gets amazon bucket "asgqaorcautomation" file count in "OrcTestData" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC18OrcS3CatalogerVersionIncremental" and clicks on search
    And user performs "facet selection" in "SC18OrcS3CatalogerVersionIncremental" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "OrcTestData/TestOrc/version/" in bucket "asgqaorcautomation" with maximum count of "50"
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 2     |
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page

  Scenario: SC#36: Add orc files in S3 Amazon storage & Run OrcS3Cataloger with version mode settings as true and incremental is true
    Given user performs "multiple upload" in amazon storage service with below parameters
      | bucketName         | keyPrefix                   | dirPath                                     | recursive |
      | asgqaorcautomation | OrcTestData/TestOrc/version | ida/S3OrcPayloads/TestData/TestOrc/version/ | true      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                              | body                                                                         | response code | response message                 | jsonPath                                                              |
      | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerVersionIncremental                               | ida/s3OrcPayloads/PluginConfiguration/sc18OrcS3CatalogerVersionIncrTrue.json | 204           |                                  |                                                                       |
      |                  |       |       | Get          | settings/analyzers/OrcS3Cataloger                                                                |                                                                              | 200           | OrcS3CatalogerVersionIncremental |                                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerVersionIncremental |                                                                              | 200           | IDLE                             | $.[?(@.configurationName=='OrcS3CatalogerVersionIncremental')].status |
      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerVersionIncremental  | ida/empty.json                                                               | 200           |                                  |                                                                       |
      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerVersionIncremental |                                                                              | 200           | IDLE                             | $.[?(@.configurationName=='OrcS3CatalogerVersionIncremental')].status |

  ##7190163##
  @MLP-27617 @webtest
  Scenario: SC#36: Verify file versions are collected correctly when scan mode is set as versions and incremental scan is true in OrcS3Cataloger
    Given user gets amazon bucket "asgqaorcautomation" file count in "OrcTestData" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC18OrcS3CatalogerVersionIncremental" and clicks on search
    And user performs "facet selection" in "SC18OrcS3CatalogerVersionIncremental" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "OrcTestData/TestOrc/version/" in bucket "asgqaorcautomation" with maximum count of "50"
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | File      | 3     |
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page

  @aws
  Scenario:SC#36:Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "OrcTestData" in bucket "asgqaorcautomation"
    Then user "Delete" a bucket "asgqaorcautomation" in amazon storage service

  Scenario: SC#36: Delete the cataloged items for scenario: version mode
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type      | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaorcautomation                       | Directory |       |       |

  @aws
  Scenario: SC#37: Create a bucket and folder with orc files in S3 Amazon storage
    Given user "Create" a bucket "asgqaorcautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName         | keyPrefix   | dirPath                     | recursive |
      | asgqaorcautomation | OrcTestData | ida/s3OrcPayloads/TestData/ | true      |

  Scenario Outline: SC#37: Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | body                                                             | response code | response message   | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                                               | ida/s3OrcPayloads/DataSource/AmazonS3DataSourceConfig.json       | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                                               |                                                                  | 200           | AmazonS3DataSource |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger/AmazonS3Cataloger                              | ida/s3OrcPayloads/PluginConfiguration/sc19AmazonS3Cataloger.json | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                                |                                                                  | 200           | AmazonS3Cataloger  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger |                                                                  | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger  | ida/empty.json                                                   | 200           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/AmazonS3Cataloger |                                                                  | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Cataloger')].status |


  Scenario Outline: SC#37: Run the Plugin configurations for DataSource and OrcS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                      | response code | response message           | jsonPath                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3DataSource                                                        | ida/s3OrcPayloads/DataSource/AmazonOrcS3ValidDataSourceConfig.json        | 204           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3DataSource                                                        |                                                                           | 200           | OrcS3DataSource            |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerWithAmazonS3                              | ida/s3OrcPayloads/PluginConfiguration/sc19OrcS3CatalogerWithAmazonS3.json | 204           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                         |                                                                           | 200           | OrcS3CatalogerWithAmazonS3 |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerWithAmazonS3 |                                                                           | 200           | IDLE                       | $.[?(@.configurationName=='OrcS3CatalogerWithAmazonS3')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerWithAmazonS3  | ida/empty.json                                                            | 200           |                            |                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerWithAmazonS3 |                                                                           | 200           | IDLE                       | $.[?(@.configurationName=='OrcS3CatalogerWithAmazonS3')].status |

  ##7190182##
  @MLP-27617 @webtest @MLPQA-18063 @MLPQA-18064
  Scenario: SC#37: Verify OrcS3Cataloger runs above the cataloged items from S3 Cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC19OrcS3CatalogerWithAmazonS3" and clicks on search
    And user performs "facet selection" in "SC19OrcS3CatalogerWithAmazonS3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ORC,SC19OrcS3CatalogerWithAmazonS3,Test_BA_OrcS3" should get displayed for the column "cataloger/OrcS3Cataloger/OrcS3CatalogerWithAmazonS3%"
    And user enters the search text "SC19AmazonS3Cataloger" and clicks on search
    And user performs "facet selection" in "SC19AmazonS3Cataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Amazon S3,SC19AmazonS3Cataloger,Test_BA_OrcS3" should get displayed for the column "cataloger/AmazonS3Cataloger/AmazonS3Cataloger"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                                                              | fileName      | userTag                        |
      | Default     | Field     | Metadata Type | ORC,SC19OrcS3CatalogerWithAmazonS3,Test_BA_OrcS3,Amazon S3                       | age           | SC19OrcS3CatalogerWithAmazonS3 |
      | Default     | File      | Metadata Type | Amazon S3,SC19AmazonS3Cataloger,ORC,SC19OrcS3CatalogerWithAmazonS3,Test_BA_OrcS3 | UsingHive.orc | SC19OrcS3CatalogerWithAmazonS3 |
      | Default     | Directory | Metadata Type | Amazon S3,SC19AmazonS3Cataloger,ORC,SC19OrcS3CatalogerWithAmazonS3,Test_BA_OrcS3 | OrcTestData   | SC19OrcS3CatalogerWithAmazonS3 |
      | Default     | Cluster   | Metadata Type | Amazon S3,SC19AmazonS3Cataloger,ORC,SC19OrcS3CatalogerWithAmazonS3,Test_BA_OrcS3 | amazonaws.com | SC19OrcS3CatalogerWithAmazonS3 |
      | Default     | Service   | Metadata Type | Amazon S3,SC19AmazonS3Cataloger,ORC,SC19OrcS3CatalogerWithAmazonS3,Test_BA_OrcS3 | AmazonS3      | SC19OrcS3CatalogerWithAmazonS3 |
    And user clicks on logout button

  Scenario: SC#37: Delete the cataloged items for scenario: specific node condition
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type      | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger%       | Analysis  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | asgqaorcautomation                             | Directory |       |       |


  Scenario Outline: SC#38: Run the Plugin configurations for DataSource and OrcS3Cataloger for scenario: Empty Datasource & Empty Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                           | body                                                                                  | response code | response message               | jsonPath                                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3DataSource                                                            | ida/s3OrcPayloads/DataSource/AmazonOrcS3EmptyCredDataSourceConfig.json                | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3DataSource                                                            |                                                                                       | 200           | OrcS3DataSourceEmptyCred       |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerEmptyDSEmptyCred                              | ida/s3OrcPayloads/PluginConfiguration/sc20OrcS3CatalogerEmptyDataSourceEmptyCred.json | 204           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                             |                                                                                       | 200           | OrcS3CatalogerEmptyDSEmptyCred |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerEmptyDSEmptyCred |                                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='OrcS3CatalogerEmptyDSEmptyCred')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerEmptyDSEmptyCred  | ida/empty.json                                                                        | 200           |                                |                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerEmptyDSEmptyCred |                                                                                       | 200           | IDLE                           | $.[?(@.configurationName=='OrcS3CatalogerEmptyDSEmptyCred')].status |

  ##7190174##
  @webtest @MLP-27617
  Scenario: SC#38: Verify OrcS3Cataloger collects Analysis item with proper log messages for Empty Datasource & Empty Credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC20OrcS3CatalogerEmptyDSEmptyCred" and clicks on search
    And user performs "facet selection" in "SC20OrcS3CatalogerEmptyDSEmptyCred" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OrcS3Cataloger/OrcS3CatalogerEmptyDSEmptyCred%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
      | Number of halt errors     | 1             | Description |
    Then Analysis log "cataloger/OrcS3Cataloger/OrcS3CatalogerEmptyDSEmptyCred%" should display below info/error/warning
      | type  | logValue                                                                                    | logCode | pluginName | removableText |
      | ERROR | Orc S3 Cataloger failed with exception: AWS_S3-0010: Required attribute Secret key is blank |         |            |               |
    And user clicks on logout button

  Scenario Outline: SC#40: Run the Plugin configurations for DataSource and OrcS3Cataloger for scenario: Invalid Datasource & Invalid Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | body                                                                                      | response code | response message                   | jsonPath                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3DataSource                                                                | ida/s3OrcPayloads/DataSource/AmazonOrcS3InValidCredDataSourceConfig.json                  | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3DataSource                                                                |                                                                                           | 200           | OrcS3DataSourceInValidCred         |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerInvalidDSInvalidCred                              | ida/s3OrcPayloads/PluginConfiguration/sc22OrcS3CatalogerInvalidDataSourceInvalidCred.json | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                                 |                                                                                           | 200           | OrcS3CatalogerInvalidDSInvalidCred |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerInvalidDSInvalidCred |                                                                                           | 200           | IDLE                               | $.[?(@.configurationName=='OrcS3CatalogerInvalidDSInvalidCred')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerInvalidDSInvalidCred  | ida/empty.json                                                                            | 200           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerInvalidDSInvalidCred |                                                                                           | 200           | IDLE                               | $.[?(@.configurationName=='OrcS3CatalogerInvalidDSInvalidCred')].status |

  ##7190173##
  @webtest @MLP-27617
  Scenario: SC#40: Verify OrcS3Cataloger collects Analysis item with proper log messages for Invalid Datasource & Invalid Credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC22OrcS3CatalogerInvalidDSInvalidCred" and clicks on search
    And user performs "facet selection" in "SC22OrcS3CatalogerInvalidDSInvalidCred" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OrcS3Cataloger/OrcS3CatalogerInvalidDSInvalidCred%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 3             | Description |
    Then Analysis log "cataloger/OrcS3Cataloger/OrcS3CatalogerInvalidDSInvalidCred%" should display below info/error/warning
      | type  | logValue                                                               | logCode     | pluginName | removableText |
      | ERROR | Amazon S3 connection failed: AWS_S3-0006: Error retrieving bucket list | AWS_S3-0011 |            |               |
    And user clicks on logout button

  Scenario Outline: SC#42: Run the Plugin configurations for DataSource and OrcS3Cataloger for scenario: Valid Datasource & Null Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                          | body                                                                                 | response code | response message              | jsonPath                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3DataSource                                                           | ida/s3OrcPayloads/DataSource/AmazonOrcS3ValidDataSourceConfig.json                   | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3DataSource                                                           |                                                                                      | 200           | OrcS3DataSource               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerValidDSNullCred                              | ida/s3OrcPayloads/PluginConfiguration/sc24OrcS3CatalogerValidDataSourceNullCred.json | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                            |                                                                                      | 200           | OrcS3CatalogerValidDSNullCred |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerValidDSNullCred |                                                                                      | 200           | IDLE                          | $.[?(@.configurationName=='OrcS3CatalogerValidDSNullCred')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerValidDSNullCred  | ida/empty.json                                                                       | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerValidDSNullCred |                                                                                      | 200           | IDLE                          | $.[?(@.configurationName=='OrcS3CatalogerValidDSNullCred')].status |

  ##7190177##
  @webtest @MLP-27617
  Scenario: SC#42: Verify OrcS3Cataloger collects Analysis item with proper log messages for Valid Datasource & Null Credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC24OrcS3CatalogerValidDSNullCred" and clicks on search
    And user performs "facet selection" in "SC24OrcS3CatalogerValidDSNullCred" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OrcS3Cataloger/OrcS3CatalogerValidDSNullCred%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
      | Number of halt errors     | 1             | Description |
    Then Analysis log "cataloger/OrcS3Cataloger/OrcS3CatalogerValidDSNullCred%" should display below info/error/warning
      | type  | logValue                                                                                    | logCode          | pluginName | removableText |
      | ERROR | Orc S3 Cataloger failed with exception: AWS_S3-0010: Required attribute Credential is blank | AWS_S3_ORC-00003 |            |               |
    And user clicks on logout button

  Scenario Outline: SC#43: Run the Plugin configurations for DataSource and OrcS3Cataloger for scenario: Null Datasource & Valid Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                          | body                                                                                 | response code | response message              | jsonPath                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerNullDSValidCred                              | ida/s3OrcPayloads/PluginConfiguration/sc25OrcS3CatalogerNullDataSourceValidCred.json | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                            |                                                                                      | 200           | OrcS3CatalogerNullDSValidCred |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNullDSValidCred |                                                                                      | 200           | IDLE                          | $.[?(@.configurationName=='OrcS3CatalogerNullDSValidCred')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNullDSValidCred  | ida/empty.json                                                                       | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNullDSValidCred |                                                                                      | 200           | IDLE                          | $.[?(@.configurationName=='OrcS3CatalogerNullDSValidCred')].status |

  ##7190176##
  @webtest @MLP-27617
  Scenario: SC#43: Verify OrcS3Cataloger collects Analysis item with proper log messages for Null Datasource & Valid Credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC25OrcS3CatalogerNullDSValidCred" and clicks on search
    And user performs "facet selection" in "SC25OrcS3CatalogerNullDSValidCred" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OrcS3Cataloger/OrcS3CatalogerNullDSValidCred%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
      | Number of halt errors     | 1             | Description |
    Then Analysis log "cataloger/OrcS3Cataloger/OrcS3CatalogerNullDSValidCred%" should display below info/error/warning
      | type  | logValue                                                                                     | logCode          | pluginName | removableText |
      | ERROR | Orc S3 Cataloger failed with exception: AWS_S3-0010: Required attribute Data Source is blank | AWS_S3_ORC-00003 |            |               |
    And user clicks on logout button

  Scenario Outline: SC#44: Run the Plugin configurations for DataSource and OrcS3Cataloger for scenario: Null Region
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                     | body                                                                             | response code | response message          | jsonPath                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3DataSource                                                      | ida/s3OrcPayloads/DataSource/AmazonOrcS3ValidDataSourceConfigWithNullRegion.json | 204           |                           |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3DataSource                                                      |                                                                                  | 200           | OrcS3DataSourceNullRegion |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger/OrcS3CatalogerNullRegion                              | ida/s3OrcPayloads/PluginConfiguration/sc26OrcS3CatalogerNullRegion.json          | 204           |                           |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                                       |                                                                                  | 200           | OrcS3CatalogerNullRegion  |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNullRegion |                                                                                  | 200           | IDLE                      | $.[?(@.configurationName=='OrcS3CatalogerNullRegion')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNullRegion  | ida/empty.json                                                                   | 200           |                           |                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3CatalogerNullRegion |                                                                                  | 200           | IDLE                      | $.[?(@.configurationName=='OrcS3CatalogerNullRegion')].status |

  ##7190175##
  @webtest @MLP-27617
  Scenario: SC#44: Verify OrcS3Cataloger collects Analysis item with proper log messages for Null Region
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC26OrcS3CatalogerNullRegion" and clicks on search
    And user performs "facet selection" in "SC26OrcS3CatalogerNullRegion" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/OrcS3Cataloger/OrcS3CatalogerNullRegion%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
      | Number of halt errors     | 1             | Description |
    Then Analysis log "cataloger/OrcS3Cataloger/OrcS3CatalogerNullRegion%" should display below info/error/warning
      | type  | logValue                                                                                | logCode          | pluginName | removableText |
      | ERROR | Orc S3 Cataloger failed with exception: AWS_S3-0010: Required attribute Region is blank | AWS_S3_ORC-00003 |            |               |
    And user clicks on logout button

  Scenario: SC#44: Delete the cataloged items for scenario: negative cases
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                     | type                | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/OrcS3Cataloger% | Analysis            |       |       |
      | SingleItemDelete | Default | Test_BA_OrcS3                            | BusinessApplication |       |       |

  @aws
  Scenario:SC#45:Delete the asgqaorcautomation bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "OrcTestData" in bucket "asgqaorcautomation"
    Then user "Delete" a bucket "asgqaorcautomation" in amazon storage service


  @cr-data @sanity @positive
  Scenario Outline: SC#46:Delete Credentials, Datasource and cataloger config for Orc S3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                            | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidOrcS3Credentials     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/IncorrectOrcS3Credentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptyOrcS3Credentials     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OrcS3DataSource             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OrcS3Cataloger              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3DataSource          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AmazonS3Cataloger           |      | 204           |                  |          |

