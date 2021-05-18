@MLP-2556
Feature:  MLP-2556 Verification of adding new node with plugins

#  @webtest @MLP-2556 @positive
#  Scenario: MLP-2556_Verification of adding new node
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/analyzers" for node with hostname
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks Add New Node button in Plugin Management screen
#    And user enter node name as "hostName"
#    And user select "BigData" from Catalog list
#    Then user click save button in Create New Node page

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556_Verification of adding new node with BigDataAnalyzer plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "BigDataAnalyzer" from the available plugin list in Plugin Manager
    And user add button in "BIGDATAANALYZER CONFIGURATIONS" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  | DataAnalyzer           |
      | LABEL                 | DataAnalyzer           |
    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "BIGDATAANALYZER CONFIGURATIONS" page

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556_Verification of adding new node with CommonLineage Plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "CommonLineage" from the available plugin list in Plugin Manager
    And user add button in "COMMONLINEAGE CONFIGURATIONS" section
    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue                                                                |
      | NAME                  | CommonLineage                                                                         |
      | LABEL                 | CommonLineage                                                                         |
      | CANDIDATES QUERY      | g.V(items).out('has_Column').where(out('dataOfType').values('dataType').is('STRING')) |
    And user select lineage as "BOTH" in Lineage Direction dropdown
#    And user enables auto start checkbox in plugin configuration panel
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "COMMONLINEAGE CONFIGURATIONS" page

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556_Verification of adding new node with CommonLinker Plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "CommonLinker" from the available plugin list in Plugin Manager
    And user add button in "COMMONLINKER CONFIGURATIONS" section
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  | CommonLinker           |
      | LABEL                 | CommonLinker           |
      | EXCLUDEDCONTENTTYPES  | text/x-python          |
      | INCLUDEDCONTENTTYPES  | application/sql        |
#    And user enables auto start checkbox in plugin configuration panel
    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "COMMONLINKER CONFIGURATIONS" page

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556_Verification of adding new node with GitCollector plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "GitCollector" from the available plugin list in Plugin Manager
    And user add button in "GITCOLLECTOR CONFIGURATIONS" section
    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue                                              |
      | NAME                  | GitCollector1                                                       |
      | LABEL                 | Data Analyzer                                                       |
      | REPOSITORY URL        | https://source-team.asg.com/scm/diqa/pythonparserautomationrepo.git |
    And user enters repository username and password for "GitCollector"
    And user add button in "PLUGIN CONFIGURATION" section
    And user enters "BRANCH" as "refs/heads/master"
    And user click Apply button in "FILTERS" page
    And user clicks on Add button near to field "FILE FILTERS"
    And user enters "LABEL" text field as "Git"
    And user enters "EXPRESSION" text field as ".*\\.cpp$|.*\\.h$"
    And user selects "regex" from simple or regular expression
    And user click Apply button in "FILEFILTERS" page
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "GITCOLLECTOR CONFIGURATIONS" page

  @webtest @MLP-2556 @positive
  Scenario:  MLP-2556_Verification of adding new node with Hdfs Cataloger Plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HdfsCataloger" from the available plugin list in Plugin Manager
    And user add button in "HDFSCATALOGER CONFIGURATIONS" section
    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName       | pluginConfigFieldValue                 |
      | NAME                        | HdfsCataloger                          |
      | LABEL                       | HdfsCataloger                          |
      | MAX HITS                    | 100                                    |
      | DELTA TIME                  | 30                                     |
      | HDFS USER                   | hdfs                                   |
      | KERBEROS KEYTAB LOCATION    | /etc/security/keytabs/kataloger.keytab |
      | KERBEROS KRB5 LOCATION      | /etc/krb5.conf                         |
      | KERBEROS PRINCIPAL NAME     | hdfs@PRINCIPAL.COM                     |
      | CLUSTER MANAGER NAME        | HORTONWORKS                            |
      | CLUSTER MANAGER HOSTNAME    | http://10.33.6.165                     |
      | CLUSTER MANAGER PORT        | 8080                                   |
      | CLUSTER MANAGER API VERSION | api/v1                                 |
    And user enters repository username and password for "ClusterManager"
