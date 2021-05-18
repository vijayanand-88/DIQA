@MLP-17300
Feature: MLP-17300 Data Source Changes for DynamoDB

  @sanity @positive @IDA-10.3
  Scenario: Update AWS secret key and access from config file
    Given User update the below "DynamoDB Readonly credentials" in following files using json path
      | filePath                                                   | accessKeyPath | secretKeyPath |
      | ida/dynamoDBPayloads/Credentials/dydbValidCredentials.json | $..accessKey  | $..secretKey  |


#  @sanity @positive @IDA-10.3
#  Scenario: SC1#:Create new table in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | createTable | ida/dynamoDBPayloads/TestData/CreateTable1.json |
#
##    do not delete table name 'AllDatatypes'
##  @sanity @positive  @IDA-10.3
##  Scenario: SC1#:Create new table AllDataTypes in Dynamo DB using DynamoDB Util
##    Given user connects to AWS Dynamo database and perform the following operation
##      | action      | jsonPath                                        |
##      | createTable | ida/dynamoDBPayloads/TestData/CreateTable2.json |
#
#  @sanity @positive  @IDA-10.3
#  Scenario: SC1#:Create new table DynamicColumns in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | createTable | ida/dynamoDBPayloads/TestData/CreateTable3.json |
#
#  @sanity @positive  @IDA-10.3
#  Scenario: SC1#:Create new table CatalogTable in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | createTable | ida/dynamoDBPayloads/TestData/CreateTable4.json |
#
#  @sanity @positive  @IDA-10.3
#  Scenario: SC1#:Create new Global table in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action            | jsonPath                                              |
#      | createGlobalTable | ida/dynamoDBPayloads/TestData/CreateGlobalTable1.json |
#
#  @sanity @positive  @IDA-10.3
#  Scenario: SC1#:Create new table TableOnlyPrimaryKey in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                             |
#      | createTable | ida/dynamoDBPayloads/TestData/CreateTableOnlyPK.json |
#
#  @sanity @positive  @IDA-10.3
#  Scenario: SC1#:Create records for the new table in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName  | jsonPath                                              |
#      | createItem | TestTable1 | ida/dynamoDBPayloads/TestData/CreateRecordTable1.json |
#
#
#  @sanity @positive  @IDA-10.3
#  Scenario: SC1#:Create records for the new table AllDataTypes in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName    | jsonPath                                              |
#      | createItem | AllDataTypes | ida/dynamoDBPayloads/TestData/CreateRecordTable2.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName    | jsonPath                                              |
#      | createItem | AllDataTypes | ida/dynamoDBPayloads/TestData/CreateRecordTable4.json |
#
#  @sanity @positive  @IDA-10.3
#  Scenario: SC1#:Create records for the new table TestTableOnlyPK in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName       | jsonPath                                                   |
#      | createItem | TestTableOnlyPK | ida/dynamoDBPayloads/TestData/CreateRecordTableOnlyPK.json |
#
#
#  @sanity @positive  @IDA-10.3
#  Scenario: SC1#:Create records for the new table GlobalTestTable1 in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName        | jsonPath                                                     |
#      | createItem | GlobalTable_2017 | ida/dynamoDBPayloads/TestData/CreateGlobalTable1Record1.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName        | jsonPath                                                     |
#      | createItem | GlobalTable_2017 | ida/dynamoDBPayloads/TestData/CreateGlobalTable1Record2.json |
#
#  @sanity @positive  @IDA-10.3
#  Scenario: SC1#:Create records for the new table DynamicColumns in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName      | jsonPath                                              |
#      | createItem | DynamicColumns | ida/dynamoDBPayloads/TestData/CreateRecordTable3.json |
#    And user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName      | jsonPath                                               |
#      | createItem | DynamicColumns | ida/dynamoDBPayloads/TestData/CreateRecordTable31.json |
#    And user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName      | jsonPath                                               |
#      | createItem | DynamicColumns | ida/dynamoDBPayloads/TestData/CreateRecordTable32.json |
#
#  @sanity @positive  @IDA-10.3
#  Scenario: SC1#:Create records for the new table CatalogTable in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName    | jsonPath                                              |
#      | createItem | CatalogTable | ida/dynamoDBPayloads/TestData/CreateRecordTable6.json |
#    And user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName    | jsonPath                                              |
#      | createItem | CatalogTable | ida/dynamoDBPayloads/TestData/CreateRecordTable5.json |
#
#
#  @sanity @positive @IDA-1.1.0
#  Scenario: SC1#:Create new table TAGDETAILS_ALLMATCH in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | createTable | ida/dynamoDBPayloads/TestData/CreateTable5.json |
#
#
#  @sanity @positive @IDA-10.3
#  Scenario: SC1#:Create new record for the table TAGDETAILS_ALLMATCH in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName           | jsonPath                                                       |
#      | createItem | TAGDETAILS_ALLMATCH | ida/dynamoDBPayloads/TestData/TAGDETAILS_ALLMATCH_Record1.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName           | jsonPath                                                       |
#      | createItem | TAGDETAILS_ALLMATCH | ida/dynamoDBPayloads/TestData/TAGDETAILS_ALLMATCH_Record2.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName           | jsonPath                                                       |
#      | createItem | TAGDETAILS_ALLMATCH | ida/dynamoDBPayloads/TestData/TAGDETAILS_ALLMATCH_Record3.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName           | jsonPath                                                       |
#      | createItem | TAGDETAILS_ALLMATCH | ida/dynamoDBPayloads/TestData/TAGDETAILS_ALLMATCH_Record4.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName           | jsonPath                                                       |
#      | createItem | TAGDETAILS_ALLMATCH | ida/dynamoDBPayloads/TestData/TAGDETAILS_ALLMATCH_Record5.json |
#
#
#  @sanity @positive @IDA-1.1.0
#  Scenario: SC1#:Create new table TAGDETAILS_ALLEMPTY in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | createTable | ida/dynamoDBPayloads/TestData/CreateTable6.json |
#
#
#  @sanity @positive  @IDA-10.3
#  Scenario: SC1#:Create  new record for the table TAGDETAILS_ALLEMPTY in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName           | jsonPath                                                    |
#      | createItem | TAGDETAILS_ALLEMPTY | ida/dynamoDBPayloads/TestData/TAGDETAILS_EMPTY_Record1.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName           | jsonPath                                                    |
#      | createItem | TAGDETAILS_ALLEMPTY | ida/dynamoDBPayloads/TestData/TAGDETAILS_EMPTY_Record2.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName           | jsonPath                                                    |
#      | createItem | TAGDETAILS_ALLEMPTY | ida/dynamoDBPayloads/TestData/TAGDETAILS_EMPTY_Record3.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName           | jsonPath                                                    |
#      | createItem | TAGDETAILS_ALLEMPTY | ida/dynamoDBPayloads/TestData/TAGDETAILS_EMPTY_Record4.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName           | jsonPath                                                    |
#      | createItem | TAGDETAILS_ALLEMPTY | ida/dynamoDBPayloads/TestData/TAGDETAILS_EMPTY_Record5.json |
#
#
#  @sanity @positive  @IDA-10.3
#  Scenario: SC1#:Create new table TAGDETAILS_RatioEqualTo05EmptyFalse in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | createTable | ida/dynamoDBPayloads/TestData/CreateTable7.json |
#
#  @sanity @positive @IDA-10.3
#  Scenario: SC1#:Create  new record for the table TAGDETAILS_RatioEqualTo05EmptyFalse in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                           | jsonPath                                                                       |
#      | createItem | TAGDETAILS_RatioEqualTo05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_RatioEqualTo05EmptyFalse_Record1.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                           | jsonPath                                                                       |
#      | createItem | TAGDETAILS_RatioEqualTo05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_RatioEqualTo05EmptyFalse_Record2.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                           | jsonPath                                                                       |
#      | createItem | TAGDETAILS_RatioEqualTo05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_RatioEqualTo05EmptyFalse_Record3.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                           | jsonPath                                                                       |
#      | createItem | TAGDETAILS_RatioEqualTo05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_RatioEqualTo05EmptyFalse_Record4.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                           | jsonPath                                                                       |
#      | createItem | TAGDETAILS_RatioEqualTo05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_RatioEqualTo05EmptyFalse_Record5.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                           | jsonPath                                                                       |
#      | createItem | TAGDETAILS_RatioEqualTo05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_RatioEqualTo05EmptyFalse_Record6.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                           | jsonPath                                                                       |
#      | createItem | TAGDETAILS_RatioEqualTo05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_RatioEqualTo05EmptyFalse_Record7.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                           | jsonPath                                                                       |
#      | createItem | TAGDETAILS_RatioEqualTo05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_RatioEqualTo05EmptyFalse_Record8.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                           | jsonPath                                                                       |
#      | createItem | TAGDETAILS_RatioEqualTo05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_RatioEqualTo05EmptyFalse_Record9.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                           | jsonPath                                                                        |
#      | createItem | TAGDETAILS_RatioEqualTo05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_RatioEqualTo05EmptyFalse_Record10.json |
#
#
#  @sanity @positive @IDA-10.3
#  Scenario: SC1:Create new table TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | createTable | ida/dynamoDBPayloads/TestData/CreateTable8.json |
#
#  @sanity @positive @IDA-10.3
#  Scenario: SC1#:Create new record for the table TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record1.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record2.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record3.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record4.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record5.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record6.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record7.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record8.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record9.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                   | jsonPath                                                                                |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record10.json |
#
#
#  @sanity @positive @IDA-10.3
#  Scenario: SC1#:Create new table TAGDETAILS_Ratiogreaterthan05MatchFullTrue in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | createTable | ida/dynamoDBPayloads/TestData/CreateTable9.json |
#
#  @sanity @positive @IDA-10.3
#  Scenario: SC41#:Create new record for the table  TAGDETAILS_Ratiogreaterthan05MatchFullTrue in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                  | jsonPath                                                                              |
#      | createItem | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05MatchFullTrue_Record1.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                  | jsonPath                                                                              |
#      | createItem | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05MatchFullTrue_Record2.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                  | jsonPath                                                                              |
#      | createItem | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05MatchFullTrue_Record3.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                  | jsonPath                                                                              |
#      | createItem | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05MatchFullTrue_Record4.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                  | jsonPath                                                                              |
#      | createItem | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05MatchFullTrue_Record5.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                  | jsonPath                                                                              |
#      | createItem | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05MatchFullTrue_Record6.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                  | jsonPath                                                                              |
#      | createItem | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05MatchFullTrue_Record7.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                  | jsonPath                                                                              |
#      | createItem | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05MatchFullTrue_Record8.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                  | jsonPath                                                                              |
#      | createItem | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05MatchFullTrue_Record9.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                  | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05MatchFullTrue_Record10.json |
#
#
#  @sanity @positive @IDA-10.3
#  Scenario: SC1#:Create new table TAGDETAILS_Ratiolesserthan05MatchFullTrue in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                         |
#      | createTable | ida/dynamoDBPayloads/TestData/CreateTable10.json |
#
#  @sanity @positive @IDA-10.3
#  Scenario: SC1#:Create new record for the table TAGDETAILS_Ratiolesserthan05MatchFullTrue in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                 | jsonPath                                                                             |
#      | createItem | TAGDETAILS_Ratiolesserthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolesserthan05MatchFullTrue_Record1.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                 | jsonPath                                                                             |
#      | createItem | TAGDETAILS_Ratiolesserthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolesserthan05MatchFullTrue_Record2.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                 | jsonPath                                                                             |
#      | createItem | TAGDETAILS_Ratiolesserthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolesserthan05MatchFullTrue_Record3.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                 | jsonPath                                                                             |
#      | createItem | TAGDETAILS_Ratiolesserthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolesserthan05MatchFullTrue_Record4.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                 | jsonPath                                                                             |
#      | createItem | TAGDETAILS_Ratiolesserthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolesserthan05MatchFullTrue_Record5.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                 | jsonPath                                                                             |
#      | createItem | TAGDETAILS_Ratiolesserthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolesserthan05MatchFullTrue_Record6.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                 | jsonPath                                                                             |
#      | createItem | TAGDETAILS_Ratiolesserthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolesserthan05MatchFullTrue_Record7.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                 | jsonPath                                                                             |
#      | createItem | TAGDETAILS_Ratiolesserthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolesserthan05MatchFullTrue_Record8.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                 | jsonPath                                                                             |
#      | createItem | TAGDETAILS_Ratiolesserthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolesserthan05MatchFullTrue_Record9.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                 | jsonPath                                                                              |
#      | createItem | TAGDETAILS_Ratiolesserthan05MatchFullTrue | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolesserthan05MatchFullTrue_Record10.json |
#
#  @sanity @positive @IDA-10.3
#  Scenario: SC1#:Create new table TAGDETAILS_Ratiolessthan05EmptyFalse in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                         |
#      | createTable | ida/dynamoDBPayloads/TestData/CreateTable11.json |
#
#  @sanity @positive @IDA-10.3
#  Scenario: SC1#:Create new record for the table TAGDETAILS_Ratiolessthan05EmptyFalse in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                            | jsonPath                                                                        |
#      | createItem | TAGDETAILS_Ratiolessthan05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolessthan05EmptyFalse_Record1.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                            | jsonPath                                                                        |
#      | createItem | TAGDETAILS_Ratiolessthan05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolessthan05EmptyFalse_Record2.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                            | jsonPath                                                                        |
#      | createItem | TAGDETAILS_Ratiolessthan05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolessthan05EmptyFalse_Record3.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                            | jsonPath                                                                        |
#      | createItem | TAGDETAILS_Ratiolessthan05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolessthan05EmptyFalse_Record4.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                            | jsonPath                                                                        |
#      | createItem | TAGDETAILS_Ratiolessthan05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolessthan05EmptyFalse_Record5.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                            | jsonPath                                                                        |
#      | createItem | TAGDETAILS_Ratiolessthan05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolessthan05EmptyFalse_Record6.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                            | jsonPath                                                                        |
#      | createItem | TAGDETAILS_Ratiolessthan05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolessthan05EmptyFalse_Record7.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                            | jsonPath                                                                        |
#      | createItem | TAGDETAILS_Ratiolessthan05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolessthan05EmptyFalse_Record8.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                            | jsonPath                                                                        |
#      | createItem | TAGDETAILS_Ratiolessthan05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolessthan05EmptyFalse_Record9.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                            | jsonPath                                                                         |
#      | createItem | TAGDETAILS_Ratiolessthan05EmptyFalse | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiolessthan05EmptyFalse_Record10.json |
#
#
#  @sanity @positive @IDA-10.3
#  Scenario: SC1#:Create new table TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action            | jsonPath                                         |
#      | createGlobalTable | ida/dynamoDBPayloads/TestData/CreateTable12.json |
#
#  @sanity @positive @IDA-10.3
#  Scenario: SC1#:Create new record for the table TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 in Dynamo DB using DynamoDB Util
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record1.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record2.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record3.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record4.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record5.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record6.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record7.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record8.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                                   | jsonPath                                                                               |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record9.json |
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action     | tableName                                                   | jsonPath                                                                                |
#      | createItem | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | ida/dynamoDBPayloads/TestData/TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_Record10.json |
#    And sync the test execution for "180" seconds

 ############# setting the Credentials ###################
  @jdbc
  Scenario Outline: SC1#-Set the Credentials for DynamoDB Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                           | body                                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/ValidDYDBCredentials     | ida/dynamoDBPayloads/Credentials/dydbValidCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/IncorrectDYDBCredentials | ida/dynamoDBPayloads/Credentials/dydbInValidCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EmptyDYDBCredentials     | ida/dynamoDBPayloads/Credentials/dydbEmptyCredentials.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/ValidDYDBCredentials     |                                                              | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/IncorrectDYDBCredentials |                                                              | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EmptyDYDBCredentials     |                                                              | 200           |                  |          |

  @sanity
  Scenario: SC1#-Set the DynamoDB Datasources
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                   | body                                                           | response code | response message | jsonPath            |
      | application/json | raw   | false | Put  | settings/analyzers/DynamoDBDataSource | ida/dynamoDBPayloads/DataSource/dydbValidDataSourceConfig.json | 204           |                  |                     |
      |                  |       |       | Get  | settings/analyzers/DynamoDBDataSource |                                                                | 200           |                  | dydbValidDataSource |

  @sanity @positive @regression @IDA_E2E
  Scenario Outline: create BussinessApplication tag and run the plugin configuration with the new field
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                                               | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | ida/dynamoDBPayloads/PluginConfiguration/BussinessApplication.json | 200           |                  |          |

