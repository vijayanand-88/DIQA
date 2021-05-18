@MLP-6465
Feature:MLP-6465: cloudera_SkipSelectsCases

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:MLP_6465_SC1#-Set the Credentials and DataSource for CNavigator
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                             | body                                                               | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaValidCredentials   | ida/cloudEraNavigatorPayloads/Credentials/Valid.json               | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ClouderaInValidCredentials | ida/cloudEraNavigatorPayloads/Credentials/Invalid.json             | 200           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CNavigatorDataSource         | ida/cloudEraNavigatorPayloads/DataSource/CNavigatorDataSource.json | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/CNavigatorDataSource         |                                                                    | 200           | CNavigatorDataSource |          |

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:SC1#_MLP_6465_Config the CNavigator plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/CNavigatorCataloger | ida/cloudEraNavigatorPayloads/CloudEra_6465_Hive.json | 204           |                  |          |

  ##6195266##
  @MLP-6465 @webtest @positive @regression @regression @cloudera
  Scenario:SC#1_MLP_6465_Verify whether the 'select queries' data not getting displayed when skip select queries option is enabled for sourcetype 'Hive'
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                  | body | response code | response message | jsonPath                                              |
      | application/json |       |       | Get          | settings/analyzers/CNavigatorCataloger                                               |      | 200           | HiveSkipSelectON |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveSkipSelectON |      | 200           | IDLE             | $.[?(@.configurationName=='HiveSkipSelectON')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                          | body | response code | response message | jsonPath                                              |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveSkipSelectON  |      | 200           |                  |                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveSkipSelectON |      | 200           | IDLE             | $.[?(@.configurationName=='HiveSkipSelectON')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN6465SC1" and clicks on search
    And user performs "facet selection" in "CN6465SC1" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 454   |
      | HIVE [Service]                | 305   |
      | YARN [Service]                | 75    |
      | IMPALA [Service]              | 55    |
      | HDFS [Service]                | 15    |
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Operation |
      | Execution |
      | Service   |
      | Analysis  |
      | Cluster   |
      | Column    |
      | Table     |
      | Database  |
      | Directory |
      | Partition |
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And compare item names list in UI not starts with "select"
    And user enters the search text "CN6465SC1" and clicks on search
    And user performs "facet selection" in "CN6465SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    And compare item names list in UI not starts with "select"
    And user clicks on logout button


  ##6195267##
  @MLP-6465 @webtest @positive @regression @regression @cloudera
  Scenario:SC#2_MLP_6465_Verify whether the 'select queries' data not got displayed when skip select queries option is enabled for sourcetype 'Impala'.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body | response code | response message | jsonPath                                                |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/ImpalaSkipSelectON |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaSkipSelectON')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                                |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/ImpalaSkipSelectON  |      | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/ImpalaSkipSelectON |      | 200           | IDLE             | $.[?(@.configurationName=='ImpalaSkipSelectON')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN6465SC2" and clicks on search
    And user performs "facet selection" in "CN6465SC2" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Operation |
      | Execution |
      | Service   |
      | Analysis  |
      | Cluster   |
      | Column    |
      | Table     |
      | Database  |
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 43    |
      | IMPALA [Service]              | 43    |
    And compare item names list in UI not starts with "select"
    And user enters the search text "CN6465SC2" and clicks on search
    And user performs "facet selection" in "CN6465SC2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    And compare item names list in UI not starts with "select"
    And user clicks on logout button


  ##6195269##
  @MLP-6465 @webtest @positive @regression @regression @cloudera
  Scenario:SC#3_MLP_6465_Verify whether the data getting displayed in IDC UI when sourcetype is empty.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                 | body | response code | response message | jsonPath                                             |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/EmptySourceType |      | 200           | IDLE             | $.[?(@.configurationName=='EmptySourceType')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                         | body | response code | response message | jsonPath                                             |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/EmptySourceType  |      | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/EmptySourceType |      | 200           | IDLE             | $.[?(@.configurationName=='EmptySourceType')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN6465SC3" and clicks on search
    And user performs "facet selection" in "CN6465SC3" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 682   |
      | HDFS [Service]                | 271   |
      | YARN [Service]                | 254   |
      | HIVE [Service]                | 145   |
      | IMPALA [Service]              | 5     |
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Operation |
      | Execution |
      | Service   |
      | Analysis  |
      | Cluster   |
      | Column    |
      | Table     |
      | Database  |
      | Directory |
      | File      |
    And user clicks on logout button

  ##6195270##
  @MLP-6465 @webtest @positive @regression @regression @cloudera
  Scenario:SC#4_MLP_6465_Verify whether the data getting displayed in IDC UI when sourcetype is multiple.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body | response code | response message | jsonPath                                                |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/MultipleSourceType |      | 200           | IDLE             | $.[?(@.configurationName=='MultipleSourceType')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                            | body | response code | response message | jsonPath                                                |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/MultipleSourceType  |      | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/MultipleSourceType |      | 200           | IDLE             | $.[?(@.configurationName=='MultipleSourceType')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN6465SC4" and clicks on search
    And user performs "facet selection" in "CN6465SC4" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PIG [Service]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Execution |
      | Operation |
      | Service   |
    And user performs "facet selection" in "SQOOP [Service]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Execution |
      | Operation |
      | Service   |
    And user enters the search text "CN6465SC4" and clicks on search
    And user performs "facet selection" in "CN6465SC4" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Hierarchy" section in item search results page
      | facetType                     | count |
      | Cloudera QuickStart [Cluster] | 71    |
      | HDFS [Service]                | 16    |
      | YARN [Service]                | 20    |
      | PIG [Service]                 | 14    |
      | SQOOP [Service]               | 20    |
    And user clicks on logout button

##6198850##
  @MLP-6465 @webtest @positive @regression @regression @cloudera
  Scenario:SC#5_MLP_6465_Verify whether the 'select queries' data not got displayed when skip select queries option is enabled for sourcetype 'Pig'.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                         |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/PIGSelectON |      | 200           | IDLE             | $.[?(@.configurationName=='PIGSelectON')].status |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body | response code | response message | jsonPath                                         |
      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/PIGSelectON  |      | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/PIGSelectON |      | 200           | IDLE             | $.[?(@.configurationName=='PIGSelectON')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN6465SC5" and clicks on search
    And user performs "facet selection" in "CN6465SC5" attribute under "Tags" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Operation |
      | Execution |
      | Service   |
      | Analysis  |
      | Cluster   |
      | Directory |
      | File      |
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Execution" attribute under "Metadata Type" facets in Item Search results page
    And compare item names list in UI not starts with "select"
    And user clicks on logout button

  @MLP-4441 @sanity @positive
  Scenario:6465_SC#1 to 5:Delete all the item id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                              | type      | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveSkipSelectON%   | Analysis  |       |       |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/ImpalaSkipSelectON% | Analysis  |       |       |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/EmptySourceType%    | Analysis  |       |       |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/MultipleSourceType% | Analysis  |       |       |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/PIGSelectON%        | Analysis  |       |       |
      | MultipleIDDelete | Default | Pig%                                              | Operation |       |       |
      | MultipleIDDelete | Default | ROOT%                                             | Directory |       |       |
      | MultipleIDDelete | Default | Movies%                                           | Operation |       |       |
      | MultipleIDDelete | Default | s%                                                | Operation |       |       |
      | MultipleIDDelete | Default | e%                                                | Operation |       |       |
      | MultipleIDDelete | Default | insert%                                           | Operation |       |       |
      | MultipleIDDelete | Default | INSERT%                                           | Operation |       |       |
      | MultipleIDDelete | Default | test%                                             | Database  |       |       |
      | MultipleIDDelete | Default | joined%                                           | Database  |       |       |
      | MultipleIDDelete | Default | hive%                                             | Database  |       |       |
      | MultipleIDDelete | Default | sqoop%                                            | Database  |       |       |
      | MultipleIDDelete | Default | default%                                          | Database  |       |       |
      | MultipleIDDelete | Default | CREATE%                                           | Operation |       |       |
      | MultipleIDDelete | Default | FROM%                                             | Operation |       |       |
      | MultipleIDDelete | Default | create%                                           | Operation |       |       |
      | MultipleIDDelete | Default | app%                                              | Operation |       |       |

########################## MLP-5561 cases #####################################################

   ##6123614##
  @MLP-5561 @webtest @positive @regression @cloudera
  Scenario:SC#1_MLP_5561_Verify the query text appears in lineage hop when mode is Copy(Impala query)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                           | body | response code | response message | jsonPath                                       |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CNavigatorCataloger/HiveQuery |      | 200           | IDLE             | $.[?(@.configurationName=='HiveQuery')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveQuery          |      | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveQuery         |      | 200           | IDLE             | $.[?(@.configurationName=='HiveQuery')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "create table census_filter as select * from census w..._4407887" and clicks on search
    And user performs "facet selection" in "CN5561SC1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "create table census_filter as select * from census w..._4407887" item from search results
    Then user performs click and verify in new window
      | Table        | value                                           | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | census.census_year => census_filter.census_year | verify widget contains |                  |             |
      | Lineage Hops | census.name => census_filter.name               | verify widget contains |                  |             |
      | Lineage Hops | census.year => census_filter.year               | verify widget contains |                  |             |
      | Lineage Hops | census.census_year => census_filter.census_year | click and switch tab   | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                     | widgetName  |
      | mode              | COPY                                                              | Description |
      | source            | create table census_filter as select * from census where year = ? | Description |
    And user clicks on logout button

##Technology Tag cases:

##6754458#
  @sanity @positive @MLP-8191 @webtest @IDA-10.3
  Scenario:SC1#_5561_Verify the Technology tag appears properly for items collected by CNavigator plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name      | facet | Tag                          | fileName                                 | userTag   |
      | Default     | Column    | Type  | Cloudera Navigator,CN5561SC1 | year                                     | CN5561SC1 |
      | Default     | Execution | Type  | Cloudera Navigator,CN5561SC1 | job_1532521880492_0132_1657150           | CN5561SC1 |
      | Default     | Operation | Type  | Cloudera Navigator,CN5561SC1 | select * from default.employeeimp_762968 | CN5561SC1 |
      | Default     | Table     | Type  | Cloudera Navigator,CN5561SC1 | hive_s3_6120                             | CN5561SC1 |
      | Default     | Directory | Type  | Cloudera Navigator,CN5561SC1 | census                                   | CN5561SC1 |
      | Default     | Partition | Type  | Cloudera Navigator,CN5561SC1 | year=2012                                | CN5561SC1 |


  @aws @webtest @negative
  Scenario:SC#2_5561_Verify whether the background of the panel is displayed in red when connection is unsuccessful due to invalid / Empty credentials in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute            |
      | Data Source Type | CNavigatorDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName               | attribute             |
      | Name                    | CNavigator_DataSource |
      | Label                   | CNavigator_DataSource |
      | Cloudera Navigator Host | http://10.33.208.102  |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                  |
      | Credential | ClouderaInValidCredentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "No connection with data source - CNavigator connection was failed" is "displayed" in "Add Data Sources Page"

  @amazonSpectrum @positve @regression @sanity @webtest
  Scenario:SC#3_5561_Verify whether the background of the panel is displayed in green when connection is successful in Step1 pop up when user logs in for the first time in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute            |
      | Data Source Type | CNavigatorDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName               | attribute             |
      | Name                    | CNavigator_DataSource |
      | Label                   | CNavigator_DataSource |
      | Cloudera Navigator Host | http://10.33.208.102  |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                |
      | Credential | ClouderaValidCredentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"

     ##6194388##
  @MLP-6466 @webtest @positive @regression @cloudera
  Scenario:SC#4_5561_Verify proper error message is shown if mandatory fields are not filled in cloudEraNavigator plugin configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in the Add Configuration Page
      | fieldName | attribute           |
      | Type      | Cataloger           |
      | Plugin    | CNavigatorCataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |

 ######### DRY Run cases #############:

  @MLP-3244 @sanity @positive @regression
  Scenario Outline:SC5#_5561_Run the CNavigator with DRY RUN is set to TRUE
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                         | body                                                         | response code | response message | jsonPath                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CNavigatorCataloger                                      | ida/cloudEraNavigatorPayloads/CloudEra_5561_Hive_DRYRUN.json | 204           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CNavigatorCataloger                                      |                                                              | 200           | HiveQueryDryRun  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/*/CNavigatorCataloger/HiveQueryDryRun  | ida/cloudEraNavigatorPayloads/empty.json                     | 200           |                  |                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/*/CNavigatorCataloger/HiveQueryDryRun |                                                              | 200           | IDLE             | $.[?(@.configurationName=='HiveQueryDryRun')].status |

  @webtest @regression @sanity @IDA-10.0
  Scenario:SC5#_5561_Verify CNavigator plugin with Dry Run = True in IDC UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CN5561DRY" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CNavigatorCataloger/HiveQueryDryRun%"
    And user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/CNavigatorCataloger/HiveQueryDryRun%" should display below info/error/warning
      | type | logValue                                                                                                                                 | logCode       | pluginName          | removableText |
      | INFO | Plugin started                                                                                                                           | ANALYSIS-0019 |                     |               |
      | INFO | Plugin CNavigatorCataloger running on dry run mode                                                                                       | ANALYSIS-0069 | CNavigatorCataloger |               |
      | INFO | Plugin CNavigatorCataloger processed 2 items on dry run mode and not written to the repository                                           | ANALYSIS-0070 | CNavigatorCataloger |               |
      | INFO | Plugin CNavigatorCataloger Start Time:2020-05-12 11:57:09.028, End Time:2020-05-12 11:57:30.731, Processed Count:2, Errors:0, Warnings:0 | ANALYSIS-0072 | CNavigatorCataloger |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.520)                                                                           | ANALYSIS-0020 |                     |               |

  @MLP-4441 @sanity @positive
  Scenario:SC5#_5561_:Delete Analysis id
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type     | query | param |
      | SingleItemDelete | Default | cataloger/CNavigatorCataloger/HiveQueryDryRun% | Analysis |       |       |

  @MLP-4441 @positive @regression @cloudera
  Scenario Outline:6465_SC6-Delete the Credentials and Data Sources
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaValidCredentials   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ClouderaInValidCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorDataSource         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/CNavigatorCataloger          |      | 204           |                  |          |


  @MLP-4441 @sanity @positive
  Scenario:6465_SC#7:Delete cluster id and Analysis finally
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                           | type     | query | param |
      | SingleItemDelete | Default | Cloudera QuickStart            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CNavigatorCataloger% | Analysis |       |       |