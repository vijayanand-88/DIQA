@MLP-2284
Feature:2284: Rework of BigData Analyzer to IDA Plugin

  @MLP-1983 @sanity @positive
  Scenario: MLP-1983: Creating a table in hiveview
    Given user executes the following Query in the Hive JDBC
      | queryEntry            |
      | CreateHiveBDADatabase |
      | CreateHiveBDATable1   |

  @MLP-2284 @webtest @sanity @regression @sftp
  Scenario Outline:Verification of the BigData Analyzer functionality for a newly created table
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type         | url                                                                                     | body                                                                              | response code | response message |
      | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                        | ida/bigdataAnalyzerPayloads/new_Hive_Cataloger_BigdataAnalyzer_Configuration.json | 204           |                  |
      | application/json | raw   | false | Put          | settings/analyzers/HiveMonitor                                                          | ida/bigdataAnalyzerPayloads/new_Hive_Monitor_BigdataAnalyzer_Configuration.json   | 204           |                  |
      | application/json | raw   | false | Put          | settings/analyzers/BigDataAnalyzer                                                      | ida/bigdataAnalyzerPayloads/new_Hive_BigdataAnalyzer_Configuration.json           | 204           |                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger        |                                                                                   | 200           | IDLE             |
      | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger         |                                                                                   | 200           |                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger        |                                                                                   | 200           | IDLE             |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer |                                                                                   | 200           | IDLE             |

  @MLP-2284 @webtest @positve @hdfs @regression @sanity
  Scenario: MLP-1983: Verify whether the Tables and columns  parsed in the IDC UI
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user enters the search text "hivebda" and clicks on search
    And user selects the "Table" from the Type
#    And user waits for the delta time to be completed for the monitor to trigger Cataloger
#    And user connects to the SFTP server and downloads the "/catalogHive.log"
#    Then user validates the entries in "catalogHive.log"
#      | logEntry                |
#      | HiveCatalogerBDAnalyzer |
    Then following item(s) should get displayed in item search results in Subject area page
      | itemName  |
      | sales_bda |
    And user executes the following Query in the Hive JDBC
      | queryEntry    |
      | DropBDATable1 |

  @MLP-2284 @webtest @sanity @regression @sftp
  Scenario Outline:Verification of the BigData Analyzer functionality for an existing table
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
  Examples:
  | Header           | Query | Param | type         | url                                                                                     | body                                                                              | response code | response message |
  | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger        |                                                                                   | 200           | IDLE             |
  | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger         |                                                                                   | 200           |                  |
  | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger        |                                                                                   | 200           | IDLE             |
  | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer |                                                                                   | 200           | IDLE             |

  @MLP-2284 @webtest @positve @hdfs @regression @sanity
  Scenario: MLP-1983: Verify whether the Tables and columns  parsed in the IDC UI for default database
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user enters the search text "sample_07" and clicks on search
    And user clicks the show all button for the "Type" facet
    And user checks the checkbox for "Table" in Type
    And user checks the checkbox for "default [Database]" in Type
    Then following item(s) should get displayed in item search results in Subject area page
      | itemName  |
      | sample_07 |