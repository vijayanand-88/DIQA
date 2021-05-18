@MLAnalyzer
Feature:MLAnalyzer: Rework of ML Analyzer to IDA Plugin

#################################################################################################################################################################
##############Scenario 1
##############################################################################################################################################################

  @sanity @positive
  Scenario:MLP-1667:sc1- To verify catalog is created with supplied payload
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "ida/mlAnalyzerPayloads/CreateMLAnalyzerCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And verify created schema "MLANALYZER CATALOG" exists in database


  @MLAnalyzer @sanity @positive
  Scenario: MLP-1983:sc2-Creating database and souce table1 in hiveview for ML Analyzer Validation
    And user executes the following Query in the Hive JDBC
      | queryEntry              |
      | CreateMLADatabase       |
      | CreateMLATable1         |
      | InsertRow1IntoMLATable1 |
      | InsertRow2IntoMLATable1 |
      | InsertRow3IntoMLATable1 |
      | InsertRow4IntoMLATable1 |


  @MLAnalyzer @positve @hdfs @regression @sanity
  Scenario:SC3-Run HiveCataloger Plugin for database and table created
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                              | body                                        | response code | response message   | jsonPath                                           |
      | application/json | raw   | false | Put          | settings/analyzers/BigDataAnalyzer                                               | ida/mlAnalyzerPayloads/BigDataAnalyzer.json | 204           |                    |                                                    |
      |                  |       |       | Get          | settings/analyzers/BigDataAnalyzer                                               |                                             | 200           | MLANALYZER CATALOG |                                                    |
      |                  |       |       | Put          | settings/analyzers/HiveCataloger                                                 | ida/mlAnalyzerPayloads/HiveCataloger.json   | 204           |                    |                                                    |
      |                  |       |       | Get          | settings/analyzers/HiveCataloger                                                 |                                             | 200           | MLANALYZER CATALOG |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                             | 200           | IDLE               | $.[?(@.configurationName=='HiveCataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  | ida/mlAnalyzerPayloads/emptyjson.json       | 200           |                    |                                                    |


  @MLAnalyzer @positve @hdfs @regression @sanity
  Scenario: SC4-Get the status of Hive and Big data plugin
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                           |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                       | body | response code | response message | jsonPath                                           |
      |        |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/* |      | 200           | IDLE             | $.[?(@.configurationName=='Data Analyzer')].status |

  @MLAnalyzer @positve @hdfs @regression @sanity
  Scenario: SC5-Verify whether the tags are assigned to the columns of first table in postgres
    Then user validates the Column "colour" of table "testmlatable1" has following tags "Big Data,Hadoop Files,Hive,colour,shade" in postgres
    And user validates the Column "shade" of table "testmlatable1" has following tags "Big Data,Hadoop Files,Hive,colour,shade" in postgres

  @MLAnalyzer @webtest @positve @hdfs @regression @sanity
  Scenario: SC6-Verify whether the Tables and columns  parsed in the IDC UI with the assigned tags
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user enters the search text "testmladatabase" and clicks on search
    And user clicks on "testmladatabase" in the items listed
    Then verify the table "TABLES" has item "testmlatable1"
    And user clicks on type of item "testmlatable1" in table "TABLES"
    Then verify the table "COLUMNS" has item "colour"
    And user clicks on type of item "colour" in table "COLUMNS"
    Then the following tags "Colour,Hadoop Files,Hive,Shade,Big Data" should get displayed for the column "colour"
    And user should be able logoff the IDC

  @MLAnalyzer @positve @hdfs @regression @sanity
  Scenario Outline: SC7-Changing the ML Analyzer configuration by removing the tags
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type | url                                | body                                        | response code | response message   |
      | application/json | raw   | false | Put  | settings/analyzers/BigDataAnalyzer | ida/mlAnalyzerPayloads/BigDataAnalyzer.json | 204           |                    |
      | application/json |       |       | Get  | settings/analyzers/BigDataAnalyzer |                                             | 200           | MLANALYZER CATALOG |
      | application/json | raw   | false | Put  | settings/analyzers/HiveCataloger   | ida/mlAnalyzerPayloads/HiveCataloger2.json  | 204           |                    |
      | application/json |       |       | Get  | settings/analyzers/HiveCataloger   |                                             | 200           | MLANALYZER CATALOG |
      | application/json | raw   | false | Put  | settings/analyzers/MLAnalyzer      | ida/mlAnalyzerPayloads/MLAnalyzer.json      | 204           |                    |
      | application/json |       |       | Get  | settings/analyzers/MLAnalyzer      |                                             | 200           | MLANALYZER CATALOG |

  @MLAnalyzer @sanity @positive
  Scenario: MLP-1983: SC8-Creating all the reamining tables in hiveview for ML Analyzer Validation
    And user executes the following Query in the Hive JDBC
      | queryEntry                     |
      | CreateMLATable2SameAsMLATable1 |
      | CreateMLATable3                |
      | InsertRow1IntoMLATable3        |
      | InsertRow2IntoMLATable3        |
      | InsertRow3IntoMLATable3        |
      | InsertRow4IntoMLATable3        |
      | CreateMLATable4                |
      | InsertRow1IntoMLATable4        |
      | InsertRow2IntoMLATable4        |
      | InsertRow3IntoMLATable4        |
      | InsertRow4IntoMLATable4        |
      | CreateMLATable5                |
      | InsertRow1IntoMLATable5        |
      | InsertRow2IntoMLATable5        |
      | InsertRow3IntoMLATable5        |
      | InsertRow4IntoMLATable5        |

  @MLAnalyzer @sanity @positive
  Scenario: MLP-1983: SC8#2-Check the status of the plugins
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                              | body | response code | response message | jsonPath                                           |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |      | 200           | IDLE             | $.[?(@.configurationName=='HiveCataloger')].status |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/*        |      | 200           | IDLE             | $.[?(@.configurationName=='Data Analyzer')].status |

  Scenario: SC9 - Start the Hive cataloger
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                              | body | response code | response message |
      | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/*              |      | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |      | 200           | IDLE             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/*        |      | 200           | IDLE             |


  @MLAnalyzer @positve @hdfs @regression @sanity
  Scenario: SC10-Verify whether the tags are not assigned to the second table columns in postgres
    Then user validates the Column "colour" of table "testmlatable2" has following tags "Hadoop Files,Hive,Big Data" in postgres
    And user validates the Column "shade" of table "testmlatable2" has following tags "Hadoop Files,Hive,Big Data" in postgres
    Then user validates the Column "colour3" of table "testmlatable3" has following tags "Hadoop Files,Hive,Big Data" in postgres
    And user validates the Column "shade3" of table "testmlatable3" has following tags "Hadoop Files,Hive,Big Data" in postgres
    Then user validates the Column "colour4" of table "testmlatable4" has following tags "Hadoop Files,Hive,Big Data" in postgres
    And user validates the Column "shade4" of table "testmlatable4" has following tags "Hadoop Files,Hive,Big Data" in postgres
    Then user validates the Column "colour5" of table "testmlatable5" has following tags "Hadoop Files,Hive,Big Data" in postgres
    And user validates the Column "shade5" of table "testmlatable5" has following tags "Hadoop Files,Hive,Big Data" in postgres

  @webtest @MLAnalyzer @positve @hdfs @regression @sanity
  Scenario: SC11-Run the ML Analyzer plugin from UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user clicks on Administration widget
    And user clicks on Plugin Manager in Administration dashboard
#    And user clicks on "Cluster Demo" from nodes list
    And user clicks on plugin monitor icon for Node "Cluster Demo"
    And user verifies the following in the Plugin monitor
      | status | pluginName  |
      | IDLE   | ML ANALYZER |
    And user clicks on "start" button for "ML ANALYZER" Plugin

  @MLAnalyzer @positve @hdfs @regression @sanity
  Scenario: SC12-verify whether ML Analyzer plugin is finished runnning
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                  | body | response code | response message | jsonPath                                         |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/MLAnalyzer/* |      | 200           | IDLE             | $.[?(@.configurationName=='ML Analyzer')].status |



  @MLAnalyzer @positve @hdfs @regression @sanity
  Scenario: SC13-Verify whether the tags are assigned to the columns of second table in postgres
    Then user validates the Column "colour" of table "testmlatable2" has following tags "colour,Hadoop Files,Hive,shade,Big Data" in postgres
    And user validates the Column "shade" of table "testmlatable2" has following tags "colour,Hadoop Files,Hive,shade,Big Data" in postgres
    Then user validates the Column "colour3" of table "testmlatable3" has following tags "colour,Hadoop Files,Hive,shade,Big Data" in postgres
    And user validates the Column "shade3" of table "testmlatable3" has following tags "colour,Hadoop Files,Hive,shade,Big Data" in postgres
    Then user validates the Column "colour4" of table "testmlatable4" has following tags "Hadoop Files,Hive,Big Data" in postgres
    And user validates the Column "shade4" of table "testmlatable4" has following tags "Hadoop Files,Hive,Big Data" in postgres
    Then user validates the Column "colour5" of table "testmlatable5" has following tags "Hadoop Files,Hive,Big Data" in postgres
    And user validates the Column "shade5" of table "testmlatable5" has following tags "Hadoop Files,Hive,Big Data" in postgres


  @MLAnalyzer @webtest @positve @hdfs @regression @sanity
  Scenario: SC14-Verify whether the second and third Table and its columns parsed in the IDC UI with the assigned tags
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user select "MLANALYZER CATALOG" from Catalog list
  #  And user enters the search text "MLANALYZER CATALOG" and clicks on search
    And user performs "facet selection" in "testmlatable2 [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "item click" on "shade" item from search results
    Then the following tags "Colour,Hadoop Files,Hive,Shade,Big Data" should get displayed for the column "shade"
    Then user clicks on close button in the item full view page
    And user performs "item click" on "colour" item from search results
    Then the following tags "Colour,Hadoop Files,Hive,Shade,Big Data" should get displayed for the column "colour"
    Then user clicks on close button in the item full view page
    And user performs "facet selection" in "testmlatable3 [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "item click" on "shade3" item from search results
    Then the following tags "Colour,Hadoop Files,Hive,Shade,Big Data" should get displayed for the column "shade3"
    Then user clicks on close button in the item full view page
    And user performs "item click" on "colour3" item from search results
    Then the following tags "Colour,Hadoop Files,Hive,Shade,Big Data" should get displayed for the column "colour3"

  @MLAnalyzer @webtest @positve @hdfs @regression @sanity
  Scenario: SC15-Verify whether the forth and fifth Table and its columns parsed in the IDC UI with the assigned tags
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user select "MLANALYZER CATALOG" from Catalog list
#    And user enters the search text "MLANALYZER CATALOG" and clicks on search
    And user performs "facet selection" in "testmlatable4 [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "item click" on "shade4" item from search results
    Then the following tags "Hadoop Files,Hive,Big Data" should get displayed for the column "shade4"
    Then user clicks on close button in the item full view page
    And user performs "item click" on "colour4" item from search results
    Then the following tags "Hadoop Files,Hive,Big Data" should get displayed for the column "colour4"
    Then user clicks on close button in the item full view page
    And user performs "facet selection" in "testmlatable5 [Table]" attribute under "Parent hierarchy" facets in Item Search results page
    And user performs "item click" on "shade5" item from search results
    Then the following tags "Hadoop Files,Hive,Big Data" should get displayed for the column "shade5"
    Then user clicks on close button in the item full view page
    And user performs "item click" on "colour5" item from search results
    Then the following tags "Hadoop Files,Hive,Big Data" should get displayed for the column "colour5"


###########################################################################################################################################################################
##################Dropping the databases and tables created for scenario 1
##################################################################################################################################################################

  @MLAnalyzer @sanity @positive
  Scenario: MLP-1983:SC16-Deleting the created database.
    Given user executes the following Query in the Hive JDBC
      | queryEntry      |
      | DropMLATable5   |
      | DropMLATable4   |
      | DropMLATable3   |
      | DropMLATable2   |
      | DropMLATable1   |
      | DropMLADatabase |
#
  @negative
  Scenario:MLP-1667: To verify created area name is deleted
    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "/settings/catalogs/MLANALYZER%20CATALOG"
    Then Status code 204 must be returned
    When user makes a REST Call for Get request with url "/settings/catalogs/MLANALYZER%20CATALOG"
    And response message contains value "CONFIG-0007"
    And verify created schema "MLANALYZER CATALOG" doesn't exists in database