#    And user enables scan HDFS checkbox
    And user add button in "PLUGIN CONFIGURATION" section
    And user enter the following values in filter page
      | filterPageFieldName    | filterPageFieldValue                                   |
      | LABEL                  | Demo Filter                                            |
      | ROOT                   | /qa                                                    |
      | FILE EXTENSIONS        | csv                                                    |
      | TAGS                   | Trustworthy                                            |
      | INCLUDE/EXCLUDE REGEXP | ^(\+\d{1,3}\s)?\(?\d{1,3}\)?[\s.-]\d{3}([\s.-])?\d{4}$ |
    And user click Apply button in "FILTERS" page
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "HDFSCATALOGER CONFIGURATIONS" page

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556_Verification of adding new node with Hdfs Monitor Plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HdfsMonitor" from the available plugin list in Plugin Manager
    And user add button in "HDFSMONITOR CONFIGURATIONS" section
    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName        | pluginConfigFieldValue |
      | NAME                         | HdfsMonitor            |
      | LABEL                        | HdfsMonitor            |
      | CATALOGER CONFIGURATION NAME | HdfsMonitor            |
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "HDFSMONITOR CONFIGURATIONS" page

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556_Verification of adding new node with Hive Cataloger Plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HiveCataloger" from the available plugin list in Plugin Manager
    And user add button in "HIVECATALOGER CONFIGURATIONS" section
    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName    | pluginConfigFieldValue                 |
      | NAME                     | HiveCataloger                          |
      | LABEL                    | HiveCataloger                          |
      | DELTA TIME               | 3                                      |
      | KERBEROS KEYTAB LOCATION | /etc/security/keytabs/kataloger.keytab |
      | KERBEROS KRB5 LOCATION   | /etc/krb5.conf                         |
      | KERBEROS PRINCIPAL NAME  | hdfs@PRINCIPAL.COM                     |
    And user add button in "PLUGIN CONFIGURATION" section
    And user enter the following values in filter page
      | filterPageFieldName | filterPageFieldValue |
      | LABEL               | Demo Filter          |
      | DATABASES           | xademo               |
      | TAGS                | Trustworthy          |
    And user click Apply button in "FILTERS" page
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "HIVECATALOGER CONFIGURATIONS" page

  @webtest @MLP-2556 @positive
  Scenario:MLP-2556_Verification of adding new node with Hive Monitor Plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HiveMonitor" from the available plugin list in Plugin Manager
    And user add button in "HIVEMONITOR CONFIGURATIONS" section
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName        | pluginConfigFieldValue |
      | NAME                         | HiveMonitor            |
      | LABEL                        | HiveMonitor            |
      | CATALOGER CONFIGURATION NAME | HiveCataloger          |
    And user enables auto start checkbox in plugin configuration panel
    And user enables Enable Query Parser checkbox
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "HIVEMONITOR CONFIGURATIONS" page

  @webtest @MLP-2556 @positive
  Scenario:MLP-2556_Verification of adding new node with HiveDirectoryLinker Plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HiveDirectoryLinker" from the available plugin list in Plugin Manager
    And user add button in "HIVEDIRECTORYLINKER CONFIGURATIONS" section
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  | HiveDirectoryLinker    |
      | LABEL                 | HiveDirectoryLinker    |
    And user enables auto start checkbox in plugin configuration panel
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "HIVEDIRECTORYLINKER CONFIGURATIONS" page

  @webtest @MLP-2556 @positive
  Scenario:MLP-2556_Verification of adding new node with MLAnalyzer Plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "MLAnalyzer" from the available plugin list in Plugin Manager
    And user add button in "MLANALYZER CONFIGURATIONS" section
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  | MLAnalyzer             |
      | LABEL                 | MLAnalyzer             |
      | MAX NUMBER VALUES     | 50                     |
      | CUTOFF RATIO          | 10                     |
    And user add button in "PLUGIN CONFIGURATION" section
    And user enter the following values in filter page
      | filterPageFieldName | filterPageFieldValue |
      | LABEL               | Demo Filter          |
      | DATABASES           | xademo               |
      | TAGS                | Trustworthy          |
    And user click Apply button in "FILTERS" page
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "MLANALYZER CONFIGURATIONS" page

  @webtest @MLP-2556 @positive
  Scenario:MLP-2556_Verification of adding new node with QueryParser Plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HiveQueryParser" from the available plugin list in Plugin Manager
    And user add button in "HIVEQUERYPARSER CONFIGURATIONS" section
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName | validationMessage              | pageName             |
      | NAME                  | Name field should not be empty | PLUGIN CONFIGURATION |
    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  | HiveQueryParser        |
      | LABEL                 | HiveQueryParser        |
    And user enables auto start checkbox in plugin configuration panel
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "HIVEQUERYPARSER CONFIGURATIONS" page

