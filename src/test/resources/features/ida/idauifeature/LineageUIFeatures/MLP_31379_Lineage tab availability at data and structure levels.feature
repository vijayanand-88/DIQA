@MLPQA-17758
Feature: Lineage tab availability for the DD Item types

############################################################################################################################################################################################
################################################################AWSGlueLineage,SqlServerDBCataloger , SQLServerDBPostProcessor and ORCS3Cataloger################################################################################################
############################################################################################################################################################################################

  @precondition @LineageTab
  Scenario: SC#1_Update credential payload json for SqlServerDB
    Given User update the below "SqlServer Credentials" in following files using json path
      | filePath                                                           | username    | password    |
      | ida/SqlServerPostprocessorPayloads_2019/SqlServer_Credentials.json | $..userName | $..password |


  @precondition @LineageTab
  Scenario Outline: SC#1_2_Add valid Credentials for SqlServerDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                        | body                                                               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/license                              | ida\hbasePayloads\DataSource\license_DS.json                      | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/SqlServer_Credentials | ida/SqlServerPostprocessorPayloads_2019/SqlServer_Credentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/SqlServer_Credentials |                                                                    | 200           |                  |          |


 ########################################## Run the SqlServerDB Cataloger and PostProcessor Plugin #########################################


  @LineageTab
  Scenario Outline: SC#1_3_Run the SqlServerDB Cataloger and PostProcessor Plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | body                                                                 | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBDataSource                                                          | ida/SqlServerPostprocessorPayloads_2019/SqlServer_DataSource.json    | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBDataSource                                                          |                                                                      | 200           | SQLServer_DataSource    |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBCataloger                                                           | ida/SqlServerPostprocessorPayloads_2019/SqlServer_Cataloger.json     | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBCataloger                                                           |                                                                      | 200           | SQLServer_Cataloger     |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SQLServer_Cataloger          |                                                                      | 200           | IDLE                    | $.[?(@.configurationName=='SQLServer_Cataloger')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/SQLServerDBCataloger/SQLServer_Cataloger           | ida/SqlServerPostprocessorPayloads_2019/empty.json                   | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/SQLServerDBCataloger/SQLServer_Cataloger          |                                                                      | 200           | IDLE                    | $.[?(@.configurationName=='SQLServer_Cataloger')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/SQLServerDBPostProcessor                                                       | ida/SqlServerPostprocessorPayloads_2019/SqlServer_Postprocessor.json | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/SQLServerDBPostProcessor                                                       |                                                                      | 200           | SQLServer_PostProcessor |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/lineage/SQLServerDBPostProcessor/SQLServer_PostProcessor |                                                                      | 200           | IDLE                    | $.[?(@.configurationName=='SQLServer_PostProcessor')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/lineage/SQLServerDBPostProcessor/SQLServer_PostProcessor  | ida/SqlServerPostprocessorPayloads_2019/empty.json                   | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/lineage/SQLServerDBPostProcessor/SQLServer_PostProcessor |                                                                      | 200           | IDLE                    | $.[?(@.configurationName=='SQLServer_PostProcessor')].status |

     ########################################## Run the AWSGlueCataloger,AWSCollector,AWSGluePythonParser and AWSGluePythonSparkLineage #########################################

  @precondition @LineageTab
  Scenario:AmazonS3_Update the aws credential Json for Amazon S3
    Given User update the below "aws credentials" in following files using json path
      | filePath                            | accessKeyPath                 | secretKeyPath                 |
      | ida/sanityPayloads/credentials.json | $..GlueCredentials..accessKey | $..GlueCredentials..secretKey |

  @LineageTab
  Scenario Outline:GlueLineage_Update Credential,Data Source,plugin configuration and run plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                       | bodyFile                                      | path                 | response code | response message | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/sanityGCCredential                                                   | payloads/ida/sanityPayloads/credentials.json  | $.GlueCredentials    | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueDataSource                                                      | payloads/ida/sanityPayloads/datasource.json   | $.AWSGCCataloger     | 204           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGlueCataloger                                                       | payloads/ida/sanityPayloads/pluginconfig.json | $.AWSGlueCatalogerGC | 204           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSCollectorDataSource                                                 | payloads/ida/sanityPayloads/datasource.json   | $.AWSCollectorDS     | 204           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSCollector                                                           | payloads/ida/sanityPayloads/pluginconfig.json | $.AWSCollector       | 204           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGluePythonParser                                                    | payloads/ida/sanityPayloads/pluginconfig.json | $.GluePythonParser   | 204           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AWSGluePythonSparkLineage                                              | payloads/ida/sanityPayloads/pluginconfig.json | $.GluePythonLineage  | 204           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/GCConfig                 |                                               |                      | 200           | IDLE             | $.[?(@.configurationName=='GCConfig')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AWSGlueCataloger/GCConfig                  |                                               |                      | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AWSGlueCataloger/GCConfig                 |                                               |                      | 200           | IDLE             | $.[?(@.configurationName=='GCConfig')].status          |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/SanityGCC                    |                                               |                      | 200           | IDLE             | $.[?(@.configurationName=='SanityGCC')].status         |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/collector/AWSCollector/SanityGCC                     |                                               |                      | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/AWSCollector/SanityGCC                    |                                               |                      | 200           | IDLE             | $.[?(@.configurationName=='SanityGCC')].status         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/AWSGluePythonParser/SanityGlueParser         |                                               |                      | 200           | IDLE             | $.[?(@.configurationName=='SanityGlueParser')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/parser/AWSGluePythonParser/SanityGlueParser          |                                               |                      | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/parser/AWSGluePythonParser/SanityGlueParser         |                                               |                      | 200           | IDLE             | $.[?(@.configurationName=='SanityGlueParser')].status  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/AWSGluePythonSparkLineage/SanityGlueLineage |                                               |                      | 200           | IDLE             | $.[?(@.configurationName=='SanityGlueLineage')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/lineage/AWSGluePythonSparkLineage/SanityGlueLineage  |                                               |                      | 200           |                  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/lineage/AWSGluePythonSparkLineage/SanityGlueLineage |                                               |                      | 200           | IDLE             | $.[?(@.configurationName=='SanityGlueLineage')].status |

         ########################################## Run the OrcS3Cataloger plugin #########################################

  @precondition @LineageTab
  Scenario Outline: Add valid Credentials for OrcS3
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                             | body                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/OrcS3_ValidJSONCredentials | ida/SnowFlakeLinkerPayloads/orcS3ValidCredentials.json | 200           |                  |          |

  @LineageTab
  Scenario Outline: Pre-Condition_Run the SnowflakeCataloger, File Cataloger (orc) and the snowflakeLinker
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                           | body                                                              | response code | response message | jsonPath                                            |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3DataSource                                            | ida/SnowFlakeLinkerPayloads/AmazonOrcS3ValidDataSourceConfig.json | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3DataSource                                            |                                                                   | 200           | OrcS3DataSource  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OrcS3Cataloger                                             | ida/SnowFlakeLinkerPayloads/sc1OrcS3Cataloger.json                | 204           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OrcS3Cataloger                                             |                                                                   | 200           | OrcS3Cataloger   |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger  | ida/SnowFlakeLinkerPayloads/empty.json                            | 200           |                  |                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OrcS3Cataloger/OrcS3Cataloger |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='OrcS3Cataloger')].status |


   @webtest @TEST_MLPQA-17654 @MLPQA-17471 @LineageTab
  Scenario:SC1 Verify the Table and Column item type has "Lineage" tab in Item View Page
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "payments" and clicks on search
    And user performs "facet selection" in "SQL Server" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "payments" item from search results
    And user "verifies displayed" on "Item view Tab" for "Lineage" in "Item View page"
    Then user performs click and verify in new window
      | Table   | value          | Action               | RetainPrevwindow | indexSwitch |
      | Columns | customernumber | click and switch tab | No               |             |
    And user "verifies displayed" on "Item view Tab" for "Lineage" in "Item View page"
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table  | value  | Action               | RetainPrevwindow | indexSwitch |
      | Tables | orders | click and switch tab | No               |             |
    And user "verifies displayed" on "Item view Tab" for "Lineage" in "Item View page"
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | ordernumber | click and switch tab | No               |             |
    And user "verifies displayed" on "Item view Tab" for "Lineage" in "Item View page"


   @webtest @TEST_MLPQA-17654 @MLPQA-17471 @LineageTab
  Scenario:SC2 Verify the View/Materialized view item type has "Lineage" tab in Item View Page
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "sqlserverviewtomultipletable" and clicks on search
    And user performs "facet selection" in "SQL Server" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "sqlserverviewtomultipletable" item from search results
    And user "verifies displayed" on "Item view Tab" for "Lineage" in "Item View page"
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table  | value                                 | Action               | RetainPrevwindow | indexSwitch |
      | Tables | sqlserverviewtomultipletableinnerjoin | click and switch tab | No               |             |
    And user "verifies displayed" on "Item view Tab" for "Lineage" in "Item View page"
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value               | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | testschema          | click and switch tab | No               |             |
      | Tables  | productmaterialview | click and switch tab | No               |             |
    And user "verifies displayed" on "Item view Tab" for "Lineage" in "Item View page"


   @webtest @TEST_MLPQA-17654 @MLPQA-17471 @LineageTab
  Scenario:SC3 Verify the Trigger item type has "Lineage" tab in Item View Page
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "trigger_product_audit" and clicks on search
    And user performs "facet selection" in "SQL Server" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Trigger" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "trigger_product_audit" item from search results
    And user "verifies displayed" on "Item view Tab" for "Lineage" in "Item View page"
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table       | value             | Action               | RetainPrevwindow | indexSwitch |
      | has_Trigger | trigger_vw_brands | click and switch tab | No               |             |
    And user "verifies displayed" on "Item view Tab" for "Lineage" in "Item View page"

##BugID=MLP-31787
   @webtest @TEST_MLPQA-17652 @MLPQA-17471 @LineageTab
  Scenario:SC4 Verify the Directory item type has "Lineage" tab in Item View Page
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORCFilesinCombinationFolder" and clicks on search
    And user performs "facet selection" in "ORC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORCFilesinCombinationFolder" item from search results
    And user "verifies displayed" on "Item view Tab" for "Lineage" in "Item View page"
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table       | value             | Action               | RetainPrevwindow | indexSwitch |
      | has_Trigger | trigger_vw_brands | click and switch tab | No               |             |
    And user "verifies displayed" on "Item view Tab" for "Lineage" in "Item View page"


   @webtest @TEST_MLPQA-17654 @MLPQA-17471 @LineageTab
  Scenario:SC5 Verify the File and File field item type has "Lineage" tab in Item View Page
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORCFilesinCombinationFolder" and clicks on search
    And user performs "facet selection" in "ORC" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Directory" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORCFilesinCombinationFolder" item from search results
    Then user performs click and verify in new window
      | Table | value           | Action               | RetainPrevwindow | indexSwitch |
      | Files | Alldatatype.orc | click and switch tab | No               |             |
    And user "verifies displayed" on "Item view Tab" for "Lineage" in "Item View page"
    Then user performs click and verify in new window
      | Table  | value   | Action               | RetainPrevwindow | indexSwitch |
      | Fields | address | click and switch tab | No               |             |
    And user "verifies displayed" on "Item view Tab" for "Lineage" in "Item View page"


   @webtest @TEST_MLPQA-17653 @MLPQA-17471 @LineageTab
  Scenario:SC6 Verify the Schema and SourceTree item type doesn't have "Lineage" tab in Item View Page
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "idatestdatabase" and clicks on search
    And user performs "facet selection" in "SQL Server" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "idatestdatabase" item from search results
    And user "verifies not displayed" on "Item view Tab" for "Lineage" in "Item View page"
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | testschema | click and switch tab | No               |             |
    And user "verifies not displayed" on "Item view Tab" for "Lineage" in "Item View page"
    And user enters the search text "AWSGlueOperationSpigotTest" and clicks on search
    And user performs "facet selection" in "Amazon Glue" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AWSGlueOperationSpigotTest" item from search results
    And user "verifies not displayed" on "Item view Tab" for "Lineage" in "Item View page"
    Then user performs click and verify in new window
      | Table      | value                      | Action               | RetainPrevwindow | indexSwitch |
      | SourceTree | AWSGlueOperationSpigotTest | click and switch tab | No               |             |
    And user "verifies not displayed" on "Item view Tab" for "Lineage" in "Item View page"


  @LineageTab
  Scenario:Post-Condition:Delete cataloger and Analyzer analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type                | query | param |
      | MultipleIDDelete | Default | cataloger/OrcS3Cataloger/%             | Analysis            |       |       |
      | SingleItemDelete | Default | amazonaws.com                          | Cluster             |       |       |
      | SingleItemDelete | Default | SnowFlakeLinker_BA                     | BusinessApplication |       |       |
      | SingleItemDelete | Default | diqbecsql1901v.did.dev.asgint.loc      | Cluster             |       |       |
      | SingleItemDelete | Default | cataloger/SQLServerDBCataloger/%       | Analysis            |       |       |
      | SingleItemDelete | Default | lineage/SQLServerDBPostProcessor/%     | Analysis            |       |       |
      | MultipleIDDelete | Default | AWSGlue                                | Service             |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster             |       |       |
      | MultipleIDDelete | Default | cataloger/AWSGlueCataloger/%           | Analysis            |       |       |
      | MultipleIDDelete | Default | parser/AWSGluePythonParser/%           | Analysis            |       |       |
      | MultipleIDDelete | Default | lineage/AWSGluePythonSparkLineage/%    | Analysis            |       |       |
      | MultipleIDDelete | Default | collector/AWSCollector/%               | Analysis            |       |       |


  @LineageTab
  Scenario Outline:Delete Config and credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                            | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AWSGlueCataloger/GCConfig                   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AWSCollector/SanityGCC                      |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AWSGluePythonParser/SanityGlueParser        |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AWSGluePythonSparkLineage/SanityGlueLineage |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AWSGlueDataSource/SanityGCDS                |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/AWSCollectorDataSource/SanityGCCDS          |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/sanityGCCredential                        |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SQLServerDBCataloger                        |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SQLServerDBPostProcessor                    |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/SQLServerDBDataSource                       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/SqlServer_Credentials                     |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OrcS3Cataloger                              |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OrcS3DataSource                             |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/OrcS3_ValidJSONCredentials                |          |      | 200           |                  |          |


