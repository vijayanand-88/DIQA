@AmazonRedshift
Feature:AmazonRedshift: verification of AmazonRedShift IDA Plugin
  Description: MLP-14361 - Validate the Failed and succeed notifications in UI when Redshift datasource plugin failed or succeeded.

  @precondition
  Scenario: MLP-1960:SC1#Update credential payload json for Amazon Redshift
    Given User update the below "redshift credentials" in following files using json path
      | filePath                                           | username    | password    |
      | ida/AmazonRedShiftPayloads/CredentialsSuccess.json | $..userName | $..password |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: Add valid and invalid Credentials for AmazonRedshift
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                             | body                                               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/license                                | ida\hbasePayloads\DataSource\license_DS.json       | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Redshift_Credentials       | ida/AmazonRedShiftPayloads/CredentialsSuccess.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Redshift_Credentials       |                                                    | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RedshiftInvalidCredentials | ida/AmazonRedShiftPayloads/InvalidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RedshiftInvalidCredentials |                                                    | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials     | idc/EdiBusPayloads/credentials/EDIBusValidCredentials.json | 200           |                  |          |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusValidCredentials     |                                                            | 200           |                  |          |

##############################################UI Validations##########################################################


  @redshift @webtest @negative
  Scenario:SC01#Verify whether the background of the panel is displayed in red when connection is unsuccessful due to invalid / Empty credentials in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute                |
      | Data Source Type | AmazonRedshiftDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                                                   |
      | Name      | AmazonRedshift_DataSource                                                                   |
      | Label     | AmazonRedshift_DataSource                                                                   |
      | URL       | jdbc:redshift://redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com:5439/world |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                  |
      | Credential | RedshiftInvalidCredentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "No connection with data source - Password authentication failed for user" is "displayed" in "Add Data Sources Page"


   #6822674
  @positve @regression @sanity @webtest
  Scenario:SC02#Verify whether the background of the panel is displayed in green when connection is successful in Step1 pop up when user logs in for the first time in Local Node
  Verify captions and tool tip text in RedshiftDataSource

    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                         | body                                                     | response code | response message   | jsonPath |
      | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftDataSource | ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json | 204           |                    |          |
      |                  |       |       | Get  | settings/analyzers/AmazonRedshiftDataSource |                                                          | 200           | RedshiftDataSource |          |
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute                |
      | Data Source Type | AmazonRedshiftDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Data Source Type*     |
      | Name*                 |
      | Label                 |
      | URL*                  |
      | Credential*           |
      | Node                  |
      | Driver Bundle Name*   |
      | Driver Bundle Version |
      | Driver Name           |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                                                                                   |
      | Name      | AmazonRedshift_DataSource                                                                   |
      | Label     | AmazonRedshift_DataSource                                                                   |
      | URL       | jdbc:redshift://redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com:5439/world |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute            |
      | Credential | Redshift_Credentials |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"


  #6822684
  @redshift @webtest @negative
  Scenario:SC03#Verify whether the background of the panel is displayed in red when connection is unsuccessful in Redshift cataloger when invalid / empty credential is used in Local Node
  Verify captions and tool tip text in RedshiftCataloger

    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute               |
      | Type      | Cataloger               |
      | Plugin    | AmazonRedshiftCataloger |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                |
      | Name      | AmazonRedshift_Cataloger |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute          |
      | Data Source | RedshiftDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                |
      | Data Source*         |
      | Credential*          |
      | Business Application |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                  |
      | Credential | RedshiftInvalidCredentials |
    And user "click" on "Test Connection" button in "Add Manage Configuration Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Manage Configuration Sources Page"
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  ##6822671##
  @MLP-146361 @RedShift @positive @sanity @webtest @IDA_E2E
  Scenario:SC04# Verify proper error message is shown if mandatory fields are not filled in Redshift DataSource plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                |
      | Type      | AmazonRedshiftDataSource |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
      | URL       | URL field should not be empty  |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  #6822672
  @MLP-146361 @RedShift @positive @sanity @webtest @IDA_E2E
  Scenario:SC05# Verify error message is displayed when providing incorrect Redshift url in url field
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Data Sources" in "Add Data source Configuration"
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data source Configuration"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                |
      | Type      | AmazonRedshiftDataSource |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute |
      | Name      | /         |
    And user "enter text" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                                                                                    |
      | URL       | jdbc1:redshift://redshift-cluster-1.cfemcchdhpao.us-east-2.redshift.amazonaws.com:5439/world |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage                                                                                               |
      | Name      | Invalid name. Leading/trailing blanks and special characters are forbidden                                      |
      | URL       | UnSupported Redshift JDBC URL Format. Sample Format : jdbc:redshift://<<hostname>>:<<port number>>/<<database>> |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  #6822674
  @MLP-146361 @RedShift @positive @sanity @webtest @IDA_E2E
  Scenario:SC06# Verify the newly introduced fields in Redshift cataloger plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute               |
      | Type      | Cataloger               |
      | Plugin    | AmazonRedshiftCataloger |
    And user verifies the "Dynamic form" for "PluginConfiguration" in Add Manage Configuration Page
      | Data Source* |
      | Credential*  |


    ################################################TechnologyTag_EDIBus##########################################################


  @sanity @positive @regression @IDA_E2E
  Scenario Outline:SC07#create BussinessApplication tag and run the plugin configuration with the new field
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                 | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/AmazonRedshiftPayloads/BussinessApplication.json | 200           |                  |          |

  #6822675
  Scenario Outline:MLP-7847:SC07#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                      | response code | response message   | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json  | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                           | 200           | RedshiftDataSource |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter1.json | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                           | 200           | RedShiftCataloger  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                           | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                     | 200           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                           | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |


    #6822675
  @RedShift @positve @regression @sanity @webtest @IDA_E2E
  Scenario:SC07#Verify Redshift cataloger scans and collects data if schema name and table name are provided in filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cataloger_filter1" and clicks on search
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "world" item from search results
    Then user performs click and verify in new window
      | Table   | value      | Action                 | RetainPrevwindow | indexSwitch |
      | Schemas | testschema | verify widget contains | No               |             |
      | Schemas | testschema | click and switch tab   | No               |             |
      | Tables  | employee   | verify widget contains | No               |             |
    And user enters the search text "Cataloger_filter1" and clicks on search
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AmazonRedshiftCataloger/RedShiftCataloger%"
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/AmazonRedshiftCataloger/RedShiftCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | logCode       | pluginName        | removableText |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0019 |                   |               |
      | INFO | ANALYSIS-0073: Plugin AmazonredshiftCataloger Configuration: --- ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: name: "RedShiftCataloger"2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginVersion: "LATEST"2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: label: null2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: catalogName: "Default"2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: eventClass: null2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: eventCondition: null2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: nodeCondition: "name==\"LocalNode\""2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: maxWorkSize: 1002020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: tags:2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - "Cataloger_filter1"2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginType: "cataloger"2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: dataSource: "RedshiftDataSource"2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: credential: "Redshift_Credentials"2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: businessApplicationName: "AmazonRedshift_BA"2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: dryRun: false2020-08-17 07:34:14.189 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: schedule: null2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: filter: null2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginName: "AmazonRedshiftCataloger"2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: schemas:2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - schema: "testschema"2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: tables:2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - table: "employee"2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: incremental: false2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: type: "Cataloger"2020-03-13 05:59:14.112 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: properties: [] | ANALYSIS-0073 | RedShiftCataloger |               |
      | INFO | ANALYSIS-0072: Plugin AmazonRedshiftCataloger Start Time:2020-03-13 05:59:14.109, End Time:2020-03-13 05:59:18.815, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0072 | RedShiftCataloger |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.138)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0020 |                   |               |


  @sanity @positive @webtest @IDA-10.0
  Scenario: SC08# Verify the technology tags got assigned to all Redshift items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cataloger_filter1" and clicks on search
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Redshift,AmazonRedshift_BA,Cataloger_filter1" should get displayed for the column "cataloger/AmazonRedshiftCataloger"
    And user enters the search text "Default" and clicks on search
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                          | fileName       | userTag           |
      | Default     | Column     | Metadata Type | Redshift,AmazonRedshift_BA,Cataloger_filter1 | ename          | AmazonRedshift_BA |
      | Default     | Constraint | Metadata Type | Redshift,AmazonRedshift_BA,Cataloger_filter1 | employee_pkey  | AmazonRedshift_BA |
      | Default     | Database   | Metadata Type | Redshift,AmazonRedshift_BA,Cataloger_filter1 | world          | AmazonRedshift_BA |
      | Default     | Schema     | Metadata Type | Redshift,AmazonRedshift_BA,Cataloger_filter1 | testschema     | AmazonRedshift_BA |
      | Default     | Service    | Metadata Type | Redshift,AmazonRedshift_BA,Cataloger_filter1 | AmazonRedshift | AmazonRedshift_BA |
      | Default     | Table      | Metadata Type | Redshift,AmazonRedshift_BA,Cataloger_filter1 | employee       | AmazonRedshift_BA |
    And user enters the search text "Cataloger_filter1" and clicks on search
    And user performs "facet selection" in "AmazonRedshift_BA" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Redshift,AmazonRedshift_BA,Cataloger_filter1" should get displayed for the column "redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com"
    And user enters the search text "Cataloger_filter1" and clicks on search
    And user performs "facet selection" in "AmazonRedshift_BA" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Host" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Redshift,AmazonRedshift_BA,Cataloger_filter1" should get displayed for the column "redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com"

#  #6549303
#  @sanity @positive @webtest @edibus
#  Scenario:SC09#MLP-9043_Verify the Redshift items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Cataloger_filter1" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Column     |
#      | Analysis   |
#      | Cluster    |
#      | Constraint |
#      | Database   |
#      | Host       |
#      | Schema     |
#      | Service    |
#      | Table      |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | REDSHIFT    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/EDIBusRedshiftConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                                       | response code | response message | jsonPath                                            |
#      | application/json |       |       | Put          | settings/analyzers/EDIBusDataSource                                 | idc/EdiBusPayloads/datasource/EDIBusDS_AmazonRedshift.json | 204           |                  |                                                     |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/EDIBusRedshiftConfig.json               | 204           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusRedshift |                                                            | 200           | IDLE             | $.[?(@.configurationName=='EDIBusRedshift')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusRedshift  |                                                            | 200           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusRedshift |                                                            | 200           | IDLE             | $.[?(@.configurationName=='EDIBusRedshift')].status |
#    And user enters the search text "EDIBusRedshift" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusRedshift%"
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Number of errors  | 0             | Description |
#    And user enters the search text "Cataloger_filter1" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | REDSHIFT    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                           |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/Cloud Data Warehouses/Redshift |
#      | $..selections.['type_s'][*]                   | Column                                               |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                              | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=Cataloger_filter1&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | REDSHIFT    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
#    And user enters the search text "Cataloger_filter1" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                     |
#      | AP-DATA      | REDSHIFT    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                           |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/Cloud Data Warehouses/Redshift |
#      | $..selections.['type_s'][*]                   | Database                                             |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                              | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=Cataloger_filter1&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | REDSHIFT    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
#    And user enters the search text "Cataloger_filter1" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | REDSHIFT    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                           |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/Cloud Data Warehouses/Redshift |
#      | $..selections.['type_s'][*]                   | Schema                                               |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                              | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=Cataloger_filter1&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | REDSHIFT    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA ) |
#    And user enters the search text "Cataloger_filter1" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                          |
#      | AP-DATA      | REDSHIFT    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                           |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Cloud Data/Cloud Data Warehouses/Redshift |
#      | $..selections.['type_s'][*]                   | Table                                                |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                              | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=Cataloger_filter1&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
#      | AP-DATA      | REDSHIFT    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
#    And user enters the search text "Cataloger_filter1" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | REDSHIFT    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                               |
#      | AP-DATA      | REDSHIFT    | 1.0                | (XNAME * *  ~/ @*Redshift≫DEFAULT≫DWR_RDB_COLUMN≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | REDSHIFT    | 1.0                | (XNAME * *  ~/ @*Redshift≫DEFAULT≫DWR_RDB_TABLE_OR_VIEW≫@* ),AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | REDSHIFT    | 1.0                | (XNAME * *  ~/ @*Redshift≫DEFAULT≫DWR_RDB_DATABASE≫@* ),AND,( TYPE = DWR_IDC )      |
#      | AP-DATA      | REDSHIFT    | 1.0                | (XNAME * *  ~/ @*Redshift≫DEFAULT≫DWR_RDB_DB_SYSTEM≫@* ),AND,( TYPE = DWR_IDC )     |


  @sanity @positive
  Scenario:SC09#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
#      | MultipleIDDelete | Default | bulk/EDIBus/%                                                    | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |


    #################################################Dry Run#####################################################3
  Scenario Outline:MLP-7847:SC10#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                 | response code | response message   | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json             | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                                      | 200           | RedshiftDataSource |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter1_DryRunTrue.json | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                      | 200           | RedShiftCataloger  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                                | 200           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |

  @RedShift @positve @regression @sanity @webtest
  Scenario: SC10# Verify the Redshift items like Cluster,Service,Database...etc collected when dry run is set as true
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "RedShiftCataloger" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/AmazonRedshiftCataloger/RedShiftCataloger%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/AmazonRedshiftCataloger/RedShiftCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | logCode       | pluginName              | removableText |
      | INFO | Plugin AmazonRedshiftCataloger running on dry run mode                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0069 | AmazonRedshiftCataloger |               |
      | INFO | Plugin AmazonRedshiftCataloger Configuration: --- 2020-03-20 10:35:57.156 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: name: "RedShiftCataloger" 2020-03-20 10:35:57.156 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginVersion: "LATEST" 2020-03-20 10:35:57.157 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: label: null 2020-03-20 10:35:57.157 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: catalogName: "Default" 2020-03-20 10:35:57.157 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: eventClass: null 2020-03-20 10:35:57.157 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: eventCondition: null 2020-03-20 10:35:57.157 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: nodeCondition: "name==\"LocalNode\"" 2020-03-20 10:35:57.157 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: maxWorkSize: 100 2020-03-20 10:35:57.157 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: tags: 2020-03-20 10:35:57.157 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - "Cataloger_DryRunTrue" 2020-03-20 10:35:57.157 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginType: "cataloger" 2020-03-20 10:35:57.158 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: dataSource: "RedshiftDataSource" 2020-03-20 10:35:57.158 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: credential: "Redshift_Credentials" 2020-03-20 10:35:57.158 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: businessApplicationName: "AmazonRedshift_BA" 2020-03-20 10:35:57.158 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: dryRun: true 2020-08-17 12:16:05.242 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: schedule: null 2020-03-20 10:35:57.158 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: filter: null 2020-03-20 10:35:57.158 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginName: "AmazonRedshiftCataloger" 2020-03-20 10:35:57.158 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: schemas: 2020-03-20 10:35:57.158 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - schema: "testschema 2020-03-20 10:35:57.158 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: tables: 2020-03-20 10:35:57.158 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - table: "employee" 2020-03-20 10:35:57.159 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: incremental: false 2020-03-20 10:35:57.159 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: type: "Cataloger" 2020-03-20 10:35:57.175 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: properties: [] | ANALYSIS-0073 | AmazonRedshiftCataloger |               |
      | INFO | Plugin AmazonRedshiftCataloger Start Time:2020-03-20 10:35:57.145, End Time:2020-03-20 10:36:07.511, Processed Count:2, Errors:0, Warnings:0 2020-03-20 10:36:07.511                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0072 | AmazonRedshiftCataloger |               |
      | INFO | Plugin AmazonRedshiftCataloger processed 2 items on dry run mode and not written to the repository                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | ANALYSIS-0070 | AmazonRedshiftCataloger |               |

  @sanity @positive
  Scenario:SC10#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