#  @webtest @MLP-2556 @positive
#  Scenario: MLP-2556_Verification of adding new node with PythonParser Plugin
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on "hostName" from list of nodes
#    And user enable "PythonParser" plugin check box and click Assign button
#    And user navigate to "PythonParser" plugin configuration page
#    And user add button in "PYTHONPARSERCONFIGURATIONS" section
#    And user verifies the validation message is displayed under the Plugin configuration fields
#      | pluginConfigFieldName        | validationMessage                                        |
#      | NAME                         | Name field should not be empty                         |
#    And user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName | pluginConfigFieldValue |
#      | NAME                  | PythonParser           |
#      | LABEL                 | PythonParser           |
#      | CATALOG NAME          | BigData                |
#    And user enables auto start checkbox in plugin configuration panel
#    And user click Apply button in "PLUGIN CONFIGURATION" page
#    And user click Apply button in "PYTHONPARSERCONFIGURATIONS" page

  @webtest @MLP-2556 @positive
  Scenario:MLP-2556_Verification of adding new node with SimilarityLinker Plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "SimilarityLinker" from the available plugin list in Plugin Manager
    And user add button in "SIMILARITYLINKER CONFIGURATIONS" section
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName | validationMessage              | pageName             |
      | NAME                  | Name field should not be empty | PLUGIN CONFIGURATION |
    And user selects "BigData" catalog from the dropdown in the Plugin configuration panel in Plugin manager
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | NAME                  | SimilarityLinker       |
      | LABEL                 | SimilarityLinker       |
    And user enables auto start checkbox in plugin configuration panel
    And user add button in "PLUGIN CONFIGURATION" section
    And user select the class name "com.asg.ida.similar.link.dom.JaccardSimilarityMethod" in checks page
    And user enter the following values in checks page
      | checksPageFieldName | checksPageFieldValue |
      | PROPERTY            | name                 |
    And user click Apply button in "CHECKS" page
    And user click Apply button in "PLUGIN CONFIGURATION" page
    And user click Apply button in "SIMILARITYLINKER CONFIGURATIONS" page


  @MLP-2556 @positive
  Scenario: Validation of UI Configuration and API response for the node
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                         | body | response code | response message |
      |        | raw   | false | Get  | settings/analyzers/hostName |      | 200           |                  |
    Then Plugin Configuration from payload "idc\MLP-2556_Node_Plugin_Configuration.json" and REST API response should match

