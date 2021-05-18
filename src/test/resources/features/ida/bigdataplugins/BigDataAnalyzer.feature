@MLP-1960
Feature:MLP-1960: Rework of BigData Analyzer to IDA Plugin
  Description: Hdfs bundle(previously known as IDC Prototype CatalogHdfs project ) is a set of plugins for gathering metadata, parsing directories and monitoring events in Hdfs File system

#################################################################################################################################################################
##############Scenario 1
##############################################################################################################################################################

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline:SC#1Creating a directory in Ambari Files View and Uploading a file into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                | body                            | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | bdaautomation/bdadata.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/HdfsAutomationTestData1.csv | 201           |                  |

  @MLP-1960 @positve @regression @sanity
  Scenario: MLP-1960:SC1#Update the host in all dependent plugins
    Given User update the ambari host in following files using json path
      | filePath                                        | jsonPath              | node               |
      | ida/bigdataAnalyzerPayloads/ambariResolver.json | $..clusterManagerHost | clusterManagerHost |
    And user update the json file "ida/bigdataAnalyzerPayloads/ambariResolver.json" file for following values
      | jsonPath       | jsonValues |
      | $..catalogName | BigData    |

  @MLP-1960 @positve @regression @sanity
  Scenario Outline:SC#1 Configure the cluster demo node with ambari resolver configuration
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type | url                               | body                                            | response code | response message |
      | application/json | raw   | false | Put  | settings/analyzers/AmbariResolver | ida/bigdataAnalyzerPayloads/ambariResolver.json | 204           |                  |
      | application/json |       |       | Get  | settings/analyzers/AmbariResolver |                                                 | 200           | BigData          |

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario: SC#1Run Amabari Resolver Plugin for SC1
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
    And user update json file "ida/bigdataAnalyzerPayloads/AmbariResolver_Configuration.json" file for following values using property loader
      | jsonPath                  | jsonValues         |
      | $..['clusterManagerHost'] | sftpServerHostname |

    And supply payload with file name "ida/bigdataAnalyzerPayloads/AmbariResolver_Configuration.json"
    When user makes a REST Call for PUT request with url "settings/analyzers/AmbariResolver" with the following query param
      | raw | false |
    And Status code 204 must be returned

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC#1Run HDFSCataloger Plugin for SC1
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type         | url                                                                                     | body                                                                              | response code | response message       |
      | application/json | raw   | false | Put          | settings/analyzers/HdfsCataloger                                                        | ida/bigdataAnalyzerPayloads/new_HDFS_Cataloger_BigdataAnalyzer_Configuration.json | 204           |                        |
      | application/json | raw   | false | Put          | settings/analyzers/HdfsMonitor                                                          | ida/bigdataAnalyzerPayloads/new_HDFS_Monitor_BigdataAnalyzer_Configuration.json   | 204           |                        |
      | application/json | raw   | false | Put          | settings/analyzers/BigDataAnalyzer                                                      | ida/bigdataAnalyzerPayloads/new_HDFS_BigdataAnalyzer_Configuration.json           | 204           |                        |
      | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                                   | 200           | /bdaautomation,include |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                                   | 200           | IDLE                   |
      | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger         |                                                                                   | 200           |                        |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                                   | 200           | IDLE                   |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer |                                                                                   | 200           | IDLE                   |

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario: SC#1Verify whether the Cluster,DbSystem,table and its columns are parsed in the Postgres for SC#1
    Then user validates the Cluster has service "Hdfs" has DatabaseOrDirectory "bdaautomation" has TableOrFile "bdadata.csv" has ColumnsOrFields "_c0" has below metadata
      | dataType | maxLength | minLength | notNullAmount | notNullPercentage | uniqueAmount | uniquePercentage | avgLength | minWordCount | maxWordCount | avgWordCount |
      | string   | 11        | 1         | 4             | 100               | 4            | 100              | 4.75      | 1            | 2            | 1            |
    And user validates the Cluster has service "Hdfs" has DatabaseOrDirectory "bdaautomation" has TableOrFile "bdadata.csv" has ColumnsOrFields "_c1" has below metadata
      | dataType | maxLength | minLength | notNullAmount | notNullPercentage | uniqueAmount | uniquePercentage | avgLength | minWordCount | maxWordCount | avgWordCount |
      | string   | 44        | 3         | 4             | 100               | 4            | 100              | 13.75     | 1            | 1            | 1            |
    And user validates the Cluster has service "Hdfs" has DatabaseOrDirectory "bdaautomation" has TableOrFile "bdadata.csv" has ColumnsOrFields "_c2" has below metadata
      | dataType | maxLength | minLength | notNullAmount | notNullPercentage | uniqueAmount | uniquePercentage | avgLength | minWordCount | maxWordCount | avgWordCount |
      | string   | 43        | 4         | 4             | 100               | 4            | 100              | 15.25     | 1            | 1            | 1            |
    And user validates the Cluster has service "Hdfs" has DatabaseOrDirectory "bdaautomation" has TableOrFile "bdadata.csv" has ColumnsOrFields "_c3" has below metadata
      | average | dataType | maxValue | median | minValue | notNullAmount | notNullPercentage | standardDeviation   | uniqueAmount | variance            | sum |
      | 2.5     | integer  | 4        | 2      | 1        | 4             | 100               | 1.12000000000000011 | 4            | 1.66999999999999993 | 10  |

  @MLP-1960 @webtest @positve @hdfs @regression @sanity
  Scenario: SC#1Verify whether the Directory,Files and its Fields are parsed in the IDC UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user enters the search text "bdaautomation" and clicks on search
    And user clicks on "bdaautomation" in the items listed
    Then verify the table "FILES" has item "bdadata.csv"
    And user clicks on type of item "bdadata.csv" in table "FILES"
    Then verify the table "FIELDS" has item "_c0"
    And user clicks on type of item "_c0" in table "FIELDS"
    Then the below metadata should get displayed for "_c0"
      | Data type | Maximum length | Minimum length | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values | avgLength | minWordCount | maxWordCount | avgWordCount |
      | string    | 11             | 1              | 4                         | 100                           | 4                       | 100                         | 4.75      | 1            | 2            | 1            |
    Then verify the table "FIELDS" has item "_c1"
    And user clicks on type of item "_c1" in table "FIELDS"
    Then the below metadata should get displayed for "_c1"
      | Data type | Maximum length | Minimum length | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values | avgLength | minWordCount | maxWordCount | avgWordCount |
      | string    | 44             | 3              | 4                         | 100                           | 4                       | 100                         | 13.75     | 1            | 1            | 1            |
    Then verify the table "FIELDS" has item "_c2"
    And user clicks on type of item "_c2" in table "FIELDS"
    Then the below metadata should get displayed for "_c2"
      | Data type | Maximum length | Minimum length | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values | avgLength | minWordCount | maxWordCount | avgWordCount |
      | string    | 43             | 4              | 4                         | 100                           | 4                       | 100                         | 15.25     | 1            | 1            | 1            |
    Then verify the table "FIELDS" has item "_c3"
    And user clicks on type of item "_c3" in table "FIELDS"
    Then the below metadata should get displayed for "_c3"
      | Average | Data type | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Standard deviation | Number of unique values | Variance | Percentage of unique values | sum |
      | 2.5     | integer   | 4             | 2      | 1             | 4                         | 100                           | 1.12               | 4                       | 1.67     | 100                         | 10  |
    And user should be able logoff the IDC


