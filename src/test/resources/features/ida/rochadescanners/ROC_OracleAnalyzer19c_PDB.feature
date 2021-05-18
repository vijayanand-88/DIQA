@MLPQA-18272
Feature: Validation for Rochade Oracle PDB
  # MLP-30469 - Analyzer support implementation for Rochade data in Oracle


  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline:Policy1:Create root tag and sub tag for Oracle PDB Anlayzer and Update policy tags for Oracle Anlayzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | body                                                                | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | tags/Default/structures | ida/Rochade_OraclePDB/API/PolicyEngine/ORACLE_PDB_TagStructure.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions  | ida/Rochade_OraclePDB/API/PolicyEngine/ORACLE_PDB_policy1.json      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/license        | ida\hbasePayloads\DataSource\license_DS.json                        | 204           |                  |          |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure Credential,Data Source,Plugin config for Oracle and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                             | bodyFile                                                        | path                              | response code | response message            | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeCredentials                         | payloads/ida/Rochade_OraclePDB/Credentials/credentials.json     | $.RochadeCredentials              | 200           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeCredentials                         |                                                                 |                                   | 200           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Oracle19Credentials                        | payloads/ida/Rochade_OraclePDB/Credentials/credentials.json     | $.Oracle19Credentials             | 200           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle19Credentials                        |                                                                 |                                   | 200           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/Oracle19cPDBCredentials                    | payloads/ida/Rochade_OraclePDB/Credentials/credentials.json     | $.Oracle19Credentials             | 200           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle19cPDBCredentials                    |                                                                 |                                   | 200           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EDICredentials                             | payloads/ida/Rochade_OraclePDB/Credentials/credentials.json     | $.EDICredentials                  | 200           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/EDICredentials                             |                                                                 |                                   | 200           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCOracleSADataSource                        | payloads/ida/Rochade_OraclePDB/Configurations/datasource.json   | $.RochadeDS                       | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCOracleSADataSource                        |                                                                 |                                   | 200           | RochadeDS                   |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource                             | payloads/ida/Rochade_OraclePDB/Configurations/datasource.json   | $.EDIBusOracleDS                  | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource                             |                                                                 |                                   | 200           | EDIBusOracleDS              |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCOracleDataSource                          | payloads/ida/Rochade_OraclePDB/Configurations/datasource.json   | $.Oracle19PDB                     | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCOracleDataSource                          |                                                                 |                                   | 200           | Oracle19PDB                 |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleScan/RochadeOracleScan_PDB             | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.OracleScan.configurations       | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleScan/RochadeOracleScan_PDB             |                                                                 |                                   | 200           | RochadeOracleScan_PDB       |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleImport/RochadeOracleImport_PDB         | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.OracleImport.configurations     | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleImport/RochadeOracleImport_PDB         |                                                                 |                                   | 200           | RochadeOracleImport_PDB     |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleReconcile/RochadeOracleReconcile_PDB   | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.OracleReconcile.configurations  | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleReconcile/RochadeOracleReconcile_PDB   |                                                                 |                                   | 200           | RochadeOracleReconcile_PDB  |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.OracleDBAnalyzer.configurations | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER |                                                                 |                                   | 200           | ROCHADE_ORACLE_PDB_ANLAYZER |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/EDIBusOracleReplicate_PDB             | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.EDIBus_Replicate.configurations | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/EDIBusOracleReplicate_PDB             |                                                                 |                                   | 200           | EDIBusOracleReplicate_PDB   |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/EDIBusOracleCleanup_PDB               | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.EDIBus_Cleanup.configurations   | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/EDIBusOracleCleanup_PDB               |                                                                 |                                   | 200           | EDIBusOracleCleanup_PDB     |          |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Run OracleScan, OracleImport, OracleReconsile , EDI Bus and Oracle Anlayzer Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                           | bodyFile | path | response code | response message | jsonPath                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/RochadeIDANode/rochade/OracleScan/RochadeOracleScan_PDB           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScan_PDB')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/RochadeIDANode/rochade/OracleScan/RochadeOracleScan_PDB            |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/RochadeIDANode/rochade/OracleScan/RochadeOracleScan_PDB           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleScan_PDB')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/RochadeIDANode/rochade/OracleImport/RochadeOracleImport_PDB       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport_PDB')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/RochadeIDANode/rochade/OracleImport/RochadeOracleImport_PDB        |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/RochadeIDANode/rochade/OracleImport/RochadeOracleImport_PDB       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleImport_PDB')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/RochadeIDANode/rochade/OracleReconcile/RochadeOracleReconcile_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleReconcile_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/RochadeIDANode/rochade/OracleReconcile/RochadeOracleReconcile_PDB  |          |      | 200           |                  |                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/RochadeIDANode/rochade/OracleReconcile/RochadeOracleReconcile_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeOracleReconcile_PDB')].status |


