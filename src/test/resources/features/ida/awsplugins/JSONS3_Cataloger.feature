@MLP-14875
Feature:DataSource Implementation for AWS S3 JSON Cataloger

  @aws @precondition
  Scenario: Update AWS secret key and access from config file
    Given User update the below "S3 Readonly credentials" in following files using json path
      | filePath                                                      | accessKeyPath | secretKeyPath |
      | ida/s3JsonPayloads/Credentials/awsJSONS3ValidCredentials.json | $..accessKey  | $..secretKey  |

  @jdbc @cr-data
  Scenario Outline: SC1#-Set the Credentials for Json S3 Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                           | body                                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidJSONCredentials     | ida/s3JsonPayloads/Credentials/awsJSONS3ValidCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/IncorrectJSONCredentials | ida/s3JsonPayloads/Credentials/awsJSONS3InValidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EmptyJSONCredentials     | ida/s3JsonPayloads/Credentials/awsJSONS3EmptyCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidJSONCredentials     |                                                                 | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/IncorrectJSONCredentials |                                                                 | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EmptyJSONCredentials     |                                                                 | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials   | idc/EdiBusPayloads/credentials/EDIBusValidCredentials.json      | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusValidCredentials   |                                                                 | 200           |                  |          |


  #QAC-7078866
  @MLP-14629 @webtest
  Scenario: SC1_1#-Verify whether the background of the panel is displayed in green when test connection is successful for JsonS3DataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source" button in Manage Data Sources
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute        |
      | Data Source Type | JsonS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute            |
      | Name*     | JsonS3DataSourceTest |
      | Label     | JsonS3DataSourceTest |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute                         |
      | Region      | US East (N. Virginia) [us-east-1] |
      | Credential* | ValidJSONCredentials              |
      | Node        | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "click" on "Save" button in "Add Data Sources Page"

  @MLP-14629 @webtest
  Scenario: SC1_2#-Verify whether the background of the panel is displayed in green when test connection is successful for JsonS3DataSource in GoogleCloud Node
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source" button in Manage Data Sources
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute        |
      | Data Source Type | JsonS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute             |
      | Name*     | JsonS3DataSourceTest2 |
      | Label     | JsonS3DataSourceTest2 |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute                         |
      | Region      | US East (N. Virginia) [us-east-1] |
      | Credential* | ValidJSONCredentials              |
      | Node        | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "click" on "Save" button in "Add Data Sources Page"


  @MLP-14629 @webtest
  Scenario: SC#1_3-Verify whether the background of the panel is displayed in red when test connection is not successful for JsonS3DataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source" button in Manage Data Sources
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute        |
      | Data Source Type | JsonS3DataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute            |
      | Name*     | AutoQADataSourceTest |
      | Label     | AutoQADataSourceTest |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute                         |
      | Region      | US East (N. Virginia) [us-east-1] |
      | Credential* | IncorrectJSONCredentials          |
      | Node        | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute            |
      | Credential* | EmptyJSONCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"


  @cr-data
  Scenario: SC1#-Set the Json S3 Datasource
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                 | body                                                                 | response code | response message | jsonPath                    |
      | application/json | raw   | false | Put  | settings/analyzers/JsonS3DataSource | ida/s3JsonPayloads/DataSource/AmazonJSONS3ValidDataSourceConfig.json | 204           |                  |                             |
      |                  |       |       | Get  | settings/analyzers/JsonS3DataSource |                                                                      | 200           |                  | AmazonJSONS3ValidDataSource |

  @aws
  Scenario: MLP-8710:SC1#Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgqajsontestautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName              | keyPrefix    | dirPath                      | recursive |
      | asgqajsontestautomation | AutoTestData | ida/s3JsonPayloads/TestData/ | true      |


  @sanity @positive @regression @IDA_E2E
  Scenario Outline:SC1#create BussinessApplication tag and run the plugin configuration with the new field
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/s3JsonPayloads/PluginConfiguration/BussinessApplication.json | 200           |                  |          |

  #QAC-6515949
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC1#Verify JsonS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when JsonS3Cataloger is run with region  and Bucketname with Include
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                        | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc1JsonS3Config.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                             | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                             | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                               | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                             | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And user gets amazon bucket "asgqajsontestautomation" file count in "AutoTestData/TestJSON" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC1Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC1Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page
    And user enters the search text "COLOURS.json" and clicks on search
    And user performs "facet selection" in "JsonS3SC1Tags" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet | Tag                          | fileName     | userTag       |
      | Default     | File | Type  | JSON,JsonS3SC1Tags,JSONS3_BA | COLOURS.json | JsonS3SC1Tags |
    And user performs "item click" on "COLOURS.json" item from search results
    Then user "verify presence" of following "item view section" in Item View Page
      | Fields |
    And user enters the search text "JsonS3SC1Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC1Tags" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Service   | 1     |
      | Cluster   | 1     |
      | Directory | 5     |
      | File      | 20    |
      | Field     | 25    |
    And user enters the search text "JsonS3SC1Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC1Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/JsonS3Cataloger/JsonS3Cataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | amazonaws.com |
      | AmazonS3      |
    Then Analysis log "cataloger/JsonS3Cataloger/JsonS3Cataloger/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:JsonS3Cataloger, Plugin Type:cataloger, Plugin Version:LATEST, Node Name:InternalNode, Host Name:2dd09a954f6b, Plugin Configuration name:JsonS3Cataloger                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0071 | JsonS3Cataloger | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: ---  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: name: "JsonS3Cataloger"  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: pluginVersion: "LATEST"  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: label:  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration:   : ""  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: catalogName: "Default"  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: eventClass: null  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: eventCondition: null  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: nodeCondition: "type=='internal'"  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: maxWorkSize: 1000  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: tags:  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: - "JsonS3SC1Tags"  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: pluginType: "cataloger"  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: dataSource: "AmazonJSONS3ValidDataSource"  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: credential: "ValidJSONCredentials"  2020-03-02 10:37:55.906 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: businessApplicationName: "JSONS3_BA"  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: dryRun: false  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: schedule: null  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: filter: null  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: versionMode: false  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: maxObjectsAmount: 1000  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: incremental: false  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration: bucketFilter:  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration:   mode: "INCLUDE"  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration:   patterns:  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration:   - "asgqajsontestautomation"  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration:   objectFilter:  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration:     dirFilter:  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration:       mode: "INCLUDE"  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration:       patterns:  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration:       - "*/TestJSON/*"  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration:     fileFilter:  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration:       mode: "INCLUDE"  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration:       patterns: []  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration:     dirPrefixes:  2020-03-02 10:37:55.907 INFO - ANALYSIS-0073: Plugin JsonS3Cataloger Configuration:     - "/AutoTestData" | ANALYSIS-0073 | JsonS3Cataloger |                |
      | INFO | ANALYSIS-0072: Plugin JsonS3Cataloger Start Time:2020-03-02 10:37:55.904, End Time:2020-03-02 10:38:13.745, Processed Count:2, Errors:0, Warnings:3                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0072 | JsonS3Cataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0020 |                 |                |

  #QAC- 6515967
  @sanity @positive @MLP-7660 @webtest @IDA-10.0 @MLPQA-18060 @MLPQA-18064
  Scenario: Verify the technology tags got assigned to all S3JSON catalogued items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                                    | fileName                | userTag       |
      | Default     | Directory | Metadata Type | JSON,JsonS3SC1Tags,JSONS3_BA,Amazon S3 | asgqajsontestautomation | JsonS3SC1Tags |
      | Default     | Cluster   | Metadata Type | JSON,JsonS3SC1Tags,JSONS3_BA,Amazon S3 | amazonaws.com           | JsonS3SC1Tags |
      | Default     | Field     | Metadata Type | JSON,JsonS3SC1Tags,JSONS3_BA,Amazon S3 | Field                   | JsonS3SC1Tags |
      | Default     | File      | Metadata Type | JSON,JsonS3SC1Tags,JSONS3_BA,Amazon S3 | simple.json             | JsonS3SC1Tags |
      | Default     | Service   | Metadata Type | JSON,JsonS3SC1Tags,JSONS3_BA,Amazon S3 | AmazonS3                | JsonS3SC1Tags |
    Then user "verify tag item non presence" of technology tags for the below Type and file names
      | catalogName | name    | facet         | Tag        | fileName      | userTag       |
      | Default     | Cluster | Metadata Type | Data Files | amazonaws.com | JsonS3SC1Tags |
      | Default     | Service | Metadata Type | Data Files | AmazonS3      | JsonS3SC1Tags |

  #QAC-6515968
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC1#Verify breadcrumb hierarchy appears correctly in S3Cataloger cataloged items
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC1Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC1Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "simple.json" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | amazonaws.com           |
      | AmazonS3                |
      | asgqajsontestautomation |
      | AutoTestData            |
      | TestJSON                |
      | simple.json             |


  Scenario Outline:SC1#user retrieves the total items for a catalog and copy to a json file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name         | asg_scopeid | targetFile                          | jsonpath               |
      | APPDBPOSTGRES | ID      | Default | File      | simple.json  |             | response/jsonS3/actual/itemIds.json | $..has_File.id         |
      | APPDBPOSTGRES | ID      | Default | Directory | JsonInternal |             | response/jsonS3/actual/itemIds.json | $..has_SubDirectory.id |
      | APPDBPOSTGRES | ID      | Default | Directory | AutoTestData |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id    |

  Scenario Outline: SC1#validate the total count and facets count for a catalog
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                            | response code | response message | filePath                                   | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Get  | searches/fulltext/Default?query=JsonS3SC1Tags&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0     |                                                 | 200           |                  | response/jsonS3/actual/catalogItems.json   |          |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | response/jsonS3/body/getFacetsCountRequest.json | 200           |                  | response/jsonS3/actual/facetWiseCount.json |          |


  Scenario Outline:SC1#user retrieves the metadata of each datat type for a catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                 | responseCode | inputJson              | inputFile                           | outPutFile                                 | outPutJson |
      | components/Default/item/Default.File:::dynamic      | 200          | $..has_File.id         | response/jsonS3/actual/itemIds.json | response/jsonS3/actual/fileMetadata.json   |            |
      | components/Default/item/Default.Directory:::dynamic | 200          | $..has_SubDirectory.id | response/jsonS3/actual/itemIds.json | response/jsonS3/actual/subdirMetadata.json |            |
      | components/Default/item/Default.Directory:::dynamic | 200          | $..has_Directory.id    | response/jsonS3/actual/itemIds.json | response/jsonS3/actual/dirMetadata.json    |            |

  #QAC-6515964
  Scenario Outline: Validate the catalogued count and File Directory/sub directory level metadata appears correctly in IDC
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                       | actualValues                               | valueType         | expectedJsonPath                        | actualJsonPath                                                           |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/catalogItems.json   | intCompare        | $..totalCount                           | $..count                                                                 |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/facetWiseCount.json | intListCompare    | $..MetaData.facetCounts.type_s..count   | $.facetCounts..type_s..count                                             |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/fileMetadata.json   | intCompare        | $..fileMetaData..fileSize               | $..[?(@.caption=='Description')]..[?(@.caption=='File size')].data.value |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/fileMetadata.json   | stringListCompare | $..fileMetaData..taglist..techTag       | $..[?(@.caption=='Tags')].data..name                                     |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/fileMetadata.json   | stringCompare     | $..fileMetaData..location               | $..[?(@.caption=='Description')]..[?(@.caption=='Location')].data.value  |
#      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/fileMetadata.json   | stringCompare     | $..fileMetaData..technicalData..values.storageClass               | $..[?(@.caption=='Technical Data')]..value.storageClass                  |
#      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/fileMetadata.json   | stringCompare     | $..fileMetaData..technicalData..values.key                        | $..[?(@.caption=='Technical Data')]..value.key                           |
#      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/fileMetadata.json   | stringCompare     | $..fileMetaData..technicalData..values.rawMetaData.Content-Length | $..[?(@.caption=='Technical Data')]..value.rawMetaData.Content-Length    |
#      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/fileMetadata.json   | stringCompare     | $..fileMetaData..technicalData..values.rawMetaData.Content-Type   | $..[?(@.caption=='Technical Data')]..value.rawMetaData.Content-Type      |
#      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/fileMetadata.json   | stringCompare     | $..fileMetaData..technicalData..values.rawMetaData.Accept-Ranges  | $..[?(@.caption=='Technical Data')]..value.rawMetaData.Accept-Ranges     |
#      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/fileMetadata.json   | stringCompare     | $..fileMetaData..technicalData..values.acl.grantee.displayName    | $..[?(@.caption=='Technical Data')]..value.acl.grantee.displayName       |
#      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/fileMetadata.json   | stringCompare     | $..fileMetaData..technicalData..values.acl.grantee.typeIdentifier | $..[?(@.caption=='Technical Data')]..value.acl.grantee.typeIdentifier    |
#      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/fileMetadata.json   | stringCompare     | $..fileMetaData..technicalData..values.acl.permission             | $..[?(@.caption=='Technical Data')]..value.acl.permission                |
#      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/fileMetadata.json   | stringCompare     | $..fileMetaData..technicalData..values.url                        | $..[?(@.caption=='Technical Data')]..value.url                           |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/subdirMetadata.json | intCompare        | $..subdirectoryMetaData..directorySize  | $..[?(@.caption=='Directory size')]..value                               |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/subdirMetadata.json | intCompare        | $..subdirectoryMetaData..numberOfFiles  | $..[?(@.caption=='Number of files')]..value                              |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/subdirMetadata.json | intCompare        | $..subdirectoryMetaData..sizeOfFiles    | $..[?(@.caption=='Size of files')]..value                                |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/subdirMetadata.json | intCompare        | $..subdirectoryMetaData..numberOfSubDir | $..[?(@.caption=='Number of sub-directories')]..value                    |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/subdirMetadata.json | intCompare        | $..subdirectoryMetaData..sizeOfSubDir   | $..[?(@.caption=='Size of sub-directories')]..value                      |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/subdirMetadata.json | stringCompare     | $..subdirectoryMetaData..location       | $..[?(@.caption=='Location')]..value                                     |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/dirMetadata.json    | intCompare        | $..directoryMetaData..directorySize     | $..[?(@.caption=='Directory size')]..value                               |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/dirMetadata.json    | intCompare        | $..directoryMetaData..numberOfFiles     | $..[?(@.caption=='Number of files')]..value                              |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/dirMetadata.json    | intCompare        | $..directoryMetaData..sizeOfFiles       | $..[?(@.caption=='Size of files')]..value                                |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/dirMetadata.json    | intCompare        | $..directoryMetaData..numberOfSubDir    | $..[?(@.caption=='Number of sub-directories')]..value                    |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/dirMetadata.json    | intCompare        | $..directoryMetaData..sizeOfSubDir      | $..[?(@.caption=='Size of sub-directories')]..value                      |
      | response/jsonS3/expected/jsonS3ExpectedJsonData.json | response/jsonS3/actual/dirMetadata.json    | stringCompare     | $..directoryMetaData..location          | $..[?(@.caption=='Location')]..value                                     |

  #QAC-6515963
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC1#Verify Bucket level metadata appears correctly in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC1Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC1Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "asgqajsontestautomation" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue            | widgetName  |
      | Directory size            | 0                        | Statistics  |
      | Number of files           | 0                        | Statistics  |
      | Size of files             | 0                        | Statistics  |
      | Location                  | asgqajsontestautomation/ | Description |
      | Number of sub-directories | 1                        | Statistics  |
      | Size of sub-directories   | 0                        | Statistics  |
#    And user copy metadata value from Item View Page and write to file using below parameters
#      | itemName       | asgqajsontestautomation                    |
#      | attributeName  | Technical Data                             |
#      | actualFilePath | ida/s3JsonPayloads/actualBuckTechData.json |
#    Then file content in "ida/s3JsonPayloads/expectedBuckTechData.json" should be same as the content in "ida/s3JsonPayloads/actualBuckTechData.json"

#  ##6549303
#  @sanity @positive @webtest @edibus
#  Scenario:MLP-9043_Verify the Json S3 items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "JsonS3SC1Tags" and clicks on search
#    And user performs "facet selection" in "JsonS3SC1Tags" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "JSON" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | File      |
#      | Directory |
#      | Analysis  |
#      | Cluster   |
#      | Service   |
#      | Field     |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/EDIBusJSONConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                             | body                                               | response code | response message | jsonPath                                        |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                             | idc/EdiBusPayloads/datasource/EDIBusDS_Jsons3.json | 204           |                  |                                                 |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/EDIBusJSONConfig.json           | 204           |                  |                                                 |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJSON |                                                    | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJSON')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusJSON  |                                                    | 200           |                  |                                                 |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusJSON |                                                    | 200           | IDLE             | $.[?(@.configurationName=='EDIBusJSON')].status |
#    And user enters the search text "EDIBusJSON" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusJSON%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "JsonS3SC1Tags" and clicks on search
#    And user performs "facet selection" in "JsonS3SC1Tags" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "JSON" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                 |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                 |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/JSON |
#      | $..selections.['type_s'][*]                   | File                                       |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                          | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=JsonS3SC1Tags&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) |
#    And user enters the search text "JsonS3SC1Tags" and clicks on search
#    And user performs "facet selection" in "JsonS3SC1Tags" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "JSON" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                 |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/Data Files/JSON |
#      | $..selections.['type_s'][*]                   | Directory                                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                          | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=JsonS3SC1Tags&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_DIRECTORY ) |
#    And user enters the search text "JsonS3SC1Tags" and clicks on search
#    And user performs "facet selection" in "JsonS3SC1Tags" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "JSON" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                        |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE_SYSTEM) |
#    And user enters the search text "JsonS3SC1Tags" and clicks on search
#    And user performs "facet selection" in "JsonS3SC1Tags" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "JSON" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Field" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FIELD ) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @*JSON≫DEFAULT≫DWR_DAT_FILE≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @*JSON≫DEFAULT≫DWR_DAT_DIRECTORY≫@* ),AND,( TYPE = DWR_IDC )   |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @*JSON≫DEFAULT≫DWR_DAT_FILE_SYSTEM≫@* ),AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | S3JSON      | 1.0                | (XNAME * *  ~/ @*JSON≫DEFAULT≫DWR_DAT_FIELD≫@* ),AND,( TYPE = DWR_IDC )       |


  Scenario Outline:SC1# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC1#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC1#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

#  Scenario Outline:SC1# user retrieves ID for Analysis type EDIBus
#    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
#    Examples:
#      | database      | catalog | name                            | type | targetFile                          | jsonpath           |
#      | APPDBPOSTGRES | Default | cataloger/EDIBus/EDIBusJSON%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |
#
#  Scenario Outline:SC1#Delete EDIBusAnalysis item
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
#    Examples:
#      | url                                      | responseCode | inputJson          | inputFile                           |
#      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/jsonS3/actual/itemIds.json |

  #QAC-6518913
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC2#Verify JsonS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when JsonS3Cataloger is run with region and Bucketname(Include)/Directory/File(include)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                   | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/S3JsonPayloads/PluginConfiguration/sc2JsonS3ConfigFileInclude.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                        | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                          | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC2Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC2Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | simple.json |


  Scenario Outline:SC2# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC2#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC2#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  #QAC-6518914
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC3#Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region and Bucketname(Include)/Directory/File(Exclude)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                   | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc3JsonS3ConfigFileExclude.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                        | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                          | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC3Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC3Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | simple.json |

  Scenario Outline:SC3# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC3#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC3#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  #QAC-7078860
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC4#Verify JsonS3Cataloger collects Analysis item when JsonS3Cataloger is run with region, incorrect Access Key, Secret Key
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                          | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc4JsonS3ConfigInCorrectAccessKey.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                               | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                                 | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC4Tags" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/JsonS3Cataloger/JsonS3Cataloger%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/JsonS3Cataloger/JsonS3Cataloger/%" should display below info/error/warning
      | type  | logValue                     | logCode     |
      | ERROR | Error retrieving bucket list | AWS_S3-0006 |

  Scenario Outline:SC4# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC4#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                           |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/jsonS3/actual/itemIds.json |

  #QAC-6518815
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC5#Verify JsonS3Cataloger doesn't collects fields of invalid json files available in S3
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                   | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc5JsonS3ConfigInvalidJson.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                        | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                          | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC5Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC5Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Item Value" in Item Search Results Page
      | InvalidJson.json |


  Scenario Outline:SC5# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC5#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC5#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  #QAC-6515950
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC6#Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname with Exclude
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                     | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/S3JsonPayloads/PluginConfiguration/sc6JsonS3ConfigBucketExclude.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                          | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                            | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC6Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC6Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | asgcoms3bucket |


  Scenario Outline:SC6# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC6#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC6#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  #QAC-6515951
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC7#Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname(Include) and Directory(Include)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                     | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc7JsonS3ConfigSubDirInclude.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                          | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                            | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And user gets amazon bucket "asgqajsontestautomation" file count in "AutoTestData/TestJSON/JsonInternal" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC7Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC7Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page


  Scenario Outline:SC7# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC7#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC7#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  #QAC-6515957
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC8#Verify S3 JSON Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname(Include)/Directory/Sub Directory(Include)/File(*)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                       | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc8JsonS3ConfigFileInludeRegex.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                            | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                              | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC8Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC8Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | objectArray.json |
    And user enters the search text "Default" and clicks on search
    And user performs "facet selection" in "JsonS3SC8Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | TestJSON |


  Scenario Outline:SC8# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC8#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC8#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  #QAC-6515953
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC9#Verify S3Cataloger collects Cluster,Service,Analysis,Directory,File when S3Cataloger is run with region  and Bucketname(Include)/Directory/Sub Directory(Exclude)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                     | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc9JsonS3ConfigSubDirExclude.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                          | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                            | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC9Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC9Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | JsonInternal |

  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC9_2#Verify JsonS3Cataloger doesnt collects the excluded files
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC9Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC9Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | CNavigatorSubDirectory.json |
      | subdirfile.json             |

  Scenario Outline:SC9# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC9#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC9#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  #QAC-6515954
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC10#Verify JsonS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when JsonS3Cataloger is run with region  and Bucketname(Include)/Directory/Sub Directory(Include)/File(include)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                                 | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc10JsonS3ConfigSubDirIncludeFileInclude.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                                      | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                                        | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC10Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC10Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | subdirfile.json |
    And user enters the search text "JsonS3SC10Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC10Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | JsonInternal |


  Scenario Outline:SC10# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC10#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC10#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  #QAC-6515955
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC11#Verify JsonS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when JsonS3Cataloger is run with region and Bucketname(Include)/Directory/Sub Directory(Include)/File(exclude)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                                 | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc11JsonS3ConfigSubDirIncludeFileExclude.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                                      | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                                        | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC11Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC11Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | JsonInternal |
    And user enters the search text "JsonS3SC11Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC11Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Items List" in Search Results Page
      | subdirfile.json |


  Scenario Outline:SC11# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC11#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC11#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  #QAC-6515956
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC12#Verify JsonS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when JsonS3Cataloger is run with region and Bucketname with wild card character(*)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                       | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc12JsonS3ConfigBucketWildCard.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                            | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                              | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC12Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC12Tags" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | File      |
      | Directory |
      | Analysis  |
      | Cluster   |
      | Service   |
      | Field     |
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | asgqajsontestautomation |

  Scenario Outline:SC12# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC12#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC12#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  #QAC-7078847
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario:SC13#Verify JsonS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when JsonS3Cataloger is run with region and Bucketname(Include)/Directory(Name with / and *)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                         | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc13JsonS3ConfigDirWithSlashStar.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                              | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                                | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And user gets amazon bucket "asgqajsontestautomation" file count in "AutoTestData/TestJSON/JsonInternal" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC13Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC13Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page


  Scenario Outline:SC13# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC13#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC13#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  #QAC-6515958
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario:SC14#Verify JsonS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when JsonS3Cataloger is run with region  and Bucketname(Include)/Directory/Sub Directory(Name with / and *)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                           | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/s14JsonS3ConfigSubDirWithSlashStar.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                                | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                                  | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And user gets amazon bucket "asgqajsontestautomation" file count in "AutoTestData/TestJSON/JsonInternal" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC14Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC14Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page


  Scenario Outline:SC14# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC14#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC14#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |


  @aws
  Scenario:SC15#Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqajsontestautomation"
    Then user "Delete" a bucket "asgqajsontestautomation" in amazon storage service

  #QAC-6515960,6516838
  @webtest
  Scenario: MLP-8710:SC16#Verify incremental scan works properly with JsonS3Cataloger
    Given user "Create" a bucket "asgqajsontestautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName              | keyPrefix             | dirPath                              | recursive |
      | asgqajsontestautomation | AutoTestData/TestJson | ida/S3JsonPayloads/TestData/TestJson | true      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                         | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc16JsonS3ConfigIncrementalFalse.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                              | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                                | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And user gets amazon bucket "asgqajsontestautomation" file count in "AutoTestData" directory and store in temp variable
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC16Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC16Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName              | keyPrefix                | dirPath                                 | recursive |
      | asgqajsontestautomation | AutoTestData/Incremental | ida/s3JsonPayloads/TestData/Incremental | false     |
    And user gets amazon bucket "asgqajsontestautomation" file count in "AutoTestData" directory and store in temp variable
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                  | body                                                                    | response code | response message | jsonPath                                             |
      |        |       |       | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc16JsonS3ConfigIncremental.json | 204           |                  |                                                      |
      |        |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                         | 200           |                  | JsonS3Cataloger                                      |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                           | 200           |                  |                                                      |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And user enters the search text "JsonS3SC16Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC16Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And results panel "file count" should be displayed as "tempStoredValue" in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | incremental.json |

  Scenario Outline:SC16# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC16#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC16#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  Scenario Outline:SC16_1# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC16_1#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                           |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/jsonS3/actual/itemIds.json |

  #QAC-6516841
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC18#Verify JsonS3Cataloger doesn't collects fields of json files which has file size more than 10MB
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                       | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc18JsonS3ConfigSizeMoreThan10.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                            | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                              | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC18Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC18Tags" attribute under "Tags" facets in Item Search results page
    Then user verify "verify non presence" with following values under "Metadata Type" section in item search results page
      | Field |
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Item Value" in Item Search Results Page
      | citylots.json |


  Scenario Outline:SC18# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC18#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC18#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  @aws
  Scenario:SC18_2#Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqajsontestautomation"
    Then user "Delete" a bucket "asgqajsontestautomation" in amazon storage service

  #QAC-6515969
  @webtest @MLP-8710 @positive @regression @pluginManager
  Scenario: MLP-8710 SC19# Verify proper error message is shown if mandatory fields are not filled in JsonS3Cataloger configuration page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | Cataloger       |
      | Plugin    | JsonS3Cataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"

  #QAC-6515961
  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710-SC#20 Verify file versions are collected correctly when scan mode is set as versions in JsonS3Cataloger
    Given user "Create" a bucket "asgqajsontestautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName              | keyPrefix    | dirPath                      | recursive |
      | asgqajsontestautomation | AutoTestData | ida/S3JsonPayloads/TestData/ | true      |
    And user performs "version option enable" in amazon storage service with below parameters
      | bucketName              | status  |
      | asgqajsontestautomation | Enabled |
    And user performs "single upload" in amazon storage service with below parameters
      | bucketName              | keyPrefix                                      | dirPath                                                       |
      | asgqajsontestautomation | AutoTestData/TestJSON/version/baseversion.json | ida/s3JsonPayloads/TestData/TestJSON/version/baseversion.json |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc20JsonS3ConfigVersion.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                     | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                       | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC20Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC20Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestJSON/version/" in bucket "asgqajsontestautomation" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page


  Scenario Outline:SC20# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC20#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC20#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  @aws
  Scenario:SC21#Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "AutoTestData" in bucket "asgqajsontestautomation"
    Then user "Delete" a bucket "asgqajsontestautomation" in amazon storage service

  #QAC-6515961
  @MLP-8708 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-7847_SC22# Verify file versions are collected correctly when scan mode is set as versions in AmazonS3Cataloger and Incremental collection is ON
    Given user "Create" a bucket "asgqajsontestautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName              | keyPrefix    | dirPath                      | recursive |
      | asgqajsontestautomation | AutoTestData | ida/s3JsonPayloads/TestData/ | true      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                    | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc22JsonS3ConfigVersionIncr.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                         | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                           | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And user performs "version option enable" in amazon storage service with below parameters
      | bucketName              | status  |
      | asgqajsontestautomation | Enabled |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC22Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC22Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestJSON/version/" in bucket "asgqajsontestautomation" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page
    And user performs "version option enable" in amazon storage service with below parameters
      | bucketName              | status  |
      | asgqajsontestautomation | Enabled |
    And user performs "single upload" in amazon storage service with below parameters
      | bucketName              | keyPrefix                                      | dirPath                                                       |
      | asgqajsontestautomation | AutoTestData/TestJSON/version/baseversion.json | ida/s3JsonPayloads/TestData/TestJSON/version/baseversion.json |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                  | body                          | response code | response message | jsonPath                                             |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                               | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |        |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json | 200           |                  |                                                      |
      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                               | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And user enters the search text "JsonS3SC22Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC22Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "version [Directory]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user get objects list from "AutoTestData/TestJSON/version/" in bucket "asgqajsontestautomation" with maximum count of "50"
    Then results panel "file count" should be displayed as "tempStoredValue" in Item Search results page


  Scenario Outline:SC22# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC22#user retrieves the bucket ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type      | name                    | asg_scopeid | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | ID      | Default | Directory | asgqajsontestautomation |             | response/jsonS3/actual/itemIds.json | $..has_Directory.id |

  Scenario Outline:SC22#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |

  Scenario Outline:SC22_1# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC22_1#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                           |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/jsonS3/actual/itemIds.json |


  @aws
  Scenario:SC23#Delete the version bucket in Amazon S3 storage
    Given user "Delete Version" objects in amazon directory "AutoTestData" in bucket "asgqajsontestautomation"
    Then user "Delete" a bucket "asgqajsontestautomation" in amazon storage service

  ##QAC-7078869
  @MLP-14875 @webtest @positive @regression @pluginManager
  Scenario: SC24# Verify if all the mandatory fields (Name) are throwing with proper error message if they are left blank in Json S3 Datasource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source" button in Manage Data Sources
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute        |
      | Data Source Type | JsonS3DataSource |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"

  @aws
  Scenario: SC25#Create a bucket and folder with various file formats in S3 Amazon storage
    Given user "Create" a bucket "asgqajsontestautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName              | keyPrefix    | dirPath                      | recursive |
      | asgqajsontestautomation | AutoTestData | ida/s3JsonPayloads/TestData/ | true      |

  ####
#  @MLP-14875 @webtest
#  Scenario: SC26#-Verify the Analysis succeeded notification displayed in IDC UI when the analysis plugin executed without any errors - Valid jSON S3 DataSource
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                     | body                                                                 | response code | response message | jsonPath                                                         |
#      | application/json | raw   | false | Post         | settings/catalogs                                                       | ida/s3JsonPayloads/catalogs/CreateS3CatalogSC1.json                  | 204           |                  |                                                                  |
#      |                  |       |       | Put          | settings/analyzers/JsonS3DataSource                                     | ida/s3JsonPayloads/DataSource/AmazonJSONS3ValidDataSourceConfig.json | 204           |                  |                                                                  |
#      |                  |       |       | Get          | settings/analyzers/JsonS3DataSource                                     |                                                                      | 200           |                  | AmazonJSONS3ValidDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/datasource/JsonS3DataSource/* |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3ValidDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/InternalNode/datasource/JsonS3DataSource/*  | ida/s3JsonPayloads/empty.json                                        | 200           |                  |                                                                  |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/InternalNode/datasource/JsonS3DataSource/* |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3ValidDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis JsonS3DataSource on InternalNode has started" in the notifications tab
#    And "Analysis succeeded!" notification should have content "Analysis JsonS3DataSource on InternalNode has succeeded" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3JsonATSC1"
#    Then Status code 204 must be returned
#    And user clicks on logout button

  @MLP-14629 @webtest
  Scenario: SC27#-Verify captions and tool tip text in JsonS3DataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source" button in Manage Data Sources
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute        |
      | Data Source Type | JsonS3DataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name*       | Plugin configuration name                                                             |
      | Label       | Plugin configuration extended label and description                                   |
      | Credential* | Credential to be used                                                                 |
      | Region      | Geographic area where the JSON resources are available in Amazon S3 for data analysis |

  ####
  @webtest @MLP-14875
  Scenario: SC28#-Verify captions and tool tip text in JsonS3Cataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute       |
      | Type      | Cataloger       |
      | Plugin    | JsonS3Cataloger |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                      |
      | Label                      |
      | Credential*                |
      | Data Source*               |
      | Bucket filter              |
      | Bucket names               |
      | Mode                       |
      | S3 Objects filter          |
      | Directory prefixes to scan |
      | Sub Directory filter       |
      | File filter                |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name*             | Plugin configuration name                                                                                       |
      | Label             | Plugin configuration extended label and description                                                             |
      | Credential*       | Credential to be used                                                                                           |
      | Data Source*      | Data source connection to be used                                                                               |
      | Bucket names      | Add the bucket names to filter them based on the mode, Include/Exclude. All buckets are included if left empty. |
      | S3 Objects filter | Apply filters to S3 objects, such as directories, sub-directories and files.                                    |

#  ####
#  @MLP-14875 @webtest
#  Scenario: SC29#-Verify the Analysis failed notification event displayed in IDC UI when user gives invalid Secret and Access Key for Json S3 datasource plugin
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                   | response code | response message | jsonPath                                                           |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3JsonPayloads/catalogs/CreateS3CatalogSC28.json                   | 204           |                  |                                                                    |
#      |                  |       |       | Put          | settings/analyzers/JsonS3DataSource                                  | ida/s3JsonPayloads/DataSource/AmazonJSONS3InvalidDataSourceConfig.json | 204           |                  |                                                                    |
#      |                  |       |       | Get          | settings/analyzers/JsonS3DataSource                                  |                                                                        | 200           |                  | AmazonJSONS3InValidDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3InValidDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/JsonS3DataSource/*  | ida/s3JsonPayloads/empty.json                                          | 200           |                  |                                                                    |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                        | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3InValidDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis JsonS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis JsonS3DataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3JsonATSC28"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#  ###
#  @MLP-14875 @webtest
#  Scenario: SC30#-Verify the Json S3 Cataloger does not collect any items when an Invalid Datasource(with wrong Credentials) and Invalid Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                                        | response code | response message | jsonPath                                                                                |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3JsonPayloads/catalogs/CreateS3CatalogSC28.json                                        | 204           |                  |                                                                                         |
#      |                  |       |       | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc28JsonS3InvalidDataSourceAndCredentialsConfig.json | 204           |                  |                                                                                         |
#      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                                             | 200           |                  | JsonS3CatalogerWithInvalidDataSourceAndCredentials                                      |
#      |                  |       |       | Put          | settings/analyzers/JsonS3DataSource                                  | ida/s3JsonPayloads/DataSource/AmazonJSONS3InvalidDataSourceConfig.json                      | 204           |                  |                                                                                         |
#      |                  |       |       | Get          | settings/analyzers/JsonS3DataSource                                  |                                                                                             | 200           |                  | AmazonJSONS3InValidDataSource                                                           |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                                             | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3InValidDataSource')].status                      |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/JsonS3DataSource/*  | ida/s3JsonPayloads/empty.json                                                               | 200           |                  |                                                                                         |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                                             | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3InValidDataSource')].status                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*    |                                                                                             | 200           | IDLE             | $.[?(@.configurationName=='JsonS3CatalogerWithInvalidDataSourceAndCredentials')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*     | ida/s3JsonPayloads/empty.json                                                               | 200           |                  |                                                                                         |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*    |                                                                                             | 200           | IDLE             | $.[?(@.configurationName=='JsonS3CatalogerWithInvalidDataSourceAndCredentials')].status |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis JsonS3Cataloger on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis JsonS3Cataloger on LocalNode has failed:" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis JsonS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis JsonS3DataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "S3JsonATSC28" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Analysis |
#      | Cluster  |
#      | Service  |
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "cataloger" item from search results
#    And user click on Analysis log link in DATA widget section
#    Then user "verify analysis log contains" presence of "The AWS Access Key Id you provided does not exist in our records." in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3JsonATSC28"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#  ###
#  @MLP-14875 @webtest
#  Scenario: SC31#- Verify the Json S3  Cataloger collects all items when an Invalid Datasource(with wrong Credentials) and Valid Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                                             | response code | response message | jsonPath                                                                                     |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3JsonPayloads/catalogs/CreateS3CatalogSC28.json                                             | 204           |                  |                                                                                              |
#      |                  |       |       | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc28JsonS3InvalidDataSourceAndValidCredentialsConfig.json | 204           |                  |                                                                                              |
#      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                                                  | 200           |                  | JsonS3CatalogerWithInvalidDataSourceAndValidCredentials                                      |
#      |                  |       |       | Put          | settings/analyzers/JsonS3DataSource                                  | ida/s3JsonPayloads/DataSource/AmazonJSONS3InvalidDataSourceConfig.json                           | 204           |                  |                                                                                              |
#      |                  |       |       | Get          | settings/analyzers/JsonS3DataSource                                  |                                                                                                  | 200           |                  | AmazonJSONS3InValidDataSource                                                                |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3InValidDataSource')].status                           |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/JsonS3DataSource/*  | ida/s3JsonPayloads/empty.json                                                                    | 200           |                  |                                                                                              |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3InValidDataSource')].status                           |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*    |                                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='JsonS3CatalogerWithInvalidDataSourceAndValidCredentials')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*     | ida/s3JsonPayloads/empty.json                                                                    | 200           |                  |                                                                                              |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*    |                                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='JsonS3CatalogerWithInvalidDataSourceAndValidCredentials')].status |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis JsonS3Cataloger on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis JsonS3Cataloger on LocalNode has succeeded" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis JsonS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis JsonS3DataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "S3JsonATSC28" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Field     |
#      | File      |
#      | Directory |
#      | Analysis  |
#      | Cluster   |
#      | Service   |
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3JsonATSC28"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#  ###
#  @MLP-14875 @webtest
#  Scenario: SC32#-Verify the Analysis failed notification displayed in IDC UI when Datasource Plugin is Started with Empty Credentials in Datasource
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                 | response code | response message | jsonPath                                                         |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3JsonPayloads/catalogs/CreateS3CatalogSC29.json                 | 204           |                  |                                                                  |
#      |                  |       |       | Put          | settings/analyzers/JsonS3DataSource                                  | ida/s3JsonPayloads/DataSource/AmazonJSONS3EmptyDataSourceConfig.json | 204           |                  |                                                                  |
#      |                  |       |       | Get          | settings/analyzers/JsonS3DataSource                                  |                                                                      | 200           |                  | AmazonJSONS3EmptyDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3EmptyDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/JsonS3DataSource/*  | ida/s3JsonPayloads/empty.json                                        | 200           |                  |                                                                  |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3EmptyDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis JsonS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis JsonS3DataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3JsonATSC29"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#  ###
#  @MLP-14875 @webtest
#  Scenario: SC33#-Verify the Json S3 Cataloger does not collect any items when an Datasource(with Empty Credentials) and Empty Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                                           | response code | response message | jsonPath                                                                                   |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3JsonPayloads/catalogs/CreateS3CatalogSC29.json                                           | 204           |                  |                                                                                            |
#      |                  |       |       | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc29JsonS3EmptyDataSourceAndEmptyCredentialsConfig.json | 204           |                  |                                                                                            |
#      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                                                | 200           |                  | JsonS3CatalogerWithEmptyDataSourceAndEmptyCredentials                                      |
#      |                  |       |       | Put          | settings/analyzers/JsonS3DataSource                                  | ida/s3JsonPayloads/DataSource/AmazonJSONS3EmptyDataSourceConfig.json                           | 204           |                  |                                                                                            |
#      |                  |       |       | Get          | settings/analyzers/JsonS3DataSource                                  |                                                                                                | 200           |                  | AmazonJSONS3EmptyDataSource                                                                |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                                                | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3EmptyDataSource')].status                           |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/JsonS3DataSource/*  | ida/s3JsonPayloads/empty.json                                                                  | 200           |                  |                                                                                            |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                                                | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3EmptyDataSource')].status                           |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*    |                                                                                                | 200           | IDLE             | $.[?(@.configurationName=='JsonS3CatalogerWithEmptyDataSourceAndEmptyCredentials')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*     | ida/s3JsonPayloads/empty.json                                                                  | 200           |                  |                                                                                            |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*    |                                                                                                | 200           | IDLE             | $.[?(@.configurationName=='JsonS3CatalogerWithEmptyDataSourceAndEmptyCredentials')].status |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis JsonS3Cataloger on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis JsonS3Cataloger on LocalNode has failed:" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis JsonS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis JsonS3DataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "S3JsonATSC29" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Analysis |
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "cataloger" item from search results
#    And user click on Analysis log link in DATA widget section
#    Then user "verify analysis log contains" presence of "Required attribute Access key is blank" in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3JsonATSC29"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#  ###
#  @MLP-14875 @webtest
#  Scenario: SC34#-Verify the Analysis failed notification displayed in IDC UI when Json S3 Datasource Plugin is Started with No Region(Region will be null in Json)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                                 | response code | response message | jsonPath                                                                |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3JsonPayloads/catalogs/CreateS3CatalogSC30.json                                 | 204           |                  |                                                                         |
#      |                  |       |       | Put          | settings/analyzers/JsonS3DataSource                                  | ida/s3JsonPayloads/DataSource/AmazonJSONS3InvalidDataSourceWithNullRegionConfig.json | 204           |                  |                                                                         |
#      |                  |       |       | Get          | settings/analyzers/JsonS3DataSource                                  |                                                                                      | 200           |                  | AmazonJSONS3DataSourceWithNoRegion                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3DataSourceWithNoRegion')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/JsonS3DataSource/*  | ida/s3JsonPayloads/empty.json                                                        | 200           |                  |                                                                         |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3DataSourceWithNoRegion')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis JsonS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis JsonS3DataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3JsonATSC30"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#  ###
#  @MLP-14875 @webtest
#  Scenario: SC35#-Verify the Json S3 Cataloger does not collect any items when an Datasource(with No Region) and Valid Credentials are used in the Plugin Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                                 | response code | response message | jsonPath                                                                |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3JsonPayloads/catalogs/CreateS3CatalogSC30.json                                 | 204           |                  |                                                                         |
#      |                  |       |       | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc30JsonS3NoRegionCatalogerConfig.json        | 204           |                  |                                                                         |
#      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                                      | 200           |                  | JsonS3CatalogerWithNoRegion                                             |
#      |                  |       |       | Put          | settings/analyzers/JsonS3DataSource                                  | ida/s3JsonPayloads/DataSource/AmazonJSONS3InvalidDataSourceWithNullRegionConfig.json | 204           |                  |                                                                         |
#      |                  |       |       | Get          | settings/analyzers/JsonS3DataSource                                  |                                                                                      | 200           |                  | AmazonJSONS3DataSourceWithNoRegion                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3DataSourceWithNoRegion')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/JsonS3DataSource/*  | ida/s3JsonPayloads/empty.json                                                        | 200           |                  |                                                                         |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3DataSourceWithNoRegion')].status |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*    |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='JsonS3CatalogerWithNoRegion')].status        |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*     | ida/s3JsonPayloads/empty.json                                                        | 200           |                  |                                                                         |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/*    |                                                                                      | 200           | IDLE             | $.[?(@.configurationName=='JsonS3CatalogerWithNoRegion')].status        |
#    And user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis JsonS3Cataloger on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis JsonS3Cataloger on LocalNode has failed:" in the notifications tab
#    And "Analysis started!" notification should have content "Analysis JsonS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis JsonS3DataSource on LocalNode has failed:" in the notifications tab
#    Then user clicks on exit button in notifications panel
#    And user select "All" catalog and search "S3JsonATSC30" items at top end
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Analysis |
#    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
#    And user performs "dynamic item click" on "cataloger" item from search results
#    And user click on Analysis log link in DATA widget section
#    Then user "verify analysis log contains" presence of "Required attribute Region is blank" in Analysis Log of IDC UI
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3JsonATSC30"
#    Then Status code 204 must be returned
#    And user clicks on logout button
#
#  ###
#  @MLP-14875 @webtest
#  Scenario: SC36#-Verify the Analysis failed notification displayed in IDC UI when Datasource Plugin is Started without Credentials in Datasource (Credentials will be null in Json)
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on notification icon
#    When user clicks on mark all read button in the notifications tab
#    Then user clicks on exit button in notifications panel
#    Then Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                                             | response code | response message | jsonPath                                                                     |
#      | application/json | raw   | false | Post         | settings/catalogs                                                    | ida/s3JsonPayloads/catalogs/CreateS3CatalogSC31.json                             | 204           |                  |                                                                              |
#      |                  |       |       | Put          | settings/analyzers/JsonS3DataSource                                  | ida/s3JsonPayloads/DataSource/AmazonJSONS3NullCredentialsInDataSourceConfig.json | 204           |                  |                                                                              |
#      |                  |       |       | Get          | settings/analyzers/JsonS3DataSource                                  |                                                                                  | 200           |                  | AmazonJSONS3NullCredentialsInDataSource                                      |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3NullCredentialsInDataSource')].status |
#      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/JsonS3DataSource/*  | ida/s3JsonPayloads/empty.json                                                    | 200           |                  |                                                                              |
#      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/JsonS3DataSource/* |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='AmazonJSONS3NullCredentialsInDataSource')].status |
#    When user clicks on notification icon
#    And "Analysis started!" notification should have content "Analysis JsonS3DataSource on LocalNode has started" in the notifications tab
#    And "Analysis failed!" notification should have content "Analysis JsonS3DataSource on LocalNode has failed:" in the notifications tab
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/S3JsonATSC31"
#    Then Status code 204 must be returned
#    And user clicks on logout button

  ###QAC-7078868
  @MLP-14875 @webtest
  Scenario: SC37#-Verify the Json S3 Cataloger does not collect any items when Datasource is null or Credential invalid in Json
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                                                                    | response code | response message | jsonPath                                                               |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                | ida/s3JsonPayloads/PluginConfiguration/sc31JsonS3CatalogerWithNullDataSourceConfig.json | 204           |                  |                                                                        |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                |                                                                                         | 200           |                  | JsonS3CatalogerWithNullDataSource                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/* |                                                                                         | 200           | IDLE             | $.[?(@.configurationName=='JsonS3CatalogerWithNullDataSource')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*  | ida/s3JsonPayloads/empty.json                                                           | 200           |                  |                                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/* |                                                                                         | 200           | IDLE             | $.[?(@.configurationName=='JsonS3CatalogerWithNullDataSource')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC31Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC31Tags" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    And user enters the search text "JsonS3SC31Tags" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/JsonS3Cataloger/JsonS3CatalogerWithNullDataSource/%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/JsonS3Cataloger/JsonS3CatalogerWithNullDataSource%" should display below info/error/warning
      | type  | logValue                                | logCode     |
      | ERROR | Required attribute Data Source is blank | AWS_S3-0010 |
    Given Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                               | body                                                                                     | response code | response message | jsonPath                                                               |
      |        |       |       | Put          | settings/analyzers/JsonS3DataSource                               | ida/s3JsonPayloads/DataSource/AmazonJSONS3ValidDataSourceConfig.json                     | 204           |                  |                                                                        |
      |        |       |       | Put          | settings/analyzers/JsonS3Cataloger                                | ida/s3JsonPayloads/PluginConfiguration/sc31JsonS3CatalogerWithNullCredentialsConfig.json | 204           |                  |                                                                        |
      |        |       |       | Get          | settings/analyzers/JsonS3Cataloger                                |                                                                                          | 200           |                  | JsonS3CatalogerWithNullCredential                                      |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/* |                                                                                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3CatalogerWithNullCredential')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/JsonS3Cataloger/*  | ida/s3JsonPayloads/empty.json                                                            | 200           |                  |                                                                        |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/JsonS3Cataloger/* |                                                                                          | 200           | IDLE             | $.[?(@.configurationName=='JsonS3CatalogerWithNullCredential')].status |
    And user enters the search text "JsonS3SC32Tags" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/JsonS3Cataloger/JsonS3CatalogerWithNullCredential%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/JsonS3Cataloger/JsonS3CatalogerWithNullCredential%" should display below info/error/warning
      | type  | logValue                                                            | logCode          |
      | ERROR | Invalid data source configuration name: AmazonJSONS3ValidDataSource | AWS_S3_JSON-0002 |


  Scenario Outline:SC37# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                            | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3CatalogerWithNullDataSource%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC37#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                           |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/jsonS3/actual/itemIds.json |

  Scenario Outline:SC37_1# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                            | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3CatalogerWithNullCredential%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC37_1#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                           |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/jsonS3/actual/itemIds.json |


  @webtest
  Scenario: MLP-8710:SC38#Verify JsonS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when JsonS3Cataloger is run with dry run true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                              | response code | response message | jsonPath                                                   |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc1JsonS3ConfigDryRun.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                   | 200           |                  | JsonS3CatalogerDryRun                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='JsonS3CatalogerDryRun')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                     | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='JsonS3CatalogerDryRun')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC38Tags" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/JsonS3Cataloger/JsonS3CatalogerDryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/JsonS3Cataloger/JsonS3CatalogerDryRun%" should display below info/error/warning
      | type | logValue                                                                                   | logCode       | pluginName | removableText |
      | INFO | Plugin JsonS3Cataloger running on dry run mode                                             | ANALYSIS-0069 |            |               |
      | INFO | Plugin JsonS3Cataloger processed 0 items on dry run mode and not written to the repository | ANALYSIS-0070 |            |               |


  Scenario Outline:SC38# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC38#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                           |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/jsonS3/actual/itemIds.json |


  Scenario Outline:MLP-14875:SC39#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                 | body                                                                  | response code | response message   | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3DataSource                               | ida/s3JsonPayloads/DataSource/AmazonS3JSONS3DataSourceConfig.json     | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3DataSource                               |                                                                       | 200           | AmazonS3DataSource |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonS3Cataloger                                | ida/s3JsonPayloads/PluginConfiguration/sc39AmazonS3_JSONS3Config.json | 204           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonS3Cataloger                                |                                                                       | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                       | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonS3Cataloger/*  | ida/amazonPayloads/empty.json                                         | 200           |                    |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonS3Cataloger/* |                                                                       | 200           | IDLE               | $.[?(@.configurationName=='AmazonS3Catalog')].status |


  @MLP-8710 @webtest @aws @regression @sanity @IDA-10.0
  Scenario: MLP-8710:SC39#Verify JsonS3Cataloger collects Cluster,Service,Analysis,Directory,File,Field when JsonS3Cataloger is run with region  and Bucketname with Include
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                 | response code | response message            | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3DataSource                                  | ida/s3JsonPayloads/DataSource/AmazonJSONS3ValidDataSourceConfig.json | 204           |                             |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3DataSource                                  |                                                                      | 200           | AmazonJSONS3ValidDataSource |                                                      |
      |                  |       |       | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc39JsonS3Config.json         | 204           |                             |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                      | 200           | JsonS3Cataloger             |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                      | 200           | IDLE                        | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                        | 200           |                             |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                      | 200           | IDLE                        | $.[?(@.configurationName=='JsonS3Cataloger')].status |

  Scenario Outline: SC#39-user retrieves the item ids of different items of SC32 and copy them to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                            | type | targetFile                          | jsonpath            |
      | APPDBPOSTGRES | Default | asgqajsontestautomation                         |      | response/jsonS3/actual/itemIds.json | $..has_Directory.id |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN   |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id  |
      | APPDBPOSTGRES | Default | cataloger/AmazonS3Cataloger/AmazonS3Catalog%DYN |      | response/jsonS3/actual/itemIds.json | $..has_File.id      |

  #QAC- 6515967
  @sanity @positive @MLP-17683 @webtest @IDA-10.3 @MLPQA-18060 @MLPQA-18064
  Scenario: SC#39-Verify the technology tags got assigned to all S3 and Parquet S3 catalogued items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet         | Tag                           | fileName                | userTag        |
      | Default     | Directory | Metadata Type | JsonS3SC39Tags,Amazon S3,JSON | asgqajsontestautomation | JsonS3SC39Tags |
      | Default     | Cluster   | Metadata Type | JsonS3SC39Tags,Amazon S3,JSON | amazonaws.com           | JsonS3SC39Tags |
      | Default     | Field     | Metadata Type | JsonS3SC39Tags,Amazon S3,JSON | Field                   | JsonS3SC39Tags |
      | Default     | File      | Metadata Type | JsonS3SC39Tags,Amazon S3,JSON | simple.json             | JsonS3SC39Tags |
      | Default     | Service   | Metadata Type | JsonS3SC39Tags,Amazon S3,JSON | AmazonS3                | JsonS3SC39Tags |
    And user clicks on logout button

  Scenario Outline: SC#39- user deletes the SC39 item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                       | responseCode | inputJson           | inputFile                           |
      | items/Default/Default.Directory:::dynamic | 204          | $..has_Directory.id | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_Analysis.id  | response/jsonS3/actual/itemIds.json |
      | items/Default/Default.Analysis:::dynamic  | 204          | $..has_File.id      | response/jsonS3/actual/itemIds.json |


  @MLP-14875 @webtest
  Scenario: SC40#-Verify the Json S3 Cataloger does not collect any items when bucket is invalid
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                         | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc40JsonS3Config.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                              | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                              | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/s3JsonPayloads/empty.json                                | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                              | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC40Tags" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/JsonS3Cataloger/JsonS3Cataloger%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/JsonS3Cataloger/JsonS3Cataloger/%" should display below info/error/warning
      | type | logValue                        | logCode | pluginName | removableText |
      | INFO | No S3 data available to catalog |         |            |               |


  Scenario Outline:SC40# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC40#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                           |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/jsonS3/actual/itemIds.json |

  @MLP-14875 @webtest
  Scenario: SC41#-Verify the Json S3 Cataloger does not collect any items when directory is invalid
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                         | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc41JsonS3Config.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                              | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                              | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/s3JsonPayloads/empty.json                                | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                              | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC41Tags" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/JsonS3Cataloger/JsonS3Cataloger%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/JsonS3Cataloger/JsonS3Cataloger/%" should display below info/error/warning
      | type | logValue                        | logCode | pluginName | removableText |
      | INFO | No S3 data available to catalog |         |            |               |


  Scenario Outline:SC41# user retrieves ID for Analysis type
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                          | type | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger%DYN |      | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline:SC41#Delete item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                      | responseCode | inputJson          | inputFile                           |
      | items/Default/Default.Analysis:::dynamic | 204          | $..has_Analysis.id | response/jsonS3/actual/itemIds.json |


  @aws
  Scenario:SC42#Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqajsontestautomation"
    Then user "Delete" a bucket "asgqajsontestautomation" in amazon storage service

  @webtest
  Scenario: MLP-8710:SC43#Verify incremental scan works properly with JsonS3Cataloger for newly added file
    Given user "Create" a bucket "asgqajsontestautomation" in amazon storage service
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName              | keyPrefix             | dirPath                              | recursive |
      | asgqajsontestautomation | AutoTestData/TestJson | ida/S3JsonPayloads/TestData/TestJson | true      |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                         | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc16JsonS3ConfigIncrementalFalse.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                              | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                                | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "JsonS3SC16Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC16Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "simple.json" item from search results
    And user "store" the value of item "simple.json" of attribute "Last catalogued at" with temporary text
    And user "store as Static" the value of item "simple.json" of attribute "Last catalogued at" with temporary text
    And user performs "multiple upload" in amazon storage service with below parameters
      | bucketName              | keyPrefix                | dirPath                                 | recursive |
      | asgqajsontestautomation | AutoTestData/Incremental | ida/s3JsonPayloads/TestData/Incremental | false     |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body                                                                    | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/JsonS3Cataloger                                   | ida/s3JsonPayloads/PluginConfiguration/sc16JsonS3ConfigIncremental.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/JsonS3Cataloger                                   |                                                                         | 200           |                  | JsonS3Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/JsonS3Cataloger/*  | ida/S3JsonPayloads/empty.json                                           | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/JsonS3Cataloger/* |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='JsonS3Cataloger')].status |
    And user enters the search text "JsonS3SC16Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC16Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "simple.json" item from search results
    Then user "verify equals" the value of item "simple.json" of attribute "Last catalogued at" with temporary text
    And user enters the search text "JsonS3SC16Tags" and clicks on search
    And user performs "facet selection" in "JsonS3SC16Tags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "incremental.json" item from search results
    Then user "verify not equals" the value of item "incremental.json" of attribute "Last catalogued at" with temporary text

  @sanity @positive @IDA_E2E
  Scenario: SC#43-Delete the Id's
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                       | type      | query | param |
      | MultipleIDDelete | Default | cataloger/JsonS3Cataloger/JsonS3Cataloger% | Analysis  |       |       |
      | MultipleIDDelete | Default | amazonaws.com                              | Cluster   |       |       |
      | MultipleIDDelete | Default | AmazonS3                                   | Service   |       |       |
      | MultipleIDDelete | Default | asgqajsontestautomation                    | Directory |       |       |

  @aws
  Scenario:SC43#Delete the bucket in Amazon S3 storage
    Given user "Delete" objects in amazon directory "AutoTestData" in bucket "asgqajsontestautomation"
    Then user "Delete" a bucket "asgqajsontestautomation" in amazon storage service

  @MLP-14874 @webtest
  Scenario: SC#44 Verify whether the background of the panel is displayed in red when test connection is not successful for JsonS3DataSource in LocalNode for disabled/unsupported region
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
      | fieldName        | attribute        |
      | Data Source Type | JsonS3DataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute             |
      | Name*     | JsonS3DataSourceTest3 |
      | Label     | JsonS3DataSourceTest3 |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute                        |
      | Region*     | China (Ningxia) [cn-northwest-1] |
      | Credential* | ValidJSONCredentials             |
      | Node        | LocalNode                        |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Error retrieving bucket list" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute                       |
      | Region*   | Africa (Cape Town) [af-south-1] |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Error retrieving bucket list" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute                                   |
      | Region*   | Asia Pacific (Osaka-Local) [ap-northeast-3] |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Cannot create enum from ap-northeast-3 value!" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"

#  @edibus @positive
#  Scenario:Clearing of Subject Area in Rochade
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


  Scenario Outline: Delete Credentials, Datasource and cataloger config for Json S3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                           | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidJSONCredentials     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/IncorrectJSONCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptyJSONCredentials     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/JsonS3DataSource           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/JsonS3Cataloger            |      | 204           |                  |          |


  Scenario Outline:Getting business application ID
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type                | name      | asg_scopeid | targetFile                          | jsonpath           |
      | APPDBPOSTGRES | ID      | Default | BusinessApplication | JSONS3_BA |             | response/jsonS3/actual/itemIds.json | $..has_Analysis.id |


  Scenario Outline: user deletes business application from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson          | inputFile                           |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..has_Analysis.id | response/jsonS3/actual/itemIds.json |