##AWS env cases as GoogleCloud will fail
  @webtest @regression @positive
  Scenario:SC#1 : Verification of TestConnection for DynamoDB DataSource and plugin configuration
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute          |
      | Data Source Type | DynamoDBDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute        |
      | Name      | AutoQADataSource |
      | Label     | AutoQADataSource |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | ValidDYDBCredentials              |
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Node      | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
#    And user "select dropdown" in Add Data Source Page
#      | fieldName  | attribute   |
#      | Deployment | GoogleCloud |
#    And user "click" on "Test Connection" button in "Add Data Sources pop up"
#    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
#    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
#    And user "click" on "Close button" button in "Add Data Source popup"
#    And user clicks on "Yes" link in the "Unsaved Changes popup"
#    And user performs following actions in the sidebar
#      | actionType | actionItem            |
#      | click      | Settings Icon         |
#      | click      | Manage Configurations |
#    And user performs "click" operation in Manage Configurations panel
#      | button          | actionItem |
#      | Open Deployment | LocalNode  |
#    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
#    And user "select dropdown" in Add Configuration Page in Manage Configurations
#      | fieldName      | attribute         |
#      | Type           | Cataloger         |
#      | Plugin         | DynamoDBCataloger |
#      | Plugin version | LATEST            |
#    And user "enter text" in Add Data Source Page
#      | fieldName | attribute           |
#      | Name      | AutoQADataCataloger |
#      | Label     | AutoQADataCataloger |
#    And user "select dropdown" in Add Data Source Page
#      | fieldName   | attribute            |
#      | Data Source | DynamoValidDS        |
#      | Credential  | ValidDYDBCredentials |
#    And user "click" on "Test Connection" button in "Add Configuration pop up"
#    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Configuration pop up"

  @webtest
  Scenario: SC#2-Verify whether the background of the panel is displayed in red when test connection is not successful for DynamoDBDataSource in LocalNode
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute          |
      | Data Source Type | DynamoDBDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Region*     |
      | Credential* |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute            |
      | Name      | AutoQADataSourceTest |
      | Label     | AutoQADataSourceTest |
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute                         |
      | Region     | US East (N. Virginia) [us-east-1] |
      | Credential | IncorrectDYDBCredentials          |
      | Node       | LocalNode                         |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName  | attribute            |
      | Credential | EmptyDYDBCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "enabled" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"

  @sanity @positive @IDA-10.3
  Scenario:SC3_Verify the Host should have the appropriate metadata information in IDC UI and Database
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                          | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC1.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                               | 200           |                  | DynamoCatalog1                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                               | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog1')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                               | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                               | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog1')].status |

  Scenario Outline: SC3#user retrieves ID with catalog name and type
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type       | name                                   | asg_scopeid | targetFile                            | jsonpath             |
      | APPDBPOSTGRES | ID      | Default | Table      | TestTable1                             |             | response/dynamoDB/actual/itemIds.json | $..has_Table.id      |
      | APPDBPOSTGRES | ID      | Default | Constraint | TESTTABLE1_PRIMARYKEY                  |             | response/dynamoDB/actual/itemIds.json | $..has_Constraint.id |
      | APPDBPOSTGRES | ID      | Default | Service    | DYNAMODB                               |             | response/dynamoDB/actual/itemIds.json | $..has_Service.id    |
      | APPDBPOSTGRES | ID      | Default | Database   | DYNAMODB                               |             | response/dynamoDB/actual/itemIds.json | $..has_Database.id   |
      | APPDBPOSTGRES | ID      | Default | Host       | Domain=amazonaws.com;Region=us-east-1; |             | response/dynamoDB/actual/itemIds.json | $..has_Host.id       |
      | APPDBPOSTGRES | ID      | Default | Cluster    | Domain=amazonaws.com;Region=us-east-1; |             | response/dynamoDB/actual/itemIds.json | $..Cluster.id        |


  Scenario Outline: SC3#user retrieves the metadata of each datat type for a catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                  | responseCode | inputJson            | inputFile                             | outPutFile                                       | outPutJson |
      | components/Default/item/Default.Host:::dynamic       | 200          | $..has_Host.id       | response/dynamoDB/actual/itemIds.json | response/dynamoDB/actual/hostMetadata.json       |            |
      | components/Default/item/Default.Cluster:::dynamic    | 200          | $..Cluster.id        | response/dynamoDB/actual/itemIds.json | response/dynamoDB/actual/clusterMetadata.json    |            |
      | components/Default/item/Default.Service:::dynamic    | 200          | $..has_Service.id    | response/dynamoDB/actual/itemIds.json | response/dynamoDB/actual/serviceMetadata.json    |            |
      | components/Default/item/Default.Database:::dynamic   | 200          | $..has_Database.id   | response/dynamoDB/actual/itemIds.json | response/dynamoDB/actual/databaseMetadata.json   |            |
      | components/Default/item/Default.Table:::dynamic      | 200          | $..has_Table.id      | response/dynamoDB/actual/itemIds.json | response/dynamoDB/actual/tableMetadata.json      |            |
      | components/Default/item/Default.Constraint:::dynamic | 200          | $..has_Constraint.id | response/dynamoDB/actual/itemIds.json | response/dynamoDB/actual/constraintMetadata.json |            |


  Scenario Outline: SC3#validate the total count and facets count for a catalog
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                              | response code | response message | filePath                                     | jsonPath |
#      | IDC         | TestSystem | application/json |       |       | Get  | searches/fulltext/Default?query=SC1DynamoTags&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0     |                                                   | 200           |                  | response/dynamoDB/actual/catalogItems.json   |          |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | response/dynamoDB/body/getFacetsCountRequest.json | 200           |                  | response/dynamoDB/actual/facetWiseCount.json |          |

#6754454##6754453#6754445#6754446#6754447#6754455#6754463#
  Scenario Outline:SC3# Validate Cluster,Host,Service,Database,Table and Constraint should have the appropriate metadata information in IDC UI and Database
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                           | actualValues                                     | valueType         | expectedJsonPath                                                | actualJsonPath                                                            |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/facetWiseCount.json     | intCompare        | $..totalCount                                                   | $..count                                                                  |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/facetWiseCount.json     | intListCompare    | $..MetaData.facetCounts.type_s..count                           | $.facetCounts..type_s..count                                              |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/hostMetadata.json       | stringListCompare | $..hostMetaData..taglist..techTag                               | $..[?(@.type=='taglist')].data..name                                      |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/hostMetadata.json       | stringCompare     | $..hostMetaData..HostName                                       | $..[?(@.caption=='Host name')].data..value                                |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/hostMetadata.json       | intCompare        | $..hostMetaData..NumberofCores                                  | $..[?(@.caption=='Number of cores')].data..value                          |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/clusterMetadata.json    | stringListCompare | $..clusterMetaData..taglist..techTag                            | $..[?(@.type=='taglist')].data..name                                      |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/clusterMetadata.json    | stringListCompare | $..clusterMetaData..table..values.[?(@.type=='Hosts')].name     | $..[?(@.caption=='Hosts')].data..name                                     |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/clusterMetadata.json    | stringListCompare | $..clusterMetaData..table..values.[?(@.type=='Services')].name  | $..[?(@.caption=='Services')].data..name                                  |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/serviceMetadata.json    | stringListCompare | $..serviceMetaData..taglist..techTag                            | $..[?(@.type=='taglist')].data..name                                      |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/serviceMetadata.json    | stringListCompare | $..serviceMetaData..table..values.[?(@.type=='Databases')].name | $..[?(@.caption=='Databases')].data..name                                 |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/serviceMetadata.json    | stringCompare     | $..serviceMetaData.applicationVersion                           | $..[?(@.caption=='Application Version')].data..value                      |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/databaseMetadata.json   | stringListCompare | $..databaseMetaData..taglist..techTag                           | $..[?(@.type=='taglist')].data..name                                      |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/databaseMetadata.json   | stringCompare     | $..storageType                                                  | $..[?(@.caption=='Storage type')]..value                                  |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/databaseMetadata.json   | stringListCompare | $..databaseMetaData.table.values..name                          | $..[?(@.caption=='Tables')].data..name                                    |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/tableMetadata.json      | stringListCompare | $..tableMetaData..taglist..techTag                              | $..[?(@.type=='taglist')].data..name                                      |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/tableMetadata.json      | stringCompare     | $..tableMetaData.tableType                                      | $..[?(@.caption=='Description')]..[?(@.caption=='Table Type')].data.value |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/constraintMetadata.json | stringListCompare | $..constraintMetaData..taglist..techTag                         | $..[?(@.type=='taglist')].data..name                                      |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/constraintMetadata.json | stringCompare     | $..constraintMetaData.constraintType                            | $..[?(@.caption=='Constraint Type')].data.value                           |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/constraintMetadata.json | stringCompare     | $..constraintMetaData.table.values..name                        | $..[?(@.caption=='columns')].data..name                                   |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/facetWiseCount.json     | intCompare        | $.MetaData..type_s..[?(@.value=='Column')].count                | $.facetCounts..type_s..[?(@.value=='Column')].count                       |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/facetWiseCount.json     | intCompare        | $.MetaData..type_s..[?(@.value=='Constraint')].count            | $.facetCounts..type_s..[?(@.value=='Constraint')].count                   |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/facetWiseCount.json     | intCompare        | $.MetaData..type_s..[?(@.value=='Table')].count                 | $.facetCounts..type_s..[?(@.value=='Table')].count                        |

 ##6754452#7126907
  @sanity @positive @webtest @MLP-8191 @IDA-10.3
  Scenario:SC11#Verify the column data types
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1DynamoTags" and clicks on search
    And user performs "facet selection" in "SC1DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AllDataTypes" item from search results
    Then user performs click and verify in new window
      | Table   | value   | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book BS | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | SET               |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book Binary | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | BINARY            |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book Blank | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | VARCHAR           |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value                  | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book Datewithtimestamp | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | VARCHAR           |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book double | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | FLOAT             |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book Float | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | FLOAT             |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book long | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | FLOAT             |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value   | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book NS | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | SET               |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | BookAuthor | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | MAP               |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Color | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | LIST              |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book NULL | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | NULL              |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value   | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book SS | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | SET               |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book Title | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | VARCHAR           |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Id    | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | FLOAT             |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value          | Action               | RetainPrevwindow | indexSwitch |
      | Columns | In Publication | click and switch tab | Yes              |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | BIT               |
      | Length       | 1                 |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value         | Action               | RetainPrevwindow | indexSwitch |
      | Columns | ItemsOnMyDesk | click and switch tab | No               |             |
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Data type    | LIST              |


 ##6754448#
  @sanity @positive @webtest @IDA-10.3
  Scenario:SC4#Verify the column should have the appropriate metadata information in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Title" and clicks on search
    And user performs "facet selection" in "SC1DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Title" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | VARCHAR       | Description |
      | Length            | 2000          | Statistics  |
#      | Comments          | The column Title. | Description |
    And user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
#    And user copy metadata value from Item View Page and write to file using below parameters
#      | itemName       | Title                                             |
#      | attributeName  | Technical Data                                    |
#      | actualFilePath | ida/dynamoDBPayloads/TestData/actualTechData.json |
#    Then file content in "ida/dynamoDBPayloads/TestData/expectedTitleMetadata.json" should be same as the content in "ida/dynamoDBPayloads/TestData/actualTechData.json"
    And user enters the search text "SC1DynamoTags" and clicks on search
    And user performs "facet selection" in "SC1DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/DynamoDBCataloger/DynamoCatalog1%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | DYNAMODB                               |
      | Domain=amazonaws.com;Region=us-east-1; |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/DynamoDBCataloger/DynamoCatalog1%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | logCode       | pluginName        | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0019 |                   |                |
      | INFO | Plugin Name:DynamoDBCataloger, Plugin Type:cataloger, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:ad0afbc5759b, Plugin Configuration name:DynamoCatalog1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | ANALYSIS-0071 | DynamoDBCataloger | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: ---  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: name: "DynamoCatalog1"  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: pluginVersion: "LATEST"  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: label:  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: : ""  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: catalogName: "Default"  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: eventClass: null  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: eventCondition: null  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: nodeCondition: null  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: maxWorkSize: 100  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: tags:  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: - "SC1DynamoTags"  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: pluginType: "cataloger"  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: dataSource: "DynamoValidDS"  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: credential: "ValidDYDBCredentials"  2020-08-31 06:20:23.247 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: businessApplicationName: "DYNAMODB_BA"  2020-08-31 06:20:23.248 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: dryRun: false  2020-08-31 06:20:23.248 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: schedule: null  2020-08-31 06:20:23.248 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: filter: null  2020-08-31 06:20:23.248 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: tables:  2020-08-31 06:20:23.248 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: - table: "GlobalTable2019"  2020-08-31 06:20:23.249 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: - table: "GlobalTable_2017"  2020-08-31 06:20:23.249 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: - table: "DynamicColumns"  2020-08-31 06:20:23.249 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: - table: "CatalogTable"  2020-08-31 06:20:23.249 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: - table: "TestTableOnlyPK"  2020-08-31 06:20:23.249 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: - table: "AllDataTypes"  2020-08-31 06:20:23.249 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: - table: "TestTable1"  2020-08-31 06:20:23.249 INFO  - ANALYSIS-0073: Plugin DynamoDBCataloger Configuration: properties: [] | ANALYSIS-0073 | DynamoDBCataloger |                |
      | INFO | Plugin DynamoDBCataloger Start Time:2020-03-05 09:35:25.298, End Time:2020-03-05 09:35:48.813, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0072 | DynamoDBCataloger |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:35.865)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0020 |                   |                |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC4:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog1/% | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;       | Cluster  |       |       |


#6754463#
  @sanity @positive @webtest @IDA-10.3
  Scenario: SC5#Verify DynamoDBCataloger plugin config throws error message in UI if mandatory fields are not passed as input.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute         |
      | Type      | Cataloger         |
      | Plugin    | DynamoDBCataloger |
    And user verifies "validation message" is displayed under the fields in "Add Configuration" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  #6754449#
  @sanity @positive @webtest @IDA-10.3
  Scenario:SC6#Verify DynamDBCataloger collects DB items specific to the Table Name given in filters.
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                          | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC9.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                               | 200           |                  | DynamoCatalog2                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                               | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog2')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                               | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                               | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog2')].status |


  Scenario Outline:SC6#validate the total count and facets count for a catalog DynamoCatalogNoFilter
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                   | response code | response message | filePath                                     | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | response/dynamoDB/body/getFacetsCountRequest_SC11.json | 200           |                  | response/dynamoDB/actual/facetWiseCount.json |          |


  Scenario Outline: SC6#user retrieves ID with catalog name and type
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type  | name       | asg_scopeid | targetFile                            | jsonpath        |
      | APPDBPOSTGRES | ID      | Default | Table | TestTable1 |             | response/dynamoDB/actual/itemIds.json | $..has_Table.id |


  Scenario Outline: SC6#user retrieves the data of particular item for a catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                             | responseCode | inputJson       | inputFile                             | outPutFile                                  | outPutJson |
      | components/Default/item/Default.Table:::dynamic | 200          | $..has_Table.id | response/dynamoDB/actual/itemIds.json | response/dynamoDB/actual/tableMetadata.json |            |


  #6754463#
  Scenario Outline:SC6# Verify DynamDBCataloger collects DB items specific to the Table Name given in filters.
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                | actualValues                                 | valueType     | expectedJsonPath                                     | actualJsonPath                                          |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData_SC11.json | response/dynamoDB/actual/facetWiseCount.json | intCompare    | $.MetaData..type_s..[?(@.value=='Column')].count     | $.facetCounts..type_s..[?(@.value=='Column')].count     |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData_SC11.json | response/dynamoDB/actual/facetWiseCount.json | intCompare    | $.MetaData..type_s..[?(@.value=='Constraint')].count | $.facetCounts..type_s..[?(@.value=='Constraint')].count |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData_SC11.json | response/dynamoDB/actual/facetWiseCount.json | intCompare    | $.MetaData..type_s..[?(@.value=='Table')].count      | $.facetCounts..type_s..[?(@.value=='Table')].count      |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData_SC11.json | response/dynamoDB/actual/tableMetadata.json  | stringCompare | $.MetaData..tableMetaData.name                       | $..caption.name                                         |


       ##6754464#
  @sanity @positive @webtest @IDA-10.3
  Scenario:SC7#Verify the breadcrumb hierarchy appears correctly when JDBC cataloger is ran for DynamoDBDatabase
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2DynamoTags" and clicks on search
    And user performs "facet selection" in "SC2DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Color" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | Domain=amazonaws.com;Region=us-east-1; |
      | DYNAMODB                               |
      | DYNAMODB                               |
      | TestTable1                             |
      | Color                                  |


  Scenario Outline: SC7#user retrieves the total items for a catalog and copy to a json file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type       | name                  | asg_scopeid | targetFile                            | jsonpath             |
      | APPDBPOSTGRES | ID      | Default | Constraint | TESTTABLE1_PRIMARYKEY |             | response/dynamoDB/actual/itemIds.json | $..has_Constraint.id |


  Scenario Outline: SC7#user retrieves the data of particular item for a catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                  | responseCode | inputJson            | inputFile                             | outPutFile                                       | outPutJson |
      | components/Default/item/Default.Constraint:::dynamic | 200          | $..has_Constraint.id | response/dynamoDB/actual/itemIds.json | response/dynamoDB/actual/constraintMetadata.json |            |

  #6754444#
  Scenario Outline:SC7Verify the DynamoDB Tables should have constraints window with Primary Key constraints(Primary key and sort key) available.
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                | actualValues                                     | valueType     | expectedJsonPath                                                        | actualJsonPath                               |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData_SC11.json | response/dynamoDB/actual/constraintMetadata.json | stringCompare | $.MetaData..constraintMetaData.name                                     | $..caption.name                              |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData_SC11.json | response/dynamoDB/actual/constraintMetadata.json | stringCompare | $..MetaData.constraintMetaData.table.values.[?(@.type=='Columns')].name | $..[?(@.caption=='columns')].data.data..name |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC7:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog2/% | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;       | Cluster  |       |       |


