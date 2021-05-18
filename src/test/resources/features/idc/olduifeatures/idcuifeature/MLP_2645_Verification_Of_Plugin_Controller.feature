@MLP-2645
Feature: MLP-2645 This feature is to verify the Plugin Controller in Plugin Manager

#    @webtest @MLP-2645
#      Scenario: MLP-2645 Verification of Plugin Controller
#      Given User launch browser and traverse to login page
#      And user enter credentials for "System Administrator1" role
#      And user clicks on Administration widget
#      And user clicks on Plugin Manager in Administration dashboard
#      When user clicks the eye open icon displayed under actions in plugin manager panel
#      Then verify "PLUGIN CONFIGURATION STATUS" label is displayed under Plugin controller panel
#      And click on any arrow to expand the plugins
#      And verify the Status and Actions are displayed for the plugin configurations
#      And user should be able logoff the IDC
#
#    @webtest @MLP-2645
#    Scenario: MLP-2645 Verification of Plugin Controller via edit mode of a node
#      Given User launch browser and traverse to login page
#      And user enter credentials for "System Administrator1" role
#      And user clicks on Administration widget
#      And user clicks on Plugin Manager in Administration dashboard
#      When user clicks the "Cluster Demo" node in plugin manager panel
#      And user sees panel with "CLUSTER DEMO" node name on header
#      Then user clicks on Plugin controller button
#      And click on any arrow to expand the plugins
#      And verify the Status and Actions are displayed for the plugin configurations
#      And user should be able logoff the IDC

#  @webtest @MLP-2645 @positive @regression @pluginManager
#  Scenario: MLP-2645 Verification of plugin controller icon in case of no plugins
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on Add new node Button in Plugin Management page
#    And user enters the node name "Test Node" in the name field
#    Then user select "BigData" from Catalog list
#    And user click save button in Create New Node page
#    And user verifies the node "Test Node" is displayed under NODES list
#    And user verifies Plugin Controller icon is not displayed for the node "Test Node"
#    And user clicks the "Test Node" node in plugin manager panel
#    And user clicks on Delete button in the Edit Node panel
#    And user clicks on Yes button in alert message
#    And user should be able logoff the IDC

  @webtest @MLP-2961 @positive @regression @pluginManager
  Scenario: MLP-2961 Verification of creating a node for running a plugin controller for non restricted character
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    And supply payload with file name "/idc/GitCollector_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollector" with the following query param
      | raw | false |
    And Status code 204 must be returned

  @webtest @MLP-2961 @positive @regression
  Scenario Outline: MLP-2961 Verification of running a plugin with non restricted characters
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And user "click" on "CATALOG MANAGER" dashboard
    And user creates a catalog with name "<catalogName>" and save it in Catalog manager page
    And user clicks on home button
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "GitCollector" from the available plugin list in Plugin Manager
    And user clicks on the configuration Name "GitCollector"
    And user selects "<catalogName>" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "GITCOLLECTOR CONFIGURATIONS" page
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/GitCollector |      | 200           | IDLE             |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                     | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/GitCollector |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/GitCollector |      | 200           | IDLE             |
    And user refreshes the application
    And user selects "<catalogName>" catalog from catalog list
    And user selects the "Analysis" from the Type
    And user clicks on first item on the item list page
    And user verifies the METADATA errors is displayed as "0"
