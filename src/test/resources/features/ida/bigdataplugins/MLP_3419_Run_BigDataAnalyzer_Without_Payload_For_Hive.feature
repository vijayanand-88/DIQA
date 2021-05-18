@MLP-3419
Feature:MLP-3419: Analyze Hive tables if run without payload
  Description: Analyze Hive tables if run without payload

#####################################################################################################################################################################
##############Scenario 1
##############################################################################################################################################################
  @MLP-3419 @sanity @positive
  Scenario: MLP-3419: Creating a table in hiveview
    And user executes the following Query in the Hive JDBC
      | queryEntry             |
      | CreateHiveBDADatabase2 |
      | CreateHiveBDATable2    |

  @MLP-3419 @positve @regression @sanity
  Scenario: MLP-3419:SC1#Update the host in all dependent plugins
    Given User update the ambari host in following files using json path
      | filePath                                        | jsonPath              | node               |
      | ida/bigdataAnalyzerPayloads/ambariResolver.json | $..clusterManagerHost | clusterManagerHost |
    And user update the json file "ida/bigdataAnalyzerPayloads/ambariResolver.json" file for following values
      | jsonPath       | jsonValues |
      | $..catalogName | BigData    |

  @MLP-3419 @positve @regression @sanity
  Scenario Outline:SC#1 Configure the cluster demo node with ambari resolver configuration
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type | url                               | body                                            | response code | response message |
      | application/json | raw   | false | Put  | settings/analyzers/AmbariResolver | ida/bigdataAnalyzerPayloads/ambariResolver.json | 204           |                  |
      | application/json |       |       | Get  | settings/analyzers/AmbariResolver |                                                 | 200           | BigData          |

  @MLP-3419 @positve @hive @regression @sanity
  Scenario Outline: SC#1Run HiveCataloger Plugin for SC1 with automatic analysis as false
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type         | url                                                                                     | body                                                                                                       | response code | response message |
      | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                        | ida/bigdataAnalyzerPayloads/new_Hive_Cataloger_BigdataAnalyzer_False_automatic_analysis_Configuration.json | 204           |                  |
      | application/json | raw   | false | Put          | settings/analyzers/HiveMonitor                                                          | ida/bigdataAnalyzerPayloads/new_Hive_Monitor_BigdataAnalyzer_Configuration.json                            | 204           |                  |
      | application/json | raw   | false | Put          | settings/analyzers/BigDataAnalyzer                                                      | ida/bigdataAnalyzerPayloads/new_Hive_BigdataAnalyzer_Configuration.json                                    | 204           |                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger        |                                                                                                            | 200           | IDLE             |
      | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger         |                                                                                                            | 200           |                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger        |                                                                                                            | 200           | IDLE             |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer |                                                                                                            | 200           | IDLE             |

  @MLP-3419 @webtest @positve @hive @regression @sanity
  Scenario: SC#1Verify whether only the Tables and columns are parsed without the metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user enters the search text "hivebda2" and clicks on search
    And user clicks on "hivebda2" in the items listed
    Then verify the table "TABLES" has item "sample"
    And user clicks on type of item "sample" in table "TABLES"
    Then verify the table "COLUMNS" has item "code"
    And user clicks on type of item "code" in table "COLUMNS"
    Then the below metadata should not get displayed for "code"
      | Average | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Standard deviation | Number of unique values | Variance |
      | 3.1     | 6.0000        | 2.59   | 1.0000        | 164558                    | 100                           | 0.83               | 6                       | 0.69     |

  @MLP-3419 @positve @hive @regression @sanity
  Scenario Outline: SC#1Run DataAnalyzer Plugin for SC1
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type         | url                                                                                     | body | response code | response message |
      | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer  |      | 200           |                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer |      | 200           | IDLE             |

  @MLP-3419 @positve @hive @regression @sanity
  Scenario: SC#1Verify whether the metadata getting displayed for  columns in the Postgres for SC#1
    Then user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda2" has TableOrFile "sample" has ColumnsOrFields "total_emp" has below metadata
      | average             | dataType | maxValue  | median | minValue | notNullAmount | notNullPercentage | standardDeviation   | uniqueAmount | variance            | sum       |
      | 492777.479999999981 | int      | 135185230 | 50040  | 370      | 823           | 100               | 4884297.66999999993 | 801          | 23885386064644.8906 | 405555870 |
    And user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda2" has TableOrFile "sample" has ColumnsOrFields "description" has below metadata
      | dataType | maxLength | minLength | maxValue                           | minValue                 | notNullAmount | notNullPercentage | uniquePercentage | uniqueAmount | avgLength           | minWordCount | maxWordCount | avgWordCount | mostFrequentWord |
      | string   | 105       | 6         | Zoologists and wildlife biologists | Accountants and auditors | 823           | 100               | 100              | 823          | 34.7000000000000028 | 1            | 14           | 4            | and              |
    And user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda2" has TableOrFile "sample" has ColumnsOrFields "code" has below metadata
      | dataType | maxLength | minLength | maxValue | minValue | notNullAmount | notNullPercentage | uniquePercentage | uniqueAmount | avgLength | minWordCount | maxWordCount | avgWordCount | mostFrequentWord |
      | string   | 7         | 7         | 53-7199  | 00-0000  | 823           | 100               | 100              | 823          | 7         | 1            | 1            | 1            | 13-2081          |
    And user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda2" has TableOrFile "sample" has ColumnsOrFields "salary" has below metadata
      | average             | dataType | maxValue | median | minValue | notNullAmount | notNullPercentage   | standardDeviation   | uniqueAmount | variance           | sum      |
      | 49670.1100000000006 | int      | 206770   | 41825  | 17400    | 819           | 99.5100000000000051 | 26986.1399999999994 | 762          | 729141994.49000001 | 40679820 |

  @MLP-3419 @webtest @positve @hive @regression @sanity
  Scenario: SC#1Verify whether the Tables and columns  parsed in the IDC UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user enters the search text "hivebda2" and clicks on search
    And user clicks on "hivebda2" in the items listed
    Then verify the table "TABLES" has item "sample"
    And user clicks on type of item "sample" in table "TABLES"
    Then verify the table "COLUMNS" has item "total_emp"
    And user clicks on type of item "total_emp" in table "COLUMNS"
    Then the below metadata should get displayed for "total_emp"
      | Average   | Data type | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Standard deviation | Number of unique values | Variance          | sum       |
      | 492777.48 | int       | 135185230     | 50040  | 370           | 823                       | 100                           | 4884297.67         | 801                     | 23885386064644.89 | 405555870 |
    Then verify the table "COLUMNS" has item "description"
    And user clicks on type of item "description" in table "COLUMNS"
    Then the below metadata should get displayed for "description"
      | Data type | Maximum length | Minimum length | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values | avgLength | minWordCount | maxWordCount | avgWordCount | mostFrequentWord |
      | string    | 105            | 6              | 823                       | 100                           | 823                     | 100                         | 34.7      | 1            | 14           | 4            | and              |
    Then verify the table "COLUMNS" has item "code"
    And user clicks on type of item "code" in table "COLUMNS"
    Then the below metadata should get displayed for "code"
      | Data type | Maximum length | Minimum length | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values | avgLength | minWordCount | maxWordCount | avgWordCount | mostFrequentWord |
      | string    | 7              | 7              | 823                       | 100                           | 823                     | 100                         | 7         | 1            | 1            | 1            | 13-2081          |
    Then verify the table "COLUMNS" has item "salary"
    And user clicks on type of item "salary" in table "COLUMNS"
    Then the below metadata should get displayed for "salary"
      | Average  | Data type | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Number of null values | Standard deviation | Number of unique values | Variance     | Percentage of unique values | sum      |
      | 49670.11 | int       | 206770        | 41825  | 17400         | 819                       | 99.51                         | 4                     | 26986.14           | 762                    | 729141994.49 | 92.59                       | 40679820 |
    And user should be able logoff the IDC