###########################################################################################################################################################################################
############################################################################ Policy Patterns - PII Tagging #########################################################################################
############################################################################################################################################################################################

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to cleanup for Policy Pattern scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And sync the test execution for "20" seconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile | path | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to replicate for Policy Pattern scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And sync the test execution for "20" seconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | bodyFile | path | response code | response message | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleReplicate_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB  |          |      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleReplicate_PDB')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure OracleAnlayzer on LocalNode and run for (Policy Pattern) scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                                 | bodyFile                                                        | path                                            | response code | response message                                | jsonPath                                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables                                 | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.OracleDBAnalyzer_PolicyPattern.configurations | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables                                 |                                                                 |                                                 | 200           | ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables |                                                                 |                                                 | 200           | IDLE                                            | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables  |                                                                 |                                                 | 200           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables |                                                                 |                                                 | 200           | IDLE                                            | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables')].status |


  @TEST_MLPQA-3244 @MLPQA-17486 @7263940 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC1MLP_26096_Verify PIItags for Oracle PDB Table ,typePattern can be set as:string or .*str.* minimumRatio:0.5, Match Empty=false, Match Full=false.
  Verify Tag is set for the column when typePattern(String) and dataPattern/minimumRatio matches with the column type/value ratio in Parquet file field.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                           | Query                    | Action         |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC1Tag    | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC1Tag       | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC1Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC1Tag  | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_PDB_EmailPII_SC1Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_PDB_EmailPII_SC1Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC1Tag       | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC1Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | GENDER    | ORACLE_PDB_GenderPII_SC1Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC1Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | EMAIL     | ORACLE_PDB_EmailPII_SC1Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | GENDER    | ORACLE_PDB_GenderPII_SC1Tag    | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC1Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | ORACLE_PDB_GenderPII_SC1Tag    | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | ORACLE_PDB_SSNPII_SC1Tag       | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | ORACLE_PDB_IPAddressPII_SC1Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | ORACLE_PDB_FullNamePII_SC1Tag  | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | ORACLE_PDB_EmailPII_SC1Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | GENDER    | ORACLE_PDB_GenderPII_SC1Tag    | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | ORACLE_PDB_SSNPII_SC1Tag       | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC1Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | ORACLE_PDB_FullNamePII_SC1Tag  | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | EMAIL     | ORACLE_PDB_EmailPII_SC1Tag     | EDIColumnQuerywithSchema | TagAssigned    |

  @TEST_MLPQA-3243 @MLPQA-17486 @7263941 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC2#MLP_26096_Verify PItags not set for Parquet File columns , typePattern can be set as:  NUMBER or .*VAR1.* or .*FLOAT.* or .*NUM.*  minimumRatio:0.5
  Verify Tag is not set for the column when typePattern(other than String) and dataPattern/minimumRatio matches with the column type/value ratio in Parquet file field.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                           | Query                    | Action         |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC2Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC2Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC2Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC2Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_PDB_EmailPII_SC2Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_PDB_EmailPII_SC2Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC2Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC2Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | GENDER    | ORACLE_PDB_GenderPII_SC2Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC2Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | EMAIL     | ORACLE_PDB_EmailPII_SC2Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | GENDER    | ORACLE_PDB_GenderPII_SC2Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC2Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | SSN       | ORACLE_PDB_SSNPII_SC2Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | FULL_NAME | ORACLE_PDB_FullNamePII_SC2Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | ORACLE_PDB_GenderPII_SC2Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | ORACLE_PDB_SSNPII_SC2Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | ORACLE_PDB_IPAddressPII_SC2Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | ORACLE_PDB_FullNamePII_SC2Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | ORACLE_PDB_EmailPII_SC2Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | GENDER    | ORACLE_PDB_GenderPII_SC2Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | ORACLE_PDB_SSNPII_SC2Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC2Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | ORACLE_PDB_FullNamePII_SC2Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | EMAIL     | ORACLE_PDB_EmailPII_SC2Tag     | EDIColumnQuerywithSchema | TagNotAssigned |


  @TEST_MLPQA-3239 @MLPQA-17486 @7263945 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC3#MLP_26096_Verify PItags for Parquet File columns  , namePattern can be set as:.*FULL.*,.*IP.*,GENDER,.*EMAIL.*,SSN.*, minimumRatio:0.5
  Verify Tag is set for the column when namePattern and dataPattern/minimumRatio matches with the column name/value ratio in Parquet File Columns.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                           | Query                    | Action         |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC3Tag    | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC3Tag       | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC3Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC3Tag  | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_PDB_EmailPII_SC3Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC3Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC3Tag       | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC3Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_PDB_EmailPII_SC3Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | GENDER    | ORACLE_PDB_GenderPII_SC3Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC3Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | GENDER    | ORACLE_PDB_GenderPII_SC3Tag    | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | SSN       | ORACLE_PDB_SSNPII_SC3Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | ORACLE_PDB_IPAddressPII_SC3Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | ORACLE_PDB_FullNamePII_SC3Tag  | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | ORACLE_PDB_EmailPII_SC3Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | ORACLE_PDB_GenderPII_SC3Tag    | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | ORACLE_PDB_SSNPII_SC3Tag       | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC3Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | ORACLE_PDB_FullNamePII_SC3Tag  | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | EMAIL     | ORACLE_PDB_EmailPII_SC3Tag     | EDIColumnQuerywithSchema | TagAssigned    |


  @TEST_MLPQA-3232 @MLPQA-17486 @7263952 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC4#MLP_26096_Verify PIItags not set for Parquet file columns , namePattern set as: .*F1ULL.*,IP1,1GENDER,.*EM1AIL.*,SSN11.*, minimumRatio:0.5
  Verify Tag is not set for the column when namePattern(does not match) and dataPattern/minimumRatio that does not matches with the column name/value ratio in Oracle PDB Table.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                           | Query                    | Action         |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC4Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC4Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC4Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC4Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_PDB_EmailPII_SC4Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_PDB_EmailPII_SC4Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC4Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC4Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | GENDER    | ORACLE_PDB_GenderPII_SC42Tag   | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC4Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | EMAIL     | ORACLE_PDB_EmailPII_SC4Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | GENDER    | ORACLE_PDB_GenderPII_SC4Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC4Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | SSN       | ORACLE_PDB_SSNPII_SC4Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | FULL_NAME | ORACLE_PDB_FullNamePII_SC4Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | ORACLE_PDB_GenderPII_SC4Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | ORACLE_PDB_SSNPII_SC4Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | ORACLE_PDB_IPAddressPII_SC4Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | ORACLE_PDB_FullNamePII_SC4Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | ORACLE_PDB_EmailPII_SC4Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | GENDER    | ORACLE_PDB_GenderPII_SC4Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | ORACLE_PDB_SSNPII_SC4Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC4Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | ORACLE_PDB_FullNamePII_SC4Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | EMAIL     | ORACLE_PDB_EmailPII_SC4Tag     | EDIColumnQuerywithSchema | TagNotAssigned |

  @TEST_MLPQA-3233 @MLPQA-17486 @7263951 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC5#MLP_26096_Verify PItags for Oracle PDB Table , valid name and type pattern minimumRatio:0.2
  Verify Tag is set for the column when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the data in column in OracleDB table.
  (Ex: 0.2 - 2 or more rows should have matcning column values)- Match Empty is False
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                   | Column    | Tags                           | Query                    | Action      |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | GENDER    | ORACLE_PDB_GenderPII_SC5Tag    | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | SSN       | ORACLE_PDB_SSNPII_SC5Tag       | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | IPADDRESS | ORACLE_PDB_IPAddressPII_SC5Tag | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | FULL_NAME | ORACLE_PDB_FullNamePII_SC5Tag  | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | EMAIL     | ORACLE_PDB_EmailPII_SC5Tag     | EDIColumnQuerywithSchema | TagAssigned |

  @TEST_MLPQA-3228 @MLPQA-17486 @7263956 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC6#MLP_26096_Verify PIItags for Oracle PDB Table , minimumRatio:0.6 matchfull true and matchempty false
  Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in column in OracleDB table.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 2 rows empty/1 row blank, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                           | Query                    | Action         |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | ORACLE_PDB_IPAddressPII_SC6Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | ORACLE_PDB_EmailPII_SC6Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | ORACLE_PDB_GenderPII_SC6Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | ORACLE_PDB_FullNamePII_SC6Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | ORACLE_PDB_SSNPII_SC6Tag       | EDIColumnQuerywithSchema | TagNotAssigned |

  @TEST_MLPQA-3241 @MLPQA-17486 @7263943 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC7#MLP_26096_Verify PIItags for Oracle PDB Table , minimumRatio:1 matchfull false and matchempty false
  Verify Tag is set for the column when dataPattern and minimumRatio(1-full match) is passed which has a regexp that matches with the data in column in OracleDB table.
  (Ex: 1 - all rows should match) - Match Empty is false
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename  | Column    | Tags                           | Query                    | Action      |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | GENDER    | ORACLE_PDB_GenderPII_SC8Tag    | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | SSN       | ORACLE_PDB_SSNPII_SC8Tag       | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | IPADDRESS | ORACLE_PDB_IPAddressPII_SC8Tag | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | FULL_NAME | ORACLE_PDB_FullNamePII_SC8Tag  | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH | EMAIL     | ORACLE_PDB_EmailPII_SC8Tag     | EDIColumnQuerywithSchema | TagAssigned |

  @TEST_MLPQA-3240 @MLPQA-17486 @7263944 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC8#MLP_26096_Verify PIItags for Oracle PDB Table , minimumRatio:0.5 matchfull false and matchempty false
  Verify Tag is set for the column when dataPattern and minimumRatio(equal to 0.5) is passed which has a regexp that matches with the data in column in OracleDB table.
  (Ex: 0.5 - 5 or more rows should have matching column values) - Match Empty is false.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                  | Column    | Tags                           | Query                    | Action      |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | GENDER    | ORACLE_PDB_GenderPII_SC9Tag    | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | SSN       | ORACLE_PDB_SSNPII_SC9Tag       | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | IPADDRESS | ORACLE_PDB_IPAddressPII_SC9Tag | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | FULL_NAME | ORACLE_PDB_FullNamePII_SC9Tag  | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse | EMAIL     | ORACLE_PDB_EmailPII_SC9Tag     | EDIColumnQuerywithSchema | TagAssigned |

  @TEST_MLPQA-3242 @MLPQA-17486 @7263942 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC9#MLP_26096_Verify PIItags for DynamoDB tables , minimumRatio:0.2 matchfull false and matchempty false,namePattern can be set as:FULL.*,IPADDRESS,GENDER,.*MAIL,.*SSN.*
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                   | Column    | Tags                            | Query                    | Action      |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | GENDER    | ORACLE_PDB_GenderPII_SC10Tag    | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | SSN       | ORACLE_PDB_SSNPII_SC10Tag       | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | IPADDRESS | ORACLE_PDB_IPAddressPII_SC10Tag | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | FULL_NAME | ORACLE_PDB_FullNamePII_SC10Tag  | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse | EMAIL     | ORACLE_PDB_EmailPII_SC10Tag     | EDIColumnQuerywithSchema | TagAssigned |


  @TEST_MLPQA-3238 @MLPQA-17486 @7263946 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC10#MLP_26096_Verify PItags not set for Oracle PDB Table , namePattern set as: FULL1.*,IPAD1DRESS,GENDER1,.*1MAIL,.*1SSN.*, minimumRatio:0.2
  Verify Tag is not set for the column when namePattern(does not match),typePattern,dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in Oracle PDB Table.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                            | Query                    | Action         |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC11Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC11Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC11Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC11Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_PDB_EmailPII_SC11Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_PDB_EmailPII_SC11Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC11Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC11Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | GENDER    | ORACLE_PDB_GenderPII_SC11Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC11Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | EMAIL     | ORACLE_PDB_EmailPII_SC11Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | GENDER    | ORACLE_PDB_GenderPII_SC11Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC11Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | SSN       | ORACLE_PDB_SSNPII_SC11Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | FULL_NAME | ORACLE_PDB_FullNamePII_SC11Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | ORACLE_PDB_GenderPII_SC11Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | ORACLE_PDB_SSNPII_SC11Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | ORACLE_PDB_IPAddressPII_SC11Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | ORACLE_PDB_FullNamePII_SC11Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | ORACLE_PDB_EmailPII_SC11Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | GENDER    | ORACLE_PDB_GenderPII_SC11Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | ORACLE_PDB_SSNPII_SC11Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC11Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | ORACLE_PDB_FullNamePII_SC11Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | EMAIL     | ORACLE_PDB_EmailPII_SC11Tag     | EDIColumnQuerywithSchema | TagNotAssigned |

  @TEST_MLPQA-3237 @MLPQA-17486 @7263947 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC11#MLP_26096_Verify PItags not set for Oracle PDB Table , name pattern (Invalid columns) minimumRatio:0.2 matchfull false and matchempty false.
  Verify Tag is not set for the column when namePattern,typePattern(does not match),dataPattern,minimumRatio is passed which has any of the regexp and ratio that does not matches with the data in Oracle PDB Table.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                            | Query                    | Action         |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC12Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC12Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC12Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC12Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_PDB_EmailPII_SC12Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_PDB_EmailPII_SC12Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC12Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC12Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | GENDER    | ORACLE_PDB_GenderPII_SC12Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC12Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | EMAIL     | ORACLE_PDB_EmailPII_SC12Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | GENDER    | ORACLE_PDB_GenderPII_SC12Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC12Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | SSN       | ORACLE_PDB_SSNPII_SC12Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | FULL_NAME | ORACLE_PDB_FullNamePII_SC12Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | ORACLE_PDB_GenderPII_SC12Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | ORACLE_PDB_SSNPII_SC12Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | ORACLE_PDB_IPAddressPII_SC12Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | ORACLE_PDB_FullNamePII_SC12Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | ORACLE_PDB_EmailPII_SC12Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | GENDER    | ORACLE_PDB_GenderPII_SC12Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | ORACLE_PDB_SSNPII_SC12Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC12Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | ORACLE_PDB_FullNamePII_SC12Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | EMAIL     | ORACLE_PDB_EmailPII_SC12Tag     | EDIColumnQuerywithSchema | TagNotAssigned |

  @TEST_MLPQA-3236 @MLPQA-17486 @7263948 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC12#MLP_26096_Verify PItags not set for Oracle PDB Table , data pattern (Invalid regex) minimumRatio:0.2 matchfull false and matchempty false
  Verify Tag is not set for the column when namePattern,typePattern,dataPattern and minimumRatio(does not match) is passed which has any of the regexp and ratio that does not matches with the data in Oracle PDB Table.
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                            | Query                    | Action         |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC13Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC13Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC13Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC13Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | EMAIL     | ORACLE_PDB_EmailPII_SC13Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | EMAIL     | ORACLE_PDB_EmailPII_SC13Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC13Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC13Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | GENDER    | ORACLE_PDB_GenderPII_SC13Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC13Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | EMAIL     | ORACLE_PDB_EmailPII_SC13Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | GENDER    | ORACLE_PDB_GenderPII_SC13Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC13Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | SSN       | ORACLE_PDB_SSNPII_SC13Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | FULL_NAME | ORACLE_PDB_FullNamePII_SC13Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | ORACLE_PDB_GenderPII_SC13Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | ORACLE_PDB_SSNPII_SC13Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | ORACLE_PDB_IPAddressPII_SC13Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | ORACLE_PDB_FullNamePII_SC13Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | ORACLE_PDB_EmailPII_SC13Tag     | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | GENDER    | ORACLE_PDB_GenderPII_SC13Tag    | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | ORACLE_PDB_SSNPII_SC13Tag       | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC13Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | FULL_NAME | ORACLE_PDB_FullNamePII_SC13Tag  | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | EMAIL     | ORACLE_PDB_EmailPII_SC13Tag     | EDIColumnQuerywithSchema | TagNotAssigned |

  @TEST_MLPQA-3235 @MLPQA-17486 @7263949 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC13#MLP_26096_Verify PIItags for Oracle PDB Table , minimumRatio:0.5 matchfull false and matchempty true.
  Verify Tag is not set for the column when Ignore empty and null is true and all the column values in DB are blank/null.(dataPattern/minimumRatio/MatchEmpty:True/MatchFull:False)
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename  | Column    | Tags                            | Query                    | Action      |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | EMAIL     | ORACLE_PDB_EmailPII_SC14Tag     | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | SSN       | ORACLE_PDB_SSNPII_SC14Tag       | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY | IPADDRESS | ORACLE_PDB_IPAddressPII_SC14Tag | EDIColumnQuerywithSchema | TagAssigned |

  @TEST_MLPQA-3229 @MLPQA-17486 @7263955 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC14#MLP_26096_Verify PIItags for Oracle PDB Table , minimumRatio:0.6 matchfull true and matchempty false
  Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in OracleDB table.
  (Ex: 0.6 - 6 or more rows should have matcning column values - dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                         | Column   | Tags                           | Query                    | Action         |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | COMMENTS | ORACLE_PDB_FullMatchPII_SC1Tag | EDIColumnQuerywithSchema | TagNotAssigned |

  @TEST_MLPQA-3244 @MLPQA-17486 @7263940 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC15#MLP_26096_Verify PIItags for Oracle PDB Table , minimumRatio:0.2 matchfull true and matchempty false
  Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the exact data in column in OracleDB table.
  (Ex: 0.2 - 2 or more rows should have matcning column values - namePattern,typePattern,dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                        | Column   | Tags                           | Query                    | Action         |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolesserthan05MatchFullTrue | COMMENTS | ORACLE_PDB_FullMatchPII_SC3Tag | EDIColumnQuerywithSchema | TagNotAssigned |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline:Policy2:Create root tag and sub tag for Oracle PDB Anlayzer and Update policy tags for Oracle Anlayzer
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | body                                                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions | ida/Rochade_OraclePDB/API/PolicyEngine/ORACLE_PDB_policy2.json | 204           |                  |          |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure OracleAnlayzer on LocalNode and run for (Policy Pattern) scenario for second run
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                                 | bodyFile                                                        | path                                            | response code | response message                                | jsonPath                                                                             |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables                                 | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.OracleDBAnalyzer_PolicyPattern.configurations | 204           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables                                 |                                                                 |                                                 | 200           | ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables |                                                                 |                                                 | 200           | IDLE                                            | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables  |                                                                 |                                                 | 200           |                                                 |                                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables |                                                                 |                                                 | 200           | IDLE                                            | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_PolicyPatternTables')].status |

  @TEST_MLPQA-3230 @MLPQA-17486 @7263954 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC16#MLP_26096_Verify PIItags for Oracle PDB Table , minimumRatio:0.6 matchfull false and matchempty true
  Verify Tag is not set for the column when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the data in Oracle PDB Table.
  (Ex: 0.6 - 6 or more rows should have matcning column values including empty) - Match Empty is False -10 rows , 2 rows empty/1 row blank, 4 rows match,3 rows does not match
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                           | Query                    | Action      |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | GENDER    | ORACLE_PDB_GenderPII_SC7Tag    | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | SSN       | ORACLE_PDB_SSNPII_SC7Tag       | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | ORACLE_PDB_IPAddressPII_SC7Tag | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | ORACLE_PDB_FullNamePII_SC7Tag  | EDIColumnQuerywithSchema | TagAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | EMAIL     | ORACLE_PDB_EmailPII_SC7Tag     | EDIColumnQuerywithSchema | TagAssigned |

  @TEST_MLPQA-3231 @MLPQA-17486 @7263953 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC17#MLP_26096_Verify PIItags for Oracle PDB Table , minimumRatio:0.6 matchfull true and matchempty false
  Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(greater than 0.5) is passed which has a regexp that matches with the exact data in column in OracleDB table.
  (Ex: 0.6 - 6 or more rows should have matcning column values - dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                         | Column   | Tags                           | Query                    | Action      |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05MatchFullTrue | COMMENTS | ORACLE_PDB_FullMatchPII_SC2Tag | EDIColumnQuerywithSchema | TagAssigned |

  @TEST_MLPQA-3245 @MLPQA-17486 @7263939 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC18#MLP_26096_Verify PIItags for Oracle PDB Table , minimumRatio:0.2 matchfull true and matchempty false
  Verify Multiple Tag is not set for the column when Whole word Match:true and Tag is set when reran with Whole word Match:false when dataPattern and minimumRatio(lesser than 0.5) is passed which has a regexp that matches with the exact data in column in OracleDB table.
  (Ex: 0.2 - 2 or more rows should have matcning column values - namePattern,typePattern,dataPattern and minimumRatio passed).
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                        | Column   | Tags                           | Query                    | Action      |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolesserthan05MatchFullTrue | COMMENTS | ORACLE_PDB_FullMatchPII_SC4Tag | EDIColumnQuerywithSchema | TagAssigned |


###################################################################################################################################################################################
##############################################################################Internal Node############################################################################################
#####################################################################################################################################################################################

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline:Policy3:Create root tag and sub tag for Oracle PDB Anlayzer and Update policy tags for Oracle Anlayzer for Internal Node
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                    | body                                                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | policy/tagging/actions | ida/Rochade_OraclePDB/API/PolicyEngine/ORACLE_PDB_policy1.json | 204           |                  |          |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to cleanup for Internal node
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile | path | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to replicate for Internal Node
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | bodyFile | path | response code | response message | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleReplicate_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB  |          |      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleReplicate_PDB')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure OracleAnlayzer on InternalNode and run
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                             | bodyFile                                                        | path                                           | response code | response message                         | jsonPath                                                                      |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_InternalNode                                    | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.OracleDBAnalyzer_InternalNode.configurations | 204           |                                          |                                                                               |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_InternalNode                                    |                                                                 |                                                | 200           | ROCHADE_ORACLE_PDB_ANLAYZER_InternalNode |                                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_InternalNode |                                                                 |                                                | 200           | IDLE                                     | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_InternalNode')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_InternalNode  |                                                                 |                                                | 200           |                                          |                                                                               |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_InternalNode |                                                                 |                                                | 200           | IDLE                                     | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_InternalNode')].status |

  @TEST_MLPQA-3246 @MLPQA-17486 @7263938 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC19#MLP_26096_Verify PIItags for Oracle PDB Table with appended PII tags when run in Internal Node
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                            | Query                    | Action         |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC1Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC2Tag        | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC3Tag   | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC4Tag        | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | GENDER    | ORACLE_PDB_GenderPII_SC5Tag     | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | ORACLE_PDB_FullNamePII_SC6Tag   | EDIColumnQuerywithSchema | TagNotAssigned |

  @TEST_MLPQA-3247 @MLPQA-17486 @7263937 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC19#MLP_26096_Verify PIItags for Oracle PDB Table with appended PII tags when run in Internal Node
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                            | Query                    | Action         |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC8Tag  | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | ORACLE_PDB_SSNPII_SC9Tag        | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC10Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC11Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | ORACLE_PDB_IPAddressPII_SC12Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC13Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC14Tag       | EDIColumnQuerywithSchema | TagAssigned    |


######################################################################################################################################################################################
##########################################################################Rochade Node################################################################################################
##############################################################################################################################################################################################

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to cleanup for Rochade node
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile | path | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to replicate for Rochade Node
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | bodyFile | path | response code | response message | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleReplicate_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB  |          |      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleReplicate_PDB')].status |

  @TEST_MLPQA-16813 @MLPQA-17486 @7270705 @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure OracleAnlayzer on Rochade Node and run
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                              | bodyFile                                                        | path                                          | response code | response message                        | jsonPath                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_RochadeNode                                      | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.OracleDBAnalyzer_RochadeNode.configurations | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_RochadeNode                                      |                                                                 |                                               | 200           | ROCHADE_ORACLE_PDB_ANLAYZER_RochadeNode |                                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/RochadeIDANode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_RochadeNode |                                                                 |                                               | 200           | IDLE                                    | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_RochadeNode')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/RochadeIDANode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_RochadeNode  |                                                                 |                                               | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/RochadeIDANode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_RochadeNode |                                                                 |                                               | 200           | IDLE                                    | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_RochadeNode')].status |

  @TEST_MLPQA-3248 @MLPQA-17486 @7263936 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC20#MLP_26096_Verify PIItags for Oracle PDB Table iwth appended PII tags
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                          | Query                    | Action         |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | GENDER    | ORACLE_PDB_GenderPII_SC1Tag   | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | SSN       | ORACLE_PDB_SSNPII_SC2Tag      | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | FULL_NAME | ORACLE_PDB_FullNamePII_SC3Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC4Tag      | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | GENDER    | ORACLE_PDB_GenderPII_SC5Tag   | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | FULL_NAME | ORACLE_PDB_FullNamePII_SC6Tag | EDIColumnQuerywithSchema | TagNotAssigned |

  @TEST_MLPQA-3234 @MLPQA-17486 @7263950 @ROC_OracleAnalyzer19c_PDB @PIITag
  Scenario:SC20_1#MLP_26096_Verify PIItags for Oracle PDB Table iwth appended PII tags
    Given Tag verification of UI items in API for all the DataTypes
      | DatabaseName               | SchemaName   | TableName/Filename                          | Column    | Tags                            | Query                    | Action         |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLMATCH                         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC8Tag  | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | SSN       | ORACLE_PDB_SSNPII_SC9Tag        | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC10Tag | EDIColumnQuerywithSchema | TagAssigned    |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiolessthan05EmptyFalse        | IPADDRESS | ORACLE_PDB_IPAddressPII_SC11Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_Ratiogreaterthan05EmptyFalseTrue | IPADDRESS | ORACLE_PDB_IPAddressPII_SC12Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_RatioEqualTo05EmptyFalse         | IPADDRESS | ORACLE_PDB_IPAddressPII_SC13Tag | EDIColumnQuerywithSchema | TagNotAssigned |
      | PDBDB19C.DIQ.QA.ASGINT.LOC | TEST_TAGGING | TAGDETAILS_ALLEMPTY                         | SSN       | ORACLE_PDB_SSNPII_SC14Tag       | EDIColumnQuerywithSchema | TagAssigned    |



