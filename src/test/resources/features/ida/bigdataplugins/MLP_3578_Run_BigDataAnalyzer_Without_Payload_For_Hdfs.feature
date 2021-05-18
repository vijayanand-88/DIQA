@MLP-3578
Feature:MLP-3578: Analyze HDFS files if run without payload
  Description: Analyze HDFS files if run without payload

#####################################################################################################################################################################
##############Scenario 1
##############################################################################################################################################################
  @MLP-3578 @positve @hdfs @regression @sanity
  Scenario Outline:SC#1Creating a directory in Ambari Files View and Uploading a file into the directory
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                              | body                            | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | hdfsbda/hdfsbdadata.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/HdfsAutomationTestData1.csv | 201           |                  |

  @MLP-3578 @positve @regression @sanity
  Scenario: MLP-3578:SC1#Update the host in all dependent plugins
    Given User update the ambari host in following files using json path
      | filePath                                        | jsonPath              | node               |
      | ida/bigdataAnalyzerPayloads/ambariResolver.json | $..clusterManagerHost | clusterManagerHost |
    And user update the json file "ida/bigdataAnalyzerPayloads/ambariResolver.json" file for following values
      | jsonPath       | jsonValues |
      | $..catalogName | BigData    |

  @MLP-3578 @positve @regression @sanity
  Scenario Outline:SC#1 Configure the cluster demo node with ambari resolver configuration
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type | url                               | body                                            | response code | response message |
      | application/json | raw   | false | Put  | settings/analyzers/AmbariResolver | ida/bigdataAnalyzerPayloads/ambariResolver.json | 204           |                  |
      | application/json |       |       | Get  | settings/analyzers/AmbariResolver |                                                 | 200           | BigData          |

  @MLP-3419 @positve @hive @regression @sanity
  Scenario Outline:SC#1Run HDFSCataloger Plugin for SC1 with automatic analysis as false
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type         | url                                                                                     | body                                                                                                       | response code | response message |
      | application/json | raw   | false | Put          | settings/analyzers/HdfsCataloger                                                        | ida/bigdataAnalyzerPayloads/new_HDFS_Cataloger_BigdataAnalyzer_False_automatic_analysis_Configuration.json | 204           |                  |
      | application/json | raw   | false | Put          | settings/analyzers/HdfsMonitor                                                          | ida/bigdataAnalyzerPayloads/new_HDFS_Monitor_BigdataAnalyzer_Configuration.json                            | 204           |                  |
      | application/json | raw   | false | Put          | settings/analyzers/BigDataAnalyzer                                                      | ida/bigdataAnalyzerPayloads/new_HDFS_BigdataAnalyzer_Configuration.json                                    | 204           |                  |
      | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                                                            | 200           | /hdfsbda,include |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                                                            | 200           | IDLE             |
      | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger         |                                                                                                            | 200           |                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                                                            | 200           | IDLE             |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer |                                                                                                            | 200           | IDLE             |

  @MLP-3419 @webtest @positve @hive @regression @sanity
  Scenario: SC#1Verify whether only the Tables and columns are parsed without the metadata
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user enters the search text "hdfsbda" and clicks on search
    And user clicks on "hdfsbda" in the items listed
    Then verify the table "FILES" has item "hdfsbdadata.csv"
    And user clicks on type of item "hdfsbdadata.csv" in table "FILES"
    Then verify the table "FIELDS" does not have item "_c0"

  @MLP-3419 @positve @hive @regression @sanity
  Scenario Outline: SC#1Run DataAnalyzer Plugin
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type         | url                                                                                     | body | response code | response message |
      | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer  |      | 200           |                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer |      | 200           | IDLE             |

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario: SC#1Verify whether the Cluster,DbSystem,table and its columns are parsed in the Postgres for SC#1
    Then user validates the Cluster has service "Hdfs" has DatabaseOrDirectory "hdfsbda" has TableOrFile "hdfsbdadata.csv" has ColumnsOrFields "_c0" has below metadata
      | dataType | maxLength | minLength | notNullAmount | notNullPercentage | uniqueAmount | uniquePercentage |
      | string   | 11        | 1         | 4             | 100               | 4            | 100              |
    And user validates the Cluster has service "Hdfs" has DatabaseOrDirectory "hdfsbda" has TableOrFile "hdfsbdadata.csv" has ColumnsOrFields "_c1" has below metadata
      | dataType | maxLength | minLength | notNullAmount | notNullPercentage | uniqueAmount | uniquePercentage |
      | string   | 44        | 3         | 4             | 100               | 4            | 100              |
    And user validates the Cluster has service "Hdfs" has DatabaseOrDirectory "hdfsbda" has TableOrFile "hdfsbdadata.csv" has ColumnsOrFields "_c2" has below metadata
      | dataType | maxLength | minLength | notNullAmount | notNullPercentage | uniqueAmount | uniquePercentage |
      | string   | 43        | 4         | 4             | 100               | 4            | 100              |

  @MLP-3419 @webtest @positve @hive @regression @sanity
  Scenario: SC#1Verify whether the Tables and columns  parsed in the IDC UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user enters the search text "hdfsbda" and clicks on search
    And user clicks on "hdfsbda" in the items listed
    Then verify the table "FILES" has item "hdfsbdadata.csv"
    And user clicks on type of item "hdfsbdadata.csv" in table "FILES"
    Then verify the table "FIELDS" has item "_c0"
    And user clicks on type of item "_c0" in table "FIELDS"
    Then the below metadata should get displayed for "_c0"
      | Data type | Maximum length | Minimum length | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values |
      | string    | 11             | 1              | 4                         | 100                           | 4                       | 100                         |
    Then verify the table "FIELDS" has item "_c1"
    And user clicks on type of item "_c1" in table "FIELDS"
    Then the below metadata should get displayed for "_c1"
      | Data type | Maximum length | Minimum length | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values |
      | string    | 44             | 3              | 4                         | 100                           | 4                       | 100                         |
    Then verify the table "FIELDS" has item "_c2"
    And user clicks on type of item "_c2" in table "FIELDS"
    Then the below metadata should get displayed for "_c2"
      | Data type | Maximum length | Minimum length | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values |
      | string    | 43             | 4              | 4                         | 100                           | 4                       | 100                         |
    And user should be able logoff the IDC