#####################################################################################################################################################################
##############Scenario 2
##############################################################################################################################################################
  @MLP-3419 @sanity @positive
  Scenario: MLP-3419: Creating a table in hiveview
    And user executes the following Query in the Hive JDBC
      | queryEntry             |
      | CreateHiveBDADatabase3 |

  @MLP-3419 @sanity @positive
  Scenario:  SC#2 Creating a new table
    And user executes the following Query in the Hive JDBC
      | queryEntry          |
      | CreateHiveBDATable3 |

  @MLP-3419 @positve @hive @regression @sanity
  Scenario Outline: SC#2 Setting Automatic Analysis as true for the Hive Cataloger
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type         | url                                                                                     | body                                                                                                      | response code | response message |
      | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                        | ida/bigdataAnalyzerPayloads/new_Hive_Cataloger_BigdataAnalyzer_True_automatic_analysis_Configuration.json | 204           |                  |
      | application/json | raw   | false | Put          | settings/analyzers/HiveMonitor                                                          | ida/bigdataAnalyzerPayloads/new_Hive_Monitor_BigdataAnalyzer_Configuration.json                           | 204           |                  |
      | application/json | raw   | false | Put          | settings/analyzers/BigDataAnalyzer                                                      | ida/bigdataAnalyzerPayloads/new_Hive_BigdataAnalyzer_Configuration.json                                   | 204           |                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger        |                                                                                                           | 200           | IDLE             |
      | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger         |                                                                                                           | 200           |                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger        |                                                                                                           | 200           | IDLE             |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer |                                                                                                           | 200           | IDLE             |

  Scenario Outline: SC#2 Syncing until Hive Cataloger and BigData Analyzer completes running
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type         | url                                                                                     | body | response code | response message |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger        |      | 200           | IDLE             |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer |      | 200           | IDLE             |


  @MLP-3419 @positve @hive @regression @sanity
  Scenario: SC#2Verify whether the Cluster,DbSystem,table and its columns are parsed in the Postgres for SC#2
    Then user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda3" has TableOrFile "sample2" has ColumnsOrFields "total_emp" has below metadata
      | average             | dataType | maxValue  | median | minValue | notNullAmount | notNullPercentage | standardDeviation   | uniqueAmount | variance            |
      | 492777.479999999981 | int      | 135185230 | 50040  | 370      | 823           | 100               | 4884297.66999999993 | 801          | 23885386064644.8008 |
    And user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda3" has TableOrFile "sample2" has ColumnsOrFields "description" has below metadata
      | dataType | maxLength | minLength | maxValue                           | minValue                 | notNullAmount | notNullPercentage | uniquePercentage | uniqueAmount |
      | string   | 105       | 6         | Zoologists and wildlife biologists | Accountants and auditors | 823           | 100               | 100              | 823          |
    And user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda3" has TableOrFile "sample2" has ColumnsOrFields "code" has below metadata
      | dataType | maxLength | minLength | maxValue | minValue | notNullAmount | notNullPercentage | uniquePercentage | uniqueAmount |
      | string   | 7         | 7         | 53-7199  | 00-0000  | 823           | 100               | 100              | 823          |
    And user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda3" has TableOrFile "sample2" has ColumnsOrFields "salary" has below metadata
      | average             | dataType | maxValue | median | minValue | notNullAmount | notNullPercentage   | standardDeviation   | uniqueAmount | variance           |
      | 49670.1100000000006 | int      | 206770   | 41825  | 17400    | 819           | 99.5100000000000051 | 26986.1399999999994 | 762          | 729141994.49000001 |

  @MLP-3419 @webtest @positve @hive @regression @sanity
  Scenario: SC#2 Verify whether the Tables and columns  parsed in the IDC UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user enters the search text "hivebda3" and clicks on search
    And user clicks on "hivebda3" in the items listed
    Then verify the table "TABLES" has item "sample2"
    And user clicks on type of item "sample2" in table "TABLES"
    Then verify the table "COLUMNS" has item "total_emp"
    And user clicks on type of item "total_emp" in table "COLUMNS"
    Then the below metadata should get displayed for "total_emp"
      | Average   | Data type | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Standard deviation | Number of unique values | Variance         |
      | 492777.48 | int       | 135185230     | 50040  | 370           | 823                       | 100                           | 4884297.67         | 801                     | 23885386064644.8 |
    Then verify the table "COLUMNS" has item "description"
    And user clicks on type of item "description" in table "COLUMNS"
    Then the below metadata should get displayed for "description"
      | Data type | Maximum length | Minimum length | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values |
      | string    | 105            | 6              | 823                       | 100                           | 823                     | 100                         |
    Then verify the table "COLUMNS" has item "code"
    And user clicks on type of item "code" in table "COLUMNS"
    Then the below metadata should get displayed for "code"
      | Data type | Maximum length | Minimum length | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values |
      | string    | 7              | 7              | 823                       | 100                           | 823                     | 100                         |
    Then verify the table "COLUMNS" has item "salary"
    And user clicks on type of item "salary" in table "COLUMNS"
    Then the below metadata should get displayed for "salary"
      | Average  | Data type | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Number of null values | Standard deviation | Number of unique values | Variance     | Percentage of unique values |
      | 49670.11 | int       | 206770        | 41825  | 17400         | 819                       | 99.51                         | 4                     | 26986.14           | 762                     | 729141994.49 | 92.59                       |
    And user should be able logoff the IDC

########################################################################################################################################################################
###############Deleting the created folders and databases in Ambari
###############################################################################################################################################################

  @MLP-1983 @sanity @positive
  Scenario: MLP-1983: Deleting the created database.
    Given user executes the following Query in the Hive JDBC
      | queryEntry           |
      | DropHiveBDATable2    |
      | DropHiveBDADatabase2 |
      | DropHiveBDATable3    |
      | DropHiveBDADatabase3 |