#####################################################################Delete Policy Tags and Rules############################################################


  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline:Deleting the Policy Pattern tags and Rules
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                                   | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=OracleDBAnalyzer&technologies= |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | /tags/Default/tags/ORACLE_PDB_PII                                                     |      | 204           |                  |          |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Run Oracle Anlayzer Plugin
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                             | bodyFile | path | response code | response message | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER |          |      | 200           | IDLE             | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER  |          |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER |          |      | 200           | IDLE             | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER')].status |


#####################################################################################Data Sampling################################################################################



  @TEST_MLPQA-3257 @MLPQA-17486 @7263926 @webtest @jdbc @ROC_OracleAnalyzer19c_PDB
  Scenario:SC#21_Verify OracleDbAnalyzer does data sampling when the Anlayzer ran in LOCALNODE
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORACLE_TAG_DETAILS" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "PDBDB19C.DIQ.QA.ASGINT.LOC [Database]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ORACLE_TAG_DETAILS" item from search results
    And user "navigatesToTab" name "Data Sample" in item view page
    Then following "Data Sample" values should get displayed in item view page
      | GENDER | FULL_NAME      | EMAIL            | STATE | PHONE_NUMBER | EMPLOYEE_ID | POSTAL_CODE | ORACLEDB_LOCALTIME    | ORACLEDB_SALARY | JOINING_DATE        | SSN         | IP_ADDRESS    |
      | m      | Alex Ferguson  | fergie@gmail.com | DC    | 515.123.4568 | 10          | 46576       | 2020-04-24 08:06:08.0 | 100.9           | 2013-05-08 17:02:07 | 345-53-3222 | 255.249.255.0 |
      | f      | Jones Campbell | cambie@gmail.com | TX    | 515.123.4356 | 11          | 46581       | 2020-04-24 08:06:08.0 | 90.55           | 2015-08-05 14:05:07 | 345-53-3779 | 255.249.12.0  |
      | f      | Irina Shayk    | ishayk@gmail.com | VI    | 515.123.2580 | 13          | 48276       | 2020-04-24 08:06:08.0 |                 | 2008-11-18 17:52:47 | 345-66-3222 | 255.71.255.56 |
      | m      | Lionel Messi   | lmessi@gmail.com | NY    | 515.123.6666 | 12          | 78576       | 2020-04-24 08:06:08.0 |                 | 2011-09-14 16:42:57 | 315-53-3222 | 255.83.45.0   |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline:SC22:user get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES","ORACLE_TABLE","ORACLE_TAG_DETAILS" and "ORACLE_DIFFDATATYPES_VIEW"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                                   | asg_scopeid | targetFile                                    | jsonpath                                     |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES      |             | payloads/ida/Rochade_OraclePDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES      |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TABLE              |             | payloads/ida/Rochade_OraclePDB/API/items.json | $.Tables.TableName.ORACLE_TABLE              |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TAG_DETAILS        |             | payloads/ida/Rochade_OraclePDB/API/items.json | $.Tables.TableName.ORACLE_TAG_DETAILS        |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES_VIEW |             | payloads/ida/Rochade_OraclePDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES_VIEW |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: SC22:user hits the TableID's and save the DataSample Values
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                             | responseCode | inputJson                                    | inputFile                                     | outPutFile                                                               | outPutJson |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES      | payloads/ida/Rochade_OraclePDB/API/items.json | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES.json      |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TABLE              | payloads/ida/Rochade_OraclePDB/API/items.json | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_TABLE.json              |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_TAG_DETAILS        | payloads/ida/Rochade_OraclePDB/API/items.json | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_TAG_DETAILS.json        |            |
      | components/Default/definition/dataSample/Default.File:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES_VIEW | payloads/ida/Rochade_OraclePDB/API/items.json | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW.json |            |

  @ROC_OracleAnalyzer19c_PDB
  Scenario: SC#22_update the values with "null" for the dynamic columns values
    And user "update" the json file "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\Rochade_OraclePDB\API\Actual\ORACLE_TABLE.json" file for following values
      | jsonPath                | jsonValues | type  |
      | $..sample.values[0].[0] |            | Array |
      | $..sample.values[0].[1] |            | Array |
      | $..sample.values[0].[2] |            | Array |
      | $..sample.values[0].[3] |            | Array |
      | $..sample.values[1].[0] |            | Array |
      | $..sample.values[1].[1] |            | Array |
      | $..sample.values[1].[2] |            | Array |
      | $..sample.values[1].[3] |            | Array |
      | $..sample.values[2].[0] |            | Array |
      | $..sample.values[2].[1] |            | Array |
      | $..sample.values[2].[2] |            | Array |
      | $..sample.values[2].[3] |            | Array |
      | $..sample.values[3].[0] |            | Array |
      | $..sample.values[3].[1] |            | Array |
      | $..sample.values[3].[2] |            | Array |
      | $..sample.values[3].[3] |            | Array |
      | $..sample.values[4].[0] |            | Array |
      | $..sample.values[4].[1] |            | Array |
      | $..sample.values[4].[2] |            | Array |
      | $..sample.values[4].[3] |            | Array |
      | $..sample.values[5].[0] |            | Array |
      | $..sample.values[5].[1] |            | Array |
      | $..sample.values[5].[2] |            | Array |
      | $..sample.values[5].[3] |            | Array |
    And user "update" the json file "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\Rochade_OraclePDB\API\Actual\ORACLE_TAG_DETAILS.json" file for following values
      | jsonPath                | jsonValues | type  |
      | $..sample.values[0].[6] |            | Array |
      | $..sample.values[0].[6] |            | Array |
      | $..sample.values[0].[6] |            | Array |
      | $..sample.values[0].[6] |            | Array |
      | $..sample.values[1].[6] |            | Array |
      | $..sample.values[1].[6] |            | Array |
      | $..sample.values[1].[6] |            | Array |
      | $..sample.values[1].[6] |            | Array |
      | $..sample.values[2].[6] |            | Array |
      | $..sample.values[2].[6] |            | Array |
      | $..sample.values[2].[6] |            | Array |
      | $..sample.values[2].[6] |            | Array |
      | $..sample.values[3].[6] |            | Array |
      | $..sample.values[3].[6] |            | Array |
      | $..sample.values[3].[6] |            | Array |
      | $..sample.values[3].[6] |            | Array |


  @TEST_MLPQA-3256 @MLPQA-17486 @7263927 @ROC_OracleAnalyzer19c_PDB
  Scenario: SC#22 MLP_24048_Verify the DataSamples values are as expected
    Then file content in "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\Rochade_OraclePDB\API\Expected\ORACLE_DIFFDATATYPES.json"
    Then file content in "ida\Rochade_OraclePDB\API\Actual\ORACLE_TABLE.json" should be same as the content in "ida\Rochade_OraclePDB\API\Expected\ORACLE_TABLE.json"
    Then file content in "ida\Rochade_OraclePDB\API\Actual\ORACLE_TAG_DETAILS.json" should be same as the content in "ida\Rochade_OraclePDB\API\Expected\ORACLE_TAG_DETAILS.json"
    Then file content in "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW.json" should be same as the content in "ida\Rochade_OraclePDB\API\Expected\ORACLE_DIFFDATATYPES_VIEW.json"

