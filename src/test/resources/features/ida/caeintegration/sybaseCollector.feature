Feature: CAE Testing for sybase

  #######################################Add Credential for the sybase##############################################

  @sanity @positive @regression @IDA_E2E
  Scenario Outline:SC#Add Credentials for sybase
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                      | bodyFile                                                             | path             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Valid_sybase_Cred   | payloads/ida/CAE_Sybase_Payloads/Credentials/sybase_credentials.json | $.valid_sybase   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Valid_sybase_Cred   |                                                                      |                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Invalid_sybase_Cred | payloads/ida/CAE_Sybase_Payloads/Credentials/sybase_credentials.json | $.invalid_sybase | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Invalid_sybase_Cred |                                                                      |                  | 200           |                  |          |


    ##################################DataSource Test connection for Valid and Invalid Credentials##############################

  ##7185438## ##7185439##
  @webtest @negative
  Scenario:SC#1_Verify whether the background of the panel is displayed in red when connection to DataSource is unsuccessful due to invalid credential/Invalid Host/Invalid DB name in CAE Node (DataSource plugin)
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Data Sources          |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | DataSource_for_Sybase |
      | Credential       | Invalid_sybase_Cred   |
      | Node             | Headless-EDI          |
    And user "enter text" in Add Data Source Page
      | fieldName    | attribute                                      |
      | Name         | Invalid_Sybase_DataSourceTest                  |
      | Label        | Invalid_Sybase_DataSourceTest                  |
      | Database Url | jdbc:sybase:Tds:gechcae-col1.asg.com:5000/jdbc |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute         |
      | Credential | Valid_sybase_Cred |
    And user "enter text" in Add Data Source Page
      | fieldName    | attribute                                   |
      | Database Url | jdbc:sybase:Tds:gech-col1.asg.com:5000/jdbc |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user "enter text" in Add Data Source Page
      | fieldName    | attribute                                    |
      | Database Url | jdbc:sybase:Tds:gechcae-col1.asg.com:5000/jd |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"


  ##7185437##
  @positve @regression @sanity @webtest
  Scenario:SC#1_Verify whether the background of the panel is displayed in green when connection to DataSource is successful due to valid credential in CAE Node (DataSource Plugin)
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Data Sources          |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | DataSource_for_Sybase |
      | Credential       | Valid_sybase_Cred     |
      | Node             | Headless-EDI          |
    And user "enter text" in Add Data Source Page
      | fieldName    | attribute                                      |
      | Name         | Valid_Sybase_DataSourceTest                    |
      | Label        | Valid_Sybase_DataSourceTest                    |
      | Database Url | jdbc:sybase:Tds:gechcae-col1.asg.com:5000/jdbc |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"


     ########################################################DataSource Test connection in Plugin Config with Valid and Invalid Credentials###############################################################


  ##7199286##
  @webtest
  Scenario:SC#2_Verify wheather the background in the Cataloger panel is red when connection is unsuccessful due to Invalid Credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | Headless-EDI |
    And user "click" on "Add Configuration" button under "Headless-EDI" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute                |
      | Type       | Collector                |
      | Plugin     | CAE_Collector_for_Sybase |
      | Credential | Invalid_sybase_Cred      |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute             |
      | Name      | Sybase_Collector_Test |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute                   |
      | Data Source | Valid_Sybase_DataSourceTest |
      | Credential  | Invalid_sybase_Cred         |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Configuration Sources Page"



  ##7199618##
  @webtest
  Scenario:SC#2_Verify whether the background in the Cataloger panel is green when connection is successful due to valid Credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | Headless-EDI |
    And user "click" on "Add Configuration" button under "Headless-EDI" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute                |
      | Type       | Collector                |
      | Plugin     | CAE_Collector_for_Sybase |
      | Credential | Valid_sybase_Cred        |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute             |
      | Name      | Sybase_Collector_Test |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute                   |
      | Data Source | Valid_Sybase_DataSourceTest |
      | Credential  | Valid_sybase_Cred           |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"
    And user "click" on "Save" button in "Add Configuration Sources Page"



    ############################################################Verify Mandatory Error Message in sybase Datasource and Collector plugin####################################################################

  ##7185440##
  @webtest @jdbc
  Scenario:SC#3_Verify proper error message is shown if mandatory fields are not filled in sybase_DataSource plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Data Sources          |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | DataSource_for_Sybase |
    And user "enter text" in Add Data Source Page
      | fieldName    | attribute |
      | Name         |           |
      | Database Url | A         |
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName    | errorMessage                                                                                                                                  |
      | Database Url | Invalid Sybase JDBC URL. The URL should comply with standard Sybase JDBC URL format. Sample Format : jdbc:sybase:Tds:[host]:[port]/[database] |
    And user press "BACK_SPACE" key using key press event
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName    | errorMessage                           |
      | Name         | Name field should not be empty         |
      | Database Url | Database Url field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  ##7200324##
  @webtest @jdbc
  Scenario:SC#3_Verify proper error message is shown if mandatory fields are not filled in CAE_Collector_for_Sybase plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Configurations        |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | Headless-EDI |
    And user "click" on "Add Configuration" button under "Headless-EDI" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                |
      | Type      | Collector                |
      | Plugin    | CAE_Collector_for_Sybase |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  @webtest
  Scenario:SC3#Verify presence of configuration fields for sybase Collector
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Add Data source Configuration"
    And user performs "click" operation in Manage Configurations panel
      | button            | actionItem   |
      | Open Deployment   | Headless-EDI |
      | Add Configuration |              |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute                |
      | Type      | Collector                |
      | Plugin    | CAE_Collector_for_Sybase |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*                |
      | Label                |
      | Business Application |
      | Schema Filters       |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Plugin version      |
      | Event condition     |
      | Tags                |
      | Configuration Lines |
      | DEBUG               |
      | JAVA_MEMORY_HEAP_1  |
      | JAVA_MEMORY_HEAP_2  |


  Scenario Outline: SC5#Create BusinessApplication tag
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                 | bodyFile                                                  | path               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | /items/Default/root | payloads/ida/CAE_sybase_Payloads/BusinessApplication.json | $.sybase_creator   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | /items/Default/root | payloads/ida/CAE_sybase_Payloads/BusinessApplication.json | $.sybase_collector | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | /items/Default/root | payloads/ida/CAE_sybase_Payloads/BusinessApplication.json | $.sybase_feeder    | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | /items/Default/root | payloads/ida/CAE_sybase_Payloads/BusinessApplication.json | $.sybase_ddloader  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | /items/Default/root | payloads/ida/CAE_sybase_Payloads/BusinessApplication.json | $.sybase_lineage   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | /items/Default/root | payloads/ida/CAE_sybase_Payloads/BusinessApplication.json | $.sybase_deletor   | 200           |                  |          |



     ############################################################Verify the CAECreator plugin for sybase ############################################################
  Scenario Outline:SC4# Run the CAE Creator plugin for sybase
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | bodyFile                                                                             | path                                    | response code | response message            | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/Valid_CAE_Creator_Deletor_sybase_Cred                          | payloads/ida/CAE_sybase_Payloads/Credentials/sybase_Creator_Deletor_credentials.json | $.Valid_CAE_Creator_Deletor_sybase_Cred | 200           |                             |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Creator_Deletor_sybase_Cred                          |                                                                                      |                                         | 200           |                             |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybaseEP_Creator_Deletor_DS                        | payloads/ida/CAE_sybase_Payloads/sybase_Creator_Deletor_DataSource.json              | $.sybaseEP_Creator_Deletor_DS           | 204           |                             |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybaseEP_Creator_Deletor_DS                        |                                                                                      |                                         | 200           | sybaseEP_Creator_Deletor_DS |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAECreateEntryPoint/sybaseEP_Creator                             | payloads/ida/CAE_sybase_Payloads/sybase_Creator_Deletor.json                         | $.sybaseEP_Creator                      | 204           |                             |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAECreateEntryPoint/sybaseEP_Creator                             |                                                                                      |                                         | 200           | sybaseEP_Creator            |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreateEntryPoint/sybaseEP_Creator |                                                                                      |                                         | 200           | IDLE                        | $.[?(@.configurationName=='sybaseEP_Creator')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAECreateEntryPoint/sybaseEP_Creator  |                                                                                      |                                         | 200           |                             |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAECreateEntryPoint/sybaseEP_Creator |                                                                                      |                                         | 200           | IDLE                        | $.[?(@.configurationName=='sybaseEP_Creator')].status |


  ##7198384##
  @webtest
  Scenario:SC#04:BA Tag, Tech tag for CAECreatorEntryPoint Plugin
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SYBASE_CREATOR_BA" and clicks on search
    And user performs "facet selection" in "SYBASE_CREATOR_BA" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SYBASE_CREATOR_BA,BEC" should get displayed for the column "other/CAECreateEntryPoint/sybaseEP_Creator"
    And user delete all "Analysis" log with name "other/CAECreateEntryPoint/sybaseEP_Creator/%" using database

    ##################################################################Verify DES file is not collected when Invalid credentials is used in the sybase collector###############################################

  Scenario Outline:SC5# Run the sybase Collector plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                             | bodyFile                                                | path                                  | response code | response message                    | jsonPath                                                                 |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase                                                                        | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json | $.sybase_DataSource                   | 204           |                                     |                                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase                                                                        |                                                         |                                       | 200           | sybase_DataSource                   |                                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase                                                                     | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json  | $.sybase_Collector_InvalidCredentials | 204           |                                     |                                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase                                                                     |                                                         |                                       | 200           | sybase_Collector_InvalidCredentials |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_InvalidCredentials |                                                         |                                       | 200           | IDLE                                | $.[?(@.configurationName=='sybase_Collector_InvalidCredentials')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_InvalidCredentials  |                                                         |                                       | 200           |                                     |                                                                          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_InvalidCredentials |                                                         |                                       | 200           | IDLE                                | $.[?(@.configurationName=='sybase_Collector_InvalidCredentials')].status |


  ##7203229##
  Scenario: SC5# Verify the error count in CAE Collector analysis log
    Given Verify Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_InvalidCredentials%" info/error/warning for below parameters
      | assertion      | type  | code           | logMessage                                                |
      | should contain | error | VHC-ERR-300105 | VHC-ERR-300105 : DBMS connection could not be established |
    And Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_InvalidCredentials%" should display below info/error/warning
      | type | logValue                                                                                                                                      | logCode       | pluginName               | removableText |
      | INFO | Plugin CAE_Collector_for_Sybase Start Time:2020-08-20 15:43:58.844, End Time:2020-08-20 15:44:04.500, Processed Count:0, Errors:4, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Sybase |               |
      | INFO | Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                    | ANALYSIS-0075 | CAE_Collector_for_Sybase |               |
    And user delete all "Analysis" log with name "collector/CAE_Collector_for_Sybase/sybase_Collector_InvalidCredentials%" using database


    ##################################################################Verify DES file is not collected when tilt (~) is used to combine two config lines into one###############################################

  Scenario Outline:SC5_1# Run the sybase Collector plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                           | bodyFile                                                | path                                | response code | response message                  | jsonPath                                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase                                                                      | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json | $.sybase_DataSource                 | 204           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase                                                                      |                                                         |                                     | 200           | sybase_DataSource                 |                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_withTiltInConfig                                 | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json  | $.sybase_Collector_withTiltInConfig | 204           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_withTiltInConfig                                 |                                                         |                                     | 200           | sybase_Collector_withTiltInConfig |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_withTiltInConfig |                                                         |                                     | 200           | IDLE                              | $.[?(@.configurationName=='sybase_Collector_withTiltInConfig')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_withTiltInConfig  |                                                         |                                     | 200           |                                   |                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_withTiltInConfig |                                                         |                                     | 200           | IDLE                              | $.[?(@.configurationName=='sybase_Collector_withTiltInConfig')].status |

  ##7237471##
  Scenario: SC5_1# Verify the error count in CAE Collector analysis log
    Given Verify Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_withTiltInConfig%" info/error/warning for below parameters
      | assertion      | type  | code           | logMessage                                                                                          |
      | should contain | error | VHC-ERR-300338 | VHC-ERR-300338 : First parameter is not a valid source location (must be DIR, etc), found BATCH=200 |
    And Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_withTiltInConfig%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Sybase Start Time:2020-10-22 15:31:34.909, End Time:2020-10-22 15:31:39.288, Processed Count:0, Errors:9, Warnings:2 | ANALYSIS-0072 | CAE_Collector_for_Sybase |               |
      | INFO | Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                   | ANALYSIS-0075 | CAE_Collector_for_Sybase |               |
    And user delete all "Analysis" log with name "collector/CAE_Collector_for_Sybase/sybase_Collector_withTiltInConfig%" using database


    #####################################Verify the Tags, Hierarchy, metadata verification for sybase collector when the collector ran without any schema filter####################################################################################################################################################

  Scenario Outline:SC4#Run the sybase Collector, feeder and loader plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                          | bodyFile                                                                    | path                       | response code | response message  | jsonPath                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase                                                     | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json                     | $.sybase_DataSource        | 204           |                   |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase                                                     |                                                                             |                            | 200           | sybase_DataSource |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase                                                  | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json                      | $.sybase_Collector         | 204           |                   |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase                                                  |                                                                             |                            | 200           | sybase_Collector  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector |                                                                             |                            | 200           | IDLE              | $.[?(@.configurationName=='sybase_Collector')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector  | payloads/ida/CAE_sybase_Payloads/empty.json                                 | $.emptyJson                | 200           |                   |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector |                                                                             |                            | 200           | IDLE              | $.[?(@.configurationName=='sybase_Collector')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                            | payloads/ida/CAE_sybase_Payloads/Credentials/sybase_Feeder_credentials.json | $.valid_sybase_Feeder_Cred | 200           |                   |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                            |                                                                             |                            | 200           |                   |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                            | payloads/ida/CAE_sybase_Payloads/sybase_Feeder_DataSource.json              | $.sybase_Feeder_DataSource | 204           |                   |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                            |                                                                             |                            | 200           | sybase_Feeder_DS  |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/sybase_Feeder                                                     | payloads/ida/CAE_sybase_Payloads/sybase_Feeder.json                         | $.sybase_Feeder            | 204           |                   |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/sybase_Feeder                                                     |                                                                             |                            | 200           | sybase_Feeder     |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                         |                                                                             |                            | 200           | IDLE              | $.[?(@.configurationName=='sybase_Feeder')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                          |                                                                             |                            | 200           |                   |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                         |                                                                             |                            | 200           | IDLE              | $.[?(@.configurationName=='sybase_Feeder')].status    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                               | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json                       | $.sybase_DDLoader          | 204           |                   |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                               |                                                                             |                            | 200           | sybase_DDLoader   |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader               |                                                                             |                            | 200           | IDLE              | $.[?(@.configurationName=='sybase_DDLoader')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                |                                                                             |                            | 200           |                   |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader               |                                                                             |                            | 200           | IDLE              | $.[?(@.configurationName=='sybase_DDLoader')].status  |


  ##7198383## ##Bug Exists##
  @webtest
  Scenario: Verify the Breadcrumb hierarchy for the sybase
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ACCOUNTING_HISTORY" and clicks on search
    And user performs "definite facet selection" in "SYBASE_BA" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ID" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | GECHCAE-COL1.ASG.COM |
      | SYBASE:5000          |
      | JDBC                 |
      | DBO                  |
      | ACCOUNTING_HISTORY   |
      | ID                   |


  ##7198384## ##BUG exists##
  @webtest
  Scenario:SC#_Verify Bussiness tag, Technology appears correctly in sybase items
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SYBASE_FEEDER_BA" and clicks on search
    And user performs "facet selection" in "SYBASE_FEEDER_BA" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SYBASE_FEEDER_BA,BEC" should get displayed for the column "other/CAEFeed/sybase_Feeder"
    And user enters the search text "SYBASE_BA" and clicks on search
    And user performs "facet selection" in "SYBASE_BA" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "SYBASE_LOADER_BA,SYBASE_BA,BEC" should get displayed for the column "collector/CAEDDLoader/sybase_DDLoader"
    Then the following tags "SYBASE_BA,BEC" should get displayed for the column "collector/CAE_Collector_for_Sybase/sybase_Collector"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                          | fileName                | userTag                 |
      | Default     | Table      | Metadata Type | Sybase/SAP ASE,BEC,SYBASE_BA | ACCOUNTING_HISTORY      | ACCOUNTING_HISTORY      |
      | Default     | Column     | Metadata Type | Sybase/SAP ASE,BEC,SYBASE_BA | FPML_TAG                | FPML_TAG                |
      | Default     | Constraint | Metadata Type | Sybase/SAP ASE,BEC,SYBASE_BA | JDBC_ADDRESS_FK         | JDBC_ADDRESS_FK         |
      | Default     | Routine    | Metadata Type | Sybase/SAP ASE,BEC,SYBASE_BA | GETADDRESS              | GETADDRESS              |
      | Default     | Index      | Metadata Type | Sybase/SAP ASE,BEC,SYBASE_BA | NAME_IND                | NAME_IND                |
      | Default     | Trigger    | Metadata Type | Sybase/SAP ASE,BEC,SYBASE_BA | UPDATE_CUSTOMER_TRIGGER | UPDATE_CUSTOMER_TRIGGER |
      | Default     | Cluster    | Metadata Type | Sybase/SAP ASE,BEC,SYBASE_BA | GECHCAE-COL1.ASG.COM    | GECHCAE-COL1.ASG.COM    |
      | Default     | Service    | Metadata Type | Sybase/SAP ASE,BEC,SYBASE_BA | SYBASE:5000             | SYBASE:5000             |
      | Default     | Database   | Metadata Type | Sybase/SAP ASE,BEC,SYBASE_BA | JDBC                    | JDBC                    |
      | Default     | Schema     | Metadata Type | Sybase/SAP ASE,BEC,SYBASE_BA | DBO                     | DBO                     |


  ##7198375##
  @webtest
  Scenario:Validate the data type counts in sybase
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sybase/SAP ASE" and clicks on search
    And user performs "facet selection" in "Sybase/SAP ASE" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                          | columnName | queryOperation | facet         | facetValue | count      |
      | SYBASE_JDBC  | STRUCTURED   | json/IDA.json | SybaseQueries | getTableCountFromJDBCDB             | name       | returnValue    | Metadata Type | Table      | fromSource |
      | SYBASE_JDBC  | STRUCTURED   | json/IDA.json | SybaseQueries | getConstraintCountFromJDBCDB        | name       | returnValue    | Metadata Type | Constraint | fromSource |
      | SYBASE_JDBC  | STRUCTURED   | json/IDA.json | SybaseQueries | getProcedureCountFromJDBCDB         | name       | returnValue    | Metadata Type | Routine    | fromSource |
      | SYBASE_JDBC  | STRUCTURED   | json/IDA.json | SybaseQueries | getTriggerConstraintCountFromJDBCDB | name       | returnValue    | Metadata Type | Trigger    | fromSource |
      |              |              |               |               |                                     |            |                | Metadata Type | Index      | 9          |
      |              |              |               |               |                                     |            |                | Metadata Type | Schema     | 2          |
      |              |              |               |               |                                     |            |                | Metadata Type | Database   | 1          |
      |              |              |               |               |                                     |            |                | Metadata Type | Cluster    | 1          |
      |              |              |               |               |                                     |            |                | Metadata Type | Column     | 502        |
      |              |              |               |               |                                     |            |                | Metadata Type | Service    | 1          |


  ##7198375##
  @webtest
  Scenario: SC5# Verify the Procees count and log for sybase collector and CAEDDLoader analysis log
    Given Verify Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =        119 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =        119 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          0 |
    And Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Sybase Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Sybase |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Sybase |               |
    And Analysis log "collector/CAEDDLoader/sybase_DDLoader/%" should display below info/error/warning
      | type | logValue                                                                                                                           | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:831, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                     | ANALYSIS-0020 | CAEDDLoader |               |


  ##7198384##
  @webtest
  Scenario: Verify the widget and the Metadata attributes for Cluster, Service, Database, Schema, Table, View and Column
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "GECHCAE-COL1.ASG.COM" and clicks on search
    And user performs "definite facet selection" in "Sybase/SAP ASE" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "GECHCAE-COL1.ASG.COM" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Sybase        | Description |
    Then user performs click and verify in new window
      | Table    | value       | Action                 | RetainPrevwindow | indexSwitch |
      | Services | SYBASE:5000 | verify widget contains | No               |             |
      | Services | SYBASE:5000 | click and switch tab   | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Sybase        | Description |
    Then user performs click and verify in new window
      | Table     | value | Action                 | RetainPrevwindow | indexSwitch |
      | Databases | JDBC  | verify widget contains | No               |             |
      | Databases | JDBC  | click and switch tab   | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Sybase        | Description |
    Then user performs click and verify in new window
      | Table   | value | Action                 | RetainPrevwindow | indexSwitch |
      | Schemas | DBO   | verify widget contains | No               |             |
      | Schemas | DOUG  | verify widget contains | No               |             |
      | Schemas | DBO   | click and switch tab   | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Sybase        | Description |
    Then user performs click and verify in new window
      | Table       | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Constraints | CK_CST_EMPID | verify widget contains | No               |             |
      | Constraints | CK_CST_EMPID | click and switch tab   | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Constraint Type   | CHECK         | Description |
    Then user performs click and verify in new window
      | Table | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | CK_CST_EMPID | verify widget contains | No               |             |
#      | columns | ID           | verify widget contains | No               |             |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table     | value    | Action                 | RetainPrevwindow | indexSwitch |
      | has_Index | NAME_IND | verify widget contains | No               |             |
      | has_Index | NAME_IND | click and switch tab   | No               |             |
    Then user performs click and verify in new window
      | Table | value    | Action                | RetainPrevwindow | indexSwitch |
      | Data  | NAME_IND | verify widgetcontains | No               |             |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table       | value      | Action                 | RetainPrevwindow | indexSwitch |
      | has_Routine | GETADDRESS | verify widget contains | No               |             |
      | has_Routine | GETADDRESS | click and switch tab   | No               |             |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | routineType       | PROCEDURE     | Description |
    Then user performs click and verify in new window
      | Table     | value      | Action                 | RetainPrevwindow | indexSwitch |
      | SQLSource | GETADDRESS | verify widget contains | No               |             |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table       | value | Action                 | RetainPrevwindow | indexSwitch |
      | has_Trigger | T1    | verify widget contains | No               |             |
      | has_Trigger | T1    | click and switch tab   | No               |             |
    Then user performs click and verify in new window
      | Table     | value | Action                 | RetainPrevwindow | indexSwitch |
#      | dependencies | DBO         | verify widget contains | No               |             |
#      | dependencies | TITLEAUTHOR | verify widget contains | No               |             |
      | SQLSource | T1    | verify widget contains | No               |             |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value              | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | ACCOUNTING_HISTORY | verify widget contains | No               |             |
      | Tables | ACCOUNTING_HISTORY | click and switch tab   | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Created           | Lifecycle  |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Description       | Sybase        | Description |
      | Table Type        | TABLE         | Description |
    Then user performs click and verify in new window
      | Table     | value              | Action                 | RetainPrevwindow | indexSwitch |
      | Columns   | ID                 | verify widget contains | No               |             |
      | SQLSource | ACCOUNTING_HISTORY | verify widget contains | No               |             |
      | Columns   | ID                 | click and switch tab   | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName  |
      | Description       | Description |
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | INT           | Description |
      | Length            | 4             | Statistics  |
    Then user performs click and verify in new window
      | Table | value | Action                 | RetainPrevwindow | indexSwitch |
      | Type  | INT   | verify widget contains | No               |             |


  Scenario:SC#00:Delete Cluster and all the Analysis log for Sybsae
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                  | type     | query | param |
      | MultipleIDDelete | Default | other/CAEFeed/sybase_Feeder/%                         | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/sybase_DDLoader/%               | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector/% | Analysis |       |       |


  #########################################Verify the data is deleted from the Entry Point and removed from DD When sybase Collector has PROCESS DELETE and CAEDDLoader has Clear as TRUE and Incremental as False#################################################################################################################################

  Scenario Outline:SC5#Run the sybase Collector, feeder and loader plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                         | bodyFile                                                       | path                              | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase                                                                    | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json        | $.sybase_DataSource               | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase                                                                    |                                                                |                                   | 200           | sybase_DataSource               |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE                                 | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json         | $.sybase_Collector_Process_DELETE | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE                                 |                                                                |                                   | 200           | sybase_Collector_Process_DELETE |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Collector_Process_DELETE')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE  | payloads/ida/CAE_sybase_Payloads/empty.json                    | $.emptyJson                       | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Collector_Process_DELETE')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                                           |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                           | payloads/ida/CAE_sybase_Payloads/sybase_Feeder_DataSource.json | $.sybase_Feeder_DataSource        | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                           |                                                                |                                   | 200           | sybase_Feeder_DS                |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/sybase_Feeder                                                                    | payloads/ida/CAE_sybase_Payloads/sybase_Feeder.json            | $.sybase_Feeder                   | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/sybase_Feeder                                                                    |                                                                |                                   | 200           | sybase_Feeder                   |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                        |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Feeder')].status                   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                                         |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                        |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Feeder')].status                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                              | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json          | $.sybase_DDLoader                 | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                              |                                                                |                                   | 200           | sybase_DDLoader                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                              |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_DDLoader')].status                 |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                               |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                              |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_DDLoader')].status                 |


  ####
  @webtest
  Scenario: SC#5: Verify the Log for the sybase collector(PROCESS: DELETE) and CAEDDLoader with Clear True and Incremental False runa and deletes the data from DD.
    Given Verify Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =          0 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =          0 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =        119 |
    And Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Sybase Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Sybase |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Sybase |               |
    And Analysis log "collector/CAEDDLoader/sybase_DDLoader/%" should display below info/error/warning
      | type | logValue                                                                                                                          | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:37, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                    | ANALYSIS-0020 | CAEDDLoader |               |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    Then user "verify non presence" of following "Values" in Search Results Page
      | GECHCAE-COL1.ASG.COM | No data found |


  Scenario:SC#05:Delete Cluster and all the Analysis log for Sybase
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | MultipleIDDelete | Default | other/CAEFeed/sybase_Feeder/%                                        | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/sybase_DDLoader/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE/% | Analysis |       |       |


    ######################################################Verify if the Schema Included in the Sybase Collector is collected and Loaded into DD Using the CAEDDLoader###########################################################################################

  Scenario Outline:SC6#Run the sybase Collector, feeder and loader plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                         | bodyFile                                                       | path                              | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase                                                                    | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json        | $.sybase_DataSource               | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase                                                                    |                                                                |                                   | 200           | sybase_DataSource               |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Include_Schema                                 | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json         | $.sybase_Collector_Include_Schema | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Include_Schema                                 |                                                                |                                   | 200           | sybase_Collector_Include_Schema |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Include_Schema |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Collector_Include_Schema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Include_Schema  | payloads/ida/CAE_sybase_Payloads/empty.json                    | $.emptyJson                       | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Include_Schema |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Collector_Include_Schema')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                                           |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                           | payloads/ida/CAE_sybase_Payloads/sybase_Feeder_DataSource.json | $.sybase_Feeder_DataSource        | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                           |                                                                |                                   | 200           | sybase_Feeder_DS                |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/sybase_Feeder                                                                    | payloads/ida/CAE_sybase_Payloads/sybase_Feeder.json            | $.sybase_Feeder                   | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/sybase_Feeder                                                                    |                                                                |                                   | 200           | sybase_Feeder                   |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                        |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Feeder')].status                   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                                         |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                        |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Feeder')].status                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                              | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json          | $.sybase_DDLoader                 | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                              |                                                                |                                   | 200           | sybase_DDLoader                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                              |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_DDLoader')].status                 |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                               |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                              |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_DDLoader')].status                 |


  #### ##Bug_exist##
  @webtest
  Scenario:SC#6: Validate the logs of sybase collector, CAELoader and the data type counts in sybase
    Given Verify Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Include_Schema/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =        106 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =         94 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          0 |
    And Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Include_Schema/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Sybase Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Sybase |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Sybase |               |
    And Analysis log "collector/CAEDDLoader/sybase_DDLoader/%" should display below info/error/warning
      | type | logValue                                                                                                                           | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:721, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                     | ANALYSIS-0020 | CAEDDLoader |               |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sybase/SAP ASE" and clicks on search
    And user performs "facet selection" in "Sybase/SAP ASE" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                                        | columnName | queryOperation | facet         | facetValue | count      |
      | SYBASE_JDBC  | STRUCTURED   | json/IDA.json | SybaseQueries | getTableCountFromJDBCDB_IncludeSchema             | name       | returnValue    | Metadata Type | Table      | fromSource |
      | SYBASE_JDBC  | STRUCTURED   | json/IDA.json | SybaseQueries | getConstraintCountFromJDBCDB_IncludeSchema        | name       | returnValue    | Metadata Type | Constraint | fromSource |
      | SYBASE_JDBC  | STRUCTURED   | json/IDA.json | SybaseQueries | getProcedureCountFromJDBCDB_IncludeSchema         | name       | returnValue    | Metadata Type | Routine    | fromSource |
      | SYBASE_JDBC  | STRUCTURED   | json/IDA.json | SybaseQueries | getTriggerConstraintCountFromJDBCDB_IncludeSchema | name       | returnValue    | Metadata Type | Trigger    | fromSource |
      |              |              |               |               |                                                   |            |                | Metadata Type | Index      | 9          |
      |              |              |               |               |                                                   |            |                | Metadata Type | Schema     | 1          |
      |              |              |               |               |                                                   |            |                | Metadata Type | Database   | 1          |
      |              |              |               |               |                                                   |            |                | Metadata Type | Cluster    | 1          |
      |              |              |               |               |                                                   |            |                | Metadata Type | Column     | 440        |
      |              |              |               |               |                                                   |            |                | Metadata Type | Service    | 1          |


  Scenario:SC#06:Delete Cluster and all the Analysis log for Sybase
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | MultipleIDDelete | Default | other/CAEFeed/sybase_Feeder/%                                        | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/sybase_DDLoader/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector_Include_Schema/% | Analysis |       |       |


  Scenario Outline:SC6#Delete the items from entry point
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                         | bodyFile                                                       | path                              | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase                                                                    | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json        | $.sybase_DataSource               | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase                                                                    |                                                                |                                   | 200           | sybase_DataSource               |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE                                 | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json         | $.sybase_Collector_Process_DELETE | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE                                 |                                                                |                                   | 200           | sybase_Collector_Process_DELETE |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Collector_Process_DELETE')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE  | payloads/ida/CAE_sybase_Payloads/empty.json                    | $.emptyJson                       | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Collector_Process_DELETE')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                                           |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                           | payloads/ida/CAE_sybase_Payloads/sybase_Feeder_DataSource.json | $.sybase_Feeder_DataSource        | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                           |                                                                |                                   | 200           | sybase_Feeder_DS                |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/sybase_Feeder                                                                    | payloads/ida/CAE_sybase_Payloads/sybase_Feeder.json            | $.sybase_Feeder                   | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/sybase_Feeder                                                                    |                                                                |                                   | 200           | sybase_Feeder                   |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                        |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Feeder')].status                   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                                         |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                        |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Feeder')].status                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                              | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json          | $.sybase_DDLoader                 | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                              |                                                                |                                   | 200           | sybase_DDLoader                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                              |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_DDLoader')].status                 |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                               |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                              |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_DDLoader')].status                 |


  Scenario:SC#05:Delete Cluster and all the Analysis log for the delete items in Sybase
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | MultipleIDDelete | Default | other/CAEFeed/sybase_Feeder/%                                        | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/sybase_DDLoader/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE/% | Analysis |       |       |


    ######################################################Verify if the Schema excluded in the Sybase Collector should exclude and collect other schema and Loaded into DD Using the CAEDDLoader###########################################################################################

  Scenario Outline:SC7#Run the sybase Collector, feeder and loader plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                         | bodyFile                                                       | path                              | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase                                                                    | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json        | $.sybase_DataSource               | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase                                                                    |                                                                |                                   | 200           | sybase_DataSource               |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Exclude_Schema                                 | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json         | $.sybase_Collector_Exclude_Schema | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Exclude_Schema                                 |                                                                |                                   | 200           | sybase_Collector_Exclude_Schema |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Exclude_Schema |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Collector_Exclude_Schema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Exclude_Schema  | payloads/ida/CAE_sybase_Payloads/empty.json                    | $.emptyJson                       | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Exclude_Schema |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Collector_Exclude_Schema')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                                           |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                           | payloads/ida/CAE_sybase_Payloads/sybase_Feeder_DataSource.json | $.sybase_Feeder_DataSource        | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                           |                                                                |                                   | 200           | sybase_Feeder_DS                |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/sybase_Feeder                                                                    | payloads/ida/CAE_sybase_Payloads/sybase_Feeder.json            | $.sybase_Feeder                   | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/sybase_Feeder                                                                    |                                                                |                                   | 200           | sybase_Feeder                   |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                        |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Feeder')].status                   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                                         |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                        |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Feeder')].status                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                              | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json          | $.sybase_DDLoader                 | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                              |                                                                |                                   | 200           | sybase_DDLoader                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                              |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_DDLoader')].status                 |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                               |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                              |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_DDLoader')].status                 |


  ####
  @webtest
  Scenario:SC#7: Validate the logs of sybase collector, CAELoader and the data type counts in sybase
    Given Verify Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Exclude_Schema/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =         13 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =         13 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          0 |
    And Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Exclude_Schema/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Sybase Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Sybase |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Sybase |               |
    And Analysis log "collector/CAEDDLoader/sybase_DDLoader/%" should display below info/error/warning
      | type | logValue                                                                                                                           | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:152, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                     | ANALYSIS-0020 | CAEDDLoader |               |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sybase/SAP ASE" and clicks on search
    And user performs "facet selection" in "Sybase/SAP ASE" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                            | columnName | queryOperation | facet         | facetValue | count      |
      | SYBASE_JDBC  | STRUCTURED   | json/IDA.json | SybaseQueries | getTableCountFromJDBCDB_ExcludeSchema | name       | returnValue    | Metadata Type | Table      | fromSource |
      |              |              |               |               |                                       |            |                | Metadata Type | Schema     | 1          |
      |              |              |               |               |                                       |            |                | Metadata Type | Database   | 1          |
      |              |              |               |               |                                       |            |                | Metadata Type | Cluster    | 1          |
      |              |              |               |               |                                       |            |                | Metadata Type | Column     | 62         |
      |              |              |               |               |                                       |            |                | Metadata Type | Service    | 1          |


  Scenario:SC#07:Delete Cluster and all the Analysis log for Sybase
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | MultipleIDDelete | Default | other/CAEFeed/sybase_Feeder/%                                        | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/sybase_DDLoader/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector_Exclude_Schema/% | Analysis |       |       |


  Scenario Outline:SC7#Delete the items from entry point
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                         | bodyFile                                                       | path                              | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase                                                                    | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json        | $.sybase_DataSource               | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase                                                                    |                                                                |                                   | 200           | sybase_DataSource               |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE                                 | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json         | $.sybase_Collector_Process_DELETE | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE                                 |                                                                |                                   | 200           | sybase_Collector_Process_DELETE |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Collector_Process_DELETE')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE  | payloads/ida/CAE_sybase_Payloads/empty.json                    | $.emptyJson                       | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Collector_Process_DELETE')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                                           |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                           | payloads/ida/CAE_sybase_Payloads/sybase_Feeder_DataSource.json | $.sybase_Feeder_DataSource        | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                           |                                                                |                                   | 200           | sybase_Feeder_DS                |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/sybase_Feeder                                                                    | payloads/ida/CAE_sybase_Payloads/sybase_Feeder.json            | $.sybase_Feeder                   | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/sybase_Feeder                                                                    |                                                                |                                   | 200           | sybase_Feeder                   |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                        |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Feeder')].status                   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                                         |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                        |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Feeder')].status                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                              | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json          | $.sybase_DDLoader                 | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                              |                                                                |                                   | 200           | sybase_DDLoader                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                              |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_DDLoader')].status                 |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                               |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                              |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_DDLoader')].status                 |


  Scenario:SC#07:Delete Cluster and all the Analysis log for the delete items in Sybase
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | MultipleIDDelete | Default | other/CAEFeed/sybase_Feeder/%                                        | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/sybase_DDLoader/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE/% | Analysis |       |       |


     ######################################################Verify if the Schema Included & excluded in the Sybase Collector should Include and exclude schema and Loaded into DD Using the CAEDDLoader###########################################################################################

  Scenario Outline:SC8#Run the sybase Collector, feeder and loader plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                                 | bodyFile                                                       | path                                      | response code | response message                        | jsonPath                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase                                                                            | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json        | $.sybase_DataSource                       | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase                                                                            |                                                                |                                           | 200           | sybase_DataSource                       |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Include_Exclude_Schema                                 | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json         | $.sybase_Collector_Include_Exclude_Schema | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Include_Exclude_Schema                                 |                                                                |                                           | 200           | sybase_Collector_Include_Exclude_Schema |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Include_Exclude_Schema |                                                                |                                           | 200           | IDLE                                    | $.[?(@.configurationName=='sybase_Collector_Include_Exclude_Schema')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Include_Exclude_Schema  | payloads/ida/CAE_sybase_Payloads/empty.json                    | $.emptyJson                               | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Include_Exclude_Schema |                                                                |                                           | 200           | IDLE                                    | $.[?(@.configurationName=='sybase_Collector_Include_Exclude_Schema')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                                                   |                                                                |                                           | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                                   | payloads/ida/CAE_sybase_Payloads/sybase_Feeder_DataSource.json | $.sybase_Feeder_DataSource                | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                                   |                                                                |                                           | 200           | sybase_Feeder_DS                        |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/sybase_Feeder                                                                            | payloads/ida/CAE_sybase_Payloads/sybase_Feeder.json            | $.sybase_Feeder                           | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/sybase_Feeder                                                                            |                                                                |                                           | 200           | sybase_Feeder                           |                                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                                |                                                                |                                           | 200           | IDLE                                    | $.[?(@.configurationName=='sybase_Feeder')].status                           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                                                 |                                                                |                                           | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                                |                                                                |                                           | 200           | IDLE                                    | $.[?(@.configurationName=='sybase_Feeder')].status                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                                      | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json          | $.sybase_DDLoader                         | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                                      |                                                                |                                           | 200           | sybase_DDLoader                         |                                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                                      |                                                                |                                           | 200           | IDLE                                    | $.[?(@.configurationName=='sybase_DDLoader')].status                         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                                       |                                                                |                                           | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                                      |                                                                |                                           | 200           | IDLE                                    | $.[?(@.configurationName=='sybase_DDLoader')].status                         |


  #### ##Bug ID: MLP-28934##
  @webtest
  Scenario:SC#8: Validate the logs of sybase collector, CAELoader and the data type counts in sybase
    Given Verify Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Include_Exclude_Schema/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =        106 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =         94 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          0 |
    And Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Include_Exclude_Schema/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Sybase Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Sybase |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Sybase |               |
    And Analysis log "collector/CAEDDLoader/sybase_DDLoader/%" should display below info/error/warning
      | type | logValue                                                                                                                           | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:716, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                     | ANALYSIS-0020 | CAEDDLoader |               |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sybase/SAP ASE" and clicks on search
    And user performs "facet selection" in "Sybase/SAP ASE" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath     | queryPage     | queryField                                        | columnName | queryOperation | facet         | facetValue | count      |
      | SYBASE_JDBC  | STRUCTURED   | json/IDA.json | SybaseQueries | getTableCountFromJDBCDB_IncludeSchema             | name       | returnValue    | Metadata Type | Table      | fromSource |
      | SYBASE_JDBC  | STRUCTURED   | json/IDA.json | SybaseQueries | getConstraintCountFromJDBCDB_IncludeSchema        | name       | returnValue    | Metadata Type | Constraint | fromSource |
      | SYBASE_JDBC  | STRUCTURED   | json/IDA.json | SybaseQueries | getProcedureCountFromJDBCDB_IncludeSchema         | name       | returnValue    | Metadata Type | Routine    | fromSource |
      | SYBASE_JDBC  | STRUCTURED   | json/IDA.json | SybaseQueries | getTriggerConstraintCountFromJDBCDB_IncludeSchema | name       | returnValue    | Metadata Type | Trigger    | fromSource |
      |              |              |               |               |                                                   |            |                | Metadata Type | Index      | 9          |
      |              |              |               |               |                                                   |            |                | Metadata Type | Schema     | 1          |
      |              |              |               |               |                                                   |            |                | Metadata Type | Database   | 1          |
      |              |              |               |               |                                                   |            |                | Metadata Type | Cluster    | 1          |
      |              |              |               |               |                                                   |            |                | Metadata Type | Column     | 440        |
      |              |              |               |               |                                                   |            |                | Metadata Type | Service    | 1          |


  Scenario:SC#08:Delete Cluster and all the Analysis log for Sybase
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                         | type     | query | param |
      | MultipleIDDelete | Default | other/CAEFeed/sybase_Feeder/%                                                | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/sybase_DDLoader/%                                      | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector_Include_Exclude_Schema/% | Analysis |       |       |


  Scenario Outline:SC8#Delete the items from entry point
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                         | bodyFile                                                       | path                              | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase                                                                    | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json        | $.sybase_DataSource               | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase                                                                    |                                                                |                                   | 200           | sybase_DataSource               |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector                |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Collector')].status                |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector                 | payloads/ida/CAE_sybase_Payloads/empty.json                    | $.emptyJson                       | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector                |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Collector')].status                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                        |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Feeder')].status                   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                                         |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                        |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Feeder')].status                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE                                 | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json         | $.sybase_Collector_Process_DELETE | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE                                 |                                                                |                                   | 200           | sybase_Collector_Process_DELETE |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Collector_Process_DELETE')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE  | payloads/ida/CAE_sybase_Payloads/empty.json                    | $.emptyJson                       | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Collector_Process_DELETE')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                                           |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                           | payloads/ida/CAE_sybase_Payloads/sybase_Feeder_DataSource.json | $.sybase_Feeder_DataSource        | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                           |                                                                |                                   | 200           | sybase_Feeder_DS                |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/sybase_Feeder                                                                    | payloads/ida/CAE_sybase_Payloads/sybase_Feeder.json            | $.sybase_Feeder                   | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/sybase_Feeder                                                                    |                                                                |                                   | 200           | sybase_Feeder                   |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                        |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Feeder')].status                   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                                         |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                        |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_Feeder')].status                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                              | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json          | $.sybase_DDLoader                 | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                              |                                                                |                                   | 200           | sybase_DDLoader                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                              |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_DDLoader')].status                 |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                               |                                                                |                                   | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                              |                                                                |                                   | 200           | IDLE                            | $.[?(@.configurationName=='sybase_DDLoader')].status                 |


  Scenario:SC#08:Delete Cluster and all the Analysis log for the delete items in Sybase
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | MultipleIDDelete | Default | other/CAEFeed/sybase_Feeder/%                                        | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/sybase_DDLoader/%                              | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE/% | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector/%                | Analysis |       |       |