#    And user clicks on the log under HAS_FILE
#    And configure a new REST API for the service "BitBucket"
#    And User calls the bitbucket repository web service to get the repo "projects/DIQA/repos/pythonanalyzerdemo/files?limit=1000"
#    And user validates the file count
#    Then Source count in log "0012" should have number of newly created files in repository

    Examples:
      | catalogName   |
      | Testing`      |
      | Testing!      |
      | Testing@      |
      | Testing^      |
      | Testing&      |
      | Testing(      |
      | Testing=      |
      | Testing$      |
      | Testing<      |
      | Testing>      |
      | Testing)      |
      | Testing+      |
      | Testing-      |
      | Testing_      |
      | Testing*      |
      | Testing.      |
      | Testing'      |
      | Testing:      |
      | Testing,      |
      | Testing;      |
      | Testing#      |
      | Testing%      |
      | Testing~      |
      | @Testing%~.#* |

  @webtest @MLP-2961 @positive @regression
  Scenario Outline: MLP-2961 Deleting the catalog created
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Administration" dashboard
    And user "click" on "CATALOG MANAGER" dashboard
    And user clicks on mentioned catalog "<catalogName>" to be deleted
    And user clicks on Delete button in the New Subject Area page

    Examples:
      | catalogName   |
      | Testing`      |
      | Testing!      |
      | Testing@      |
      | Testing^      |
      | Testing&      |
      | Testing(      |
      | Testing=      |
      | Testing$      |
      | Testing<      |
      | Testing>      |
      | Testing)      |
      | Testing+      |
      | Testing-      |
      | Testing_      |
      | Testing*      |
      | Testing.      |
      | Testing'      |
      | Testing:      |
      | Testing,      |
      | Testing;      |
      | Testing#      |
      | Testing%      |
      | Testing~      |
      | @Testing%~.#* |

  @webtest @MLP-2961 @positive @regression @pluginManager
  Scenario: MLP-2961 Configuring Git Collector for Editing a configuration and running it
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    And supply payload with file name "/idc/GitCollector_Catalog_Analysis_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollector" with the following query param
      | raw | false |
    And Status code 204 must be returned

  @webtest @MLP-2645 @positive @regression @pluginManager
  Scenario: MLP-2645 Verification of Editing a configuration and running it
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/GitCollector |      | 200           | IDLE             |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                     | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/GitCollector |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/GitCollector |      | 200           | IDLE             |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects "Analysis" catalog from catalog list
    And user selects the "Analysis" from the Type
    And user clicks on first item on the item list page
    Then user verifies the METADATA errors is displayed as "0"
    And user should be able logoff the IDC

  @webtest @MLP-2961 @positive @regression @pluginManager
  Scenario: MLP-2961 Configuring Git Collector for adding multiple configuration and running it
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    And supply payload with file name "/idc/GitCollector_Catalog_multiConfig_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollector" with the following query param
      | raw | false |
    And Status code 204 must be returned

  @webtest @MLP-2645 @positive @regression @pluginManager
  Scenario: MLP-2645 Verification of adding multiple configuration and running it
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "GitCollector" from the available plugin list in Plugin Manager
    And user add button in "GITCOLLECTOR CONFIGURATIONS" section
    And user selects "multiConfig" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue                                    |
      | NAME                  | GitCollector1                                             |
      | LABEL                 | Data Analyzer                                             |
      | REPOSITORY URL        | https://source-team.asg.com/scm/diqa/ui_plugin_config.git |
    And user enters repository username and password for "GitCollector"
    And user add button in "PLUGIN CONFIGURATION" section
    And user enters "BRANCH" as "refs/heads/master"
    And user click Apply button in "FILTERS" page
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "GITCOLLECTOR CONFIGURATIONS" page
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/GitCollector |      | 200           | IDLE             |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                     | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/GitCollector |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/GitCollector |      | 200           | IDLE             |
    And user selects "multiConfig" catalog from catalog list
    And user selects the "Analysis" from the Type
    And user clicks on first item on the item list page
    Then user verifies the METADATA errors is displayed as "0"
    And user should be able logoff the IDC

  @webtest @MLP-2961 @positive @regression @pluginManager
  Scenario: MLP-2961 Configuring Git Collector for getting plugins results in a new Widget
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    And supply payload with file name "/idc/GitCollector_Catalog_Sample_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollector" with the following query param
      | raw | false |
    And Status code 204 must be returned

  @webtest @MLP-2645 @positive @regression @pluginManager
  Scenario: MLP-2645 Verification of getting plugins results in a new Widget
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/GitCollector |      | 200           | IDLE             |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                     | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/GitCollector |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/GitCollector |      | 200           | IDLE             |
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user refreshes the application
    And user selects "Sample" catalog from catalog list
    And user selects the "Analysis" from the Type
    And user clicks on first item on the item list page
    Then user verifies the METADATA errors is displayed as "0"
    And user should be able logoff the IDC

  @webtest @MLP-2961 @positive @regression @pluginManager
  Scenario: MLP-2961 Configuring Git Collector for Running a configuration and verifying the status
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    And supply payload with file name "/idc/GitCollector_Catalog_Sample_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollector" with the following query param
      | raw | false |
    And Status code 204 must be returned

  @webtest @MLP-2645 @positive @regression @pluginManager
  Scenario: MLP-2645 Verification of Plugin Controller Running a configuration and verifying the status
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user clicks on plugin monitor icon for Node "hostName"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/GitCollector |      | 200           | IDLE             |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                     | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/GitCollector |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/GitCollector |      | 200           | IDLE             |
    And user clicks on "start" button for "GITCOLLECTOR" Plugin
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                      | body | response code | response message |
      |        |       |       | Get  | extensions/analyzers/status/hostName/collector/GitCollector/GitCollector |      | 200           | RUNNING          |
    And user should be able logoff the IDC