#####################################################################################################################################################################
##############Scenario 2
##############################################################################################################################################################

  @MLP-3419 @sanity @positive
  Scenario Outline:SC#1Creating a new file under the directory in Ambari Files View
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type | url                                                                                                                                                     | body                            | response code | response message |
      | HdfsDataNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Put  | hdfsbda/hdfsmonitorbdadata.csv?user.name=raj_ops&op=CREATE&namenoderpcaddress=sandbox.hortonworks.com:8020&createflag=&createparent=true&overwrite=true | ida/HdfsAutomationTestData1.csv | 201           |                  |


  @MLP-3419 @positve @hive @regression @sanity
  Scenario Outline: SC#2 Setting Automatic Analysis as true for the HDfs Cataloger
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type         | url                                                                                     | body                                                                                                      | response code | response message |
      | application/json | raw   | false | Put          | settings/analyzers/HdfsCataloger                                                        | ida/bigdataAnalyzerPayloads/new_HDFS_Cataloger_BigdataAnalyzer_True_automatic_analysis_Configuration.json | 204           |                  |
      | application/json | raw   | false | Put          | settings/analyzers/HdfsMonitor                                                          | ida/bigdataAnalyzerPayloads/new_HDFS_Monitor_BigdataAnalyzer_Configuration.json                           | 204           |                  |
      | application/json | raw   | false | Put          | settings/analyzers/BigDataAnalyzer                                                      | ida/bigdataAnalyzerPayloads/new_HDFS_BigdataAnalyzer_Configuration.json                                   | 204           |                  |
      | application/json |       |       | Get          | settings/analyzers/HdfsCataloger                                                        |                                                                                                           | 200           | /hdfsbda,include |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                                                           | 200           | IDLE             |
      | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger         |                                                                                                           | 200           |                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |                                                                                                           | 200           | IDLE             |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer |                                                                                                           | 200           | IDLE             |



  Scenario Outline: SC#2 Syncing until Hdfs Cataloger and BigData Analyzer completes running
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type         | url                                                                                     | body | response code | response message |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HdfsCataloger/HdfsCataloger        |      | 200           | IDLE             |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/dataanalyzer/BigDataAnalyzer/BigDataAnalyzer |      | 200           | IDLE             |

  @MLP-1960 @positve @hdfs @regression @sanity
  Scenario: SC#2Verify whether the Cluster,DbSystem,directories and its fields are parsed in the Postgres
    And The values for the below query in Postgres should be "hdfsbda"
      | description | schemaName | tableName   | columnName | criteriaName |
      | SELECT      | BigData    | V_Directory | ID         | name         |
    When user tries to derive the relation of "Files" from "hdfsbda"
      | description | schemaName | tableName  | columnName | criteriaName         |
      | SELECT      | BigData    | E_has_File | ID         | BigData.Directory__O |
    Then user tries to validate whether "hdfsmonitorbdadata.csv" exists in "Files"
      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
      | SELECT      | BigData    | V_File    | ID,name    | ID           | ID           | name       |
    And user tries to derive the relation of "Fields" from "hdfsmonitorbdadata.csv"
      | description | schemaName | tableName   | columnName | criteriaName    |
      | SELECT      | BigData    | E_has_Field | ID         | BigData.File__O |
    And user validates the list of "_c0,_c1,_c2" available in the database in postgres
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | BigData    | V_Field   | name       | ID           |
    Then user validates the Cluster has service "Hdfs" has DatabaseOrDirectory "hdfsbda" has TableOrFile "hdfsmonitorbdadata.csv" has ColumnsOrFields "_c0" has below metadata
      | dataType | maxLength | minLength | notNullAmount | notNullPercentage | uniqueAmount | uniquePercentage |
      | string   | 11        | 1         | 4             | 100               | 4            | 100              |
    Then user validates the Cluster has service "Hdfs" has DatabaseOrDirectory "hdfsbda" has TableOrFile "hdfsmonitorbdadata.csv" has ColumnsOrFields "_c1" has below metadata
      | dataType | maxLength | minLength | notNullAmount | notNullPercentage | uniqueAmount | uniquePercentage |
      | string   | 44        | 3         | 4             | 100               | 4            | 100              |
    Then user validates the Cluster has service "Hdfs" has DatabaseOrDirectory "hdfsbda" has TableOrFile "hdfsmonitorbdadata.csv" has ColumnsOrFields "_c2" has below metadata
      | dataType | maxLength | minLength | notNullAmount | notNullPercentage | uniqueAmount | uniquePercentage |
      | string   | 43        | 4         | 4             | 100               | 4            | 100              |

  @MLP-3419 @webtest @positve @hive @regression @sanity
  Scenario: SC#1Verify whether the Tables and columns  parsed in the IDC UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user enters the search text "hdfsbda" and clicks on search
    And user clicks on "hdfsbda" in the items listed
    Then verify the table "FILES" has item "hdfsmonitorbdadata.csv"
    And user clicks on type of item "hdfsmonitorbdadata.csv" in table "FILES"
    Then verify the table "FIELDS" has item "_c0"
    And user clicks on type of item "_c0" in table "FIELDS"
    Then the below metadata should get displayed for "_c0"
      | Data type | Maximum length | Minimum length | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values |
      | string    | 11             | 1              | 4                         | 100                           | 4                       | 100                         |
    Then verify the table "FIELDS" has item "_c1"
    And user clicks on type of item "_c1" in table "FIELDS"
    Then the below metadata should get displayed for "_c1"
      | Data type | Maximum length | Minimum length | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values |
      | string    | 44             | 3              | 4                         | 100                           | 4                       | 100                         |
    Then verify the table "FIELDS" has item "_c2"
    And user clicks on type of item "_c2" in table "FIELDS"
    Then the below metadata should get displayed for "_c2"
      | Data type | Maximum length | Minimum length | Number of non null values | Percentage of non null values | Number of unique values | Percentage of unique values |
      | string    | 43             | 4              | 4                         | 100                           | 4                       | 100                         |
    And user should be able logoff the IDC


########################################################################################################################################################################
###############Deleting the created folders and databases in Ambari
###############################################################################################################################################################

  @MLP-1960
  Scenario Outline: Delete the created files in Ambari
    Given configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | ServiceName  | Authorization              | X-Requested-By | type   | url                              | body | response code | response message |
      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Delete | hdfsbda?op=DELETE&recursive=true |      | 200           | true             |

