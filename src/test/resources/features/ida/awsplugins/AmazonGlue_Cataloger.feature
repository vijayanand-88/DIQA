@MLP-14320
Feature: MLP-14320 Cataloger Support for Amazon Glue

  ########################################## Pre-Conditions ##########################################
  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario: SC1#MLP_14320:Create new Database in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                            |
      | createDatabase | ida/amazonGluePayloads/TestData/createDatabase.json |
    And user connects to AWS Glue database and perform the following operation
      | action         | jsonPath                                             |
      | createDatabase | ida/amazonGluePayloads/TestData/createDatabase1.json |

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario: SC1#MLP_14320:Create new table in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                         |
      | createTable | ida/amazonGluePayloads/TestData/createTable.json |
    And user connects to AWS Glue database and perform the following operation
      | action      | jsonPath                                          |
      | createTable | ida/amazonGluePayloads/TestData/createTable1.json |

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario: SC1#MLP_14320:Create new partitioned table in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action                   | jsonPath                                          |
      | createTableWithPartition | ida/amazonGluePayloads/TestData/createTable2.json |
    And user connects to AWS Glue database and perform the following operation
      | action          | jsonPath                                             |
      | createPartition | ida/amazonGluePayloads/TestData/createPartition.json |

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario: SC1#MLP_14320:Create new Job in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                           |
      | createJob | ida/amazonGluePayloads/TestData/createTestJob.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                        |
      | createJob | ida/amazonGluePayloads/TestData/createJob2.json |

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario: SC1#MLP_14320:Create new UDF in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                        |
      | createUDF | ida/amazonGluePayloads/TestData/createUDF1.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                        |
      | createUDF | ida/amazonGluePayloads/TestData/createUDF2.json |

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario: SC1#MLP_14320:Create new Connection in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action           | jsonPath                                              |
      | createConnection | ida/amazonGluePayloads/TestData/createConnection.json |
    And user connects to AWS Glue database and perform the following operation
      | action           | jsonPath                                               |
      | createConnection | ida/amazonGluePayloads/TestData/createConnection1.json |
    And user connects to AWS Glue database and perform the following operation
      | action           | jsonPath                                               |
      | createConnection | ida/amazonGluePayloads/TestData/createConnection2.json |

  @aws @precondition
  Scenario: SC1#Update AWS secret key and access from config file
    Given User update the below "Glue Readonly credentials" in following files using json path
      | filePath                                                        | accessKeyPath | secretKeyPath |
      | ida/amazonGluePayloads/Credentials/awsGlueValidCredentials.json | $..accessKey  | $..secretKey  |

  @cr-data @sanity @positive
  Scenario Outline: SC1#-Set the Credentials for AWSGlueDatasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                         | body                                                                              | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/license                                            | ida\hbasePayloads\DataSource\license_DS.json                                      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidGlueCredentials                   | ida/amazonGluePayloads/Credentials/awsGlueValidCredentials.json                   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/InvalidGlueCredentials                 | ida/amazonGluePayloads/Credentials/awsGlueInValidCredentials.json                 | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EmptyGlueCredentials                   | ida/amazonGluePayloads/Credentials/awsGlueEmptyCredentials.json                   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/InvalidGlueCredentialsInvalidSecretKey | ida/amazonGluePayloads/Credentials/awsGlueInvalidCredentialsInvalidSecretkey.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidGlueCredentials                   |                                                                                   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/InvalidGlueCredentials                 |                                                                                   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EmptyGlueCredentials                   |                                                                                   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/InvalidGlueCredentialsInvalidSecretKey |                                                                                   | 200           |                  |          |

  @sanity @positive @regression
  Scenario Outline: SC1#Create BusinessApplication tag and run the plugin configuration with the new field for AWS Glue
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                                | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/amazonGluePayloads/PluginConfiguration/BusinessApplication.json | 200           |                  |          |

  ########################################## UI Validations ##########################################
  @MLP-14320 @webtest @positive @regression @IDA-10.3
  Scenario:SC#2_Verify whether the background of the panel is displayed in green when connection is successful in Step1 pop up when user logs in for the first time in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute         |
      | Data Source Type | AWSGlueDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute             |
      | Name      | AmazonGlue_DataSource |
      | Label     | AmazonGlue_DataSource |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | ValidGlueCredentials              |
      | Node       | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "click" on "Save" button in "Add Data Sources Page"

  @MLP-14320 @webtest @positive @regression @IDA-10.3
  Scenario:SC#3_Verify whether the background of the panel is displayed in red when datasource connection is not successful in Step1 pop up when user logs in for the first time in Local Node
  Verify captions and tool tip text in AWSGlueDataSource

    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute         |
      | Data Source Type | AWSGlueDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Data Source Type* |
      | Name*             |
      | Label             |
      | Region*           |
      | Credential*       |
      | Node              |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute              |
      | Name      | AmazonGlue_DataSource1 |
      | Label     | AmazonGlue_DataSource1 |
    And user verifies "Save Button" is "disabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | InvalidGlueCredentials            |
      | Node       | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute            |
      | Credential | EmptyGlueCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"


  @MLP-14320 @webtest @positive @regression @IDA-10.3
  Scenario:SC#4_Verify whether the background of the panel is displayed in green when connection is successful in AWSGlueCataloger when valid credential is used in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute             |
      | Type        | Cataloger             |
      | Plugin      | AWSGlueCataloger      |
      | Data Source | AmazonGlue_DataSource |
      | Credential  | ValidGlueCredentials  |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Name      | AWSGlueCataloger |
      | Label     | AWSGlueCataloger |
    And user "click" on "Test Connection" button in "Add Manage Configuration Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Manage Configuration Sources Page"
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"
    And user "click" on "Save" button in "Add Configuration pop up"

  #6836407#
  @MLP-14320 @webtest @positive @regression @IDA-10.3
  Scenario:SC#5_Verify whether the background of the panel is displayed in red when connection is unsuccessful in AWSGlueCataloger when invalid / empty credential is used in Local Node
  Verify captions and tool tip text in AWSGlueCataloger

    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute              |
      | Type        | Cataloger              |
      | Plugin      | AWSGlueCataloger       |
      | Data Source | AmazonGlue_DataSource  |
      | Credential  | InvalidGlueCredentials |
    And user verifies the "Dynamic form" for "PluginConfiguration" in Add Manage Configuration Page
      | Name*               |
      | Label               |
      | Databases to Filter |
      | Jobs to Filter      |
      | Data Source*        |
      | Credential*         |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute         |
      | Name      | AWSGlueCataloger1 |
      | Label     | AWSGlueCataloger1 |
    And user "click" on "Test Connection" button in "Add Manage Configuration Sources Page"
    And user verifies "No connection with data source - AmazonS3 connection was failed" is "displayed" in "Add Manage Configuration Sources Page"
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute            |
      | Credential | EmptyGlueCredentials |
    And user "click" on "Test Connection" button in "Add Manage Configuration Sources Page"
    And user verifies "No connection with data source - Required attribute Secret key is blank" is "displayed" in "Add Manage Configuration Sources Page"
#    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  #6754463#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario: SC6#MLP_14320_Verify AWSGlueCataloger plugin config throws error message in UI if mandatory fields are not passed as input.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Type      | Cataloger        |
      | Plugin    | AWSGlueCataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

  #6878391#
  @MLP-15788 @webtest @positive @regression @pluginManager
  Scenario: SC7# Verify if all the mandatory fields (Name) are throwing with proper error message if they are left blank in AWSGlueDatasource
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute         |
      | Data Source Type | AWSGlueDataSource |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