##6754462#
  @sanity @positive @webtest @IDA-10.3
  Scenario:SC8#Verify captions and tool tip text in DynamoDBCataloger and DynamoDBDataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute         |
      | Type      | Cataloger         |
      | Plugin    | DynamoDBCataloger |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name* |
      | Label |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name  | Plugin configuration name                           |
      | Label | Plugin configuration extended label and description |
    And user "click" on "Close button" button in "Add Configuration to LocalNode popup"
    And user clicks on "Yes" link in the "Unsaved Changes popup"
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute          |
      | Data Source Type | DynamoDBDataSource |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*   |
      | Label   |
      | Domain  |
      | Region* |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Name   | Plugin configuration name                                                             |
      | Label  | Plugin configuration extended label and description                                   |
      | Domain | Domain Name                                                                           |
      | Region | Geographic area where the Amazon Dynamo DB resources are available for data analysis. |
    And user "click" on "Close button" button in "Add Data Source popup"
    And user clicks on "Yes" link in the "Unsaved Changes popup"
    And user performs following actions in the sidebar
      | actionType | actionItem         |
      | click      | Settings Icon      |
      | click      | Manage Credentials |
    And user "click" on "Add Credentials Button in Manage Credentials Page" button in "Manage Credentials page"
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute |
      | Type      | AWS       |
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Type*       |
      | Name*       |
      | Access Key* |
      | Secret Key* |
    Then user "Verify tool tip message presence" for below parameters in Plugin Configuration page
      | Access Key | Access key ID to access AWS resource     |
      | Secret Key | Secret access key to access AWS resource |


  #6754457#
  @sanity @positive @webtest @IDA-10.3
  Scenario:SC9#Verify DynamoDBCataloger scans and collects data if the plugin configuration has specific node condition
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/DynamoDBDataSource                               | ida/dynamoDBPayloads/DataSource/dydbValidDataSourceConfig.json | 204           |                  |                                                     |
      |        |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC14.json | 204           |                  |                                                     |
      |        |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog3                                      |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog3')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog3')].status |

  Scenario Outline: SC9#user retrieves ID with catalog name and type
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type    | name                                   | asg_scopeid | targetFile                            | jsonpath      |
      | APPDBPOSTGRES | ID      | Default | Cluster | Domain=amazonaws.com;Region=us-east-1; |             | response/dynamoDB/actual/itemIds.json | $..Cluster.id |

  Scenario Outline: SC9#user retrieves the metadata of each datat type for a catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                               | responseCode | inputJson     | inputFile                             | outPutFile                                    | outPutJson |
      | components/Default/item/Default.Cluster:::dynamic | 200          | $..Cluster.id | response/dynamoDB/actual/itemIds.json | response/dynamoDB/actual/clusterMetadata.json |            |


  @sanity @positive @IDA-10.3
  Scenario Outline:SC9#validate DynamoDBCataloger scans and collects data if the plugin configuration has specific node condition
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                   | response code | response message | filePath                                     | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | response/dynamoDB/body/getFacetsCountRequest_SC15.json | 200           |                  | response/dynamoDB/actual/facetWiseCount.json |          |


  @sanity @positive @IDA-10.3
  Scenario Outline:SC9# Verify DynamoDBCataloger scans and collects data if the plugin configuration has specific node condition
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                           | actualValues                                  | valueType         | expectedJsonPath                                                | actualJsonPath                                          |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/facetWiseCount.json  | intCompare        | $.MetaData..type_s..[?(@.value=='Column')].count                | $.facetCounts..type_s..[?(@.value=='Column')].count     |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/facetWiseCount.json  | intCompare        | $.MetaData..type_s..[?(@.value=='Constraint')].count            | $.facetCounts..type_s..[?(@.value=='Constraint')].count |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/facetWiseCount.json  | intCompare        | $.MetaData..type_s..[?(@.value=='Table')].count                 | $.facetCounts..type_s..[?(@.value=='Table')].count      |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/clusterMetadata.json | stringListCompare | $..clusterMetaData..table..values.[?(@.type=='Hosts')].name     | $..[?(@.caption=='Hosts')].data..name                   |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/clusterMetadata.json | stringListCompare | $..clusterMetaData..table..values.[?(@.type=='Services')].name  | $..[?(@.caption=='Services')].data..name                |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/serviceMetadata.json | stringListCompare | $..serviceMetaData..taglist..techTag                            | $..[?(@.type=='taglist')].data..name                    |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | response/dynamoDB/actual/serviceMetadata.json | stringListCompare | $..serviceMetaData..table..values.[?(@.type=='Databases')].name | $..[?(@.caption=='Databases')].data..name               |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC9:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog3/% | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;       | Cluster  |       |       |



##6754451#
  @sanity @positive @IDA-10.3
  Scenario:SC10#Verify DynamoDBCataloger collects DB items specific to the Multiple Tables given in filters.
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                            |
      |        |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC15.json | 204           |                  |                                                     |
      |        |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog4                                      |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog4')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                     |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog4')].status |

  @sanity @positive @IDA-10.3
  Scenario Outline:SC10#_Validate DynamoDBCataloger collects DB items specific to the Multiple Tables given in filters.
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                   | response code | response message | filePath                                     | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | response/dynamoDB/body/getFacetsCountRequest_SC16.json | 200           |                  | response/dynamoDB/actual/facetWiseCount.json |          |


  Scenario Outline: SC10#user retrieves ID with catalog name and type
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type     | name                                   | asg_scopeid | targetFile                            | jsonpath           |
      | APPDBPOSTGRES | ID      | Default | Database | DYNAMODB                               |             | response/dynamoDB/actual/itemIds.json | $..has_Database.id |
      | APPDBPOSTGRES | ID      | Default | Cluster  | Domain=amazonaws.com;Region=us-east-1; |             | response/dynamoDB/actual/itemIds.json | $..Cluster.id      |

  Scenario Outline: SC10#user retrieves the data of particular item for a catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                | responseCode | inputJson          | inputFile                             | outPutFile                                     | outPutJson |
      | components/Default/item/Default.Database:::dynamic | 200          | $..has_Database.id | response/dynamoDB/actual/itemIds.json | response/dynamoDB/actual/databaseMetadata.json |            |

  @sanity @positive @IDA-10.3
  Scenario Outline:SC10# Verify the DynamoDBCataloger collects DB items specific to the Multiple Tables given in filters.
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                | actualValues                                   | valueType     | expectedJsonPath                                                   | actualJsonPath                                     |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData_SC16.json | response/dynamoDB/actual/facetWiseCount.json   | intCompare    | $.MetaData..type_s..[?(@.value=='Table')].count                    | $.facetCounts..type_s..[?(@.value=='Table')].count |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData_SC16.json | response/dynamoDB/actual/databaseMetadata.json | stringCompare | $.MetaData.databaseMetaData.table.values.[?(@.type=='Table')].name | $..[?(@.caption=='Tables')].data.data..name        |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC10:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog4/% | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;       | Cluster  |       |       |


##6754450#
  @sanity @positive @IDA-10.3
  Scenario:SC11#Verify DynamoDBCataloger does not collects Table, Columns,Constraints with filters having non-existing Table.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC16.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog5                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog5')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog5')].status |
    Then Analysis log "cataloger/DynamoDBCataloger/DynamoCatalog5%" should display below info/error/warning
      | type | logValue                                     | logCode            |
      | WARN | No data is available for cataloging purpose. | ANALYSIS-JDBC-0048 |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC11:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog5/% | Analysis |       |       |





#  #6754456#
  @sanity @positive @IDA-10.3
  Scenario:SC12#Verify DynamoDBCataloger scans and collects data if the collection contains dynamic columns
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC18.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog7                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog7')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog7')].status |

  @sanity @positive @IDA-10.3
  Scenario Outline:SC12#_Validate DynamoDBCataloger scans and collects data if the collection contains dynamic columns
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                   | response code | response message | filePath                                     | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | response/dynamoDB/body/getFacetsCountRequest_SC19.json | 200           |                  | response/dynamoDB/actual/facetWiseCount.json |          |


  Scenario Outline: SC12#user retrieves ID with catalog name and type
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type  | name           | asg_scopeid | targetFile                            | jsonpath        |
      | APPDBPOSTGRES | ID      | Default | Table | DynamicColumns |             | response/dynamoDB/actual/itemIds.json | $..has_Table.id |

  Scenario Outline: SC12#user retrieves the data of particular item for a catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                             | responseCode | inputJson       | inputFile                             | outPutFile                                  | outPutJson |
      | components/Default/item/Default.Table:::dynamic | 200          | $..has_Table.id | response/dynamoDB/actual/itemIds.json | response/dynamoDB/actual/tableMetadata.json |            |

  @sanity @positive @IDA-10.3
  Scenario Outline:SC12# Verify the DynamoDBCataloger scans and collects data if the collection contains dynamic columns
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                | actualValues                                 | valueType     | expectedJsonPath                                                  | actualJsonPath                                      |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData_SC19.json | response/dynamoDB/actual/facetWiseCount.json | intCompare    | $.MetaData..type_s..[?(@.value=='Column')].count                  | $.facetCounts..type_s..[?(@.value=='Column')].count |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData_SC19.json | response/dynamoDB/actual/tableMetadata.json  | stringCompare | $.MetaData.tableMetaData.table.values.[?(@.type=='Columns')].name | $..[?(@.caption=='Columns')].data.data..name        |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC12:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog7/% | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;       | Cluster  |       |       |



#6754637
  @sanity @positive @webtest @IDA-10.3
  Scenario:SC13#Verify the global Table should have the appropriate metadata information in IDC UI and Database
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/DynamoDBPayloads/PluginConfiguration/DynamoConfigSC19.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog8                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog8')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog8')].status |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC9DynamoTags" and clicks on search
    And user performs "facet selection" in "SC9DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "GlobalTable_2017" item from search results
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName  |
      | Last catalogued at | Lifecycle   |
      | Table Type         | Description |

#6754638
  @sanity @positive  @webtest @IDA-10.3
  Scenario:SC14#Verify the streaming attribute gets added in metadata attributes for global table "2017" column and should appear the same in IDC UI and Database
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC9DynamoTags" and clicks on search
    And user performs "facet selection" in "SC9DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "GlobalTable_2017" item from search results
    Then user performs click and verify in new window
      | Table   | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | aws:rep:deleting     | verify widget contains |                  |             |
      | Columns | aws:rep:updateregion | verify widget contains |                  |             |
      | Columns | aws:rep:updatetime   | verify widget contains |                  |             |
      | Columns | aws:rep:deleting     | click and switch tab   | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName  |
#      | Comments           | Description |
      | Data type          | Description |
      | Last catalogued at | Lifecycle   |
      | Length             | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value                | Action               | RetainPrevwindow | indexSwitch |
      | Columns | aws:rep:updateregion | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName  |
#      | Comments           | Description |
      | Data type          | Description |
      | Last catalogued at | Lifecycle   |
      | Length             | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value                | Action               | RetainPrevwindow | indexSwitch |
      | Columns | aws:rep:updateregion | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName  |
#      | Comments           | Description |
      | Data type          | Description |
      | Last catalogued at | Lifecycle   |
      | Length             | Statistics  |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC14:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog8/% | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;       | Cluster  |       |       |



##6754465#
  @sanity @positive @webtest @IDA-10.3
  Scenario:SC15#Verify DynamoDBCataloger collects only analysis and throws error message in log when incorrect Access key/Secret key is given.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBDataSource                               | ida/dynamoDBPayloads/DataSource/dydbInValidDataSourceConfig.json | 204           |                  |                                                     |
      |                  |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC20.json   | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                  | 200           |                  | DynamoCatalog9                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog9')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog9')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC10DynamoTags" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/DynamoDBCataloger/DynamoCatalog9%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of errors          | 3             | Description |
      | Number of processed items | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/DynamoDBCataloger/DynamoCatalog9%" should display below info/error/warning
      | type  | logValue                                            | logCode            |
      | ERROR | Error in connection Details - Invalid Credentials . | ANALYSIS-JDBC-0051 |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC15:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog9/% | Analysis |       |       |



   ##6754461#
  @sanity @positive @webtest @IDA-10.3
  Scenario:SC16#Verify  DynamoDBCataloger collects only analysis and throws error message in log when incorrect domain name is given.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                                     | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBDataSource                               | ida/dynamoDBPayloads/DataSource/dydbDataSourceIncorrectDomainConfig.json | 204           |                  |                                                      |
      |                  |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC22.json           | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                          | 200           |                  | DynamoCatalog11                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog11')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                          | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog11')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC12DynamoTags" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/DynamoDBCataloger/DynamoCatalog11%"
    And the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 2             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "cataloger/DynamoDBCataloger/DynamoCatalog11%" should display below info/error/warning
      | type  | logValue                                                    | logCode            |
      | ERROR | Invalid data source configuration name: DynamoInvalidDomain | ANALYSIS-JDBC-0037 |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC16:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog11/% | Analysis |       |       |





##6770210#
  @sanity @positive @IDA-10.3
  Scenario:SC17#Verify the DynamoDB Tables should have constraints window with Primary Key constraints(Only Primary key and No sort key) available.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                             |
      | application/json | raw   | false | Put          | settings/analyzers/DynamoDBDataSource                               | ida/dynamoDBPayloads/DataSource/dydbValidDataSourceConfig.json | 204           |                  |                                                      |
      |                  |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC23.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog12                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog12')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog12')].status |


  @sanity @positive @IDA-10.3
  Scenario Outline:SC17#_Validate DynamoDB Tables should have constraints window with Primary Key constraints(Only Primary key and No sort key) available.
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                   | response code | response message | filePath                                     | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | response/dynamoDB/body/getFacetsCountRequest_SC24.json | 200           |                  | response/dynamoDB/actual/facetWiseCount.json |          |


  Scenario Outline: SC17#user retrieves ID with catalog name and type
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type       | name                       | asg_scopeid | targetFile                            | jsonpath             |
      | APPDBPOSTGRES | ID      | Default | Constraint | TESTTABLEONLYPK_PRIMARYKEY |             | response/dynamoDB/actual/itemIds.json | $..has_Constraint.id |

  Scenario Outline: SC17#user retrieves the data of particular item for a catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                  | responseCode | inputJson            | inputFile                             | outPutFile                                       | outPutJson |
      | components/Default/item/Default.Constraint:::dynamic | 200          | $..has_Constraint.id | response/dynamoDB/actual/itemIds.json | response/dynamoDB/actual/constraintMetadata.json |            |


  @sanity @positive @IDA-10.3
  Scenario Outline:SC17#_Verify DynamoDB Tables should have constraints window with Primary Key constraints(Only Primary key and No sort key) available.
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                | actualValues                                     | valueType     | expectedJsonPath                                                       | actualJsonPath                                          |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData_SC24.json | response/dynamoDB/actual/facetWiseCount.json     | intCompare    | $.MetaData..type_s..[?(@.value=='Constraint')].count                   | $.facetCounts..type_s..[?(@.value=='Constraint')].count |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData_SC24.json | response/dynamoDB/actual/constraintMetadata.json | stringCompare | $.MetaData.constraintMetaData.table.values.[?(@.type=='Columns')].name | $..[?(@.caption=='columns')].data.data..name            |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData_SC24.json | response/dynamoDB/actual/constraintMetadata.json | stringCompare | $.MetaData.constraintMetaData.name                                     | $.caption.name                                          |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC17:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog12/% | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;        | Cluster  |       |       |


  ##6754466#
  @sanity @positive @webtest @IDA-10.3
  Scenario:SC18# Verify the relationships shows properly between the table and constraint under relationship tab
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                             |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC24.json | 204           |                  |                                                      |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog13                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog13')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog13')].status |

    ##  #6689699#
  Scenario Outline:SC18#:user get the Dynamic ID's (Source ID) for the constraint
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                  | type       | targetFile                                                | jsonpath                   |
      | APPDBPOSTGRES | Default | TESTTABLE1_PRIMARYKEY | Constraint | payloads\ida\dynamoDBPayloads\APIValidation\itemsIds.json | $.DynamicIDs.constraint.id |

  Scenario Outline:SC18#:user hits the Constraint ID and store it in a seperate file
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                                                                    | responseCode | inputJson                  | inputFile                                                 | outPutFile                                                    | outPutJson |
      | searches/Default/query/queryDiagramOutRecursive/Default.Constraint:::dynamic?what=id,type,name,catalog | 200          | $.DynamicIDs.constraint.id | payloads\ida\dynamoDBPayloads\APIValidation\itemsIds.json | payloads\ida\dynamoDBPayloads\APIValidation\relationship.json |            |

  Scenario Outline:SC18#:#Verify the DynamoDB Tables should have relationship data window with lineage created.
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                           | actualValues                                                  | valueType     | expectedJsonPath                                                       | actualJsonPath                |
      | response/dynamoDB/expected/dynamoDBExpectedJsonData.json | payloads\ida\dynamoDBPayloads\APIValidation\relationship.json | stringCompare | $.MetaData.constraintMetaData.table.values.[?(@.type=='Columns')].name | $..[?(@.type=='Column')].name |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC18:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                          | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog13/% | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;        | Cluster  |       |       |




##    #6770211#
##  @sanity @positive @MLP-8191 @webtest @IDA-10.3
##  Scenario:SC27#MLP_8191 Verification of Password encryption for DynamoDBCataloger
##    And Execute REST API with following parameters
##      | Header | Query | Param | type         | url                                                                 | body                                                | response code | response message | jsonPath                                             |
##      |        |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC25.json | 204           |                  |                                                      |
##      |        |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                     | 200           |                  | DynamoCatalog14                                      |
##      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                     | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog14')].status |
##      |        |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                     | 200           |                  |                                                      |
##      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                     | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog14')].status |
##    Given User launch browser and traverse to login page
##    When user enter credentials for "System Administrator1" role
##    And login must be successful for all users
##    And user enters the search text "DynamoCatalog14" and clicks on search
##    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
##    And user clicks on first item on the item list page
##    And user copy metadata value from Item View Page and write to file using below parameters
##      | attributeName  | Definition                           |
##      | actualFilePath | ida/DynamoDBPayloads/Definition.json |
##    Then user verify whether "password encrypted" for below parameters
##      | pluginName        | pluginConfigPassword | passwordFilePath                     | jsonpath    |
##      | DynamoDBCataloger | s3SecretKey          | ida/DynamoDBPayloads/Definition.json | $.secretkey |
##    And user makes a REST Call for DELETE request with url "/settings/catalogs/DynamoCatalog14"
##    Then Status code 204 must be returned
##    When user makes a REST Call for Get request with url "/settings/catalogs/DynamoCatalog14"
##    And response message contains value "CONFIG-0007"
##    And verify created schema "DynamoCatalog14" doesn't exists in database


  ###########Below cases Added by Vijay Dated: 14/Jan/2020############

  ##6930091##
  @webtest @positive @regression @IDA-10.3
  Scenario: SC19# Verify if all the mandatory fields (Name) are throwing with proper error message if they are left blank in DynamoDBDatasource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Manage Data Sources page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute          |
      | Data Source Type | DynamoDBDataSource |
    And user verifies "validation message" is displayed under the fields in "Manage Data Sources page" Popup
      | fieldName | validationMessage              |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Manage Data Sources page"