###################################################################################Data Profiling###################################################################################


  @TEST_MLPQA-3255 @MLPQA-17486 @7263928 @webtest  @ROC_OracleAnalyzer19c_PDB
  Scenario:SC#23_Verify data profiling (number, varchar2 ,Date and TimeStamp) for Table and View after running the Oracle Analyzer with SchemaFilter in LOCALNODE
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Oracle" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PDBDB19C.DIQ.QA.ASGINT.LOC" item from search results
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch |
      | Schemas | ORACLE12C_SCHEMA1  | click and switch tab | Yes              |             |
      | Tables  | ORACLE_TAG_DETAILS | click and switch tab | Yes              |             |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue | widgetName  |
      | Table Type        | TABLE         | Description |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    Then user performs click and verify in new window
      | Table   | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | FULL_NAME | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | VARCHAR2      | Description |
      | Length                        | 40            | Statistics  |
      | Maximum length                | 14            | Statistics  |
      | Maximum value                 | Lionel Messi  | Statistics  |
      | Minimum length                | 11            | Statistics  |
      | Minimum value                 | Alex Ferguson | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 4             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value           | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ORACLEDB_SALARY | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    And user "section presence" on "Data Distribution" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | NUMBER        | Description |
      | Average                       | 95.72         | Statistics  |
      | Length                        | 6             | Statistics  |
      | Median                        | 95.72         | Statistics  |
      | Maximum value                 | 100.9         | Statistics  |
      | Variance                      | 53.56         | Statistics  |
      | Minimum value                 | 90.55         | Statistics  |
      | Number of non null values     | 2             | Statistics  |
      | Percentage of non null values | 50            | Statistics  |
      | Number of null values         | 2             | Statistics  |
      | Number of unique values       | 2             | Statistics  |
      | Percentage of unique values   | 50            | Statistics  |
      | Standard deviation            | 7.32          | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value              | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Columns | ORACLEDB_LOCALTIME | click and switch tab | No               |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIMESTAMP     | Description |
      | Length                        | 0             | Statistics  |
#      | Maximum value                 | 2020-04-24 08:06:08 | Statistics  |
#      | Minimum value                 | 2020-04-24 08:06:08 | Statistics  |
      | Number of non null values     | 4             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 1             | Statistics  |
      | Percentage of unique values   | 25            | Statistics  |
    And user navigates to the index "1" to perform actions
    Then user performs click and verify in new window
      | Table   | value       | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | Tables  | ORACLE_VIEW | click and switch tab | Yes              |             |          |          |                 |
      | Columns | DOB         | click and switch tab | Yes              |             |          |          |                 |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | DATE          | Description |
      | Length                        | 0             | Statistics  |