#  @MLP-2556 @webtest @positive
#  Scenario: Validation of deleting the test node
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on "hostName" from list of nodes
#    And user clicks on Delete button in the Edit Node panel
#    And user clicks Yes on the node delete alert window

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of tool tip for Hive Monitor Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HiveMonitor" from the available plugin list in Plugin Manager
    And user add button in "HIVEMONITOR CONFIGURATIONS" section
    Then user mouse hovers the help icon in plugin configuration fields
      | pluginConfigFieldName        | mouseHoverText                                                                                   |
      | CATALOGER CONFIGURATION NAME | Name of Hive Cataloger plugin configuration with which current Hive Monitor plugin works in pair |
      | ENABLE HIVE QUERY PARSER     | Indicates if HiveQueryParser feature is enabled                                                  |
    And user should be able logoff the IDC

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of tool tip for SimilarityLinker Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "SimilarityLinker" from the available plugin list in Plugin Manager
    And user add button in "SIMILARITYLINKER CONFIGURATIONS" section
    Then user mouse hovers the help icon in plugin configuration fields
      | pluginConfigFieldName | mouseHoverText                                       |
      | CHECKS                | Similarity checks                                    |
      | CUTOFF                | Minimum value for similarity result to generate link |
      | LINK NAME             | Link name to generate                                |
      | QUERY                 | Gremlin query to retrieve all items to link          |
      | SIMILAR MAX           | Maximum number of similar items to link              |
    And user clicks on Add button near to field "CHECKS"
    And user mouse hovers the help icon in plugin configuration fields
      | pluginConfigFieldName | mouseHoverText                                                    |
      | METHOD                | Similarity calculation method to use                              |
      | CLASS                 | Class name of similarity calculation method                       |
      | PROPERTY              | Property of top item to retrieve all items to link                |
      | WEIGHT                | Weight of the check (higher means more influence on final result) |
    And user should be able logoff the IDC

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of tool tip for Hive Cataloger Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HiveCataloger" from the available plugin list in Plugin Manager
    And user add button in "HIVECATALOGER CONFIGURATIONS" section
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user mouse hovers the help icon in plugin configuration fields
      | pluginConfigFieldName    | mouseHoverText                                                                                                                               |
      | NAME                     | Plugin configuration name                                                                                                                    |
      | PLUGIN VERSION           | Required plugin version                                                                                                                      |
      | CATALOG NAME             | Catalog name                                                                                                                                 |
      | EVENT CONDITION          | Condition an event must match to trigger this configuration. Expressed in Groovy                                                             |
      | EVENT CLASS              | Event Class name to trigger current plugin configuration                                                                                     |
      | AUTO START               | Option to enable/disable the automatic execution of the plugin configuration after node startup                                              |
      | KERBEROS KEYTAB LOCATION | Path to user keytab file. Keytab is a file representation of Kerberos principal. It contains pairs of Kerberos principal and encrypted keys. |
      | KERBEROS KRB5 LOCATION   | Path to  main Kerberos configuration file - krb5.conf                                                                                        |
      | KERBEROS PRINCIPAL NAME  | Name of Kerberos principal that would be used for connecting with Hive metastore                                                             |
      | DELTA TIME               | Interval for monitoring new Hive event files. Is defined in seconds.                                                                         |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of tool tip for Hdfs Monitor Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HdfsMonitor" from the available plugin list in Plugin Manager
    And user add button in "HDFSMONITOR CONFIGURATIONS" section
    Then user mouse hovers the help icon in plugin configuration fields
      | pluginConfigFieldName        | mouseHoverText                                                                                   |
      | CATALOGER CONFIGURATION NAME | Name of Hdfs Cataloger plugin configuration with which current Hive Monitor plugin works in pair |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of tool tip for Hdfs Cataloger Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HdfsCataloger" from the available plugin list in Plugin Manager
    And user add button in "HDFSCATALOGER CONFIGURATIONS" section
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user mouse hovers the help icon in plugin configuration fields
      | pluginConfigFieldName       | mouseHoverText                                                                                                                               |
      | HDFS USER                   | User for connection to HDFS (for non-kerberized cluster)                                                                                     |
      | KERBEROS KEYTAB LOCATION    | Path to user keytab file. Keytab is a file representation of Kerberos principal. It contains pairs of Kerberos principal and encrypted keys. |
      | KERBEROS KRB5 LOCATION      | Path to  main Kerberos configuration file - krb5.conf                                                                                        |
      | KERBEROS PRINCIPAL NAME     | Name of Kerberos principal that will be used for connecting to HDFS                                                                          |
      | CLUSTER MANAGER NAME        | Name of the cluster manager system: cloudera or hortonworks                                                                                  |
      | CLUSTER MANAGER HOSTNAME    | Hostname of cluster manager(Ambari or Cloudera Manager) service                                                                              |
      | CLUSTER MANAGER PORT        | Port of cluster manager(Ambari or Cloudera Manager) service                                                                                  |
      | CLUSTER MANAGER USER        | User for connecting with cluster manager                                                                                                     |
      | CLUSTER MANAGER PASSWORD    | Password for connecting with cluster manager                                                                                                 |
      | CLUSTER MANAGER API VERSION | Version of REST API for connecting with Cluster Manager, e.g. v1                                                                             |
      | SCAN HDFS                   | Switch on/off scanning of HDFS file system                                                                                                   |
      | SCAN CLUSTER SERVICES       | Switch on/off scanning of cluster services(e.g. hive, oozie, tez)                                                                            |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of tool tip for BigDataAnalyzer Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "BigDataAnalyzer" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user mouse hovers the help icon in plugin configuration fields
      | pluginConfigFieldName | mouseHoverText                                                     |
      | SAMPLE SIZE           | Number of rows that would be retrieved from Hive table or CSV file |
      | HISTOGRAM BUCKETS     | Number of buckets for representing data distribution               |
      | TOP VALUES            | Most popular values in Hive table of CSV files                     |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of tool tip for GitCollector Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "GitCollector" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user mouse hovers the help icon in plugin configuration fields
      | pluginConfigFieldName | mouseHoverText                                 |
      | REPOSITORY URL        | URL to access repository                       |
      | REPOSITORY USER       | User name with access rights to the repository |
      | REPOSITORY PASSWORD   | Repository password                            |
    And user clicks on Add button near to field "FILTERS"
    Then user mouse hovers the help icon in plugin configuration fields
      | pluginConfigFieldName | mouseHoverText            |
      | BRANCH                | Path of branch to collect |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of tool tip for MLAnalyzer Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "MLAnalyzer" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user mouse hovers the help icon in plugin configuration fields
      | pluginConfigFieldName | mouseHoverText                                 |
      | MAX NUMBER VALUES     | Maximum number of reference values for one tag |
      | CUTOFF RATIO          | Ratio of matches vs total                      |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of tool tip for Common Lineage Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "CommonLineage" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user mouse hovers the help icon in plugin configuration fields
      | pluginConfigFieldName | mouseHoverText                                                                                 |
      | CANDIDATES QUERY      | Gremlin query to retrieve lineage candidates                                                   |
      | SOURCE ELEMENTS QUERY | Gremlin query to retrieve source elements from data elements, default goes up the 'uses' link. |
      | LINEAGE DIRECTION     | Lineage direction, default is OUT                                                              |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of validation messages for Hive Monitor Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HiveMonitor" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName        | validationMessage                                      | pageName             |
      | NAME                         | Name field should not be empty                         | PLUGIN CONFIGURATION |
      | CATALOGER CONFIGURATION NAME | Cataloger configuration name field should not be empty | PLUGIN CONFIGURATION |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of validation messages for Hive Cataloger Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HiveCataloger" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName | validationMessage              | pageName             |
      | NAME                  | Name field should not be empty | PLUGIN CONFIGURATION |