#################Dry Run scenario Starts###########################

  @sanity @positive @MLP-14320
  Scenario: SC8#-Set the AWSGlueDatasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                         | body                                                              | response code | response message       | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/AWSGlueDataSource/AWSGlueValidDataSource | ida/amazonGluePayloads/DataSource/AmazonGlueDataSourceConfig.json | 204           |                        |          |
      |                  |       |       | Get  | settings/analyzers/AWSGlueDataSource/AWSGlueValidDataSource |                                                                   | 200           | AWSGlueValidDataSource |          |

  #6754453#
  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario:SC8#MLP_14320_Run the Glue Cataloger plugin with dryRun as True
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                                                    | response code | response message | jsonPath                                          |
      | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigDryRunTrue.json | 204           |                  |                                                   |
      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                         | 200           | GlueCatalog1     |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='GlueCatalog1')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  | ida/amazonGluePayloads/empty.json                                       | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='GlueCatalog1')].status |


  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC8#MLP_14320_Verify after AWS Glue Cataloger plugin Run Successful with dry run as true
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagGlueDryRunTrue" and clicks on search
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Cluster   |
      | Service   |
      | Database  |
      | Table     |
      | Column    |
      | Operation |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AWSGlueCataloger/GlueCatalog%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 1             |
      | Number of errors          | 0             |
    And user "widget presence" on "Processed Items" in Item view page
    Then Analysis log "cataloger/AWSGlueCataloger/GlueCatalog1%" should display below info/error/warning
      | type | logValue                                        | logCode       | pluginName       | removableText |
      | INFO | Plugin AWSGlueCataloger running on dry run mode | ANALYSIS-0069 | AWSGlueCataloger |               |

  @sanity @positive
  Scenario:SC#8:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%           | Analysis |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster  |       |       |

#  ##################Dry Run scenario Ends###########################
#
#  ############################# Plugin Run #########################################

  @cr-data @sanity @positive
  Scenario: SC9#-Set the AWSGlueDatasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                         | body                                                              | response code | response message       | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/AWSGlueDataSource/AWSGlueValidDataSource | ida/amazonGluePayloads/DataSource/AmazonGlueDataSourceConfig.json | 204           |                        |          |
      |                  |       |       | Get  | settings/analyzers/AWSGlueDataSource/AWSGlueValidDataSource |                                                                   | 200           | AWSGlueValidDataSource |          |

  #6754453#
  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario:SC9#MLP_14320_Run the Glue Cataloger plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                                             | response code | response message | jsonPath                                          |
      | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigSC1.json | 204           |                  |                                                   |
      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                  | 200           | GlueCatalog1     |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='GlueCatalog1')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  | ida/amazonGluePayloads/empty.json                                | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='GlueCatalog1')].status |

#  ############################# EDI BUS #########################################
   #6549303