########################################################################Incrementals Scenario: Add Data to Sybase Database and run the sybase collector with PROCESSS AUTO and CAEDDLoader with CLEAR(FALSE) and INCREMENTAL(TRUE)###########################################################################################

  Scenario Outline:SC9#Run the sybase Collector, feeder and loader plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                     | bodyFile                                                       | path                           | response code | response message             | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase/sybase_DataSource_Testing_DB                                   | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json        | $.sybase_DataSource_Testing_DB | 204           |                              |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase/sybase_DataSource_Testing_DB                                   |                                                                |                                | 200           | sybase_DataSource_Testing_DB |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Testing_DB                                 | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json         | $.sybase_Collector_Testing_DB  | 204           |                              |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Testing_DB                                 |                                                                |                                | 200           | sybase_Collector_Testing_DB  |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Testing_DB |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Collector_Testing_DB')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Testing_DB  | payloads/ida/CAE_sybase_Payloads/empty.json                    | $.emptyJson                    | 200           |                              |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Testing_DB |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Collector_Testing_DB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                                       |                                                                |                                | 200           |                              |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                       | payloads/ida/CAE_sybase_Payloads/sybase_Feeder_DataSource.json | $.sybase_Feeder_DataSource     | 204           |                              |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                       |                                                                |                                | 200           | sybase_Feeder_DS             |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/sybase_Feeder                                                                | payloads/ida/CAE_sybase_Payloads/sybase_Feeder.json            | $.sybase_Feeder                | 204           |                              |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/sybase_Feeder                                                                |                                                                |                                | 200           | sybase_Feeder                |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                    |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Feeder')].status               |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                                     |                                                                |                                | 200           |                              |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                    |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Feeder')].status               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                          | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json          | $.sybase_DDLoader              | 204           |                              |                                                                  |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                          |                                                                |                                | 200           | sybase_DDLoader              |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                          |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_DDLoader')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                           |                                                                |                                | 200           |                              |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                          |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_DDLoader')].status             |


  ####
  @webtest
  Scenario:SC#9: Validate the logs of sybase collector, CAELoader and the data type counts in sybase
    Given Verify Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Testing_DB/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =         13 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =         13 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          0 |
    And Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Testing_DB/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Sybase Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Sybase |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Sybase |               |
    And Analysis log "collector/CAEDDLoader/sybase_DDLoader/%" should display below info/error/warning
      | type | logValue                                                                                                                           | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:132, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                     | ANALYSIS-0020 | CAEDDLoader |               |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sybase/SAP ASE" and clicks on search
    And user performs "facet selection" in "Sybase/SAP ASE" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName   | dataBaseType | queryPath     | queryPage     | queryField                 | columnName | queryOperation | facet         | facetValue | count      |
      | SYBASE_TESTING | STRUCTURED   | json/IDA.json | SybaseQueries | getTableCountFromTESTINGDB | name       | returnValue    | Metadata Type | Table      | fromSource |
      |                |              |               |               |                            |            |                | Metadata Type | Column     | 50         |


  @jdbc
  Scenario:SC#9: create Table for incremental scenario
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage     | queryField                |
      | SYBASE_TESTING     | EXECUTEQUERY | json/IDA.json | SybaseQueries | createTableForIncremental |
      | SYBASE_TESTING     | EXECUTEQUERY | json/IDA.json | SybaseQueries | createViewForIncremental  |


  Scenario Outline:SC9#Run the sybase Collector, feeder and loader plugin for Incremental
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                      | bodyFile                                                       | path                           | response code | response message             | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase/sybase_DataSource_Testing_DB                                    | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json        | $.sybase_DataSource_Testing_DB | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase/sybase_DataSource_Testing_DB                                    |                                                                |                                | 200           | sybase_DataSource_Testing_DB |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Incremental                                 | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json         | $.sybase_Collector_Incremental | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Incremental                                 |                                                                |                                | 200           | sybase_Collector_Incremental |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Collector_Incremental')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental  | payloads/ida/CAE_sybase_Payloads/empty.json                    | $.emptyJson                    | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Collector_Incremental')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                                        |                                                                |                                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                        | payloads/ida/CAE_sybase_Payloads/sybase_Feeder_DataSource.json | $.sybase_Feeder_DataSource     | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                        |                                                                |                                | 200           | sybase_Feeder_DS             |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/sybase_Feeder                                                                 | payloads/ida/CAE_sybase_Payloads/sybase_Feeder.json            | $.sybase_Feeder                | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/sybase_Feeder                                                                 |                                                                |                                | 200           | sybase_Feeder                |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                     |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Feeder')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                                      |                                                                |                                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                     |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Feeder')].status                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader_1                                                         | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json          | $.sybase_DDLoader_1            | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader_1                                                         |                                                                |                                | 200           | sybase_DDLoader_1            |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_1                         |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_DDLoader_1')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_1                          |                                                                |                                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_1                         |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_DDLoader_1')].status            |


  #### ##BUG Exists##
  @webtest
  Scenario:SC#9: Validate the logs of sybase collector, CAELoader and the data type counts in sybase for Incremental Scenario
    Given Verify Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =         15 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =         10 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          0 |
    And Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Sybase Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Sybase |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Sybase |               |
    And Analysis log "collector/CAEDDLoader/sybase_DDLoader_1/%" should display below info/error/warning
      | type | logValue                                                                                                                          | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:14, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                    | ANALYSIS-0020 | CAEDDLoader |               |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sybase/SAP ASE" and clicks on search
    And user performs "facet selection" in "Sybase/SAP ASE" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName   | dataBaseType | queryPath     | queryPage     | queryField                 | columnName | queryOperation | facet         | facetValue | count      |
      | SYBASE_TESTING | STRUCTURED   | json/IDA.json | SybaseQueries | getTableCountFromTESTINGDB | name       | returnValue    | Metadata Type | Table      | fromSource |
      |                |              |               |               |                            |            |                | Metadata Type | Column     | 60         |


  Scenario:SC#09:Delete Cluster and all the Analysis log for the delete items in Sybase
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                              | type     | query | param |
      | MultipleIDDelete | Default | other/CAEFeed/sybase_Feeder/%                                     | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/sybase_DDLoader/%                           | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/sybase_DDLoader_1/%                         | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental/% | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector_Testing_DB/%  | Analysis |       |       |


    #########################################ncrementals Scenario: Delete Data to Sybase Database and run the sybase collector with PROCESSS AUTO and CAEDDLoader with CLEAR(FALSE) and INCREMENTAL(TRUE) and Negative(TRUE)###########################################################################################

  @jdbc
  Scenario:SC#10: Drop Table for incremental scenario
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage     | queryField              |
      | SYBASE_TESTING     | EXECUTEQUERY | json/IDA.json | SybaseQueries | dropViewForIncremental  |
      | SYBASE_TESTING     | EXECUTEQUERY | json/IDA.json | SybaseQueries | dropTableForIncremental |


  Scenario Outline:SC10#Run the sybase Collector, feeder and loader plugin for Incremental
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                      | bodyFile                                                       | path                           | response code | response message             | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase/sybase_DataSource_Testing_DB                                    | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json        | $.sybase_DataSource_Testing_DB | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase/sybase_DataSource_Testing_DB                                    |                                                                |                                | 200           | sybase_DataSource_Testing_DB |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Incremental                                 | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json         | $.sybase_Collector_Incremental | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Incremental                                 |                                                                |                                | 200           | sybase_Collector_Incremental |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Collector_Incremental')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental  | payloads/ida/CAE_sybase_Payloads/empty.json                    | $.emptyJson                    | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Collector_Incremental')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                                        |                                                                |                                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                        | payloads/ida/CAE_sybase_Payloads/sybase_Feeder_DataSource.json | $.sybase_Feeder_DataSource     | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                        |                                                                |                                | 200           | sybase_Feeder_DS             |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/sybase_Feeder                                                                 | payloads/ida/CAE_sybase_Payloads/sybase_Feeder.json            | $.sybase_Feeder                | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/sybase_Feeder                                                                 |                                                                |                                | 200           | sybase_Feeder                |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                     |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Feeder')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                                      |                                                                |                                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                     |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Feeder')].status                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader_2                                                         | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json          | $.sybase_DDLoader_2            | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader_2                                                         |                                                                |                                | 200           | sybase_DDLoader_2            |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_2                         |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_DDLoader_2')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_2                          |                                                                |                                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_2                         |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_DDLoader_2')].status            |


  #### ##BUG Exists##
  @webtest
  Scenario:SC#10: Validate the logs of sybase collector, CAELoader and the data type counts in sybase for Incremental Scenario
    Given Verify Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =         13 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =          8 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          2 |
    And Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Sybase Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Sybase |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Sybase |               |
    And Analysis log "collector/CAEDDLoader/sybase_DDLoader_2/%" should display below info/error/warning
      | type | logValue                                                                                                                         | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                   | ANALYSIS-0020 | CAEDDLoader |               |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sybase/SAP ASE" and clicks on search
    And user performs "facet selection" in "Sybase/SAP ASE" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName   | dataBaseType | queryPath     | queryPage     | queryField                 | columnName | queryOperation | facet         | facetValue | count      |
      | SYBASE_TESTING | STRUCTURED   | json/IDA.json | SybaseQueries | getTableCountFromTESTINGDB | name       | returnValue    | Metadata Type | Table      | fromSource |
      |                |              |               |               |                            |            |                | Metadata Type | Column     | 50         |


  Scenario:SC#10:Delete Cluster and all the Analysis log for the delete items in Sybase
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                              | type     | query | param |
      | MultipleIDDelete | Default | other/CAEFeed/sybase_Feeder/%                                     | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/sybase_DDLoader_2/%                         | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental/% | Analysis |       |       |


    ###############################################Incrementals Scenario: Add Data to Sybase Database and run the sybase collector with PROCESSS AUTO and CAEDDLoader with CLEAR(FALSE) and INCREMENTAL(FALSE)###########################################################################################

  @jdbc
  Scenario:SC#11: create Table for incremental scenario
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage     | queryField                |
      | SYBASE_TESTING     | EXECUTEQUERY | json/IDA.json | SybaseQueries | createTableForIncremental |
      | SYBASE_TESTING     | EXECUTEQUERY | json/IDA.json | SybaseQueries | createViewForIncremental  |


  Scenario Outline:SC11#Run the sybase Collector, feeder and loader plugin for Incremental
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                      | bodyFile                                                       | path                           | response code | response message             | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase/sybase_DataSource_Testing_DB                                    | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json        | $.sybase_DataSource_Testing_DB | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase/sybase_DataSource_Testing_DB                                    |                                                                |                                | 200           | sybase_DataSource_Testing_DB |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Incremental                                 | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json         | $.sybase_Collector_Incremental | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Incremental                                 |                                                                |                                | 200           | sybase_Collector_Incremental |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Collector_Incremental')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental  | payloads/ida/CAE_sybase_Payloads/empty.json                    | $.emptyJson                    | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Collector_Incremental')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                                        |                                                                |                                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                        | payloads/ida/CAE_sybase_Payloads/sybase_Feeder_DataSource.json | $.sybase_Feeder_DataSource     | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                        |                                                                |                                | 200           | sybase_Feeder_DS             |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/sybase_Feeder                                                                 | payloads/ida/CAE_sybase_Payloads/sybase_Feeder.json            | $.sybase_Feeder                | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/sybase_Feeder                                                                 |                                                                |                                | 200           | sybase_Feeder                |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                     |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Feeder')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                                      |                                                                |                                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                     |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Feeder')].status                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader_3                                                         | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json          | $.sybase_DDLoader_3            | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader_3                                                         |                                                                |                                | 200           | sybase_DDLoader_3            |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_3                         |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_DDLoader_3')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_3                          |                                                                |                                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_3                         |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_DDLoader_3')].status            |


  #### ##BUG Exists##
  @webtest
  Scenario:SC#11: Validate the logs of sybase collector, CAELoader and the data type counts in sybase for Incremental Scenario
    Given Verify Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =         15 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =         10 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          0 |
    And Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Sybase Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Sybase |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Sybase |               |
    And Analysis log "collector/CAEDDLoader/sybase_DDLoader_3/%" should display below info/error/warning
      | type | logValue                                                                                                                           | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:132, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                     | ANALYSIS-0020 | CAEDDLoader |               |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sybase/SAP ASE" and clicks on search
    And user performs "facet selection" in "Sybase/SAP ASE" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName   | dataBaseType | queryPath     | queryPage     | queryField                 | columnName | queryOperation | facet         | facetValue | count      |
      | SYBASE_TESTING | STRUCTURED   | json/IDA.json | SybaseQueries | getTableCountFromTESTINGDB | name       | returnValue    | Metadata Type | Table      | fromSource |
      |                |              |               |               |                            |            |                | Metadata Type | Column     | 60         |


  Scenario:SC#11:Delete Cluster and all the Analysis log for the delete items in Sybase
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                              | type     | query | param |
      | MultipleIDDelete | Default | other/CAEFeed/sybase_Feeder/%                                     | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/sybase_DDLoader_3/%                         | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental/% | Analysis |       |       |


    ##########################################Incrementals Scenario: Remove Data from Sybase Database and run the sybase collector with PROCESSS AUTO and CAEDDLoader with CLEAR(FALSE) and INCREMENTAL(FALSE) and Negative(TRUE)###########################################################################################

  @jdbc
  Scenario:SC#12: Drop Table for incremental scenario
    Given user connects to the database and performs the following operation
      | databaseConnection | Operation    | queryPath     | queryPage     | queryField              |
      | SYBASE_TESTING     | EXECUTEQUERY | json/IDA.json | SybaseQueries | dropViewForIncremental  |
      | SYBASE_TESTING     | EXECUTEQUERY | json/IDA.json | SybaseQueries | dropTableForIncremental |


  Scenario Outline:SC12#Run the sybase Collector, feeder and loader plugin for Incremental
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                      | bodyFile                                                       | path                           | response code | response message             | jsonPath                                                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_Sybase/sybase_DataSource_Testing_DB                                    | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json        | $.sybase_DataSource_Testing_DB | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_Sybase/sybase_DataSource_Testing_DB                                    |                                                                |                                | 200           | sybase_DataSource_Testing_DB |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Incremental                                 | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json         | $.sybase_Collector_Incremental | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Incremental                                 |                                                                |                                | 200           | sybase_Collector_Incremental |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Collector_Incremental')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental  | payloads/ida/CAE_sybase_Payloads/empty.json                    | $.emptyJson                    | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Collector_Incremental')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                                        |                                                                |                                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                        | payloads/ida/CAE_sybase_Payloads/sybase_Feeder_DataSource.json | $.sybase_Feeder_DataSource     | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                        |                                                                |                                | 200           | sybase_Feeder_DS             |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/sybase_Feeder                                                                 | payloads/ida/CAE_sybase_Payloads/sybase_Feeder.json            | $.sybase_Feeder                | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/sybase_Feeder                                                                 |                                                                |                                | 200           | sybase_Feeder                |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                     |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Feeder')].status                |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                                      |                                                                |                                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                     |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_Feeder')].status                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader_4                                                         | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json          | $.sybase_DDLoader_4            | 204           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader_4                                                         |                                                                |                                | 200           | sybase_DDLoader_4            |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_4                         |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_DDLoader_4')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_4                          |                                                                |                                | 200           |                              |                                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_4                         |                                                                |                                | 200           | IDLE                         | $.[?(@.configurationName=='sybase_DDLoader_4')].status            |


  #### ##BUG Exists##
  @webtest
  Scenario:SC#12: Validate the logs of sybase collector, CAELoader and the data type counts in sybase for Incremental Scenario
    Given Verify Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                                                 |
      | should contain | INFO | VHC-INF-300900 | VHC-INF-300900 : Total number of directory objects processed  =         13 |
      | should contain | INFO | VHC-INF-300901 | VHC-INF-300901 : Total number of objects loaded               =          8 |
      | should contain | INFO | VHC-INF-300902 | VHC-INF-300902 : Total number of objects deleted              =          2 |
    And Analysis log "collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental/%" should display below info/error/warning
      | type | logValue                                                                                                                                                     | logCode       | pluginName               | removableText |
      | INFO | ANALYSIS-0072: Plugin CAE_Collector_for_Sybase Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAE_Collector_for_Sybase |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                               | ANALYSIS-0020 | CAE_Collector_for_Sybase |               |
    And Analysis log "collector/CAEDDLoader/sybase_DDLoader_4/%" should display below info/error/warning
      | type | logValue                                                                                                                           | logCode       | pluginName  | removableText |
      | INFO | Plugin CAEDDLoader Start Time:2020-09-22 20:30:28.559, End Time:2020-09-22 20:30:37.210, Processed Count:117, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDDLoader |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                     | ANALYSIS-0020 | CAEDDLoader |               |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Sybase/SAP ASE" and clicks on search
    And user performs "facet selection" in "Sybase/SAP ASE" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName   | dataBaseType | queryPath     | queryPage     | queryField                 | columnName | queryOperation | facet         | facetValue | count      |
      | SYBASE_TESTING | STRUCTURED   | json/IDA.json | SybaseQueries | getTableCountFromTESTINGDB | name       | returnValue    | Metadata Type | Table      | fromSource |
      |                |              |               |               |                            |            |                | Metadata Type | Column     | 50         |


  Scenario:SC#12:Delete Cluster and all the Analysis log for the delete items in Sybase
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                              | type     | query | param |
      | MultipleIDDelete | Default | other/CAEFeed/sybase_Feeder/%                                     | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/sybase_DDLoader_4/%                         | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_Sybase/sybase_Collector_Incremental/% | Analysis |       |       |

