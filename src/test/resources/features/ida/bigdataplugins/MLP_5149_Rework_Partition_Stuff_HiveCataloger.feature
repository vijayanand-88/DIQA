@MLP-5149
Feature:MLP-5149: Rework Partition stuff in Hive Cataloger
  Description: Rework Partition stuff in Hive Cataloger

#####################################################################################################################################################################
############## Creating a database/table in hive view along with inserting values and setting certain config values
##############################################################################################################################################################

  @MLP-5149 @sanity @positive
  Scenario: MLP-5149: Creating a database/table in hive view along with inserting values and setting certain config values
    And user executes the following Query in the Hive JDBC
      | queryEntry                  |
      | CreateHivePartitionDatabase |
      | CreateHiveNonPartitionTable |
      | InsertIntoNonPartitionTable |
      | CreateHivePartitionTable    |
      | SetPartitionTrue            |
      | SetPartitionModeNonStrict   |
      | InsertIntoPartitionTable    |

#####################################################################################################################################################################
############## Create a catalog to test Hive Partition Item
##############################################################################################################################################################

  @MLP-5149 @positve @hive @regression @sanity
  Scenario:MLP-5149:Create a catalog to test Hive Partition Item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "ida/bigdataAnalyzerPayloads/CreateHivePartitionCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And verify created schema "TestHivePartition" exists in database

  @MLP-5149 @positve @regression @sanity
  Scenario: MLP-5149:SC1#Update the host in all dependent plugins
    Given User update the ambari host in following files using json path
      | filePath                                        | jsonPath              | node               |
      | ida/bigdataAnalyzerPayloads/ambariResolver.json | $..clusterManagerHost | clusterManagerHost |
    And user update the json file "ida/bigdataAnalyzerPayloads/ambariResolver.json" file for following values
      | jsonPath       | jsonValues        |
      | $..catalogName | TestHivePartition |

  @MLP-5149 @positve @regression @sanity
  Scenario Outline:SC#1 Configure the cluster demo node with ambari resolver configuration
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type | url                               | body                                            | response code | response message  |
      | application/json | raw   | false | Put  | settings/analyzers/AmbariResolver | ida/bigdataAnalyzerPayloads/ambariResolver.json | 204           |                   |
      | application/json |       |       | Get  | settings/analyzers/AmbariResolver |                                                 | 200           | TestHivePartition |

  @MLP-5149 @positve @hive @regression @sanity
  Scenario Outline: Run HiveCataloger Plugin
    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
    Examples:
      | Header           | Query | Param | type         | url                                                                              | body                                                                        | response code | response message |
      | application/json | raw   | false | Put          | settings/analyzers/HiveCataloger                                                 | ida/bigdataAnalyzerPayloads/new_Hive_Cataloger_Partition_Configuration.json | 204           |                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                             | 200           | IDLE             |
      | application/json |       |       | Post         | extensions/analyzers/start/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger  |                                                                             | 200           |                  |
      | application/json |       |       | RecursiveGet | extensions/analyzers/status/Cluster%20Demo/cataloger/HiveCataloger/HiveCataloger |                                                                             | 200           | IDLE             |

#####################################################################################################################################################################
############## Scenario 1: Verify partition is stored as a separate item by HiveCataloger when the table collected has partition
##############################################################################################################################################################

  @MLP-5149 @webtest @positve @hive @regression @sanity
  Scenario: SC#1 Verify whether the Tables and columns  parsed in the IDC UI for partitioned table
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user enters the search text "testhivepartition" and clicks on search
    And user clicks on "testhivepartition" in the items listed
    Then verify the table "TABLES" has item "partition_table"
    And user clicks on type of item "partition_table" in table "TABLES"
    Then verify the table "HAS_PARTITION" has item "state"
    And user clicks on type of item "state" in table "HAS_PARTITION"
    Then the below metadata should get displayed for "state"
      | parentPath                        |
      | testhivepartition/partition_table |
    And user should be able logoff the IDC

#####################################################################################################################################################################
############## Scenario 2: Verify partition is not stored as a separate item by HiveCataloger when the table collected does not have partition
##############################################################################################################################################################

  @MLP-5149 @webtest @positve @hive @regression @sanity
  Scenario: SC#2 Verify whether the Tables and columns  parsed in the IDC UI for non-partitioned table
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator" role
    And login must be successful for all users
    And user enters the search text "testhivepartition" and clicks on search
    And user clicks on "testhivepartition" in the items listed
    Then verify the table "TABLES" has item "non_partition_table"
    And user clicks on type of item "non_partition_table" in table "TABLES"
    Then verify the table "HAS_PARTITION" does not have item "state"
    And user should be able logoff the IDC

#####################################################################################################################################################################
############## Deleting the created database/table in hive view
##############################################################################################################################################################

  @MLP-5149 @sanity @positive
  Scenario: MLP-5149: Deleting the created database/table in hive view
    And user executes the following Query in the Hive JDBC
      | queryEntry                |
      | DropHivePartitionTable    |
      | DropHiveNonPartitionTable |
      | DropHivePartitionDatabase |

#####################################################################################################################################################################
############## Deleting the created catalog
##############################################################################################################################################################
  @MLP-5149 @sanity @positive
  Scenario: MLP-5149 To verify created catalog is deleted
    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "/settings/catalogs/TestHivePartition"
    Then Status code 204 must be returned
    When user makes a REST Call for Get request with url "/settings/catalogs/TestHivePartition"
    And response message contains value "CONFIG-0007"
    And verify created schema "TestHivePartition" doesn't exists in database