#      | Maximum value                 | 2015-11-10 00:00:00 | Statistics  |
#      | Minimum value                 | 1945-01-01 00:00:00 | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |
    And user navigates to the index "0" to perform actions
    Then user performs click and verify in new window
      | Table   | value | Action               | RetainPrevwindow | indexSwitch |
      | Columns | DOB2  | click and switch tab | Yes              |             |
    Then user "verify metadata attributes" section has following values
      | metaDataAttribute | widgetName |
      | Last analyzed at  | Lifecycle  |
    And user "widget presence" on "Most frequent values" in Item view page
    Then the following metadata values should be displayed
      | metaDataAttribute             | metaDataValue | widgetName  |
      | Data type                     | TIMESTAMP     | Description |
      | Length                        | 6             | Statistics  |
#      | Maximum value                 | 2015-07-01 02:11:00 | Statistics  |
#      | Minimum value                 | 1945-01-01 11:11:00 | Statistics  |
      | Number of non null values     | 5             | Statistics  |
      | Percentage of non null values | 100           | Statistics  |
      | Number of null values         | 0             | Statistics  |
      | Number of unique values       | 5             | Statistics  |
      | Percentage of unique values   | 100           | Statistics  |

  @TEST_MLPQA-3260 @MLPQA-17486 @7263923 @ROC_OracleAnalyzer19c_PDB
  Scenario: SC#_24 MLP_7662_Verify data profiling (number, varchar2 ,Date and TimeStamp) for Table and View after running the Oracle Analyzer with SchemaFilter in LOCALNODE
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                        | jsonPath                                                       | Action                    | query                    | DatabaseName               | SchemaName        | TableName/Filename        | columnName/FieldName |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BFILECOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYDOUBLECOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYFLOATCOLUMN    |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | LONGCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCLOBCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | RAWCOLUMN            |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | ROWIDCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | UROWIDCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BFILECOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BINARYDOUBLECOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BINARYFLOATCOLUMN    |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | LONGCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCLOBCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NUMBERCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NUMBERCOLUMN         |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NUMBERCOLUMN         |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NVARCHAR2COLUMN      |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NVARCHAR2COLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | RAWCOLUMN            |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | ROWIDCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | UROWIDCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | VARCHAR2COLUMN       |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | VARCHAR2COLUMN       |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | VARCHAR2COLUMN       |

#####################################################################################################################################################################################
##########################################################Oracle Multiple Table filters(duplicate schema and duplicate tables)#####################################################
####################################################################################################################################################################################

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to cleanup for (duplicate schema , duplicate tables, Only Tables and Different Schema) scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And sync the test execution for "20" seconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile | path | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to replicate for (duplicate schema , duplicate tables, Only Tables and Different Schema) scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And sync the test execution for "20" seconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | bodyFile | path | response code | response message | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleReplicate_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB  |          |      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleReplicate_PDB')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure OracleAnlayzer on LocalNode and run for (duplicate schema , duplicate tables, Only Tables and Different Schema) scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                            | bodyFile                                                        | path                                             | response code | response message                           | jsonPath                                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_MultipleTables                                 | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.OracleDBAnalyzer_multipleTables.configurations | 204           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_MultipleTables                                 |                                                                 |                                                  | 200           | ROCHADE_ORACLE_PDB_ANLAYZER_MultipleTables |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_MultipleTables |                                                                 |                                                  | 200           | IDLE                                       | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_MultipleTables')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_MultipleTables  |                                                                 |                                                  | 200           |                                            |                                                                                 |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_MultipleTables |                                                                 |                                                  | 200           | IDLE                                       | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_MultipleTables')].status |

##############################################################################Data Profiling#############################################################################################

  @TEST_MLPQA-3253 @MLPQA-17486 @7263930 @TEST_MLPQA-3259 @MLPQA-17486 @7263924 @ROC_OracleAnalyzer19c_PDB
  Scenario: SC#25 MLP_7662_Verify data profiling for Table and View after running the Oracle Analyzer with SchemaFilter and Multiple Table filters in LOCALNODE
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                        | jsonPath                                                       | Action                    | query                    | DatabaseName               | SchemaName        | TableName/Filename        | columnName/FieldName |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BFILECOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYDOUBLECOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYFLOATCOLUMN    |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | LONGCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCLOBCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | RAWCOLUMN            |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | ROWIDCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | UROWIDCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BFILECOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BINARYDOUBLECOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BINARYFLOATCOLUMN    |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics           | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle            | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics           | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle            | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle           | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | LONGCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics          | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle           | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCLOBCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description        | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NUMBERCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NUMBERCOLUMN         |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle          | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NUMBERCOLUMN         |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description     | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NVARCHAR2COLUMN      |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics      | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle       | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NVARCHAR2COLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description           | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | RAWCOLUMN            |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description         | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | ROWIDCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle   | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle    | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics      | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle       | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description     | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description        | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | UROWIDCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics       | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | VARCHAR2COLUMN       |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle        | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | VARCHAR2COLUMN       |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description      | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | VARCHAR2COLUMN       |