#####################################################################################################################################################################
##############Scenario 2
##############################################################################################################################################################
  @MLP-1983 @sanity @positive
  Scenario: MLP-1983: Creating a table in hiveview
    And user executes the following Query in the Hive JDBC
      | queryEntry            |
      | CreateHiveBDADatabase |
      | CreateHiveBDATable1   |

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario Outline: SC#2Run HiveCataloger Plugin for SC1
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

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario: SC#2Verify whether the Cluster,DbSystem,table and its columns are parsed in the Postgres for SC#1
    Then user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda" has TableOrFile "sales_bda" has ColumnsOrFields "unit_sales" has below metadata
      | average             | dataType      | maxValue | median              | minValue | notNullAmount | notNullPercentage | standardDeviation   | uniqueAmount | variance             | sum         |
      | 3.10000000000000009 | decimal(10,4) | 6.0000   | 2.58999999999999986 | 1.0000   | 164558        | 100               | 0.82999999999999996 | 6            | 0.689999999999999947 | 509987.0000 |
    And user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda" has TableOrFile "sales_bda" has ColumnsOrFields "promotion_id" has below metadata
      | average             | dataType | maxValue | minValue | notNullAmount | notNullPercentage | standardDeviation   | uniqueAmount | variance            | uniquePercentage     | sum      |
      | 236.639999999999986 | int      | 1893     | 0        | 164558        | 100               | 459.490000000000009 | 241          | 211135.200000000012 | 0.149999999999999994 | 38941420 |
    And user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda" has TableOrFile "sales_bda" has ColumnsOrFields "store_cost" has below metadata
      | average             | dataType      | maxValue | median              | minValue | notNullAmount | notNullPercentage | standardDeviation   | uniqueAmount | variance            | uniquePercentage    | sum         |
      | 2.62999999999999989 | decimal(10,4) | 10.2900  | 2.39000000000000012 | 0.1612   | 164558        | 100               | 1.45999999999999996 | 11701        | 2.12000000000000011 | 7.11000000000000032 | 432565.7289 |
    And user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda" has TableOrFile "sales_bda" has ColumnsOrFields "customer_id" has below metadata
      | average             | dataType | maxValue | median              | minValue | notNullAmount | notNullPercentage | standardDeviation   | uniqueAmount | variance            | uniquePercentage | sum       |
      | 5105.32999999999993 | int      | 10281    | 5083.14000000000033 | 3        | 164558        | 100               | 2899.69000000000005 | 7824         | 8408274.91999999993 | 4.75             | 840123117 |
    And user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda" has TableOrFile "sales_bda" has ColumnsOrFields "time_id" has below metadata
      | average             | dataType | maxValue | median              | minValue | notNullAmount | notNullPercentage | standardDeviation   | uniqueAmount | variance            | sum       |
      | 899.889999999999986 | int      | 1065     | 900.730000000000018 | 732      | 164558        | 100               | 97.8599999999999994 | 320          | 9576.59000000000015 | 148084691 |
    And user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda" has TableOrFile "sales_bda" has ColumnsOrFields "store_id" has below metadata
      | average             | dataType | maxValue | median              | minValue | notNullAmount | notNullPercentage | standardDeviation   | uniqueAmount | variance            | uniquePercentage      | sum     |
      | 12.5800000000000001 | int      | 24       | 11.9299999999999997 | 1        | 164558        | 100               | 6.38999999999999968 | 24           | 40.8299999999999983 | 0.0100000000000000002 | 2070490 |
    And user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda" has TableOrFile "sales_bda" has ColumnsOrFields "store_sales" has below metadata
      | average             | dataType      | maxValue | median              | minValue | notNullAmount | notNullPercentage | standardDeviation   | uniqueAmount | variance            | uniquePercentage     | sum          |
      | 6.55999999999999961 | decimal(10,4) | 22.9200  | 5.95999999999999996 | 0.5000   | 164558        | 100               | 3.45999999999999996 | 1056         | 11.9499999999999993 | 0.640000000000000013 | 1079147.4700 |
    And user validates the Cluster has service "Hive" has DatabaseOrDirectory "hivebda" has TableOrFile "sales_bda" has ColumnsOrFields "product_id" has below metadata
      | average             | dataType | maxValue | median             | minValue | notNullAmount | notNullPercentage | standardDeviation   | uniqueAmount | variance | uniquePercentage     | sum       |
      | 782.809999999999945 | int      | 1559     | 784.57000000000005 | 1        | 164558        | 100               | 448.129999999999995 | 1559         | 200823   | 0.949999999999999956 | 128818372 |

  @MLP-1960 @webtest @positve @hdfs @regression @sanity
  Scenario: SC#2Verify whether the Tables and columns  parsed in the IDC UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user enters the search text "hivebda" and clicks on search
    And user clicks on "hivebda" in the items listed
    Then verify the table "TABLES" has item "sales_bda"
    And user clicks on type of item "sales_bda" in table "TABLES"
    Then verify the table "COLUMNS" has item "unit_sales"
    And user clicks on type of item "unit_sales" in table "COLUMNS"
    Then the below metadata should get displayed for "unit_sales"
      | Average | Data type     | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Standard deviation | Number of unique values | Variance | sum         |
      | 3.1     | decimal(10,4) | 6.0000        | 2.59   | 1.0000        | 164558                    | 100                           | 0.83               | 6                       | 0.69     | 509987.0000 |
    Then verify the table "COLUMNS" has item "promotion_id"
    And user clicks on type of item "promotion_id" in table "COLUMNS"
    Then the below metadata should get displayed for "promotion_id"
      | Average | Data type | Maximum value | Minimum value | Number of non null values | Percentage of non null values | Standard deviation | Number of unique values | Variance | Percentage of unique values | sum      |
      | 236.64  | int       | 1893          | 0             | 164558                    | 100                           | 459.49             | 241                     | 211135.2 | 0.15                        | 38941420 |
    Then verify the table "COLUMNS" has item "store_cost"
    And user clicks on type of item "store_cost" in table "COLUMNS"
    Then the below metadata should get displayed for "store_cost"
      | Average | Data type     | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Standard deviation | Number of unique values | Variance | Percentage of unique values | sum         |
      | 2.63    | decimal(10,4) | 10.2900       | 2.39   | 0.1612        | 164558                    | 100                           | 1.46               | 11701                   | 2.12     | 7.11                        | 432565.7289 |
    Then verify the table "COLUMNS" has item "customer_id"
    And user clicks on type of item "customer_id" in table "COLUMNS"
    Then the below metadata should get displayed for "customer_id"
      | Average | Data type | Maximum value | Median  | Minimum value | Number of non null values | Percentage of non null values | Standard deviation | Number of unique values | Variance   | Percentage of unique values | sum       |
      | 5105.33 | int       | 10281         | 5083.14 | 3             | 164558                    | 100                           | 2899.69            | 7824                    | 8408274.92 | 4.75                        | 840123117 |
    Then verify the table "COLUMNS" has item "time_id"
    And user clicks on type of item "time_id" in table "COLUMNS"
    Then the below metadata should get displayed for "time_id"
      | Average | Data type | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Standard deviation | Number of unique values | Variance | sum       |
      | 899.89  | int       | 1065          | 900.73 | 732           | 164558                    | 100                           | 97.86              | 320                     | 9576.59  | 148084691 |
    Then verify the table "COLUMNS" has item "store_id"
    And user clicks on type of item "store_id" in table "COLUMNS"
    Then the below metadata should get displayed for "store_id"
      | Average | Data type | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Standard deviation | Number of unique values | Variance | Percentage of unique values | sum     |
      | 12.58   | int       | 24            | 11.93  | 1             | 164558                    | 100                           | 6.39               | 24                      | 40.83    | 0.01                        | 2070490 |
    Then verify the table "COLUMNS" has item "store_sales"
    And user clicks on type of item "store_sales" in table "COLUMNS"
    Then the below metadata should get displayed for "store_sales"
      | Average | Data type     | Maximum value | Median | Minimum value | Number of non null values | Percentage of non null values | Standard deviation | Number of unique values | Variance | Percentage of unique values | sum          |
      | 6.56    | decimal(10,4) | 22.9200       | 5.96   | 0.5000        | 164558                    | 100                           | 3.46               | 1056                    | 11.95    | 0.64                        | 1079147.4700 |
    And user should be able logoff the IDC


########################################################################################################################################################################
###############Deleting the created folders and databases in Ambari
###############################################################################################################################################################

  @MLP-1960
  Scenario Outline: Delete the created files in Ambari
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type   | url                                    | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | bdaautomation?op=DELETE&recursive=true |      | 200           | true             |

  @MLP-1983 @sanity @positive
  Scenario: MLP-1983: Deleting the created database.
    Given user executes the following Query in the Hive JDBC
      | queryEntry          |
      | DropHiveBDATable1   |
      | DropHiveBDADatabase |