####6930097##
##  @17300 @webtest
##  Scenario: SC28#-Verify the DynamoDB Cataloger does not collect any items when an Invalid Datasource(with wrong Credentials) and Invalid Credentials are used in the Plugin Configuration
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator1" role
##    When user clicks on notification icon
##    When user clicks on mark all read button in the notifications tab
##    Then user clicks on exit button in notifications panel
##    And Execute REST API with following parameters
##      | Header           | Query | Param | type         | url                                                                    | body                                                             | response code | response message | jsonPath                                                            |
##      | application/json | raw   | false | Post         | settings/catalogs                                                      | ida/dynamoDBPayloads/catalogs/CreateDynamoCatalog.json           | 204           |                  |                                                                     |
##      |                  |       |       | Put          | settings/analyzers/DynamoDBCataloger                                   | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC26.json   | 204           |                  |                                                                     |
##      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                   |                                                                  | 200           |                  | DynamoCatalog15                                                     |
##      |                  |       |       | Put          | settings/analyzers/DynamoDBDataSource                                  | ida/dynamoDBPayloads/DataSource/dydbInValidDataSourceConfig.json | 204           |                  |                                                                     |
##      |                  |       |       | Get          | settings/analyzers/DynamoDBDataSource                                  |                                                                  | 200           |                  | dydbInValidDataSource                                               |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBInvalidDS')].status              |
##      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/DynamoDBDataSource/*  | ida/dynamoDBPayloads/TestData/empty.json                         | 200           |                  |                                                                     |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBInvalidDS')].status              |
##      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/*    |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalogInvalidCredential')].status |
##      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*     | ida/dynamoDBPayloads/TestData/empty.json                         | 200           |                  |                                                                     |
##      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/*    |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalogInvalidCredential')].status |
##    And user clicks on notification icon
##    And "Analysis started!" notification should have content "Analysis DynamoDBCataloger on LocalNode has started" in the notifications tab
##    And "Analysis failed!" notification should have content "Analysis DynamoDBCataloger on LocalNode has failed:" in the notifications tab
##    And "Analysis started!" notification should have content "Analysis DynamoDBDataSource on LocalNode has started" in the notifications tab
##    And "Analysis failed!" notification should have content "Analysis DynamoDBDataSource on LocalNode has failed:" in the notifications tab
##    Then user clicks on exit button in notifications panel
##    And user select "All" catalog and search "DynamoCatalog1" items at top end
##    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
##      | Analysis |
##    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
##    And user performs "dynamic item click" on "cataloger" item from search results
##    And user click on Analysis log link in DATA widget section
##    Then user "verify analysis log contains" presence of "No JDBC connection could be established" in Analysis Log of IDC UI
##    Then user "verify analysis log contains" presence of "Invalid credential configuration name: The security token included in the request is invalid." in Analysis Log of IDC UI
##    And user makes a REST Call for DELETE request with url "/settings/catalogs/DynamoCatalog1"
##    Then Status code 204 must be returned
##    And user clicks on logout button
##
##
##
##  ##6930098##
##  @17300 @webtest
##  Scenario: SC29#-Verify the DynamoDB Cataloger collects all items when an Invalid Datasource(with wrong Credentials) and Valid Credentials are used in the Plugin Configuration
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator1" role
##    When user clicks on notification icon
##    When user clicks on mark all read button in the notifications tab
##    Then user clicks on exit button in notifications panel
##    And Execute REST API with following parameters
##      | Header           | Query | Param | type         | url                                                                    | body                                                             | response code | response message | jsonPath                                               |
##      | application/json | raw   | false | Post         | settings/catalogs                                                      | ida/dynamoDBPayloads/catalogs/CreateDynamoCatalog.json           | 204           |                  |                                                        |
##      |                  |       |       | Put          | settings/analyzers/DynamoDBCataloger                                   | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC27.json   | 204           |                  |                                                        |
##      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                   |                                                                  | 200           |                  | DynamoCatalog1                                         |
##      |                  |       |       | Put          | settings/analyzers/DynamoDBDataSource                                  | ida/dynamoDBPayloads/DataSource/dydbInValidDataSourceConfig.json | 204           |                  |                                                        |
##      |                  |       |       | Get          | settings/analyzers/DynamoDBDataSource                                  |                                                                  | 200           |                  | DynamoDBInvalidDS                                      |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBInvalidDS')].status |
##      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/DynamoDBDataSource/*  | ida/dynamoDBPayloads/TestData/empty.json                         | 200           |                  |                                                        |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBInvalidDS')].status |
##      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/*    |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog27')].status   |
##      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*     | ida/dynamoDBPayloads/TestData/empty.json                         | 200           |                  |                                                        |
##      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/*    |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog27')].status   |
##    And user clicks on notification icon
##    And "Analysis started!" notification should have content "Analysis DynamoDBCataloger on LocalNode has started" in the notifications tab
##    And "Analysis succeeded!" notification should have content "Analysis DynamoDBCataloger on LocalNode has succeeded" in the notifications tab
##    And "Analysis started!" notification should have content "Analysis DynamoDBDataSource on LocalNode has started" in the notifications tab
##    And "Analysis failed!" notification should have content "Analysis DynamoDBDataSource on LocalNode has failed:" in the notifications tab
##    Then user clicks on exit button in notifications panel
##    And user select "All" catalog and search "DynamoCatalog1" items at top end
##    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
##      | Constraint |
##      | Table      |
##      | Database   |
##      | Column     |
##      | Analysis   |
##      | Cluster    |
##      | Service    |
##      | Host       |
##    And user makes a REST Call for DELETE request with url "/settings/catalogs/DynamoCatalog1"
##    Then Status code 204 must be returned
##    And user clicks on logout button
##
##
##  ##6930103##
##  @17300 @webtest
##  Scenario: SC30#-Verify the Analysis failed notification displayed in IDC UI when Datasource Plugin is Started with Empty Credentials in Datasource for DynamoDB
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator1" role
##    When user clicks on notification icon
##    When user clicks on mark all read button in the notifications tab
##    Then user clicks on exit button in notifications panel
##    Then Execute REST API with following parameters
##      | Header           | Query | Param | type         | url                                                                    | body                                                           | response code | response message | jsonPath                                             |
##      | application/json | raw   | false | Post         | settings/catalogs                                                      | ida/dynamoDBPayloads/catalogs/CreateDynamoCatalog.json         | 204           |                  |                                                      |
##      |                  |       |       | Put          | settings/analyzers/DynamoDBDataSource                                  | ida/dynamoDBPayloads/DataSource/dydbEmptyDataSourceConfig.json | 204           |                  |                                                      |
##      |                  |       |       | Get          | settings/analyzers/DynamoDBDataSource                                  |                                                                | 200           |                  | DynamoDBEmptyDS                                      |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBEmptyDS')].status |
##      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/DynamoDBDataSource/*  | ida/dynamoDBPayloads/TestData/empty.json                       | 200           |                  |                                                      |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBEmptyDS')].status |
##    When user clicks on notification icon
##    And "Analysis started!" notification should have content "Analysis DynamoDBDataSource on LocalNode has started" in the notifications tab
##    And "Analysis failed!" notification should have content "Analysis DynamoDBDataSource on LocalNode has failed:" in the notifications tab
##    And user makes a REST Call for DELETE request with url "/settings/catalogs/DynamoCatalog1"
##    Then Status code 204 must be returned
##    And user clicks on logout button
##
##
##  ##6930099##
##  @17300 @webtest
##  Scenario: SC31#-Verify the DynamoDB Cataloger does not collect any items when an Datasource(with Empty Credentials) and Empty Credentials are used in the Plugin Configuration
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator1" role
##    When user clicks on notification icon
##    When user clicks on mark all read button in the notifications tab
##    Then user clicks on exit button in notifications panel
##    And Execute REST API with following parameters
##      | Header           | Query | Param | type         | url                                                                    | body                                                           | response code | response message | jsonPath                                                           |
##      | application/json | raw   | false | Post         | settings/catalogs                                                      | ida/dynamoDBPayloads/catalogs/CreateDynamoCatalog.json         | 204           |                  |                                                                    |
##      |                  |       |       | Put          | settings/analyzers/DynamoDBCataloger                                   | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC28.json | 204           |                  |                                                                    |
##      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                   |                                                                | 200           |                  | DynamoCatalogEmptyCredentials                                      |
##      |                  |       |       | Put          | settings/analyzers/DynamoDBDataSource                                  | ida/dynamoDBPayloads/DataSource/dydbEmptyDataSourceConfig.json | 204           |                  |                                                                    |
##      |                  |       |       | Get          | settings/analyzers/DynamoDBDataSource                                  |                                                                | 200           |                  | DynamoDBEmptyDS                                                    |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBEmptyDS')].status               |
##      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/DynamoDBDataSource/*  | ida/dynamoDBPayloads/TestData/empty.json                       | 200           |                  |                                                                    |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBEmptyDS')].status               |
##      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/*    |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalogEmptyCredentials')].status |
##      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*     | ida/dynamoDBPayloads/TestData/empty.json                       | 200           |                  |                                                                    |
##      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/*    |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalogEmptyCredentials')].status |
##    And user clicks on notification icon
##    And "Analysis started!" notification should have content "Analysis DynamoDBCataloger on LocalNode has started" in the notifications tab
##    And "Analysis failed!" notification should have content "Analysis DynamoDBCataloger on LocalNode has failed:" in the notifications tab
##    And "Analysis started!" notification should have content "Analysis DynamoDBDataSource on LocalNode has started" in the notifications tab
##    And "Analysis failed!" notification should have content "Analysis DynamoDBDataSource on LocalNode has failed:" in the notifications tab
##    Then user clicks on exit button in notifications panel
##    And user select "All" catalog and search "DynamoCatalog1" items at top end
##    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
##      | Analysis |
##    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
##    And user performs "dynamic item click" on "cataloger" item from search results
##    And user click on Analysis log link in DATA widget section
##    Then user "verify analysis log contains" presence of "No JDBC connection could be established" in Analysis Log of IDC UI
##    Then user "verify analysis log contains" presence of "Invalid credential configuration name: An Access Key must be specified." in Analysis Log of IDC UI
##    And user makes a REST Call for DELETE request with url "/settings/catalogs/DynamoCatalog1"
##    Then Status code 204 must be returned
##    And user clicks on logout button
##
##
##  #6930100# MLP-17770 Bug raised##
##  @17300 @webtest
##  Scenario: SC32#-Verify the Analysis failed notification displayed in IDC UI when DynamoDB Datasource Plugin is Started with No Region(Region will be null in Json)
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator1" role
##    When user clicks on notification icon
##    When user clicks on mark all read button in the notifications tab
##    Then user clicks on exit button in notifications panel
##    Then Execute REST API with following parameters
##      | Header           | Query | Param | type         | url                                                                    | body                                                                           | response code | response message | jsonPath                                              |
##      | application/json | raw   | false | Post         | settings/catalogs                                                      | ida/dynamoDBPayloads/catalogs/CreateDynamoCatalog.json                         | 204           |                  |                                                       |
##      |                  |       |       | Put          | settings/analyzers/DynamoDBDataSource                                  | ida/dynamoDBPayloads/DataSource/dydbInvalidDataSourceWithNullRegionConfig.json | 204           |                  |                                                       |
##      |                  |       |       | Get          | settings/analyzers/DynamoDBDataSource                                  |                                                                                | 200           |                  | DynamoDBNoRegion                                      |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBNoRegion')].status |
##      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/DynamoDBDataSource/*  | ida/dynamoDBPayloads/TestData/empty.json                                       | 200           |                  |                                                       |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBNoRegion')].status |
##    When user clicks on notification icon
##    And "Analysis started!" notification should have content "Analysis DynamoDBDataSource on LocalNode has started" in the notifications tab
##    And "Analysis failed!" notification should have content "Analysis DynamoDBDataSource on LocalNode has failed:" in the notifications tab
##    And user makes a REST Call for DELETE request with url "/settings/catalogs/DynamoCatalog1"
##    Then Status code 204 must be returned
##    And user clicks on logout button
##
##
##
##  #6930100#MLP-17770 Bug raised##
##  @MLP-17300 @webtest
##  Scenario: SC33#-Verify the DynamoDB Cataloger does not collect any items when an Datasource(with No Region) and Valid Credentials are used in the Plugin Configuration
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator1" role
##    When user clicks on notification icon
##    When user clicks on mark all read button in the notifications tab
##    Then user clicks on exit button in notifications panel
##    And Execute REST API with following parameters
##      | Header           | Query | Param | type         | url                                                                    | body                                                                           | response code | response message | jsonPath                                                                     |
##      | application/json | raw   | false | Post         | settings/catalogs                                                      | ida/dynamoDBPayloads/catalogs/CreateDynamoCatalog.json                         | 204           |                  |                                                                              |
##      |                  |       |       | Put          | settings/analyzers/DynamoDBCataloger                                   | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC29.json                 | 204           |                  |                                                                              |
##      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                   |                                                                                | 200           |                  | DynamoCatalogDSNoRegionValidCredentials                                      |
##      |                  |       |       | Put          | settings/analyzers/DynamoDBDataSource                                  | ida/dynamoDBPayloads/DataSource/dydbInvalidDataSourceWithNullRegionConfig.json | 204           |                  |                                                                              |
##      |                  |       |       | Get          | settings/analyzers/DynamoDBDataSource                                  |                                                                                | 200           |                  | DynamoDBNoRegion                                                             |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBNoRegion')].status                        |
##      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/DynamoDBDataSource/*  | ida/dynamoDBPayloads/TestData/empty.json                                       | 200           |                  |                                                                              |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBNoRegion')].status                        |
##      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/*    |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalogDSNoRegionValidCredentials')].status |
##      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*     | ida/dynamoDBPayloads/TestData/empty.json                                       | 200           |                  |                                                                              |
##      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/*    |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalogDSNoRegionValidCredentials')].status |
##    And user clicks on notification icon
##    And "Analysis started!" notification should have content "Analysis DynamoDBCataloger on LocalNode has started" in the notifications tab
##    And "Analysis failed!" notification should have content "Analysis DynamoDBCataloger on LocalNode has failed:" in the notifications tab
##    And "Analysis started!" notification should have content "Analysis DynamoDBDataSource on LocalNode has started" in the notifications tab
##    And "Analysis failed!" notification should have content "Analysis DynamoDBDataSource on LocalNode has failed:" in the notifications tab
##    Then user clicks on exit button in notifications panel
##    And user select "All" catalog and search "DynamoCatalog1" items at top end
##    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
##      | Analysis |
##    And user performs "facet selection" in "Analysis" attribute under "Type" facets in Item Search results page
##    And user performs "dynamic item click" on "cataloger" item from search results
##    And user click on Analysis log link in DATA widget section
##    Then user "verify analysis log contains" presence of "Required attribute Region is blank" in Analysis Log of IDC UI
##    And user makes a REST Call for DELETE request with url "/settings/catalogs/DynamoCatalog1"
##    Then Status code 204 must be returned
##    And user clicks on logout button
##
##
##  ##6930090##
##  @17300 @webtest
##  Scenario: SC34#-Verify the Analysis failed notification displayed in IDC UI when Datasource Plugin is Started without Credentials in Datasource (Credentials will be null in Json)
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator1" role
##    When user clicks on notification icon
##    When user clicks on mark all read button in the notifications tab
##    Then user clicks on exit button in notifications panel
##    Then Execute REST API with following parameters
##      | Header           | Query | Param | type         | url                                                                    | body                                                                       | response code | response message | jsonPath                                                    |
##      | application/json | raw   | false | Post         | settings/catalogs                                                      | ida/dynamoDBPayloads/catalogs/CreateDynamoCatalog.json                     | 204           |                  |                                                             |
##      |                  |       |       | Put          | settings/analyzers/DynamoDBDataSource                                  | ida/dynamoDBPayloads/DataSource/dydbNullCredentialsInDataSourceConfig.json | 204           |                  |                                                             |
##      |                  |       |       | Get          | settings/analyzers/DynamoDBDataSource                                  |                                                                            | 200           |                  | DynamoDBNullCredential                                      |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBNullCredential')].status |
##      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/DynamoDBDataSource/*  | ida/dynamoDBPayloads/TestData/empty.json                                   | 200           |                  |                                                             |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBNullCredential')].status |
##    When user clicks on notification icon
##    And "Analysis started!" notification should have content "Analysis DynamoDBDataSource on LocalNode has started" in the notifications tab
##    And "Analysis failed!" notification should have content "Analysis DynamoDBDataSource on LocalNode has failed:" in the notifications tab
##    And user makes a REST Call for DELETE request with url "/settings/catalogs/DynamoCatalog1"
##    Then Status code 204 must be returned
##    And user clicks on logout button


  ##6930102##
  @17300 @webtest
  Scenario:SC20#-Verify the DynamoDB Cataloger does not collect any items when Datasource null and Credential value invalid in Json
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                   | body                                                           | response code | response message | jsonPath                                                 |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                                  | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC30.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                                  |                                                                | 200           |                  | DynamoCatalogDSNull                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/DynamoCatalogDSNull |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalogDSNull')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/DynamoCatalogDSNull  | ida/dynamoDBPayloads/TestData/empty.json                       | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/DynamoCatalogDSNull |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalogDSNull')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC20DynamoTags" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/DynamoDBCataloger/DynamoCatalogDSNull%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/DynamoDBCataloger/DynamoCatalogDSNull%" should display below info/error/warning
      | type  | logValue                                     | logCode            |
      | ERROR | Invalid data source configuration name: null | ANALYSIS-JDBC-0037 |
    And Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                                           | body                                                           | response code | response message | jsonPath                                                         |
      |        |       |       | Put          | settings/analyzers/DynamoDBDataSource                                                         | ida/dynamoDBPayloads/DataSource/dydbValidDataSourceConfig.json | 204           |                  |                                                                  |
      |        |       |       | Get          | settings/analyzers/DynamoDBDataSource                                                         |                                                                | 200           |                  | DynamoValidDS                                                    |
      |        |       |       | Put          | settings/analyzers/DynamoDBCataloger                                                          | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC31.json | 204           |                  |                                                                  |
      |        |       |       | Get          | settings/analyzers/DynamoDBCataloger                                                          |                                                                | 200           |                  | DynamoCatalogCredentialNull                                      |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/DynamoCatalogCredentialNull |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalogCredentialNull')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/DynamoCatalogCredentialNull  | ida/dynamoDBPayloads/TestData/empty.json                       | 200           |                  |                                                                  |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/DynamoCatalogCredentialNull |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalogCredentialNull')].status |
    And user enters the search text "SC21DynamoTags" and clicks on search
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Analysis |
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/DynamoDBCataloger/DynamoCatalogCredentialNull%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/DynamoDBCataloger/DynamoCatalogCredentialNull%" should display below info/error/warning
      | type  | logValue                                            | logLine            |
      | ERROR | Error in connection Details - Invalid Credentials . | ANALYSIS-JDBC-0051 |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC20:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                      | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalogCredentialNull/% | Analysis |       |       |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalogDSNull/%         | Analysis |       |       |