#  @webtest @MLP-2645 @positive @regression
#  Scenario: MLP-2645 Verification of Plugin Controller Running multiple configurations at the same time
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And User click on Subject Area Manager link on the Dashboard page
#    And user clicks on Create Button in Subject Area Management page
#    And user enters Name "Analysis" and Description of New Subject Area
#    And user clicks on save button in New Subject Area page
#    And user clicks on home button from Catalog_Management
#    And user clicks on Quickstart Dashoboard
#    And user clicks on Quickstart Dashoboard
#    And User clicks on Edit button
#    And User drag and drop a "Analysis" widget to the second page from the displayed widget list
#    And user clicks on save button on the dashboard
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on Add new node Button in Plugin Management page
#    And user enter node name as "hostName"
#    And user enable "GitCollector" plugin check box and click Assign button
#    And user navigate to "GitCollector" plugin configuration page
#    And user add button in "GIT COLLECTOR CONFIGURATIONS" section
#    And user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName | pluginConfigFieldValue                                |
#      | NAME                  | GitCollector                                          |
#      | LABEL                 | Data Analyzer                                         |
#      | CATALOG NAME          | Analysis                                              |
#      | REPOSITORY URL        | https://source-team.asg.com/scm/diqa/pythonlinker.git |
#    And user enters repository username and password for "GitCollector"
#    And user add button in "PLUGIN CONFIGURATION" section
#    And user enters "BRANCH" as "refs/heads/master"
#    And user click Apply button in "FILTERS" page
#    And user click Apply button in "PLUGIN CONFIGURATION" page
#    And user click Apply button in "GIT COLLECTOR CONFIGURATIONS" page
#    And user enable "PythonParser" plugin check box and click Assign button
#    And user navigate to "PythonParser" plugin configuration page
#    And user add button in "PYTHONPARSERCONFIGURATIONS" section
#    And user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName | pluginConfigFieldValue |
#      | NAME                  | PythonParser           |
#      | LABEL                 | PythonParser           |
#      | CATALOG NAME          | Analysis               |
#    And user enables auto start checkbox in plugin configuration panel
#    And user click Apply button in "PLUGIN CONFIGURATION" page
#    And user click Apply button in "PYTHONPARSERCONFIGURATIONS" page
#    And user enable "PythonImportLinker" plugin check box and click Assign button
#    And user navigate to "PythonImportLinker" plugin configuration page
#    And user add button in "PYTHONIMPORTLINKERCONFIGURATIONS" section
#    And user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName | pluginConfigFieldValue |
#      | NAME                  | PythonImportLinker     |
#      | LABEL                 | PythonImportLinker     |
#      | CATALOG NAME          | Analysis               |
#    And user enables auto start checkbox in plugin configuration panel
#    And user click Apply button in "PLUGIN CONFIGURATION" page
#    And user click Apply button in "PYTHONIMPORTLINKERCONFIGURATIONS" page
#    And user click save button in Create New Node page
#    And user clicks on plugin monitor icon for Node "hostName"
#    And user clicks on "start" button for "GITCOLLECTOR" Plugin
#    And user verifies the following in the Plugin monitor
#      | status | pluginName   |
#      | IDLE   | GITCOLLECTOR |
#    And user clicks on "start" button for "PYTHONPARSER" Plugin
#    And user verifies the following in the Plugin monitor
#      | status | pluginName   |
#      | IDLE   | PYTHONPARSER |
#    And user clicks on "start" button for "PYTHONIMPORTLINKER" Plugin
#    And user verifies the following in the Plugin monitor
#      | status | pluginName         |
#      | IDLE   | PYTHONIMPORTLINKER |
#    And user clicks on close button in the panel
#    And user clicks on home button from Plugin_Management
#    And user clicks on Quickstart Dashoboard
#    Then user verifies the following in the QuickStart dashboard
#      | action | widget   | plugin                                       |
#      | verify | Analysis | collector/GitCollector/GitCollector          |
#      | verify | Analysis | parser/PythonParser/PythonParser             |
#      | verify | Analysis | linker/PythonImportLinker/PythonImportLinker |
#    And user clicks on Administration widget
#    And User click on Subject Area Manager link on the Dashboard page
#    And user clicks on mentioned catalog "Analysis" to be deleted
#    And user clicks on Delete button in the New Subject Area page
#    And user clicks on home button from Catalog_Management
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on "hostName" from list of nodes
#    And user clicks on Delete button in the Edit Node panel
#    And user clicks on Yes button in alert message
#    And user should be able logoff the IDC