###################################################SchemaNameAloneInFilter###########################################
  @RedShift
  Scenario Outline:SC11#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                      | response code | response message   | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json  | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                           | 200           | RedshiftDataSource |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter2.json | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                           | 200           | RedShiftCataloger  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                           | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                     | 200           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                           | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |


  @RedShift @positve @regression @sanity @webtest
  Scenario: SC11#Verify Redshift cataloger scans and collects data if schema name alone is provided in filters
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cataloger_filter2" and clicks on search
    And user performs "facet selection" in "Cataloger_filter2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "world" item from search results
    Then user performs click and verify in new window
      | Table   | value      | Action                 | RetainPrevwindow | indexSwitch |
      | Schemas | testschema | verify widget contains | No               |             |
      | Schemas | testschema | click and switch tab   | No               |             |
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField        | columnName | queryOperation   | storeResults  |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTables | table_name | returnstringlist | resultsInList |
    And user "verifies" the "testschema" Item view page result "list" value with Postgres DB

  Scenario Outline: SC11# user retrieves the total items for a catalog and copy to a json file
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                                             | type    | targetFile                                  | jsonpath           |
      | APPDBPOSTGRES | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster | response/AmazonRedshift/actual/itemIds.json | $..Cluster.id      |
      | APPDBPOSTGRES | Default | Cataloger_filter2                                                | Tag     | response/AmazonRedshift/actual/itemIds.json | $..has_Tag.id      |
      | APPDBPOSTGRES | Default | cataloger/AmazonRedshiftCataloger/RedShiftCataloger%DYN          |         | response/AmazonRedshift/actual/itemIds.json | $..has_Analysis.id |

  Scenario Outline: SC11# user deletes the item from database using dynamic id stored in json
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                          | responseCode | inputJson          | inputFile                                   |
      | items/Default/Default.Cluster:::dynamic      | 204          | $..Cluster.id      | response/AmazonRedshift/actual/itemIds.json |
      | items/Default/Default.Tag:::dynamic          | 204          | $..has_Tag.id      | response/AmazonRedshift/actual/itemIds.json |
      | items/Default/Default.has_Analysis:::dynamic | 204          | $..has_Analysis.id | response/AmazonRedshift/actual/itemIds.json |

####################################################MultipleSchemaInFilter############################################################################
  @RedShift
  Scenario Outline:SC12#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                      | response code | response message   | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json  | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                           | 200           | RedshiftDataSource |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter3.json | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                           | 200           | RedShiftCataloger  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                           | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                     | 200           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                           | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC12#Verify Redshift cataloger scans and collects data if multiple schema name alone is provided in filters
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cataloger_filter3" and clicks on search
    And user performs "facet selection" in "Cataloger_filter3" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "world" item from search results
    Then user performs click and verify in new window
      | Table   | value      | Action                 | RetainPrevwindow | indexSwitch |
      | Schemas | testschema | verify widget contains | No               |             |
      | Schemas | schematest | verify widget contains | No               |             |
      | Schemas | testschema | click and switch tab   | No               |             |
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField        | columnName | queryOperation   | storeResults  |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTables | table_name | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user enters the search text "Cataloger_filter3" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "world" item from search results
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | schematest | click and switch tab | No               |             |
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField         | columnName | queryOperation   | storeResults  |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTables2 | table_name | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB

  @sanity @positive
  Scenario:SC12#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

##########################################NonExistingSchema#####################################################
  @RedShift
  Scenario Outline:SC13#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                      | response code | response message   | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json  | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                           | 200           | RedshiftDataSource |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter4.json | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                           | 200           | RedShiftCataloger  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                           | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                     | 200           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                           | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC013#Verify Redshift cataloger scans and collects data if non existing schema name and table name are provided in filters
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cataloger_filter4" and clicks on search
    And user performs "facet selection" in "Cataloger_filter4" attribute under "Tags" facets in Item Search results page
    Then user verify "catalog not contains" any "Schema" attribute under "Metadata Type" facets
    Then user verify "catalog not contains" any "Table" attribute under "Metadata Type" facets

  @sanity @positive
  Scenario:SC13#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

