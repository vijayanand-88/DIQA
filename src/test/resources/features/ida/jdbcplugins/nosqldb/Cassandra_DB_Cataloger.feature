@MLP-7662
Feature:JDBC Cataloger and Analyzer Support for Cassandra database
  Description : JDBC Cataloger Support for Cassandra DB

  #########################################Cassandra Data Creation###########################################


#  @sanity @positive @MLP-7662 @webtest @IDA-10.0
#  Scenario: SC#01 MLP_7662_ PreCondition_Cassandra db_Create KeySpace in Cassandra database
#    Given user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField     | keySpaceName       |
#      | CASSANDRA    | create    | createKeySpace | json/IDA.json | cassandraQueries | createKeySpace | AutomationKeySpace |
#      | CASSANDRA    | create    | createKeySpace | json/IDA.json | cassandraQueries | createKeySpace | KeySpace1          |
#      | CASSANDRA    | create    | createKeySpace | json/IDA.json | cassandraQueries | createKeySpace | KeySpace2          |
#      | CASSANDRA    | create    | createKeySpace | json/IDA.json | cassandraQueries | createKeySpace | KeySpace3          |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField        | tableName |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTable1      | Table1    |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTable2      | Table1    |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTable3      | Table1    |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTable4      | Table2    |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTable5      | Table3    |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTable6      | Table4    |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTable7      | Table5    |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insert_KS1_Table1 | Table1    |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insert_KS1_Table3 | Table3    |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insert_KS1_Table2 | Table2    |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insert_KS2_Table1 | Table1    |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insert_KS2_Table4 | Table4    |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insert_KS3_Table1 | Table1    |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insert_KS3_Table5 | Table5    |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField  | tableName      |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTable | UserDetailsTC1 |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertData  | UserDetailsTC1 |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField                 | tableName    |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTableMultiplePartion | MultiplePart |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertTableMultiplePartion | MultiplePart |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField             | tableName           |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTableCompoundKey | UserDetailsCompound |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertCompData1        | UserDetailsCompound |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertCompData2        | UserDetailsCompound |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertCompData3        | UserDetailsCompound |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertCompData4        | UserDetailsCompound |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertCompData5        | UserDetailsCompound |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField              | tableName               |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTablePartitioning | UserDetailsPartitioning |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertPartData1         | UserDetailsPartitioning |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertPartData2         | UserDetailsPartitioning |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertPartData3         | UserDetailsPartitioning |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField              | tableName         |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createAlterTableColumns | alterTablestudent |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertalter1            | alterTablestudent |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertalter2            | alterTablestudent |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertalter3            | alterTablestudent |
#      | CASSANDRA    | alter     | alterTable     | json/IDA.json | cassandraQueries | alterTablestudent       | alterTablestudent |
#      | CASSANDRA    | alter     | insertData     | json/IDA.json | cassandraQueries | insertalter4            | alterTablestudent |
#      | CASSANDRA    | alter     | insertData     | json/IDA.json | cassandraQueries | insertalter5            | alterTablestudent |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField                | tableName    |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTableAllDataTypes   | AllDataTypes |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | AllDataTypesInsertRecord1 | AllDataTypes |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | AllDataTypesInsertRecord2 | AllDataTypes |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | AllDataTypesInsertRecord3 | AllDataTypes |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField            | tableName     |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createListWideColumns | listWidetable |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertList1           | listWidetable |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertList2           | listWidetable |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertList3           | listWidetable |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField           | tableName |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createMapWideColumns | maptable  |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertmap1           | maptable  |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertmap2           | maptable  |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertmap3           | maptable  |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField           | tableName |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createSetWideColumns | settable  |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertset1           | settable  |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertset2           | settable  |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertset3           | settable  |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField  | tableName      |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTable | UserDetailsTC1 |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertData  | UserDetailsTC1 |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField                       | tableName           |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTagDetailsAllMatch         | tagdetails_allmatch |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord1_TagDetailsAllMatch | tagdetails_allmatch |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord2_TagDetailsAllMatch | tagdetails_allmatch |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord3_TagDetailsAllMatch | tagdetails_allmatch |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord4_TagDetailsAllMatch | tagdetails_allmatch |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord5_TagDetailsAllMatch | tagdetails_allmatch |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField                       | tableName           |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTagDetailsAllEmpty         | tagdetails_allempty |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord1_TagDetailsAllEmpty | tagdetails_allempty |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord2_TagDetailsAllEmpty | tagdetails_allempty |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord3_TagDetailsAllEmpty | tagdetails_allempty |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord4_TagDetailsAllEmpty | tagdetails_allempty |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord5_TagDetailsAllEmpty | tagdetails_allempty |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField                          | tableName                            |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createRatioLess5EmptyFalse          | tagdetails_ratiolessthan05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord1_RatioLess5EmptyFalse  | tagdetails_ratiolessthan05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord2_RatioLess5EmptyFalse  | tagdetails_ratiolessthan05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord3_RatioLess5EmptyFalse  | tagdetails_ratiolessthan05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord4_RatioLess5EmptyFalse  | tagdetails_ratiolessthan05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord5_RatioLess5EmptyFalse  | tagdetails_ratiolessthan05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord6_RatioLess5EmptyFalse  | tagdetails_ratiolessthan05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord7_RatioLess5EmptyFalse  | tagdetails_ratiolessthan05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord8_RatioLess5EmptyFalse  | tagdetails_ratiolessthan05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord9_RatioLess5EmptyFalse  | tagdetails_ratiolessthan05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord10_RatioLess5EmptyFalse | tagdetails_ratiolessthan05emptyfalse |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField                                 | tableName                                   |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createRatioGreater5EmptyFalseTrue          | tagdetails_ratiogreaterthan05emptyfalsetrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord1_RatioGreater5EmptyFalseTrue  | tagdetails_ratiogreaterthan05emptyfalsetrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord2_RatioGreater5EmptyFalseTrue  | tagdetails_ratiogreaterthan05emptyfalsetrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord3_RatioGreater5EmptyFalseTrue  | tagdetails_ratiogreaterthan05emptyfalsetrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord4_RatioGreater5EmptyFalseTrue  | tagdetails_ratiogreaterthan05emptyfalsetrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord5_RatioGreater5EmptyFalseTrue  | tagdetails_ratiogreaterthan05emptyfalsetrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord6_RatioGreater5EmptyFalseTrue  | tagdetails_ratiogreaterthan05emptyfalsetrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord7_RatioGreater5EmptyFalseTrue  | tagdetails_ratiogreaterthan05emptyfalsetrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord8_RatioGreater5EmptyFalseTrue  | tagdetails_ratiogreaterthan05emptyfalsetrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord9_RatioGreater5EmptyFalseTrue  | tagdetails_ratiogreaterthan05emptyfalsetrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord10_RatioGreater5EmptyFalseTrue | tagdetails_ratiogreaterthan05emptyfalsetrue |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField                           | tableName                           |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createRatioEqual5EmptyFalse          | tagdetails_ratioequalto05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord1_RatioEqual5EmptyFalse  | tagdetails_ratioequalto05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord2_RatioEqual5EmptyFalse  | tagdetails_ratioequalto05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord3_RatioEqual5EmptyFalse  | tagdetails_ratioequalto05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord4_RatioEqual5EmptyFalse  | tagdetails_ratioequalto05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord5_RatioEqual5EmptyFalse  | tagdetails_ratioequalto05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord6_RatioEqual5EmptyFalse  | tagdetails_ratioequalto05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord7_RatioEqual5EmptyFalse  | tagdetails_ratioequalto05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord8_RatioEqual5EmptyFalse  | tagdetails_ratioequalto05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord9_RatioEqual5EmptyFalse  | tagdetails_ratioequalto05emptyfalse |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord10_RatioEqual5EmptyFalse | tagdetails_ratioequalto05emptyfalse |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField                                | tableName                                  |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createRatioGreater5MatchFullTrue          | tagdetails_ratiogreaterthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord1_RatioGreater5MatchFullTrue  | tagdetails_ratiogreaterthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord2_RatioGreater5MatchFullTrue  | tagdetails_ratiogreaterthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord3_RatioGreater5MatchFullTrue  | tagdetails_ratiogreaterthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord4_RatioGreater5MatchFullTrue  | tagdetails_ratiogreaterthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord5_RatioGreater5MatchFullTrue  | tagdetails_ratiogreaterthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord6_RatioGreater5MatchFullTrue  | tagdetails_ratiogreaterthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord7_RatioGreater5MatchFullTrue  | tagdetails_ratiogreaterthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord8_RatioGreater5MatchFullTrue  | tagdetails_ratiogreaterthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord9_RatioGreater5MatchFullTrue  | tagdetails_ratiogreaterthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord10_RatioGreater5MatchFullTrue | tagdetails_ratiogreaterthan05matchfulltrue |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField                               | tableName                                 |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createRatioLesser5MatchFullTrue          | tagdetails_ratiolesserthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord1_RatioLesser5MatchFullTrue  | tagdetails_ratiolesserthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord2_RatioLesser5MatchFullTrue  | tagdetails_ratiolesserthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord3_RatioLesser5MatchFullTrue  | tagdetails_ratiolesserthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord4_RatioLesser5MatchFullTrue  | tagdetails_ratiolesserthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord5_RatioLesser5MatchFullTrue  | tagdetails_ratiolesserthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord6_RatioLesser5MatchFullTrue  | tagdetails_ratiolesserthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord7_RatioLesser5MatchFullTrue  | tagdetails_ratiolesserthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord8_RatioLesser5MatchFullTrue  | tagdetails_ratiolesserthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord9_RatioLesser5MatchFullTrue  | tagdetails_ratiolesserthan05matchfulltrue |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertRecord10_RatioLesser5MatchFullTrue | tagdetails_ratiolesserthan05matchfulltrue |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField                 | tableName     |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTableDataProfiling   | DataProfiling |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | InsertDataProfilingRecord1 | DataProfiling |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | InsertDataProfilingRecord2 | DataProfiling |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | InsertDataProfilingRecord3 | DataProfiling |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField                     | tableName         |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createCounterTable             | popular_count     |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | UpdateCounterTable             | popular_count     |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTableRace                | race              |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTableComplexDataTypes    | ComplexDataTypes  |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTableComplexDataTypes1   | ComplexDataTypes1 |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTableComplexDataTypes2   | ComplexDataTypes2 |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | InsertRecord1_ComplexDataTypes | ComplexDataTypes  |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | InsertRecord2_ComplexDataTypes | ComplexDataTypes  |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | InsertRecord3_ComplexDataTypes | ComplexDataTypes1 |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | InsertRecord4_ComplexDataTypes | ComplexDataTypes2 |
#    And user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField                            | keySpaceName          |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createIndexTable1                     | rank_by_year_and_name |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | InsertIndexRecord1                    | rank_by_year_and_name |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | InsertIndexRecord2                    | rank_by_year_and_name |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createIndexTable2                     | cyclist_alt_stats     |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | InsertIndexRecord3                    | cyclist_alt_stats     |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createIndexonCompositePartitionColumn | rank_by_year_and_name |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createIndexonclusteringKeyColumn      | rank_by_year_and_name |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createMultipleIndexColumn1            | cyclist_alt_stats     |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createMultipleIndexColumn2            | cyclist_alt_stats     |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createIndexonListColumn               | ComplexDataTypes      |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createIndexonSetColumn                | ComplexDataTypes      |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createIndexonMapKEYSColumn            | ComplexDataTypes      |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createIndexonMapENTRIESColumn         | ComplexDataTypes1     |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createIndexonMapVALUESColumn          | ComplexDataTypes1     |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createIndexonFrozenListVALUESColumn   | ComplexDataTypes2     |
#    And sync the test execution for "180" seconds

    ########################################## Verify table exist##################################################

  Scenario: SC#01 MLP_7662_Verify whether below tables are available
    Given user validate if the table "userdetailstc1" exists in "automationkeyspace"
    Given user validate if the table "multiplepart" exists in "automationkeyspace"
    Given user validate if the table "userdetailscompound" exists in "automationkeyspace"
    Given user validate if the table "userdetailspartitioning" exists in "automationkeyspace"
    Given user validate if the table "altertablestudent" exists in "automationkeyspace"
    Given user validate if the table "alldatatypes" exists in "automationkeyspace"
    Given user validate if the table "listwidetable" exists in "automationkeyspace"
    Given user validate if the table "maptable" exists in "automationkeyspace"
    Given user validate if the table "settable" exists in "automationkeyspace"
    Given user validate if the table "ComplexDataTypes" exists in "AutomationKeySpace"
    Given user validate if the table "ComplexDataTypes1" exists in "AutomationKeySpace"
    Given user validate if the table "ComplexDataTypes2" exists in "AutomationKeySpace"
    Given user validate if the table "rank_by_year_and_name" exists in "AutomationKeySpace"
    Given user validate if the table "cyclist_alt_stats" exists in "AutomationKeySpace"
    Given user validate if the table "table1" exists in "keyspace1"
    Given user validate if the table "table2" exists in "keyspace1"
    Given user validate if the table "table3" exists in "keyspace1"
    Given user validate if the table "table1" exists in "keyspace2"
    Given user validate if the table "table4" exists in "keyspace2"
    Given user validate if the table "table1" exists in "keyspace3"
    Given user validate if the table "table5" exists in "keyspace3"

  ###############################################Pre-Condition (Credential and BA Tag)##############################

  @sanity @positive @regression @IDA_E2E
  Scenario Outline:SC#02 Add valid Credentials and Bussiness Tag for Cassandra
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                              | body                                                    | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCassandraCredentials | idc/EdiBusPayloads/credentials/EDIBusValidCassandraCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/CassandraCredentials        | ida/cassandraPayloads/CassandraCredentials.json         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/CassandraCredentials        |                                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/CassandraInvalidCredentials | ida/cassandraPayloads/CassandraInvalidCredential.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/CassandraInvalidCredentials |                                                         | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root                               | ida/cassandraPayloads/businessApplicationCataloger.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root                               | ida/cassandraPayloads/businessApplicationAnalyzer.json  | 200           |                  |          |

  ####################################UI Testing for Test Connection (Datasource and Cataloger)##################################
  ##7097004##
  @positve @regression @sanity @webtest
  Scenario:SC#03_Verify whether the background of the panel is displayed in red when connection is unsuccessful due to invalid Host/Port in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem          |
      | mouse hover | Settings Icon       |
      | click       | Settings Icon       |
      | click       | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | CassandraDBDataSource |
      | Credential       | CassandraCredentials  |
      | Node             | LocalNode             |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute        |
      | Name      | CassandraDS_Test |
      | Label     | CassandraDS_Test |
      | Host      | decheh           |
      | Port      | 9042             |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"
    And user "enter text" in Add Data Source Page
      | fieldName | attribute             |
      | Host      | dechehdpqa01v.asg.com |
      | Port      | 90                    |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Failed datasource connection" is "displayed" in "Add Data Sources Page"
    And user verifies "Save Button" is "enabled" in "Add Configuration pop up"


  ##7097002##
  @positve @regression @sanity @webtest
  Scenario:SC#03_Verify whether the background of the panel is displayed in green when connection is successful in Step1 pop up when user logs in for the first time in Local Node
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem          |
      | mouse hover | Settings Icon       |
      | click       | Settings Icon       |
      | click       | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | CassandraDBDataSource |
      | Credential       | CassandraCredentials  |
      | Node             | LocalNode             |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute             |
      | Name      | CassandraDS_Test      |
      | Label     | CassandraDS_Test      |
      | Host      | dechehdpqa01v.asg.com |
      | Port      | 9042                  |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Data Sources Page"
    And user "click" on "Save" button in "Add Data Sources Page"


  #7097003##
  @webtest
  Scenario:SC#03_Verify whether the background in the Cataloger panel is green when connection is successful due to valid Credentials
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem            |
      | mouse hover | Settings Icon         |
      | click       | Settings Icon         |
      | click       | Manage Configurations |
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName  | attribute            |
      | Type       | Cataloger            |
      | Plugin     | CassandraDBCataloger |
      | Credential | CassandraCredentials |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute                 |
      | Name      | CassandraDBCataloger_Test |
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName   | attribute            |
      | Data Source | CassandraDS_Test     |
      | Credential  | CassandraCredentials |
    And user "click" on "Test Connection" button in "Add Data Sources Page"
    And user verifies "Successful datasource connection" is "displayed" in "Add Configuration Sources Page"
    And user "click" on "Save" button in "Add Configuration Sources Page"

  @MLP-14874 @webtest
  Scenario: SC#3 Verify Caption and tool tip for Cassandra DataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType  | actionItem          |
      | mouse hover | Settings Icon       |
      | click       | Settings Icon       |
      | click       | Manage Data Sources |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName        | attribute             |
      | Data Source Type | CassandraDBDataSource |
    And user should scroll to the left of the screen
    Then user "Verify the presnce of captions" in Plugin Configuration page
      | Name*       |
      | Label       |
      | Host*       |
      | Port        |
      | Credential* |
      | Node        |


  ################################DryRun-Cataloger################################################3

  ##7096995##
  @webtest
  Scenario: SC#04_Verify the Dry run feature in CassandraDBCataloger
    Given user "update" the json file "ida/cassandraPayloads/CassandraCatalogConfig_DryRun.json" file for following values
      | jsonPath  | jsonValues | type    |
      | $..dryRun | true       | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                     | response code | response message | jsonPath                                                      |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json           | 204           |                  |                                                               |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                          | 200           |                  | CassandraDS                                                   |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/CassandraCatalogConfig_DryRun.json | 204           |                  |                                                               |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                          | 200           |                  | CassandraCatalogerDryRun                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                          | 200           | IDLE             | $.[?(@.configurationName=='CassandraCatalogerDryRun')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                          | 200           |                  |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                          | 200           | IDLE             | $.[?(@.configurationName=='CassandraCatalogerDryRun')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CasTag" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CassandraDBCataloger/CassandraCatalogerDryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "cataloger/CassandraDBCataloger/CassandraCatalogerDryRun%" should display below info/error/warning
      | type | logValue                                                                                        | logCode       | pluginName           | removableText |
      | INFO | Plugin CassandraDBCataloger running on dry run mode                                             | ANALYSIS-0069 | CassandraDBCataloger |               |
      | INFO | Plugin CassandraDBCataloger processed 2 items on dry run mode and not written to the repository | ANALYSIS-0070 | CassandraDBCataloger |               |
      | INFO | Plugin completed                                                                                | ANALYSIS-0020 |                      |               |


  Scenario:SC#04_Delete the dry run cataloger Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                     | type     | query | param |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/CassandraCatalogerDryRun% | Analysis |       |       |


    ######################################Cassandra Cataloger Case##########################################

  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#05_MLP_7662_Verify JDBC Cataloger collects items properly if the url does not contain keyspacename but the Database field contains keyspacename.
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                              | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json    | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                   | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/CassandraCatalogConfig.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                   | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                   | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                   | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                   | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdetailstc1" and clicks on search
    And user performs "facet selection" in "userdetailstc1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userdetailstc1" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | firstname | verify widget contains |                  |             |
      | Columns | lastname  | verify widget contains |                  |             |
      | Columns | id        | verify widget contains |                  |             |


######################################EDI Case for Cassandra#####################################################

#  ##7096995##
#  @sanity @positive @webtest @edibus
#  Scenario: SC#06 MLP-9043_Verify the CassandraDB items are replicated to EDI
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "Cassandra" and clicks on search
#    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
#    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
#      | Column     |
#      | Table      |
#      | Constraint |
#      | Analysis   |
#      | Cluster    |
#      | Database   |
#      | Host       |
#      | Service    |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | CASSANDRADB | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And user update json file "idc/EdiBusPayloads/datasource/EDIBusDS_Cassandra.json" file for following values using property loader
#      | jsonPath        | jsonValues  |
#      | $..['EDI host'] | EDIHostName |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                                  | response code | response message | jsonPath                                             |
#      | application/json | raw   | false | Put          | settings/analyzers/EDIBusDataSource                                  | idc/EdiBusPayloads/datasource/EDIBusDS_Cassandra.json | 204           |                  |                                                      |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/CassandraDBConfig.json             | 204           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/CassandraDB_EDI |                                                       | 200           | IDLE             | $.[?(@.configurationName=='CassandraDB_EDI')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/CassandraDB_EDI  |                                                       | 200           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/CassandraDB_EDI |                                                       | 200           | IDLE             | $.[?(@.configurationName=='CassandraDB_EDI')].status |
#    And user enters the search text "CassandraDB_EDI" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/CassandraDB_EDI%"
#    Then the following metadata values should be displayed
#      | metaDataAttribute | metaDataValue | widgetName  |
#      | Number of errors  | 0             | Description |
#    And user enters the search text "Cassandra" and clicks on search
#    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                     |
#      | AP-DATA      | CASSANDRADB | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                           |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/NoSQL Databases/Cassandra |
#      | $..selections.['type_s'][*]                   | Database                                             |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                      | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=Cassandra&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | CASSANDRADB | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
#    And user enters the search text "Cassandra" and clicks on search
#    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Table" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                          |
#      | AP-DATA      | CASSANDRADB | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                           |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/NoSQL Databases/Cassandra |
#      | $..selections.['type_s'][*]                   | Table                                                |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                      | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=Cassandra&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
#      | AP-DATA      | CASSANDRADB | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
#    And user enters the search text "Cassandra" and clicks on search
#    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Column" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
#      | AP-DATA      | CASSANDRADB | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN) |
#    And user update the json file "idc/EdiBusPayloads/TagFilter.json" file for following values
#      | jsonPath                                      | jsonValues                                           |
#      | $..selections.['asg.tagPathsHierarchy_ss'][*] | Technology/Enterprise Data/NoSQL Databases/Cassandra |
#      | $..selections.['type_s'][*]                   | Column                                               |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                                                                      | body                              | response code | response message | jsonPath |
#      |        |       |       | Post | searches/fulltext/Default?query=Cassandra&advanced=false&natural=false&limit=1000&offset=0&limitFacets=1 | idc/EdiBusPayloads/TagFilter.json | 200           |                  |          |
#    And user stores the values in list from response using jsonpath "$..name"
#    And user connects Rochade Server and "compare itemNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
#      | AP-DATA      | CASSANDRADB | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
#    And user enters the search text "Cassandra" and clicks on search
#    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
#    And user performs "facet selection" in "Service" attribute under "Type" facets in Item Search results page
#    And user gets the items search count
#    And user connects Rochade Server and "compare count" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
#      | AP-DATA      | CASSANDRADB | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM) |
#    And user connects Rochade Server and "verify itemCount notNull" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                |
#      | AP-DATA      | CASSANDRADB | 1.0                | (XNAME * *  ~/ @*Cassandra≫DEFAULT≫DWR_RDB_COLUMN≫@* ) ,AND,( TYPE = DWR_IDC )       |
#      | AP-DATA      | CASSANDRADB | 1.0                | (XNAME * *  ~/ @*Cassandra≫DEFAULT≫DWR_RDB_TABLE_OR_VIEW≫@* ),AND,( TYPE = DWR_IDC ) |
#      | AP-DATA      | CASSANDRADB | 1.0                | (XNAME * *  ~/ @*Cassandra≫DEFAULT≫DWR_RDB_DATABASE≫@* ),AND,( TYPE = DWR_IDC )      |
#      | AP-DATA      | CASSANDRADB | 1.0                | (XNAME * *  ~/ @*Cassandra≫DEFAULT≫DWR_RDB_DB_SYSTEM≫@* ),AND,( TYPE = DWR_IDC )     |


    #################################Technology, Explicit and BA Tag for Cataloger##########################################

  ##7096995##
  @sanity @positive @MLP-7660 @webtest @IDA-10.0
  Scenario: SC#07 Verify the technology tags, Explicit tag and BusinessApplication tag got assigned to all Cassandra DB items like Cluster,Service,Database...etc
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Cassandra,CasTag,CassandraCatalogerBA" should get displayed for the column "cataloger/CassandraDBCataloger"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                   | fileName                  | userTag   |
      | Default     | Column     | Metadata Type | Cassandra,CasTag,CassandraCatalogerBA | firstname                 | Cassandra |
      | Default     | Table      | Metadata Type | Cassandra,CasTag,CassandraCatalogerBA | userdetailstc1            | Cassandra |
      | Default     | Cluster    | Metadata Type | Cassandra,CasTag,CassandraCatalogerBA | dechehdpqa01v.asg.com     | Cassandra |
      | Default     | Host       | Metadata Type | Cassandra,CasTag,CassandraCatalogerBA | dechehdpqa01v.asg.com     | Cassandra |
      | Default     | Database   | Metadata Type | Cassandra,CasTag,CassandraCatalogerBA | automationkeyspace        | Cassandra |
      | Default     | Constraint | Metadata Type | Cassandra,CasTag,CassandraCatalogerBA | USERDETAILSTC1_PRIMARYKEY | Cassandra |
      | Default     | Service    | Metadata Type | Cassandra,CasTag,CassandraCatalogerBA | CASSANDRA                 | Cassandra |


    ######################################Cassandra Cataloger Case##########################################


  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#08 MLP_7662_Verify the metadata information for Host attribute
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "facet selection" in "Host" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "dechehdpqa01v.asg.com" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue         | widgetName  |
      | Number of cores   | 0                     | Statistics  |
      | Host name         | dechehdpqa01v.asg.com | Description |


  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#08 MLP_7662_Verify the metadata information for Service attribute
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CASSANDRA" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute   | metaDataValue                                 | widgetName  |
      | Application Version | CData JDBC Driver for Cassandra 201919.0.7037 | Description |


  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#08 MLP_7662_Verify the metadata information for Table attribute
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdetailstc1" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userdetailstc1" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |


  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#08 MLP_7662_Verify the metadata information for DataBase attribute
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "automationkeyspace" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                 | widgetName  |
      | Storage type      | CData JDBC Driver for Cassandra 201919.0.7037 | Description |


  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#08 MLP_7662_Verify JDBC cataloger scans and collects primary key constraints but does not collect index in cassandra tables
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "USERDETAILSTC1_PRIMARYKEY " and clicks on search
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | USERDETAILSTC1_PRIMARYKEY |


  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#08 MLP_7662_Verify the metadata information for Column attribute and the breadcrumb values
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdetailstc1" and clicks on search
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "id" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | dechehdpqa01v.asg.com |
      | CASSANDRA             |
      | automationkeyspace    |
      | userdetailstc1        |
      | id                    |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | UUID          | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute  | widgetName |
      | Last catalogued at | Lifecycle  |


  ##7096995##
  @webtest
  Scenario: SC#08_Verify the Processed Item count and widget and Logging enhancement in CassandraDBCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "cataloger/CassandraDBCataloger/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
#      | Number of errors          | 0             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | dechehdpqa01v.asg.com |
      | CASSANDRA             |
    Then Analysis log "cataloger/CassandraDBCataloger/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                           | logCode       | pluginName           | removableText  |
      | INFO | Plugin started                                                                                                                                                                     | ANALYSIS-0019 |                      |                |
      | INFO | Plugin Name:CassandraDBCataloger, Plugin Type:cataloger, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:64918117aadc, Plugin Configuration name:Cassandra Cataloger | ANALYSIS-0071 | CassandraDBCataloger | Plugin Version |
#      | INFO | Plugin CassandraDBCataloger Configuration: --- 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: name: "Cassandra Cataloger" 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: pluginVersion: "LATEST" 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: label: 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: : "Cassandra Cataloger" 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: catalogName: "Default" 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: eventClass: null 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: eventCondition: null 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: nodeCondition: "name==\"LocalNode\"" 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: maxWorkSize: 100 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: tags: 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: - "CasTag" 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: pluginType: "cataloger" 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: dataSource: "CassandraDS" 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: credential: "CassandraCredentials" 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: businessApplicationName: "CassandraCatalogerBA" 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: dryRun: false 2020-09-01 09:26:20.098 INFO  - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: schedule: null 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: filter: null 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: tables: 2020-06-09 06:54:28.002 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: - table: "userdetailstc1" 2020-06-09 06:54:28.003 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: pluginName: "CassandraDBCataloger" 2020-06-09 06:54:28.003 INFO - ANALYSIS-0073: Plugin CassandraDBCataloger Configuration: type: "Cataloger" | ANALYSIS-0073 | CassandraDBCataloger |                |
#      | INFO | Plugin CassandraDBCataloger Start Time:2020-06-09 06:54:28.001, End Time:2020-06-09 06:54:28.490, Processed Count:2, Errors:0, Warnings:0                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | ANALYSIS-0072 | CassandraDBCataloger |                |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:00.489)                                                                                                                     | ANALYSIS-0020 |                      |                |


  Scenario:SC#08:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/% | Analysis |       |       |
#      | MultipleIDDelete | Default | bulk/EDIBus/CassandraDB_EDI/%    | Analysis |       |       |


    ###################################Compound Partioning (Multiple Partitioning Key,Clustering Key)########################

  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#09 MLP_7662_Verify JDBC cataloger scans and collects Cluster,Service,KeySpace,Tables,columns if the table contains Compound Partitioning key(Multiple Partitioning Key,Clustering Key)
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                  | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json        | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                       | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/CassandraCatalogCompConfig.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                       | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                       | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "facet selection" in "multiplepart [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "multiplepart" item from search results
    Then user performs click and verify in new window
      | Table   | value    | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | category | verify widget contains |                  |             |
      | Columns | points   | verify widget contains |                  |             |
      | Columns | lastname | verify widget contains |                  |             |
      | Columns | id       | verify widget contains |                  |             |


  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario:  SC#09 MLP_7662_Verify JDBC cataloger scans and collects constraints if the table contains Compound Partitioning key(Multiple Partitioning Key,Clustering Key) in UI
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "facet selection" in "multiplepart [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Constraint" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | MULTIPLEPART_PRIMARYKEY |

  Scenario:SC#09 Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com            | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/% | Analysis |       |       |


    #############################Compound Primary Key(Partitioning Key,Clustering Key)##############################


  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#10 MLP_7662_Verify JDBC cataloger scans and collects Cluster,Service,KeySpace,Tables,columns if the table contains Compound Primary Key(Partitioning Key,Clustering Key) - Wide rows
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json      | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                     | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/CassandraCPCatalogConfig.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                     | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                     | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                     | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                     | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdetailscompound" and clicks on search
    And user performs "facet selection" in "userdetailscompound [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userdetailscompound" item from search results
    Then user performs click and verify in new window
      | Table   | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | tweetmessage | verify widget contains |                  |             |
      | Columns | email        | verify widget contains |                  |             |
      | Columns | username     | verify widget contains |                  |             |
      | Columns | tweet_id     | verify widget contains |                  |             |

  Scenario:SC#10 Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com            | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/% | Analysis |       |       |


  #############################Primary Key(Partitioning Key)##############################################

  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario:SC#11 MLP_7662_Verify JDBC cataloger scans and collects Cluster,Service,KeySpace,Tables,columns if the table contains Primary Key(Partitioning Key) and cataloger ran in InternalNode
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                       | body                                                       | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                                  | ida/cassandraPayloads/CassandraDataSourceInternalNode.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                  |                                                            | 200           |                  | CassandraDSInternalNode                                  |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                   | ida/cassandraPayloads/CassandraPartKeyConfig.json          | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                   |                                                            | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/CassandraDBCataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/CassandraDBCataloger/*  |                                                            | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/CassandraDBCataloger/* |                                                            | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "userdetailspartitioning" and clicks on search
    And user performs "facet selection" in "userdetailspartitioning [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userdetailspartitioning" item from search results
    Then user performs click and verify in new window
      | Table   | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | tweetmessage | verify widget contains |                  |             |
      | Columns | email        | verify widget contains |                  |             |
      | Columns | username     | verify widget contains |                  |             |

  Scenario:SC#11 Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com            | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/% | Analysis |       |       |


    #######################dynamic rows and columns using Alter table#################################################################

  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#12 MLP_7662_Verify JDBC cataloger scans and collects dynamic rows and columns using Alter table option in IDC UI
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                               | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json     | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                    | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/CassandraAltTableConfig.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                    | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                    | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                    | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                    | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "facet selection" in "altertablestudent [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "altertablestudent" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | id    | verify widget contains |                  |             |
      | Columns | age   | verify widget contains |                  |             |
      | Columns | name  | verify widget contains |                  |             |
      | Columns | phone | verify widget contains |                  |             |

  Scenario:SC#12 Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com            | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/% | Analysis |       |       |


  ###########################Data Type Verification for all data types(Simple Data Type)########################################

  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#13 MLP_7662_Verify JDBC cataloger scans and collects Table and columns properly if the table contains possible different built in data types
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                   | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json         | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                        | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/CassandraAllDataTypesConfig.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                        | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                        | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                        | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                        | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "alldatatypes" and clicks on search
    And user performs "facet selection" in "alldatatypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 27 items" in Item Search results page
    And user performs "item click" on "alldatatypes" item from search results
    Then user performs click and verify in new window
      | Table   | value          | Action                    | RetainPrevwindow | indexSwitch | filePath                                    | jsonPath         | metadataSection |
      | Columns | asciidata      | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.asciidata      | Description     |
      | Columns | bigintdata     | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.bigintdata     | Description     |
      | Columns | blobdata       | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.blobdata       | Description     |
      | Columns | booleandata    | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.booleandata    | Description     |
      | Columns | commission_pct | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.commission_pct | Description     |
      | Columns | datedata       | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.datedata       | Description     |
      | Columns | decimaldata    | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.decimaldata    | Description     |
      | Columns | department_id  | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.department_id  | Description     |
      | Columns | doubledata     | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.doubledata     | Description     |
      | Columns | smallintdata   | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.smallintdata   | Description     |
      | Columns | timedata       | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.timedata       | Description     |
      | Columns | timestampdata  | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.timestampdata  | Description     |
      | Columns | tinyintdata    | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.tinyintdata    | Description     |


  Scenario:SC#13:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/% | Analysis |       |       |


  ##################################List Table################################################################

  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario:SC#14 MLP_7662_Verify JDBC cataloger scans and collects table with collection columns as List - Wide columns
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json      | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                     | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/CassandraListTableConfig.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                     | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                     | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                     | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                     | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "listwidetable" and clicks on search
    And user performs "facet selection" in "listwidetable [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "listwidetable" item from search results
    Then user performs click and verify in new window
      | Table   | value  | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | emails | verify widget contains |                  |             |
      | Columns | name   | verify widget contains |                  |             |


  Scenario:SC#14:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com            | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/% | Analysis |       |       |


    ###################################Map Table##############################################################

  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#15 MLP_7662_ Verify JDBC cataloger scans and collects table with collection columns as Map - Wide columns
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                               | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json     | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                    | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/CassandraMapTableConfig.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                    | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                    | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                    | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                    | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "facet selection" in "maptable [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "maptable" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | firstname | verify widget contains |                  |             |
      | Columns | teams     | verify widget contains |                  |             |
      | Columns | lastname  | verify widget contains |                  |             |
      | Columns | id        | verify widget contains |                  |             |

  Scenario:SC#15:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com            | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/% | Analysis |       |       |


################################Set Table #########################################################################3


  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#16 MLP_7662_Verify JDBC cataloger scans and collects table with collection columns as Set- Wide columns
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                               | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json     | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                    | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/CassandraSetTableConfig.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                    | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                    | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                    | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                    | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "settable" and clicks on search
    And user performs "facet selection" in "settable [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "settable" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | firstname | verify widget contains |                  |             |
      | Columns | teams     | verify widget contains |                  |             |
      | Columns | lastname  | verify widget contains |                  |             |
      | Columns | id        | verify widget contains |                  |             |

  Scenario:SC#16:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com            | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/% | Analysis |       |       |


#  @sanity @positive @MLP-7662 @webtest @IDA-10.0
#  Scenario: SC#17 Verify JDBC cataloger scans and collects Table and columns properly if the table contains possible different user defined data types
#    Given user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField               | tableName   |
#      | CASSANDRA    | create    | createTable    | json/IDA.json | cassandraQueries | createTableUserDataTypes | UserDefined |
#      | CASSANDRA    | create    | insertData     | json/IDA.json | cassandraQueries | insertUserDef1           | UserDefined |


  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#17 MLP_7662_Verify JDBC Cataloger collects items properly if the url does not contain keyspacename but the Database field contains keyspacename.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                  | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json        | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                       | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/CassandraInvalidDriverName.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                       | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                       | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user enters the search text "userdetailstc1" and clicks on search
    And user performs "facet selection" in "userdetailstc1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "userdetailstc1" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | firstname | verify widget contains |                  |             |
      | Columns | lastname  | verify widget contains |                  |             |
      | Columns | id        | verify widget contains |                  |             |


  Scenario:SC#17:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/% | Analysis |       |       |


    ################################Error Message Validation###########################################

  @webtest @MLP-2645 @positive @regression @pluginManager
  Scenario: SC#18 MLP_7662_Verify Cassandra error message in IDC UI when the mandatory fields not entered in CassandraDBCataloger
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem |
      | Open Deployment | LocalNode  |
    And user "click" on "Add Configuration" button under "LocalNode" in Manage Configurations
    And user "select dropdown" in Add Configuration Page in Manage Configurations
      | fieldName | attribute            |
      | Type      | Cataloger            |
      | Plugin    | CassandraDBCataloger |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


  @webtest @MLP-2645 @positive @regression @pluginManager
  Scenario: SC#18 MLP_7662_Verify Cassandra error message in IDC UI when the mandatory fields not entered in CassandraDBDataSource
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem                   |
      | click      | Capture And Import Data Icon |
      | click      | Manage Data Sources          |
    And user "click" on "Add Data Source Button in Manage Data Sources Page" button in "Add Data Sources Page"
    And user "select dropdown" in Add Data Source Page
      | fieldName        | attribute             |
      | Data Source Type | CassandraDBDataSource |
    And user "enter text" in Add Data Source Page
      | fieldName | attribute |
      | Name      |           |
      | Host      |           |
#      | Keyspace Name |           |
    And user press "TAB" key using key press event
    Then user "Verify Error message presence" for below parameters in Plugin Configuration page
      | fieldName | errorMessage                   |
      | Name      | Name field should not be empty |
      | Host      | Host field should not be empty |
#      | Keyspace Name | Keyspace Name field should not be empty |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"


    ###########################################Frozen########################################################

  @sanity @positive @MLP-7662 @webtest @IDA-10.0
  Scenario: SC#19 MLP_7662_Verify JDBC cataloger scans and collects Table and columns properly if the table contains possible different user defined data types (FROZEn)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource2.json     | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                     | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/CassandraCatalogerFrozen.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                     | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                     | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                     | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                     | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "facet selection" in "cyclist_races [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "cyclist_races" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | firstname | verify widget contains |                  |             |
      | Columns | lastname  | verify widget contains |                  |             |
      | Columns | id        | verify widget contains |                  |             |
      | Columns | races     | verify widget contains |                  |             |


  Scenario:SC#19:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                             | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com            | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/% | Analysis |       |       |

#    ########################################Cataloger Filter cases##############################################################



  @sanity @positive @MLP-24048 @webtest @IDA-10.0
  Scenario: SC#13 MLP_24048_Verify JDBC cataloger scans and collects Table and columns properly with filter conditions
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                                  | response code | response message | jsonPath                                                     |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json                        | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                                       | 200           |                  | CassandraDS                                                  |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/FilterPayloads/CassandraCatalogerFilterSC1.json | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                                       | 200           |                  | Cassandra_Cataloger_SC1                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC1')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                                       | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC1')].status |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#13 MLP_24048_verify whether multiple keyspace including empty and table filters within same keyspace should be repeated in filter cataloger configuration
    And user update the json file "ida/cassandraPayloads/API/SC1_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                      |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC1_CassandraFilter                             |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/dechehdpqa01v.asg.com/Service/CASSANDRA |
      | $..selections.['type_s'][*]                             | Table                                           |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                           | body                                               | response code | response message | filePath                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC1_CassandraFilter&limitFacet=10&offset=0&limit=20 | payloads/ida/cassandraPayloads/API/SC1_Filter.json | 200           |                  | response\Cassandra\Actual\SC1_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#13 MLP_24048_Compare the tables with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                              | actualValues                              | valueType         | expectedJsonPath | actualJsonPath               |
      | response\Cassandra\Expected\SC1_Filter.json | response\Cassandra\Actual\SC1_Filter.json | stringListCompare | $.SC1.Tables[*]  | $..[?(@.type=='Table')].name |

  @MLP-24048  @sanity @positive
  Scenario:DryRunSC#13:Delete all the External Packages and anlysis with respect to commonlinker
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type     | query | param |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/Cassandra_Cataloger_SC1% | Analysis |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                                   | Cluster  |       |       |


  @sanity @positive @MLP-24048 @webtest @IDA-10.0
  Scenario: SC#14 MLP_24048_Verify JDBC cataloger scans and collects Table and columns properly with filter conditions
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                                  | response code | response message | jsonPath                                                     |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json                        | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                                       | 200           |                  | CassandraDS                                                  |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/FilterPayloads/CassandraCatalogerFilterSC2.json | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                                       | 200           |                  | Cassandra_Cataloger_SC2                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC2')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                                       | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC2')].status |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#14 MLP_24048_verify whether multiple keyspace including empty and table filters within same keyspace should be repeated in filter cataloger configuration
    And user update the json file "ida/cassandraPayloads/API/SC1_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                      |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC2_CassandraFilter                             |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/dechehdpqa01v.asg.com/Service/CASSANDRA |
      | $..selections.['type_s'][*]                             | Table                                           |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                           | body                                               | response code | response message | filePath                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC2_CassandraFilter&limitFacet=10&offset=0&limit=20 | payloads/ida/cassandraPayloads/API/SC1_Filter.json | 200           |                  | response\Cassandra\Actual\SC2_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#14 MLP_24048_Compare the tables with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                              | actualValues                              | valueType         | expectedJsonPath | actualJsonPath               |
      | response\Cassandra\Expected\SC1_Filter.json | response\Cassandra\Actual\SC2_Filter.json | stringListCompare | $.SC2.Tables[*]  | $..[?(@.type=='Table')].name |

  @MLP-24048  @sanity @positive
  Scenario:DryRunSC#14:Delete all the Anlaysis and Cluster
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type     | query | param |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/Cassandra_Cataloger_SC2% | Analysis |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                                   | Cluster  |       |       |


  @sanity @positive @MLP-24048 @webtest @IDA-10.0
  Scenario: SC#15 MLP_24048_Verify JDBC cataloger scans and collects Table and columns properly with filter conditions
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                                  | response code | response message | jsonPath                                                     |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json                        | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                                       | 200           |                  | CassandraDS                                                  |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/FilterPayloads/CassandraCatalogerFilterSC3.json | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                                       | 200           |                  | Cassandra_Cataloger_SC3                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC3')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                                       | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC3')].status |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#15 MLP_24048_verify whether multiple keyspace including empty and table filters within same keyspace should be repeated in filter cataloger configuration
    And user update the json file "ida/cassandraPayloads/API/SC1_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                      |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC3_CassandraFilter                             |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/dechehdpqa01v.asg.com/Service/CASSANDRA |
      | $..selections.['type_s'][*]                             | Table                                           |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                           | body                                               | response code | response message | filePath                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC3_CassandraFilter&limitFacet=10&offset=0&limit=20 | payloads/ida/cassandraPayloads/API/SC1_Filter.json | 200           |                  | response\Cassandra\Actual\SC3_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#15 MLP_24048_Compare the tables with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                              | actualValues                              | valueType         | expectedJsonPath | actualJsonPath               |
      | response\Cassandra\Expected\SC1_Filter.json | response\Cassandra\Actual\SC3_Filter.json | stringListCompare | $.SC3.Tables[*]  | $..[?(@.type=='Table')].name |

  @MLP-24048  @sanity @positive
  Scenario:DryRunSC#15:Delete all the Anlaysis and Cluster
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type     | query | param |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/Cassandra_Cataloger_SC3% | Analysis |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                                   | Cluster  |       |       |


  @sanity @positive @MLP-24048 @webtest @IDA-10.0
  Scenario: SC#16 MLP_24048_Verify JDBC cataloger scans and collects Table and columns properly with filter conditions
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                                  | response code | response message | jsonPath                                                     |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json                        | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                                       | 200           |                  | CassandraDS                                                  |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/FilterPayloads/CassandraCatalogerFilterSC4.json | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                                       | 200           |                  | Cassandra_Cataloger_SC4                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC4')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                                       | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC4')].status |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#16 MLP_24048_verify whether multiple keyspace including empty and table filters within same keyspace should be repeated in filter cataloger configuration
    And user update the json file "ida/cassandraPayloads/API/SC1_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                      |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC4_CassandraFilter                             |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/dechehdpqa01v.asg.com/Service/CASSANDRA |
      | $..selections.['type_s'][*]                             | Table                                           |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                           | body                                               | response code | response message | filePath                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC4_CassandraFilter&limitFacet=10&offset=0&limit=20 | payloads/ida/cassandraPayloads/API/SC1_Filter.json | 200           |                  | response\Cassandra\Actual\SC4_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#16 MLP_24048_Compare the tables with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                              | actualValues                              | valueType         | expectedJsonPath | actualJsonPath               |
      | response\Cassandra\Expected\SC1_Filter.json | response\Cassandra\Actual\SC4_Filter.json | stringListCompare | $.SC4.Tables[*]  | $..[?(@.type=='Table')].name |

  @MLP-24048  @sanity @positive
  Scenario:DryRunSC#16:Delete all the Anlaysis and Cluster
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                    | type     | query | param |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/Cassandra_Cataloger_SC4% | Analysis |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                                   | Cluster  |       |       |

    ################Data Sample, Tag (technology, explicit, BA) and Data Profiling######################################

  #7103057## ##7103059## ##BugID-MLP-23970##
  @webtest
  Scenario: SC#20_Verify Datasampling for all datatypes is displayed properly when Cassandra analyzer ran with table filter
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                   | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json         | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                        | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCatalogerNoFilter.json  | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                        | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                        | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                        | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                        | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerWithFilter.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                        | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                        | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                        | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                        | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "alldatatypes" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "alldatatypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "alldatatypes" item from search results
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName |
      | Number of rows    | 3             | Statistics |
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | Asciidata | Bigintdata | Blobdata    | Booleandata | Commission_pct | Datedata   | Decimaldata | Department_id | Doubledata | Email              | Employee_id | First_name | Inetdata       | Job_id | Last_name | Manager_id | Phone_number | Salary | Smallintdata | Timedata | Timestampdata           | Timeuuidsata                         | Tinyintdata | Uuiddata                             | Varchardata | Varintdata |
      | 065       | 23432433   | UNSUPPORTED | false       | 34.4           | 2019-04-07 | 2.43        | 55            | 45.4       | Cassy.j@sample.com | 1237        | Cassey     | 192.168.100.25 | 347    | Johns     | 35         | 032423332    | 129009 | 7000         | 20:00:00 | 2017-05-01 11:21:59.001 | 50554d6e-29bb-11e5-b345-feff819cdc9f | 30          | 50554d6e-29bb-11e5-b345-feff819cdc9f | dataVar2    | 1500       |
      | 065       | 3234323    | UNSUPPORTED | false       | 88.4           | 2019-04-07 | 7.43        | 35            | 34.4       | Tom.h@sample.com   | 1238        | Tom        | 192.168.100.28 | 240    | Hanks     | 25         | 898243988    | 129203 | -72          | 17:00:00 | 2017-01-01 11:21:59.001 | 50554d6e-29bb-11e5-b345-feff819cdc9f | 40          | 50554d6e-29bb-11e5-b345-feff819cdc9f | dataVar3    | 500        |
      | 065       | 3432434232 | UNSUPPORTED | true        | 23.4           | 2017-05-05 | 0.45        | 65            | 34.5       | john.m@sample.com  | 1234        | John       | 192.168.100.21 | 345    | Michael   | 43         | 8989789798   | 129088 | 20000        | 16:00:00 | 2017-04-01 11:21:59.001 | 50554d6e-29bb-11e5-b345-feff819cdc9f | 20          | 50554d6e-29bb-11e5-b345-feff819cdc9f | dataVar     | 2500       |


  ##7103058##
  @webtest @IDA-10.0
  Scenario: SC#20_Verify the technology tags, Explicit tag and BusinessApplication tag got assigned to all Cassandra DB Analyzed items like Cluster,Service,Database...etc
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CassandraAnalyzerBA" and clicks on search
    And user performs "definite facet selection" in "CassandraAnalyzerBA" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "Cassandra,CasAnTag,CassandraAnalyzerBA" should get displayed for the column "dataanalyzer/CassandraDBAnalyzer"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet         | Tag                                                                | fileName                | userTag             |
      | Default     | Column     | Metadata Type | Cassandra,CasTag,CassandraCatalogerBA,CasAnTag,CassandraAnalyzerBA | timedata                | CassandraAnalyzerBA |
      | Default     | Table      | Metadata Type | Cassandra,CasTag,CassandraCatalogerBA,CasAnTag,CassandraAnalyzerBA | alldatatypes            | CassandraAnalyzerBA |
      | Default     | Cluster    | Metadata Type | Cassandra,CasTag,CassandraCatalogerBA,CasAnTag,CassandraAnalyzerBA | dechehdpqa01v.asg.com   | CassandraAnalyzerBA |
      | Default     | Constraint | Metadata Type | Cassandra,CasTag,CassandraCatalogerBA,CasAnTag,CassandraAnalyzerBA | ALLDATATYPES_PRIMARYKEY | CassandraAnalyzerBA |
      | Default     | Service    | Metadata Type | Cassandra,CasTag,CassandraCatalogerBA,CasAnTag,CassandraAnalyzerBA | CASSANDRA               | CassandraAnalyzerBA |


  ##7103059## ##Bug-ID MLP-23971##
  @webtest
  Scenario: SC#20 Verify Data profiling for Interger/Numeric (bigint, smallint, float, decimal, double, integer, tinyint) datatype in CassandraDB Table.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "dataprofiling" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "dataprofiling [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "dataprofiling" item from search results
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | bigintdata | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value          | Action               | RetainPrevwindow | indexSwitch |
      | Columns | commission_pct | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch |
      | Columns | decimaldata | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value         | Action               | RetainPrevwindow | indexSwitch |
      | Columns | department_id | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch |
      | Columns | doubledata | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value        | Action               | RetainPrevwindow | indexSwitch |
      | Columns | smallintdata | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value          | Action                    | RetainPrevwindow | indexSwitch | filePath                                    | jsonPath             | metadataSection |
      | Columns | bigintdata     | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.bigintdataStat     | Statistics      |
      | Columns | commission_pct | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.commission_pctStat | Statistics      |
      | Columns | decimaldata    | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.decimaldataStat    | Statistics      |
      | Columns | department_id  | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.department_idStat  | Statistics      |
      | Columns | doubledata     | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.doubledataStat     | Statistics      |
      | Columns | smallintdata   | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.smallintdataStat   | Statistics      |


  ##7103060##
  @webtest
  Scenario: SC#20_Verify Data profiling for String/VARCHAR datatype in CassandraDB Table.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "dataprofiling" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "dataprofiling [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "dataprofiling" item from search results
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | email | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue      | widgetName  |
      | Data type                     | TEXT               | Description |
      | Maximum length                | 18                 | Statistics  |
      | Maximum value                 | john.m@sample.com  | Statistics  |
      | Minimum length                | 17                 | Statistics  |
      | Minimum value                 | Cassy.j@sample.com | Statistics  |
      | Number of non null values     | 3                  | Statistics  |
      | Percentage of non null values | 100                | Statistics  |
      | Number of null values         | 0                  | Statistics  |
      | Number of unique values       | 2                  | Statistics  |
      | Percentage of unique values   | 66.67              | Statistics  |


  ##7103061##
  @webtest
  Scenario: SC#20_Verify Data profiling for Date,Time,Timestamp datatype in CassandraDB Table.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "dataprofiling" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "dataprofiling [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "dataprofiling" item from search results
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch |
      | Columns | datedata | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Maximum value                 | Apr 7, 2019   | Statistics  |
      | Minimum value                 | May 5, 2017   | Statistics  |
      | Number of non null values     | 3             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 66.67         | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch |
      | Columns | timedata | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIME          | Description |
      | Maximum value                 | 20:00:00      | Statistics  |
      | Minimum value                 | 16:00:00      | Statistics  |
      | Number of non null values     | 3             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 66.67         | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value         | Action               | RetainPrevwindow | indexSwitch |
      | Columns | timestampdata | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue            | widgetName  |
      | Data type                     | TIMESTAMP                | Description |
#      | Length                        | 16                       | Statistics  |
      | Maximum value                 | 2017-05-01T11:21:59.001Z | Statistics  |
      | Minimum value                 | 2017-04-01T11:21:59.001Z | Statistics  |
      | Number of non null values     | 3                        | Statistics  |
      | Percentage of non null values | 100                      | Statistics  |
      | Number of null values         | 0                        | Statistics  |
      | Number of unique values       | 2                        | Statistics  |
      | Percentage of unique values   | 66.67                    | Statistics  |


  Scenario:SC#20:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ###############################Prccessed Widget and Logging enhancement(Analyzer)##########################################

   ##7103062##
  @webtest
  Scenario: SC#21_Verify processed widget, count and Logging enhancement for CassandraDBAnalyzer.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                    | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json          | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                         | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCatalogerWithFilter.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                         | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                         | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                         | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                         | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json    | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                         | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                         | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                         | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                         | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/CassandraDBAnalyzer/%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
#      | Number of errors          | 0             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | dechehdpqa01v.asg.com |
      | CASSANDRA             |
    Then Analysis log "dataanalyzer/CassandraDBAnalyzer/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | logCode       | pluginName          | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | ANALYSIS-0019 |                     |                |
      | INFO | Plugin Name:CassandraDBAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.1.0.SNAPSHOT, Node Name:LocalNode, Host Name:64918117aadc, Plugin Configuration name:CassandraAnalyzer                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            | ANALYSIS-0071 | CassandraDBAnalyzer | Plugin Version |
      | INFO | Plugin CassandraDBAnalyzer Configuration: --- 2020-06-11 08:24:51.184 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: name: "CassandraAnalyzer" 2020-06-11 08:24:51.184 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: pluginVersion: "LATEST" 2020-06-11 08:24:51.184 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: label: 2020-06-11 08:24:51.184 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: : "" 2020-06-11 08:24:51.184 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: catalogName: "Default" 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: eventClass: null 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: eventCondition: null 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: nodeCondition: "name==\"LocalNode\"" 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: maxWorkSize: 100 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: tags: 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: - "CasAnTag" 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: pluginType: "dataanalyzer" 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: dataSource: null 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: credential: null 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: businessApplicationName: "CassandraAnalyzerBA" 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: dryRun: false 2020-09-02 05:26:38.200 INFO  - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: schedule: null 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: filter: null 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: histogramBuckets: 10 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: tables: [] 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: pluginName: "CassandraDBAnalyzer" 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: queryBatchSize: 100 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: sampleDataCount: 25 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: type: "Dataanalyzer" 2020-06-11 08:24:51.185 INFO - ANALYSIS-0073: Plugin CassandraDBAnalyzer Configuration: topValues: 10 | ANALYSIS-0073 | CassandraDBAnalyzer |                |
#      | INFO | Plugin CassandraDBAnalyzer Start Time:2020-06-11 08:24:51.183, End Time:2020-06-11 08:24:52.588, Processed Count:2, Errors:0, Warnings:1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              | ANALYSIS-0072 | CassandraDBAnalyzer |                |
#      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:01.405)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | ANALYSIS-0020 |                     |                |


  ##7103063##
  @webtest
  Scenario: SC#21_Verify CassandraDBAnalyzer analyzes the table when the Analyzer ran without filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "maptable" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "maptable [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "maptable" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | firstname | verify widget contains | No               |             |
      | Columns | firstname | click and switch tab   | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TEXT          | Description |
#      | Length                        | 2000          | Statistics  |
      | Maximum length                | 9             | Statistics  |
      | Maximum value                 | Marianne      | Statistics  |
      | Minimum length                | 4             | Statistics  |
      | Minimum value                 | Anna          | Statistics  |
      | Number of non null values     | 3             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 3             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value        | Action               | RetainPrevwindow | indexSwitch |
      | Tables  | multiplepart | click and switch tab | No               |             |
      | Columns | points       | click and switch tab | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | INT           | Description |
      | Average                       | 1269          | Statistics  |
#      | Length                        | 10            | Statistics  |
      | Maximum value                 | 1269          | Statistics  |
      | Median                        | 1269          | Statistics  |
      | Minimum value                 | 1269          | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
      | Standard deviation            | 0             | Statistics  |
      | Variance                      | 0             | Statistics  |


  Scenario:SC#21:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


    #########################Dry run for cassandraDBAnalyzer####################################################

  ##7103062##
  @webtest
  Scenario: SC#22_Verify the Dry run feature in CassandraDBAnalyzer
    Given user "update" the json file "ida/cassandraPayloads/CassandraCatalogConfig_DryRun.json" file for following values
      | jsonPath  | jsonValues | type    |
      | $..dryRun | false      | boolean |
    Given user "update" the json file "ida/cassandraPayloads/CassandraAnalyzerConfig_DryRun.json" file for following values
      | jsonPath  | jsonValues | type    |
      | $..dryRun | true       | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                      | response code | response message | jsonPath                                                      |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json            | 204           |                  |                                                               |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                           | 200           |                  | CassandraDS                                                   |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCatalogConfig_DryRun.json  | 204           |                  |                                                               |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                           | 200           |                  | CassandraCatalogerDryRun                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                           | 200           | IDLE             | $.[?(@.configurationName=='CassandraCatalogerDryRun')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                           | 200           |                  |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                           | 200           | IDLE             | $.[?(@.configurationName=='CassandraCatalogerDryRun')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerConfig_DryRun.json | 204           |                  |                                                               |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                           | 200           |                  | CassandraAnalyzerDryRun                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                           | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzerDryRun')].status  |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                           | 200           |                  |                                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                           | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzerDryRun')].status  |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CasAnTag" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "dataanalyzer/CassandraDBAnalyzer/CassandraAnalyzerDryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue |
      | Number of processed items | 0             |
      | Number of errors          | 0             |
    And user "widget not present" on "Processed Items" in Item view page
    Then Analysis log "dataanalyzer/CassandraDBAnalyzer/CassandraAnalyzerDryRun%" should display below info/error/warning
      | type | logValue                                                                                       | logCode       | pluginName          | removableText |
      | INFO | Plugin CassandraDBAnalyzer running on dry run mode                                             | ANALYSIS-0069 | CassandraDBAnalyzer |               |
      | INFO | Plugin CassandraDBAnalyzer processed 0 items on dry run mode and not written to the repository | ANALYSIS-0070 | CassandraDBAnalyzer |               |
      | INFO | Plugin completed                                                                               | ANALYSIS-0020 |                     |               |


  Scenario:SC#22:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  #########################################PII Tag cases######################################################

  Scenario Outline:SC#23_Create root tag and sub tag and data pattern tag for Cassandra
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                          | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/cassandraPayloads/policyEngine/cassandraTagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/cassandraPayloads/policyEngine/policy1.1.0_sc1.json       | 204           |                  |          |


  ##7103064##
  @webtest @PIITag
  Scenario: SC#24_Verify Tag is set for the column when typePattern(Varchar) and dataPattern/minimumRatio matches with the column type/value ratio in cassandra table.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                            | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                  | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                 | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCatalogerWithPIITableFilter.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                 | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                 | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json            | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                 | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                 | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_allmatch [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_allmatch" item from search results
    Then user performs click and verify in new window
      | Table   | value                                       | Action               | RetainPrevwindow | indexSwitch | verify         | tag                      |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagAssigned    | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagAssigned    | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagAssigned    | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagAssigned    | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagAssigned    | CassandraIPAddressPIITag |
      | Tables  | tagdetails_allempty                         | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagAssigned    | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagAssigned    | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagAssigned    | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiolessthan05emptyfalse        | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagAssigned    | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagAssigned    | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagAssigned    | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiogreaterthan05emptyfalsetrue | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagAssigned    | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagAssigned    | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagAssigned    | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagAssigned    | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratioequalto05emptyfalse         | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagAssigned    | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagAssigned    | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagAssigned    | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagAssigned    | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagAssigned    | CassandraIPAddressPIITag |


  Scenario:SC#24:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ##7103065##
  @webtest @PIITag
  Scenario: SC#25_Verify Tag is not set for the column when typePattern(other than String) and dataPattern/minimumRatio matches with the column type/value ratio in Cassandra table.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                            | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc2.json         | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                  | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                 | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCatalogerWithPIITableFilter.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                 | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                 | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json            | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                 | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                 | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_allmatch" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_allmatch [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_allmatch" item from search results
    Then user performs click and verify in new window
      | Table   | value                                       | Action               | RetainPrevwindow | indexSwitch | verify         | tag                      |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_allempty                         | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiolessthan05emptyfalse        | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiogreaterthan05emptyfalsetrue | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratioequalto05emptyfalse         | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiogreaterthan05matchfulltrue  | click and switch tab | No               |             |                |                          |
      | Columns | comments                                    | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | name                                        | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | rollnumber                                  | click and verify tag | No               | 1           | TagNotAssigned | CassandraFullMatchPIITag |
      | Tables  | tagdetails_ratiolesserthan05matchfulltrue   | click and switch tab | No               |             |                |                          |
      | Columns | comments                                    | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | name                                        | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | rollnumber                                  | click and verify tag | No               | 1           | TagNotAssigned | CassandraFullMatchPIITag |


  Scenario:SC#25:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ##7103066##
  @webtest @PIITag
  Scenario: SC#26_Verify Tag is set for the column when namePattern and dataPattern/minimumRatio matches with the column name/value ratio in Cassandra table.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                            | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc3.json         | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                  | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                 | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCatalogerWithPIITableFilter.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                 | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                 | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json            | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                 | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                 | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_allmatch" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_allmatch [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_allmatch" item from search results
    Then user performs click and verify in new window
      | Table   | value                                       | Action               | RetainPrevwindow | indexSwitch | verify         | tag                      |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagAssigned    | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagAssigned    | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagAssigned    | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagAssigned    | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagAssigned    | CassandraIPAddressPIITag |
      | Tables  | tagdetails_allempty                         | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagAssigned    | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagAssigned    | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagAssigned    | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiolessthan05emptyfalse        | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagAssigned    | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagAssigned    | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagAssigned    | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiogreaterthan05emptyfalsetrue | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagAssigned    | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagAssigned    | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagAssigned    | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagAssigned    | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratioequalto05emptyfalse         | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagAssigned    | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagAssigned    | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagAssigned    | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagAssigned    | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagAssigned    | CassandraIPAddressPIITag |


  Scenario:SC#26:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ##7103067##
  @webtest @PIITag
  Scenario: SC#27_Verify Tag is not set for the column when namePattern(does not match) and dataPattern/minimumRatio that does not matches with the column name/value ratio in Cassandra table.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                            | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc4.json         | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                  | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                 | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCatalogerWithPIITableFilter.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                 | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                 | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json            | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                 | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                 | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_allmatch" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_allmatch [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_allmatch" item from search results
    Then user performs click and verify in new window
      | Table   | value                                       | Action               | RetainPrevwindow | indexSwitch | verify         | tag                      |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_allempty                         | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiolessthan05emptyfalse        | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiogreaterthan05emptyfalsetrue | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratioequalto05emptyfalse         | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiogreaterthan05matchfulltrue  | click and switch tab | No               |             |                |                          |
      | Columns | comments                                    | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | name                                        | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | rollnumber                                  | click and verify tag | No               | 1           | TagNotAssigned | CassandraFullMatchPIITag |
      | Tables  | tagdetails_ratiolesserthan05matchfulltrue   | click and switch tab | No               |             |                |                          |
      | Columns | comments                                    | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | name                                        | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | rollnumber                                  | click and verify tag | No               | 1           | TagNotAssigned | CassandraFullMatchPIITag |


  Scenario:SC#27:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ##7103068##
  @webtest @PIITag
  Scenario: SC#28_Verify Tag is not set for the column when namePattern(does not match) and dataPattern/minimumRatio that does not matches with the column name/value ratio in Cassandra table.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                               | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc5.json            | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                     | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                    | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCataloger_RatioLess5EmptyFalse.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                    | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                    | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                    | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                    | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json               | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                    | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                    | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_ratiolessthan05emptyfalse" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_ratiolessthan05emptyfalse [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_ratiolessthan05emptyfalse" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | verify      | tag                      |
      | Columns | gender    | click and verify tag | No               | 0           | TagAssigned | CassandraGenderPIITag    |
      | Columns | email     | click and verify tag | No               | 0           | TagAssigned | CassandraEmailPIITag     |
      | Columns | full_name | click and verify tag | No               | 0           | TagAssigned | CassandraFullNamePIITag  |
      | Columns | ssn       | click and verify tag | No               | 0           | TagAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress | click and verify tag | No               | 1           | TagAssigned | CassandraIPAddressPIITag |


  Scenario:SC#28:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ##7103069## ##Bug-ID MLP-23041## ##Tag Should not be assigned to gender##
  @webtest @PIITag
  Scenario: SC#29_Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Cassandra table. (Match Empty and Full as False and True)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                                      | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc6.json                   | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                            | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                           | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCataloger_RatioGreater5EmptyFalseTrue.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                           | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                           | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json                      | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                           | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                           | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_ratiogreaterthan05emptyfalsetrue" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_ratiogreaterthan05emptyfalsetrue [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_ratiogreaterthan05emptyfalsetrue" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | verify         | tag                      |
      | Columns | gender    | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email     | click and verify tag | No               | 0           | TagAssigned    | CassandraEmailPIITag     |
      | Columns | full_name | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn       | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress | click and verify tag | No               | 1           | TagAssigned    | CassandraIPAddressPIITag |


#  Scenario:SC#29:Delete Cluster and all the Analysis log for Cassandra
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                               | type     | query | param |
#      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
#      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
#      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ##7103070## ####
  @webtest @PIITag
  Scenario: SC#30_Verify Tag is set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in Cassandra table. (Match Empty and Full as True)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                                      | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc7.json                   | 204           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                           | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_ratiogreaterthan05emptyfalsetrue" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_ratiogreaterthan05emptyfalsetrue [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_ratiogreaterthan05emptyfalsetrue" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | verify         | tag                      |
      | Columns | gender    | click and verify tag | No               | 0           | TagAssigned    | CassandraGenderPIITag    |
      | Columns | email     | click and verify tag | No               | 0           | TagAssigned    | CassandraEmailPIITag     |
      | Columns | full_name | click and verify tag | No               | 0           | TagAssigned    | CassandraFullNamePIITag  |
      | Columns | ssn       | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress | click and verify tag | No               | 1           | TagAssigned    | CassandraIPAddressPIITag |


  Scenario:SC#30:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ##7103071##
  @webtest @PIITag
  Scenario: SC#31_Verify Tag is set for the column when dataPattern and minimumRatio(1-full match) is passed which has a regexp that matches with the data in column in Cassandra table. (Match Empty and Full as false)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                    | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc8.json | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json          | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                         | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCataloger_AllMatch.json  | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                         | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                         | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                         | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                         | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json    | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                         | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                         | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                         | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                         | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_allmatch" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_allmatch [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_allmatch" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | verify      | tag                      |
      | Columns | gender    | click and verify tag | No               | 0           | TagAssigned | CassandraGenderPIITag    |
      | Columns | email     | click and verify tag | No               | 0           | TagAssigned | CassandraEmailPIITag     |
      | Columns | full_name | click and verify tag | No               | 0           | TagAssigned | CassandraFullNamePIITag  |
      | Columns | ssn       | click and verify tag | No               | 0           | TagAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress | click and verify tag | No               | 1           | TagAssigned | CassandraIPAddressPIITag |


  Scenario:SC#31:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ##7103072##
  @webtest @PIITag
  Scenario: SC#32_Verify Tag is set for the column when dataPattern and minimumRatio(equal to 0.5) is passed which has a regexp that matches with the data in column in Cassandra table. (Match Empty and Full as false)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                                | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc9.json             | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                      | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                     | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCataloger_RatioEqual5EmptyFalse.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                     | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                     | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json                | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                     | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                     | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                     | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_ratioequalto05emptyfalse" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_ratioequalto05emptyfalse [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_ratioequalto05emptyfalse" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | verify      | tag                      |
      | Columns | gender    | click and verify tag | No               | 0           | TagAssigned | CassandraGenderPIITag    |
      | Columns | email     | click and verify tag | No               | 0           | TagAssigned | CassandraEmailPIITag     |
      | Columns | full_name | click and verify tag | No               | 0           | TagAssigned | CassandraFullNamePIITag  |
      | Columns | ssn       | click and verify tag | No               | 0           | TagAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress | click and verify tag | No               | 1           | TagAssigned | CassandraIPAddressPIITag |


  Scenario:SC#32:Delete Cluster   and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ##7103073##
  @webtest @PIITag
  Scenario: SC#33_Verify Tag is set for the column when namePattern,typePattern,dataPattern and minimumRatio is passed which has a regexp and minimum ratio that matches with the data in column in Cassandra table. (Match Empty and Full as false)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                               | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc10.json           | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                     | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                    | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCataloger_RatioLess5EmptyFalse.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                    | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                    | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                    | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                    | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json               | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                    | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                    | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                    | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_ratiolessthan05emptyfalse" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_ratiolessthan05emptyfalse [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_ratiolessthan05emptyfalse" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | verify      | tag                      |
      | Columns | gender    | click and verify tag | No               | 0           | TagAssigned | CassandraGenderPIITag    |
      | Columns | email     | click and verify tag | No               | 0           | TagAssigned | CassandraEmailPIITag     |
      | Columns | full_name | click and verify tag | No               | 0           | TagAssigned | CassandraFullNamePIITag  |
      | Columns | ssn       | click and verify tag | No               | 0           | TagAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress | click and verify tag | No               | 1           | TagAssigned | CassandraIPAddressPIITag |


  Scenario:SC#33:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ##7103074##
  @webtest @PIITag
  Scenario: SC#34_Verify Tag is not set for the column when namePattern(does not match),typePattern,dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in column in Cassandra table. (Match Empty and Full as false)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                            | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc11.json        | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                  | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                 | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCatalogerWithPIITableFilter.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                 | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                 | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json            | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                 | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                 | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_allmatch" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_allmatch [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_allmatch" item from search results
    Then user performs click and verify in new window
      | Table   | value                                       | Action               | RetainPrevwindow | indexSwitch | verify         | tag                      |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_allempty                         | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiolessthan05emptyfalse        | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiogreaterthan05emptyfalsetrue | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratioequalto05emptyfalse         | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiogreaterthan05matchfulltrue  | click and switch tab | No               |             |                |                          |
      | Columns | comments                                    | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | name                                        | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | rollnumber                                  | click and verify tag | No               | 1           | TagNotAssigned | CassandraFullMatchPIITag |
      | Tables  | tagdetails_ratiolesserthan05matchfulltrue   | click and switch tab | No               |             |                |                          |
      | Columns | comments                                    | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | name                                        | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | rollnumber                                  | click and verify tag | No               | 1           | TagNotAssigned | CassandraFullMatchPIITag |


  Scenario:SC#34:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ##7103075##
  @webtest @PIITag
  Scenario: SC#35_Verify Tag is not set for the column when namePattern,typePattern(does not match),dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in column in Cassandra table. (Match Empty and Full as false)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                            | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc12.json        | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                  | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                 | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCatalogerWithPIITableFilter.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                 | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                 | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json            | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                 | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                 | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_allmatch" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_allmatch [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_allmatch" item from search results
    Then user performs click and verify in new window
      | Table   | value                                       | Action               | RetainPrevwindow | indexSwitch | verify         | tag                      |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_allempty                         | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiolessthan05emptyfalse        | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiogreaterthan05emptyfalsetrue | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratioequalto05emptyfalse         | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiogreaterthan05matchfulltrue  | click and switch tab | No               |             |                |                          |
      | Columns | comments                                    | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | name                                        | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | rollnumber                                  | click and verify tag | No               | 1           | TagNotAssigned | CassandraFullMatchPIITag |
      | Tables  | tagdetails_ratiolesserthan05matchfulltrue   | click and switch tab | No               |             |                |                          |
      | Columns | comments                                    | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | name                                        | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | rollnumber                                  | click and verify tag | No               | 1           | TagNotAssigned | CassandraFullMatchPIITag |


  Scenario:SC#35:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ##7103076##
  @webtest @PIITag
  Scenario: SC#36_Verify Tag is not set for the column when namePattern,typePattern,dataPattern and minimumRatio(does not match) is passed which has any of the regexp and ratio that does not matches with the data in column in Cassandra table. (Match Empty and Full as false)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                            | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc13.json        | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                  | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                 | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCatalogerWithPIITableFilter.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                 | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                 | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json            | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                 | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                 | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                 | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_allmatch" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_allmatch [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_allmatch" item from search results
    Then user performs click and verify in new window
      | Table   | value                                       | Action               | RetainPrevwindow | indexSwitch | verify         | tag                      |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_allempty                         | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiolessthan05emptyfalse        | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiogreaterthan05emptyfalsetrue | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratioequalto05emptyfalse         | click and switch tab | No               |             |                |                          |
      | Columns | gender                                      | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email                                       | click and verify tag | No               | 0           | TagNotAssigned | CassandraEmailPIITag     |
      | Columns | full_name                                   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn                                         | click and verify tag | No               | 0           | TagNotAssigned | CassandraSSNPIITag       |
      | Columns | ipaddress                                   | click and verify tag | No               | 1           | TagNotAssigned | CassandraIPAddressPIITag |
      | Tables  | tagdetails_ratiogreaterthan05matchfulltrue  | click and switch tab | No               |             |                |                          |
      | Columns | comments                                    | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | name                                        | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | rollnumber                                  | click and verify tag | No               | 1           | TagNotAssigned | CassandraFullMatchPIITag |
      | Tables  | tagdetails_ratiolesserthan05matchfulltrue   | click and switch tab | No               |             |                |                          |
      | Columns | comments                                    | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | name                                        | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | rollnumber                                  | click and verify tag | No               | 1           | TagNotAssigned | CassandraFullMatchPIITag |


  Scenario:SC#36:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |



  ##7103077##
  @webtest @PIITag
  Scenario: SC#37_Verify Tag is not set for the column when match empty is true and all the column values in DB are empty.(dataPattern/minimumRatio/MatchEmpty:True/MatchFull:False)
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                     | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc14.json | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json           | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                          | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCataloger_AllEmpty.json   | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                          | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                          | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                          | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                          | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json     | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                          | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                          | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                          | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                          | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_allempty" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_allempty [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_allempty" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | verify         | tag                      |
      | Columns | gender    | click and verify tag | No               | 0           | TagNotAssigned | CassandraGenderPIITag    |
      | Columns | email     | click and verify tag | No               | 0           | TagAssigned    | CassandraEmailPIITag     |
      | Columns | full_name | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullNamePIITag  |
      | Columns | ssn       | click and verify tag | No               | 0           | TagAssigned    | CassandraSSNPIITag       |
      | Columns | ipaddress | click and verify tag | No               | 1           | TagAssigned    | CassandraIPAddressPIITag |


  Scenario:SC#37:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ##7104568##
  @webtest @PIITag
  Scenario: SC#38_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in Cassandra table.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                                     | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc15.json                 | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                           | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                          | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCataloger_RatioGreater5MatchFullTrue.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                          | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                          | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json                     | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                          | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                          | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                          | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_ratiogreaterthan05matchfulltrue" and clicks on search
    And user performs "facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_ratiogreaterthan05matchfulltrue [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_ratiogreaterthan05matchfulltrue" item from search results
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | verify         | tag                      |
      | Columns | rollnumber | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | name       | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | comments   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
    Given Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body                                                     | response code | response message | jsonPath                                               |
      |        |       |       | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc16.json | 204           |                  |                                                        |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                          | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                          | 200           |                  |                                                        |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                          | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status |
    And user enters the search text "tagdetails_ratiogreaterthan05matchfulltrue" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_ratiogreaterthan05matchfulltrue [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_ratiogreaterthan05matchfulltrue" item from search results
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | verify         | tag                      |
      | Columns | rollnumber | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | name       | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | comments   | click and verify tag | No               | 0           | TagAssigned    | CassandraFullMatchPIITag |


  Scenario:SC#38:Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


  ##7104569##
  @webtest @PIITag
  Scenario: SC#39_Verify Tag is not set for the column when MatchFull:true and Tag is set when reran with MatchFull:false when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the exact data in column in Cassandra table.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                                    | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc17.json                | 204           |                  |                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                          | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                         | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCataloger_RatioLesser5MatchFullTrue.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                         | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                         | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json                    | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                         | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                         | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                         | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "tagdetails_ratiolesserthan05matchfulltrue" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_ratiolesserthan05matchfulltrue [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_ratiolesserthan05matchfulltrue" item from search results
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | verify         | tag                      |
      | Columns | rollnumber | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | name       | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | comments   | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
    Given Execute REST API with following parameters
      | Header | Query | Param | type         | url                                                                      | body                                                     | response code | response message | jsonPath                                               |
      |        |       |       | Put          | policy/tagging/actions                                                   | ida/cassandraPayloads/policyEngine/policy1.1.0_sc18.json | 204           |                  |                                                        |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                          | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status |
      |        |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                          | 200           |                  |                                                        |
      |        |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                          | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status |
    And user enters the search text "tagdetails_ratiolesserthan05matchfulltrue" and clicks on search
    And user performs "definite facet selection" in "Cassandra" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "tagdetails_ratiolesserthan05matchfulltrue [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "tagdetails_ratiolesserthan05matchfulltrue" item from search results
    Then user performs click and verify in new window
      | Table   | value      | Action               | RetainPrevwindow | indexSwitch | verify         | tag                      |
      | Columns | rollnumber | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | name       | click and verify tag | No               | 0           | TagNotAssigned | CassandraFullMatchPIITag |
      | Columns | comments   | click and verify tag | No               | 0           | TagAssigned    | CassandraFullMatchPIITag |


  Scenario: SC#39_Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |


#  ##########################Complex DataType Verification#####################################################

  ##7110810## ##7110811##
  @webtest
  Scenario: SC#40_Verify the Complex/Collection/UDT Datatypes has the appropriate Data type name and Profiling is not done after the execution of Cassandra Cataloger and Analyzer.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                           | response code | response message | jsonPath                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                 | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                | 200           |                  | CassandraDS                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/CassandraCataloger_ComplexDataTypes.json | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                | 200           |                  | Cassandra Cataloger                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                | 200           | IDLE             | $.[?(@.configurationName=='Cassandra Cataloger')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json           | 204           |                  |                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                | 200           |                  | CassandraAnalyzer                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                | 200           |                  |                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status   |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "complexdatatypes" and clicks on search
    And user performs "facet selection" in "complexdatatypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 16 items" in Item Search results page
    And user performs "item click" on "complexdatatypes" item from search results
    Then user performs click and verify in new window
      | Table   | value        | Action                    | RetainPrevwindow | indexSwitch | filePath                                    | jsonPath           | metadataSection |
      | Columns | blobdata     | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.blobdata         | Description     |
      | Columns | boll         | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.booleandata      | Description     |
      | Columns | emails       | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.ListDataType     | Description     |
      | Columns | inetdata     | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.InetDataType     | Description     |
      | Columns | info         | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.TupleDataType    | Description     |
      | Columns | name         | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.FrozenDataType   | Description     |
      | Columns | teams        | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.MapDataType      | Description     |
      | Columns | teams2       | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.SetDataType      | Description     |
      | Columns | timeuuidsata | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.TimeUuidDataType | Description     |
      | Columns | uuiddata     | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.UuidDataType     | Description     |
#    Then user performs click and verify in new window
#      | Table   | value        | Action                    | RetainPrevwindow | indexSwitch | filePath                                    | jsonPath              | metadataSection |
#      | Columns | blobdata     | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.ComplexDataTypeStat | Statistics      |
#      | Columns | boll         | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.BoolDataTypeStat    | Statistics      |
#      | Columns | emails       | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.ComplexDataTypeStat | Statistics      |
#      | Columns | inetdata     | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.ComplexDataTypeStat | Statistics      |
#      | Columns | info         | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.ComplexDataTypeStat | Statistics      |
#      | Columns | name         | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.ComplexDataTypeStat | Statistics      |
#      | Columns | teams        | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.ComplexDataTypeStat | Statistics      |
#      | Columns | teams2       | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.ComplexDataTypeStat | Statistics      |
#      | Columns | timeuuidsata | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.ComplexDataTypeStat | Statistics      |
#      | Columns | uuiddata     | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.ComplexDataTypeStat | Statistics      |


  Scenario: SC#40_Delete Cluster and all the Analysis log for Cassandra
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                               | type     | query | param |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com              | Cluster  |       |       |
      | MultipleIDDelete | Default | cataloger/CassandraDBCataloger/%   | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/CassandraDBAnalyzer/% | Analysis |       |       |

    ################Analyzers################

  @sanity @positive @MLP-24048 @webtest @IDA-10.0
  Scenario: SC#17 MLP_24048_Verify JDBC cataloger scans and collects Table and columns properly with filter conditions
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                                  | response code | response message | jsonPath                                                     |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                        | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                       | 200           |                  | CassandraDS                                                  |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/FilterPayloads/CassandraCatalogerFilterSC5.json | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                       | 200           |                  | Cassandra_Cataloger_SC5                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC5')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                       | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC5')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/FilterPayloads/CassandraAnalyzerFilterSC1.json  | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                       | 200           |                  | Cassandra_Analyzer_SC1                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Analyzer_SC1')].status  |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                       | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Analyzer_SC1')].status  |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#17 MLP_24048_verify whether multiple keyspace including empty and table filters within same keyspace should be repeated in filter cataloger configuration
    And user update the json file "ida/cassandraPayloads/API/SC1_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                      |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC1_CassandraAnalyzerFilter                     |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/dechehdpqa01v.asg.com/Service/CASSANDRA |
      | $..selections.['type_s'][*]                             | Table                                           |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                   | body                                               | response code | response message | filePath                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC1_CassandraAnalyzerFilter&limitFacet=10&offset=0&limit=20 | payloads/ida/cassandraPayloads/API/SC1_Filter.json | 200           |                  | response\Cassandra\Actual\SC5_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#17 MLP_24048_Compare the tables Analyzed with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                              | actualValues                              | valueType         | expectedJsonPath | actualJsonPath               |
      | response\Cassandra\Expected\SC1_Filter.json | response\Cassandra\Actual\SC5_Filter.json | stringListCompare | $.SC1.Tables[*]  | $..[?(@.type=='Table')].name |

  Scenario Outline:SC17:user get the Dynamic ID's (Database ID) for the Keyspaces "Keyspace1,keyspace2,Keyspace3"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type     | name      | asg_scopeid | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace1 | table1      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS1Tables.table1 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace1 | table2      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS1Tables.table2 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace1 | table3      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS1Tables.table3 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace2 | table1      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS2Tables.table1 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace2 | table4      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS2Tables.table4 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace3 | table1      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS3Tables.table1 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace3 | table5      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS3Tables.table5 |

  Scenario Outline: SC17:user hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                   | inputFile                                     | outPutFile                                                               | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS1Tables.table1 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC1\KS1_Table1_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS1Tables.table2 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC1\KS1_Table2_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS1Tables.table3 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC1\KS1_Table3_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS2Tables.table1 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC1\KS2_Table1_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS2Tables.table4 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC1\KS2_Table4_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS3Tables.table1 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC1\KS3_Table1_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS3Tables.table5 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC1\KS3_Table5_DataSample.json |            |

  Scenario: SC#17 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\cassandraPayloads\API\Actual\SC1\KS1_Table1_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC1\KS1_Table1_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC1\KS1_Table2_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC1\KS1_Table2_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC1\KS1_Table3_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC1\KS1_Table3_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC1\KS2_Table1_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC1\KS2_Table1_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC1\KS2_Table4_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC1\KS2_Table4_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC1\KS3_Table1_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC1\KS3_Table1_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC1\KS3_Table5_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC1\KS3_Table5_DataSample.json"

  @webtest
  Scenario: SC#17_Verify CassandraDBAnalyzer analyze the column and display data profiling
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC1_CassandraAnalyzerFilter" and clicks on search
    And user performs "facet selection" in "SC1_CassandraAnalyzerFilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "keyspace1 [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "table1" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | firstname | verify widget contains | No               |             |
      | Columns | firstname | click and switch tab   | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TEXT          | Description |
      | Maximum length                | 8             | Statistics  |
      | Maximum value                 | Marianne      | Statistics  |
      | Minimum length                | 8             | Statistics  |
      | Minimum value                 | Marianne      | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | lastname | verify widget contains | No               |             |
      | Columns | lastname | click and switch tab   | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | TEXT          | Description |

  @MLP-24048  @sanity @positive
  Scenario:DryRunSC#17:Delete all the Anlaysis and Cluster
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                     | type     | query | param |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/Cassandra_Cataloger_SC5%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/CassandraDBAnalyzer/Cassandra_Analyzer_SC1% | Analysis |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                                    | Cluster  |       |       |


  @sanity @positive @MLP-24048 @webtest @IDA-10.0
  Scenario: SC#18 MLP_24048_Verify JDBC cataloger scans and collects Table and columns properly with filter conditions
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                                  | response code | response message | jsonPath                                                     |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                        | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                       | 200           |                  | CassandraDS                                                  |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/FilterPayloads/CassandraCatalogerFilterSC5.json | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                       | 200           |                  | Cassandra_Cataloger_SC5                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC5')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                       | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC5')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/FilterPayloads/CassandraAnalyzerFilterSC2.json  | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                       | 200           |                  | Cassandra_Analyzer_SC2                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Analyzer_SC2')].status  |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                       | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Analyzer_SC2')].status  |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#18 MLP_24048_verify whether multiple keyspace including empty and table filters within same keyspace should be repeated in filter cataloger configuration
    And user update the json file "ida/cassandraPayloads/API/SC1_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                      |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC2_CassandraAnalyzerFilter                     |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/dechehdpqa01v.asg.com/Service/CASSANDRA |
      | $..selections.['type_s'][*]                             | Table                                           |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                   | body                                               | response code | response message | filePath                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC2_CassandraAnalyzerFilter&limitFacet=10&offset=0&limit=20 | payloads/ida/cassandraPayloads/API/SC1_Filter.json | 200           |                  | response\Cassandra\Actual\SC6_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#18 MLP_24048_Compare the tables Analyzed with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                              | actualValues                              | valueType         | expectedJsonPath | actualJsonPath               |
      | response\Cassandra\Expected\SC1_Filter.json | response\Cassandra\Actual\SC6_Filter.json | stringListCompare | $.SC2.Tables[*]  | $..[?(@.type=='Table')].name |

  Scenario Outline:SC18:user get the Dynamic ID's (Database ID) for the Keyspaces "Keyspace1,keyspace2,Keyspace3"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type     | name      | asg_scopeid | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace1 | table1      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS1Tables.table1 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace1 | table2      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS1Tables.table2 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace1 | table3      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS1Tables.table3 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace2 | table1      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS2Tables.table1 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace2 | table4      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS2Tables.table4 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace3 | table1      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS3Tables.table1 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace3 | table5      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS3Tables.table5 |

  Scenario Outline: SC18:user hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                   | inputFile                                     | outPutFile                                                               | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS1Tables.table1 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC2\KS1_Table1_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS1Tables.table2 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC2\KS1_Table2_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS1Tables.table3 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC2\KS1_Table3_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS2Tables.table1 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC2\KS2_Table1_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS2Tables.table4 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC2\KS2_Table4_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS3Tables.table1 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC2\KS3_Table1_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS3Tables.table5 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC2\KS3_Table5_DataSample.json |            |

  Scenario: SC#18 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\cassandraPayloads\API\Actual\SC2\KS1_Table1_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC2\KS1_Table1_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC2\KS1_Table2_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC2\KS1_Table2_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC2\KS1_Table3_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC2\KS1_Table3_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC2\KS2_Table1_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC2\KS2_Table1_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC2\KS2_Table4_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC2\KS2_Table4_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC2\KS3_Table1_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC2\KS3_Table1_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC2\KS3_Table5_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC2\KS3_Table5_DataSample.json"

  @webtest
  Scenario: SC#18_Verify CassandraDBAnalyzer analyze the column and display data profiling
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC2_CassandraAnalyzerFilter" and clicks on search
    And user performs "facet selection" in "SC2_CassandraAnalyzerFilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "keyspace1 [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "table1" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | firstname | verify widget contains | No               |             |
      | Columns | firstname | click and switch tab   | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TEXT          | Description |
      | Maximum length                | 8             | Statistics  |
      | Maximum value                 | Marianne      | Statistics  |
      | Minimum length                | 8             | Statistics  |
      | Minimum value                 | Marianne      | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | id    | verify widget contains | No               |             |
      | Columns | id    | click and switch tab   | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | UUID          | Description |

  @MLP-24048  @sanity @positive
  Scenario:DryRunSC#18:Delete all the Anlaysis and Cluster
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                     | type     | query | param |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/Cassandra_Cataloger_SC5%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/CassandraDBAnalyzer/Cassandra_Analyzer_SC2% | Analysis |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                                    | Cluster  |       |       |

  @sanity @positive @MLP-24048 @webtest @IDA-10.0
  Scenario: SC#19 MLP_24048_Verify JDBC cataloger scans and collects Table and columns properly with filter conditions
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                                  | response code | response message | jsonPath                                                     |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                        | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                       | 200           |                  | CassandraDS                                                  |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/FilterPayloads/CassandraCatalogerFilterSC5.json | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                       | 200           |                  | Cassandra_Cataloger_SC5                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC5')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                       | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC5')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/FilterPayloads/CassandraAnalyzerFilterSC3.json  | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                       | 200           |                  | Cassandra_Analyzer_SC3                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Analyzer_SC3')].status  |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                       | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Analyzer_SC3')].status  |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#19 MLP_24048_verify whether multiple keyspace including empty and table filters within same keyspace should be repeated in filter cataloger configuration
    And user update the json file "ida/cassandraPayloads/API/SC1_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                      |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC3_CassandraAnalyzerFilter                     |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/dechehdpqa01v.asg.com/Service/CASSANDRA |
      | $..selections.['type_s'][*]                             | Table                                           |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                   | body                                               | response code | response message | filePath                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC3_CassandraAnalyzerFilter&limitFacet=10&offset=0&limit=20 | payloads/ida/cassandraPayloads/API/SC1_Filter.json | 200           |                  | response\Cassandra\Actual\SC7_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#19 MLP_24048_Compare the tables Analyzed with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                              | actualValues                              | valueType         | expectedJsonPath | actualJsonPath               |
      | response\Cassandra\Expected\SC1_Filter.json | response\Cassandra\Actual\SC7_Filter.json | stringListCompare | $.SC3.Tables[*]  | $..[?(@.type=='Table')].name |

  Scenario Outline:SC19:user get the Dynamic ID's (Database ID) for the Keyspaces "Keyspace1,keyspace2,Keyspace3"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type     | name      | asg_scopeid | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace1 | table1      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS1Tables.table1 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace1 | table2      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS1Tables.table2 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace1 | table3      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS1Tables.table3 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace2 | table1      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS2Tables.table1 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace2 | table4      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS2Tables.table4 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace3 | table1      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS3Tables.table1 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace3 | table5      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS3Tables.table5 |

  Scenario Outline: SC19:user hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                   | inputFile                                     | outPutFile                                                               | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS1Tables.table1 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC3\KS1_Table1_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS1Tables.table2 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC3\KS1_Table2_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS1Tables.table3 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC3\KS1_Table3_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS2Tables.table1 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC3\KS2_Table1_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS2Tables.table4 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC3\KS2_Table4_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS3Tables.table1 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC3\KS3_Table1_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS3Tables.table5 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC3\KS3_Table5_DataSample.json |            |

  Scenario: SC#19 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\cassandraPayloads\API\Actual\SC3\KS1_Table1_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC3\KS1_Table1_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC3\KS1_Table2_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC3\KS1_Table2_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC3\KS1_Table3_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC3\KS1_Table3_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC3\KS2_Table1_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC3\KS2_Table1_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC3\KS2_Table4_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC3\KS2_Table4_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC3\KS3_Table1_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC3\KS3_Table1_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC3\KS3_Table5_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC3\KS3_Table5_DataSample.json"

  @webtest
  Scenario: SC#19_Verify CassandraDBAnalyzer analyze the column and display data profiling
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC3_CassandraAnalyzerFilter" and clicks on search
    And user performs "facet selection" in "SC3_CassandraAnalyzerFilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "keyspace2 [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "table1" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | firstname | verify widget contains | No               |             |
      | Columns | firstname | click and switch tab   | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TEXT          | Description |
      | Maximum length                | 8             | Statistics  |
      | Maximum value                 | Marianne      | Statistics  |
      | Minimum length                | 8             | Statistics  |
      | Minimum value                 | Marianne      | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | id    | verify widget contains | No               |             |
      | Columns | id    | click and switch tab   | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | UUID          | Description |

  @MLP-24048  @sanity @positive
  Scenario:DryRunSC#19:Delete all the Anlaysis and Cluster
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                     | type     | query | param |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/Cassandra_Cataloger_SC5%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/CassandraDBAnalyzer/Cassandra_Analyzer_SC3% | Analysis |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                                    | Cluster  |       |       |

  @sanity @positive @MLP-24048 @webtest @IDA-10.0
  Scenario: SC#20 MLP_24048_Verify JDBC cataloger scans and collects Table and columns properly with filter conditions
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                                  | response code | response message | jsonPath                                                     |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                        | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                       | 200           |                  | CassandraDS                                                  |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/FilterPayloads/CassandraCatalogerFilterSC5.json | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                       | 200           |                  | Cassandra_Cataloger_SC5                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC5')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                       | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC5')].status |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/FilterPayloads/CassandraAnalyzerFilterSC4.json  | 204           |                  |                                                              |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                       | 200           |                  | Cassandra_Analyzer_SC4                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Analyzer_SC4')].status  |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                       | 200           |                  |                                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                       | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Analyzer_SC4')].status  |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#20 MLP_24048_verify whether multiple keyspace including empty and table filters within same keyspace should be repeated in filter cataloger configuration
    And user update the json file "ida/cassandraPayloads/API/SC1_Filter.json" file for following values
      | jsonPath                                                | jsonValues                                      |
      | $..selections.['asg.tagPathsHierarchy_ss'][*]           | SC4_CassandraAnalyzerFilter                     |
      | $..selections.['asg.parentTypeNamePathHierarchy_ss'][*] | Cluster/dechehdpqa01v.asg.com/Service/CASSANDRA |
      | $..selections.['type_s'][*]                             | Table                                           |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                   | body                                               | response code | response message | filePath                                  | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | components/itemlist?query=SC4_CassandraAnalyzerFilter&limitFacet=10&offset=0&limit=20 | payloads/ida/cassandraPayloads/API/SC1_Filter.json | 200           |                  | response\Cassandra\Actual\SC8_Filter.json |          |

  @MLP-24048  @sanity @positive
  Scenario Outline: SC#20 MLP_24048_Compare the tables Analyzed with respect to filters
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                              | actualValues                              | valueType         | expectedJsonPath | actualJsonPath               |
      | response\Cassandra\Expected\SC1_Filter.json | response\Cassandra\Actual\SC8_Filter.json | stringListCompare | $.SC4.Tables[*]  | $..[?(@.type=='Table')].name |

  Scenario Outline:SC20:user get the Dynamic ID's (Database ID) for the Keyspaces "Keyspace1,keyspace2,Keyspace3"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive     | catalog | type     | name      | asg_scopeid | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace1 | table1      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS1Tables.table1 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace1 | table2      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS1Tables.table2 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace1 | table3      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS1Tables.table3 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace2 | table1      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS2Tables.table1 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace2 | table4      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS2Tables.table4 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace3 | table1      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS3Tables.table1 |
      | APPDBPOSTGRES | AsgScope_ID | Default | Database | keyspace3 | table5      | payloads/ida/cassandraPayloads/API/items.json | $.Database.KS3Tables.table5 |

  Scenario Outline: SC20:user hits the TablesID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                   | inputFile                                     | outPutFile                                                               | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS1Tables.table1 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC4\KS1_Table1_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS1Tables.table2 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC4\KS1_Table2_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS1Tables.table3 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC4\KS1_Table3_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS2Tables.table1 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC4\KS2_Table1_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS2Tables.table4 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC4\KS2_Table4_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS3Tables.table1 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC4\KS3_Table1_DataSample.json |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Database.KS3Tables.table5 | payloads/ida/cassandraPayloads/API/items.json | payloads\ida\cassandraPayloads\API\Actual\SC4\KS3_Table5_DataSample.json |            |

  Scenario: SC#20 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\cassandraPayloads\API\Actual\SC4\KS1_Table1_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC4\KS1_Table1_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC4\KS1_Table2_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC4\KS1_Table2_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC4\KS1_Table3_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC4\KS1_Table3_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC4\KS2_Table1_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC4\KS2_Table1_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC4\KS2_Table4_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC4\KS2_Table4_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC4\KS3_Table1_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC4\KS3_Table1_DataSample.json"
    Then file content in "ida\cassandraPayloads\API\Actual\SC4\KS3_Table5_DataSample.json" should be same as the content in "ida\cassandraPayloads\API\Expected\SC4\KS3_Table5_DataSample.json"

  @webtest
  Scenario: SC#20_Verify CassandraDBAnalyzer analyze the column and display data profiling
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SC4_CassandraAnalyzerFilter" and clicks on search
    And user performs "facet selection" in "SC4_CassandraAnalyzerFilter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "keyspace1 [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "table1" item from search results
    Then user performs click and verify in new window
      | Table   | value     | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | firstname | verify widget contains | No               |             |
      | Columns | firstname | click and switch tab   | No               |             |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TEXT          | Description |
      | Maximum length                | 8             | Statistics  |
      | Maximum value                 | Marianne      | Statistics  |
      | Minimum length                | 8             | Statistics  |
      | Minimum value                 | Marianne      | Statistics  |
      | Number of non null values     | 1             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action                 | RetainPrevwindow | indexSwitch |
      | Columns | id    | verify widget contains | No               |             |
      | Columns | id    | click and switch tab   | No               |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Data type         | UUID          | Description |

  @MLP-24048  @sanity @positive
  Scenario:DryRunSC#20:Delete all the Anlaysis and Cluster
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                     | type     | query | param |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/Cassandra_Cataloger_SC5%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/CassandraDBAnalyzer/Cassandra_Analyzer_SC4% | Analysis |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                                    | Cluster  |       |       |

    ########################################Complex Data types validations################################################

  Scenario: SC#21 MLP_24048_Verify JDBC cataloger scans and collects Table and columns properly to verify Index
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                               | response code | response message | jsonPath                                                       |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json     | 204           |                  |                                                                |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                    | 200           |                  | CassandraDS                                                    |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/CassandraCatalogerIndex.json | 204           |                  |                                                                |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                    | 200           |                  | Cassandra_Cataloger_Index                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                    | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_Index')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                    | 200           |                  |                                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                    | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_Index')].status |

     ################################Index tables in Contraints widget verification#################

  @webtest
  Scenario: SC#21_Verify whether the indexs(composite partition key,clustering key,map Values, map Entries, frozen list,collection columns,map keys) are available in the contraints widget for the tables
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "CassandraFilter_Index" and clicks on search
    And user performs "facet selection" in "CassandraFilter_Index" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "automationkeyspace" item from search results
    Then user performs click and verify in new window
      | Table  | value                 | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | cyclist_alt_stats     | verify widget contains | No               |             |
      | Tables | complexdatatypes1     | verify widget contains | No               |             |
      | Tables | rank_by_year_and_name | verify widget contains | No               |             |
      | Tables | complexdatatypes2     | verify widget contains | No               |             |
      | Tables | complexdatatypes      | verify widget contains | No               |             |
    Then user performs click and verify in new window
      | Table       | value            | Action                 | RetainPrevwindow | indexSwitch |
      | Tables      | complexdatatypes | click and switch tab   | No               |             |
      | Constraints | email_idx        | verify widget contains | No               |             |
      | Constraints | teams2_idx       | verify widget contains | No               |             |
      | Constraints | teams_idx        | verify widget contains | No               | 0           |
    Then user performs click and verify in new window
      | Table       | value             | Action                 | RetainPrevwindow | indexSwitch |
      | Tables      | complexdatatypes1 | click and switch tab   | No               |             |
      | Constraints | teams_idx_entries | verify widget contains | No               |             |
      | Constraints | teams_idx_values  | verify widget contains | No               | 0           |
    Then user performs click and verify in new window
      | Table       | value             | Action                 | RetainPrevwindow | indexSwitch |
      | Tables      | complexdatatypes2 | click and switch tab   | No               |             |
      | Constraints | plane_idx_frozen  | verify widget contains | No               | 0           |
    Then user performs click and verify in new window
      | Table       | value                 | Action                 | RetainPrevwindow | indexSwitch |
      | Tables      | rank_by_year_and_name | click and switch tab   | No               |             |
      | Constraints | ryear                 | verify widget contains | No               |             |
      | Constraints | rrank                 | verify widget contains | No               | 0           |
    Then user performs click and verify in new window
      | Table       | value             | Action                 | RetainPrevwindow | indexSwitch |
      | Tables      | cyclist_alt_stats | click and switch tab   | No               |             |
      | Constraints | birthday_idx      | verify widget contains | No               |             |
      | Constraints | nationality_idx   | verify widget contains | No               | 0           |

    #############################################Complexdatatypes table column profiling and DATATYPE verification#####################
    ##Bug-ID-23971,24715
  @webtest
  Scenario: SC#22 Verify the Complex/Collection/UDT Datatypes has the appropriate Data type name and Profiling is not done after the execution of Cassandra Cataloger and Analyzer.
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                 | response code | response message | jsonPath                                               |
      | application/json |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/CassandraAnalyzerNoFilter.json | 204           |                  |                                                        |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                      | 200           |                  | CassandraAnalyzer                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                      | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                      | 200           |                  |                                                        |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                      | 200           | IDLE             | $.[?(@.configurationName=='CassandraAnalyzer')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "facet selection" in "complexdatatypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 16 items" in Item Search results page
    And user performs "item click" on "complexdatatypes" item from search results
    Then user performs click and verify in new window
      | Table   | value        | Action                    | RetainPrevwindow | indexSwitch | filePath                                    | jsonPath           | metadataSection |
      | Columns | blobdata     | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.blobdata         | Description     |
      | Columns | boll         | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.booleandata      | Description     |
      | Columns | emails       | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.ListDataType     | Description     |
      | Columns | inetdata     | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.InetDataType     | Description     |
      | Columns | info         | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.TupleDataType    | Description     |
      | Columns | name         | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.FrozenDataType   | Description     |
      | Columns | teams        | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.MapDataType      | Description     |
      | Columns | teams2       | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.SetDataType      | Description     |
      | Columns | timeuuidsata | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.TimeUuidDataType | Description     |
      | Columns | uuiddata     | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.UuidDataType     | Description     |
      | Columns | bike         | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.SetDataType      | Description     |
      | Columns | car          | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.MapDataType      | Description     |
      | Columns | plane        | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.ListDataType     | Description     |
      | Columns | sbk          | click and verify metadata | Yes              | 0           | ida/cassandraPayloads/expectedMetadata.json | $.ListDataType     | Description     |

#################################Complex Data type 'Length & Last analyzed at" non presence########################################
  @webtest
  Scenario: SC#23 Verify that "Length & Last analyzed at" field from STATISTICS and LIFECYCLE section is removed for all the complex datatypes
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "facet selection" in "complexdatatypes [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "complexdatatypes" item from search results
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch |
      | Columns | blobdata | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | boll  | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value  | Action               | RetainPrevwindow | indexSwitch |
      | Columns | emails | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch |
      | Columns | inetdata | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | info  | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | name  | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | teams | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value  | Action               | RetainPrevwindow | indexSwitch |
      | Columns | teams2 | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value        | Action               | RetainPrevwindow | indexSwitch |
      | Columns | timeuuidsata | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value    | Action               | RetainPrevwindow | indexSwitch |
      | Columns | uuiddata | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | bike  | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | car   | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | plane | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | sbk   | click and switch tab | No               |             |
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute | widgetName |
      | Length            | Statistics |
      | Last analyzed at  | Lifecycle  |


     ##############################invalid keysapce in cataloger#################################

  Scenario: SC#25 MLP_24048_Verify JDBC cataloger doesn't scans and collects Table and columns properly with invalid keyspaces
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                                          | response code | response message | jsonPath                                                                 |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json                                | 204           |                  |                                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                                               | 200           |                  | CassandraDS                                                              |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/NegativeConfig's/CassandraCatalogerInvalidKeyspace.json | 204           |                  |                                                                          |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                                               | 200           |                  | Cassandra_Cataloger_InvalidKeyspace                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_InvalidKeyspace')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                                               | 200           |                  |                                                                          |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                                               | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_InvalidKeyspace')].status |
    Then Analysis log "cataloger/CassandraDBCataloger/Cassandra_Cataloger_InvalidKeyspace%" should display below info/error/warning
      | type | logValue                                     | logCode            |
      | WARN | No data is available for cataloging purpose. | ANALYSIS-JDBC-0048 |

  @MLP-24048  @sanity @positive
  Scenario:DryRunSC#25:Delete all the Anlaysis and Cluster
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                | type     | query | param |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/Cassandra_Cataloger_InvalidKeyspace% | Analysis |       |       |

        ##############################invalid table in cataloger#################################

  Scenario: SC#26 MLP_24048_Verify JDBC cataloger doesn't scans and collects Table and columns properly with invalid tables
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                    | body                                                                       | response code | response message | jsonPath                                                              |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                               | ida/cassandraPayloads/CassandraDataSource.json                             | 204           |                  |                                                                       |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                               |                                                                            | 200           |                  | CassandraDS                                                           |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                | ida/cassandraPayloads/NegativeConfig's/CassandraCatalogerInvalidTable.json | 204           |                  |                                                                       |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                |                                                                            | 200           |                  | Cassandra_Cataloger_InvalidTable                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_InvalidTable')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*  |                                                                            | 200           |                  |                                                                       |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/* |                                                                            | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_InvalidTable')].status |
    Then Analysis log "cataloger/CassandraDBCataloger/Cassandra_Cataloger_InvalidTable%" should display below info/error/warning
      | type | logValue                                     | logCode            |
      | WARN | No data is available for cataloging purpose. | ANALYSIS-JDBC-0048 |

  @MLP-24048  @sanity @positive
  Scenario:DryRunSC#26:Delete all the Anlaysis and Cluster
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/Cassandra_Cataloger_InvalidTable% | Analysis |       |       |

    #########################################Invalid keyspace in Analyzer#################################

  @sanity @positive @MLP-24048 @webtest @IDA-10.0
  Scenario: SC#27 MLP_24048_Verify JDBC cataloger scans and collects Table and columns properly but doesn't analyze the tables with invalid keyspace
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                                         | response code | response message | jsonPath                                                                |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                               | 204           |                  |                                                                         |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                              | 200           |                  | CassandraDS                                                             |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/FilterPayloads/CassandraCatalogerFilterSC5.json        | 204           |                  |                                                                         |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                              | 200           |                  | Cassandra_Cataloger_SC5                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC5')].status            |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                              | 200           |                  |                                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC5')].status            |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/NegativeConfig's/CassandraAnalyzerInvalidKeyspace.json | 204           |                  |                                                                         |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                              | 200           |                  | Cassandra_Analyzer_Invalidkeyspace                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Analyzer_Invalidkeyspace')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                              | 200           |                  |                                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                              | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Analyzer_Invalidkeyspace')].status |
    Then Analysis log "dataanalyzer/CassandraDBAnalyzer/Cassandra_Analyzer_Invalidkeyspace%" should display below info/error/warning
      | type | logValue                                             | logCode            |
      | WARN | Database [invalidkeyspace] not found in the Catalog. | ANALYSIS-JDBC-0053 |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "facet selection" in "table1 [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "firstname" item from search results
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute         | widgetName |
      | Number of non null values | Statistics |
      | Maximum Value             | Statistics |
      | Minimum Value             | Statistics |
      | Standard deviation        | Statistics |
      | Variance                  | Statistics |
      | Last Analyzed At          | Lifecycle  |

  @MLP-24048  @sanity @positive
  Scenario:DryRunSC#27:Delete all the Anlaysis and Cluster
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/Cassandra_Cataloger_SC5%              | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/CassandraDBAnalyzer/Cassandra_Analyzer_Invalidkeyspace% | Analysis |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                                                | Cluster  |       |       |

#########################################Invalid table in Analyzer#################################

  @sanity @positive @MLP-24048 @webtest @IDA-10.0
  Scenario: SC#28 MLP_24048_Verify JDBC cataloger scans and collects Table and columns properly but doesn't analyze the tables with invalid keyspace
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                                      | response code | response message | jsonPath                                                             |
      | application/json | raw   | false | Put          | settings/analyzers/CassandraDBDataSource                                 | ida/cassandraPayloads/CassandraDataSource.json                            | 204           |                  |                                                                      |
      |                  |       |       | Get          | settings/analyzers/CassandraDBDataSource                                 |                                                                           | 200           |                  | CassandraDS                                                          |
      |                  |       |       | Put          | settings/analyzers/CassandraDBCataloger                                  | ida/cassandraPayloads/FilterPayloads/CassandraCatalogerFilterSC5.json     | 204           |                  |                                                                      |
      |                  |       |       | Get          | settings/analyzers/CassandraDBCataloger                                  |                                                                           | 200           |                  | Cassandra_Cataloger_SC5                                              |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC5')].status         |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/CassandraDBCataloger/*    |                                                                           | 200           |                  |                                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/CassandraDBCataloger/*   |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Cataloger_SC5')].status         |
      |                  |       |       | Put          | settings/analyzers/CassandraDBAnalyzer                                   | ida/cassandraPayloads/NegativeConfig's/CassandraAnalyzerInvalidTable.json | 204           |                  |                                                                      |
      |                  |       |       | Get          | settings/analyzers/CassandraDBAnalyzer                                   |                                                                           | 200           |                  | Cassandra_Analyzer_InvalidTable                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Analyzer_InvalidTable')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/CassandraDBAnalyzer/*  |                                                                           | 200           |                  |                                                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/CassandraDBAnalyzer/* |                                                                           | 200           | IDLE             | $.[?(@.configurationName=='Cassandra_Analyzer_InvalidTable')].status |
#    Then Analysis log "dataanalyzer/CassandraDBAnalyzer/Cassandra_Analyzer_InvalidTable%" should display below info/error/warning
#      | type | logValue                                             | logCode            |
#      | WARN | Database [invalidkeyspace] not found in the Catalog. | ANALYSIS-JDBC-0053 |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Cassandra" and clicks on search
    And user performs "facet selection" in "keyspace3 [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "firstname" item from search results
    And user "verify metadata properties" section does not have the following values
      | metaDataAttribute         | widgetName |
      | Number of non null values | Statistics |
      | Maximum Value             | Statistics |
      | Minimum Value             | Statistics |
      | Standard deviation        | Statistics |
      | Variance                  | Statistics |
      | Last Analyzed At          | Lifecycle  |

  @MLP-24048  @sanity @positive
  Scenario:DryRunSC#28:Delete all the Anlaysis and Cluster
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                              | type     | query | param |
      | SingleItemDelete | Default | cataloger/CassandraDBCataloger/Cassandra_Cataloger_SC5%           | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/CassandraDBAnalyzer/Cassandra_Analyzer_InvalidTable% | Analysis |       |       |
      | SingleItemDelete | Default | dechehdpqa01v.asg.com                                             | Cluster  |       |       |


  #######################################Delete Config, Credentials, and Keyspace#########################y

  Scenario: SC#41 Delete the businessApplication tag
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                 | type                | query | param |
      | SingleItemDelete | Default | CassandraCatalogerBA | BusinessApplication |       |       |
      | SingleItemDelete | Default | CassandraAnalyzerBA  | BusinessApplication |       |       |


  Scenario Outline: SC#41 Delete the Cassandra PII tag and Cassandra PII tag structure along with the CassandraDatasource and PluginConfig and credentials
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                      | body | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/EDIBusValidCassandraCredentials                                     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/CassandraCredentials                                                |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/CassandraInvalidCredentials                                         |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CassandraDBDataSource                                                 |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CassandraDBCataloger                                                  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/CassandraDBAnalyzer                                                   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=CassandraDBAnalyzer&technologies= |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | /tags/Default/tags/CassandraPII                                                          |      | 204           |                  |          |


#  @sanity @positive @MLP-7662 @webtest @IDA-10.0
#  Scenario: SC#41 PostExecution#MLP_7662_Cassandra db_drop KeySpace in Cassandra database
#    Given user connect to the Cassandra DB database and execute query for the below parameters
#      | dataBaseName | operation | dataTypeAction | queryPath     | queryPage        | queryField   | keySpaceName       |
#      | CASSANDRA    | Drop      | dropKeySpace   | json/IDA.json | cassandraQueries | dropKeySpace | automationkeyspace |
#      | CASSANDRA    | Drop      | dropKeySpace   | json/IDA.json | cassandraQueries | dropKeySpace | keyspace1          |
#      | CASSANDRA    | Drop      | dropKeySpace   | json/IDA.json | cassandraQueries | dropKeySpace | keyspace2          |
#      | CASSANDRA    | Drop      | dropKeySpace   | json/IDA.json | cassandraQueries | dropKeySpace | keyspace3          |