#  @webtest @MLP-2645 @positive @regression @pluginManager
#  Scenario Outline: MLP-2645 Creating a directory in Ambari Files View and Uploading a file into the directory for HDFS Cataloger
#    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                   | body                           | response code | response message |
#      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | idcautomation/sampledata.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | idc/HdfsAutomationTestData.csv | 201           |                  |
#
#  @webtest @MLP-2961 @positive @regression @pluginManager
#  Scenario: MLP-2961 Configuring the HDFSCataloger Plugin
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/idc/HDFSCataloger_Configuration.json"
#    When user makes a REST Call for PUT request with url "settings/analyzers/HdfsCataloger" with the following query param
#      | raw | false |
#    And Status code 204 must be returned
#
#  @webtest @MLP-2645 @positive @regression @pluginManager
#  Scenario: MLP-2645 Running the HDFSCataloger Plugin
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on plugin monitor icon for Node "Cluster Demo"
#    And user verifies the following in the Plugin monitor
#      | status | pluginName    |
#      | IDLE   | HDFSCATALOGER |
#    And user clicks on "start" button for "HDFSCATALOGER" Plugin
#    Then user verifies the following in the Plugin monitor
#      | status | pluginName    |
#      | IDLE   | HDFSCATALOGER |
#    And user clicks on close button in the panel

#  @webtest @MLP-2645 @positive @sftp @regression @pluginManager
#  Scenario: MLP-2645 verify the message.log has the entry for running of HdfsCataloger.
#    Given user connects to the SFTP server and downloads the "messages.log"
#    Then user validates the entries in "messages.log"
#      | logEntry                 |
#      | HdfsCatalogerScanMessage |
#
#  @webtest @MLP-2645 @positive @regression @pluginManager
#  Scenario: MLP-2645 Verify whether the Cluster,DbSystem,table and its columns are parsed in the Postgres for HDFS Cataloger
#    Given The values for the below query in Postgres should be "idcautomation"
#      | description | schemaName | tableName   | columnName | criteriaName |
#      | SELECT      | BigData    | V_Directory | ID         | name         |
#    When user tries to derive the relation of "Files" from "idcautomation"
#      | description | schemaName | tableName  | columnName | criteriaName         |
#      | SELECT      | BigData    | E_has_File | ID         | BigData.Directory__O |
#    Then user tries to validate whether "sampledata.csv" exists in "Files"
#      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
#      | SELECT      | BigData    | V_File    | ID,name    | ID           | ID           | name       |