#      | DELTA TIME            | Delta time should have not empty value | PLUGIN CONFIGURATION |
    And user clicks on Add button near to field "FILTERS"
    And user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName | validationMessage               | pageName |
      | LABEL                 | label field should not be empty | FILTERS  |
#      | DATABASES             | Databases should have at least one value selected |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of validation messages for Hdfs Monitor Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HdfsMonitor" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName        | validationMessage                                      | pageName             |
      | NAME                         | Name field should not be empty                         | PLUGIN CONFIGURATION |
      | CATALOGER CONFIGURATION NAME | Cataloger configuration name field should not be empty | PLUGIN CONFIGURATION |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of validation messages for Hdfs Cataloger Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HdfsCataloger" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName | validationMessage              | pageName             |
      | NAME                  | Name field should not be empty | PLUGIN CONFIGURATION |
    And user clicks on Add button near to field "FILTERS"
    And user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName | validationMessage               | pageName |
      | LABEL                 | label field should not be empty | FILTERS  |
      | ROOT                  | root field should not be empty  | FILTERS  |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of validation messages for BigDataAnalyzer Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "BigDataAnalyzer" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName | validationMessage              | pageName             |
      | NAME                  | Name field should not be empty | PLUGIN CONFIGURATION |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of validation messages for GitCollector Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "GitCollector" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName | validationMessage                        | pageName             |
      | NAME                  | Name field should not be empty           | PLUGIN CONFIGURATION |
      | REPOSITORY URL        | Repository URL field should not be empty | PLUGIN CONFIGURATION |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of validation messages for MLAnalyzer Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "MLAnalyzer" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName | validationMessage              | pageName             |
      | NAME                  | Name field should not be empty | PLUGIN CONFIGURATION |
     # | DELTA TIME            | Delta time should have not empty value | PLUGIN CONFIGURATION |
     # | MAX HITS              | Max hits should have not empty value   | PLUGIN CONFIGURATION |
    And user clicks on Add button near to field "FILTERS"
    And user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName | validationMessage               | pageName |
      | LABEL                 | label field should not be empty | FILTERS  |