##################################################################################Data Sampling################################################################################################

  @TEST_MLPQA-3254 @MLPQA-17486 @7263929 @ROC_OracleAnalyzer19c_PDB 
  Scenario Outline:SC26:user get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES","ORACLE_TABLE","ORACLE_TAG_DETAILS" with Different schemas
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                                   | asg_scopeid | targetFile                                    | jsonpath                                     |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES      |             | payloads/ida/Rochade_OraclePDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES      |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TABLE              |             | payloads/ida/Rochade_OraclePDB/API/items.json | $.Tables.TableName.ORACLE_TABLE              |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_TAG_DETAILS        |             | payloads/ida/Rochade_OraclePDB/API/items.json | $.Tables.TableName.ORACLE_TAG_DETAILS        |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES_VIEW |             | payloads/ida/Rochade_OraclePDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES_VIEW |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: SC26:user hits the TableID's and save the DataSample Values for (duplicate schema , duplicate tables, Only Tables and Different Schema)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                                    | inputFile                                     | outPutFile                                                               | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES      | payloads/ida/Rochade_OraclePDB/API/items.json | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES.json      |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables.TableName.ORACLE_TABLE              | payloads/ida/Rochade_OraclePDB/API/items.json | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_TABLE.json              |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables.TableName.ORACLE_TAG_DETAILS        | payloads/ida/Rochade_OraclePDB/API/items.json | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_TAG_DETAILS.json        |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES_VIEW | payloads/ida/Rochade_OraclePDB/API/items.json | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW.json |            |

  @ROC_OracleAnalyzer19c_PDB
  Scenario: SC#26_update the values with null for the dynamic columns for (duplicate schema , duplicate tables, Only Tables and Different Schema)
    And user "update" the json file "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\Rochade_OraclePDB\API\Actual\ORACLE_TABLE.json" file for following values
      | jsonPath                | jsonValues | type  |
      | $..sample.values[0].[0] |            | Array |
      | $..sample.values[0].[1] |            | Array |
      | $..sample.values[0].[2] |            | Array |
      | $..sample.values[0].[3] |            | Array |
      | $..sample.values[1].[0] |            | Array |
      | $..sample.values[1].[1] |            | Array |
      | $..sample.values[1].[2] |            | Array |
      | $..sample.values[1].[3] |            | Array |
      | $..sample.values[2].[0] |            | Array |
      | $..sample.values[2].[1] |            | Array |
      | $..sample.values[2].[2] |            | Array |
      | $..sample.values[2].[3] |            | Array |
      | $..sample.values[3].[0] |            | Array |
      | $..sample.values[3].[1] |            | Array |
      | $..sample.values[3].[2] |            | Array |
      | $..sample.values[3].[3] |            | Array |
      | $..sample.values[4].[0] |            | Array |
      | $..sample.values[4].[1] |            | Array |
      | $..sample.values[4].[2] |            | Array |
      | $..sample.values[4].[3] |            | Array |
      | $..sample.values[5].[0] |            | Array |
      | $..sample.values[5].[1] |            | Array |
      | $..sample.values[5].[2] |            | Array |
      | $..sample.values[5].[3] |            | Array |
    And user "update" the json file "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\Rochade_OraclePDB\API\Actual\ORACLE_TAG_DETAILS.json" file for following values
      | jsonPath                | jsonValues | type  |
      | $..sample.values[0].[6] |            | Array |
      | $..sample.values[0].[6] |            | Array |
      | $..sample.values[0].[6] |            | Array |
      | $..sample.values[0].[6] |            | Array |
      | $..sample.values[1].[6] |            | Array |
      | $..sample.values[1].[6] |            | Array |
      | $..sample.values[1].[6] |            | Array |
      | $..sample.values[1].[6] |            | Array |
      | $..sample.values[2].[6] |            | Array |
      | $..sample.values[2].[6] |            | Array |
      | $..sample.values[2].[6] |            | Array |
      | $..sample.values[2].[6] |            | Array |
      | $..sample.values[3].[6] |            | Array |
      | $..sample.values[3].[6] |            | Array |
      | $..sample.values[3].[6] |            | Array |
      | $..sample.values[3].[6] |            | Array |



  @TEST_MLPQA-3260 @MLPQA-17486 @7263923 @ROC_OracleAnalyzer19c_PDB
  Scenario: SC#26 MLP_24048_Verify data sampling and profiling happens properly when duplicate schema , duplicate tables, Only Tables and Different Schema are provided in filters
    Then file content in "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\Rochade_OraclePDB\API\Expected\ORACLE_DIFFDATATYPES.json"
    Then file content in "ida\Rochade_OraclePDB\API\Actual\ORACLE_TABLE.json" should be same as the content in "ida\Rochade_OraclePDB\API\Expected\ORACLE_TABLE.json"
    Then file content in "ida\Rochade_OraclePDB\API\Actual\ORACLE_TAG_DETAILS.json" should be same as the content in "ida\Rochade_OraclePDB\API\Expected\ORACLE_TAG_DETAILS.json"
    Then file content in "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW.json" should be same as the content in "ida\Rochade_OraclePDB\API\Expected\ORACLE_DIFFDATATYPES_VIEW.json"




   #####################################################################Logging Enhancements#######################################################################################

  @TEST_MLPQA-3250 @MLPQA-17486 @7263933 @ROC_OracleAnalyzer19c_PDB
  Scenario: Commoncase#MLP_24889_Verify the Analysis log information for Oracle Analyzer plugin
    Then Analysis log "dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_MultipleTables%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | logCode       | pluginName       | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   | ANALYSIS-0019 |                  |                |
      | INFO | ANALYSIS-0071: Plugin Name:OracleDBAnalyzer, Plugin Type:dataanalyzer, Plugin Version:1.2.0.SNAPSHOT, Node Name:LocalNode, Host Name:984a8d313571, Plugin Configuration name:ROCHADE_ORACLE_PDB_ANLAYZER                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | ANALYSIS-0071 | OracleDBAnalyzer | Plugin Version |
      | INFO | ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: ---  2020-12-31 05:58:47.774 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: name: "ROCHADE_ORACLE_PDB_ANLAYZER_MultipleTables"  2020-12-31 05:58:47.774 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginVersion: "LATEST"  2020-12-31 05:58:47.775 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: label:  2020-12-31 05:58:47.775 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: : ""  2020-12-31 05:58:47.775 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: auditFields:  2020-12-31 05:58:47.775 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: createdBy: "TestSystem"  2020-12-31 05:58:47.775 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: createdAt: "2020-12-31T05:58:05.590097"  2020-12-31 05:58:47.775 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: modifiedBy: "TestSystem"  2020-12-31 05:58:47.775 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: modifiedAt: "2020-12-31T05:58:05.590103"  2020-12-31 05:58:47.776 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: catalogName: "Default"  2020-12-31 05:58:47.776 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: eventClass: null  2020-12-31 05:58:47.776 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: eventCondition: null  2020-12-31 05:58:47.776 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: nodeCondition: "name==\"LocalNode\""  2020-12-31 05:58:47.776 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: maxWorkSize: 100  2020-12-31 05:58:47.776 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: tags: []  2020-12-31 05:58:47.776 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginType: "dataanalyzer"  2020-12-31 05:58:47.776 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: dataSource: null  2020-12-31 05:58:47.776 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: credential: null  2020-12-31 05:58:47.776 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: businessApplicationName: null  2020-12-31 05:58:47.776 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: schedule: null  2020-12-31 05:58:47.777 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: filter: null  2020-12-31 05:58:47.777 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: histogramBuckets: 10  2020-12-31 05:58:47.777 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: dryRun: false  2020-12-31 05:58:47.777 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: pluginName: "OracleDBAnalyzer"  2020-12-31 05:58:47.777 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: queryBatchSize: 100  2020-12-31 05:58:47.777 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: sampleDataCount: 25  2020-12-31 05:58:47.777 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: schemas:  2020-12-31 05:58:47.777 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - schema: "ORACLE12C_SCHEMA1"  2020-12-31 05:58:47.777 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: tables:  2020-12-31 05:58:47.777 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_DIFFDATATYPES_VIEW"  2020-12-31 05:58:47.778 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_DIFFDATATYPES"  2020-12-31 05:58:47.778 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_DIFFDATATYPES_VIEW"  2020-12-31 05:58:47.778 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - schema: "ORACLE12C_SCHEMA1"  2020-12-31 05:58:47.778 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: tables:  2020-12-31 05:58:47.778 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_TAG_DETAILS"  2020-12-31 05:58:47.778 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_TABLE"  2020-12-31 05:58:47.778 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - schema: "C##ORACLE12C_SCHEMA1"  2020-12-31 05:58:47.778 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: tables:  2020-12-31 05:58:47.778 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_TAG_DETAILS"  2020-12-31 05:58:47.778 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - tables:  2020-12-31 05:58:47.779 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: - table: "ORACLE_TAG_DETAILS"  2020-12-31 05:58:47.779 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: type: "Dataanalyzer"  2020-12-31 05:58:47.779 INFO  - ANALYSIS-0073: Plugin OracleDBAnalyzer Configuration: topValues: 10 | ANALYSIS-0073 | OracleDBAnalyzer |                |
      | INFO | Plugin OracleDBAnalyzer Start Time:2020-11-30 13:43:15.610, End Time:2020-11-30 13:44:38.785, Processed Count:0, Errors:4, Warnings:12                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | ANALYSIS-0072 | OracleDBAnalyzer |                |
      | INFO | Plugin completed with errors (elapsed time in (HH:MM:SS.ms): 00:00:30.610)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | ANALYSIS-0075 |                  |                |


    ##########################################################Technology ,BA and explicit tag validation######################################################

  #7152592
  @TEST_MLPQA-3250 @MLPQA-17486 @7263933 @ROC_OracleAnalyzer19c_PDB
  Scenario:Commoncase#MLP_24889_Verify Technology tag , Explicit tag , Bussiness Application tag and File Filter tag
    Given Tag verification of UI items in API for all the DataTypes
      | ServiceName              | DatabaseName               | SchemaName        | TableName/Filename   | Column      | Tags       | Query                    | Action      |
      |                          | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES | FLOATCOLUMN | ROC,Oracle | EDIColumnQuerywithSchema | TagAssigned |
      |                          | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES |             | ROC,Oracle | EDITableQuerywithSchema  | TagAssigned |
      |                          | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 |                      |             | ROC,Oracle | EDISchemaQuery           | TagAssigned |
      |                          | PDBDB19C.DIQ.QA.ASGINT.LOC |                   |                      |             | ROC,Oracle | EDIDatabaseQuery         | TagAssigned |
      | $$OracleDefaultSystem≫DB |                            |                   |                      |             | ROC,Oracle | EDIServiceQuery          | TagAssigned |



#####################################################################################################################################################################################
###########################################################################Oracle Table filter with Database#######################################################################
####################################################################################################################################################################################

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to cleanup for (Filter with Database) scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And sync the test execution for "20" seconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile | path | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to replicate for (Filter with Database) scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And sync the test execution for "20" seconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | bodyFile | path | response code | response message | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleReplicate_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB  |          |      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleReplicate_PDB')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure OracleAnlayzer on LocalNode and run for (Filter with Database) scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                                | bodyFile                                                        | path                                                 | response code | response message                               | jsonPath                                                                            |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_DatabasewithTables                                 | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.OracleDBAnalyzer_DatabasewithTables.configurations | 204           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_DatabasewithTables                                 |                                                                 |                                                      | 200           | ROCHADE_ORACLE_PDB_ANLAYZER_DatabasewithTables |                                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_DatabasewithTables |                                                                 |                                                      | 200           | IDLE                                           | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_DatabasewithTables')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_DatabasewithTables  |                                                                 |                                                      | 200           |                                                |                                                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_DatabasewithTables |                                                                 |                                                      | 200           | IDLE                                           | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_DatabasewithTables')].status |

  @TEST_MLPQA-3251 @MLPQA-17486 @7263932 @TEST_MLPQA-3261 @MLPQA-17486 @7263922 @ROC_OracleAnalyzer19c_PDB
  Scenario: SC#27_MLP_7662_Verify data profiling for Table and View after running the Oracle Analyzer with Database filters in LOCALNODE
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                        | jsonPath                                                                 | Action                    | query                    | DatabaseName               | SchemaName        | TableName/Filename        | columnName/FieldName |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description                   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BFILECOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description            | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYDOUBLECOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description             | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYFLOATCOLUMN    |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description                    | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description                    | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics                     | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle                      | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description                    | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description                    | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics                     | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle                      | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics_Attributes          | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description                   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics                    | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle                     | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description                    | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | LONGCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description                   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics                    | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle                     | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description                   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCLOBCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description                  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics                   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle                    | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description               | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics                | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle                 | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description                     | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | RAWCOLUMN            |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description                   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | ROWIDCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics            | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle             | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description           | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics_Attributes | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics             | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle              | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description            | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics_Attributes  | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics                | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle                 | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description               | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics_Attributes     | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description                  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | UROWIDCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics                 | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle                  | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description                | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description                   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BFILECOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description            | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BINARYDOUBLECOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description             | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BINARYFLOATCOLUMN    |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description                    | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description                    | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics                     | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle                      | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description                    | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description                    | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics                     | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle                      | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics_Attributes          | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description                   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics                    | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle                     | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description                    | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | LONGCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description                   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics                    | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle                     | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description                   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCLOBCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description                  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NUMBERCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics                   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NUMBERCOLUMN         |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle                    | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NUMBERCOLUMN         |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description               | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NVARCHAR2COLUMN      |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics                | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle                 | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NVARCHAR2COLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description                     | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | RAWCOLUMN            |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description                   | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | ROWIDCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics            | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle             | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description           | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics_Attributes | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics             | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle              | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description            | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics_Attributes  | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics                | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle                 | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description               | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics_Attributes     | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description                  | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | UROWIDCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics                 | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | VARCHAR2COLUMN       |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle                  | metadataAttributePresence | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | VARCHAR2COLUMN       |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description                | metadataValuePresence     | EDIColumnQuerywithSchema | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | VARCHAR2COLUMN       |


##################################################################################Data Sampling################################################################################################

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline:SC28:user get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES","ORACLE_TABLE","ORACLE_TAG_DETAILS"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                  | name                                                                   | asg_scopeid | targetFile                                    | jsonpath                                     |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES      |             | payloads/ida/Rochade_OraclePDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES      |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES_VIEW |             | payloads/ida/Rochade_OraclePDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES_VIEW |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: SC28:user hits the TableID's and save the DataSample Values for (Filter with Database)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                                    | inputFile                                     | outPutFile                                                               | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES      | payloads/ida/Rochade_OraclePDB/API/items.json | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES.json      |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES_VIEW | payloads/ida/Rochade_OraclePDB/API/items.json | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW.json |            |

  @ROC_OracleAnalyzer19c_PDB
  Scenario: SC#28_update the values with null for the dynamic columns for (Filter with Database)
    And user "update" the json file "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |
    And user "update" the json file "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[15] |            | Array |
      | $..sample.values[1].[15] |            | Array |
      | $..sample.values[2].[15] |            | Array |
      | $..sample.values[3].[15] |            | Array |
      | $..sample.values[4].[15] |            | Array |
      | $..sample.values[0].[16] |            | Array |
      | $..sample.values[1].[16] |            | Array |
      | $..sample.values[2].[16] |            | Array |
      | $..sample.values[3].[16] |            | Array |
      | $..sample.values[4].[16] |            | Array |



  @TEST_MLPQA-16813 @MLPQA-17486 @7270705 @ROC_OracleAnalyzer19c_PDB
  Scenario: SC#28 MLP_24048_Verify data sampling and profiling happens properly when table name alone given in filter(Filter with Database)
    Then file content in "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES.json" should be same as the content in "ida\Rochade_OraclePDB\API\Expected\ORACLE_DIFFDATATYPES.json"
    Then file content in "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW.json" should be same as the content in "ida\Rochade_OraclePDB\API\Expected\ORACLE_DIFFDATATYPES_VIEW.json"