#  @webtest @MLP-2645 @positive @regression @pluginManager
#  Scenario: MLP-2645 Verify whether the Directory,Files and its Fields are parsed in the UI for HDFS Cataloger
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And login must be successful for all users
#    And user enters the search text "idcautomation" and clicks on search
#    And user clicks on "idcautomation" in the items listed
#    Then verify the table "FILES" has item "sampledata.csv"
#
#  #Verification of db and IDC UI is already covered in API
#  @webtest @MLP-2645 @positive @regression @pluginManager
#  Scenario: MLP-2645 Verification of Plugin Controller Running a HdfsMonitor configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on plugin monitor icon for Node "Cluster Demo"
#    Then user verifies the following in the Plugin monitor
#      | status  | pluginName  |
#      | RUNNING | HDFSMONITOR |
#    And user clicks on close button in the panel
#
#  @webtest @MLP-2645 @positive @regression @pluginManager
#  Scenario: MLP-2645 Verify whether the HiveCataloger can be started
#    Given user executes the following Query in the Hive JDBC
#      | queryEntry                   |
#      | DropTable_CatalogerSalesFact |
#      | DropTable_CatalogerZoneWest  |
#      | DropCatalogerDatabase        |
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/json                   |
#      | Accept        | application/json                   |
#    And supply payload with file name "/idc/HiveCataloger_Configuration.json"
#    When user makes a REST Call for PUT request with url "settings/analyzers/HiveCataloger" with the following query param
#      | raw | false |
#    And Status code 204 must be returned
#    And user executes the following Query in the Hive JDBC
#      | queryEntry                   |
#      | CreateHiveCatalogerDatabase3 |
#      | CreateHiveCatalogerTable1    |
#      | CreateHiveCatalogerTable2    |
#    And supply payload with file name "/ida/empty.json"
#    And user makes a REST Call for POST request with url "extensions/analyzers/start/Cluster Demo/cataloger/HiveCataloger/HiveCataloger"
#    Then Status code 200 must be returned
#
#  @webtest @MLP-2645 @positive @regression @pluginManager
#  Scenario: MLP-2645 Verification of Plugin Controller Running a HiveCataloger configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on plugin monitor icon for Node "Cluster Demo"
#    And user verifies the following in the Plugin monitor
#      | status | pluginName    |
#      | IDLE   | HIVECATALOGER |
#    And user clicks on "start" button for "HDFSCATALOGER" Plugin
#    Then user verifies the following in the Plugin monitor
#      | status | pluginName    |
#      | IDLE   | HIVECATALOGER |
#    And user clicks on close button in the panel
#
#  @webtest @MLP-2645 @positive @regression @pluginManager
#  Scenario: MLP-2645 Verify whether the Cluster,DbSystem,table and its columns are parsed to IDC UI for Hive Cataloger
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on search icon
#    And user selects the "Cluster" from the Type
#    And user validates the cluster name"Cluster Demo" from IDC UI
#    Then user validates the existence of the Query under the following tables
#      | queryEntry          | tableEntry |
#      | HIVE                | SERVICES   |
#      | hivecatalogersample | DATABASES  |
#      | sales_fact          | TABLES     |
##    Then user validates "COLUMNS" for the "sales_fact_Columns" source
#
#  @webtest @MLP-2645 @positive @regression @pluginManager
#  Scenario: MLP-2645 Verification of Plugin Controller Running a HiveMonitor configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user click on Analysis plugin label and navigate to "HiveMonitor" from the available plugin list in Plugin Manager
#    And user add button in "HIVEMONITOR CONFIGURATIONS" section
#    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
#    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
#    And user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName        | pluginConfigFieldValue |
#      | NAME                         | Hive Monitor           |
#      | LABEL                        | Hive Monitor           |
#      | CATALOGER CONFIGURATION NAME | HiveCataloger          |
#    And user enables auto start checkbox in plugin configuration panel
#    And user enables Enable Query Parser checkbox
#    And user click Apply button in "PLUGIN CONFIGURATION" page
#    And user click Apply button in "HIVEMONITOR CONFIGURATIONS" page
#    And user clicks on home button from Plugin_Management
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on plugin monitor icon for Node "Cluster Demo"
#    And user verifies the following in the Plugin monitor
#      | status  | pluginName  |
#      | RUNNING | HIVEMONITOR |
#
#  @webtest @MLP-2645 @positive @regression @pluginManager
#  Scenario: MLP-2645 Verify whether the Cluster,DbSystem,table and its columns are parsed to IDC UI# for Hive Monitor configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on search icon
#    And user selects the "Cluster" from the Type
#    And user validates the cluster name"Cluster Demo" from IDC UI
#    Then user validates the existence of the Query under the following tables
#      | queryEntry          | tableEntry |
#      | HIVE                | SERVICES   |
#      | hivecatalogersample | DATABASES  |
#      | sales_fact          | TABLES     |
#    Then user validates "COLUMNS" for the "sales_fact_Columns" source