##    ##6930096##
##  @MLP-17300 @webtest
##  Scenario: SC36#-Verify the Analysis succeeded notification displayed in IDC UI when the analysis plugin executed without any errors - Valid DynamoDBDataSource
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator1" role
##    When user clicks on notification icon
##    When user clicks on mark all read button in the notifications tab
##    Then user clicks on exit button in notifications panel
##    And Execute REST API with following parameters
##      | Header           | Query | Param | type         | url                                                                    | body                                                           | response code | response message | jsonPath                                           |
##      | application/json | raw   | false | Post         | settings/catalogs                                                      | ida/dynamoDBPayloads/catalogs/CreateDynamoCatalog.json         | 204           |                  |                                                    |
##      |                  |       |       | Put          | settings/analyzers/DynamoDBDataSource                                  | ida/dynamoDBPayloads/DataSource/dydbValidDataSourceConfig.json | 204           |                  |                                                    |
##      |                  |       |       | Get          | settings/analyzers/DynamoDBDataSource                                  |                                                                | 200           |                  | DynamoValidDS                                      |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoValidDS')].status |
##      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/DynamoDBDataSource/*  | ida/s3AvroPayloads/empty.json                                  | 200           |                  |                                                    |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoValidDS')].status |
##    When user clicks on notification icon
##    And "Analysis started!" notification should have content "Analysis DynamoDBDataSource on LocalNode has started" in the notifications tab
##    And "Analysis succeeded!" notification should have content "Analysis DynamoDBDataSource on LocalNode has succeeded" in the notifications tab
##    And user makes a REST Call for DELETE request with url "/settings/catalogs/DynamoCatalog1"
##    Then Status code 204 must be returned
##    And user clicks on logout button
##
##
####6930095##
##  @MLP-17300 @webtest
##  Scenario: SC37#-Verify the Analysis failed notification event displayed in IDC UI when user gives invalid Secret and Access Key for DynamoDBDataSource plugin
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator1" role
##    When user clicks on notification icon
##    When user clicks on mark all read button in the notifications tab
##    Then user clicks on exit button in notifications panel
##    Then Execute REST API with following parameters
##      | Header           | Query | Param | type         | url                                                                    | body                                                             | response code | response message | jsonPath                                               |
##      | application/json | raw   | false | Post         | settings/catalogs                                                      | ida/dynamoDBPayloads/catalogs/CreateDynamoCatalog.json           | 204           |                  |                                                        |
##      |                  |       |       | Put          | settings/analyzers/DynamoDBDataSource                                  | ida/dynamoDBPayloads/DataSource/dydbInValidDataSourceConfig.json | 204           |                  |                                                        |
##      |                  |       |       | Get          | settings/analyzers/DynamoDBDataSource                                  |                                                                  | 200           |                  | DynamoDBInvalidDS                                      |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBInvalidDS')].status |
##      |                  |       |       | Post         | /extensions/analyzers/start/LocalNode/datasource/DynamoDBDataSource/*  | ida/dynamoDBPayloads/empty.json                                  | 200           |                  |                                                        |
##      |                  |       |       | RecursiveGet | /extensions/analyzers/status/LocalNode/datasource/DynamoDBDataSource/* |                                                                  | 200           | IDLE             | $.[?(@.configurationName=='DynamoDBInvalidDS')].status |
##    When user clicks on notification icon
##    And "Analysis started!" notification should have content "Analysis DynamoDBDataSource on LocalNode has started" in the notifications tab
##    And "Analysis failed!" notification should have content "Analysis DynamoDBDataSource on LocalNode has failed:" in the notifications tab
##    And user makes a REST Call for DELETE request with url "/settings/catalogs/DynamoCatalog1"
##    Then Status code 204 must be returned
##    And user clicks on logout button



  @sanity @positive @IDA-10.3 @webtest
  Scenario:SC21#Verify the DynamoDBCataloger with dryrun as true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                            |
      | application/json | raw   | false | Put          | settings/analyzers/DynamoDBDataSource                               | ida/dynamoDBPayloads/DataSource/dydbValidDataSourceConfig.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/DynamoDBDataSource                               |                                                                | 200           |                  | dydbValidDataSource                                 |
      |                  |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC32.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog1                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog1')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog1')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC22DynamoTags" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/DynamoDBCataloger/DynamoCatalog1%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/DynamoDBCataloger/DynamoCatalog1%" should display below info/error/warning
      | type | logValue                                                                                     | logCode       | pluginName | removableText |
      | INFO | Plugin DynamoDBCataloger running on dry run mode                                             | ANALYSIS-0069 |            |               |
      | INFO | Plugin DynamoDBCataloger processed 2 items on dry run mode and not written to the repository | ANALYSIS-0070 |            |               |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC21:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                         | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog1/% | Analysis |       |       |



  ##22837 - Explicit tags & BA Tags
  ################################################Analyzer scenario#####################################################################

  @sanity
  Scenario: SC22#-Set the DynamoDB Datasources
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                   | body                                                           | response code | response message | jsonPath            |
      | application/json | raw   | false | Put  | settings/analyzers/DynamoDBDataSource | ida/dynamoDBPayloads/DataSource/dydbValidDataSourceConfig.json | 204           |                  |                     |
      |                  |       |       | Get  | settings/analyzers/DynamoDBDataSource |                                                                | 200           |                  | dydbValidDataSource |

#7077246
  @sanity @positive @IDA-1.1.0
  Scenario:SC22#Run DynamoDB cataloger for DryRun and No Filter scnario with respect to Dynamo DB Analyzer
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC33.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog1                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog1')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog1')].status |

    #bug id -MLP-24578