#######################################################################################################################################################################################
##################################################################################Dry Run#########################################################################################################
#########################################################################################################################################################################################

    #Bug-31469
  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to cleanup for Dry Run scenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And sync the test execution for "20" seconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile | path | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to replicate for Dry Run dcenario
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And sync the test execution for "20" seconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | bodyFile | path | response code | response message | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleReplicate_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB  |          |      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleReplicate_PDB')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure OracleAnlayzer on Local Node and run with Dry run
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                    | bodyFile                                                        | path                                     | response code | response message                   | jsonPath                                                                |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_DryRun                                 | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.OracleDBAnalyzer_DryRun.configurations | 204           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_DryRun                                 |                                                                 |                                          | 200           | ROCHADE_ORACLE_PDB_ANLAYZER_DryRun |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_DryRun |                                                                 |                                          | 200           | IDLE                               | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_DryRun')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_DryRun  |                                                                 |                                          | 200           |                                    |                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_DryRun |                                                                 |                                          | 200           | IDLE                               | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_DryRun')].status |

      #Bug-31469
  @TEST_MLPQA-3250 @MLPQA-17486 @7263933 @ROC_OracleAnalyzer19c_PDB
  Scenario: Commoncase#MLP_24889_Verify the Analysis log information for Oracle Analyzer plugin with Dry Run TRUE
    Then Analysis log "dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_DryRun%" should display below info/error/warning
      | type | logValue                                                                                                                              | logCode       | pluginName       | removableText |
      | INFO | Plugin started                                                                                                                        | ANALYSIS-0019 |                  |               |
      | INFO | Plugin OracleDBAnalyzer running on dry run mode                                                                                       | ANALYSIS-0069 | OracleDBAnalyzer |               |
      | INFO | Plugin OracleDBAnalyzer processed 0 items on dry run mode and not written to the repository                                           | ANALYSIS-0070 |                  |               |
      | INFO | Plugin OracleDBAnalyzer Start Time:2021-01-16 07:42:53.269, End Time:2021-01-16 07:42:53.369, Processed Count:0, Errors:0, Warnings:1 | ANALYSIS-0072 | OracleDBAnalyzer |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:40.205)                                                                        | ANALYSIS-0020 |                  |               |

###############################################################################################################################################################################################
##########################################################################Invalid Database , Schema and tables################################################################################
#########################################################################################################################################################################################################

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to cleanup for 3rd time
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And sync the test execution for "20" seconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile | path | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to replicate for 3rd time
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And sync the test execution for "20" seconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                            | bodyFile | path | response code | response message | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleReplicate_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB  |          |      | 200           |                  |                                                                |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleReplicate_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleReplicate_PDB')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure OracleAnlayzer on Local Node and run with Invalid Database
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                             | bodyFile                                                        | path                                              | response code | response message                            | jsonPath                                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_InvalidDatabase                                 | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.OracleDBAnalyzer_InvalidDatabase.configurations | 204           |                                             |                                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_InvalidDatabase                                 |                                                                 |                                                   | 200           | ROCHADE_ORACLE_PDB_ANLAYZER_InvalidDatabase |                                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_InvalidDatabase |                                                                 |                                                   | 200           | IDLE                                        | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_InvalidDatabase')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_InvalidDatabase  |                                                                 |                                                   | 200           |                                             |                                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_InvalidDatabase |                                                                 |                                                   | 200           | IDLE                                        | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER_InvalidDatabase')].status |

  @TEST_MLPQA-16814 @MLPQA-17486 @7263934 @ROC_OracleAnalyzer19c_PDB
  Scenario: SC#29_MLP_24889_Verify the Analysis log information for Oracle Analyzer plugin with invalid Database
    Then Analysis log "dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER_InvalidDatabase%" should display below info/error/warning
      | type | logValue                                                             | logCode            | pluginName | removableText |
      | INFO | Plugin started                                                       | ANALYSIS-0019      |            |               |
      | WARN | Database [PDBDB19C.DIQ.QA.ASGINT.LOC12345] not found in the Catalog. | ANALYSIS-JDBC-0053 |            |               |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:01:40.205)       | ANALYSIS-0020      |            |               |



###########################################################################################################################################################################################
############################################################################ Different Host #########################################################################################
############################################################################################################################################################################################

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline:Configure and run Oracle19c PDB Cataloger (Not Rochade/CAE)
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | body                                                                                           | response code | response message                | jsonPath                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                                             | ida/jdbcAnalyzerPayloads/Oracle19cPDB/OracleDataSource.json                                    | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                                             |                                                                                                | 200           | Oracle19cPDBDS                  |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                                              | ida/jdbcAnalyzerPayloads/Oracle19cPDB/pluginConfiguration/OracleCatalogerWithSchemaFilter.json | 204           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                                              |                                                                                                | 200           | OracleCatalogerWithSchemaFilter |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter  |                                                                                                | 200           |                                 |                                                                      |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter |                                                                                                | 200           | IDLE                            | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Run Oracle Anlayzer to Anlayze both Rochade and Normal Oracle data
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                             | bodyFile                                                        | path                              | response code | response message            | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER                                 | payloads/ida/Rochade_OraclePDB/Configurations/pluginconfig.json | $.OracleDBAnalyzer.configurations | 204           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER                                 |                                                                 |                                   | 200           | ROCHADE_ORACLE_PDB_ANLAYZER |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER |                                                                 |                                   | 200           | IDLE                        | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER  |                                                                 |                                   | 200           |                             |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/ROCHADE_ORACLE_PDB_ANLAYZER |                                                                 |                                   | 200           | IDLE                        | $.[?(@.configurationName=='ROCHADE_ORACLE_PDB_ANLAYZER')].status |


    ##############################################################################Data Profiling#############################################################################################

  @TEST_MLPQA-3252 @MLPQA-17486 @7263931 @ROC_OracleAnalyzer19c_PDB
  Scenario: SC#30_MLP_7662_Verify data profiling for Table and View after running the Oracle Analyzer with Database filters in LOCALNODE for the Rochade Oracle PDB Host
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                        | jsonPath                                                                 | Action                    | query                     | ServiceName              | DatabaseName               | SchemaName        | TableName/Filename        | columnName/FieldName |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description                   | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BFILECOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description            | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYDOUBLECOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description             | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYFLOATCOLUMN    |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description                    | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description                    | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics                     | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle                      | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description                    | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description                    | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics                     | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle                      | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics_Attributes          | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description                   | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics                    | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle                     | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description                    | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | LONGCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description                   | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics                    | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle                     | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description                   | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCLOBCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description                  | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics                   | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle                    | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description               | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics                | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle                 | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description                     | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | RAWCOLUMN            |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description                   | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | ROWIDCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics            | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle             | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description           | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics_Attributes | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics             | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle              | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description            | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics_Attributes  | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics                | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle                 | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description               | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics_Attributes     | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description                  | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | UROWIDCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics                 | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle                  | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description                | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Description                   | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BFILECOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Description            | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BINARYDOUBLECOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Description             | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BINARYFLOATCOLUMN    |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Description                    | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description                    | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics                     | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle                      | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description                    | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Description                    | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics                     | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle                      | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics_Attributes          | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description                   | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics                    | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle                     | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Description                    | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | LONGCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description                   | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics                    | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle                     | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description                   | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCLOBCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Description                  | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NUMBERCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics                   | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NUMBERCOLUMN         |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle                    | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NUMBERCOLUMN         |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Description               | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NVARCHAR2COLUMN      |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics                | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle                 | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NVARCHAR2COLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Description                     | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | RAWCOLUMN            |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Description                   | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | ROWIDCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics            | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle             | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Description           | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics_Attributes | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics             | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle              | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Description            | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics_Attributes  | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics                | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle                 | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Description               | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics_Attributes     | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Description                  | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | UROWIDCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics                 | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | VARCHAR2COLUMN       |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle                  | metadataAttributePresence | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | VARCHAR2COLUMN       |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Description                | metadataValuePresence     | ColumnQueryWithoutCluster | $$OracleDefaultSystem≫DB | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | VARCHAR2COLUMN       |

  @TEST_MLPQA-3251 @MLPQA-17486 @7263932 @ROC_OracleAnalyzer19c_PDB
  Scenario: SC#31_MLP_7662_Verify data profiling for Table and View after running the Oracle Analyzer with Database filters in LOCALNODE for the Normal Oracle PDB host
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                        | jsonPath                                                                 | Action                       | query                 | ClusterName                     | ServiceName | DatabaseName               | SchemaName        | TableName/Filename        | columnName/FieldName |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Lifecycle                     | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BFILECOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Lifecycle              | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYDOUBLECOLUMN   |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Lifecycle               | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BINARYFLOATCOLUMN    |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Lifecycle                      | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | BLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description                    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics                     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle                      | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CHARCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description                    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | CLOBCOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics1                    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle                      | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics_Attributes          | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics1                   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description                   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle                     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | FLOATCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Lifecycle                      | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | LONGCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description                   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics                    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle                     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCHARCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description                   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NCLOBCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics1                  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle                    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NUMBERCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics                | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle                 | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Lifecycle                       | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | RAWCOLUMN            |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Lifecycle                     | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | ROWIDCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics1           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle             | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics_Attributes | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics1            | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle              | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics_Attributes  | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics1               | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle                 | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics_Attributes     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Lifecycle                    | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | UROWIDCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics                 | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle                  | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES      | VARCHAR2COLUMN       |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BFILECOLUMN.Lifecycle                     | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BFILECOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYDOUBLECOLUMN.Lifecycle              | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BINARYDOUBLECOLUMN   |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BINARYFLOATCOLUMN.Lifecycle               | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BINARYFLOATCOLUMN    |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.BLOBCOLUMN.Lifecycle                      | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | BLOBCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Description                    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Statistics                     | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CHARCOLUMN.Lifecycle                      | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CHARCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.CLOBCOLUMN.Description                    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | CLOBCOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics1                    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Lifecycle                      | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.DATECOLUMN.Statistics_Attributes          | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | DATECOLUMN           |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Statistics1                   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Description                   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.FLOATCOLUMN.Lifecycle                     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | FLOATCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.LONGCOLUMN.Lifecycle                      | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | LONGCOLUMN           |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Description                   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Statistics                    | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCHARCOLUMN.Lifecycle                     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCHARCOLUMN          |
      | Description | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NCLOBCOLUMN.Description                   | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NCLOBCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Statistics1                  | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NUMBERCOLUMN         |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NUMBERCOLUMN.Lifecycle                    | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NUMBERCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Statistics                | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.NVARCHAR2COLUMN.Lifecycle                 | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | NVARCHAR2COLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.RAWCOLUMN.Lifecycle                       | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | RAWCOLUMN            |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.ROWIDCOLUMN.Lifecycle                     | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | ROWIDCOLUMN          |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics1           | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Lifecycle             | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6LTZCOLUMN.Statistics_Attributes | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6LTZCOLUMN  |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics1            | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Lifecycle              | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMP6TZCOLUMN.Statistics_Attributes  | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMP6TZCOLUMN   |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics1               | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Lifecycle                 | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.TIMESTAMPCOLUMN.Statistics_Attributes     | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | TIMESTAMPCOLUMN      |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.UROWIDCOLUMN.Lifecycle                    | metadataAttributeNonPresence | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | UROWIDCOLUMN         |
      | Statistics  | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Statistics                 | metadataValuePresence        | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | VARCHAR2COLUMN       |
      | Lifecycle   | ida/Rochade_OraclePDB/API/expectedMetadata.json | $.ORACLE_DIFFDATATYPES.Columns.VARCHAR2COLUMN.Lifecycle                  | metadataAttributePresence    | ColumnQuerywithSchema | diqscanora01v.diq.qa.asgint.loc | ORACLE:1522 | PDBDB19C.DIQ.QA.ASGINT.LOC | ORACLE12C_SCHEMA1 | ORACLE_DIFFDATATYPES_VIEW | VARCHAR2COLUMN       |