#  @webtest @MLP-3356 @positive @regression @pluginManager
#  Scenario: MLP-3356 Verification of Plugin monitor to show node status as Unknown
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on Add new node Button in Plugin Management page
#    And user enters the node name "Test Node" in the name field
#    Then user select "BigData" from Catalog list
#    And user click save button in Create New Node page
#    And user verifies the status "UNKNOWN" for the node "Test Node"
#    And user clicks the "Test Node" node in plugin manager panel
#    And user clicks on Delete button in the Edit Node panel
#    And user clicks on Yes button in alert message
#    And user should be able logoff the IDC

#  @webtest @MLP-3356 @positive @regression @pluginManager
#  Scenario: MLP-3356 Verification of Plugin monitor to show node status as Running
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on Add new node Button in Plugin Management page
#    And user enter node name as "hostName"
#    Then user select "BigData" from Catalog list
#    And user click save button in Create New Node page
#    And user verifies the status "RUNNING" for the node "hostName"
#    And user clicks on "hostName" from list of nodes
#    And user clicks on Delete button in the Edit Node panel
#    And user clicks on Yes button in alert message
#    And user should be able logoff the IDC

  @webtest @MLP-3356 @positive @regression @pluginManager
  Scenario: MLP-3356 Verification of Plugin monitor to show node status as Down
    Given configure a new REST API for the service "Ambari"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
      | X-Requested-By | ambari                     |
    And supply payload with file name "ida/IDANODEStopServiceComponent.json"
    When user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE/"
    Then Status code 202 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user verifies the status "Down" for the node "Cluster Demo"
    And user should be able logoff the IDC
    And configure a new REST API for the service "Ambari"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
      | X-Requested-By | ambari                     |
    And supply payload with file name "ida/IDANODEStartServiceComponent.json"
    And user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE/"
    And Status code 202 must be returned

  @webtest @MLP-2961 @positive @regression @pluginManager
  Scenario: MLP-2961 Configuring Git Collector for Running a unning python plugins
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    And supply payload with file name "/idc/GitCollector_Catalog_PyAnalysis_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/GitCollector" with the following query param
      | raw | false |
    And Status code 204 must be returned

  @webtest @MLP-2645 @positive @regression @pluginManager
  Scenario: MLP-2645 Verification of Plugin Controller running python plugins
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/GitCollector |      | 200           | IDLE             |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                     | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/collector/GitCollector/GitCollector |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/collector/GitCollector/GitCollector |      | 200           | IDLE             |

  @webtest @MLP-2645 @positive @regression @pluginManager
  Scenario Outline: MLP-2645 Verification of Plugin Controller running all python plugins
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "<pluginName>" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user selects "<catalogName>" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  | <pluginName>           |
      | LABEL                 | <label>                |
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "<pluginConfigurationName>" page
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                             | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/<endPoint> |      | 200           | IDLE             |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                            | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/<endPoint> |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                             | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/<endPoint> |      | 200           | IDLE             |
    And user refreshes the application
    And user selects "<catalogName>" catalog from catalog list
    And user checks the child checkbox "Python" in Tags
    And user selects the "Analysis" from the Type
    And user clicks on the items listed contains "<endPoint>"
    Then verify the table "<container>" has item "<SourceType>"

    Examples:
      | pluginName              | pluginConfigurationName                | label  | catalogName | endPoint                                               | container       | SourceType |
      | PythonParser            | PYTHONPARSER CONFIGURATIONS            | Parser | PyAnalysis  | parser/PythonParser/PythonParser                       | PROCESSED ITEMS | SourceTree |
      | PythonPackageLinker     | PYTHONPACKAGELINKER CONFIGURATIONS     | Linker | PyAnalysis  | linker/PythonPackageLinker/PythonPackageLinker         | PROCESSED ITEMS | File       |
      | PythonImportLinker      | PYTHONIMPORTLINKER CONFIGURATIONS      | Linker | PyAnalysis  | linker/PythonImportLinker/PythonImportLinker           | PROCESSED ITEMS | SourceTree |
      | PythonUseFunctionLinker | PYTHONUSEFUNCTIONLINKER CONFIGURATIONS | Linker | PyAnalysis  | linker/PythonUseFunctionLinker/PythonUseFunctionLinker |                 |            |

  @webtest @MLP-2645 @positive @regression @pluginManager
  Scenario Outline: MLP-2645 Verification of Plugin Controller running pthon function linker
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "<pluginName>" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user selects "<catalogName>" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  | <pluginName>           |
      | LABEL                 | <label>                |
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "<pluginConfigurationName>" page
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                             | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/<endPoint> |      | 200           | IDLE             |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                            | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/<endPoint> |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                             | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/<endPoint> |      | 200           | IDLE             |
    And user refreshes the application
    And user selects "<catalogName>" catalog from catalog list
    And user checks the child checkbox "Python" in Tags
    And user selects the "Analysis" from the Type
    And user clicks on the items listed contains "<endPoint>"

    Examples:
      | pluginName              | pluginConfigurationName                | label  | catalogName | endPoint                                               |
      | PythonUseFunctionLinker | PYTHONUSEFUNCTIONLINKER CONFIGURATIONS | Linker | PyAnalysis  | linker/PythonUseFunctionLinker/PythonUseFunctionLinker |


  @webtest @MLP-2645 @positive @regression @pluginManager
  Scenario: MLP-2645 Verification of Plugin Controller Running a MLAnalyzer configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "MLAnalyzer" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user selects "Analysis" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  | MLAnalyzer             |
      | LABEL                 | dataanalyzer           |
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "MLANALYZER CONFIGURATIONS" page
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                     | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/dataanalyzer/MLAnalyzer/MLAnalyzer |      | 200           | IDLE             |
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                    | body | response code | response message |
      |        |       |       | Post | extensions/analyzers/start/hostName/dataanalyzer/MLAnalyzer/MLAnalyzer |      | 200           |                  |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                     | body | response code | response message |
      |        |       |       | RecursiveGet | extensions/analyzers/status/hostName/dataanalyzer/MLAnalyzer/MLAnalyzer |      | 200           | IDLE             |
    And user refreshes the application
    And user selects "Analysis" catalog from catalog list
    And user selects the "Analysis" from the Type

  @webtest @MLP-2645 @positive @regression @pluginManager
  Scenario: MLP-2645 Verification of Plugin Controller running plugins and deletion of the node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    And user clicks on mentioned catalog "Analysis" to be deleted
    And user clicks on Delete button in the New Subject Area page
    And user should be able logoff the IDC