############################################################Lineage Verification########################################################################


  Scenario: SC#13 update the Lineage tags to the data items
    Given user updates the tags to the data items in DD
      | firstItemType | item hierarchy                               | tableName                                                                                               | LineageFor | getTagsPayloadURL              | bodyFile1                                            | assignTagsURL            | bodyFile2                                         | jsonPath1                                                | jsonPath2                                               | jsonValue |
      | Cluster       | GECHCAE-COL1.ASG.COM,SYBASE:5000,TESTING,DBO | SYBASE_VIEWTOSINGLETABLE,SYBASE_SINGLEVIEWTOVIEW,SYBASE_VIEWTOMULTIPLETABLE,SYBASE_VIEWFROMVIEWANDTABLE | Column     | tags/Default/items/assignments | payloads/ida/CAE_Sybase_Payloads/columnsPayload.json | tags/Default/assignments | payloads/ida/CAE_Sybase_Payloads/tagsPayload.json | $..[?(@.name=='Backward Lineage Candidate')].cardinality | $..[?(@.name=='Forward Lineage Candidate')].cardinality | ALL       |

  Scenario Outline: SC#13: Configure and run the CAELineage Plugin.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                      | bodyFile                                             | path             | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAELineage/sybase_Lineage                             | payloads/ida/CAE_sybase_Payloads/sybase_Lineage.json | $.sybase_Lineage | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAELineage/sybase_Lineage                             |                                                      |                  | 200           | sybase_Lineage   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAELineage/sybase_Lineage |                                                      |                  | 200           | IDLE             | $.[?(@.configurationName=='sybase_Lineage')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/other/CAELineage/sybase_Lineage  | payloads/ida/CAE_sybase_Payloads/empty.json          | $.emptyJson      | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAELineage/sybase_Lineage |                                                      |                  | 200           | IDLE             | $.[?(@.configurationName=='sybase_Lineage')].status |


  Scenario Outline: user retrieves ids for specific item name
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>"
    Examples:
      | database      | catalog | name                        | type  | targetFile                                                      |
      | APPDBPOSTGRES | Default | SYBASE_VIEWTOSINGLETABLE    | Table | Constant.REST_DIR/response/sybase/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | SYBASE_SINGLEVIEWTOVIEW     | Table | Constant.REST_DIR/response/sybase/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | SYBASE_VIEWTOMULTIPLETABLE  | Table | Constant.REST_DIR/response/sybase/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | SYBASE_VIEWFROMVIEWANDTABLE | Table | Constant.REST_DIR/response/sybase/actualJsonFiles/tableIDs.json |


  Scenario Outline: user copy the id to payload
    Given user copy the id from "<file>" to "<payloadFile>" with "<type>" using "<jsonPath>"
    Examples:
      | file                                                            | payloadFile                                                                 | type  | jsonPath                       |
      | Constant.REST_DIR/response/sybase/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/sybase/payloads/SYBASE_VIEWTOSINGLETABLE.json    | Table | $..SYBASE_VIEWTOSINGLETABLE    |
      | Constant.REST_DIR/response/sybase/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/sybase/payloads/SYBASE_SINGLEVIEWTOVIEW.json     | Table | $..SYBASE_SINGLEVIEWTOVIEW     |
      | Constant.REST_DIR/response/sybase/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/sybase/payloads/SYBASE_VIEWTOMULTIPLETABLE.json  | Table | $..SYBASE_VIEWTOMULTIPLETABLE  |
      | Constant.REST_DIR/response/sybase/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/sybase/payloads/SYBASE_VIEWFROMVIEWANDTABLE.json | Table | $..SYBASE_VIEWFROMVIEWANDTABLE |


  Scenario Outline: user get the response of lineage edges and store the lineage values in file
    Given user hits "<request>" with "<url>" "<body>" for id from "<file>" "<type>" using "<path>" and verify "<statusCode>" and store response of "<jsonPath>" in "<targetFile>" for "<name>"
    Examples:
      | request | url                                                                               | body                                                                        | file                                                            | type | path                           | statusCode | jsonPath   | targetFile                                                                         | name                        |
      | Post    | lineages/Default?dir=OUT&what=id,type,name,catalog&excludeUnusedViewColumns=false | Constant.REST_DIR/response/sybase/payloads/SYBASE_VIEWTOSINGLETABLE.json    | Constant.REST_DIR/response/sybase/actualJsonFiles/tableIDs.json | List | $..SYBASE_VIEWTOSINGLETABLE    | 200        | $..edges.* | Constant.REST_DIR/response/sybase/actualJsonFiles/SYBASE_VIEWTOSINGLETABLE.json    | SYBASE_VIEWTOSINGLETABLE    |
      | Post    | lineages/Default?dir=OUT&what=id,type,name,catalog&excludeUnusedViewColumns=false | Constant.REST_DIR/response/sybase/payloads/SYBASE_SINGLEVIEWTOVIEW.json     | Constant.REST_DIR/response/sybase/actualJsonFiles/tableIDs.json | List | $..SYBASE_SINGLEVIEWTOVIEW     | 200        | $..edges.* | Constant.REST_DIR/response/sybase/actualJsonFiles/SYBASE_SINGLEVIEWTOVIEW.json     | SYBASE_SINGLEVIEWTOVIEW     |
      | Post    | lineages/Default?dir=OUT&what=id,type,name,catalog&excludeUnusedViewColumns=false | Constant.REST_DIR/response/sybase/payloads/SYBASE_VIEWTOMULTIPLETABLE.json  | Constant.REST_DIR/response/sybase/actualJsonFiles/tableIDs.json | List | $..SYBASE_VIEWTOMULTIPLETABLE  | 200        | $..edges.* | Constant.REST_DIR/response/sybase/actualJsonFiles/SYBASE_VIEWTOMULTIPLETABLE.json  | SYBASE_VIEWTOMULTIPLETABLE  |
      | Post    | lineages/Default?dir=OUT&what=id,type,name,catalog&excludeUnusedViewColumns=false | Constant.REST_DIR/response/sybase/payloads/SYBASE_VIEWFROMVIEWANDTABLE.json | Constant.REST_DIR/response/sybase/actualJsonFiles/tableIDs.json | List | $..SYBASE_VIEWFROMVIEWANDTABLE | 200        | $..edges.* | Constant.REST_DIR/response/sybase/actualJsonFiles/SYBASE_VIEWFROMVIEWANDTABLE.json | SYBASE_VIEWFROMVIEWANDTABLE |


  Scenario Outline: user retrieve the name of id for each value stored in lineage data file
    Given user gets the name for each id stored in "<LineageFile>" under "<TableName>" and replace the id with name
    Examples:
      | LineageFile                                                                        | TableName                   |
      | Constant.REST_DIR/response/sybase/actualJsonFiles/SYBASE_VIEWTOSINGLETABLE.json    | SYBASE_VIEWTOSINGLETABLE    |
      | Constant.REST_DIR/response/sybase/actualJsonFiles/SYBASE_SINGLEVIEWTOVIEW.json     | SYBASE_SINGLEVIEWTOVIEW     |
      | Constant.REST_DIR/response/sybase/actualJsonFiles/SYBASE_VIEWTOMULTIPLETABLE.json  | SYBASE_VIEWTOMULTIPLETABLE  |
      | Constant.REST_DIR/response/sybase/actualJsonFiles/SYBASE_VIEWFROMVIEWANDTABLE.json | SYBASE_VIEWFROMVIEWANDTABLE |


  Scenario Outline: user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                         | actualJson                                                                         |
      | Constant.REST_DIR/response/sybase/expectedJsonFiles/SYBASE_VIEWTOSINGLETABLE.json    | Constant.REST_DIR/response/sybase/actualJsonFiles/SYBASE_VIEWTOSINGLETABLE.json    |
      | Constant.REST_DIR/response/sybase/expectedJsonFiles/SYBASE_SINGLEVIEWTOVIEW.json     | Constant.REST_DIR/response/sybase/actualJsonFiles/SYBASE_SINGLEVIEWTOVIEW.json     |
      | Constant.REST_DIR/response/sybase/expectedJsonFiles/SYBASE_VIEWTOMULTIPLETABLE.json  | Constant.REST_DIR/response/sybase/actualJsonFiles/SYBASE_VIEWTOMULTIPLETABLE.json  |
      | Constant.REST_DIR/response/sybase/expectedJsonFiles/SYBASE_VIEWFROMVIEWANDTABLE.json | Constant.REST_DIR/response/sybase/actualJsonFiles/SYBASE_VIEWFROMVIEWANDTABLE.json |


  Scenario:SC#13:Delete Cluster and all the Analysis log for the delete items in Sybase
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                              | type     | query | param |
      | MultipleIDDelete | Default | other/CAELineage/sybase_Lineage/% | Analysis |       |       |