#      | DATABASES             | Databases should have at least one value selected |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of validation messages for Common Lineage Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "CommonLineage" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName | validationMessage                          | pageName             |
      | NAME                  | Name field should not be empty             | PLUGIN CONFIGURATION |
      | CANDIDATES QUERY      | Candidates query field should not be empty | PLUGIN CONFIGURATION |
    And user clicks on logout button

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of validation messages for SimilarityLinker Plugin Configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "SimilarityLinker" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    And user "click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    Then user verifies the validation message is displayed under the Plugin configuration fields
      | pluginConfigFieldName | validationMessage              | pageName             |
      | NAME                  | Name field should not be empty | PLUGIN CONFIGURATION |
    And user clicks on logout button

#  @webtest @MLP-2556 @positive
#  Scenario: MLP-2556 Verification of adding a plugin without configuration
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on Add new node Button in Plugin Management page
#    And user enters the node name "Test Node" in the name field
#    Then user select "BigData" from Catalog list
#    And user select "SimilarityLinker" from Available plugin list
#    And user clicks on Assign Button
#    And user click save button in Create New Node page
#    And user sees pop up content as "Unconfigured plugins can not be saved. Do you want to proceed?"
#    And user clicks on No button in alert message
#    And user click save button in Create New Node page
#    And user sees pop up content as "Unconfigured plugins can not be saved. Do you want to proceed?"
#    And user clicks on Yes button in alert message
#    And user verifies the plugin count for node "Test Node" is displayed as "0"
#    And user clicks the "Test Node" node in plugin manager panel
#    And user clicks on Delete button in the Edit Node panel
#    And user clicks on Yes button in alert message
#    And user should be able logoff the IDC

  @webtest @MLP-2556 @positive
  Scenario: MLP-2556 Verification of adding duplicate configuration name
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
    And user click on Analysis plugin label and navigate to "HiveCataloger" from the available plugin list in Plugin Manager
    And user clicks on Add button in plugin panel
    Then user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue | pageName             |
      | NAME                  | HiveCataloger          | PLUGIN CONFIGURATION |
    And user verifies the validation message is displayed under the Plugin configuration fields for duplicate node
      | pluginConfigFieldName | validationMessage               | pageName             |
      | NAME                  | Name contains duplicated values | PLUGIN CONFIGURATION |
    And user clicks on logout button

#  @webtest @MLP-2556 @positive
#  Scenario: MLP-2556 Verification of unassign a plugin
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on Add new node Button in Plugin Management page
#    And user enters the node name "Test Node" in the name field
#    And user enable "HiveMonitor" plugin check box and click Assign button
#    And user navigate to "HiveMonitor" plugin configuration page
#    And user add button in "HIVE MONITOR CONFIGURATIONS" section
#    Then user enters the following values in Plugin Configuration fields
#      | pluginConfigFieldName        | pluginConfigFieldValue | pageName             |
#      | NAME                         | HiveMonitor            | PLUGIN CONFIGURATION |
#      | LABEL                        | HiveMonitor            | PLUGIN CONFIGURATION |
#      | CATALOG NAME                 | BigData                | PLUGIN CONFIGURATION |
#      | CATALOGER CONFIGURATION NAME | HiveMonitor            | PLUGIN CONFIGURATION |
#    And user enables auto start checkbox in plugin configuration panel
##    And user enables Enable Query Parser checkbox
#    And user click Apply button in "PLUGIN CONFIGURATION" page
#    And user click Apply button in "HIVE MONITOR CONFIGURATIONS" page
#    And user click save button in Create New Node page
#    And user clicks on "Test Node" from nodes list
#    And user clicks on "HiveMonitor" under Assigned plugins
#    And user clicks on Unassign Plugin Button
#    And user sees pop up content as "Are you sure you want to delete?"
#    And user clicks on No button in alert message
#    And user verifies configuration panel is "Displayed"
#    And user clicks on Unassign Plugin Button
#    And user clicks on Yes button in alert message
#    And user verifies configuration panel is "Not Displayed"
#    And user verifies that unassigned plugin "HiveMonitor" is not displayed in the Assigned plugins section
#    And user click save button in Create New Node page
#    And user clicks on "Test Node" from nodes list
#    And user verifies the plugin "HiveMonitor" is displayed under Available plugin list
#    And user click save button in Create New Node page
#    And user verifies new node panel is "Not Displayed"
#    And user clicks on "Test Node" from nodes list
#    And user clicks on Delete button in the Edit Node panel
#    And user clicks on Yes button in alert message