#7077246
  @sanity @positive @IDA-1.1.0 @webtest
  Scenario:SC22#Run the Analyzer with Dryn Run as true for Dynamo DBAnalyzer
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                    | body                                                          | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                    | ida/dynamoDBPayloads/PluginConfiguration/DryRun_Anlayzer.json | 204           |                  |                                                         |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                    |                                                               | 200           |                  | DryRun_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/DryRun_DDBAnalyzer |                                                               | 200           | IDLE             | $.[?(@.configurationName=='DryRun_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/DryRun_DDBAnalyzer  |                                                               | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/DryRun_DDBAnalyzer |                                                               | 200           | IDLE             | $.[?(@.configurationName=='DryRun_DDBAnalyzer')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "DryRun_Anlayzer" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/DynamoDBAnalyzer/DryRun_DDBAnalyzer/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/DynamoDBCataloger/DynamoCatalog1%" should display below info/error/warning
      | type | logValue                                                                                    | logCode       | pluginName | removableText |
      | INFO | Plugin DynamoDBAnalyzer running on dry run mode                                             | ANALYSIS-0069 |            |               |
      | INFO | Plugin DynamoDBAnalyzer processed 1 items on dry run mode and not written to the repository | ANALYSIS-0070 |            |               |

  @MLP-21662 @sanity @positive
  Scenario:SC22:Delete Analyzer analysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                               | type     | query | param |
      | SingleItemDelete | Default | dataanalyzer/DynamoDBAnalyzer/DryRun_DDBAnalyzer/% | Analysis |       |       |

#7066431
  @sanity @positive @IDA-1.1.0
  Scenario:SC23#Run the Analyzer with Non-Existing tables in filter option
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                         | body                                                                           | response code | response message | jsonPath                                                     |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                         | ida/dynamoDBPayloads/PluginConfiguration/Non-ExistingTableFilter_Anlayzer.json | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                         |                                                                                | 200           |                  | NonExisting_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NonExisting_DDBAnalyzer |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='NonExisting_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NonExisting_DDBAnalyzer  |                                                                                | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NonExisting_DDBAnalyzer |                                                                                | 200           | IDLE             | $.[?(@.configurationName=='NonExisting_DDBAnalyzer')].status |

#7066431, global tables need to be completed
  @positve @regression @sanity @webtest  @IDA-1.1.0
  Scenario:SC23#Verify the Analyzer does not create the mentioned field for all the tables
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1DynamoTags" and clicks on search
    And user performs "facet selection" in "SC1DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "DynamicColumns [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "Book Title" item from search results
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute         | widgetName |
      | Number of non null values | Statistics |
      | Maximum Value             | Statistics |
      | Minimum Value             | Statistics |
      | Standard deviation        | Statistics |
      | Variance                  | Statistics |
      | Last Analyzed At          | Lifecycle  |
    And user enters the search text "SC1DynamoTags" and clicks on search
    And user performs "facet selection" in "SC1DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "AllDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "Book BS" item from search results
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute         | widgetName |
      | Number of non null values | Statistics |
      | Maximum Value             | Statistics |
      | Minimum Value             | Statistics |
      | Standard deviation        | Statistics |
      | Variance                  | Statistics |
      | Last Analyzed At          | Lifecycle  |
    And user enters the search text "SC1DynamoTags" and clicks on search
    And user performs "facet selection" in "SC1DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TestTableOnlyPK [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "Name" item from search results
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute         | widgetName |
      | Number of non null values | Statistics |
      | Maximum Value             | Statistics |
      | Minimum Value             | Statistics |
      | Standard deviation        | Statistics |
      | Variance                  | Statistics |
      | Last Analyzed At          | Lifecycle  |

#7070408
  @positve @regression @sanity @webtest @IDA-1.1.0
  Scenario:SC24#Verify proper error message is thrown in UI if Sample Data count/Top Values/Histogram Buckets values are not provided within valid range in DynamoDBAnalyzer
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem            |
      | click      | Settings Icon         |
      | click      | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute        |
      | Type      | Dataanalyzer     |
      | Plugin    | DynamoDBAnalyzer |
    And user "Click" on "Show Advanced Settings" in Plugin Configuration panel in Plugin manger
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Sample data count     | 9                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                            |
      | Sample data count | Value of Sample data count should not be lesser than 10 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            | 4                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName  | errorMessage                                    |
      | Top values | Value of Top values should not be lesser than 5 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Top values            | 31                     |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName  | errorMessage                                      |
      | Top values | Value of Top values should not be greater than 30 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     | 4                      |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                           |
      | Histogram buckets | Value of Histogram buckets should not be lesser than 5 |
    And user enters the following values in Plugin Configuration fields
      | pluginConfigFieldName | pluginConfigFieldValue |
      | Histogram buckets     | 21                     |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName         | errorMessage                                             |
      | Histogram buckets | Value of Histogram buckets should not be greater than 20 |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"

    #7063964
  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC25#Verify whether all the tables are analyzed with no filter provided in DynamoDB Analyzer
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                            | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/NoFilter_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                 | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                 | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

#   #7077246
#  @MLP-17108 @sanity @positive
#  Scenario:SC26:Parsing the repository and validating the DynamoDB Analyzer Log
#    Then Analysis log "dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/%" should display below info/error/warning
#      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | logCode                            | pluginName       | removableText  |
#      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | ANALYSIS-0019                      |                  |                |
#      | INFO | Plugin Name:DynamoDBAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:dcfdbc3264ed, Plugin Configuration name:NoFilter_DDBAnalyzer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0071                      | DynamoDBAnalyzer | Plugin Version |
#      | INFO | Plugin DynamoDBAnalyzer Configuration: ---  2020-09-23 02:56:08.445 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: name: "NoFilter_DDBAnalyzer"  2020-09-23 02:56:08.445 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: pluginVersion: "LATEST"  2020-09-23 02:56:08.445 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: label:  2020-09-23 02:56:08.445 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: : ""  2020-09-23 02:56:08.445 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: catalogName: "Default"  2020-09-23 02:56:08.445 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: eventClass: null  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: eventCondition: null  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: nodeCondition: "name==\"LocalNode\""  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: maxWorkSize: 100  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: tags:  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: - "NoFilter"  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: pluginType: "dataanalyzer"  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: dataSource: null  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: credential: null  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: businessApplicationName: "DYNAMODB_BA"  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: dryRun: false  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: schedule: null  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: filter: null  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: histogramBuckets: 10  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: tables:  2020-09-23 02:56:08.454 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: - table: "GlobalTable2019"  2020-09-23 02:56:08.455 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: - table: "GlobalTable_2017"  2020-09-23 02:56:08.455 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: - table: "DynamicColumns"  2020-09-23 02:56:08.455 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: - table: "CatalogTable"  2020-09-23 02:56:08.455 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: - table: "TestTable1"  2020-09-23 02:56:08.455 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: pluginName: "DynamoDBAnalyzer"  2020-09-23 02:56:08.455 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: queryBatchSize: 100  2020-09-23 02:56:08.455 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: sampleDataCount: 25  2020-09-23 02:56:08.455 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: type: "Dataanalyzer"  2020-09-23 02:56:08.455 INFO  - ANALYSIS-0073: Plugin DynamoDBAnalyzer Configuration: topValues: 10 | ANALYSIS-0073                      | DynamoDBAnalyzer |                |
#      | INFO | Amazon DynamoDB Analyzer finished .                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-AMAZON-DYNAMODB-JDBC-0012 |                  |                |
#      | INFO | Plugin DynamoDBAnalyzer Start Time:2020-05-26 12:14:42.010, End Time:2020-05-26 12:16:02.187, Processed Count:2, Errors:0, Warnings:1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0072                      | DynamoDBAnalyzer |                |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:40.205)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | ANALYSIS-0020                      |                  |                |


   ##7074789#
  @positve @regression @sanity @webtest @IDA-1.1.0
  Scenario:SC27#MLP_21662_Verify the Technology tag appears properly for items collected by DynamoDBCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "NoFilter" and clicks on search
    And user performs "facet selection" in "NoFilter" attribute under "Tags" facets in Item Search results page
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                          | fileName                               | userTag  |
      | Default     | Column     | Metadata Type | Dynamo DB,SC1DynamoTags,DYNAMODB_BA,NoFilter | BicycleType                            | NoFilter |
      | Default     | Table      | Metadata Type | Dynamo DB,SC1DynamoTags,DYNAMODB_BA,NoFilter | TestTable1                             | NoFilter |
      | Default     | Cluster    | Metadata Type | Dynamo DB,SC1DynamoTags,DYNAMODB_BA,NoFilter | Domain=amazonaws.com;Region=us-east-1; | NoFilter |
      | Default     | Service    | Metadata Type | Dynamo DB,SC1DynamoTags,DYNAMODB_BA,NoFilter | DYNAMODB                               | NoFilter |
      | Default     | Constraint | Metadata Type | Dynamo DB,SC1DynamoTags,DYNAMODB_BA,NoFilter | TESTTABLE1_PRIMARYKEY                  | NoFilter |
    And user enters the search text "DYNAMODB" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Dynamo DB,SC1DynamoTags,DYNAMODB_BA,NoFilter" should get displayed for the column "DYNAMODB"
    Then the following tags "Dynamo DB,SC1DynamoTags,DYNAMODB_BA,NoFilter" should get displayed for the column "Domain=amazonaws.com;Region=us-east-1;"

##7064005
  @positve @regression @sanity @webtest @IDA-1.1.0
  Scenario:SC28#Verify the complex types are displayes as seperate columns in IDC UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1DynamoTags" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CatalogTable" item from search results
    Then user performs click and verify in new window
      | Table   | value          | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | Id             | verify widget contains |                  |             |
      | Columns | ModelBinarySet | verify widget contains |                  |             |
      | Columns | ModelList      | verify widget contains |                  |             |
      | Columns | ModelNumberSet | verify widget contains |                  |             |
      | Columns | ModelMap       | verify widget contains |                  |             |
      | Columns | ModelStringSet | verify widget contains |                  |             |
      | Columns | Name           | verify widget contains |                  |             |
      | Columns | Price          | verify widget contains |                  |             |
      | Columns | Valid          | verify widget contains |                  |             |
      | Columns | Book Title     | verify widget contains |                  |             |
      | Columns | CodeBinary     | verify widget contains |                  |             |
      | Columns | Description    | verify widget contains |                  |             |

    #7126908#7126909#7126906
  @webtest
  Scenario: SC#29#Verify that "Length & Last analyzed at" field from STATISTICS and LIFECYCLE section is removed for all the complex datatypes
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Dynamo DB" and clicks on search
    And user performs "facet selection" in "Dynamo DB" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "AllDataTypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AllDataTypes" item from search results
    Then user performs click and verify in new window
      | Table   | value   | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book BS | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value   | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book NS | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book NULL | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value   | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book SS | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | BookAuthor | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Color | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value         | Action               | RetainPrevwindow | indexSwitch |
      | Columns | ItemsOnMyDesk | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |


  #7064002#Bug-24862
  @positve @regression @sanity @webtest @IDA-1.1.0
  Scenario:SC030#Verify the data profiling metadata information for string datatype for the table "GlobalTable2017" when Analyzed with NO Filter by DynamoDBAnalyzer
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SC1DynamoTags" and clicks on search
    And user performs "facet selection" in "SC1DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "GlobalTable_2017" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | EName | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
#      | Comments                      | The primary key column EName. | Description |
      | Length                        | 255           | Statistics  |
      | Maximum length                | 11            | Statistics  |
      | Maximum value                 | Siddharthan   | Statistics  |
      | Minimum length                | 6             | Statistics  |
      | Minimum value                 | Harsha        | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | EmpId | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
#      | Comments                      | The primary key column EmpId. | Description |
      | Average                       | 123.5         | Statistics  |
      | Length                        | 22            | Statistics  |
      | Maximum value                 | 124           | Statistics  |
      | Median                        | 123.5         | Statistics  |
      | Minimum value                 | 123           | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Standard deviation            | 0.71          | Statistics  |
      | Variance                      | 0.5           | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |



  #7064000#Bug-24862
  @positve @regression @sanity @webtest @IDA-1.1.0
  Scenario:SC031#Verify the data profiling metadata information for string datatype for the table "GlobalTable2019" when Analyzed with NO Filter by DynamoDBAnalyzer
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SC1DynamoTags" and clicks on search
    And user performs "facet selection" in "SC1DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "GlobalTable2019" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | EName | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
#      | Comments                      | The primary key column EName. | Description |
      | Length                        | 255           | Statistics  |
      | Maximum length                | 6             | Statistics  |
      | Maximum value                 | Johny         | Statistics  |
      | Minimum length                | 5             | Statistics  |
      | Minimum value                 | Harsha        | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Id    | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
#      | Comments                      | The primary key column Id. | Description |
      | Average                       | 234           | Statistics  |
      | Length                        | 22            | Statistics  |
      | Maximum value                 | 345           | Statistics  |
      | Median                        | 234           | Statistics  |
      | Minimum value                 | 123           | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Standard deviation            | 156.98        | Statistics  |
      | Variance                      | 24642         | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user "section presence" on "Data Distribution" in Item view page
    And user "widget presence" on "Most frequent values" in Item view page

  #7063996#7126907#Bug-24862
  @positve @regression @sanity @webtest @IDA-1.1.0
  Scenario:SC32#Verify the data profiling metadata information for string datatype for the table "AllDataTypes" when Analyzed with NO Filter by DynamoDBAnalyzer
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SC1DynamoTags" and clicks on search
    And user performs "facet selection" in "SC1DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "AllDataTypes" item from search results
    Then user performs click and verify in new window
      | Table   | value   | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Book BS | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | SET           | Description |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Id    | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
#      | Comments                      | The primary key column Id. | Description |
      | Average                       | 250           | Statistics  |
      | Length                        | 22            | Statistics  |
      | Maximum value                 | 300           | Statistics  |
      | Median                        | 250           | Statistics  |
      | Minimum value                 | 200           | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Standard deviation            | 70.71         | Statistics  |
      | Variance                      | 5000          | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |

  Scenario: SC#32 MLP_7662_Verify the metadata properties of the collected items post anlayzer run
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                       | jsonPath                     | Action                    | query                    | ClusterName                            | ServiceName | DatabaseName | TableName/Filename | columnName/FieldName |
      | Statistics  | ida/dynamoDBPayloads/API/expectedMetadata.json | $.bigintdataStat.Statistics  | metadataValuePresence     | ColumnQuerywithoutSchema | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | AllDataTypes       | Id                   |
      | Description | ida/dynamoDBPayloads/API/expectedMetadata.json | $.bigintdataStat.Description | metadataValuePresence     | ColumnQuerywithoutSchema | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | AllDataTypes       | Id                   |
      | Lifecycle   | ida/dynamoDBPayloads/API/expectedMetadata.json | $.bigintdataStat.Lifecycle   | metadataAttributePresence | ColumnQuerywithoutSchema | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | AllDataTypes       | Id                   |
      | Statistics  | ida/dynamoDBPayloads/API/expectedMetadata.json | $.Book_Title.Statistics      | metadataValuePresence     | ColumnQuerywithoutSchema | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | AllDataTypes       | Book Title           |
      | Description | ida/dynamoDBPayloads/API/expectedMetadata.json | $.Book_Title.Description     | metadataValuePresence     | ColumnQuerywithoutSchema | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | AllDataTypes       | Book Title           |
      | Lifecycle   | ida/dynamoDBPayloads/API/expectedMetadata.json | $.Book_Title.Lifecycle       | metadataAttributePresence | ColumnQuerywithoutSchema | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | AllDataTypes       | Book Title           |

      #7063964,7064004,7126910
  Scenario Outline:SC33#:user get the Dynamic ID's (Database ID) for the Keyspaces "DYNAMODB" and table "GlobalTable_2017"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type     | name     | asg_scopeid     | targetFile                                   | jsonpath                             |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | DYNAMODB | AllDataTypes    | payloads/ida/dynamoDBPayloads/API/items.json | $.Database.us-east-1.AllDataTypes    |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | DYNAMODB | GlobalTable2019 | payloads/ida/dynamoDBPayloads/API/items.json | $.Database.us-east-1.GlobalTable2019 |

  Scenario Outline: SC33#:user hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                            | inputFile                                    | outPutFile                                                                    | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.us-east-1.AllDataTypes    | payloads/ida/dynamoDBPayloads/API/items.json | payloads\ida\dynamoDBPayloads\API\Actual\AllDataTypes\AllDataTypes.json       |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.us-east-1.GlobalTable2019 | payloads/ida/dynamoDBPayloads/API/items.json | payloads\ida\dynamoDBPayloads\API\Actual\GlobalTable2019\GlobalTable2019.json |            |

  Scenario: SC#33_verify whether multiple keyspace including empty and table filters within same keyspace should be repeated in filter cataloger configuration
    And user "update" the json file "ida\dynamoDBPayloads\API\Actual\AllDataTypes\AllDataTypes.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[3]  |            | Array |
      | $..sample.values[0].[10] |            | Array |
      | $..sample.values[1].[3]  |            | Array |
      | $..sample.values[1].[10] |            | Array |

  Scenario: SC#33_Verify the data sampling information for Dynamo DB table
    Then file content in "ida\dynamoDBPayloads\API\Actual\AllDataTypes\AllDataTypes.json" should be same as the content in "ida\dynamoDBPayloads\API\Expected\AllDataTypes\AllDataTypes.json"

  Scenario: SC#33_1_Verify the data sampling information for Dynamo DB table
    Then file content in "ida\dynamoDBPayloads\API\Actual\GlobalTable2019\GlobalTable2019.json" should be same as the content in "ida\dynamoDBPayloads\API\Expected\GlobalTable2019\GlobalTable2019.json"

#  Scenario:SC33#MLP_21662_Verify the data sampling information for Dynamo DB table
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "SC1DynamoTags" and clicks on search
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "AllDataTypes" item from search results
#    And user "navigatesToTab" name "Data Sample" in item view page
#    Then following "Data Sample" values should get displayed in item view page
#      | Book NS             | Id    | In Publication | ItemsOnMyDesk                          | Book Title | Book NULL | Color                          | Book SS                    | Book BS                            | Book Binary | Book Datewithtimestamp    | Book double | Book Float | Book long   | BookAuthor                                | Book Blank |
#      | [3.14,42.2,-19,7.5] | 200.0 | true           | [{"S":"Coffee Cup"},{"S":"Telephone"}] | Mountain A |           | [{"S":"Red"},{"S":"Black"}]    | ["Black","Green","Red"]    | ["UmFpbnk=","U25vd3k=","U3Vubnk="] | UNSUPPORTED | 2010-12-21T17:42:34+00:00 | 34.5        | 2.0000009  | 1.234567891 | {"Age":{"N":"35"},"Name":{"S":"Joe"}}     |            |
#      | [3.14,-19,7.5,72.2] | 300.0 | true           | [{"S":"Coffee Cup"},{"S":"Telephone"}] | Mountain B |           | [{"S":"Orange"},{"S":"Green"}] | ["Blue","Orange","Yellow"] | ["UmFpbnk=","U25vd3k=","U3Vubnk="] | UNSUPPORTED | 2010-12-20T17:42:34+00:00 | 45.5        | 2.0000009  | 1.234567891 | {"Age":{"N":"35"},"Name":{"S":"micheal"}} |            |
#    And user enters the search text "SC1DynamoTags" and clicks on search
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "GlobalTable2019" item from search results
#    And user "navigatesToTab" name "Data Sample" in item view page
#    Then following "Data Sample" values should get displayed in item view page
#      | Department | EName  | Id  | Project  |
#      | IT         | Harsha | 123 | project1 |
#      | Finance    | Johny  | 345 | project2 |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC33:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type     | query | param |
      | MultipleIDDelete | Default | dataanalyzer/DynamoDBAnalyzer/%        | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/DynamoDBCataloger/%          | Analysis |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster  |       |       |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC34#Run DynamoDBCataloger for withFilter Analyzer scenario
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                          | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC1.json | 204           |                  |                                                     |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                               | 200           |                  | DynamoCatalog1                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                               | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog1')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                               | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                               | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog1')].status |

    #7063964
  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC34#Verify whether all the tables are analyzed with filter provided in DynamoDB Analyzer
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                        | body                                                              | response code | response message | jsonPath                                                    |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                        | ida/dynamoDBPayloads/PluginConfiguration/WithFilter_Anlayzer.json | 204           |                  |                                                             |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                        |                                                                   | 200           |                  | WithFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/WithFilter_DDBAnalyzer |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='WithFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/WithFilter_DDBAnalyzer  |                                                                   | 200           |                  |                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/WithFilter_DDBAnalyzer |                                                                   | 200           | IDLE             | $.[?(@.configurationName=='WithFilter_DDBAnalyzer')].status |


  @positve @regression @sanity @webtest @IDA-1.1.0
  Scenario:SC34#Verify the Analyzer does not create the mentioned field for the table "TestTableOnlyPK"
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1DynamoTags" and clicks on search
    And user performs "facet selection" in "SC1DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TestTableOnlyPK [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "Name" item from search results
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute         | widgetName |
      | Number of non null values | Statistics |
      | Maximum Value             | Statistics |
      | Minimum Value             | Statistics |
      | Standard deviation        | Statistics |
      | Variance                  | Statistics |
      | Last Analyzed At          | Lifecycle  |

#        #7063998
#  @positve @regression @sanity @webtest  @MLP-21662 @IDA-1.1.0
#  Scenario:SC35#MLP_21662_Verify the data sampling information for Dynamo DB table when analyzed with filter condition
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "SC1DynamoTags" and clicks on search
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "AllDataTypes" item from search results
#    And user "navigatesToTab" name "Data Sample" in item view page
#    Then following "Data Sample" values should get displayed in item view page
#      | Book NS             | Id    | In Publication | ItemsOnMyDesk                          | Book Title | Book NULL | Color                          | Book SS                    | Book BS                            | Book Binary | Book Datewithtimestamp    | Book double | Book Float | Book long    | BookAuthor                                | Book Blank |
#      | [3.14,42.2,-19,7.5] | 200.0 | true           | [{"S":"Coffee Cup"},{"S":"Telephone"}] | Mountain A |           | [{"S":"Red"},{"S":"Black"}]    | ["Black","Green","Red"]    | ["UmFpbnk=","U25vd3k=","U3Vubnk="] | UNSUPPORTED | 2010-12-21T17:42:34+00:00 | 34.5        | 2.0000009  | 1.23456789E8 | {"Age":{"N":"35"},"Name":{"S":"Joe"}}     |            |
#      | [3.14,-19,7.5,72.2] | 300.0 | true           | [{"S":"Coffee Cup"},{"S":"Telephone"}] | Mountain B |           | [{"S":"Orange"},{"S":"Green"}] | ["Blue","Orange","Yellow"] | ["UmFpbnk=","U25vd3k=","U3Vubnk="] | UNSUPPORTED | 2010-12-20T17:42:34+00:00 | 45.5        | 2.0000009  | 1.23456789E9 | {"Age":{"N":"35"},"Name":{"S":"micheal"}} |            |
#    And user enters the search text "SC1DynamoTags" and clicks on search
#    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "GlobalTable2019" item from search results
#    And user "navigatesToTab" name "Data Sample" in item view page
#    Then following "Data Sample" values should get displayed in item view page
#      | Department | EName  | Id  | Project  |
#      | IT         | Harsha | 123 | project1 |
#      | Finance    | Johny  | 345 | project2 |


  Scenario Outline:SC35:user get the Dynamic ID's (Database ID) for the Keyspaces "DYNAMODB" and table "GlobalTable_2017"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type     | name     | asg_scopeid      | targetFile                                   | jsonpath                              |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | DYNAMODB | GlobalTable_2017 | payloads/ida/dynamoDBPayloads/API/items.json | $.Database.us-east-1.GlobalTable_2017 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | DYNAMODB | AllDataTypes     | payloads/ida/dynamoDBPayloads/API/items.json | $.Database.us-east-1.AllDataTypes     |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | DYNAMODB | GlobalTable2019  | payloads/ida/dynamoDBPayloads/API/items.json | $.Database.us-east-1.GlobalTable2019  |

  Scenario Outline: SC35:user hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                             | inputFile                                    | outPutFile                                                                      | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.us-east-1.GlobalTable_2017 | payloads/ida/dynamoDBPayloads/API/items.json | payloads\ida\dynamoDBPayloads\API\Actual\GlobalTable_2017\GlobalTable_2017.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.us-east-1.AllDataTypes     | payloads/ida/dynamoDBPayloads/API/items.json | payloads\ida\dynamoDBPayloads\API\Actual\AllDataTypes\AllDataTypes.json         |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.us-east-1.GlobalTable2019  | payloads/ida/dynamoDBPayloads/API/items.json | payloads\ida\dynamoDBPayloads\API\Actual\GlobalTable2019\GlobalTable2019.json   |            |

  Scenario: SC#35_verify whether multiple keyspace including empty and table filters within same keyspace should be repeated in filter cataloger configuration
    And user "update" the json file "ida\dynamoDBPayloads\API\Actual\GlobalTable_2017\GlobalTable_2017.json" file for following values
      | jsonPath                | jsonValues | type  |
      | $..sample.values[0].[4] |            | Array |
      | $..sample.values[1].[4] |            | Array |

    #7063998
  Scenario: SC#4_Verify the data sampling information for Dynamo DB table when analyzed with filter condition
    Then file content in "ida\dynamoDBPayloads\API\Actual\AllDataTypes\AllDataTypes.json" should be same as the content in "ida\dynamoDBPayloads\API\Expected\AllDataTypes\AllDataTypes.json"

    #7063998
  Scenario: SC#35_Verify the data sampling information for Dynamo DB table when analyzed with filter condition
    Then file content in "ida\dynamoDBPayloads\API\Actual\GlobalTable2019\GlobalTable2019.json" should be same as the content in "ida\dynamoDBPayloads\API\Expected\GlobalTable2019\GlobalTable2019.json"

  Scenario: SC#35_Verify the DataSamples values are as expected
    Then file content in "ida\dynamoDBPayloads\API\Actual\GlobalTable_2017\GlobalTable_2017.json" should be same as the content in "ida\dynamoDBPayloads\API\Expected\GlobalTable_2017\GlobalTable_2017.json"


  #7064002#Bug-24862
  @positve @regression @sanity @webtest @IDA-1.1.0
  Scenario:SC036#Verify the data profiling metadata information for string datatype for the table "GlobalTable2017" when Analyzed with Filter by DynamoDBAnalyzer
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SC1DynamoTags" and clicks on search
    And user performs "facet selection" in "SC1DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "GlobalTable_2017" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | EName | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
#      | Comments                      | The primary key column EName. | Description |
      | Length                        | 255           | Statistics  |
      | Maximum length                | 11            | Statistics  |
      | Maximum value                 | Siddharthan   | Statistics  |
      | Minimum length                | 6             | Statistics  |
      | Minimum value                 | Harsha        | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | EmpId | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
#      | Comments                      | The primary key column EmpId. | Description |
      | Average                       | 123.5         | Statistics  |
      | Length                        | 22            | Statistics  |
      | Maximum value                 | 124           | Statistics  |
      | Median                        | 123.5         | Statistics  |
      | Minimum value                 | 123           | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Standard deviation            | 0.71          | Statistics  |
      | Variance                      | 0.5           | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |



  #7064000#Bug-24862
  @positve @regression @sanity @webtest  @MLP-21662 @IDA-1.1.0
  Scenario:SC037#Verify the data profiling metadata information for string datatype for the table "GlobalTable2019" when Analyzed with Filter by DynamoDBAnalyzer
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SC1DynamoTags" and clicks on search
    And user performs "facet selection" in "SC1DynamoTags" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "GlobalTable2019" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | EName | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR       | Description |
#      | Comments                      | The primary key column EName. | Description |
      | Length                        | 255           | Statistics  |
      | Maximum length                | 6             | Statistics  |
      | Maximum value                 | Johny         | Statistics  |
      | Minimum length                | 5             | Statistics  |
      | Minimum value                 | Harsha        | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | Id    | click and switch tab | No               |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |
      | Last analyzed at   | Lifecycle  |
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | FLOAT         | Description |
#      | Comments                      | The primary key column Id. | Description |
      | Average                       | 234           | Statistics  |
      | Length                        | 22            | Statistics  |
      | Maximum value                 | 345           | Statistics  |
      | Median                        | 234           | Statistics  |
      | Minimum value                 | 123           | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Standard deviation            | 156.98        | Statistics  |
      | Variance                      | 24642         | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |

################################################################DELETING CONFIG AND TABLES#################################################################################################


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC38:Delete cataloger and Analyzer analysis and tables
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                   | type                | query | param |
      | MultipleIDDelete | Default | cataloger/DynamoDBCataloger/%          | Analysis            |       |       |
      | MultipleIDDelete | Default | Domain=amazonaws.com;Region=us-east-1; | Cluster             |       |       |
      | MultipleIDDelete | Default | dataanalyzer/DynamoDBAnalyzer/%        | Analysis            |       |       |
      | SingleItemDelete | Default | DYNAMODB_BA                            | BusinessApplication |       |       |

#  @sanity @positive @MLP-17300 @IDA-10.3
#  Scenario:SC38:MLP-17300:Delete the Tables created in AWS DynamoDB
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | deleteTable | ida/dynamoDBPayloads/TestData/deleteTable1.json |
##    And user connects to AWS Dynamo database and perform the following operation
##      | action      | jsonPath                                        |
##      | deleteTable | ida/dynamoDBPayloads/TestData/deleteTable2.json |
#    And user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | deleteTable | ida/dynamoDBPayloads/TestData/deleteTable3.json |
#    And user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                             |
#      | deleteTable | ida/dynamoDBPayloads/TestData/deleteTableOnlyPK.json |
#    And user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | deleteTable | ida/dynamoDBPayloads/TestData/deleteTable4.json |
#    And user connects to AWS Dynamo database and perform the following operation
#      | action            | Table1           | Table2           |
#      | deleteGlobalTable | GlobalTable_2017 | GlobalTable_2017 |
#
#
#    #####################################################################PII tags################################################################################################


  @sanity
  Scenario: SC39#-Set the DynamoDB Datasources
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                   | body                                                           | response code | response message | jsonPath            |
      | application/json | raw   | false | Put  | settings/analyzers/DynamoDBDataSource | ida/dynamoDBPayloads/DataSource/dydbValidDataSourceConfig.json | 204           |                  |                     |
      |                  |       |       | Get  | settings/analyzers/DynamoDBDataSource |                                                                | 200           |                  | dydbValidDataSource |


  @PIITag
  Scenario Outline: SC40#-create PIItags with respect to dynamo DB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | tags/Default/structures | ida/dynamoDBPayloads/Pii Tags/DynamoPIItags.json | 200           |                  |          |

  @PIITag
  Scenario Outline: SC41#-Set the PItags for DynamoDB tables ,typePattern can be set as:VARCHAR or .*VAR.*minimumRatio:0.5, Match Empty=false, Match Full=false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/datapattern_valid_0_5 | 204           |                  |          |


    #7077246
  @sanity @positive @IDA-1.1.0
  Scenario:SC41#Run DynamoDB cataloger for PIItags
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC41#Verify whether all the tables are analyzed and PII tas are set for the minimum ratio 0.5
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                 | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter5Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                      | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                      | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |


  @positve @regression @sanity  @PIITag
  Scenario:SC41#Verify Tag is set for the column when typePattern(String) and dataPattern/minimumRatio matches with the column type/value ratio in DynamoDB table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                          | Column    | Tags                                                          | Query                    | Action      |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | FULL_NAME | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Full Name              | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Full Name              | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Full Name              | ColumnQuerywithoutSchema | TagAssigned |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC41:Delete cataloger and Analyzer analysis and tables with PII tags ratio 0.5
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |

  @PIITag
  Scenario Outline: SC42#-Set the PItags for DynamoDB tables , typePattern can be set as:  NUMBER or .*VAR1.* or .*FLOAT.* or .*NUM.*  minimumRatio:0.5
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/datapattern_Invalid_0_5 | 204           |                  |          |


    #7077246
  @sanity @positive @IDA-1.1.0
  Scenario:SC42#Run DynamoDB cataloger for PIItags invalid datatype pattern
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC42#Verify whether all the tables are analyzed and PII with Invalid datatype pattern
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                 | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter5Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                      | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                      | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

  @positve @regression @sanity @PIITag
  Scenario:SC#42Verify Tag is not set for the column when typePattern(other than String) and dataPattern/minimumRatio matches with the column type/value ratio in Oracle table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                          | Column    | Tags                   | Query                    | Action         |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC42:Delete cataloger and Analyzer analysis and tables with PII tags ratio 0.5
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |


  @PIITag
  Scenario Outline: SC43#-Set the PItags for DynamoDB tables , namePattern can be set as:.*FULL.*,IPADDRESS,GENDER,.*EMAIL.*,SSN, minimumRatio:0.5
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/namepattern_valid_0_5 | 204           |                  |          |


    #7077246
  @sanity @positive @IDA-1.1.0
  Scenario:SC43#Run DynamoDB cataloger for PIItags valid Name pattern in regex
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC43#Verify whether all the tables are analyzed and PII with valid Name pattern in regex
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                 | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter5Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                      | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                      | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |


  @positve @regression @sanity  @PIITag
  Scenario:SC43#Verify Tag is set for the column when namepattern(valid column name) and dataPattern/minimumRatio matches with the column type/value ratio in DynamoDB table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                          | Column    | Tags                                                          | Query                    | Action      |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | FULL_NAME | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Full Name              | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Full Name              | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Full Name              | ColumnQuerywithoutSchema | TagAssigned |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC43:Delete cataloger and Analyzer analysis and tables with PII tags ratio 0.5
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |

  @PIITag
  Scenario Outline: SC44#-Set the PItags for DynamoDB tables , namePattern set as: .*FULL1.*,IPADDRESS1,GENDER1,.*EMAILS.*,SSN1, minimumRatio:0.5
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/invalidnamepattern_valid_0_5 | 204           |                  |          |


    #7077246
  @sanity @positive @IDA-1.1.0
  Scenario:SC44#Run DynamoDB cataloger for PIItags invalid Name pattern
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

  @positve @regression @sanity  @IDA-1.1.0
  Scenario:SC44#Verify whether all the tables are analyzed and PII with Invalid Name pattern
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                 | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter5Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                      | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                      | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

  @positve @regression @sanity  @PIITag
  Scenario:SC#44Verify Tag is not set for the column when NamePattern( invalid columnname) and dataPattern/minimumRatio matches with the column type/value ratio in Oracle table.
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                          | Column    | Tags                   | Query                    | Action         |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC44:Delete cataloger and Analyzer analysis and tables with PII tags ratio 0.5
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |


  @PIITag
  Scenario Outline: SC45#-Set the PItags for DynamoDB tables , valid name and type pattern minimumRatio:0.2
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                              | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/validnamepattern_valid_0_2 | 204           |                  |          |


    #7077246
  @sanity @positive @IDA-1.1.0
  Scenario:SC45#Run DynamoDB cataloger for PIItags valid name and type pattern minimumRatio:0.2 matchfull false and matchempty true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC45#Verify whether all the tables are analyzed and PII with valid name and type pattern minimumRatio:0.2 matchfull false and matchempty true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                      | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter_RL_5_Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                           | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                           | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |


  @positve @regression @sanity  @PIITag
  Scenario:SC45#Verify Tag is set for the column when minimumRatio:0.2 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                   | Column    | Tags                                                          | Query                    | Action      |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse | FULL_NAME | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Full Name              | ColumnQuerywithoutSchema | TagAssigned |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC45:Delete cataloger and Analyzer analysis and tables with PII tags ratio 0.2 matchfull false and matchempty true
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |

  @PIITag
  Scenario Outline: SC46#-Set the PIItags for DynamoDB tables , minimumRatio:0.6 matchfull false and matchempty true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                              | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/validnamepattern_valid_0_6 | 204           |                  |          |


    #7077246
  @sanity @positive @IDA-1.1.0
  Scenario:SC46#Run DynamoDB cataloger for PIItags with minimumRatio:0.6 matchfull false and matchempty true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC46#Verify whether all the tables are analyzed and PII with minimumRatio:0.6 matchfull false and matchempty true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                         | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter_RL_5_FT_Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                              | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                              | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

   #bug id - MLP-23041
  @positve @regression @sanity  @PIITag
  Scenario:SC#46Verify Tag is not set for the column when minimumRatio:0.6 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                          | Column | Tags   | Query                    | Action         |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | gender | Gender | ColumnQuerywithoutSchema | TagNotAssigned |


  @positve @regression @sanity  @PIITag
  Scenario:SC46#Verify Tag is set for the column column when minimumRatio:0.6 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                          | Column    | Tags                                                 | Query                    | Action      |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address    | ColumnQuerywithoutSchema | TagAssigned |

  @PIITag
  Scenario Outline: SC47#-Set the PIItags for DynamoDB tables , minimumRatio:0.6 matchfull true and matchempty true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                      | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/validnamepattern_valid_0_6_alltrue | 204           |                  |          |


  @positve @regression @sanity  @MLP-21662 @IDA-1.1.0
  Scenario:SC47#MLP_21662_Verify whether all the tables are analyzed and PII with minimumRatio:0.6 matchfull true and matchempty true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                         | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter_RL_5_FT_Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                              | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                              | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |


  @positve @regression @sanity @PIITag
  Scenario:SC47#Verify Tag is set for the column column when minimumRatio:0.6 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                          | Column    | Tags                                                          | Query                    | Action      |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Full Name              | ColumnQuerywithoutSchema | TagAssigned |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC47:Delete cataloger and Analyzer analysis and tables with PII tags ratio 0.6 matchfull false and matchempty true
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |

  @PIITag
  Scenario Outline: SC48#-Set the PIItags for DynamoDB tables , minimumRatio:1 matchfull false and matchempty false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/validnamepattern_valid_1_allfalse | 204           |                  |          |


    #7077246
  @sanity @positive @IDA-1.1.0
  Scenario:SC48#Run DynamoDB cataloger for PIItags with minimumRatio:1 matchfull false and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC48#Verify whether all the tables are analyzed and PII with minimumRatio:1 matchfull false and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                          | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter_ALLMatch_Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                               | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                               | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

  @positve @regression @sanity @PIITag
  Scenario:SC48#Verify Tag is set for the column when namepattern(valid column name) and dataPattern/minimumRatio:1 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename  | Column    | Tags                                                          | Query                    | Action      |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH | FULL_NAME | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Full Name              | ColumnQuerywithoutSchema | TagAssigned |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC48:Delete cataloger and Analyzer analysis and tables with PII tags minimumRatio:1 matchfull false and matchempty false
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |

  @PIITag
  Scenario Outline: SC49#-Set the PIItags for DynamoDB tables , minimumRatio:0.5 matchfull false and matchempty false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/validnamepattern_valid_0_5_allfalse | 204           |                  |          |


    #7077246
  @sanity @positive @IDA-1.1.0
  Scenario:SC49#Run DynamoDB cataloger for PIItags with minimumRatio:0.5 matchfull false and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC49#Verify whether all the tables are analyzed and PII with minimumRatio:0.5 matchfull false and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                       | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter_Equal_Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                            | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                            | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

  @positve @regression @sanity @PIITag
  Scenario:SC49#Verify Tag is set for the column when namepattern(valid column name) and dataPattern/minimumRatio:0.5 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                  | Column    | Tags                                                          | Query                    | Action      |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse | FULL_NAME | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Full Name              | ColumnQuerywithoutSchema | TagAssigned |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC49:Delete cataloger and Analyzer analysis and tables with PII tags minimumRatio:0.5 matchfull false and matchempty false
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |


  @PIITag
  Scenario Outline: SC50#-Set the PIItags for DynamoDB tables , minimumRatio:0.2 matchfull false and matchempty false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/validnamepattern_valid_0_2_allfalse | 204           |                  |          |


    #7077246
  @sanity @positive @IDA-1.1.0
  Scenario:SC50#Run DynamoDB cataloger for PIItags with minimumRatio:0.2 matchfull false and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC50#Verify whether all the tables are analyzed and PII with minimumRatio:0.2 matchfull false and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                      | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter_RL_5_Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                           | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                           | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

  @positve @regression @sanity @PIITag
  Scenario:SC50#Verify Tag is set for the column when namepattern(valid column name) and dataPattern/minimumRatio:0.2 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                   | Column    | Tags                                                          | Query                    | Action      |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse | FULL_NAME | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Full Name              | ColumnQuerywithoutSchema | TagAssigned |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC50:Delete cataloger and Analyzer analysis and tables with PII tags minimumRatio:0.2 matchfull false and matchempty false
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |


  @PIITag
  Scenario Outline: SC51#-Set the PIItags for DynamoDB tables , name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/validnamepattern_Invalid_0_2_allfalse | 204           |                  |          |


    #7077246
  @sanity @positive @IDA-1.1.0
  Scenario:SC51#Run DynamoDB cataloger for PIItags with name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC51#Verify whether all the tables are analyzed and PII with name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                 | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter5Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                      | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                      | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

  @positve @regression @sanity @PIITag
  Scenario:SC51#Verify Tag is not set for the column when name pattern (Invalid columns) and dataPattern/minimumRatio:0.2 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                          | Column    | Tags                   | Query                    | Action         |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC51:Delete cataloger and Analyzer analysis and tables with PII tags name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |


  @PIITag
  Scenario Outline: SC52#-Set the PIItags for DynamoDB tables , data pattern (Invalid datatype) minimumRatio:0.2 matchfull false and matchempty false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/Invalidtypepattern_valid_0_2_allfalse | 204           |                  |          |


    #7077246
  @sanity @positive @IDA-1.1.0
  Scenario:SC52#Run DynamoDB cataloger for PIItags withl; data pattern (Invalid datatype)  minimumRatio:0.2 matchfull false and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC52#Verify whether all the tables are analyzed and PII with data pattern (Invalid datatype)  minimumRatio:0.2 matchfull false and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                 | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter7Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                      | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                      | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

  @positve @regression @sanity @PIITag
  Scenario:SC52#Verify Tag is not set for the column when data pattern (Invalid datatype) and dataPattern/minimumRatio:0.2 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                          | Column    | Tags                   | Query                    | Action         |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |


  @positve @regression @sanity  @IDA-1.1.0
  Scenario:SC52:Delete cataloger and Analyzer analysis and tables with PII tags data pattern (Invalid datatype)  minimumRatio:0.2 matchfull false and matchempty false
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |

  @PIITag
  Scenario Outline: SC53#-Set the PIItags for DynamoDB tables , data pattern (Invalid regex) minimumRatio:0.2 matchfull false and matchempty false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.Invaliddatapattern_valid_0_2_allfalse | 204           |                  |          |


    #7077246
  @sanity @positive @IDA-1.1.0
  Scenario:SC53#Run DynamoDB cataloger for PIItags with data pattern (Invalid regex)  minimumRatio:0.2 matchfull false and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC53#Verify whether all the tables are analyzed and PII with data pattern (Invalid regex)  minimumRatio:0.2 matchfull false and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                 | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter7Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                      | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                      | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                      | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

  @positve @regression @sanity @PIITag
  Scenario:SC53#Verify Tag is not set for the column when data pattern (Invalid regex) and dataPattern/minimumRatio:0.2 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                          | Column    | Tags                   | Query                    | Action         |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLMATCH                         | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY                         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolessthan05EmptyFalse        | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | email     | Email Address          | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | gender    | Gender                 | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | IP Address             | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | Social Security Number | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | Full Name              | ColumnQuerywithoutSchema | TagNotAssigned |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC53:Delete cataloger and Analyzer analysis and tables with PII tags data pattern (Invalid regex) minimumRatio:0.2 matchfull false and matchempty false
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |


  @PIITag
  Scenario Outline: SC54#-Set the PIItags for DynamoDB tables , minimumRatio:0.5 matchfull false and matchempty true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                         | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/validtdatapattern_valid_0_5_Emptytrue | 204           |                  |          |


    #7077246
  @sanity @positive  @IDA-1.1.0
  Scenario:SC54#Run DynamoDB cataloger for PIItags with minimumRatio:0.5 matchfull false and matchempty true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC54#Verify whether all the tables are analyzed and PII with minimumRatio:0.5 matchfull false and matchempty true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                          | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter_ALLEmpty_Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                               | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                               | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

  @positve @regression @sanity @PIITag
  Scenario:SC54#Verify Tag is not set for the column when minimumRatio:0.5 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename  | Column    | Tags                                                          | Query                    | Action      |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_ALLEMPTY | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC54:Delete cataloger and Analyzer analysis and tables with PII tags minimumRatio:0.5 matchfull false and matchempty true
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | SingleItemDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |

  @PIITag
  Scenario Outline: SC55#-Set the PIItags for DynamoDB tables , minimumRatio:0.6 matchfull true and matchempty false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/validtdatapattern_valid_0_6_matchFulltrue | 204           |                  |          |


    #7077246
  @sanity @positive@IDA-1.1.0
  Scenario:SC55#Run DynamoDB cataloger for PIItags with minimumRatio:0.6 matchfull true and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC55#Verify whether all the tables are analyzed and PII with minimumRatio:0.6 matchfull true and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                             | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter_Match_RG_FT_Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                                  | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                                  | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

  @positve @regression @sanity  @PIITag
  Scenario:SC55#Verify Tag is not set for the column when minimumRatio:0.6 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                         | Column   | Tags          | Query                    | Action         |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | Comments | Fullmatch PII | ColumnQuerywithoutSchema | TagNotAssigned |


  @PIITag
  Scenario Outline: SC55#-Set the PIItags for DynamoDB tables , minimumRatio:0.6 matchfull false and matchempty false (re-run case)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                        | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/validtdatapattern_valid_0_6_Allfalse | 204           |                  |          |

  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC55#Verify whether all the tables are analyzed and PII with minimumRatio:0.6 matchfull false and matchempty true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                             | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter_Match_RG_FT_Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                                  | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                                  | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |


  @positve @regression @sanity @PIITag
  Scenario:SC55#Verify Tag is set for the column when namepattern(valid column name) and dataPattern/minimumRatio:0.6 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                         | Column   | Tags                                                 | Query                    | Action      |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | Comments | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Fullmatch PII | ColumnQuerywithoutSchema | TagAssigned |


  @positve @regression @sanity  @IDA-1.1.0
  Scenario:SC55:Delete cataloger and Analyzer analysis and tables with PII tags minimumRatio:0.6 matchfull false and matchempty false
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | MultipleIDDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |

#7099403
  @PIITag
  Scenario Outline: SC56#-Set the PIItags for DynamoDB tables , minimumRatio:0.2 matchfull true and matchempty false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/validtdatapattern_valid_0_2_matchFulltrue | 204           |                  |          |


    #7099403
  @sanity @positive @IDA-1.1.0
  Scenario:SC56#Run DynamoDB cataloger for PIItags with minimumRatio:0.2 matchfull true and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
#7099403
  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC56#Verify whether all the tables are analyzed and PII with minimumRatio:0.2 matchfull true and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                             | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter_Match_RL_FT_Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                                  | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                                  | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

    #7099403
  @positve @regression @sanity  @PIITag
  Scenario:SC56#Verify Tag is not set for the column when minimumRatio:0.2 matchfull true and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                        | Column   | Tags          | Query                    | Action         |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolesserthan05MatchFullTrue | Comments | Fullmatch PII | ColumnQuerywithoutSchema | TagNotAssigned |

#7099403
  @PIITag
  Scenario Outline: SC56#-Set the PIItags for DynamoDB tables , minimumRatio:0.2 matchfull false and matchempty false(re-run case)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                        | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/validtdatapattern_valid_0_2_Allfalse | 204           |                  |          |

    #7099403
  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC56#Verify whether all the tables are analyzed and PII with minimumRatio:0.2 matchfull false and matchempty true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                             | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter_Match_RL_FT_Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                                  | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                                  | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                                  | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

#7099403
  @positve @regression @sanity  @PIITag
  Scenario:SC56#Verify Tag is set for the column when namepattern(valid column name) and dataPattern/minimumRatio:0.2 matchfull false and matchempty false
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                        | Column   | Tags                                                 | Query                    | Action      |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiolesserthan05MatchFullTrue | Comments | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Fullmatch PII | ColumnQuerywithoutSchema | TagAssigned |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC56:Delete cataloger and Analyzer analysis and tables with PII tags minimumRatio:0.2 matchfull false and matchempty false
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | MultipleIDDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |

#7099418,7099416,7099419,7099417
  @PIITag
  Scenario Outline: SC57#-Set the PIItags for DynamoDB tables , minimumRatio:0.6 matchfull true and matchempty false
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/validtdatapattern_valid_0_6_Emptytrue_Global2017 | 204           |                  |          |


#7099418,7099416,7099419,7099417
  @sanity @positive @IDA-1.1.0
  Scenario:SC57#Run DynamoDB cataloger for PIItags with minimumRatio:0.6 matchfull true and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |

    #7099418,7099416,7099419,7099417
  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC57#Verify whether all the tables are analyzed and PII with minimumRatio:0.6 matchfull true and matchempty false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                       | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter_Gloal_Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                            | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                            | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

    #bug id - MLP-23041
    #7099418,7099416,7099419,7099417
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#57Verify Tag is not set for the column when minimumRatio:0.6 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                                          | Column | Tags   | Query                    | Action         |
#      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2019 | gender | Gender | ColumnQuerywithoutSchema | TagNotAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | gender | Gender | ColumnQuerywithoutSchema | TagNotAssigned |

#7099418,7099416,7099419,7099417
  @positve @regression @sanity @PIITag
  Scenario:SC57#Verify Tag is set for the column column when minimumRatio:0.6 matchfull false and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                                          | Column    | Tags                                                 | Query                    | Action      |
#      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2019 | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address | ColumnQuerywithoutSchema | TagAssigned |
#      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2019 | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address    | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address    | ColumnQuerywithoutSchema | TagAssigned |


#7099418,7099416,7099419,7099417
  @PIITag
  Scenario Outline:SC57#-Set the PIItags for DynamoDB tables , minimumRatio:0.6 matchfull true and matchempty true
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | bodyFile                                                     | path                                                  | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | policy/tagging/actions | payloads/ida/dynamoDBPayloads/Pii Tags/PII Tags Pattern.json | $.type/validtdatapattern_valid_0_6_Alltrue_Global2017 | 204           |                  |          |

#7099418,7099416,7099419,7099417
  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC57#Verify whether all the tables are analyzed and PII with minimumRatio:0.6 matchfull true and matchempty true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                                      | body                                                                       | response code | response message | jsonPath                                                  |
      | application/json |       |       | Put          | settings/analyzers/DynamoDBAnalyzer                                                      | ida/dynamoDBPayloads/PluginConfiguration/Filter_Gloal_Tables_Anlayzer.json | 204           |                  |                                                           |
      |                  |       |       | Get          | settings/analyzers/DynamoDBAnalyzer                                                      |                                                                            | 200           |                  | NoFilter_DDBAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer  |                                                                            | 200           |                  |                                                           |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='NoFilter_DDBAnalyzer')].status |