########################################Technology Restriction Verification#############################################################3

  Scenario Outline:SC14#Run the DB2 Collector, feeder and loader plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                    | bodyFile                                                              | path                        | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/Valid_zOS_DB2_Cred                                                                | payloads/ida/CAE_sybase_Payloads/Credentials/zOS_DB2_credentials.json | $.zOS_DB2_cred              | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_zOS_DB2_Cred                                                                |                                                                       |                             | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/DataSource_for_zOS_DB2/zOS_DB2_DS                                                   | payloads/ida/CAE_sybase_Payloads/sybase_DataSource.json               | $.zOS_DB2_DS                | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/DataSource_for_zOS_DB2/zOS_DB2_DS                                                   |                                                                       |                             | 200           | zOS_DB2_DS                |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Testing                                 | payloads/ida/CAE_sybase_Payloads/sybase_Collector.json                | $.zOS_DB2_Collector_Testing | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Testing                                 |                                                                       |                             | 200           | zOS_DB2_Collector_Testing |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Testing |                                                                       |                             | 200           | IDLE                      | $.[?(@.configurationName=='zOS_DB2_Collector_Testing')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/Headless-EDI/collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Testing  | payloads/ida/CAE_sybase_Payloads/empty.json                           | $.emptyJson                 | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Testing |                                                                       |                             | 200           | IDLE                      | $.[?(@.configurationName=='zOS_DB2_Collector_Testing')].status |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                                      |                                                                       |                             | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                      | payloads/ida/CAE_sybase_Payloads/sybase_Feeder_DataSource.json        | $.sybase_Feeder_DataSource  | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                                      |                                                                       |                             | 200           | sybase_Feeder_DS          |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEFeed/sybase_Feeder                                                               | payloads/ida/CAE_sybase_Payloads/sybase_Feeder.json                   | $.sybase_Feeder             | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEFeed/sybase_Feeder                                                               |                                                                       |                             | 200           | sybase_Feeder             |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                   |                                                                       |                             | 200           | IDLE                      | $.[?(@.configurationName=='sybase_Feeder')].status             |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEFeed/sybase_Feeder                                    |                                                                       |                             | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEFeed/sybase_Feeder                                   |                                                                       |                             | 200           | IDLE                      | $.[?(@.configurationName=='sybase_Feeder')].status             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                         | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json                 | $.sybase_DDLoader           | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader                                                         |                                                                       |                             | 200           | sybase_DDLoader           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                         |                                                                       |                             | 200           | IDLE                      | $.[?(@.configurationName=='sybase_DDLoader')].status           |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                          |                                                                       |                             | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader                         |                                                                       |                             | 200           | IDLE                      | $.[?(@.configurationName=='sybase_DDLoader')].status           |

  ####
  @webtest
  Scenario: Verify if the DB2 Items and Sybase Items are Loaded from the EntryPoint
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SYBASE_BA" and clicks on search
    And user performs "facet selection" in "SYBASE_BA" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName | dataBaseType | queryPath | queryPage | queryField | columnName | queryOperation | facet         | facetValue | count |
      |              |              |           |           |            |            |                | Metadata Type | Table      | 82    |
    And user enters the search text "DB2_VIEWTOSINGLETABLE" and clicks on search
    And user performs "facet selection" in "SYBASE_BA" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "DB2_VIEWTOSINGLETABLE" item from search results
    And user enters the search text "SYBASE_VIEWTOSINGLETABLE" and clicks on search
    And user performs "facet selection" in "SYBASE_BA" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "SYBASE_VIEWTOSINGLETABLE" item from search results


  Scenario Outline:SC14#Run the CAEDDLoader loader plugin with Technology Restriction
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                   | bodyFile                                              | path                                     | response code | response message                       | jsonPath                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDDLoader/sybase_DDLoader_Technology_Restriction                                 | payloads/ida/CAE_sybase_Payloads/sybase_DDLoader.json | $.sybase_DDLoader_Technology_Restriction | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDDLoader/sybase_DDLoader_Technology_Restriction                                 |                                                       |                                          | 200           | sybase_DDLoader_Technology_Restriction |                                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_Technology_Restriction |                                                       |                                          | 200           | IDLE                                   | $.[?(@.configurationName=='sybase_DDLoader_Technology_Restriction')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_Technology_Restriction  |                                                       |                                          | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/collector/CAEDDLoader/sybase_DDLoader_Technology_Restriction |                                                       |                                          | 200           | IDLE                                   | $.[?(@.configurationName=='sybase_DDLoader_Technology_Restriction')].status |


  ####
  @webtest
  Scenario: Verify only the Sybase Items are Loaded from the EntryPoint when Technology Restriction is set to TRUE
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SYBASE_BA" and clicks on search
    And user performs "facet selection" in "SYBASE_BA" attribute under "Tags" facets in Item Search results page
    And user connects to data base and get count of below fields and compare with platform analysis count
      | dataBaseName   | dataBaseType | queryPath     | queryPage     | queryField                 | columnName | queryOperation | facet         | facetValue | count      |
      | SYBASE_TESTING | STRUCTURED   | json/IDA.json | SybaseQueries | getTableCountFromTESTINGDB | name       | returnValue    | Metadata Type | Table      | fromSource |
    And user enters the search text "SYBASE_VIEWTOSINGLETABLE" and clicks on search
    And user performs "facet selection" in "SYBASE_BA" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "SYBASE_VIEWTOSINGLETABLE" item from search results
    And user enters the search text "DB2_VIEWTOSINGLETABLE" and clicks on search
    Then user "verify non presence" of following "Values" in Search Results Page
      | DB2_VIEWTOSINGLETABLE | No data found |


  Scenario:SC#14:Delete Cluster and all the Analysis log for the delete items in Sybase and zOS_DB2
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                            | type     | query | param |
      | MultipleIDDelete | Default | other/CAEFeed/sybase_Feeder/%                                   | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAEDDLoader/sybase_DDLoader%                          | Analysis |       |       |
      | MultipleIDDelete | Default | other/CAECreateEntryPoint/sybaseEP_Creator/%                    | Analysis |       |       |
      | MultipleIDDelete | Default | collector/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Testing/% | Analysis |       |       |

    ##############################Run the CAE ENTRY POint Deletor Plugin##################################################################

  Scenario Outline:SC15# Run the CAE Deletor plugin for sybase
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                 | bodyFile                                                                | path                          | response code | response message            | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/credentials/Valid_CAE_Creator_Deletor_sybase_Cred                          |                                                                         |                               | 200           |                             |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDataSource/sybaseEP_Creator_Deletor_DS                        | payloads/ida/CAE_sybase_Payloads/sybase_Creator_Deletor_DataSource.json | $.sybaseEP_Creator_Deletor_DS | 204           |                             |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDataSource/sybaseEP_Creator_Deletor_DS                        |                                                                         |                               | 200           | sybaseEP_Creator_Deletor_DS |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/CAEDeleteEntryPoint/sybaseEP_Deletor                             | payloads/ida/CAE_sybase_Payloads/sybase_Creator_Deletor.json            | $.sybaseEP_Deletor            | 204           |                             |                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/CAEDeleteEntryPoint/sybaseEP_Deletor                             |                                                                         |                               | 200           | sybaseEP_Deletor            |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEDeleteEntryPoint/sybaseEP_Deletor |                                                                         |                               | 200           | IDLE                        | $.[?(@.configurationName=='sybaseEP_Deletor')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/Headless-EDI/other/CAEDeleteEntryPoint/sybaseEP_Deletor  |                                                                         |                               | 200           |                             |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/Headless-EDI/other/CAEDeleteEntryPoint/sybaseEP_Deletor |                                                                         |                               | 200           | IDLE                        | $.[?(@.configurationName=='sybaseEP_Deletor')].status |


  ####
  Scenario:SC#15: Validate the logs of CAEDelteEntryPoint Plugin
    Given Verify Analysis log "other/CAEDeleteEntryPoint/sybaseEP_Deletor/%" info/error/warning for below parameters
      | assertion      | type | code           | logMessage                                         |
      | should contain | INFO | DBW-INF-006102 | DBW-INF-006102 (0000022032) : Entry point deleted. |
    And Analysis log "other/CAEDeleteEntryPoint/sybaseEP_Deletor/%" should display below info/error/warning
      | type | logValue                                                                                                                                                | logCode       | pluginName          | removableText |
      | INFO | ANALYSIS-0072: Plugin CAEDeleteEntryPoint Start Time:2020-09-22 20:29:09.842, End Time:2020-09-22 20:29:11.896, Processed Count:0, Errors:0, Warnings:0 | ANALYSIS-0072 | CAEDeleteEntryPoint |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:05.656)                                                                                          | ANALYSIS-0020 | CAEDeleteEntryPoint |               |
    And user delete all "Analysis" log with name "other/CAEDeleteEntryPoint/sybaseEP_Deletor%" using database


  Scenario:SC#14:Delete Cluster and BusinessApplication Tag
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                 | type                | query | param |
      | SingleItemDelete | Default | GECHCAE-COL1.ASG.COM | Cluster             |       |       |
      | SingleItemDelete | Default | MVSSYSA.ASG.COM      | Cluster             |       |       |
      | SingleItemDelete | Default | SYBASE_CREATOR_BA    | BusinessApplication |       |       |
      | SingleItemDelete | Default | SYBASE_BA            | BusinessApplication |       |       |
      | SingleItemDelete | Default | SYBASE_FEEDER_BA     | BusinessApplication |       |       |
      | SingleItemDelete | Default | SYBASE_LOADER_BA     | BusinessApplication |       |       |
      | SingleItemDelete | Default | SYBASE_LINEAGE_BA    | BusinessApplication |       |       |
      | SingleItemDelete | Default | SYBASE_DELETOR_BA    | BusinessApplication |       |       |

  @jdbc
  Scenario Outline:SC#15_Delete Plugin Configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                 | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Valid_zOS_DB2_Cred                                             |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Valid_sybase_Cred                                              |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Invalid_sybase_Cred                                            |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Valid_CAE_Creator_Deletor_sybase_Cred                          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Valid_CAE_Feeder_sybase_Cred                                   |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDataSource/sybase_Feeder_DS                                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDataSource/sybaseEP_Creator_Deletor_DS                        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/DataSource_for_Sybase/sybase_DataSource                          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/DataSource_for_Sybase/sybase_DataSource_Testing_DB               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/DataSource_for_zOS_DB2/zOS_DB2_DS                                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_zOS_DB2/zOS_DB2_Collector_Testing              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector                        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Include_Schema         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Exclude_Schema         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Process_DELETE         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Include_Exclude_Schema |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Testing_DB             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAE_Collector_for_Sybase/sybase_Collector_Incremental            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDDLoader/sybase_DDLoader                                      |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDDLoader/sybase_DDLoader_1                                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDDLoader/sybase_DDLoader_2                                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDDLoader/sybase_DDLoader_3                                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDDLoader/sybase_DDLoader_4                                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDDLoader/sybase_DDLoader_Technology_Restriction               |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAECreateEntryPoint/sybaseEP_Creator                             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEDeleteEntryPoint/sybaseEP_Deletor                             |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAEFeed/sybase_Feeder                                            |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CAELineage/sybase_Lineage                                        |      | 204           |                  |          |