#  @sanity @positive @webtest @edibus
#  Scenario:MLP_9043_Verify the GlueCataloger items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "SC1TagGlueCataloger" and clicks on search
#    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Amazon Glue" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Column     |
#      | Table      |
#      | Database   |
#      | Operation  |
#      | Connection |
#      | Partition  |
#      | Routine    |
#      | Analysis   |
#      | Cluster    |
#      | Service    |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/AmazonGlueConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                   | body                                     | response code | response message | jsonPath                                              |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                             | idc/EdiBusPayloads/AmazonGlueConfig.json | 204           |                  |                                                       |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAmazonGlue |                                          | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAmazonGlue')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusAmazonGlue  |                                          | 200           |                  |                                                       |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusAmazonGlue |                                          | 200           | IDLE             | $.[?(@.configurationName=='EDIBusAmazonGlue')].status |
#    And user enters the search text "EDIBusAmazonGlue" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusAmazonGlue%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "SC1TagGlueCataloger" and clicks on search
#    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Amazon Glue" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                            |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/ETL/Amazon Glue |
#      | $..selections.['type_s'][*]                   | Column                                |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                                | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=SC1TagGlueCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
#    And user enters the search text "SC1TagGlueCataloger" and clicks on search
#    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Amazon Glue" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                          |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                            |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/ETL/Amazon Glue |
#      | $..selections.['type_s'][*]                   | Table                                 |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                                | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=SC1TagGlueCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
#    And user enters the search text "SC1TagGlueCataloger" and clicks on search
#    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Amazon Glue" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Database" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                     |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                            |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/ETL/Amazon Glue |
#      | $..selections.['type_s'][*]                   | Database                              |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                                | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=SC1TagGlueCataloger&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
#    And user enters the search text "SC1TagGlueCataloger" and clicks on search
#    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Amazon Glue" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                   |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @*Amazon@ Glue≫DEFAULT≫DWR_RDB_COLUMN≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @*Amazon@ Glue≫DEFAULT≫DWR_RDB_TABLE_OR_VIEW≫@* ),AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | GLUE        | 1.0                | (XNAME * *  ~/ @*Amazon@ Glue≫DEFAULT≫DWR_RDB_DATABASE≫@* ),AND,( TYPE = DWR_IDC )      |
#
#
#  ############################# Logging Enhancements #########################################

  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:MLP-8708:SC9#Verify log entries/log enhancements(processed Items widget and Processed count) check for AWSGlueCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TagGlueCataloger" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AWSGlueCataloger/GlueCatalog%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 3             |
      | Number of errors          | 0             |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | Domain=amazonaws.com;Region=us-east-1; |
      | AWSGlue                                |
    Then Analysis log "cataloger/AWSGlueCataloger/GlueCatalog%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | logCode       | pluginName       | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0019 |                  |                |
      | INFO | Plugin Name:AWSGlueCataloger, Plugin Type:cataloger, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:752e42d5c6c5, Plugin Configuration name:GlueCatalog1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0071 | AWSGlueCataloger | Plugin Version |
      | INFO | Plugin AWSGlueCataloger Configuration: ---  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: name: "GlueCatalog1"  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: pluginVersion: "LATEST"  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: label:  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: : ""  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: auditFields:  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: createdBy: "TestSystem"  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: createdAt: "2021-02-10T11:44:03.738478"  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: modifiedBy: "TestSystem"  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: modifiedAt: "2021-02-10T11:59:19.954593"  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: catalogName: "Default"  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: eventClass: null  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: eventCondition: null  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: nodeCondition: "name==\"LocalNode\""  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: maxWorkSize: 100  2021-02-10 11:59:34.499 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: tags:  2021-02-10 11:59:34.500 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: - "SC1TagGlueCataloger"  2021-02-10 11:59:34.500 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: pluginType: "cataloger"  2021-02-10 11:59:34.500 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: dataSource: "AWSGlueValidDataSource"  2021-02-10 11:59:34.500 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: credential: "ValidGlueCredentials"  2021-02-10 11:59:34.500 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: businessApplicationName: "AWSGlueCataloger_BA"  2021-02-10 11:59:34.500 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: schedule: null  2021-02-10 11:59:34.500 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: filter: null  2021-02-10 11:59:34.500 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: dryRun: false  2021-02-10 11:59:34.500 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: includeItems:  2021-02-10 11:59:34.500 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: includeJobs: []  2021-02-10 11:59:34.500 INFO  - ANALYSIS-0073: Plugin AWSGlueCataloger Configuration: includeDatabases: [] | ANALYSIS-0073 | AWSGlueCataloger |                |
      | INFO | Plugin AWSGlueCataloger Start Time:2020-03-19 01:40:47.135, End Time:2020-03-19 01:41:19.107, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0072 | AWSGlueCataloger |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:02:06.596)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ANALYSIS-0020 |                  |                |

  ############################# UI Metadata verification #############################
  #6822653
  #6754445#


  #6754446# #6754447# #6754448#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC10#MLP_14320_Verify the Database should have the appropriate metadata information in IDC UI and Database
  Verify the Table should have the appropriate metadata information in IDC UI and Database
  Verify the column should have the appropriate metadata information in IDC UI and Database

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TagGlueCataloger" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "gluetestdatabase" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue      | widgetName  |
      | Comments          | Test Glue Database | Description |
      | Location          | Test Location      | Description |
    And user enters the search text "SC1TagGlueCataloger" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "gluetestdatabase [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "gluetesttable" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                     | widgetName  |
      | Description       | Table Description                 | Description |
      | Table Type        | TABLE                             | Description |
      | Created by        | arn:aws:iam::868165524337:user/QA | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Created            | Lifecycle  |
      | Modified           | Lifecycle  |
    And user enters the search text "backend_ip" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "backend_ip" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | string        | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |




  #6754447#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC11#MLP_14320_ Verify the metadata attributes collected at Partition level and the attributes should match with IDC UI and Postgress Database.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TagGlueCataloger" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Partition" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | [USA]    |
      | [Mexico] |
    And user performs "item click" on "[USA]" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                               | widgetName  |
      | Location          | s3://asg-ida-s3-dev-test/Store/country=USA/ | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Created           | Lifecycle  |


  #6754447#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC12#MLP_14320_Verify the metadata attributes collected at Operation level and the attributes should match with IDC UI and Postgress Database.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PythonTestJob1" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PythonTestJob1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                  | widgetName  |
      | Comments          | aws glue qa automation                                         | Description |
      | File name         | PythonTestJob1                                                 | Description |
      | Location          | s3://aws-glue-scripts-868165524337-us-east-1/QA/PythonTestJob1 | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Created            | Lifecycle  |
      | Last catalogued at | Lifecycle  |


  #6754447#
  @sanity @positive @MLP-14649 @webtest @IDA-10.3
  Scenario:SC13#MLP_14649_Verify the metadata attributes collected at Connections level and the attributes should match with IDC UI and Postgress Database.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TagGlueCataloger" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Connection" attribute under "Metadata Type" facets in Item Search results page
    And user connects to AWS Glue database and perform the following operation
      | action               |
      | verifyConnectionSize |
    And user performs "item click" on "TestJDBCConnection" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                               | widgetName  |
      | Comments          | TestJDBCConnection description                                                              | Description |
      | connectionType    | JDBC                                                                                        | Description |
      | connectionUrl     | jdbc:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world | Description |
      | Modified by       | user/QA                                                                                     | Description |
      | userName          | master                                                                                      | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Created           | Lifecycle  |
      | Modified          | Lifecycle  |


  #6754447#
  @sanity @positive @MLP-14649 @webtest @IDA-10.3
  Scenario:SC14#MLP_14649_Verify the connections associated with a Operation are listed under USES section under Operations.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PythonTestJob1" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PythonTestJob1" item from search results
    And user "verifies tab section values" has the following values in "uses" Tab in Item View page
      | TestJDBCConnection |


  #6754447#
  @sanity @positive @MLP-14649 @webtest @IDA-10.3
  Scenario:SC15#MLP_14649_Verify the metadata attributes collected at UDF level and the attributes should match with IDC UI and Postgress Database.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TagGlueCataloger" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | gluetestfunction1 |
      | gluetestfunction2 |
    And user performs "item click" on "gluetestfunction1" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Created           | Lifecycle  |


  ############################# Technology Tags Verification #############################
  #6754458#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC16#MLP_14320_Verify the Technology tag/explicit appears properly for items collected by AWSGlueCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TagGlueCataloger" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SC1TagGlueCataloger,Amazon Glue,AWSGlueCataloger_BA" should get displayed for the column "cataloger/AWSGlueCataloger"
    And user performs "facet selection" in "Partition" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SC1TagGlueCataloger,Amazon Glue,AWSGlueCataloger_BA" should get displayed for the column "USA"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name                | facet | Tag                                                 | fileName                               | userTag                                |
      | Default     | SC1TagGlueCataloger | Tags  | SC1TagGlueCataloger,Amazon Glue,AWSGlueCataloger_BA | backend_ip                             | backend_ip                             |
      | Default     | SC1TagGlueCataloger | Tags  | SC1TagGlueCataloger,Amazon Glue,AWSGlueCataloger_BA | gluetesttable                          | gluetesttable                          |
      | Default     | SC1TagGlueCataloger | Tags  | SC1TagGlueCataloger,Amazon Glue,AWSGlueCataloger_BA | gluetestdatabase                       | gluetestdatabase                       |
      | Default     | SC1TagGlueCataloger | Tags  | SC1TagGlueCataloger,Amazon Glue,AWSGlueCataloger_BA | TestJDBCConnection                     | TestJDBCConnection                     |
      | Default     | SC1TagGlueCataloger | Tags  | SC1TagGlueCataloger,Amazon Glue,AWSGlueCataloger_BA | PythonTestJob1                         | PythonTestJob1                         |
      | Default     | SC1TagGlueCataloger | Tags  | SC1TagGlueCataloger,Amazon Glue,AWSGlueCataloger_BA | gluetestfunction1                      | gluetestfunction1                      |
      | Default     | SC1TagGlueCataloger | Tags  | SC1TagGlueCataloger,Amazon Glue,AWSGlueCataloger_BA | Domain=amazonaws.com;Region=us-east-1; | Domain=amazonaws.com;Region=us-east-1; |
      | Default     | SC1TagGlueCataloger | Tags  | SC1TagGlueCataloger,Amazon Glue,AWSGlueCataloger_BA | AWSGlue                                | AWSGlue                                |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name                | facet | Tag        | fileName                               | userTag                                |
      | Default     | SC1TagGlueCataloger | Tags  | Cloud Data | Domain=amazonaws.com;Region=us-east-1; | Domain=amazonaws.com;Region=us-east-1; |
      | Default     | SC1TagGlueCataloger | Tags  | Cloud Data | AWSGlue                                | AWSGlue                                |
      | Default     | SC1TagGlueCataloger | Tags  | Cloud Data | gluetestdatabase                       | gluetestdatabase                       |
      | Default     | SC1TagGlueCataloger | Tags  | Cloud Data | gluetesttable                          | gluetesttable                          |
      | Default     | SC1TagGlueCataloger | Tags  | Cloud Data | backend_ip                             | backend_ip                             |
      | Default     | SC1TagGlueCataloger | Tags  | Cloud Data | [USA]                                  | [USA]                                  |
      | Default     | SC1TagGlueCataloger | Tags  | Cloud Data | PythonTestJob1                         | PythonTestJob1                         |
      | Default     | SC1TagGlueCataloger | Tags  | Cloud Data | gluetestfunction1                      | gluetestfunction1                      |
      | Default     | SC1TagGlueCataloger | Tags  | Cloud Data | TestJDBCConnection                     | TestJDBCConnection                     |


  #6754464#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC17#MLP_14320_Verify the breadcrumb hierarchy appears correctly when AWSGlueCataloger is ran and items got collected.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TagGlueCataloger" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "gluetesttable [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "backend_processing_time" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | Domain=amazonaws.com;Region=us-east-1; |
      | AWSGlue                                |
      | gluetestdatabase                       |
      | gluetesttable                          |
      | backend_processing_time                |

    #6822652
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC17#MLP_14320_Verify the AmazonGlueCataloger collects Cluster,Service,Database,Table,Column,Partition,Operation,Connections,UDFs when no filters are provided in configuration.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1TagGlueCataloger" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Analysis  | 1     |
      | Cluster   | 1     |
      | Service   | 1     |
      | Partition | 2     |
      | Routine   | 2     |
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user connects to AWS Glue database and perform the following operation
      | action             |
      | verifyDatabaseSize |
    And user enters the search text "SC1TagGlueCataloger" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "gluetestdatabase [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user connects to AWS Glue database and perform the following operation
      | action          | databaseName     |
      | verifyTableSize | gluetestdatabase |
    And user enters the search text "SC1TagGlueCataloger" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "gluetesttable [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user connects to AWS Glue database and perform the following operation
      | action           | databaseName     | tableName     |
      | verifyColumnSize | gluetestdatabase | gluetesttable |
    And user enters the search text "SC1TagGlueCataloger" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user connects to AWS Glue database and perform the following operation
      | action        |
      | verifyJobSize |
    And user enters the search text "SC1TagGlueCataloger" and clicks on search
    And user performs "facet selection" in "SC1TagGlueCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Connection" attribute under "Metadata Type" facets in Item Search results page
    And user connects to AWS Glue database and perform the following operation
      | action               |
      | verifyConnectionSize |


  @sanity @positive
  Scenario:SC#17:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%           | Analysis |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster  |       |       |

  #############################Scenario: 1 Ends#########################################

  #############################Scenario: second start#########################################

  @cr-data @sanity @positive
  Scenario: SC18#-Set the AWSGlueDatasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                      | body                                                                                | response code | response message                    | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/AWSGlueDataSource/AWSGlueInvalidCredentialsDataSource | ida/amazonGluePayloads/DataSource/AmazonGlueInvalidCredentialsDataSourceConfig.json | 204           |                                     |          |
      |                  |       |       | Get  | settings/analyzers/AWSGlueDataSource/AWSGlueInvalidCredentialsDataSource |                                                                                     | 200           | AWSGlueInvalidCredentialsDataSource |          |

  #6754465#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC18#MLP_14320_Verify AWSGlueCataloger collects only analysis and throws error message in log when Datasource with invalid credentials is given.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Type      | Cataloger        |
      | Plugin    | AWSGlueCataloger |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Name      | AmazonGlueConfig |
      | Label     | AmazonGlueConfig |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute                           |
      | Data Source | AWSGlueInvalidCredentialsDataSource |
      | Credential  | InvalidGlueCredentials              |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "No connection with data source - Request timed out" is "displayed" in "Add Data Sources Page"
    #And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  #6878397 Bug MLP-20126 raised for this scenario#
  @MLP-15788 @webtest @positive
  Scenario: SC19#MLP_14320_Verify the AWSGlueCataloger does not collect any items when an Invalid Datasource(with wrong Credentials) and Invalid Credentials are used in the Plugin Configuration and log shown processed count:0
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                                                         | response code | response message                    | jsonPath                                                   |
      | application/json | raw   | false | Put          | settings/analyzers/AWSGlueDataSource/AWSGlueInvalidCredentialsDataSource | ida/amazonGluePayloads/DataSource/AmazonGlueInvalidCredentialsDataSourceConfig.json          | 204           |                                     |                                                            |
      |                  |       |       | Get          | settings/analyzers/AWSGlueDataSource/AWSGlueInvalidCredentialsDataSource |                                                                                              | 200           | AWSGlueInvalidCredentialsDataSource |                                                            |
      |                  |       |       | Put          | settings/analyzers/AWSGlueCataloger                                      | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigWithInvalidDataSourceCredential.json | 204           |                                     |                                                            |
      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                      |                                                                                              | 200           | GlueInvalidKeyCatalog               |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*       |                                                                                              | 200           | IDLE                                | $.[?(@.configurationName=='GlueInvalidKeyCatalog')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*        | ida/amazonGluePayloads/empty.json                                                            | 200           |                                     |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*       |                                                                                              | 200           | IDLE                                | $.[?(@.configurationName=='GlueInvalidKeyCatalog')].status |
    And user enters the search text "tagGlueInvalidDSInvalidCred" and clicks on search
    And user performs "facet selection" in "tagGlueInvalidDSInvalidCred" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AWSGlueCataloger/GlueInvalidKeyCatalog%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 1             |
      | Number of halt errors     | 1             |
    And user "widget presence" on "Processed Items" in Item view page
    Then Analysis log "cataloger/AWSGlueCataloger/GlueInvalidKeyCatalog%" should display below info/error/warning
      | type | logValue                                                                                          | logCode                              | pluginName       | removableText |
      | HALT | Amazon Glue datasource connection failed : The security token included in the request is invalid. | ANALYSIS-GLUE-DATASOURCE-ERROR-00021 | AWSGlueCataloger |               |


  @sanity @positive
  Scenario:SC#19:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%           | Analysis |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster  |       |       |

    ###############################################################################################################################################

  @cr-data @sanity @positive
  Scenario: SC20#-Set the AWSGlueDatasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                     | body                                                                               | response code | response message                   | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/AWSGlueDataSource/AWSGlueDataSourceWithInvalidRegion | ida/amazonGluePayloads/DataSource/AmazonGlueDataSourceWithInvalidRegionConfig.json | 204           |                                    |          |
      |                  |       |       | Get  | settings/analyzers/AWSGlueDataSource/AWSGlueDataSourceWithInvalidRegion |                                                                                    | 200           | AWSGlueDataSourceWithInvalidRegion |          |

  #6754465#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC20#MLP_14320_Verify AWSGlueCataloger throws error message when Test Connection button is clicked with DataSource having incorrect region is given.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Type      | Cataloger        |
      | Plugin    | AWSGlueCataloger |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Name      | AmazonGlueConfig |
      | Label     | AmazonGlueConfig |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute                          |
      | Data Source | AWSGlueDataSourceWithInvalidRegion |
      | Credential  | ValidGlueCredentials               |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "No connection with data source - Request timed out" is "displayed" in "Add Data Sources Page"
    #And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

###################################################################################################################################################################
  @cr-data @sanity @positive
  Scenario: SC21#-Set the AWSGlueDatasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                      | body                                                                           | response code | response message                    | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/AWSGlueDataSource/AWSGlueValidDataSourceNodeCondition | ida/amazonGluePayloads/DataSource/AmazonGlueDataSourceConfigNodeCondition.json | 204           |                                     |          |
      |                  |       |       | Get  | settings/analyzers/AWSGlueDataSource/AWSGlueValidDataSourceNodeCondition |                                                                                | 200           | AWSGlueValidDataSourceNodeCondition |          |


  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario:SC21#MLP_14320_Run the Glue Cataloger plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                   | body                                                                       | response code | response message | jsonPath                                          |
      | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                   | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigNodeCondition.json | 204           |                  |                                                   |
      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                   |                                                                            | 200           | GlueCatalog1     |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AWSGlueCataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='GlueCatalog1')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/AWSGlueCataloger/*  | ida/empty.json                                                             | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AWSGlueCataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='GlueCatalog1')].status |

##6822662
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC21#MLP_14320_Verify the AmazonGlueCataloger works fine if node condition is given.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagGlueNodeCondition" and clicks on search
    And user performs "facet selection" in "tagGlueNodeCondition" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Analysis  | 1     |
      | Cluster   | 1     |
      | Service   | 1     |
      | Partition | 2     |
      | Routine   | 2     |
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user connects to AWS Glue database and perform the following operation
      | action             |
      | verifyDatabaseSize |
    And user enters the search text "tagGlueNodeCondition" and clicks on search
    And user performs "facet selection" in "tagGlueNodeCondition" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "gluetestdatabase [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user connects to AWS Glue database and perform the following operation
      | action          | databaseName     |
      | verifyTableSize | gluetestdatabase |
    And user enters the search text "tagGlueNodeCondition" and clicks on search
    And user performs "facet selection" in "tagGlueNodeCondition" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "gluetesttable [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user connects to AWS Glue database and perform the following operation
      | action           | databaseName     | tableName     |
      | verifyColumnSize | gluetestdatabase | gluetesttable |
    And user enters the search text "tagGlueNodeCondition" and clicks on search
    And user performs "facet selection" in "tagGlueNodeCondition" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user connects to AWS Glue database and perform the following operation
      | action        |
      | verifyJobSize |
    And user enters the search text "tagGlueNodeCondition" and clicks on search
    And user performs "facet selection" in "tagGlueNodeCondition" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Connection" attribute under "Metadata Type" facets in Item Search results page
    And user connects to AWS Glue database and perform the following operation
      | action               |
      | verifyConnectionSize |


  @sanity @positive
  Scenario:SC#21:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%           | Analysis |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster  |       |       |

############################################################################################################################################################
  @cr-data @sanity @positive
  Scenario: SC22#-Set the AWSGlueDatasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                         | body                                                              | response code | response message       | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/AWSGlueDataSource/AWSGlueValidDataSource | ida/amazonGluePayloads/DataSource/AmazonGlueDataSourceConfig.json | 204           |                        |          |
      |                  |       |       | Get  | settings/analyzers/AWSGlueDataSource/AWSGlueValidDataSource |                                                                   | 200           | AWSGlueValidDataSource |          |

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario:SC22#MLP_14320_Run the Glue Cataloger plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                                                       | response code | response message      | jsonPath                                                   |
      | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigNonExistingDB.json | 204           |                       |                                                            |
      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                            | 200           | GlueCatalogNoDatabase |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                            | 200           | IDLE                  | $.[?(@.configurationName=='GlueCatalogNoDatabase')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  | ida/empty.json                                                             | 200           |                       |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                            | 200           | IDLE                  | $.[?(@.configurationName=='GlueCatalogNoDatabase')].status |



  #6754450#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC22#MLP_14320_Verify the AmazonGlueCataloger collects only analysis items if non existing Database filters are given
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagGlueNonExistingDB" and clicks on search
    And user performs "facet selection" in "tagGlueNonExistingDB" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Database |
      | Table    |
      | Column   |
      | Routine  |
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis   |
      | Cluster    |
      | Service    |
      | Operation  |
      | Connection |
    And user performs "facet selection" in "tagGlueNonExistingDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AWSGlueCataloger/GlueCatalog%"
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | Domain=amazonaws.com;Region=us-east-1; |
      | AWSGlue                                |
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 3             |
      | Number of errors          | 0             |
    Then Analysis log "cataloger/AWSGlueCataloger/GlueCatalog%" should display below info/error/warning
      | type | logValue                                                                                                                              | logCode       | pluginName       | removableText |
      | INFO | Plugin AWSGlueCataloger Start Time:2020-03-05 18:44:12.750, End Time:2020-03-05 18:44:18.209, Processed Count:2, Errors:0, Warnings:0 | ANALYSIS-0072 | AWSGlueCataloger |               |


  @sanity @positive
  Scenario:SC#22:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%           | Analysis |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster  |       |       |

#########################################################################################################################
  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario:SC23#MLP_14320_Run the Glue Cataloger plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                                                        | response code | response message | jsonPath                                              |
      | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigNonExistingJob.json | 204           |                  |                                                       |
      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                             | 200           | GlueCatalogNoJob |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='GlueCatalogNoJob')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  | ida/empty.json                                                              | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                             | 200           | IDLE             | $.[?(@.configurationName=='GlueCatalogNoJob')].status |


    ##6754450#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC23#MLP_14320_Verify the AmazonGlueCataloger collects only analysis items if non existing Job filters are given
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagGlueNonExistingJob" and clicks on search
    And user performs "facet selection" in "tagGlueNonExistingJob" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Type" section in item search results page
      | Operation |
    Then user verify "presence of facets" with following values under "Type" section in item search results page
      | Analysis   |
      | Cluster    |
      | Service    |
      | Database   |
      | Table      |
      | Column     |
      | Connection |
      | Routine    |
      | Partition  |
    And user performs "facet selection" in "tagGlueNonExistingJob" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AWSGlueCataloger/GlueCatalog%"
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | Domain=amazonaws.com;Region=us-east-1; |
      | AWSGlue                                |
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 2             |
      | Number of errors          | 0             |
    Then Analysis log "cataloger/AWSGlueCataloger/GlueCatalog%" should display below info/error/warning
      | type | logValue                                                                                                                              | logCode       | pluginName       | removableText |
      | INFO | Plugin AWSGlueCataloger Start Time:2020-03-05 18:44:12.750, End Time:2020-03-05 18:44:18.209, Processed Count:2, Errors:0, Warnings:0 | ANALYSIS-0072 | AWSGlueCataloger |               |


  @sanity @positive
  Scenario:SC#23:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%           | Analysis |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster  |       |       |

##################################################################################################################################

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario:SC24#MLP_14320_Run the Glue Cataloger plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                                                             | response code | response message  | jsonPath                                               |
      | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigExactDatabaseFilter.json | 204           |                   |                                                        |
      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                                  | 200           | GlueCatalogWithDB |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='GlueCatalogWithDB')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  | ida/empty.json                                                                   | 200           |                   |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='GlueCatalogWithDB')].status |


    ##6754450#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC24#MLP_14320_Verify the AmazonGlueCataloger collects the entities matching the Database filter condition given with exact name match and with wild card character *.
  Verify all the Connections but UDFS specific to a Database are collected if Database filters are provided in AWSGlueCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagGlueExactDB" and clicks on search
    And user performs "facet selection" in "tagGlueExactDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | gluetestdatabase |
    And user enters the search text "tagGlueExactDB" and clicks on search
    And user performs "facet selection" in "tagGlueExactDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | gluetesttable |
      | store         |
    And user enters the search text "tagGlueExactDB" and clicks on search
    And user performs "facet selection" in "tagGlueExactDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | gluetestfunction1 |
      | gluetestfunction2 |
    And user enters the search text "tagGlueExactDB" and clicks on search
    And user performs "facet selection" in "tagGlueExactDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Connection" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TestJDBCConnection     |
      | DatabaseTestConnection |
      | RedshiftconnectionQA   |
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Cluster   | 1     |
      | Service   | 1     |
      | Database  | 1     |
      | Table     | 2     |
      | Column    | 31    |
      | Partition | 2     |
      | Routine   | 2     |

  @sanity @positive
  Scenario:SC#24:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%           | Analysis |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster  |       |       |


  ##################################################################################################################################

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario:SC25#MLP_14320_Run the Glue Cataloger plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                                                            | response code | response message  | jsonPath                                               |
      | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigWildDatabaseFilter.json | 204           |                   |                                                        |
      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                                 | 200           | GlueCatalogWithDB |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='GlueCatalogWithDB')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  | ida/empty.json                                                                  | 200           |                   |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='GlueCatalogWithDB')].status |



    #6822666
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC25#MLP_14320_Verify the AmazonGlueCataloger collects the entities matching the Database filter condition given with wild card character *.
  Verify all the Connections but UDFS specific to a Database are collected if Database filters are provided in AWSGlueCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagGlueDBWildcard" and clicks on search
    And user performs "facet selection" in "tagGlueDBWildcard" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | gluetestdatabase |
    And user enters the search text "tagGlueDBWildcard" and clicks on search
    And user performs "facet selection" in "tagGlueDBWildcard" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | gluetesttable |
      | store         |
    And user enters the search text "tagGlueDBWildcard" and clicks on search
    And user performs "facet selection" in "tagGlueDBWildcard" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | gluetestfunction1 |
      | gluetestfunction2 |
    And user enters the search text "tagGlueDBWildcard" and clicks on search
    And user performs "facet selection" in "tagGlueDBWildcard" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Connection" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TestJDBCConnection     |
      | DatabaseTestConnection |
      | RedshiftconnectionQA   |
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Cluster   | 1     |
      | Service   | 1     |
      | Database  | 1     |
      | Table     | 2     |
      | Column    | 31    |

  @sanity @positive
  Scenario:SC#25:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%           | Analysis |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster  |       |       |

  ####################################################################################################################################

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario:SC26#MLP_14320_Run the Glue Cataloger plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                                                        | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigExactJobFilter.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                             | 200           | GlueCatalogWithJob |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                             | 200           | IDLE               | $.[?(@.configurationName=='GlueCatalogWithJob')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  | ida/empty.json                                                              | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                             | 200           | IDLE               | $.[?(@.configurationName=='GlueCatalogWithJob')].status |

##6754450#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC26#MLP_14320_Verify the AmazonGlueCataloger collects the entities matching the Job filter condition given with exact name match
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagGlueExactJob" and clicks on search
    And user performs "facet selection" in "tagGlueExactJob" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | PythonTestJob1 |
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Connection |
      | Operation  |
      | Cluster    |
      | Service    |
      | Analysis   |
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | Database  |
      | Table     |
      | Column    |
      | Partition |
      | Routine   |
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Cluster   | 1     |
      | Service   | 1     |
      | Operation | 1     |

  @sanity @positive
  Scenario:SC#26:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%           | Analysis |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster  |       |       |

  #############################################################################################################

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario:SC27#MLP_14320_Run the Glue Cataloger plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                                                       | response code | response message   | jsonPath                                                |
      | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigWildJobFilter.json | 204           |                    |                                                         |
      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                            | 200           | GlueCatalogWithJob |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                            | 200           | IDLE               | $.[?(@.configurationName=='GlueCatalogWithJob')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  | ida/empty.json                                                             | 200           |                    |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                            | 200           | IDLE               | $.[?(@.configurationName=='GlueCatalogWithJob')].status |


#6822668
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC27#MLP_14320_Verify the AmazonGlueCataloger collects the entities matching the Job filter condition given with wild card character *.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagGlueJobWildcard" and clicks on search
    And user enters the search text "tagGlueJobWildcard" and clicks on search
    And user performs "facet selection" in "tagGlueJobWildcard" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | PythonTestJob1 |
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Connection |
      | Operation  |
      | Cluster    |
      | Service    |
      | Analysis   |
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | Database  |
      | Table     |
      | Column    |
      | Partition |
      | Routine   |
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Cluster   | 1     |
      | Service   | 1     |
      | Operation | 1     |


  @sanity @positive
  Scenario:SC#27:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%           | Analysis |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster  |       |       |

  ##################################################################################################################################

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario:SC28#MLP_14320_Run the Glue Cataloger plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                                                                | response code | response message      | jsonPath                                                   |
      | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigMultipleDatabaseFilter.json | 204           |                       |                                                            |
      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                                     | 200           | GlueCatalogMultipleDB |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueCatalogMultipleDB')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  | ida/empty.json                                                                      | 200           |                       |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                     | 200           | IDLE                  | $.[?(@.configurationName=='GlueCatalogMultipleDB')].status |


    ##6754450#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC28#MLP_14320_Verify the AmazonGlueCataloger collects the entities matching the multiple Database filter condition given with exact name match and with wild card character *.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagGlueMultipleDB" and clicks on search
    And user performs "facet selection" in "tagGlueMultipleDB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And sync the test execution for "50" seconds
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | gluetestdatabase |
      | testdatabase     |
      | gluetesttable    |
      | store            |
      | samples          |
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Database  | 3     |
      | Table     | 5     |

  @sanity @positive
  Scenario:SC#28:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%           | Analysis |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster  |       |       |


  #####################################################################################################################################

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario:SC29#MLP_14320_Run the Glue Cataloger plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                                                           | response code | response message       | jsonPath                                                    |
      | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigMultipleJobFilter.json | 204           |                        |                                                             |
      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                                | 200           | GlueCatalogMultipleJob |                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                | 200           | IDLE                   | $.[?(@.configurationName=='GlueCatalogMultipleJob')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  | ida/empty.json                                                                 | 200           |                        |                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                | 200           | IDLE                   | $.[?(@.configurationName=='GlueCatalogMultipleJob')].status |



    ##6754450#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC29#MLP_14320_Verify the AmazonGlueCataloger collects the entities matching the multiple Job filter condition given with exact name match and with wild card character *.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagGlueMultipleJob" and clicks on search
    And user performs "facet selection" in "tagGlueMultipleJob" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | QATestJob      |
      | PythonTestJob1 |
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Cluster   | 1     |
      | Service   | 1     |
      | Operation | 2     |

  @sanity @positive
  Scenario:SC#29:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%           | Analysis |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster  |       |       |


#######################################################################################################################

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario:SC30#MLP_14320_Run the Glue Cataloger plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                                                                   | response code | response message         | jsonPath                                                      |
      | application/json | raw   | false | Put          | settings/analyzers/AWSGlueCataloger                                | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigMultipleDatabaseJobFilter.json | 204           |                          |                                                               |
      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                                        | 200           | GlueCatalogMultipleDBJob |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                        | 200           | IDLE                     | $.[?(@.configurationName=='GlueCatalogMultipleDBJob')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  | ida/empty.json                                                                         | 200           |                          |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                        | 200           | IDLE                     | $.[?(@.configurationName=='GlueCatalogMultipleDBJob')].status |



    ##6754450#
  @sanity @positive @MLP-14320 @webtest @IDA-10.3
  Scenario:SC30#MLP_14320_Verify the AmazonGlueCataloger collects the entities matching the multiple Database/Jobs filter condition given with exact name match and with wild card character *.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagGlueMultipleDBJobs" and clicks on search
    And user performs "facet selection" in "tagGlueMultipleDBJobs" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | gluetestdatabase |
      | testdatabase     |
      | store            |
      | samples          |
      | gluetesttable    |
    And user enters the search text "tagGlueMultipleDBJobs" and clicks on search
    And user performs "facet selection" in "tagGlueMultipleDBJobs" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | PythonTestJob1 |

  @sanity @positive
  Scenario:SC#30:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%           | Analysis |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster  |       |       |


#############################Scenario: Third End#####################################################################


##############Notification scenarios below -Start ##################################

#  @cr-data @sanity @positive
#  Scenario: SC26#-Set the AWSGlueDatasource
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                  | body                                                              | response code | response message | jsonPath               |
#      | application/json | raw   | false | Put  | settings/analyzers/AWSGlueDataSource | ida/amazonGluePayloads/DataSource/AmazonGlueDataSourceConfig.json | 204           |                  |                        |
#      |                  |       |       | Get  | settings/analyzers/AWSGlueDataSource |                                                                   | 200           |                  | AWSGlueValidDataSource |


#    #6878394##
#  @MLP-15788 @webtest
#  Scenario: SC26#-Verify the Analysis succeeded notification displayed in IDC UI when the analysis plugin executed without any errors - Valid AWSGlueDataSource connectivity details
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                   | body                                                              | response code | response message | jsonPath                                                    |
#      | application/json | raw   | false | Post         | settings/catalogs                                                     | ida/amazonGluePayloads/catalogs/CreateAWSGlueCatalog.json         | 204           |                  |                                                             |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueDataSource                                  | ida/amazonGluePayloads/DataSource/AmazonGlueDataSourceConfig.json | 204           |                  |                                                             |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueDataSource                                  |                                                                   | 200           |                  | AWSGlueValidDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueValidDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSGlueDataSource/*  | ida/amazonGluePayloads/empty.json                                 | 200           |                  |                                                             |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueValidDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSGlueDataSource on LocalNode has started" in the notifications tab
#    And "Analysis succeeded!" notification should have content "Analysis AWSGlueDataSource on LocalNode has succeeded" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/GlueCatalog1"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#    ##6878395##
#  @MLP-15788 @webtest
#  Scenario: SC29#-Verify the Analysis failed notification event displayed in IDC UI when user gives invalid Secret and Access Key for AWS Glue datasource plugin
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                   | body                                                                                | response code | response message | jsonPath                                                                 |
#      | application/json | raw   | false | Post         | settings/catalogs                                                     | ida/amazonGluePayloads/catalogs/CreateAWSGlueInvalidKeyCatalog.json                 | 204           |                  |                                                                          |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueDataSource                                  | ida/amazonGluePayloads/DataSource/AmazonGlueInvalidCredentialsDataSourceConfig.json | 204           |                  |                                                                          |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueDataSource                                  |                                                                                     | 200           |                  | AWSGlueInvalidCredentialsDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueInvalidCredentialsDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSGlueDataSource/*  | ida/amazonGluePayloads/empty.json                                                   | 200           |                  |                                                                          |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueInvalidCredentialsDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSGlueDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSGlueDataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/GlueInvalidKeyCatalog"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#    ##6878397##
#  @MLP-15788 @webtest
#  Scenario: SC30#-Verify the AWSGlueCataloger does not collect any items when an Invalid Datasource(with wrong Credentials) and Invalid Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                   | body                                                                                         | response code | response message | jsonPath                                                                                |
#      | application/json | raw   | false | Post         | settings/catalogs                                                     | ida/amazonGluePayloads/catalogs/CreateAWSGlueInvalidKeyCatalog.json                          | 204           |                  |                                                                                         |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueCataloger                                   | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigWithInvalidDataSourceCredential.json | 204           |                  |                                                                                         |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                   |                                                                                              | 200           |                  | AWSGlueCatalogerWithInvalidDataSourceAndCredential                                      |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueDataSource                                  | ida/amazonGluePayloads/DataSource/AmazonGlueInvalidCredentialsDataSourceConfig.json          | 204           |                  |                                                                                         |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueDataSource                                  |                                                                                              | 200           |                  | AWSGlueInvalidCredentialsDataSource                                                     |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueInvalidCredentialsDataSource')].status                |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSGlueDataSource/*  | ida/amazonGluePayloads/empty.json                                                            | 200           |                  |                                                                                         |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueInvalidCredentialsDataSource')].status                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*    |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueCatalogerWithInvalidDataSourceAndCredential')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*     | ida/amazonGluePayloads/empty.json                                                            | 200           |                  |                                                                                         |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*    |                                                                                              | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueCatalogerWithInvalidDataSourceAndCredential')].status |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSGlueCataloger on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSGlueCataloger on LocalNode has failed:" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis AWSGlueDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSGlueDataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "GlueInvalidKeyCatalog" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Analysis |
#      | Cluster  |
#      | Service  |
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "cataloger" item from search results
#    And user click on Analysis log link in DATA widget section
#    Then user "verify analysis log contains" presence of "The security token included in the request is invalid." in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/GlueInvalidKeyCatalog"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#####
#  @MLP-14874 @webtest
#  Scenario: SC31#-Verify the AWSGlueCataloger collects all items when an Invalid Datasource(with wrong Credentials) and Valid Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                   | body                                                                                       | response code | response message | jsonPath                                                                              |
#      | application/json | raw   | false | Post         | settings/catalogs                                                     | ida/amazonGluePayloads/catalogs/CreateAWSGlueInvalidKeyCatalog.json                        | 204           |                  |                                                                                       |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueCataloger                                   | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigWithValidDataSourceCredential.json | 204           |                  |                                                                                       |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                   |                                                                                            | 200           |                  | AWSGlueCatalogerWithValidDataSourceAndCredential                                      |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueDataSource                                  | ida/amazonGluePayloads/DataSource/AmazonGlueInvalidCredentialsDataSourceConfig.json        | 204           |                  |                                                                                       |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueDataSource                                  |                                                                                            | 200           |                  | AWSGlueInvalidCredentialsDataSource                                                   |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueInvalidCredentialsDataSource')].status              |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSGlueDataSource/*  | ida/empty.json                                                              | 200           |                  |                                                                                       |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueInvalidCredentialsDataSource')].status              |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*    |                                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueCatalogerWithValidDataSourceAndCredential')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*     | ida/empty.json                                                              | 200           |                  |                                                                                       |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*    |                                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueCatalogerWithValidDataSourceAndCredential')].status |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSGlueCataloger on LocalNode has started" in the notifications tab
#    And "Analysis succeeded!" notification should have content "Analysis AWSGlueCataloger on LocalNode has succeeded" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis AWSGlueDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSGlueDataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "GlueInvalidKeyCatalog" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Column     |
#      | Table      |
#      | Database   |
#      | Analysis   |
#      | Cluster    |
#      | Service    |
#      | Operation  |
#      | Partition  |
#      | Routine    |
#      | Connection |
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/GlueInvalidKeyCatalog"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#    ####
#  @MLP-15788 @webtest
#  Scenario: SC33#-Verify the AWSGlueCataloger does not collect any items when an Datasource(with Empty Credentials) and Empty Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                   | body                                                                                       | response code | response message | jsonPath                                                                              |
#      | application/json | raw   | false | Post         | settings/catalogs                                                     | ida/amazonGluePayloads/catalogs/CreateAWSGlueEmptyCredential.json                          | 204           |                  |                                                                                       |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueCataloger                                   | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigWithEmptyDataSourceCredential.json | 204           |                  |                                                                                       |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                   |                                                                                            | 200           |                  | AWSGlueCatalogerWithEmptyDataSourceAndCredential                                      |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueDataSource                                  | ida/amazonGluePayloads/DataSource/AmazonGlueEmptyCredentialsDataSourceConfig.json          | 204           |                  |                                                                                       |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueDataSource                                  |                                                                                            | 200           |                  | AWSGlueEmptyCredentialsDataSource                                                     |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueEmptyCredentialsDataSource')].status                |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSGlueDataSource/*  | ida/empty.json                                                              | 200           |                  |                                                                                       |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueEmptyCredentialsDataSource')].status                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*    |                                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueCatalogerWithEmptyDataSourceAndCredential')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*     | ida/empty.json                                                              | 200           |                  |                                                                                       |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*    |                                                                                            | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueCatalogerWithEmptyDataSourceAndCredential')].status |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSGlueCataloger on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSGlueCataloger on LocalNode has failed:" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis AWSGlueDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSGlueDataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "AWSGlueEmptyDataSource" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Analysis |
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "cataloger" item from search results
#    And user click on Analysis log link in DATA widget section
#    Then user "verify analysis log contains" presence of "java.lang.IllegalArgumentException: accessKey" in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/AWSGlueEmptyDataSource"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#
#    ####
#  @MLP-15788 @webtest
#  Scenario: SC32#-Verify the Analysis failed notification displayed in IDC UI when Datasource Plugin is Started with Empty Credentials in Datasource
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                   | body                                                                              | response code | response message | jsonPath                                                               |
#      | application/json | raw   | false | Post         | settings/catalogs                                                     | ida/amazonGluePayloads/catalogs/CreateAWSGlueEmptyCredential.json                 | 204           |                  |                                                                        |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueDataSource                                  | ida/amazonGluePayloads/DataSource/AmazonGlueEmptyCredentialsDataSourceConfig.json | 204           |                  |                                                                        |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueDataSource                                  |                                                                                   | 200           |                  | AWSGlueEmptyCredentialsDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueEmptyCredentialsDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSGlueDataSource/*  | ida/empty.json                                                     | 200           |                  |                                                                        |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                                   | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueEmptyCredentialsDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSGlueDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSGlueDataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/AWSGlueEmptyDataSource"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#      ####
#  @MLP-15788 @webtest
#  Scenario: SC34#-Verify the Analysis failed notification displayed in IDC UI when AWSGlueDatasource Plugin is Started with No Region(Region will be null in Json)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                   | body                                                                          | response code | response message | jsonPath                                                           |
#      | application/json | raw   | false | Post         | settings/catalogs                                                     | ida/amazonGluePayloads/catalogs/CreateAWSGlueRegionNullCatalog.json           | 204           |                  |                                                                    |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueDataSource                                  | ida/amazonGluePayloads/DataSource/AmazonGlueDataSourceWithNoRegionConfig.json | 204           |                  |                                                                    |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueDataSource                                  |                                                                               | 200           |                  | AWSGlueDataSourceWithNoRegion                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueDataSourceWithNoRegion')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSGlueDataSource/*  | ida/amazonGluePayloads/empty.json                                             | 200           |                  |                                                                    |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueDataSourceWithNoRegion')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSGlueDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSGlueDataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/GlueNullRegionCatalog"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#####
#  @MLP-15788 @webtest
#  Scenario: SC35#-Verify the AWSGlueCataloger does not collect any items when an Datasource(with No Region) and Valid Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                   | body                                                                                               | response code | response message | jsonPath                                                                                   |
#      | application/json | raw   | false | Post         | settings/catalogs                                                     | ida/amazonGluePayloads/catalogs/CreateAWSGlueRegionNullCatalog.json                                | 204           |                  |                                                                                            |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueCataloger                                   | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigWithNoRegionDataSourceValidCredential.json | 204           |                  |                                                                                            |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                   |                                                                                                    | 200           |                  | AWSGlueCatalogerWithNoRegionDataSourceValidCredential                                      |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueDataSource                                  | ida/amazonGluePayloads/DataSource/AmazonGlueDataSourceWithNoRegionConfig.json                      | 204           |                  |                                                                                            |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueDataSource                                  |                                                                                                    | 200           |                  | AWSGlueDataSourceWithNoRegion                                                              |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueDataSourceWithNoRegion')].status                         |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSGlueDataSource/*  | ida/empty.json                                                                      | 200           |                  |                                                                                            |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueDataSourceWithNoRegion')].status                         |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*    |                                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueCatalogerWithNoRegionDataSourceValidCredential')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*     | ida/empty.json                                                                      | 200           |                  |                                                                                            |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/*    |                                                                                                    | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueCatalogerWithNoRegionDataSourceValidCredential')].status |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSGlueCataloger on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSGlueCataloger on LocalNode has failed:" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis AWSGlueDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSGlueDataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "GlueNullRegionCatalog" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Analysis |
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "cataloger" item from search results
#    And user click on Analysis log link in DATA widget section
#    Then user "verify analysis log contains" presence of "java.lang.IllegalArgumentException: region" in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/GlueNullRegionCatalog"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#    ####
#  @MLP-15788 @webtest
#  Scenario: SC36#-Verify the Analysis failed notification displayed in IDC UI when Datasource Plugin is Started without Credentials in Datasource (Credentials will be null in Json)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                   | body                                                                                | response code | response message | jsonPath                                                                |
#      | application/json | raw   | false | Post         | settings/catalogs                                                     | ida/amazonGluePayloads/catalogs/CreateAWSGlueCredentialNullCatalog.json             | 204           |                  |                                                                         |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueDataSource                                  | ida/amazonGluePayloads/DataSource/AmazonGlueDataSourceWithNullCredentialConfig.json | 204           |                  |                                                                         |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueDataSource                                  |                                                                                     | 200           |                  | AWGlueDataSourceWithNullCredential                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AWGlueDataSourceWithNullCredential')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/AWSGlueDataSource/*  | ida/amazonGluePayloads/empty.json                                                   | 200           |                  |                                                                         |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/AWSGlueDataSource/* |                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='AWGlueDataSourceWithNullCredential')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSGlueDataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis AWSGlueDataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/GlueNullCredentialCatalog"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#
#    ####
#  @MLP-14874 @webtest
#  Scenario: SC37#-Verify the AWSGlueCataloger does not collect any items when Datasource or Credential value in null in Json
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                                                                | body                                                                                   | response code | response message | jsonPath                                                                               |
#      | application/json | raw   | false | Post         | settings/catalogs                                                                                                  | ida/amazonGluePayloads/catalogs/CreateAWSGlueDataSourceOrCredentialNull.json           | 204           |                  |                                                                                        |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueDataSource                                                                               | ida/amazonGluePayloads/DataSource/AmazonGlueDataSourceConfigNullDSOrCredential.json    | 204           |                  |                                                                                        |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueDataSource                                                                               |                                                                                        | 200           |                  | AWSGlueValidDSCredentialOrDSNullInPlugin                                               |
#      |                  |       |       | Put          | settings/analyzers/AWSGlueCataloger                                                                                | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigWithNullDSValidCredential.json | 204           |                  |                                                                                        |
#      |                  |       |       | Get          | settings/analyzers/AWSGlueCataloger                                                                                |                                                                                        | 200           |                  | AWSGlueCatalogerWithNullDataSourceValidCredential                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/AWSGlueCatalogerWithNullDataSourceValidCredential |                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueCatalogerWithNullDataSourceValidCredential')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/AWSGlueCatalogerWithNullDataSourceValidCredential  | ida/amazonGluePayloads/empty.json                                                      | 200           |                  |                                                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/AWSGlueCatalogerWithNullDataSourceValidCredential |                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueCatalogerWithNullDataSourceValidCredential')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSGlueCataloger on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Invalid data source configuration name: null" in the notifications tab
##    And user select "All" catalog and search "GlueDSOrCredentialNullCatalog" items at top end
##    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
##      | Analysis |
##    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
##    And user performs "dynamic item click" on "cataloger" item from search results
##    And user click on Analysis log link in DATA widget section
##    Then user "verify analysis log contains" presence of "Invalid data source configuration name: null" in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/GlueDSOrCredentialNullCatalog"
#    Then Status code 204 must be returned
#    Then Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                | body                                                                                   | response code | response message | jsonPath                                                                       |
#      |        | raw   | false | Post         | settings/catalogs                                                  | ida/amazonGluePayloads/catalogs/CreateAWSGlueDataSourceOrCredentialNull.json           | 204           |                  |                                                                                |
#      |        |       |       | Put          | settings/analyzers/AWSGlueDataSource                               | ida/amazonGluePayloads/DataSource/AmazonGlueDataSourceConfigNullDSOrCredential.json    | 204           |                  |                                                                                |
#      |        |       |       | Get          | settings/analyzers/AWSGlueDataSource                               |                                                                                        | 200           |                  | AWSGlueValidDSCredentialOrDSNullInPlugin                                       |
#      |        |       |       | Put          | settings/analyzers/AWSGlueCataloger                                | ida/amazonGluePayloads/PluginConfiguration/AWSGlueConfigWithValidDSNullCredential.json | 204           |                  |                                                                                |
#      |        |       |       | Get          | settings/analyzers/AWSGlueCataloger                                |                                                                                        | 200           |                  | AWSGlueCatalogerWithValidDSNullCredential                                      |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueCatalogerWithValidDSNullCredential')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/*  | ida/amazonGluePayloads/empty.json                                                      | 200           |                  |                                                                                |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/* |                                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AWSGlueCatalogerWithValidDSNullCredential')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis AWSGlueCataloger on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Invalid data source configuration name: null" in the notifications tab
##    And user select "All" catalog and search "GlueDSOrCredentialNullCatalog" items at top end
##    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
##      | Analysis |
##    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
##    And user performs "dynamic item click" on "cataloger" item from search results
##    And user click on Analysis log link in DATA widget section
##    Then user "verify analysis log contains" presence of "Invalid data source configuration name: AWSGlueValidDataSource" in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/GlueDSOrCredentialNullCatalog"
#    Then Status code 204 must be returned

#############Notification scenarios below -End ##################################

  @MLP-14874 @webtest
  Scenario: Verify whether the background of the panel is displayed in red when test connection is not successful for GlueDataSource in LocalNode for disabled/unsupported region
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute         |
      | Data Source Type | AWSGlueDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute              |
      | Name*     | AWSGlueDataSourceTest3 |
      | Label     | AWSGlueDataSourceTest3 |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute                        |
      | Region*     | China (Ningxia) [cn-northwest-1] |
      | Credential* | ValidGlueCredentials             |
      | Node        | LocalNode                        |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Error retrieving bucket list" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute                              |
      | Region*   | AWS GovCloud (US-East) [us-gov-east-1] |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Error retrieving bucket list" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"

######################Delete Scenarios ##########################################################

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario: SC1#MLP_14320:Delete table in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action      | databaseName     | tableName     |
      | deleteTable | gluetestdatabase | gluetesttable |
    And user connects to AWS Glue database and perform the following operation
      | action      | databaseName     | tableName |
      | deleteTable | gluetestdatabase | store     |
    And user connects to AWS Glue database and perform the following operation
      | action      | databaseName | tableName |
      | deleteTable | testdatabase | samples   |

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario: SC1#MLP_14320:Delete Job in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action    | jobName        |
      | deleteJob | PythonTestJob1 |
    And user connects to AWS Glue database and perform the following operation
      | action    | jobName   |
      | deleteJob | QATestJob |

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario: SC1#MLP_14320:Delete UDF in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                        |
      | deleteUDF | ida/amazonGluePayloads/TestData/createUDF1.json |
    And user connects to AWS Glue database and perform the following operation
      | action    | jsonPath                                        |
      | deleteUDF | ida/amazonGluePayloads/TestData/createUDF2.json |

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario: SC1#MLP_14320:Delete Connection in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action           | connectionName         |
      | deleteConnection | DatabaseTestConnection |
    And user connects to AWS Glue database and perform the following operation
      | action           | connectionName       |
      | deleteConnection | RedshiftconnectionQA |
    And user connects to AWS Glue database and perform the following operation
      | action           | connectionName     |
      | deleteConnection | TestJDBCConnection |

  @sanity @positive @MLP-14320 @IDA-10.3
  Scenario: SC1#MLP_14320:Delete Database in Glue DB using AWSGlueUtil
    Given user connects to AWS Glue database and perform the following operation
      | action         | databaseName     |
      | deleteDatabase | gluetestdatabase |
    And user connects to AWS Glue database and perform the following operation
      | action         | databaseName |
      | deleteDatabase | testdatabase |

  @cr-data @sanity @positive
  Scenario Outline: SC1#-Delete the Credentials for AWSGlueDatasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                         | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSGlueCataloger                         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/AWSGlueDataSource                        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidGlueCredentials                   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/InvalidGlueCredentials                 |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptyGlueCredentials                   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/InvalidGlueCredentialsInvalidSecretKey |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get    | settings/credentials/ValidGlueCredentials                   |      | 404           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get    | settings/credentials/InvalidGlueCredentials                 |      | 404           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get    | settings/credentials/EmptyGlueCredentials                   |      | 404           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get    | settings/credentials/InvalidGlueCredentialsInvalidSecretKey |      | 404           |                  |          |