#7099418,7099416,7099419,7099417
  @positve @regression @sanity  @PIITag
  Scenario:SC57#Verify Tag is set for the column when namepattern(valid column name) and dataPattern/minimumRatio:0.6 matchfull true and matchempty true
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName                            | ServiceName | DatabaseName | TableName/Filename                                          | Column    | Tags                                                          | Query                    | Action      |
#      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2019 | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
#      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2019 | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
#      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2019 | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
#      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2019 | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
#      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2019 | FULL_NAME | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Full Name              | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | email     | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Email Address          | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | gender    | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Gender                 | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | IPADDRESS | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,IP Address             | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | SSN       | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Social Security Number | ColumnQuerywithoutSchema | TagAssigned |
      | Domain=amazonaws.com;Region=us-east-1; | DYNAMODB    | DYNAMODB     | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | FULL_NAME | PIITags,DYNAMODB_BA,Dynamo DB,NoFilter,Full Name              | ColumnQuerywithoutSchema | TagAssigned |


  @positve @regression @sanity @IDA-1.1.0
  Scenario:SC57:Delete cataloger and Analyzer analysis and tables with PII tags minimumRatio:0.2 matchfull true and matchempty false
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                 | type     | query | param |
      | MultipleIDDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/%  | Analysis |       |       |
      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;               | Cluster  |       |       |
      | MultipleIDDelete | Default | dataanalyzer/DynamoDBAnalyzer/NoFilter_DDBAnalyzer/% | Analysis |       |       |