###########################################NoSchemaNoTableInFilter######################################################
  @RedShift
  Scenario Outline:SC14#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                     | response code | response message   | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                          | 200           | RedshiftDataSource |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/RedshiftCataloger.json        | 204           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                          | 200           | RedShiftCataloger  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                          | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                    | 200           |                    |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                          | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC14#Verify Redshift cataloger scans and collects data if schema name and table names are not provided in filters
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cataloger_nofilter" and clicks on search
    And user performs "facet selection" in "Cataloger_nofilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "world" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField         | columnName   | queryOperation   | storeResults  |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftSchemas | table_schema | returnstringlist | resultsInList |
    And user "verifies" the "Schemas" Item view page result "list" value with Postgres DB
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | testschema | click and switch tab | No               |             |
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField        | columnName | queryOperation   | storeResults  |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTables | table_name | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
    And user enters the search text "Cataloger_nofilter" and clicks on search
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "demo" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField         | columnName | queryOperation   | storeResults  |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTables3 | table_name | returnstringlist | resultsInList |
    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB


     #This test case also covers 6848640 for MLP-14812
  @RedShift @positve @regression @sanity @webtest @MLP-34958
  Scenario:SC15#Verify the Table/View Name should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "city" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_nofilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "city [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "city" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    And user enters the search text "ticketsmv" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_nofilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ticketsmv [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ticketsmv" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | VIEW  | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC16#Verify the column Name should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "countrylanguage" and clicks on search
    And user performs "facet selection" in "Cataloger_nofilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "demo [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "countrylanguage" item from search results
    Then user performs click and verify in new window
      | Table   | value    | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | language | verify widget contains | No               |             |
      | Columns | language | click and switch tab   | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | VARCHAR       | Description |
      | Length            | 256           | Statistics  |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC17#Verify Table should have constraints window with the Index, Primary Key and Foreign key constraints available
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cataloger_nofilter" and clicks on search
    And user performs "facet selection" in "Cataloger_nofilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "department" item from search results
    And user connect to the database and execute query for the following parameters
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField            | columnName      | queryOperation   | storeResults  |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftConstraint | constraint_name | returnstringlist | resultsInList |
    And user "verifies" the "Constraints" Item view page result "list" value with Postgres DB

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC18#Verify Table should not have constraints window if the table is not having any constraints
  Verify the Service should have the appropriate metadata information in IDC UI and Database
  Verify the Host should have the appropriate metadata information in IDC UI and Database
  Verify the Database Name should have the appropriate metadata information in IDC UI and Database

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cataloger_nofilter" and clicks on search
    And user performs "facet selection" in "Cataloger_nofilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "demo [Schema]" attribute under "Hierarchy" facets in Item Search results page
    Then user verify "catalog not contains" any "Constraint" attribute under "Metadata Type" facets
    And user enters the search text "Cataloger_nofilter" and clicks on search
    And user performs "facet selection" in "Cataloger_nofilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AmazonRedshift" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute   | metaDataValue        | widgetName  |
      | Application Version | PostgreSQL08.00.0002 | Description |
    And user enters the search text "Cataloger_nofilter" and clicks on search
    And user performs "facet selection" in "Cataloger_nofilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Host" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                    | widgetName  |
      | Host name         | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Description |
      | Number of cores   | 0                                                                | Statistics  |
    And user enters the search text "Cataloger_nofilter" and clicks on search
    And user performs "facet selection" in "Cataloger_nofilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "world" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue        | widgetName  |
      | Storage type      | PostgreSQL08.00.0002 | Description |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC19#Verify the breadcrumb hierarchy appears correctly when JDBC cataloger is ran for Redshift Database
  Verify the Database Name should have the appropriate metadata information in IDC UI and Database

    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cataloger_nofilter" and clicks on search
    And user performs "facet selection" in "Cataloger_nofilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "referencetable1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "testfloat" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com |
      | AmazonRedshift                                                   |
      | world                                                            |
      | schematest                                                       |
      | referencetable1                                                  |
      | testfloat                                                        |
    And user enters the search text "Cataloger_nofilter" and clicks on search
    And user performs "facet selection" in "Cataloger_nofilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "world" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue        | widgetName  |
      | Storage type      | PostgreSQL08.00.0002 | Description |


  @sanity @positive
  Scenario:SC19#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

##################RunInInternalNode###################################

  @RedShift
  Scenario Outline:SC20#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                           | body                                                                  | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                                   | ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource_InternalNode.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                                   |                                                                       | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                    | ida/AmazonRedShiftPayloads/RedshiftCataloger_InternalNode.json        | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                    |                                                                       | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                       | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                                 | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                       | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                     | ida/AmazonRedShiftPayloads/RedshiftAnalyzer_InternalNode.json         | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                     |                                                                       | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                       | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                                 | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                       | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC20#Verify Redshift config gets mapped and Analyzer run successfully when specific node condition is mentioned
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cataloger_Internal" and clicks on search
    And user performs "facet selection" in "Cataloger_Internal" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "department [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "department" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
      | Number of rows    | 6             | Statistics  |


  #Need new UI Fix for Data Sampling Case#
  @RedShift @positve @regression @sanity @webtest
  Scenario:SC21#Verify the data sampling information for Redshift table
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cataloger_Internal" and clicks on search
    And user performs "facet selection" in "Cataloger_Internal" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "department [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "department" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Deptid | Deptname | Empid |
      | 100    | dept1    | 10    |
      | 100    | dept1    | 10    |
      | 200    | dept2    | 20    |
      | 200    | dept2    | 20    |
      | 300    | dept3    | 30    |
      | 300    | dept3    | 30    |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC22#Verify the data profiling metadata information for string datatype in redhisft DB
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Cataloger_Internal" and clicks on search
    And user performs "facet selection" in "Cataloger_Internal" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "department [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "deptname" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
      | Length                        | 50            | Statistics  |
      | Maximum length                | 5             | Statistics  |
      | Maximum value                 | dept3         | Statistics  |
      | Minimum length                | 5             | Statistics  |
      | Minimum value                 | dept1         | Statistics  |
      | Number of non null values     | 6             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 3             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC23#Verify the data profiling metadata information for numeric datatype
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Cataloger_Internal" and clicks on search
    And user performs "facet selection" in "Cataloger_Internal" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "department [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "empid" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | INTEGER       | Description |
      | Average                       | 20            | Statistics  |
      | Length                        | 10            | Statistics  |
      | Maximum value                 | 30            | Statistics  |
      | Median                        | 20            | Statistics  |
      | Minimum value                 | 10            | Statistics  |
      | Number of non null values     | 6             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 3             | Statistics  |
      | Standard deviation            | 8.94          | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | Variance                      | 80            | Statistics  |

  @sanity @positive
  Scenario:SC23#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |


########################################SingleSchemaMultipleTable##################################################
  @RedShift
  Scenario Outline:SC24##Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter5.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                           | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                     | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC24#Verify Redshift cataloger scans and collects data if single schema name with multiple table names are provided in filters
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cataloger_filter5" and clicks on search
    And user performs "facet selection" in "Cataloger_filter5" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "world" item from search results
    Then user performs click and verify in new window
      | Table   | value       | Action                 | RetainPrevwindow | indexSwitch |
      | Schemas | testschema  | verify widget contains | No               |             |
      | Schemas | testschema  | click and switch tab   | No               |             |
      | Tables  | department  | verify widget contains | No               |             |
      | Tables  | employee    | verify widget contains | No               |             |
      | Tables  | tag_details | verify widget contains | No               |             |


  @sanity @positive
  Scenario:SC24#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

 #########################################################################################################################################

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC25#Verify proper error message is shown if mandatory fields are not filled in RedshiftCataloger plugin configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem            |
      | mouse hover | Settings Icon         |
      | click       | Settings Icon         |
      | click       | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute               |
      | Type      | Cataloger               |
      | Plugin    | AmazonRedshiftCataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

##########################################################################################################
    #############Run SC26 1,2 & 3 combined #####################

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC26#-set Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                                             | bodyFile                                                          | path                | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/AmazonRedshiftDataSource/RedshiftDataSource                                  | payloads/ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json | $.configurations[0] | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/AmazonRedshiftDataSource/RedshiftDataSource                                  |                                                                   |                     | 200           | RedshiftDataSource |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/AmazonRedshiftDataSource/AmazonRedshiftDataSource_TEST_DEFAULT_CONFIGURATION | payloads/ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json | $.configurations[1] | 204           |                    |          |

  @RedShift
  Scenario Outline:SC26# Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter8.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                           | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                     | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/RedshiftAnalyzer_filter1.json  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                           | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                     | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |

#  @RedShift @positve @regression @sanity @webtest
#  Scenario:SC26# Verify the Analyzer analyze data if schema name and table name is mentioned with filter mode as Include
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Cataloger_filter8" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter8" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "tag_details [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "employee_id" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute             | metaDataValue | widgetName  |
#      | Data type                     | INTEGER       | Description |
#      | Average                       | 11            | Statistics  |
#      | Length                        | 10            | Statistics  |
#      | Maximum value                 | 13            | Statistics  |
#      | Median                        | 11            | Statistics  |
#      | Minimum value                 | 10            | Statistics  |
#      | Number of non null values     | 4             | Statistics  |
#      | Percentage of non null values | 100           | Statistics  |
#      | Number of null values         | 0             | Statistics  |
#      | Number of unique values       | 4             | Statistics  |
#      | Standard deviation            | 1.29          | Statistics  |
#      | Percentage of unique values   | 100           | Statistics  |
#      | Variance                      | 1.67          | Statistics  |

  @RedShift @positve @regression @sanity
  Scenario:SC26# Verify the Analyzer analyze data if schema name and table name is mentioned with filter mode as Include
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                                      | Action                    | query                    | ClusterName                                                      | ServiceName    | DatabaseName | SchemaName | TableName/Filename | columnName/FieldName |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Description | metadataValuePresence     | EDIColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Lifecycle   | metadataAttributePresence | EDIColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Statistics  | metadataValuePresence     | EDIColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |


  @sanity @positive
  Scenario:SC26#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

#####################################################IncludeSchemaWIthMultipleTable###################################################
  @RedShift
  Scenario Outline:SC27# Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter9.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                           | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                     | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/RedshiftAnalyzer_filter2.json  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                           | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                     | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |

#  @RedShift @positve @regression @sanity @webtest
#  Scenario:SC27# Verify the Analyzer analyze data if schema name and multiple table name is mentioned with filter mode as Include
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Cataloger_filter9" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter9" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "tag_details [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "employee_id" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute             | metaDataValue | widgetName  |
#      | Data type                     | INTEGER       | Description |
#      | Average                       | 11            | Statistics  |
#      | Length                        | 10            | Statistics  |
#      | Maximum value                 | 13            | Statistics  |
#      | Median                        | 11            | Statistics  |
#      | Minimum value                 | 10            | Statistics  |
#      | Number of non null values     | 4             | Statistics  |
#      | Percentage of non null values | 100           | Statistics  |
#      | Number of null values         | 0             | Statistics  |
#      | Number of unique values       | 4             | Statistics  |
#      | Standard deviation            | 1.29          | Statistics  |
#      | Percentage of unique values   | 100           | Statistics  |
#      | Variance                      | 1.67          | Statistics  |
#    And user enters the search text "deptname" and clicks on search
#    And user performs "facet selection" in "department [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "deptname" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute             | metaDataValue | widgetName  |
#      | Data type                     | VARCHAR       | Description |
#      | Length                        | 50            | Statistics  |
#      | Maximum length                | 5             | Statistics  |
#      | Maximum value                 | dept3         | Statistics  |
#      | Minimum length                | 5             | Statistics  |
#      | Minimum value                 | dept1         | Statistics  |
#      | Number of non null values     | 6             | Statistics  |
#      | Percentage of non null values | 100           | Statistics  |
#      | Number of null values         | 0             | Statistics  |
#      | Number of unique values       | 3             | Statistics  |
#      | Percentage of unique values   | 50            | Statistics  |
#
#  @RedShift @positve @regression @sanity @webtest
#  Scenario:SC28# Verify the Analyzer analyze data if schema name and table name is mentioned with filter mode as Include
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user enters the search text "Cataloger_filter9" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter9" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "department [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "empid" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute             | metaDataValue | widgetName  |
#      | Data type                     | INTEGER       | Description |
#      | Average                       | 20            | Statistics  |
#      | Length                        | 10            | Statistics  |
#      | Maximum value                 | 30            | Statistics  |
#      | Median                        | 20            | Statistics  |
#      | Minimum value                 | 10            | Statistics  |
#      | Number of non null values     | 6             | Statistics  |
#      | Percentage of non null values | 100           | Statistics  |
#      | Number of null values         | 0             | Statistics  |
#      | Standard deviation            | 8.94          | Statistics  |
#      | Number of unique values       | 3             | Statistics  |
#      | Percentage of unique values   | 50            | Statistics  |
#      | Variance                      | 80            | Statistics  |

  @RedShift @positve @regression @sanity
  Scenario:SC27# Verify the Analyzer analyze data if schema name and multiple table name is mentioned with filter mode as Include
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                                      | Action                    | query                 | ClusterName                                                      | ServiceName    | DatabaseName | SchemaName | TableName/Filename | columnName/FieldName |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Description | metadataValuePresence     | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Statistics  | metadataValuePresence     | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.department.Columns.deptname_analyzed.Description     | metadataValuePresence     | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | department         | deptname             |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.department.Columns.deptname_analyzed.Lifecycle       | metadataAttributePresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | department         | deptname             |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.department.Columns.deptname_analyzed.Statistics      | metadataValuePresence     | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | department         | deptname             |

  @RedShift @positve @regression @sanity
  Scenario:SC28# Verify the Analyzer analyze data if schema name and table name is mentioned with filter mode as Include
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                                | Action                    | query                 | ClusterName                                                      | ServiceName    | DatabaseName | SchemaName | TableName/Filename | columnName/FieldName |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.empid.Description | metadataValuePresence     | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | department         | empid                |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.empid.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | department         | empid                |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.empid.Statistics  | metadataValuePresence     | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | department         | empid                |

  @sanity @positive
  Scenario:SC28#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

#############################################################ExcludeSchemaAndTable######################################################
#  @RedShift @positve @regression @sanity @webtest
#  Scenario:SC29# Run plugin and Verify data is analyzed if schema name and table name is mentioned with filter mode as Exclude
#    Given Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                                        | body                                                      | response code | response message  | jsonPath                                               |
#      |        |       |       | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter5.json | 204           |                   |                                                        |
#      |        |       |       | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                           | 200           | RedShiftCataloger |                                                        |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   |                                                           | 200           |                   |                                                        |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
#      |        |       |       | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/RedshiftAnalyzer_filter3.json  | 204           |                   |                                                        |
#      |        |       |       | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                           | 200           | RedshiftAnalyzer  |                                                        |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
#      |        |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  |                                                           | 200           |                   |                                                        |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Cataloger_filter5" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter5" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "department [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "deptid" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Data type         | INTEGER       | Description |
#      | Length            | 10            | Statistics  |
#    And user clicks on search icon
#    And user performs "facet selection" in "tag_details [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
#    Then the following tags "Redshift,Cataloger_filter5" should get displayed for the column "employee_id"
#    And user performs "item click" on "employee_id" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute             | metaDataValue | widgetName  |
#      | Data type                     | INTEGER       | Description |
#      | Average                       | 11            | Statistics  |
#      | Length                        | 10            | Statistics  |
#      | Maximum value                 | 13            | Statistics  |
#      | Median                        | 11            | Statistics  |
#      | Minimum value                 | 10            | Statistics  |
#      | Number of non null values     | 4             | Statistics  |
#      | Percentage of non null values | 100           | Statistics  |
#      | Number of null values         | 0             | Statistics  |
#      | Number of unique values       | 4             | Statistics  |
#      | Standard deviation            | 1.29          | Statistics  |
#      | Percentage of unique values   | 100           | Statistics  |
#      | Variance                      | 1.67          | Statistics  |
#
#  @RedShift @positve @regression @sanity @webtest
#  Scenario:SC30# Verify the Analyzer analyze data if schema name and table name is mentioned with filter mode as Exclude
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Cataloger_filter5" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter5" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "employee [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "empid" item from search results
#    And user "verify metadata properties" section does not have the following values
#      | metaDataAttribute         | widgetName |
#      | Number of non null values | Statistics |
#      | Maximum Value             | Statistics |
#      | Minimum Value             | Statistics |
#      | Standard deviation        | Statistics |
#      | Variance                  | Statistics |
#      | Last Analyzed At          | Lifecycle  |

  @RedShift @positve @regression @sanity
  Scenario Outline:SC29# Run plugin and Verify data is analyzed if schema name and table name is mentioned with filter mode as Exclude
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                       | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter5.jsonn | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                            | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                            | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                      | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                            | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/RedshiftAnalyzer_filter3.json   | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                            | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                            | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                      | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                            | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |

  @RedShift @positve @regression @sanity
  Scenario:SC29# Verify the Analyzer analyze data if schema name and multiple table name is  mentioned with filter mode as Include
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                                      | Action                    | query                 | ClusterName                                                      | ServiceName    | DatabaseName | SchemaName | TableName/Filename | columnName/FieldName |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Description | metadataValuePresence     | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Statistics  | metadataValuePresence     | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |


  @RedShift @positve @regression @sanity
  Scenario:SC30# Verify the Analyzer analyze data if schema name and table name is not mentioned with filter mode as Exclude
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                                  | Action                       | query                 | ClusterName                                                      | ServiceName    | DatabaseName | SchemaName | TableName/Filename | columnName/FieldName |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.employee.Columns.empid.Description      | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | employee           | empid                |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.employee.Columns.empid.Lifecycle        | metadataAttributeNonPresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | employee           | empid                |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.employee.Columns.empid.Statistics       | metadataAttributeNonPresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | employee           | empid                |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.department.Columns.deptname.Description | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | department         | deptname             |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.department.Columns.deptname.Lifecycle   | metadataAttributeNonPresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | department         | deptname             |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.department.Columns.deptname.Statistics  | metadataAttributeNonPresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | department         | deptname             |

  @sanity @positive
  Scenario:SC30#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |


    ################################################IncludeSchemaNameWithMultipleTable#########################################
#  @RedShift @positve @regression @sanity @webtest @MLP-12887
#  Scenario:SC31# Verify the Analyzer analyze data if schema name and multiple table name is mentioned with filter mode as Include
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                                        | body                                                                    | response code | response message  | jsonPath                                               |
#      | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                                | ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json                | 204           |                   |                                                        |
#      |                  |       |       | Get          | settings/analyzers/AmazonRedshiftDataSource                                                |                                                                         | 200           |                   |                                                        |
#      |                  |       |       | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter5.json               | 204           |                   |                                                        |
#      |                  |       |       | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                                         | 200           | RedShiftCataloger |                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   |                                                                         | 200           |                   |                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
#      |                  |       |       | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/RedshiftAnalyzer_Multiplefilter_Include.json | 204           |                   |                                                        |
#      |                  |       |       | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                         | 200           | RedshiftAnalyzer  |                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  |                                                                         | 200           |                   |                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Cataloger_filter5" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter5" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "tag_details [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "employee_id" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute             | metaDataValue | widgetName  |
#      | Data type                     | INTEGER       | Description |
#      | Average                       | 11            | Statistics  |
#      | Length                        | 10            | Statistics  |
#      | Maximum value                 | 13            | Statistics  |
#      | Median                        | 11            | Statistics  |
#      | Minimum value                 | 10            | Statistics  |
#      | Number of non null values     | 4             | Statistics  |
#      | Percentage of non null values | 100           | Statistics  |
#      | Number of null values         | 0             | Statistics  |
#      | Number of unique values       | 4             | Statistics  |
#      | Standard deviation            | 1.29          | Statistics  |
#      | Percentage of unique values   | 100           | Statistics  |
#      | Variance                      | 1.67          | Statistics  |
#    And user clicks on search icon
#    And user performs "facet selection" in "department [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "deptname" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute             | metaDataValue | widgetName  |
#      | Data type                     | VARCHAR       | Description |
#      | Length                        | 50            | Statistics  |
#      | Maximum length                | 5             | Statistics  |
#      | Maximum value                 | dept3         | Statistics  |
#      | Minimum length                | 5             | Statistics  |
#      | Minimum value                 | dept1         | Statistics  |
#      | Number of non null values     | 6             | Statistics  |
#      | Percentage of non null values | 100           | Statistics  |
#      | Number of null values         | 0             | Statistics  |
#      | Number of unique values       | 3             | Statistics  |
#      | Percentage of unique values   | 50            | Statistics  |
#    And user clicks on search icon
#    And user performs "facet selection" in "employee [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "empid" item from search results
#    And user "verify metadata properties" section does not have the following values
#      | metaDataAttribute | widgetName |
#      | Maximum Value     | Statistics |
#      | Minimum Value     | Statistics |
#      | Last Analyzed At  | Lifecycle  |

  #############################################################ExcludeSchemaAndTable######################################################
  @RedShift @positve @regression @sanity @MLP-12887
  Scenario Outline:SC31# Verify the Analyzer analyze data if schema name and multiple table name is mentioned with filter mode as Include
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                    | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter5.json               | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                                         | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                                   | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/RedshiftAnalyzer_Multiplefilter_Include.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                         | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                                   | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |

  @RedShift @positve @regression @sanity
  Scenario:SC31_1# Verify the Analyzer analyze data if schema name and multiple table name is mentioned with filter mode as Include
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                                           | Action                    | query                 | ClusterName                                                      | ServiceName    | DatabaseName | SchemaName | TableName/Filename | columnName/FieldName |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Description      | metadataValuePresence     | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Lifecycle        | metadataAttributePresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Statistics       | metadataValuePresence     | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.department.Columns.deptname_analyzed.Description | metadataValuePresence     | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | department         | deptname             |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.department.Columns.deptname_analyzed.Lifecycle   | metadataAttributePresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | department         | deptname             |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.department.Columns.deptname_analyzed.Statistics  | metadataValuePresence     | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | department         | deptname             |


  @sanity @positive
  Scenario:SC31#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

    ##########################################ExcludeMultipleFilter#####################################################
#  @RedShift @positve @regression @sanity @webtest @MLP-12887
#  Scenario:SC32# Verify the Redshift Analyzer analyze data if multiple filters are provided with mode as Exclude
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                                        | body                                                                    | response code | response message  | jsonPath                                               |
#      | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                                | ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json                | 204           |                   |                                                        |
#      |                  |       |       | Get          | settings/analyzers/AmazonRedshiftDataSource                                                |                                                                         | 200           |                   |                                                        |
#      |                  |       |       | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter6.json               | 204           |                   |                                                        |
#      |                  |       |       | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                                         | 200           | RedShiftCataloger |                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   |                                                                         | 200           |                   |                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
#      |                  |       |       | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/RedshiftAnalyzer_Multiplefilter_Exclude.json | 204           |                   |                                                        |
#      |                  |       |       | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                         | 200           | RedshiftAnalyzer  |                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  |                                                                         | 200           |                   |                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Cataloger_filter6" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter6" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "tag_details [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "employee_id" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute             | metaDataValue | widgetName  |
#      | Data type                     | INTEGER       | Description |
#      | Average                       | 11            | Statistics  |
#      | Length                        | 10            | Statistics  |
#      | Maximum value                 | 13            | Statistics  |
#      | Median                        | 11            | Statistics  |
#      | Minimum value                 | 10            | Statistics  |
#      | Number of non null values     | 4             | Statistics  |
#      | Percentage of non null values | 100           | Statistics  |
#      | Number of null values         | 0             | Statistics  |
#      | Number of unique values       | 4             | Statistics  |
#      | Standard deviation            | 1.29          | Statistics  |
#      | Percentage of unique values   | 100           | Statistics  |
#      | Variance                      | 1.67          | Statistics  |
#    And user clicks on search icon
#    And user performs "facet selection" in "country [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "headofstate" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute             | metaDataValue | widgetName  |
#      | Data type                     | VARCHAR       | Description |
#      | Maximum length                | 13            | Statistics  |
#      | Length                        | 256           | Statistics  |
#      | Maximum value                 | Mohammad Omar | Statistics  |
#      | Minimum length                | 7             | Statistics  |
#      | Minimum value                 | Beatrix       | Statistics  |
#      | Number of non null values     | 3             | Statistics  |
#      | Percentage of non null values | 100           | Statistics  |
#      | Number of null values         | 0             | Statistics  |
#      | Number of unique values       | 2             | Statistics  |
#      | Percentage of unique values   | 66.67         | Statistics  |
#    And user clicks on search icon
#    And user performs "facet selection" in "employee [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "employee" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Table Type        | TABLE         | Description |
#    And user clicks on search icon
#    And user performs "facet selection" in "employee [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "eaddress" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Data type         | VARCHAR       | Description |
#      | Length            | 20            | Statistics  |
#    And user clicks on search icon
#    And user performs "facet selection" in "city [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "population" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Data type         | INTEGER       | Description |
#      | Length            | 10            | Statistics  |

  @RedShift @positve @regression @sanity @MLP-12887
  Scenario Outline:SC32# Verify the Redshift Analyzer analyze data if multiple filters are provided with mode as Exclude
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                           | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter6.json                      | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                                                | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                                          | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/RedshiftAnalyzer_Multiplefilter_IncludeExclude.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                                | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                                          | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |


  @RedShift @positve @regression @sanity
  Scenario:SC32_1# Verify the Redshift Analyzer analyze data if multiple filters are provided with mode as Exclude
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                                      | Action                       | query                 | ClusterName                                                      | ServiceName    | DatabaseName | SchemaName | TableName/Filename | columnName/FieldName |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Description | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.country.Columns.headofstate.Description     | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | demo       | country            | headofstate          |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.country.Columns.headofstate.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | demo       | country            | headofstate          |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.country.Columns.headofstate.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | demo       | country            | headofstate          |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.employee.Columns.empid.Description          | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | employee           | empid                |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.employee.Columns.empid.Lifecycle            | metadataAttributeNonPresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | employee           | empid                |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.employee.Columns.empid.Statistics           | metadataAttributeNonPresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | employee           | empid                |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.employee.Columns.eaddress.Description       | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | employee           | eaddress             |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.employee.Columns.eaddress.Lifecycle         | metadataAttributeNonPresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | employee           | eaddress             |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.employee.Columns.eaddress.Statistics        | metadataAttributeNonPresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | employee           | eaddress             |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.city.Columns.population.Description         | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | demo       | city               | population           |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.city.Columns.population.Lifecycle           | metadataAttributeNonPresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | demo       | city               | population           |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.city.Columns.population.Statistics          | metadataAttributeNonPresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | demo       | city               | population           |


  @sanity @positive
  Scenario:SC32#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

     ##########################################ExcludeMultipleFilter#####################################################
  @RedShift @positve @regression @sanity @webtest @MLP-12887
  Scenario:SC33#Verify the Redshift Analyzer analyze data if multiple filters are provided with mode as Include/Exclude
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                        | body                                                                           | response code | response message  | jsonPath                                               |
      | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/RedshiftCataloger_filter6.json                      | 204           |                   |                                                        |
      |                  |       |       | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                                                | 200           | RedShiftCataloger |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   |                                                                                | 200           |                   |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      |                  |       |       | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/RedshiftAnalyzer_Multiplefilter_IncludeExclude.json | 204           |                   |                                                        |
      |                  |       |       | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                                | 200           | RedshiftAnalyzer  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  |                                                                                | 200           |                   |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |

#  @webtest
#  Scenario: SC33#Validate the metadata values in IDC UI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Cataloger_filter6" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter6" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "tag_details [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "employee_id" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute             | metaDataValue | widgetName  |
#      | Data type                     | INTEGER       | Description |
#      | Average                       | 11            | Statistics  |
#      | Length                        | 10            | Statistics  |
#      | Maximum value                 | 13            | Statistics  |
#      | Median                        | 11            | Statistics  |
#      | Minimum value                 | 10            | Statistics  |
#      | Number of non null values     | 4             | Statistics  |
#      | Percentage of non null values | 100           | Statistics  |
#      | Number of null values         | 0             | Statistics  |
#      | Number of unique values       | 4             | Statistics  |
#      | Standard deviation            | 1.29          | Statistics  |
#      | Percentage of unique values   | 100           | Statistics  |
#      | Variance                      | 1.67          | Statistics  |
#    And user clicks on search icon
#    And user performs "facet selection" in "country [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "code" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute             | metaDataValue | widgetName  |
#      | Data type                     | CHAR          | Description |
#      | Length                        | 3             | Statistics  |
#      | Maximum length                | 3             | Statistics  |
#      | Maximum value                 | NLD           | Statistics  |
#      | Minimum length                | 3             | Statistics  |
#      | Minimum value                 | ABW           | Statistics  |
#      | Number of non null values     | 3             | Statistics  |
#      | Percentage of non null values | 100           | Statistics  |
#      | Number of null values         | 0             | Statistics  |
#      | Number of unique values       | 3             | Statistics  |
#      | Percentage of unique values   | 100           | Statistics  |
#    And user clicks on search icon
#    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "employee" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Table Type        | TABLE         | Description |
#    And user clicks on search icon
#    And user performs "facet selection" in "employee [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "eaddress" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Data type         | VARCHAR       | Description |
#      | Length            | 20            | Statistics  |
#    And user clicks on search icon
#    And user performs "facet selection" in "city [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "city" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Table Type        | TABLE         | Description |
#    And user clicks on search icon
#    And user performs "facet selection" in "city [Table]" attribute under "Hierarchy" facets in Item Search results page
#    And user performs "item click" on "countrycode" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Data type         | CHAR          | Description |

  @RedShift @positve @regression @sanity
  Scenario: SC33#Validate the metadata values in IDC UI
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                                      | Action                       | query                 | ClusterName                                                      | ServiceName    | DatabaseName | SchemaName | TableName/Filename | columnName/FieldName |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Description | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Lifecycle   | metadataAttributePresence    | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.tag_details.Columns.employee_id.Statistics  | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | tag_details        | employee_id          |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.country.Columns.headofstate.Description     | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | demo       | country            | headofstate          |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.country.Columns.headofstate.Lifecycle       | metadataAttributePresence    | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | demo       | country            | headofstate          |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.country.Columns.headofstate.Statistics      | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | demo       | country            | headofstate          |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.employee.Columns.eaddress.Description       | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | employee           | eaddress             |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.employee.Columns.eaddress.Lifecycle         | metadataAttributeNonPresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | employee           | eaddress             |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.employee.Columns.eaddress.Statistics        | metadataAttributeNonPresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | employee           | eaddress             |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.city.Columns.countrycode.Description        | metadataValuePresence        | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | demo       | city               | countrycode          |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.city.Columns.countrycode.Lifecycle          | metadataAttributeNonPresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | demo       | city               | countrycode          |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.city.Columns.countrycode.Statistics         | metadataAttributeNonPresence | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | demo       | city               | countrycode          |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.demo.Table.city.Description                 | metadataValuePresence        | TableQuerywithSchema  | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | demo       | city               |                      |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.demo.Table.city.Lifecycle                   | metadataAttributeNonPresence | TableQuerywithSchema  | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | demo       | city               |                      |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.testschema.Table.employee.Description       | metadataValuePresence        | TableQuerywithSchema  | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | employee           |                      |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.testschema.Table.employee.Lifecycle         | metadataAttributeNonPresence | TableQuerywithSchema  | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | employee           |                      |


  @sanity @positive
  Scenario:SC33#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

    ######################################################DataSample/TopValues/HistogramBuckets##############################################################
  #Bug MLP-14440 raised for this scenario
  @webtest @jdbc @MLP-14019
  Scenario:SC34#Verify proper error message is thrown in UI if Sample Data count/Top Values/Histogram Buckets values are not provided within valid range in AmazonRedshiftAnalyzer
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
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute              |
      | Type      | Dataanalyzer           |
      | Plugin    | AmazonRedshiftAnalyzer |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample data count     | 1001                   |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                               |
      | Sample data count | Value of Sample data count should not be greater than 1000 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample data count     | 9                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                            |
      | Sample data count | Value of Sample data count should not be lesser than 10 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            | 4                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName  | errorMessage                                    |
      | Top values | Value of Top values should not be lesser than 5 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            | 31                     |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName  | errorMessage                                      |
      | Top values | Value of Top values should not be greater than 30 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     | 4                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                           |
      | Histogram buckets | Value of Histogram buckets should not be lesser than 5 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     | 21                     |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                             |
      | Histogram buckets | Value of Histogram buckets should not be greater than 20 |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  ###########################################6848558VerifyTablleTypeViewGetsCollected################################################
#  @RedShift @positve @regression @sanity @webtest @IDA_E2E
#  Scenario:SC35#Verify Table Type View gets collected under Table Type when RedshiftCataloger plugin is ran
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                                       | body                                                     | response code | response message  | jsonPath                                               |
#      | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json | 204           |                   |                                                        |
#      |                  |       |       | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                          | 200           |                   |                                                        |
#      |                  |       |       | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/RedshiftCataloger_Views.json  | 204           |                   |                                                        |
#      |                  |       |       | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                          | 200           | RedShiftCataloger |                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                          | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                          | 200           |                   |                                                        |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                          | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Cataloger_Views" and clicks on search
#    And user performs "facet selection" in "Cataloger_Views" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "world" item from search results
#    Then user performs click and verify in new window
#      | Table   | value      | Action                 | RetainPrevwindow | indexSwitch |
#      | Schemas | testschema | verify widget contains | No               |             |
#      | Schemas | testschema | click and switch tab   | No               |             |
#    And user connect to the database and execute query for the following parameters
#      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField        | columnName | queryOperation   | storeResults  |
#      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTables | table_name | returnstringlist | resultsInList |
#    And user "verifies" the "Tables" Item view page result "list" value with Postgres DB
#    And user enters the search text "viewexternalcity" and clicks on search
#    And user clicks on search icon
#    And user enters the search text "Cataloger_Views" and clicks on search
#    And user performs "facet selection" in "Cataloger_Views" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "viewexternalcity" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName  |
#      | Last catalogued at | Lifecycle   |
#      | Created by         | Description |
#    And the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Table Type        | VIEW          | Description |
#    And user performs click and verify in new window
#      | Table     | value            | Action               | RetainPrevwindow | indexSwitch |
#      | SQLSource | viewexternalcity | click and switch tab | No               |             |
#    Then user "verify metadata properties" section has following values
#      | Data |
#
#    ##Bug id - 23448
#  @RedShift @positve @regression @sanity @webtest @MLP-12887
#  Scenario:SC36# Verify the data profiling happens for string,numeric,date,time,timestamp datatype columns for Views and should have the appropriate metadata information in IDC UI and Database
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                                        | body                                             | response code | response message | jsonPath                                              |
#      | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/RedshiftAnalyzer.json | 204           |                  |                                                       |
#      |                  |       |       | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                  | 200           | RedshiftAnalyzer |                                                       |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                  | 200           | IDLE             | $.[?(@.configurationName=='RedshiftAnalyzer')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  |                                                  | 200           |                  |                                                       |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                  | 200           | IDLE             | $.[?(@.configurationName=='RedshiftAnalyzer')].status |
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Cataloger_Views" and clicks on search
#    And user performs "facet selection" in "Cataloger_Views" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "viewexternalcity" item from search results
#    Then user performs click and verify in new window
#      | Table   | value       | Action                 | RetainPrevwindow | indexSwitch |
#      | Columns | countrycode | verify widget contains | No               |             |
#      | Columns | countrycode | click and switch tab   | No               |             |
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute             | metaDataValue | widgetName  |
#      | Data type                     | VARCHAR       | Description |
#      | Length                        | 256           | Statistics  |
#      | Maximum length                | 3             | Statistics  |
#      | Maximum value                 | NLD           | Statistics  |
#      | Minimum length                | 3             | Statistics  |
#      | Minimum value                 | AFG           | Statistics  |
#      | Number of non null values     | 10            | Statistics  |
#      | Percentage of non null values | 100           | Statistics  |
#      | Number of null values         | 0             | Statistics  |
#      | Number of unique values       | 2             | Statistics  |
#      | Percentage of unique values   | 20            | Statistics  |
#
#
#    #6866019
#  @RedShift @positve @regression @sanity @webtest
#  Scenario:SC37#Verify the data sampling information for Redshift table
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Cataloger_Views" and clicks on search
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "viewtagdetails" item from search results
#    And user "navigatesToTab" name "Data Sample" in item view page
#    Then following "Data Sample" values should get displayed in item view page
#      | Ip_address    | Ssn         | State | Full_name      | Employee_id | Gender | Email            | Postal_code | Phone_number |
#      | 255.249.255.0 | 345-53-3222 | DC    | Alex Ferguson  | 10          | m      | fergie@gmail.com | 46576       | 515.123.4568 |
#      | 255.249.12.0  | 345-53-3779 | TX    | Jones Campbell | 11          | f      | cambie@gmail.com | 46581       | 515.123.4356 |
#      | 255.83.45.0   | 315-53-3222 | NY    | Lionel Messi   | 12          | m      | lmessi@gmail.com | 78576       | 515.123.6666 |
#      | 255.71.255.56 | 345-66-3222 | VI    | Irina Shayk    | 13          | f      | ishayk@gmail.com | 48276       | 515.123.2580 |
#
#
#    #6866022
#  @RedShift @positve @regression @sanity @webtest
#  Scenario:SC38#Verify the Createdby and Tabletype should not be overriden for Views when Redshiftanalyzer is ran successfully.
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Cataloger_Views" and clicks on search
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "viewdiffdatatypes" item from search results
#    Then user "verify metadata attributes" section has following values
#      | metaDataAttribute  | widgetName |
#      | Last catalogued at | Lifecycle  |
#      | Last analyzed at   | Lifecycle  |
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Table Type        | VIEW          | Description |
#      | Created by        | master        | Description |
#      | Number of rows    | 5             | Statistics  |

  @RedShift @positve @regression @sanity @MLP-12887
  Scenario Outline:SC32# Verify Table Type View gets collected under Table Type when RedshiftCataloger plugin is ran
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                    | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/RedshiftCataloger_Views.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                         | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                   | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/RedshiftAnalyzer.json        | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                         | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                   | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                         | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |



  ##################################################################################Data Sampling################################################################################################

  @AmazonRedshift
  Scenario Outline:SC37:user get the Dynamic ID's (Table ID) for the Table name "viewtagdetails" with Different schemas
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                            | asg_scopeid | targetFile                                         | jsonpath                          |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | world,testschema,viewtagdetails |             | payloads/ida/AmazonRedShiftPayloads/API/items.json | $.Tables.TableName.viewtagdetails |

  @AmazonRedshift
  Scenario Outline: SC37:user hits the TableID's and save the DataSample Values for (duplicate schema , duplicate tables, Only Tables and Different Schema)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                         | inputFile                                          | outPutFile                                                         | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables.TableName.viewtagdetails | payloads/ida/AmazonRedShiftPayloads/API/items.json | payloads\ida\AmazonRedShiftPayloads\API\Actual\viewtagdetails.json |            |

  @TEST_MLPQA-3019 @MLPQA-17486 @7270915 @TEST_MLPQA-3024 @MLPQA-17486 @7270910 @AmazonRedshift
  Scenario: SC#37 MLP_24048_Verify data sampling and profiling happens properly when duplicate schema , duplicate tables, Only Tables and Different Schema are provided in filters
    Then file content in "ida\AmazonRedShiftPayloads\API\Actual\viewtagdetails.json" should be same as the content in "ida\AmazonRedShiftPayloads\API\Expected\viewtagdetails.json"

#################################################################################Data profiling########################################################################################################


  @RedShift @positve @regression @sanity
  Scenario: SC38#Verify the Createdby and Tabletype should not be overriden for Views when Redshiftanalyzer is ran successfully,
  Verify the data profiling happens for string,numeric,date,time,timestamp datatype columns for Views and should have the appropriate metadata
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                                           | Action                    | query                 | ClusterName                                                      | ServiceName    | DatabaseName | SchemaName | TableName/Filename | columnName/FieldName |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.viewexternalcity.Columns.countrycode.Description | metadataValuePresence     | ColumnQuerywithSchema | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | viewexternalcity   | countrycode          |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.testschema.Table.viewdiffdatatypes.Description   | metadataValuePresence     | TableQuerywithSchema  | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | viewdiffdatatypes  |                      |
      | Lifecycle   | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.testschema.Table.viewdiffdatatypes.Lifecycle     | metadataAttributePresence | TableQuerywithSchema  | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | viewdiffdatatypes  |                      |
      | Statistics  | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.testschema.Table.viewdiffdatatypes.Statistics    | metadataValuePresence     | TableQuerywithSchema  | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | AmazonRedshift | world        | testschema | viewdiffdatatypes  |                      |


  @sanity @positive
  Scenario:SC38#user retrieves the total items for a catalog and copy to a json file
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |


#
#   #####################################InvalidDataSource#####################################
#  Scenario Outline:SC39#Run the Redshift cataloger with invalid DataSource configuration
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                 | response code | response message   | jsonPath                                               |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/AmazonRedShiftPayloads/AmazonRedshiftInvalidDataSource.json      | 204           |                    |                                                        |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                                      | 200           | RedshiftDataSource |                                                        |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/RedshiftCataloger_InvalidCredentials.json | 204           |                    |                                                        |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                      | 200           | RedShiftCataloger  |                                                        |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                                | 200           |                    |                                                        |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                      | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |
#
#
#  @webtest
#  Scenario:SC39#Validate the processed count and processed widget item presence in platform
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "AmazonRedshift_BA" and clicks on search
#    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Analysis |
#    And user performs "latest analysis click" in Item Results page for "cataloger/AmazonRedshiftCataloger/RedShiftCataloger%"
#    Then the following metadata values should be displayed
#      | metaDataAttribute         | metaDataValue | widgetName  |
#      | Number of processed items | 0             | Description |
#      | Number of errors          | 2             | Description |
#    And user "widget not present" on "Processed Items" in Item view page
#    And user performs click and verify in new window
#      | Table | value | Action               | RetainPrevwindow | indexSwitch |
#      | Data  | log   | click and switch tab | No               |             |
#    Then Analysis log "cataloger/AmazonRedshiftCataloger/RedShiftCataloger%" should display below info/error/warning
#      | type  | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | logCode             | pluginName              | removableText |
#      | INFO  | 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: --- 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: name: "RedShiftCataloger" 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginVersion: "LATEST" 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: label: null 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: catalogName: "Default" 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: eventClass: null 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: eventCondition: null 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: nodeCondition: "name==\"LocalNode\"" 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: maxWorkSize: 100 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: tags: 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - "Cataloger_filter1" 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginType: "cataloger" 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: dataSource: "RedshiftDataSource" 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: credential: "InvalidCredentials" 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: businessApplicationName: "AmazonRedshift_BA" 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: dryRun: false 2020-08-17 14:26:56.521 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: schedule: null 2020-04-02 14:50:10.136 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: filter: null 2020-04-02 14:50:10.137 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginName: "AmazonRedshiftCataloger" 2020-04-02 14:50:10.137 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: schemas: 2020-04-02 14:50:10.137 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - schema: "testschema" 2020-04-02 14:50:10.137 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: tables: 2020-04-02 14:50:10.137 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - table: "employee" 2020-04-02 14:50:10.137 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: incremental: false 2020-04-02 14:50:10.137 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: type: "Cataloger" 2020-04-02 14:50:10.137 INFO - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: properties: [] | ANALYSIS-0073       | AmazonRedshiftCataloger |               |
#      | INFO  | Plugin AmazonRedshiftCataloger Start Time:2020-03-20 10:35:57.145, End Time:2020-03-20 10:36:07.511, Processed Count:0, Errors:2, Warnings:0 2020-03-20 10:36:07.511                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ANALYSIS-0072       | AmazonRedshiftCataloger |               |
#      | ERROR | No JDBC connection could be established                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | ANALYSIS-JDBC-0003: |                         |               |
#
#
#    ###############################################InvalidSchema################################################
#  Scenario Outline:SC40#Run the Plugin configurations for DataSource and AmazonS3Cataloger
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                           | response code | response message   | jsonPath                                               |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                               | ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json       | 204           |                    |                                                        |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                               |                                                                | 200           | RedshiftDataSource |                                                        |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/RedshiftCatalogerInvalidSchema.json | 204           |                    |                                                        |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                | 200           | RedShiftCataloger  |                                                        |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                          | 200           |                    |                                                        |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                | 200           | IDLE               | $.[?(@.configurationName=='RedShiftCataloger')].status |
#
#  @webtest
#  Scenario:SC40#Validate the processed count and processed widget item presence in platform for invalid schema in configuration
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "AmazonRedshift_BA" and clicks on search
#    And user performs "facet selection" in "Cataloger_InvalidSchema" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Analysis |
#    And user performs "latest analysis click" in Item Results page for "cataloger/AmazonRedshiftCataloger/RedShiftCataloger%"
#    Then the following metadata values should be displayed
#      | metaDataAttribute         | metaDataValue | widgetName  |
#      | Number of processed items | 0             | Description |
#      | Number of errors          | 0             | Description |
#    And user "widget not present" on "Processed Items" in Item view page
#    And user performs click and verify in new window
#      | Table | value | Action               | RetainPrevwindow | indexSwitch |
#      | Data  | log   | click and switch tab | No               |             |
#    Then Analysis log "cataloger/AmazonRedshiftCataloger/RedShiftCataloger%" should display below info/error/warning
#      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | logCode       | pluginName        | removableText |
#      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0019 |                   |               |
#      | INFO | ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: ---  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: name: "RedShiftCataloger"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginVersion: "LATEST"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: label: null  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: auditFields:  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: createdBy: "TestSystem"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: createdAt: "2021-03-12T10:34:40.862"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: modifiedBy: "TestSystem"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: modifiedAt: "2021-03-16T17:36:58.367"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: catalogName: "Default"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: eventClass: null  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: eventCondition: null  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: nodeCondition: "name==\"LocalNode\""  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: maxWorkSize: 100  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: tags:  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - "Cataloger_InvalidSchema"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginType: "cataloger"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: dataSource: "RedshiftDataSource"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: credential: "Redshift_Credentials"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: businessApplicationName: "AmazonRedshift_BA"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: schedule: null  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: filter: null  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: dryRun: false  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginName: "AmazonRedshiftCataloger"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: schemas:  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - schema: "xyzabc"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: tables:  2021-03-16 17:37:16.117 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - table: "employee"  2021-03-16 17:37:16.117 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: incremental: false  2021-03-16 17:37:16.117 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: type: "Cataloger"  2021-03-16 17:37:16.117 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: properties: [] | ANALYSIS-0073 | RedShiftCataloger |               |
#      | INFO | Plugin AmazonRedshiftCataloger Start Time:2021-03-16 17:37:16.114, End Time:2021-03-16 17:37:18.694, Errors:0, Warnings:1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ANALYSIS-0072 | RedShiftCataloger |               |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.138)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0020 |                   |               |


  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC39#- Set invalid DataSource configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                            | bodyFile                                                                 | path                | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/AmazonRedshiftDataSource/RedshiftDataSource | payloads/ida/AmazonRedShiftPayloads/AmazonRedshiftInvalidDataSource.json | $.configurations[0] | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/AmazonRedshiftDataSource/RedshiftDataSource |                                                                          |                     | 200           | RedshiftDataSource |          |

  @RedShift @positve @regression @sanity @MLP-12887
  Scenario Outline:SC39#Run the Redshift cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                 | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/RedshiftCataloger_InvalidCredentials.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                      | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                      | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                                | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                      | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |


  Scenario:SC39#Validate the processed count and processed widget item presence in platform
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                         | Action                | query         | TableName/Filename                                   |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.InvalidCredentials.Description | metadataValuePresence | AnalysisQuery | cataloger/AmazonRedshiftCataloger/RedShiftCataloger% |
    Then Analysis log "cataloger/AmazonRedshiftCataloger/RedShiftCataloger%" should display below info/error/warning
      | type  | logValue                                                                                                                  | logCode             | pluginName              | removableText |
      | INFO  | Plugin AmazonRedshiftCataloger Start Time:2021-03-16 17:07:36.247, End Time:2021-03-16 17:07:38.084, Errors:2, Warnings:0 | ANALYSIS-0072       | AmazonRedshiftCataloger |               |
      | ERROR | No JDBC connection could be established                                                                                   | ANALYSIS-JDBC-0003: |                         |               |

  @positve @regression @sanity  @MLP-24889 @IDA-1.1.0
  Scenario Outline: SC40#- Set valid DataSource configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                            | bodyFile                                                          | path                | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/AmazonRedshiftDataSource/RedshiftDataSource | payloads/ida/AmazonRedShiftPayloads/AmazonRedshiftDataSource.json | $.configurations[0] | 204           |                    |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/AmazonRedshiftDataSource/RedshiftDataSource |                                                                   |                     | 200           | RedshiftDataSource |          |

  Scenario Outline:SC40#Run the Plugin configurations for DataSource and AmazonS3Cataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                           | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/RedshiftCatalogerInvalidSchema.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                          | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |


  Scenario:SC40#Validate the processed count and processed widget item presence in platform for invalid schema in configuration
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                             | jsonPath                    | Action                | query         | TableName/Filename                                   |
      | Description | ida/AmazonRedShiftPayloads/API/expectedMetadata.json | $.InvalidSchema.Description | metadataValuePresence | AnalysisQuery | cataloger/AmazonRedshiftCataloger/RedShiftCataloger% |
    Then Analysis log "cataloger/AmazonRedshiftCataloger/RedShiftCataloger%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | logCode       | pluginName        | removableText |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0019 |                   |               |
      | INFO | ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: ---  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: name: "RedShiftCataloger"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginVersion: "LATEST"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: label: null  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: auditFields:  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: createdBy: "TestSystem"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: createdAt: "2021-03-12T10:34:40.862"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: modifiedBy: "TestSystem"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: modifiedAt: "2021-03-16T17:36:58.367"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: catalogName: "Default"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: eventClass: null  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: eventCondition: null  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: nodeCondition: "name==\"LocalNode\""  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: maxWorkSize: 100  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: tags:  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - "Cataloger_InvalidSchema"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginType: "cataloger"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: dataSource: "RedshiftDataSource"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: credential: "Redshift_Credentials"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: businessApplicationName: "AmazonRedshift_BA"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: schedule: null  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: filter: null  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: dryRun: false  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: pluginName: "AmazonRedshiftCataloger"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: schemas:  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - schema: "xyzabc"  2021-03-16 17:37:16.116 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: tables:  2021-03-16 17:37:16.117 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: - table: "employee"  2021-03-16 17:37:16.117 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: incremental: false  2021-03-16 17:37:16.117 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: type: "Cataloger"  2021-03-16 17:37:16.117 INFO  - ANALYSIS-0073: Plugin AmazonRedshiftCataloger Configuration: properties: [] | ANALYSIS-0073 | RedShiftCataloger |               |
      | INFO | Plugin AmazonRedshiftCataloger Start Time:2021-03-16 17:37:16.114, End Time:2021-03-16 17:37:18.694, Errors:0, Warnings:1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ANALYSIS-0072 | RedShiftCataloger |               |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:05.138)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | ANALYSIS-0020 |                   |               |

  ###############################################Incremental################################################
 #7079019
  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#41_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_filter1.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    And user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_Filter1.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline:SC#41_2_Run the Plugin configurations for DataSource , AmazonRedshiftCataloger and AmazonRedshiftAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                            | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_filter1.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                                                 | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                                           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_Filter1.json  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                                 | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                                           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#41_3_Verify the Redshift Analyzer Incremental Mode works when the schema level filter in Cataloger and Analyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diffdatatypes" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                             |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.diffdatatypes.Last_Cataloged_at                                              |
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last analyzed at                                                               |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.diffdatatypes.Last_Analyzed_at                                               |
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField                           | columnName | queryOperation | facet         | facetValue | count      |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaTablesCount     | count      | returnValue    | Metadata Type | Table      | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaColumnCount     | count      | returnValue    | Metadata Type | Column     | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaConstraintCount | count      | returnValue    | Metadata Type | Constraint | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaCount           | count      | returnValue    | Metadata Type | Schema     | fromSource |

  @jdbc
  Scenario:SC#41_4_Create table for Cataloger Incremental and Update incremental values in Configuration file
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage       | queryField  |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | RedshiftQueries | createTable |
    And user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_filter1.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |
    And user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_Filter1.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |


  Scenario Outline:SC#41_5_Run the Plugin configurations for DataSource , AmazonRedshiftCataloger and AmazonRedshiftAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                            | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_filter1.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                                                 | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                                           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_Filter1.json  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                                 | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                                           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#41_6_Verify the Redshift Analyzer Incremental Mode works when the schema level filter in Cataloger and Analyzer
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diffdatatypes" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                        | AttributeName      |
      | Equals | $.diffdatatypes.Last_Cataloged_at | Last catalogued at |
      | Equals | $.diffdatatypes.Last_Analyzed_at  | Last analyzed at   |
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField                           | columnName | queryOperation | facet         | facetValue | count      |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaTablesCount     | count      | returnValue    | Metadata Type | Table      | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaColumnCount     | count      | returnValue    | Metadata Type | Column     | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaConstraintCount | count      | returnValue    | Metadata Type | Constraint | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaCount           | count      | returnValue    | Metadata Type | Schema     | fromSource |
    And user enters the search text "schemafilterinc" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "schemafilterinc" item from search results
    And user "verifies tab section values" has the following values in "Columns" Tab in Item View page
      | email        |
      | employee_id  |
      | full_name    |
      | gender       |
      | ip_address   |
      | phone_number |
      | postal_code  |
      | ssn          |
      | state        |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#41_7_Delete created table,Cluster and Analysis files
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage       | queryField |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | RedshiftQueries | dropTable  |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/RedShiftCataloger%             | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer%            | Analysis |       |       |

    ##################################################################################################################
 #7079016
  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#42_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    And user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline:SC#42_2_Run the Plugin configurations for AmazonRedshiftCataloger and AmazonRedshiftAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_NoFilter.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                                                  | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                                            | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_NoFilter.json  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                                  | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                                            | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#42_3_Verify the Redshift Analyzer Incremental Mode works when the no filter are used for the Cataloger and the Schema Level filter used Analyser
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diffdatatypes" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                             |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.diffdatatypes.Last_Cataloged_at                                              |
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last analyzed at                                                               |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.diffdatatypes.Last_Analyzed_at                                               |
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField                           | columnName | queryOperation | facet         | facetValue | count      |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaTablesCount     | count      | returnValue    | Metadata Type | Table      | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaColumnCount     | count      | returnValue    | Metadata Type | Column     | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaConstraintCount | count      | returnValue    | Metadata Type | Constraint | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaCount           | count      | returnValue    | Metadata Type | Schema     | fromSource |
    And user enters the search text "customers" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "customers" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                             |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.customers.Last_Cataloged_at                                                  |
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last analyzed at                                                               |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.customers.Last_Analyzed_at                                                   |
    And user enters the search text "schematest" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "schematest [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField                           | columnName | queryOperation | facet         | facetValue | count      |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftSchematestTablesCount     | count      | returnValue    | Metadata Type | Table      | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftSchematestColumnCount     | count      | returnValue    | Metadata Type | Column     | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftSchematestConstraintCount | count      | returnValue    | Metadata Type | Constraint | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftSchematestCount           | count      | returnValue    | Metadata Type | Schema     | fromSource |


  @jdbc
  Scenario:SC#42_4_Create table for Cataloger Incremental and Update incremental values in Configuration file
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage       | queryField  |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | RedshiftQueries | createTable |
    And user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage       | queryField    |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | RedshiftQueries | createTable_2 |
    And user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |
    And user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline:SC#42_5_Run the Plugin configurations for AmazonRedshiftCataloger and AmazonRedshiftAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_NoFilter.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                                                  | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                                            | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_NoFilter.json  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                                  | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                                            | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#42_6_Verify the Redshift Analyzer Incremental Mode works when the no filter are used for the Cataloger and the Schema Level filter used Analyser
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diffdatatypes" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                        | AttributeName      |
      | Equals | $.diffdatatypes.Last_Cataloged_at | Last catalogued at |
      | Equals | $.diffdatatypes.Last_Analyzed_at  | Last analyzed at   |
    And user enters the search text "customers" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "customers" item from search results
    And user "Get" the json file value from "ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                    | AttributeName      |
      | Equals | $.customers.Last_Cataloged_at | Last catalogued at |
      | Equals | $.customers.Last_Analyzed_at  | Last analyzed at   |
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField                           | columnName | queryOperation | facet         | facetValue | count      |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaTablesCount     | count      | returnValue    | Metadata Type | Table      | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaColumnCount     | count      | returnValue    | Metadata Type | Column     | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaConstraintCount | count      | returnValue    | Metadata Type | Constraint | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaCount           | count      | returnValue    | Metadata Type | Schema     | fromSource |
    And user enters the search text "schemafilterinc" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "schemafilterinc" item from search results
    And user "verifies tab section values" has the following values in "Columns" Tab in Item View page
      | email        |
      | employee_id  |
      | full_name    |
      | gender       |
      | ip_address   |
      | phone_number |
      | postal_code  |
      | ssn          |
      | state        |
    And user enters the search text "schematest" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "schematest [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField                           | columnName | queryOperation | facet         | facetValue | count      |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftSchematestTablesCount     | count      | returnValue    | Metadata Type | Table      | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftSchematestColumnCount     | count      | returnValue    | Metadata Type | Column     | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftSchematestConstraintCount | count      | returnValue    | Metadata Type | Constraint | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftSchematestCount           | count      | returnValue    | Metadata Type | Schema     | fromSource |
    And user enters the search text "schemanofilterinc" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "schemanofilterinc" item from search results
    And user "verifies tab section values" has the following values in "Columns" Tab in Item View page
      | user_id    |
      | name       |
      | ip_address |
      | email      |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#42_7_Delete created table,Cluster and Analysis files
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage       | queryField |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | RedshiftQueries | dropTable  |
    And user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage       | queryField  |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | RedshiftQueries | dropTable_2 |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/RedShiftCataloger%             | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer%            | Analysis |       |       |

    #########################################################################################################
 #7079017
  @webtest
  Scenario:SC#43_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_SchemaTableFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    And user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline:SC#43_2_Run the Plugin configurations for AmazonRedshiftCataloger and AmazonRedshiftAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                                      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_SchemaTableFilter.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                                                           | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                                                     | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_NoFilter.json           | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                                           | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                                                     | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                           | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#43_3_Verify the Redshift Analyzer Incremental Mode works when the no filter is used for the Analyser and cataloger has schema and table level filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diffdatatypes" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                             |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.diffdatatypes.Last_Cataloged_at                                              |
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last analyzed at                                                               |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.diffdatatypes.Last_Analyzed_at                                               |
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 12    |
      | Table     | 1     |
      | Schema    | 1     |


  @jdbc
  Scenario:SC#43_4_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_SchemaTableFilter_1.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |
    And user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline:SC#43_5_Run the Plugin configurations for AmazonRedshiftCataloger and AmazonRedshiftAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                                        | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_SchemaTableFilter_1.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                                                             | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                             | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                                                       | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                             | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_NoFilter.json             | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                                             | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                             | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                                                       | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                             | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#43_6_Verify the Redshift Analyzer Incremental Mode works when the no filter is used for the Analyser and cataloger has schema and table level filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diffdatatypes" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                        | AttributeName      |
      | Equals | $.diffdatatypes.Last_Cataloged_at | Last catalogued at |
      | Equals | $.diffdatatypes.Last_Analyzed_at  | Last analyzed at   |
    And user enters the search text "employee1" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "employee1" item from search results
    And user "verifies tab section values" has the following values in "Columns" Tab in Item View page
      | address |
      | id      |
      | name    |
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    Then user verify Facet type and counts with following values under "Metadata Type" section in item search results page
      | facetType | count |
      | Column    | 15    |
      | Table     | 2     |
      | Schema    | 1     |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#43_7_Delete Cluster and Analysis files
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/RedShiftCataloger%             | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer%            | Analysis |       |       |

###############################################################################################################################
#7079015
  @webtest
  Scenario:SC#44_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_filter1.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    And user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_SchemaTableFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline:SC#44_2_Run the Plugin configurations for AmazonRedshiftCataloger and AmazonRedshiftAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                                     | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_filter1.json          | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                                                          | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                          | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                                                    | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                          | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_SchemaTableFilter.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                                          | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                          | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                                                    | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                          | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#44_3_Verify Incremental collection with Filters works fine in RedshiftAnalyzer(In cataloger set Incremental run:false and in analyzer set Incremental run:true and add schema/table filters)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diffdatatypes" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                             |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.diffdatatypes.Last_Cataloged_at                                              |
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last analyzed at                                                               |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.diffdatatypes.Last_Analyzed_at                                               |
    And user enters the search text "employee1" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "employee1" item from search results
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |

  @jdbc
  Scenario:SC#44_4_Update incremental values in Configuration file
    Given  user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_SchemaTableFilter_1.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline:SC#44_5_Run the Plugin configurations for AmazonRedshiftAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                                       | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_SchemaTableFilter_1.json | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                                            | 200           | RedshiftAnalyzer |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                            | 200           | IDLE             | $.[?(@.configurationName=='RedshiftAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                                                      | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                            | 200           | IDLE             | $.[?(@.configurationName=='RedshiftAnalyzer')].status |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#44_6_Verify Incremental collection with Filters works fine in RedshiftAnalyzer(In cataloger set Incremental run:false and in analyzer set Incremental run:true and add schema/table filters)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diffdatatypes" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                        | AttributeName      |
      | Equals | $.diffdatatypes.Last_Cataloged_at | Last catalogued at |
      | Equals | $.diffdatatypes.Last_Analyzed_at  | Last analyzed at   |
    And user enters the search text "employee1" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "employee1" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#44_7_Delete Cluster and Analysis files
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/RedShiftCataloger%             | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer%            | Analysis |       |       |

###############################################################################################################################
    #7079018
  @webtest
  Scenario:SC#45_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_filter1.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |
    And user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_IncludeExclude.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline:SC#45_2_Run the Plugin configurations for AmazonRedshiftCataloger and AmazonRedshiftAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                                  | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                 | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_filter1.json       | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                 |                                                                                       | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                       | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger   | ida/AmazonRedShiftPayloads/empty.json                                                 | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  |                                                                                       | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_IncludeExclude.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                                       | 200           | RedshiftAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                       | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                                                 | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                       | 200           | IDLE              | $.[?(@.configurationName=='RedshiftAnalyzer')].status  |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#45_3_Verify Incremental collection with Filters works fine in RedshiftAnalyzer(In cataloger set Incremental run:false and in analyzer set Incremental run:true and add schema/table filters)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diffdatatypes" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                             |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.diffdatatypes.Last_Cataloged_at                                              |
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last analyzed at                                                               |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.diffdatatypes.Last_Analyzed_at                                               |
    And user enters the search text "department" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "department" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                             |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.department.Last_Cataloged_at                                                 |
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last analyzed at                                                               |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.department.Last_Analyzed_at                                                  |
    And user enters the search text "employee" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "employee" item from search results
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    And user enters the search text "persons" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "persons" item from search results
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    And user enters the search text "incrementtesttable" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "incrementtesttable" item from search results
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |

  @jdbc
  Scenario:SC#45_4_Update incremental values in Configuration file
    Given  user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_IncludeExclude_1.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline:SC#45_5_Run the Plugin configurations for AmazonRedshiftAnalyzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                        | body                                                                                    | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                  | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftAnalyzer_Inc_IncludeExclude_1.json | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                  |                                                                                         | 200           | RedshiftAnalyzer |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                         | 200           | IDLE             | $.[?(@.configurationName=='RedshiftAnalyzer')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer  | ida/AmazonRedShiftPayloads/empty.json                                                   | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer |                                                                                         | 200           | IDLE             | $.[?(@.configurationName=='RedshiftAnalyzer')].status |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#45_6_Verify Incremental collection with Filters works fine in RedshiftAnalyzer(In cataloger set Incremental run:false and in analyzer set Incremental run:true and add schema/table filters)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diffdatatypes" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                        | AttributeName      |
      | Equals | $.diffdatatypes.Last_Cataloged_at | Last catalogued at |
      | Equals | $.diffdatatypes.Last_Analyzed_at  | Last analyzed at   |
    And user enters the search text "department" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "department" item from search results
    And user "Get" the json file value from "ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                     | AttributeName      |
      | Equals | $.department.Last_Cataloged_at | Last catalogued at |
      | Equals | $.department.Last_Analyzed_at  | Last analyzed at   |
    And user enters the search text "employee" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "employee" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "persons" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "persons" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    And user enters the search text "incrementtesttable" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "incrementtesttable" item from search results
    And user "verify metadata attributes" section does not have the following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#45_7_Delete Cluster and Analysis files
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/RedShiftCataloger%             | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer%            | Analysis |       |       |

###############################################################################################################################

      #7079014
  @webtest
  Scenario:SC#46_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline:SC#46_2_Run the Plugin configurations for AmazonRedshiftCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_NoFilter.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                                  | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                                            | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#46_3_Verify RedshiftCataloger Incremental Collection(Set Incremental false in cataloger and collect tables.In the second run,set incremental collection:true and add schema/table filter in cataloger).
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diffdatatypes" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                             |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.diffdatatypes.Last_Cataloged_at                                              |

  @webtest
  Scenario:SC#46_4_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_filter2.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline:SC#46_5_RRun the Plugin configurations for AmazonRedshiftCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                            | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_filter2.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                                 | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                                           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#46_6_Verify RedshiftCataloger Incremental Collection(Set Incremental false in cataloger and collect tables.In the second run,set incremental collection:true and add schema/table filter in cataloger).
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diffdatatypes" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                        | AttributeName      |
      | Equals | $.diffdatatypes.Last_Cataloged_at | Last catalogued at |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#46_7_Delete Cluster and Analysis files
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/RedShiftCataloger%             | Analysis |       |       |

###############################################################################################################################
      #7079013
  @webtest
  Scenario:SC#47_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline:SC#47_2_Run the Plugin configurations for AmazonRedshiftCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_NoFilter.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                                  | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                                            | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#47_3_Verify RedshiftCataloger works fine with Incremental Collection set as true(Set Incremental false in first run and Incremental true in second run- Add table in redshift Database)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diffdatatypes" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                             |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.diffdatatypes.Last_Cataloged_at                                              |
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField                           | columnName | queryOperation | facet         | facetValue | count      |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaTablesCount     | count      | returnValue    | Metadata Type | Table      | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaColumnCount     | count      | returnValue    | Metadata Type | Column     | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaConstraintCount | count      | returnValue    | Metadata Type | Constraint | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaCount           | count      | returnValue    | Metadata Type | Schema     | fromSource |

  @webtest
  Scenario:SC#47_4_Create table for Cataloger incremental and Update incremental values in Configuration file
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage       | queryField  |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | RedshiftQueries | createTable |
    And user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_NoFilter.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline:SC#47_5_Run the Plugin configurations for AmazonRedshiftCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_NoFilter.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                                  | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                                            | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                                  | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#47_6_Verify RedshiftCataloger works fine with Incremental Collection set as true(Set Incremental false in first run and Incremental true in second run- Add table in redshift Database)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "diffdatatypes" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "diffdatatypes" item from search results
    And user "Get" the json file value from "ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                        | AttributeName      |
      | Equals | $.diffdatatypes.Last_Cataloged_at | Last catalogued at |
    And user enters the search text "testschema" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage                | queryField                           | columnName | queryOperation | facet         | facetValue | count      |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaTablesCount     | count      | returnValue    | Metadata Type | Table      | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaColumnCount     | count      | returnValue    | Metadata Type | Column     | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaConstraintCount | count      | returnValue    | Metadata Type | Constraint | fromSource |
      | REDSHIFT     | STRUCTURED   | json/IDA.json | RedshiftCatalogerQueries | getRedshiftTestSchemaCount           | count      | returnValue    | Metadata Type | Schema     | fromSource |
    And user enters the search text "schemafilterinc" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "schemafilterinc" item from search results
    And user "verifies tab section values" has the following values in "Columns" Tab in Item View page
      | email        |
      | employee_id  |
      | full_name    |
      | gender       |
      | ip_address   |
      | phone_number |
      | postal_code  |
      | ssn          |
      | state        |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#47_7_Delete Cluster and Analysis files
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage       | queryField |
      | REDSHIFT           | EXECUTEQUERY | json/IDA.json | RedshiftQueries | dropTable  |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/RedShiftCataloger%             | Analysis |       |       |

###############################################################################################################################
      #7079020
  @webtest
  Scenario:SC#48_1_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_filter3.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | false      | boolean |

  Scenario Outline:SC#48_2_Run the Plugin configurations for AmazonRedshiftCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                            | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_filter3.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                                 | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                                           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#48_3_Verify Incremental works for a Tables which has constraints in it
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tag_details" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tag_details" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                             |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.tag_details.Last_Cataloged_at                                                |
    And user enters the search text "employee" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "employee" item from search results
    And user copy metadata value from Item View Page and write to file
      | attributeName  | Last catalogued at                                                             |
      | actualFilePath | payloads/ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json |
      | jsonpath       | $.employee.Last_Cataloged_at                                                   |


  @webtest
  Scenario:SC#48_4_Update incremental values in Configuration file
    Given user "update" the json file "ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_filter4.json" file for following values
      | jsonPath       | jsonValues | type    |
      | $..incremental | true       | boolean |

  Scenario Outline:SC#48_5_Run the Plugin configurations for AmazonRedshiftCataloger
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | body                                                                            | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                | ida/AmazonRedShiftPayloads/IncrementalConfig/RedshiftCataloger_Inc_filter4.json | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                |                                                                                 | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger  | ida/AmazonRedShiftPayloads/empty.json                                           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/RedShiftCataloger |                                                                                 | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |

  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#48_6_Verify Incremental works for a Tables which has constraints in it
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tag_details" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tag_details" item from search results
    And user "Get" the json file value from "ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json" and Compare With UI Values
      | Action | jsonObject                      | AttributeName      |
      | Equals | $.tag_details.Last_Cataloged_at | Last catalogued at |
    And user enters the search text "employee" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Cataloger_filter1" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Redshift" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "testschema [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "employee" item from search results
    And user "Get" the json file value from "ida/AmazonRedShiftPayloads/IncrementalConfig/IncrementalExpected.json" and Compare With UI Values
      | Action    | jsonObject                   | AttributeName      |
      | NotEquals | $.employee.Last_Cataloged_at | Last catalogued at |


  @RedShift @positve @regression @sanity @webtest
  Scenario:SC#48_7_Delete Cluster and Analysis files
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/RedShiftCataloger%             | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/RedshiftAnalyzer%            | Analysis |       |       |


 #############################################  PII Tags - Validation - Starts #####################################################

  @AmazonRedshift
  Scenario Outline:Policy1:Create root tag and sub tag for Oracle CDB Anlayzer and Update policy tags for Oracle Anlayzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/AmazonRedShiftPayloads/API/PolicyEngine/AmazonRedshift_TagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/AmazonRedShiftPayloads/API/PolicyEngine/AmazonRedshift_policy1.json      | 204           |                  |          |

  @MLP-20518 @sanity @positive @regression
  Scenario Outline:SC#PII_1:Create Redshift Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | bodyFile                                                                                      | path              | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonRedshiftCataloger/AmazonRedshiftCataloger                               | payloads/ida/AmazonRedShiftPayloads/policyEngine/PluginConfiguration/TagsCatalogerConfig.json | $.CatalogerConfig | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonRedshiftCataloger/AmazonRedshiftCataloger                               |                                                                                               |                   | 200           | AmazonRedshiftCataloger |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCataloger  |                                                                                               |                   | 200           | IDLE                    | $.[?(@.configurationName=='AmazonRedshiftCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCataloger   |                                                                                               |                   | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/AmazonRedshiftCataloger  |                                                                                               |                   | 200           | IDLE                    | $.[?(@.configurationName=='AmazonRedshiftCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonRedshiftAnalyzer/AmazonRedshiftAnalyzer                                 | payloads/ida/AmazonRedShiftPayloads/policyEngine/PluginConfiguration/TagsAnalyzerConfig.json  | $.configurations  | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonRedshiftAnalyzer/AmazonRedshiftAnalyzer                                 |                                                                                               |                   | 200           | AmazonRedshiftAnalyzer  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/AmazonRedshiftAnalyzer |                                                                                               |                   | 200           | IDLE                    | $.[?(@.configurationName=='AmazonRedshiftAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/AmazonRedshiftAnalyzer  |                                                                                               |                   | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/AmazonRedshiftAnalyzer |                                                                                               |                   | 200           | IDLE                    | $.[?(@.configurationName=='AmazonRedshiftAnalyzer')].status  |

  @AmazonRedshift @PIITag
  Scenario:SC1MLP_26096_Verify PIItags for AmazonRedshift Table ,typePattern can be set as:string or .*str.* minimumRatio:0.5, Match Empty=false, Match Full=false.
  Verify Tag is set for the column when typePattern(String) and dataPattern/minimumRatio matches with the column type/value ratio in Parquet file field.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                          | Column    | Tags                               | Query                    | Action         |
      | world        | testschema | tagdetails_allmatch                         | gender    | AmazonRedshift_GenderPII_SC1Tag    | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allmatch                         | ssn       | AmazonRedshift_SSNPII_SC1Tag       | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allmatch                         | ipaddress | AmazonRedshift_IPAddressPII_SC1Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allmatch                         | full_name | AmazonRedshift_FullNamePII_SC1Tag  | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allmatch                         | email     | AmazonRedshift_EmailPII_SC1Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allempty                         | email     | AmazonRedshift_EmailPII_SC1Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allempty                         | ssn       | AmazonRedshift_SSNPII_SC1Tag       | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allempty                         | ipaddress | AmazonRedshift_IPAddressPII_SC1Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allempty                         | gender    | AmazonRedshift_GenderPII_SC1Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | full_name | AmazonRedshift_FullNamePII_SC1Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | email     | AmazonRedshift_EmailPII_SC1Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | gender    | AmazonRedshift_GenderPII_SC1Tag    | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | ipaddress | AmazonRedshift_IPAddressPII_SC1Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | AmazonRedshift_GenderPII_SC1Tag    | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | AmazonRedshift_SSNPII_SC1Tag       | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | AmazonRedshift_IPAddressPII_SC1Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | AmazonRedshift_FullNamePII_SC1Tag  | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | AmazonRedshift_EmailPII_SC1Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | gender    | AmazonRedshift_GenderPII_SC1Tag    | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | ssn       | AmazonRedshift_SSNPII_SC1Tag       | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | ipaddress | AmazonRedshift_IPAddressPII_SC1Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | full_name | AmazonRedshift_FullNamePII_SC1Tag  | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | email     | AmazonRedshift_EmailPII_SC1Tag     | EDIColumnQuerywithSchema | TagAssigned    |

  @AmazonRedshift @PIITag
  Scenario:SC2#MLP_26096_Verify PItags not set for Parquet File columns , typePattern can be set as:  NUMBER or .*VAR1.* or .*FLOAT.* or .*NUM.*  minimumRatio:0.5
  Verify Tag is not set for the column when typePattern(other than String) and dataPattern/minimumRatio matches with the column type/value ratio in Parquet file field.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                          | Column    | Tags                               | Query                    | Action         |
      | world        | testschema | tagdetails_allmatch                         | gender    | AmazonRedshift_GenderPII_SC2Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | ssn       | AmazonRedshift_SSNPII_SC2Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | ipaddress | AmazonRedshift_IPAddressPII_SC2Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | full_name | AmazonRedshift_FullNamePII_SC2Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | email     | AmazonRedshift_EmailPII_SC2Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | email     | AmazonRedshift_EmailPII_SC2Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | ssn       | AmazonRedshift_SSNPII_SC2Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | ipaddress | AmazonRedshift_IPAddressPII_SC2Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | gender    | AmazonRedshift_GenderPII_SC2Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | full_name | AmazonRedshift_FullNamePII_SC2Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | email     | AmazonRedshift_EmailPII_SC2Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | gender    | AmazonRedshift_GenderPII_SC2Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | ipaddress | AmazonRedshift_IPAddressPII_SC2Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | ssn       | AmazonRedshift_SSNPII_SC2Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | full_name | AmazonRedshift_FullNamePII_SC2Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | AmazonRedshift_GenderPII_SC2Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | AmazonRedshift_SSNPII_SC2Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | AmazonRedshift_IPAddressPII_SC2Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | AmazonRedshift_FullNamePII_SC2Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | AmazonRedshift_EmailPII_SC2Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | gender    | AmazonRedshift_GenderPII_SC2Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | ssn       | AmazonRedshift_SSNPII_SC2Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | ipaddress | AmazonRedshift_IPAddressPII_SC2Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | full_name | AmazonRedshift_FullNamePII_SC2Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | email     | AmazonRedshift_EmailPII_SC2Tag     | EDIColumnQuerywithSchema | TagNotAssigned |


  @AmazonRedshift @PIITag
  Scenario:SC3#MLP_26096_Verify PItags for Parquet File columns  , namePattern can be set as:.*FULL.*,.*IP.*,gender,.*email.*,ssn.*, minimumRatio:0.5
  Verify Tag is set for the column when namePattern and dataPattern/minimumRatio matches with the column name/value ratio in Parquet File Columns.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                          | Column    | Tags                               | Query                    | Action         |
      | world        | testschema | tagdetails_allmatch                         | gender    | AmazonRedshift_GenderPII_SC3Tag    | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allmatch                         | ssn       | AmazonRedshift_SSNPII_SC3Tag       | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allmatch                         | ipaddress | AmazonRedshift_IPAddressPII_SC3Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allmatch                         | full_name | AmazonRedshift_FullNamePII_SC3Tag  | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allmatch                         | email     | AmazonRedshift_EmailPII_SC3Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allempty                         | full_name | AmazonRedshift_FullNamePII_SC3Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | ssn       | AmazonRedshift_SSNPII_SC3Tag       | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allempty                         | ipaddress | AmazonRedshift_IPAddressPII_SC3Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allempty                         | email     | AmazonRedshift_EmailPII_SC3Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_allempty                         | gender    | AmazonRedshift_GenderPII_SC3Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | ipaddress | AmazonRedshift_IPAddressPII_SC3Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | gender    | AmazonRedshift_GenderPII_SC3Tag    | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | ssn       | AmazonRedshift_SSNPII_SC3Tag       | EDIColumnQuerywithSchema | TagNotAssigned    |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | AmazonRedshift_IPAddressPII_SC3Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | AmazonRedshift_FullNamePII_SC3Tag  | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | AmazonRedshift_EmailPII_SC3Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | AmazonRedshift_GenderPII_SC3Tag    | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | AmazonRedshift_SSNPII_SC3Tag       | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | ipaddress | AmazonRedshift_IPAddressPII_SC3Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | full_name | AmazonRedshift_FullNamePII_SC3Tag  | EDIColumnQuerywithSchema | TagAssigned    |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | email     | AmazonRedshift_EmailPII_SC3Tag     | EDIColumnQuerywithSchema | TagAssigned    |


  @AmazonRedshift @PIITag
  Scenario:SC4#MLP_26096_Verify PIItags not set for Parquet file columns , namePattern set as: .*F1ULL.*,IP1,1gender,.*EM1AIL.*,ssn11.*, minimumRatio:0.5
  Verify Tag is not set for the column when namePattern(does not match) and dataPattern/minimumRatio that does not matches with the column name/value ratio in AmazonRedshift Table.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                          | Column    | Tags                               | Query                    | Action         |
      | world        | testschema | tagdetails_allmatch                         | gender    | AmazonRedshift_GenderPII_SC4Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | ssn       | AmazonRedshift_SSNPII_SC4Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | ipaddress | AmazonRedshift_IPAddressPII_SC4Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | full_name | AmazonRedshift_FullNamePII_SC4Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | email     | AmazonRedshift_EmailPII_SC4Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | email     | AmazonRedshift_EmailPII_SC4Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | ssn       | AmazonRedshift_SSNPII_SC4Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | ipaddress | AmazonRedshift_IPAddressPII_SC4Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | gender    | AmazonRedshift_GenderPII_SC42Tag   | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | full_name | AmazonRedshift_FullNamePII_SC4Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | email     | AmazonRedshift_EmailPII_SC4Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | gender    | AmazonRedshift_GenderPII_SC4Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | ipaddress | AmazonRedshift_IPAddressPII_SC4Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | ssn       | AmazonRedshift_SSNPII_SC4Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | full_name | AmazonRedshift_FullNamePII_SC4Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | AmazonRedshift_GenderPII_SC4Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | AmazonRedshift_SSNPII_SC4Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | AmazonRedshift_IPAddressPII_SC4Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | AmazonRedshift_FullNamePII_SC4Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | AmazonRedshift_EmailPII_SC4Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | gender    | AmazonRedshift_GenderPII_SC4Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | ssn       | AmazonRedshift_SSNPII_SC4Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | ipaddress | AmazonRedshift_IPAddressPII_SC4Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | full_name | AmazonRedshift_FullNamePII_SC4Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | email     | AmazonRedshift_EmailPII_SC4Tag     | EDIColumnQuerywithSchema | TagNotAssigned |

  @AmazonRedshift @PIITag
  Scenario:SC5#MLP_26096_Verify PItags for AmazonRedshift Table , valid name and type pattern minimumRatio:0.2
  Verify Tag is set for the column when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the data in column in OracleDB table.
  (Ex: 0.2 - 2 or more rows should have matcning column values)- Match Empty is False
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                   | Column    | Tags                               | Query                    | Action      |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse | gender    | AmazonRedshift_GenderPII_SC5Tag    | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse | ssn       | AmazonRedshift_SSNPII_SC5Tag       | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse | ipaddress | AmazonRedshift_IPAddressPII_SC5Tag | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse | full_name | AmazonRedshift_FullNamePII_SC5Tag  | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse | email     | AmazonRedshift_EmailPII_SC5Tag     | EDIColumnQuerywithSchema | TagAssigned |

  @AmazonRedshift @PIITag
  Scenario:SC6#MLP_26096_Verify PIItags for AmazonRedshift Table , minimumRatio:0.6 matchfull true and matchempty false
  Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in OracleDB table.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 2 rows empty/1 row blank, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                          | Column    | Tags                               | Query                    | Action         |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | AmazonRedshift_IPAddressPII_SC6Tag | EDIColumnQuerywithSchema | TagNotAssigned    |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | AmazonRedshift_EmailPII_SC6Tag     | EDIColumnQuerywithSchema | TagNotAssigned    |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | AmazonRedshift_GenderPII_SC6Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | AmazonRedshift_FullNamePII_SC6Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | AmazonRedshift_SSNPII_SC6Tag       | EDIColumnQuerywithSchema | TagNotAssigned |

  @AmazonRedshift @PIITag
  Scenario:SC7#MLP_26096_Verify PIItags for AmazonRedshift Table , minimumRatio:1 matchfull false and matchempty false
  Verify Tag is set for the column when dataPattern and minimumRatio(1-full match) is passed which has a regexp that matches with the data in column in OracleDB table.
  (Ex: 1 - all rows should match) - Match Empty is false
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename  | Column    | Tags                               | Query                    | Action      |
      | world        | testschema | tagdetails_allmatch | gender    | AmazonRedshift_GenderPII_SC8Tag    | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_allmatch | ssn       | AmazonRedshift_SSNPII_SC8Tag       | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_allmatch | ipaddress | AmazonRedshift_IPAddressPII_SC8Tag | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_allmatch | full_name | AmazonRedshift_FullNamePII_SC8Tag  | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_allmatch | email     | AmazonRedshift_EmailPII_SC8Tag     | EDIColumnQuerywithSchema | TagAssigned |

  @AmazonRedshift @PIITag
  Scenario:SC8#MLP_26096_Verify PIItags for AmazonRedshift Table , minimumRatio:0.5 matchfull false and matchempty false
  Verify Tag is set for the column when dataPattern and minimumRatio(equal to 0.5) is passed which has a regexp that matches with the data in column in OracleDB table.
  (Ex: 0.5 - 5 or more rows should have matching column values) - Match Empty is false.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                  | Column    | Tags                               | Query                    | Action      |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse | gender    | AmazonRedshift_GenderPII_SC9Tag    | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse | ssn       | AmazonRedshift_SSNPII_SC9Tag       | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse | ipaddress | AmazonRedshift_IPAddressPII_SC9Tag | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse | full_name | AmazonRedshift_FullNamePII_SC9Tag  | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse | email     | AmazonRedshift_EmailPII_SC9Tag     | EDIColumnQuerywithSchema | TagAssigned |

  @AmazonRedshift @PIITag
  Scenario:SC9#MLP_26096_Verify PIItags for DynamoDB tables , minimumRatio:0.2 matchfull false and matchempty false,namePattern can be set as:FULL.*,ipaddress,gender,.*MAIL,.*ssn.*
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                   | Column    | Tags                                | Query                    | Action      |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse | gender    | AmazonRedshift_GenderPII_SC10Tag    | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse | ssn       | AmazonRedshift_SSNPII_SC10Tag       | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse | ipaddress | AmazonRedshift_IPAddressPII_SC10Tag | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse | full_name | AmazonRedshift_FullNamePII_SC10Tag  | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse | email     | AmazonRedshift_EmailPII_SC10Tag     | EDIColumnQuerywithSchema | TagAssigned |


  @AmazonRedshift @PIITag
  Scenario:SC10#MLP_26096_Verify PItags not set for AmazonRedshift Table , namePattern set as: FULL1.*,IPAD1DRESS,gender1,.*1MAIL,.*1ssn.*, minimumRatio:0.2
  Verify Tag is not set for the column when namePattern(does not match),typePattern,dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in AmazonRedshift Table.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                          | Column    | Tags                                | Query                    | Action         |
      | world        | testschema | tagdetails_allmatch                         | gender    | AmazonRedshift_GenderPII_SC11Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | ssn       | AmazonRedshift_SSNPII_SC11Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | ipaddress | AmazonRedshift_IPAddressPII_SC11Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | full_name | AmazonRedshift_FullNamePII_SC11Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | email     | AmazonRedshift_EmailPII_SC11Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | email     | AmazonRedshift_EmailPII_SC11Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | ssn       | AmazonRedshift_SSNPII_SC11Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | ipaddress | AmazonRedshift_IPAddressPII_SC11Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | gender    | AmazonRedshift_GenderPII_SC11Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | full_name | AmazonRedshift_FullNamePII_SC11Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | email     | AmazonRedshift_EmailPII_SC11Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | gender    | AmazonRedshift_GenderPII_SC11Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | ipaddress | AmazonRedshift_IPAddressPII_SC11Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | ssn       | AmazonRedshift_SSNPII_SC11Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | full_name | AmazonRedshift_FullNamePII_SC11Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | AmazonRedshift_GenderPII_SC11Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | AmazonRedshift_SSNPII_SC11Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | AmazonRedshift_IPAddressPII_SC11Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | AmazonRedshift_FullNamePII_SC11Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | AmazonRedshift_EmailPII_SC11Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | gender    | AmazonRedshift_GenderPII_SC11Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | ssn       | AmazonRedshift_SSNPII_SC11Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | ipaddress | AmazonRedshift_IPAddressPII_SC11Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | full_name | AmazonRedshift_FullNamePII_SC11Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | email     | AmazonRedshift_EmailPII_SC11Tag     | EDIColumnQuerywithSchema | TagNotAssigned |

  @AmazonRedshift @PIITag
  Scenario:SC11#MLP_26096_Verify PItags not set for AmazonRedshift Table , name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false.
  Verify Tag is not set for the column when namePattern,typePattern(does not match),dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in AmazonRedshift Table.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                          | Column    | Tags                                | Query                    | Action         |
      | world        | testschema | tagdetails_allmatch                         | gender    | AmazonRedshift_GenderPII_SC12Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | ssn       | AmazonRedshift_SSNPII_SC12Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | ipaddress | AmazonRedshift_IPAddressPII_SC12Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | full_name | AmazonRedshift_FullNamePII_SC12Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | email     | AmazonRedshift_EmailPII_SC12Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | email     | AmazonRedshift_EmailPII_SC12Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | ssn       | AmazonRedshift_SSNPII_SC12Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | ipaddress | AmazonRedshift_IPAddressPII_SC12Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | gender    | AmazonRedshift_GenderPII_SC12Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | full_name | AmazonRedshift_FullNamePII_SC12Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | email     | AmazonRedshift_EmailPII_SC12Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | gender    | AmazonRedshift_GenderPII_SC12Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | ipaddress | AmazonRedshift_IPAddressPII_SC12Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | ssn       | AmazonRedshift_SSNPII_SC12Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | full_name | AmazonRedshift_FullNamePII_SC12Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | AmazonRedshift_GenderPII_SC12Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | AmazonRedshift_SSNPII_SC12Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | AmazonRedshift_IPAddressPII_SC12Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | AmazonRedshift_FullNamePII_SC12Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | AmazonRedshift_EmailPII_SC12Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | gender    | AmazonRedshift_GenderPII_SC12Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | ssn       | AmazonRedshift_SSNPII_SC12Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | ipaddress | AmazonRedshift_IPAddressPII_SC12Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | full_name | AmazonRedshift_FullNamePII_SC12Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | email     | AmazonRedshift_EmailPII_SC12Tag     | EDIColumnQuerywithSchema | TagNotAssigned |

  @AmazonRedshift @PIITag
  Scenario:SC12#MLP_26096_Verify PItags not set for AmazonRedshift Table , data pattern (Invalid regex) minimumRatio:0.2 matchfull false and matchempty false
  Verify Tag is not set for the column when namePattern,typePattern,dataPattern and minimumRatio(does not match) is passed which has any of the regexp and ratio that does not matches with the data in AmazonRedshift Table.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                          | Column    | Tags                                | Query                    | Action         |
      | world        | testschema | tagdetails_allmatch                         | gender    | AmazonRedshift_GenderPII_SC13Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | ssn       | AmazonRedshift_SSNPII_SC13Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | ipaddress | AmazonRedshift_IPAddressPII_SC13Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | full_name | AmazonRedshift_FullNamePII_SC13Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allmatch                         | email     | AmazonRedshift_EmailPII_SC13Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | email     | AmazonRedshift_EmailPII_SC13Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | ssn       | AmazonRedshift_SSNPII_SC13Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | ipaddress | AmazonRedshift_IPAddressPII_SC13Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | gender    | AmazonRedshift_GenderPII_SC13Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_allempty                         | full_name | AmazonRedshift_FullNamePII_SC13Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | email     | AmazonRedshift_EmailPII_SC13Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | gender    | AmazonRedshift_GenderPII_SC13Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | ipaddress | AmazonRedshift_IPAddressPII_SC13Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | ssn       | AmazonRedshift_SSNPII_SC13Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiolessthan05emptyfalse        | full_name | AmazonRedshift_FullNamePII_SC13Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | AmazonRedshift_GenderPII_SC13Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | AmazonRedshift_SSNPII_SC13Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | AmazonRedshift_IPAddressPII_SC13Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | AmazonRedshift_FullNamePII_SC13Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | AmazonRedshift_EmailPII_SC13Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | gender    | AmazonRedshift_GenderPII_SC13Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | ssn       | AmazonRedshift_SSNPII_SC13Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | ipaddress | AmazonRedshift_IPAddressPII_SC13Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | full_name | AmazonRedshift_FullNamePII_SC13Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | world        | testschema | tagdetails_ratioequalto05emptyfalse         | email     | AmazonRedshift_EmailPII_SC13Tag     | EDIColumnQuerywithSchema | TagNotAssigned |

  @AmazonRedshift @PIITag
  Scenario:SC13#MLP_26096_Verify PIItags for AmazonRedshift Table , minimumRatio:0.5 matchfull false and matchempty true.
  Verify Tag is set for the column when Ignore empty and null is true and all the column values in DB are blank/null.(dataPattern/minimumRatio/MatchEmpty:True/MatchFull:False)
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename  | Column    | Tags                                | Query                    | Action      |
      | world        | testschema | tagdetails_allempty | email     | AmazonRedshift_EmailPII_SC14Tag     | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_allempty | ssn       | AmazonRedshift_SSNPII_SC14Tag       | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_allempty | ipaddress | AmazonRedshift_IPAddressPII_SC14Tag | EDIColumnQuerywithSchema | TagAssigned |

  @AmazonRedshift @PIITag
  Scenario:SC14#MLP_26096_Verify PIItags for AmazonRedshift Table , minimumRatio:0.6 matchfull true and matchempty false
  Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in OracleDB table.
  (Ex: 0.6 - 6 or more rows should have matcning column values - dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                         | Column   | Tags                           | Query                    | Action         |
      | world        | testschema | tagdetails_ratiogreaterthan05matchfulltrue | comments | AmazonRedshift_FullMatchPII_SC1Tag | EDIColumnQuerywithSchema | TagNotAssigned |

  @AmazonRedshift @PIITag
  Scenario:SC15#MLP_26096_Verify PIItags for AmazonRedshift Table , minimumRatio:0.2 matchfull true and matchempty false
  Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the exact data in column in OracleDB table.
  (Ex: 0.2 - 2 or more rows should have matcning column values - namePattern,typePattern,dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                        | Column   | Tags                           | Query                    | Action         |
      | world        | testschema | tagdetails_ratiolesserthan05matchfulltrue | comments | AmazonRedshift_FullMatchPII_SC3Tag | EDIColumnQuerywithSchema | TagNotAssigned |

  @AmazonRedshift @PIITag
  Scenario Outline:Policy2:Create root tag and sub tag for Oracle CDB Anlayzer and Update policy tags for Oracle Anlayzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | body                                                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions | ida/AmazonRedShiftPayloads/API/PolicyEngine/AmazonRedshift_policy2.json | 204           |                  |          |

  @MLP-20518 @sanity @positive @regression
  Scenario Outline:SC#PII_2:Re run Anlayzer plugin for 2nd time
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | bodyFile | path | response code | response message | jsonPath                                                    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/AmazonRedshiftAnalyzer |          |      | 200           | IDLE             | $.[?(@.configurationName=='AmazonRedshiftAnalyzer')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/AmazonRedshiftAnalyzer  |          |      | 200           |                  |                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/AmazonRedshiftAnalyzer |          |      | 200           | IDLE             | $.[?(@.configurationName=='AmazonRedshiftAnalyzer')].status |

  @AmazonRedshift @PIITag
  Scenario:SC16#MLP_26096_Verify PIItags for AmazonRedshift Table , minimumRatio:0.6 matchfull false and matchempty true
  Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in AmazonRedshift Table.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 2 rows empty/1 row blank, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                          | Column    | Tags                               | Query                    | Action      |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | gender    | AmazonRedshift_GenderPII_SC7Tag    | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ssn       | AmazonRedshift_SSNPII_SC7Tag       | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | ipaddress | AmazonRedshift_IPAddressPII_SC7Tag | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | full_name | AmazonRedshift_FullNamePII_SC7Tag  | EDIColumnQuerywithSchema | TagAssigned |
      | world        | testschema | tagdetails_ratiogreaterthan05emptyfalsetrue | email     | AmazonRedshift_EmailPII_SC7Tag     | EDIColumnQuerywithSchema | TagAssigned |

  @AmazonRedshift @PIITag
  Scenario:SC17#MLP_26096_Verify PIItags for AmazonRedshift Table , minimumRatio:0.6 matchfull true and matchempty false
  Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in OracleDB table.
  (Ex: 0.6 - 6 or more rows should have matcning column values - dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                         | Column   | Tags                               | Query                    | Action      |
      | world        | testschema | tagdetails_ratiogreaterthan05matchfulltrue | comments | AmazonRedshift_FullMatchPII_SC2Tag | EDIColumnQuerywithSchema | TagAssigned |

  @AmazonRedshift @PIITag
  Scenario:SC18#MLP_26096_Verify PIItags for AmazonRedshift Table , minimumRatio:0.2 matchfull true and matchempty false
  Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the exact data in column in OracleDB table.
  (Ex: 0.2 - 2 or more rows should have matcning column values - namePattern,typePattern,dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName | SchemaName | TableName/Filename                        | Column   | Tags                               | Query                    | Action      |
      | world        | testschema | tagdetails_ratiolesserthan05matchfulltrue | comments | AmazonRedshift_FullMatchPII_SC4Tag | EDIColumnQuerywithSchema | TagAssigned |

   #####################################################################Delete Policy Tags and Rules############################################################

  @AmazonRedshift
  Scenario Outline:Deleting the Policy Pattern tags and Rules
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=AmazonRedshiftAnalyzer&technologies= |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | /tags/Default/tags/AmazonRedshift_PII                                                     |      | 204           |                  |          |

  @sanity @positive
  Scenario:SC#PII_8:Delete id's
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | MultipleIDDelete | Default | cataloger/AmazonRedshiftCataloger/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/AmazonRedshiftAnalyzer/%                            | Analysis |       |       |
      | MultipleIDDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |


  @RedShift @positve @regression @sanity
  Scenario:Delete plugin Configurations
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                             | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/AmazonRedshiftAnalyzer       |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftCataloger      |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftDataSource     |      | 204           |                  |          |
      |                  |       |       | Delete | settings/credentials/Redshift_Credentials       |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/RedshiftInvalidCredentials |      | 200           |                  |          |
#      |                  |       |       | Delete | settings/credentials/EDIBusValidCredentials     |      | 200           |                  |          |


###############################################################    END of PII Tags Cases       ############################################################################################################