##################################################################################Data Sampling################################################################################################

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline:SC32:user get the Dynamic ID's (Table ID) for the Table name "ORACLE_DIFFDATATYPES","ORACLE_TABLE","ORACLE_TAG_DETAILS","ORACLE_DIFFDATATYPES,"ORACLE_DIFFDATATYPES_VIEW"
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type                                  | name                                                                                                               | asg_scopeid | targetFile                                    | jsonpath                                      |
      | APPDBPOSTGRES | Unique_ID | Default | Cluster,Service,Database,Schema,Table | diqscanora01v.diq.qa.asgint.loc,ORACLE:1522,PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES      |             | payloads/ida/Rochade_OraclePDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES1      |
      | APPDBPOSTGRES | Unique_ID | Default | Cluster,Service,Database,Schema,Table | diqscanora01v.diq.qa.asgint.loc,ORACLE:1522,PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES_VIEW |             | payloads/ida/Rochade_OraclePDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES_VIEW1 |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table                 | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES                                                  |             | payloads/ida/Rochade_OraclePDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES       |
      | APPDBPOSTGRES | Unique_ID | Default | Database,Schema,Table                 | PDBDB19C.DIQ.QA.ASGINT.LOC,ORACLE12C_SCHEMA1,ORACLE_DIFFDATATYPES_VIEW                                             |             | payloads/ida/Rochade_OraclePDB/API/items.json | $.Tables.TableName.ORACLE_DIFFDATATYPES_VIEW  |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: SC32:user hits the TableID's and save the DataSample Values for (Filter with Database)
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                              | responseCode | inputJson                                     | inputFile                                     | outPutFile                                                                           | outPutJson |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES       | payloads/ida/Rochade_OraclePDB/API/items.json | payloads\ida\Rochade_OracleCDB\API\Actual\ORACLE_DIFFDATATYPES_DiffHost.json         |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES_VIEW  | payloads/ida/Rochade_OraclePDB/API/items.json | payloads\ida\Rochade_OracleCDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW_DiffHost.json    |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES1      | payloads/ida/Rochade_OraclePDB/API/items.json | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_NormalTable.json      |            |
      | components/Default/definition/dataSample/Default.Table:::dynamic | 200          | $.Tables.TableName.ORACLE_DIFFDATATYPES_VIEW1 | payloads/ida/Rochade_OraclePDB/API/items.json | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW_NormalTable.json |            |

  @ROC_OracleAnalyzer19c_PDB
  Scenario: SC#32_update the values with null for the dynamic columns for (Diffrent Host)
    And user "update" the json file "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_DiffHost.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[12] |            | Array |
      | $..sample.values[1].[12] |            | Array |
      | $..sample.values[2].[12] |            | Array |
      | $..sample.values[3].[12] |            | Array |
      | $..sample.values[4].[12] |            | Array |
      | $..sample.values[0].[13] |            | Array |
      | $..sample.values[1].[13] |            | Array |
      | $..sample.values[2].[13] |            | Array |
      | $..sample.values[3].[13] |            | Array |
      | $..sample.values[4].[13] |            | Array |
    And user "update" the json file "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW_DiffHost.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[12] |            | Array |
      | $..sample.values[1].[12] |            | Array |
      | $..sample.values[2].[12] |            | Array |
      | $..sample.values[3].[12] |            | Array |
      | $..sample.values[4].[12] |            | Array |
      | $..sample.values[0].[13] |            | Array |
      | $..sample.values[1].[13] |            | Array |
      | $..sample.values[2].[13] |            | Array |
      | $..sample.values[3].[13] |            | Array |
      | $..sample.values[4].[13] |            | Array |
    And user "update" the json file "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_NormalTable.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[12] |            | Array |
      | $..sample.values[1].[12] |            | Array |
      | $..sample.values[2].[12] |            | Array |
      | $..sample.values[3].[12] |            | Array |
      | $..sample.values[4].[12] |            | Array |
      | $..sample.values[0].[13] |            | Array |
      | $..sample.values[1].[13] |            | Array |
      | $..sample.values[2].[13] |            | Array |
      | $..sample.values[3].[13] |            | Array |
      | $..sample.values[4].[13] |            | Array |
    And user "update" the json file "ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW_NormalTable.json" file for following values
      | jsonPath                 | jsonValues | type  |
      | $..sample.values[0].[12] |            | Array |
      | $..sample.values[1].[12] |            | Array |
      | $..sample.values[2].[12] |            | Array |
      | $..sample.values[3].[12] |            | Array |
      | $..sample.values[4].[12] |            | Array |
      | $..sample.values[0].[13] |            | Array |
      | $..sample.values[1].[13] |            | Array |
      | $..sample.values[2].[13] |            | Array |
      | $..sample.values[3].[13] |            | Array |
      | $..sample.values[4].[13] |            | Array |



  @TEST_MLPQA-3251 @MLPQA-17486 @7263932 @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: SC#32 MLP_24048_Verify data sampling and profiling happens properly when table name alone given in filter(Filter with Database)
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                                         | actualValues                                                                         | valueType         | expectedJsonPath        | actualJsonPath          |
      | payloads\ida\Rochade_OraclePDB\API\Expected\ORACLE_DIFFDATATYPES.json                  | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES.json                  | stringListCompare | $..sample.values[*].[*] | $..sample.values[*].[*] |
      | payloads\ida\Rochade_OraclePDB\API\Expected\ORACLE_DIFFDATATYPES_VIEW.json             | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW.json             | stringListCompare | $..sample.values[*].[*] | $..sample.values[*].[*] |
      | payloads\ida\Rochade_OraclePDB\API\Expected\ORACLE_DIFFDATATYPES_NormalTable.json      | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_NormalTable.json      | stringListCompare | $..sample.values[*].[*] | $..sample.values[*].[*] |
      | payloads\ida\Rochade_OraclePDB\API\Expected\ORACLE_DIFFDATATYPES_VIEW_NormalTable.json | payloads\ida\Rochade_OraclePDB\API\Actual\ORACLE_DIFFDATATYPES_VIEW_NormalTable.json | stringListCompare | $..sample.values[*].[*] | $..sample.values[*].[*] |

  @ROC_OracleAnalyzer19c_PDB
  Scenario:Delete oracle cluster and all PDB related Anlaysis
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                          | type     | query | param |
      | MultipleIDDelete | Default | diqscanora01v.diq.qa.asgint.loc                               | Cluster  |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/%                                                 | Analysis |       |       |
      | MultipleIDDelete | Default | dataanalyzer/OracleDBAnalyzer/%                               | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/OracleScan/RochadeOracleScan_PDB/%                    | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/OracleImport/RochadeOracleImport_PDB/%                | Analysis |       |       |
      | MultipleIDDelete | Default | rochade/OracleReconcile/RochadeOracleReconcile_PDB/%          | Analysis |       |       |
      | MultipleIDDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter/% | Analysis |       |       |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline: Configure EDI Bus amd run to cleanup to delete all the ROC Oracle data from DD
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And sync the test execution for "20" seconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile | path | response code | response message | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB  |          |      | 200           |                  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusOracleCleanup_PDB |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBusOracleCleanup_PDB')].status |

  @ROC_OracleAnalyzer19c_PDB
  Scenario Outline:MLP-24889:Deleting the Credentials , DataSource and Configuration from DDUI
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                          | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeCredentials      |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/Oracle19Credentials     |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/Oracle19cPDBCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/EDICredentials          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus                    |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleDBAnalyzer          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleDBCataloger         |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleScan                |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleReconcile           |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleImport              |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCOracleSADataSource     |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/OracleDBDataSource        |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCOracleDataSource       |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource          |      | 204           |                  |          |