#    #####################################################EDI BUS########################################################################
#
#      #7077246
##  @sanity @positive @MLP-21662 @IDA-1.1.0
##  Scenario:SC58#MLP_21662_Run DynamoDB cataloger for EDI bus scenario
##    Given Execute REST API with following parameters
##      | Header           | Query | Param | type         | url                                                                 | body                                                           | response code | response message | jsonPath                                                   |
##      | application/json |       |       | Put          | settings/analyzers/DynamoDBCataloger                                | ida/dynamoDBPayloads/PluginConfiguration/DynamoConfigSC34.json | 204           |                  |                                                            |
##      |                  |       |       | Get          | settings/analyzers/DynamoDBCataloger                                |                                                                | 200           |                  | DynamoCatalog_PIITags                                      |
##      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
##      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/DynamoDBCataloger/*  |                                                                | 200           |                  |                                                            |
##      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/DynamoDBCataloger/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='DynamoCatalog_PIITags')].status |
##
##  Scenario Outline::SC#59#MLP-9043_Configure EDI Bus credentials and Data Source
##    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
##    Examples:
##      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | body                                                       | response code | response message       | jsonPath |
##      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EDIBusValidCredentials | idc/EdiBusPayloads/Credentials/EDIBusValidCredentials.json | 200           |                        |          |
##      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource         | idc/EdiBusPayloads/DataSource/EDIBUSDYDBDS.json            | 204           |                        |          |
##      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource         |                                                            | 200           | EDIBusDynamoDataSource |          |
##
##     ##6549303
##  @sanity @positive @webtest @edibus
##  Scenario::SC#59#MLP-9043_Verify EDI replication for items collected using DynamoDBCataloger
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator1" role
##    And user enters the search text "PIITags" and clicks on search
##    And user performs "facet selection" in "PIITags" attribute under "Tags" facets in Item Search results page
##    And user performs "facet selection" in "Dynamo DB" attribute under "Tags" facets in Item Search results page
##    And user "verify displayed" for listed "Type" facet in Search results page
##      | ItemType   |
##      | Column     |
##      | Constraint |
##      | Table      |
##      | Cluster    |
##      | Database   |
##      | Host       |
##      | Service    |
##    And user connects Rochade Server and "clears" the items in EDI subject area
##      | databaseName | subjectArea | subjectAreaVersion | query                                      |
##      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
##    And user update json file "idc/EdiBusPayloads/DynamoDBConfig.json" file for following values using property loader
##      | jsonPath                                           | jsonValues    |
##      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
##      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
##    And configure a new REST API for the service "IDC"
##    Given Execute REST API with following parameters
##      | Header           | Query | Param | type         | url                                                                 | body                                   | response code | response message | jsonPath                                            |
##      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/DynamoDBConfig.json | 204           |                  |                                                     |
##      |                  |       |       | Get          | settings/analyzers/EDIBus                                           |                                        | 200           |                  | EDIBusDynamoDB                                      |
##      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusDynamoDB |                                        | 200           | IDLE             | $.[?(@.configurationName=='EDIBusDynamoDB')].status |
##      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusDynamoDB  |                                        | 200           |                  |                                                     |
##      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusDynamoDB |                                        | 200           | IDLE             | $.[?(@.configurationName=='EDIBusDynamoDB')].status |
##    And user enters the search text "EDIBusDynamoDB" and clicks on search
##    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
##    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusDynamoDB%"
##    And METADATA widget should have following item values
##      | metaDataItem     | metaDataItemValue |
##      | Number of errors | 0                 |
##    And user enters the search text "PIITags" and clicks on search
##    And user performs "facet selection" in "PIITags" attribute under "Tags" facets in Item Search results page
##    And user performs "facet selection" in "Dynamo DB" attribute under "Tags" facets in Item Search results page
##    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
##    And user gets the items search count
##    And user connects Rochade Server and "compare count" the items in EDI subject area
##      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
##      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
##    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
##      | jsonPath                                      | jsonValues                                      |
##      | $..selections.['asg.tagPathsHierarchy_ss'][0] | PIITags                                         |
##      | $..selections.['asg.tagPathsHierarchy_ss'][1] | Technology/Cloud Data/Cloud Databases/Dynamo DB |
##      | $..selections.['type_s'][*]                   | Column                                          |
##    And Execute REST API with following parameters
##      | Header | Query | Param | type | url                                                                                                    | body                              | response code | response message | jsonPath |
##      |        |       |       | Post | searches/fulltext/Default?query=PIITags&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
##    And user stores the values in list from response using jsonpath "$..name"
##    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
##      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
##      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
##    And user enters the search text "PIITags" and clicks on search
##    And user performs "facet selection" in "PIITags" attribute under "Tags" facets in Item Search results page
##    And user performs "facet selection" in "Dynamo DB" attribute under "Tags" facets in Item Search results page
##    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
##    And user gets the items search count
##    And user connects Rochade Server and "compare count" the items in EDI subject area
##      | databaseName | subjectArea | subjectAreaVersion | query                                                                          |
##      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW) |
##    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
##      | jsonPath                                      | jsonValues                                      |
##      | $..selections.['asg.tagPathsHierarchy_ss'][0] | PIITags                                         |
##      | $..selections.['asg.tagPathsHierarchy_ss'][1] | Technology/Cloud Data/Cloud Databases/Dynamo DB |
##      | $..selections.['type_s'][*]                   | Table                                           |
##    And Execute REST API with following parameters
##      | Header | Query | Param | type | url                                                                                                    | body                              | response code | response message | jsonPath |
##      |        |       |       | Post | searches/fulltext/Default?query=PIITags&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
##    And user stores the values in list from response using jsonpath "$..name"
##    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
##      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
##      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
##    And user enters the search text "PIITags" and clicks on search
##    And user performs "facet selection" in "PIITags" attribute under "Tags" facets in Item Search results page
##    And user performs "facet selection" in "Dynamo DB" attribute under "Tags" facets in Item Search results page
##    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
##    And user gets the items search count
##    And user connects Rochade Server and "compare count" the items in EDI subject area
##      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
##      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
##    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
##      | jsonPath                                      | jsonValues                                      |
##      | $..selections.['asg.tagPathsHierarchy_ss'][0] | PIITags                                         |
##      | $..selections.['asg.tagPathsHierarchy_ss'][1] | Technology/Cloud Data/Cloud Databases/Dynamo DB |
##      | $..selections.['type_s'][*]                   | Database                                        |
##    And Execute REST API with following parameters
##      | Header | Query | Param | type | url                                                                                                    | body                              | response code | response message | jsonPath |
##      |        |       |       | Post | searches/fulltext/Default?query=PIITags&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
##    And user stores the values in list from response using jsonpath "$..name"
##    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
##      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
##      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
##    And user enters the search text "PIITags" and clicks on search
##    And user performs "facet selection" in "PIITags" attribute under "Tags" facets in Item Search results page
##    And user performs "facet selection" in "Dynamo DB" attribute under "Tags" facets in Item Search results page
##    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
##    And user gets the items search count
##    And user connects Rochade Server and "compare count" the items in EDI subject area
##      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
##      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |
##    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
##      | databaseName | subjectArea | subjectAreaVersion | query                                                                                 |
##      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @*Dynamo@ DB≫DEFAULT≫DWR_RDB_COLUMN≫@* ) ,AND,( TYPE = DWR_IDC )       |
##      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @*Dynamo@ DB≫DEFAULT≫DWR_RDB_TABLE_OR_VIEW≫@* ),AND,( TYPE = DWR_IDC ) |
##      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @*Dynamo@ DB≫DEFAULT≫DWR_RDB_DATABASE≫@* ),AND,( TYPE = DWR_IDC )      |
##      | AP-DATA      | DYNAMODB    | 1.0                | (XNAME * *  ~/ @*Dynamo@ DB≫DEFAULT≫DWR_RDB_DB_SYSTEM≫@* ),AND,( TYPE = DWR_IDC )     |
##
##  @positve @regression @sanity @MLP-21662 @IDA-1.1.0
##  Scenario:SC59:Delete cataloger and Analyzer analysis and tables with PII tags minimumRatio:0.2 matchfull false and matchempty false
##    And Delete multiple values in IDC UI with below parameters
##      | deleteAction     | catalog | name                                                | type     | query | param |
##      | SingleItemDelete | Default | cataloger/DynamoDBCataloger/DynamoCatalog_PIITags/% | Analysis |       |       |
##      | SingleItemDelete | Default | Domain=amazonaws.com;Region=us-east-1;              | Cluster  |       |       |
##
##  @positve @regression @sanity  @MLP-21662 @IDA-1.1.0
##  Scenario:SC59#Delete EDIBusAnalysis item
##    And Delete multiple values in IDC UI with below parameters
##      | deleteAction     | catalog | name                         | type     | query | param |
##      | SingleItemDelete | Default | bulk/EDIBus/EDIBusDynamoDB/% | Analysis |       |       |


  @MLP-14874 @webtest
  Scenario: SC#60 Verify whether the background of the panel is displayed in red when test connection is not successful for DynamoDBDataSource in LocalNode for disabled/unsupported region
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Settings Icon       |
      | click      | Manage Data Sources |
    And user performs following actions in the sidebar
      | actionType | actionItem                                         |
      | click      | Add Data Source Button in Manage Data Sources Page |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute          |
      | Data Source Type | DynamoDBDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute               |
      | Name*     | DynamoDBDataSourceTest3 |
      | Label     | DynamoDBDataSourceTest3 |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute                        |
      | Region*     | China (Ningxia) [cn-northwest-1] |
      | Credential* | ValidDYDBCredentials             |
      | Node        | LocalNode                        |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Error retrieving bucket list" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute                       |
      | Region*   | Africa (Cape Town) [af-south-1] |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Error retrieving bucket list" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName | attribute                                   |
      | Region*   | Asia Pacific (Osaka-Local) [ap-northeast-3] |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "No connection with data source - Cannot create enum from ap-northeast-3 value!" is "displayed" in "Step1 Add Data Source pop up"
    And user verifies "Save Button" is "enabled" in "Step1 Add Data Source pop up"

##############################################Delete tables and config#######################################################

  @jdbc
  Scenario Outline:SC61:MLP-17300:Deleting the Credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                           | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/ValidDYDBCredentials     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/IncorrectDYDBCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EmptyDYDBCredentials     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/DynamoDBDataSource         |      | 204           |                  |          |

#  @sanity @positive @MLP-21662 @IDA-10.3
#  Scenario:SC60:MLP-21662:Delete the PII validation Tables created in AWS DynamoDB
#    Given user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | deleteTable | ida/dynamoDBPayloads/TestData/deleteTable5.json |
#    And user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | deleteTable | ida/dynamoDBPayloads/TestData/deleteTable6.json |
#    And user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | deleteTable | ida/dynamoDBPayloads/TestData/deleteTable7.json |
#    And user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | deleteTable | ida/dynamoDBPayloads/TestData/deleteTable8.json |
#    And user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                        |
#      | deleteTable | ida/dynamoDBPayloads/TestData/deleteTable9.json |
#    And user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                         |
#      | deleteTable | ida/dynamoDBPayloads/TestData/deleteTable10.json |
#    And user connects to AWS Dynamo database and perform the following operation
#      | action      | jsonPath                                         |
#      | deleteTable | ida/dynamoDBPayloads/TestData/deleteTable11.json |
#    And user connects to AWS Dynamo database and perform the following operation
#      | action            | Table1                                                      | Table2                                                      |
#      | deleteGlobalTable | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue_GlobalTable2017 |
