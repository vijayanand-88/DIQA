Feature: Verify the Lineage cases in API and UI for the Oracle Post Processor Plugin


 ##################### Add Credentials for Oracle 19cRDS ####################################################

  @precondition
  Scenario:SC#1_1_Update credential payload json for Oracle19cRDS
    Given User update the below "Oracle19cRDS Readonly credentials" in following files using json path
      | filePath                                                                             | username    | password    |
      | ida/jdbcAnalyzerPayloads/oracle19cPostProcessorPayloads/Oracle19cRDSCredentials.json | $..userName | $..password |


  @sanity @positive @regression @IDA_E2E
  Scenario Outline:SC#1_2_Add valid Credentials for Oracle19cRDS
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                          | body                                                                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Oracle19cRDSLineageCred | ida/jdbcAnalyzerPayloads/oracle19cPostProcessorPayloads/Oracle19cRDSCredentials.json                   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/Oracle19cRDSLineageCred |                                                                                                        | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post | items/Default/root                           | ida/jdbcAnalyzerPayloads/oracle19cPostProcessorPayloads/businessApplication19cRDSPostProcessorTag.json | 200           |                  |          |


 ########################################## Run the Oracle Cataloger and Post Processor for Oracle 19cRDS #########################################


  @jdbc
  Scenario Outline:SC#1_3_Run the OracleDB Cataloger and PostProcessor Plugin for Oracle version 19cRDS
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                      | body                                                                                                | response code | response message                       | jsonPath                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                    | ida/jdbcAnalyzerPayloads/oracle19cPostProcessorPayloads/OracleDataSource_19cRDS.json                | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBDataSource                                    |                                                                                                     | 200           | Oracle19cRDSDSLineage                  |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                     | ida/jdbcAnalyzerPayloads/oracle19cPostProcessorPayloads/OracleCatalogerWithSchemaFilter_19cRDS.json | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                     |                                                                                                     | 200           | OracleCatalogerWithSchemaFilter_19cRDS |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*      |                                                                                                     | 200           | IDLE                                   | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter_19cRDS')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*       | ida/jdbcAnalyzerPayloads/oracle19cPostProcessorPayloads/empty.json                                  | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*      |                                                                                                     | 200           | IDLE                                   | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter_19cRDS')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBPostProcessor                                 | ida/jdbcAnalyzerPayloads/oracle19cPostProcessorPayloads/Oracle19cRDS_PostProcessor.json             | 204           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBPostProcessor                                 |                                                                                                     | 200           | Oracle19cRDS_PostProcessor             |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/lineage/OracleDBPostProcessor/* |                                                                                                     | 200           | IDLE                                   | $.[?(@.configurationName=='Oracle19cRDS_PostProcessor')].status             |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/lineage/OracleDBPostProcessor/*  | ida/jdbcAnalyzerPayloads/oracle19cPostProcessorPayloads/empty.json                                  | 200           |                                        |                                                                             |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/lineage/OracleDBPostProcessor/* |                                                                                                     | 200           | IDLE                                   | $.[?(@.configurationName=='Oracle19cRDS_PostProcessor')].status             |


#################################Verify Processed count, items and Logging enhancement for oracle 19cCDB##################################################################


  @webtest @positive
  Scenario: SC#2_Verify the OracleDB Postprocessor Plugin Processed Items for Oracle19cRDS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc19cRDSPostProcessor" and clicks on search
    And user performs "facet selection" in "Orc19cRDSPostProcessor" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/OracleDBPostProcessor/Oracle19cRDS_PostProcessor%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    And user "verifies tab section values" has the following values in "Processed Items" Tab in Item View page
      | idadb.cshey0cobobn.us-east-1.rds.amazonaws.com |
      | ORACLE:1521                                    |


  @webtest @positive
  Scenario: SC#3_Verify the Logging enhancement in OracleDB Postprocessor for Oracle19cRDS
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Orc19cRDSPostProcessor" and clicks on search
    And user performs "facet selection" in "Orc19cRDSPostProcessor" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/OracleDBPostProcessor/Oracle19cRDS_PostProcessor%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 2             | Description |
      | Number of errors          | 0             | Description |
    Then Analysis log "lineage/OracleDBPostProcessor/Oracle19cRDS_PostProcessor%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        | logCode       | pluginName            | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0019 |                       |                |
      | INFO | Plugin Name:OracleDBPostProcessor, Plugin Type:lineage, Plugin Version:1.1.0.SNAPSHOT, Node Name:InternalNode, Host Name:a8c7a014c198, Plugin Configuration name:Oracle19cRDS_PostProcessor                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | ANALYSIS-0071 | OracleDBPostProcessor | Plugin Version |
      | INFO | Plugin OracleDBPostProcessor Configuration: --- 2020-09-21 16:46:51.123 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: name: "Oracle19cRDS_PostProcessor" 2020-09-21 16:46:51.123 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: pluginVersion: "LATEST" 2020-09-21 16:46:51.124 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: label: 2020-09-21 16:46:51.124 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: : "" 2020-09-21 16:46:51.124 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: catalogName: "Default" 2020-09-21 16:46:51.124 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: eventClass: null 2020-09-21 16:46:51.125 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: eventCondition: null 2020-09-21 16:46:51.125 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: nodeCondition: "name==\"InternalNode\"" 2020-09-21 16:46:51.125 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: maxWorkSize: 100 2020-09-21 16:46:51.125 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: tags: 2020-09-21 16:46:51.125 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: - "Orc19cRDSPostProcessor" 2020-09-21 16:46:51.126 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: pluginType: "lineage" 2020-09-21 16:46:51.126 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: dataSource: null 2020-09-21 16:46:51.126 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: credential: null 2020-09-21 16:46:51.126 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: businessApplicationName: "Oracle19C_RDS_PP" 2020-09-21 16:46:51.126 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: dryRun: false 2020-09-21 16:46:51.126 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: schedule: null 2020-09-21 16:46:51.126 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: filter: null 2020-09-21 16:46:51.127 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: pluginName: "OracleDBPostProcessor" 2020-09-21 16:46:51.127 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: arguments: [] 2020-09-21 16:46:51.127 INFO - ANALYSIS-0073: Plugin OracleDBPostProcessor Configuration: type: "Lineage" | ANALYSIS-0073 | OracleDBPostProcessor |                |
      | INFO | Plugin OracleDBPostProcessor Start Time:2020-05-21 08:24:01.346, End Time:2020-05-21 08:24:15.877, Processed Count:2, Errors:0, Warnings:1                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | ANALYSIS-0072 | OracleDBPostProcessor |                |
      | INFO | Plugin completed (elapsed time in (HH:MM:SS.ms): 00:00:14.531)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  | ANALYSIS-0020 |                       |                |


    ####################################################Lineage Verification in Oracle19cRDS##########################################################################################################


 ##7126839## ##7126840## ##7126841## ##7126842## ##7126843## ##7126844## ##7126845## ##7126846## ##7126847## ##7126848## ##7126849## ##7126850## ##7126851## ##7126852## ##7126853## ##7126854## ##7126855## ##7126856## ##7126857## ##7126858## ##7126859## ##7126860## ##7126861## ##7126862## ##7126863## ##7126864## ##7126865## ##7126866## ##7126867## ##7126868## ##7126869##
  Scenario Outline:SC#4_1_user retrieves ids for specific item name
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>"
    Examples:
      | database      | catalog | name                                             | type  | targetFile                                                            |
      | APPDBPOSTGRES | Default | OCPPT2T1                                         | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OCPPV2T                                          | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OCPPVIEW                                         | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OCPPFT2T2                                        | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OCPPDSV2T                                        | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OCPPDSVT                                         | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | TRIGGERTEST                                      | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | ViewToMultipleTableGroupbyHaving                 | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | Oracleviewtosingletable                          | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | Oracleviewtomultipletable                        | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OraclemultipletableForceView                     | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleSingleViewtoView                           | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewfromViewToViewViewToTable              | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewToMultipleTableWithJoin                | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewToMultipleTableWithJoinhavingCondition | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewToMultipleTableGroupbyHaving           | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewWithUnionAll                           | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewFromMultipleTableUsingInnerJoin        | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewFromMultipleTableUsingLeftOuterJoin    | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewFromMultipleTableUsingRightOuterJoin   | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewFromMultipleTableUsingFullOuterJoin    | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewFromMultipleTableUsingCrossJoin        | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewNaturaljoin                            | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewSubqueryUsingWhere                     | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewFromComplexStatement                   | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewSubqueryUsingWhereExist                | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OraclecityviewOrderBy                            | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | sales_mv                                         | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleObjectView                                 | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewFromRangePartionedTable                | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewFromListPartionedTable                 | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewFromHashPartionedTable                 | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewfromIndexOrganizedTables               | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewfromMultipleTableWithCondt             | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewfromMultipleView                       | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewToMultipleTableWithJoinDiffSchema      | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OrcaViewFromDiffSchema                           | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OrcaViewFromDiffSchemaWithCondt                  | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |
      | APPDBPOSTGRES | Default | OracleViewWithClause                             | Table | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json |


     ##7126839## ##7126840## ##7126841## ##7126842## ##7126843## ##7126844## ##7126845## ##7126846## ##7126847## ##7126848## ##7126849## ##7126850## ##7126851## ##7126852## ##7126853## ##7126854## ##7126855## ##7126856## ##7126857## ##7126858## ##7126859## ##7126860## ##7126861## ##7126862## ##7126863## ##7126864## ##7126865## ##7126866## ##7126867## ##7126868## ##7126869##
  Scenario Outline:SC#4_2_user copy the id to payload
    Given user copy the id from "<file>" to "<payloadFile>" with "<type>" using "<jsonPath>"
    Examples:
      | file                                                                  | payloadFile                                                                                            | type  | jsonPath                                            |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OCPPT2T1.json                                         | Table | $..OCPPT2T1                                         |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OCPPV2T.json                                          | Table | $..OCPPV2T                                          |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OCPPVIEW.json                                         | Table | $..OCPPVIEW                                         |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OCPPFT2T2.json                                        | Table | $..OCPPFT2T2                                        |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OCPPDSV2T.json                                        | Table | $..OCPPDSV2T                                        |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OCPPDSVT.json                                         | Table | $..OCPPDSVT                                         |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/TRIGGERTEST.json                                      | Table | $..TRIGGERTEST                                      |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/ViewToMultipleTableGroupbyHaving.json                 | Table | $..ViewToMultipleTableGroupbyHaving                 |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/Oracleviewtosingletable.json                          | Table | $..Oracleviewtosingletable                          |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/Oracleviewtomultipletable.json                        | Table | $..Oracleviewtomultipletable                        |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OraclemultipletableForceView.json                     | Table | $..OraclemultipletableForceView                     |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleSingleViewtoView.json                           | Table | $..OracleSingleViewtoView                           |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewfromViewToViewViewToTable.json              | Table | $..OracleViewfromViewToViewViewToTable              |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewToMultipleTableWithJoin.json                | Table | $..OracleViewToMultipleTableWithJoin                |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewToMultipleTableWithJoinhavingCondition.json | Table | $..OracleViewToMultipleTableWithJoinhavingCondition |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewToMultipleTableGroupbyHaving.json           | Table | $..OracleViewToMultipleTableGroupbyHaving           |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewWithUnionAll.json                           | Table | $..OracleViewWithUnionAll                           |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromMultipleTableUsingInnerJoin.json        | Table | $..OracleViewFromMultipleTableUsingInnerJoin        |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromMultipleTableUsingLeftOuterJoin.json    | Table | $..OracleViewFromMultipleTableUsingLeftOuterJoin    |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromMultipleTableUsingRightOuterJoin.json   | Table | $..OracleViewFromMultipleTableUsingRightOuterJoin   |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromMultipleTableUsingFullOuterJoin.json    | Table | $..OracleViewFromMultipleTableUsingFullOuterJoin    |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromMultipleTableUsingCrossJoin.json        | Table | $..OracleViewFromMultipleTableUsingCrossJoin        |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewNaturaljoin.json                            | Table | $..OracleViewNaturaljoin                            |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewSubqueryUsingWhere.json                     | Table | $..OracleViewSubqueryUsingWhere                     |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromComplexStatement.json                   | Table | $..OracleViewFromComplexStatement                   |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewSubqueryUsingWhereExist.json                | Table | $..OracleViewSubqueryUsingWhereExist                |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OraclecityviewOrderBy.json                            | Table | $..OraclecityviewOrderBy                            |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/sales_mv.json                                         | Table | $..sales_mv                                         |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleObjectView.json                                 | Table | $..OracleObjectView                                 |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromRangePartionedTable.json                | Table | $..OracleViewFromRangePartionedTable                |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromListPartionedTable.json                 | Table | $..OracleViewFromListPartionedTable                 |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromHashPartionedTable.json                 | Table | $..OracleViewFromHashPartionedTable                 |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewfromIndexOrganizedTables.json               | Table | $..OracleViewfromIndexOrganizedTables               |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewfromMultipleTableWithCondt.json             | Table | $..OracleViewfromMultipleTableWithCondt             |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewfromMultipleView.json                       | Table | $..OracleViewfromMultipleView                       |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewToMultipleTableWithJoinDiffSchema.json      | Table | $..OracleViewToMultipleTableWithJoinDiffSchema      |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OrcaViewFromDiffSchema.json                           | Table | $..OrcaViewFromDiffSchema                           |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OrcaViewFromDiffSchemaWithCondt.json                  | Table | $..OrcaViewFromDiffSchemaWithCondt                  |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewWithClause.json                             | Table | $..OracleViewWithClause                             |


     ##7126839## ##7126840## ##7126841## ##7126842## ##7126843## ##7126844## ##7126845## ##7126846## ##7126847## ##7126848## ##7126849## ##7126850## ##7126851## ##7126852## ##7126853## ##7126854## ##7126855## ##7126856## ##7126857## ##7126858## ##7126859## ##7126860## ##7126861## ##7126862## ##7126863## ##7126864## ##7126865## ##7126866## ##7126867## ##7126868## ##7126869##
  Scenario Outline:SC#4_3_user get the response of lineage edges and store the lineage values in file
    Given user hits "<request>" with "<url>" "<body>" for id from "<file>" "<type>" using "<path>" and verify "<statusCode>" and store response of "<jsonPath>" in "<targetFile>" for "<name>"
    Examples:
      | request | url                                                                   | body                                                                                                   | file                                                                  | type | path                                                | statusCode | jsonPath   | targetFile                                                                                                    | name                                             |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog,&exclude=MULTIHOP | Constant.REST_DIR/response/Oracle19cRDS/payloads/OCPPT2T1.json                                         | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OCPPT2T1                                         | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPT2T1.json                                         | OCPPT2T1                                         |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OCPPV2T.json                                          | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OCPPV2T                                          | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPV2T.json                                          | OCPPV2T                                          |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OCPPVIEW.json                                         | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OCPPVIEW                                         | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPVIEW.json                                         | OCPPVIEW                                         |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OCPPFT2T2.json                                        | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OCPPFT2T2                                        | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPFT2T2.json                                        | OCPPFT2T2                                        |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OCPPDSV2T.json                                        | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OCPPDSV2T                                        | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPDSV2T.json                                        | OCPPDSV2T                                        |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OCPPDSVT.json                                         | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OCPPDSVT                                         | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPDSVT.json                                         | OCPPDSVT                                         |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/TRIGGERTEST.json                                      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..TRIGGERTEST                                      | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/TRIGGERTEST.json                                      | TRIGGERTEST                                      |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/ViewToMultipleTableGroupbyHaving.json                 | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..ViewToMultipleTableGroupbyHaving                 | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/ViewToMultipleTableGroupbyHaving.json                 | ViewToMultipleTableGroupbyHaving                 |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog,&exclude=MULTIHOP | Constant.REST_DIR/response/Oracle19cRDS/payloads/Oracleviewtosingletable.json                          | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..Oracleviewtosingletable                          | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/Oracleviewtosingletable.json                          | Oracleviewtosingletable                          |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/Oracleviewtomultipletable.json                        | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..Oracleviewtomultipletable                        | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/Oracleviewtomultipletable.json                        | Oracleviewtomultipletable                        |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OraclemultipletableForceView.json                     | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OraclemultipletableForceView                     | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OraclemultipletableForceView.json                     | OraclemultipletableForceView                     |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleSingleViewtoView.json                           | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleSingleViewtoView                           | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleSingleViewtoView.json                           | OracleSingleViewtoView                           |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewfromViewToViewViewToTable.json              | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewfromViewToViewViewToTable              | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewfromViewToViewViewToTable.json              | OracleViewfromViewToViewViewToTable              |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewToMultipleTableWithJoin.json                | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewToMultipleTableWithJoin                | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewToMultipleTableWithJoin.json                | OracleViewToMultipleTableWithJoin                |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewToMultipleTableWithJoinhavingCondition.json | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewToMultipleTableWithJoinhavingCondition | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewToMultipleTableWithJoinhavingCondition.json | OracleViewToMultipleTableWithJoinhavingCondition |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewToMultipleTableGroupbyHaving.json           | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewToMultipleTableGroupbyHaving           | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewToMultipleTableGroupbyHaving.json           | OracleViewToMultipleTableGroupbyHaving           |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog,&exclude=MULTIHOP | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewWithUnionAll.json                           | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewWithUnionAll                           | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewWithUnionAll.json                           | OracleViewWithUnionAll                           |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromMultipleTableUsingInnerJoin.json        | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewFromMultipleTableUsingInnerJoin        | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingInnerJoin.json        | OracleViewFromMultipleTableUsingInnerJoin        |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromMultipleTableUsingLeftOuterJoin.json    | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewFromMultipleTableUsingLeftOuterJoin    | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingLeftOuterJoin.json    | OracleViewFromMultipleTableUsingLeftOuterJoin    |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromMultipleTableUsingRightOuterJoin.json   | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewFromMultipleTableUsingRightOuterJoin   | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingRightOuterJoin.json   | OracleViewFromMultipleTableUsingRightOuterJoin   |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromMultipleTableUsingFullOuterJoin.json    | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewFromMultipleTableUsingFullOuterJoin    | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingFullOuterJoin.json    | OracleViewFromMultipleTableUsingFullOuterJoin    |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromMultipleTableUsingCrossJoin.json        | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewFromMultipleTableUsingCrossJoin        | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingCrossJoin.json        | OracleViewFromMultipleTableUsingCrossJoin        |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewNaturaljoin.json                            | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewNaturaljoin                            | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewNaturaljoin.json                            | OracleViewNaturaljoin                            |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewSubqueryUsingWhere.json                     | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewSubqueryUsingWhere                     | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewSubqueryUsingWhere.json                     | OracleViewSubqueryUsingWhere                     |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog,&exclude=MULTIHOP | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromComplexStatement.json                   | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewFromComplexStatement                   | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromComplexStatement.json                   | OracleViewFromComplexStatement                   |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewSubqueryUsingWhereExist.json                | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewSubqueryUsingWhereExist                | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewSubqueryUsingWhereExist.json                | OracleViewSubqueryUsingWhereExist                |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OraclecityviewOrderBy.json                            | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OraclecityviewOrderBy                            | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OraclecityviewOrderBy.json                            | OraclecityviewOrderBy                            |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/sales_mv.json                                         | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..sales_mv                                         | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/sales_mv.json                                         | sales_mv                                         |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleObjectView.json                                 | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleObjectView                                 | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleObjectView.json                                 | OracleObjectView                                 |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromRangePartionedTable.json                | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewFromRangePartionedTable                | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromRangePartionedTable.json                | OracleViewFromRangePartionedTable                |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromListPartionedTable.json                 | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewFromListPartionedTable                 | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromListPartionedTable.json                 | OracleViewFromListPartionedTable                 |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewFromHashPartionedTable.json                 | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewFromHashPartionedTable                 | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromHashPartionedTable.json                 | OracleViewFromHashPartionedTable                 |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog,&exclude=MULTIHOP | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewfromIndexOrganizedTables.json               | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewfromIndexOrganizedTables               | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewfromIndexOrganizedTables.json               | OracleViewfromIndexOrganizedTables               |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewfromMultipleTableWithCondt.json             | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewfromMultipleTableWithCondt             | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewfromMultipleTableWithCondt.json             | OracleViewfromMultipleTableWithCondt             |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewfromMultipleView.json                       | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewfromMultipleView                       | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewfromMultipleView.json                       | OracleViewfromMultipleView                       |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewToMultipleTableWithJoinDiffSchema.json      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewToMultipleTableWithJoinDiffSchema      | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewToMultipleTableWithJoinDiffSchema.json      | OracleViewToMultipleTableWithJoinDiffSchema      |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OrcaViewFromDiffSchema.json                           | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OrcaViewFromDiffSchema                           | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OrcaViewFromDiffSchema.json                           | OrcaViewFromDiffSchema                           |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OrcaViewFromDiffSchemaWithCondt.json                  | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OrcaViewFromDiffSchemaWithCondt                  | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OrcaViewFromDiffSchemaWithCondt.json                  | OrcaViewFromDiffSchemaWithCondt                  |
      | Post    | lineages/Default?dir=BOTH&what=id,type,name,catalog&exclude=MULTIHOP  | Constant.REST_DIR/response/Oracle19cRDS/payloads/OracleViewWithClause.json                             | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/tableIDs.json | List | $..OracleViewWithClause                             | 200        | $..edges.* | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewWithClause.json                             | OracleViewWithClause                             |


     ##7126839## ##7126840## ##7126841## ##7126842## ##7126843## ##7126844## ##7126845## ##7126846## ##7126847## ##7126848## ##7126849## ##7126850## ##7126851## ##7126852## ##7126853## ##7126854## ##7126855## ##7126856## ##7126857## ##7126858## ##7126859## ##7126860## ##7126861## ##7126862## ##7126863## ##7126864## ##7126865## ##7126866## ##7126867## ##7126868## ##7126869##
  Scenario Outline:SC#4_4_user retrieve the name of id for each value stored in lineage data file
    Given user gets the name for each id stored in "<LineageFile>" under "<TableName>" and replace the id with name
    Examples:
      | LineageFile                                                                                                   | TableName                                        |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPT2T1.json                                         | OCPPT2T1                                         |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPV2T.json                                          | OCPPV2T                                          |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPVIEW.json                                         | OCPPVIEW                                         |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPFT2T2.json                                        | OCPPFT2T2                                        |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPDSV2T.json                                        | OCPPDSV2T                                        |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPDSVT.json                                         | OCPPDSVT                                         |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/TRIGGERTEST.json                                      | TRIGGERTEST                                      |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/ViewToMultipleTableGroupbyHaving.json                 | ViewToMultipleTableGroupbyHaving                 |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/Oracleviewtosingletable.json                          | Oracleviewtosingletable                          |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/Oracleviewtomultipletable.json                        | Oracleviewtomultipletable                        |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OraclemultipletableForceView.json                     | OraclemultipletableForceView                     |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleSingleViewtoView.json                           | OracleSingleViewtoView                           |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewfromViewToViewViewToTable.json              | OracleViewfromViewToViewViewToTable              |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewToMultipleTableWithJoin.json                | OracleViewToMultipleTableWithJoin                |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewToMultipleTableWithJoinhavingCondition.json | OracleViewToMultipleTableWithJoinhavingCondition |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewToMultipleTableGroupbyHaving.json           | OracleViewToMultipleTableGroupbyHaving           |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewWithUnionAll.json                           | OracleViewWithUnionAll                           |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingInnerJoin.json        | OracleViewFromMultipleTableUsingInnerJoin        |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingLeftOuterJoin.json    | OracleViewFromMultipleTableUsingLeftOuterJoin    |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingRightOuterJoin.json   | OracleViewFromMultipleTableUsingRightOuterJoin   |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingFullOuterJoin.json    | OracleViewFromMultipleTableUsingFullOuterJoin    |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingCrossJoin.json        | OracleViewFromMultipleTableUsingCrossJoin        |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewNaturaljoin.json                            | OracleViewNaturaljoin                            |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewSubqueryUsingWhere.json                     | OracleViewSubqueryUsingWhere                     |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromComplexStatement.json                   | OracleViewFromComplexStatement                   |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewSubqueryUsingWhereExist.json                | OracleViewSubqueryUsingWhereExist                |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OraclecityviewOrderBy.json                            | OraclecityviewOrderBy                            |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/sales_mv.json                                         | sales_mv                                         |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleObjectView.json                                 | OracleObjectView                                 |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromRangePartionedTable.json                | OracleViewFromRangePartionedTable                |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromListPartionedTable.json                 | OracleViewFromListPartionedTable                 |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromHashPartionedTable.json                 | OracleViewFromHashPartionedTable                 |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewfromIndexOrganizedTables.json               | OracleViewfromIndexOrganizedTables               |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewfromMultipleTableWithCondt.json             | OracleViewfromMultipleTableWithCondt             |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewfromMultipleView.json                       | OracleViewfromMultipleView                       |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewToMultipleTableWithJoinDiffSchema.json      | OracleViewToMultipleTableWithJoinDiffSchema      |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OrcaViewFromDiffSchema.json                           | OrcaViewFromDiffSchema                           |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OrcaViewFromDiffSchemaWithCondt.json                  | OrcaViewFromDiffSchemaWithCondt                  |
      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewWithClause.json                             | OracleViewWithClause                             |


     ##7126839## ##7126840## ##7126841## ##7126842## ##7126843## ##7126844## ##7126845## ##7126846## ##7126847## ##7126848## ##7126849## ##7126850## ##7126851## ##7126852## ##7126853## ##7126854## ##7126855## ##7126856## ##7126857## ##7126858## ##7126859## ##7126860## ##7126861## ##7126862## ##7126863## ##7126864## ##7126865## ##7126866## ##7126867## ##7126868## ##7126869##
  Scenario Outline:SC#4_5_user compares the expected lineage data and actual lineage data
    Given user json assert between "<expectedJson>" data and "<actualJson>" data
    Examples:
      | expectedJson                                                                                                    | actualJson                                                                                                    |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OCPPT2T1.json                                         | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPT2T1.json                                         |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OCPPV2T.json                                          | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPV2T.json                                          |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OCPPVIEW.json                                         | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPVIEW.json                                         |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OCPPFT2T2.json                                        | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPFT2T2.json                                        |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OCPPDSV2T.json                                        | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPDSV2T.json                                        |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OCPPDSVT.json                                         | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OCPPDSVT.json                                         |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/TRIGGERTEST.json                                      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/TRIGGERTEST.json                                      |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/ViewToMultipleTableGroupbyHaving.json                 | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/ViewToMultipleTableGroupbyHaving.json                 |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/Oracleviewtosingletable.json                          | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/Oracleviewtosingletable.json                          |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/Oracleviewtomultipletable.json                        | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/Oracleviewtomultipletable.json                        |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OraclemultipletableForceView.json                     | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OraclemultipletableForceView.json                     |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleSingleViewtoView.json                           | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleSingleViewtoView.json                           |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewfromViewToViewViewToTable.json              | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewfromViewToViewViewToTable.json              |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewToMultipleTableWithJoin.json                | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewToMultipleTableWithJoin.json                |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewToMultipleTableWithJoinhavingCondition.json | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewToMultipleTableWithJoinhavingCondition.json |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewToMultipleTableGroupbyHaving.json           | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewToMultipleTableGroupbyHaving.json           |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewWithUnionAll.json                           | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewWithUnionAll.json                           |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewFromMultipleTableUsingInnerJoin.json        | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingInnerJoin.json        |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewFromMultipleTableUsingLeftOuterJoin.json    | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingLeftOuterJoin.json    |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewFromMultipleTableUsingRightOuterJoin.json   | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingRightOuterJoin.json   |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewFromMultipleTableUsingFullOuterJoin.json    | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingFullOuterJoin.json    |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewFromMultipleTableUsingCrossJoin.json        | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromMultipleTableUsingCrossJoin.json        |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewNaturaljoin.json                            | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewNaturaljoin.json                            |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewSubqueryUsingWhere.json                     | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewSubqueryUsingWhere.json                     |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewFromComplexStatement.json                   | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromComplexStatement.json                   |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewSubqueryUsingWhereExist.json                | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewSubqueryUsingWhereExist.json                |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OraclecityviewOrderBy.json                            | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OraclecityviewOrderBy.json                            |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/sales_mv.json                                         | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/sales_mv.json                                         |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleObjectView.json                                 | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleObjectView.json                                 |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewFromRangePartionedTable.json                | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromRangePartionedTable.json                |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewFromListPartionedTable.json                 | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromListPartionedTable.json                 |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewFromHashPartionedTable.json                 | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewFromHashPartionedTable.json                 |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewfromIndexOrganizedTables.json               | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewfromIndexOrganizedTables.json               |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewfromMultipleTableWithCondt.json             | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewfromMultipleTableWithCondt.json             |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewfromMultipleView.json                       | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewfromMultipleView.json                       |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewToMultipleTableWithJoinDiffSchema.json      | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewToMultipleTableWithJoinDiffSchema.json      |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OrcaViewFromDiffSchema.json                           | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OrcaViewFromDiffSchema.json                           |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OrcaViewFromDiffSchemaWithCondt.json                  | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OrcaViewFromDiffSchemaWithCondt.json                  |
      | Constant.REST_DIR/response/Oracle19cRDS/expectedJsonFiles/OracleViewWithClause.json                             | Constant.REST_DIR/response/Oracle19cRDS/actualJsonFiles/OracleViewWithClause.json                             |


   ##6767934##
  @webtest @MLP-9604
  Scenario:SC#5_1_Verify OraclePostProcessor generates lineage for Table to Table(through procedure)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PROT2T" and clicks on search
    Then the following tags "Oracle,Orc19cRDSCataloger,Oracle19C_RDS_PP" should get displayed for the column "lineage/Oracle19cRDS_PostProcessor"
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PROT2T" item from search results
    Then user performs click and verify in new window
      | Table          | value       | Action                 | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | dependencies   | OCPPT2T1    | verify widget contains | No               |             |          |          |                 |
      | dependencies   | OCPPT2T2    | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT AGE  | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT ID   | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT NAME | verify widget contains | No               |             |          |          |                 |
      | SQLSource      | SQLSource   | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT AGE  | click and switch tab   | No               |             |          |          |                 |
      | Lineage Source | AGE         | verify widget contains | No               |             |          |          |                 |
      | Lineage Target | AGE         | verify widget contains | No               |             |          |          |                 |
      | lineageSource  | SQLSource   | verify widget contains | No               |             |          |          |                 |
      | lineageSource  | SQLSource   | click and switch tab   | No               |             |          |          |                 |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                                                                                  | widgetName  |
      | source            | CREATE PROCEDURE PROT2T as begin insert into ORACLE12C_SCHEMA1.OCPPT2T2 (ID,NAME,AGE) select ID,NAME,AGE from ORACLE12C_SCHEMA1.OCPPT2T1; END; | Description |


  ##6767935##
  @webtest @MLP-9604
  Scenario:SC#5_2_Verify OraclePostProcessor generates lineage for View to Table(through procedure)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PROV2T" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PROV2T" item from search results
    Then user performs click and verify in new window
      | Table          | value             | Action                 | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | dependencies   | OCPPV2T           | verify widget contains | No               |             |          |          |                 |
      | dependencies   | OCPPVIEW          | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT GRADE      | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT ROLLNO     | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT NAME       | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT SCHOOLNAME | verify widget contains | No               |             |          |          |                 |
      | SQLSource      | SQLSource         | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT ROLLNO     | click and switch tab   | No               |             |          |          |                 |
      | Lineage Source | ROLLNO            | verify widget contains | No               |             |          |          |                 |
      | Lineage Target | ROLLNO            | verify widget contains | No               |             |          |          |                 |
      | lineageSource  | SQLSource         | verify widget contains | No               |             |          |          |                 |
      | lineageSource  | SQLSource         | click and switch tab   | No               |             |          |          |                 |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                                                                                                                   | widgetName  |
      | source            | CREATE PROCEDURE PROV2T as begin insert into ORACLE12C_SCHEMA1.OCPPV2T (rollno,name,grade,schoolname) select rollno,name,grade,schoolname from ORACLE12C_SCHEMA1.OCPPVIEW; END; | Description |


  ##6767936##
  @webtest @MLP-9604
  Scenario:SC#5_3_Verify OraclePostProcessor generates lineage for Table to Table(through function)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "OCPPTESTFUNCTION" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "OCPPTESTFUNCTION" item from search results
    Then user performs click and verify in new window
      | Table          | value            | Action                 | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | dependencies   | OCPPFT2T1        | verify widget contains | No               |             |          |          |                 |
      | dependencies   | OCPPFT2T1        | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT AGE       | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT CITY      | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT FIRSTNAME | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT ZIPCODE   | verify widget contains | No               |             |          |          |                 |
      | SQLSource      | SQLSource        | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT CITY      | click and switch tab   | No               |             |          |          |                 |
      | Lineage Source | CITY             | verify widget contains | No               |             |          |          |                 |
      | Lineage Target | CITY             | verify widget contains | No               |             |          |          |                 |
      | lineageSource  | SQLSource        | verify widget contains | No               |             |          |          |                 |
      | lineageSource  | SQLSource        | click and switch tab   | No               |             |          |          |                 |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                                                                                                                                                                                                                                                                           | widgetName  |
      | source            | CREATE FUNCTION OCPPTESTFUNCTION(in_person_id IN NUMBER) RETURN NUMBER IS person_details NUMBER; BEGIN INSERT INTO ORACLE12C_SCHEMA1.OCPPFT2T2 (PEOPLEID,FIRSTNAME, LASTNAME, AGE, CITY,ZIPCODE) SELECT PEOPLEID,FIRSTNAME, LASTNAME, AGE, CITY,ZIPCODE from ORACLE12C_SCHEMA1.OCPPFT2T1; RETURN(person_details); END OCPPTESTFUNCTION; | Description |


  ##6767938##
  @webtest @MLP-9604
  Scenario:SC#5_4_Verify OraclePostProcessor generates lineage for View to Table(through procedure having dynamic sql)
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "PRODSV2T" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PRODSV2T" item from search results
    Then user performs click and verify in new window
      | Table          | value             | Action                 | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | dependencies   | OCPPDSV2T         | verify widget contains | No               |             |          |          |                 |
      | dependencies   | OCPPDSVT          | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT GRADE      | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT ROLLNO     | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT NAME       | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT SCHOOLNAME | verify widget contains | No               |             |          |          |                 |
      | SQLSource      | SQLSource         | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT SCHOOLNAME | click and switch tab   | No               |             |          |          |                 |
      | Lineage Source | SCHOOLNAME        | verify widget contains | No               |             |          |          |                 |
      | Lineage Target | SCHOOLNAME        | verify widget contains | No               |             |          |          |                 |
    And user enters the search text "PRODSV2T" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "PRODSV2T" item from search results
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | SQLSource | SQLSource | click and switch tab | No               | 0           |          |          |                 |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                                                                                                                                                                                 | widgetName  |
      | source            | CREATE PROCEDURE PRODSV2T IS v_dynamicSql varchar(2000); BEGIN v_dynamicSql := 'insert into ORACLE12C_SCHEMA1.OCPPDSV2T (rollno,name,grade,schoolname)' \|\| 'select * from ORACLE12C_SCHEMA1.OCPPDSVT'; EXECUTE IMMEDIATE v_dynamicSql; END; | Description |


  @webtest @MLP-9604
  Scenario:SC#5_5_Verify OraclePostProcessor generates lineage for Triggers
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TRIGGER1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Trigger" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TRIGGER1" item from search results
    Then user performs click and verify in new window
      | Table          | value                                                                                                      | Action                 | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | dependencies   | TRIGGERTEST                                                                                                | verify widget contains | No               |             |          |          |                 |
      | dependencies   | TRIGGERTEST1                                                                                               | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT ID                                                                                                  | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT IDADDRESS                                                                                           | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT IDNAME                                                                                              | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | TRIGGER-"idadb.cshey0cobobn.us-east-1.rds.amazonaws.com"."ORACLE:1521".IDADB.ORACLE12C_SCHEMA1.TRIGGERTEST | verify widget contains | No               |             |          |          |                 |
      | SQLSource      | SQLSource                                                                                                  | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | INSERT ID                                                                                                  | click and switch tab   | No               |             |          |          |                 |
      | Lineage Source | ID                                                                                                         | verify widget contains | No               |             |          |          |                 |
      | Lineage Target | ID                                                                                                         | verify widget contains | No               |             |          |          |                 |
    And user enters the search text "TRIGGER1" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Trigger" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TRIGGER1" item from search results
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | SQLSource | SQLSource | click and switch tab | No               | 0           |          |          |                 |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                                                                                                                                          | widgetName  |
      | source            | CREATE TRIGGER ORACLE12C_SCHEMA1.TRIGGER1 AFTER insert on ORACLE12C_SCHEMA1.TRIGGERTEST for each row begin insert into ORACLE12C_SCHEMA1.TRIGGERTEST1 values(:new.ID,:new.IDNAME,:new.IDADDRESS); end; | Description |


  @webtest @MLP-9604
  Scenario: SC#5_6_Verify OraclePostProcessor generates lineage for MultipleHops
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ViewToMultipleTableGroupbyHaving" and clicks on search
    And user performs "definite facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ViewToMultipleTableGroupbyHaving" item from search results
    Then user performs click and verify in new window
      | Table          | value                                                                                                                                      | Action                 | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | dependencies   | Patient                                                                                                                                    | verify widget contains | No               |             |          |          |                 |
      | dependencies   | PatientBilling                                                                                                                             | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | "idadb.cshey0cobobn.us-east-1.rds.amazonaws.com"."ORACLE:1521".IDADB.ORACLE12C_SCHEMA1."ViewToMultipleTableGroupbyHaving".HOSPITALID (U/D) | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | "idadb.cshey0cobobn.us-east-1.rds.amazonaws.com"."ORACLE:1521".IDADB.ORACLE12C_SCHEMA1."ViewToMultipleTableGroupbyHaving".PATIENT_ID (U/D) | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | Column-Lookup                                                                                                                              | verify widget contains | No               |             |          |          |                 |
      | SQLSource      | SQLSource                                                                                                                                  | verify widget contains | No               |             |          |          |                 |
      | Lineage Hops   | Column-Lookup                                                                                                                              | click and switch tab   | No               |             |          |          |                 |
      | Lineage Source | HOSPITALID                                                                                                                                 | verify widget contains | No               |             |          |          |                 |
      | Lineage Target | HOSPITALID                                                                                                                                 | verify widget contains | No               |             |          |          |                 |
    And user enters the search text "ViewToMultipleTableGroupbyHaving" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "definite facet selection" in "ORACLE12C_SCHEMA1 [Schema]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "ViewToMultipleTableGroupbyHaving" item from search results
    Then user performs click and verify in new window
      | Table     | value     | Action               | RetainPrevwindow | indexSwitch | filePath | jsonPath | metadataSection |
      | SQLSource | SQLSource | click and switch tab | No               | 0           |          |          |                 |
    Then the following metadata values should be displayed
      | metaDataAttribute | metaDataValue                                                                                                                                                                                                                                                                                                                                                                                         | widgetName  |
      | source            | CREATE VIEW ORACLE12C_SCHEMA1."ViewToMultipleTableGroupbyHaving" ( HOSPITALID, PATIENT_ID ) AS select h1.HospitalId,p1.Patient_Id from "ORACLE12C_SCHEMA1"."Hospital" h1 join "ORACLE12C_SCHEMA1"."Patient" p1 on h1.HospitalId=p1.HospitalId join "ORACLE12C_SCHEMA1"."PatientBilling" b1 on p1.Patient_Id=b1.Patient_Id group by h1.HospitalId,p1.Patient_Id,b1.Patient_Id having p1.Patient_Id=200 | Description |


  @sanity @positive @regression
  Scenario:SC#5_7_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                         | type     | query | param |
      | SingleItemDelete | Default | idadb.cshey0cobobn.us-east-1.rds.amazonaws.com               | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaFilter% | Analysis |       |       |
      | SingleItemDelete | Default | lineage/OracleDBPostProcessor/Oracle19cRDS_PostProcessor%    | Analysis |       |       |



     ############################################Dry Run for Oracle 19cCDB Postprocessor######################################


  ##Bug Id- MLP-24577##
  @webtest
  Scenario:SC#6_1_Verify the Dry run feature for the OracleDB PostProcessor
    Given user "update" the json file "ida/jdbcAnalyzerPayloads/oracle19cPostProcessorPayloads/Oracle19cRDS_PostProcessorDryRun.json" file for following values
      | jsonPath  | jsonValues | type    |
      | $..dryRun | true       | boolean |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                      | body                                                                                                | response code | response message | jsonPath                                                                    |
      | application/json | raw   | false | Put          | settings/analyzers/OracleDBDataSource                                    | ida/jdbcAnalyzerPayloads/oracle19cPostProcessorPayloads/OracleDataSource_19cRDS.json                | 204           |                  |                                                                             |
      |                  |       |       | Get          | settings/analyzers/OracleDBDataSource                                    |                                                                                                     | 200           |                  | Oracle19cRDSDSLineage                                                       |
      |                  |       |       | Put          | settings/analyzers/OracleDBCataloger                                     | ida/jdbcAnalyzerPayloads/oracle19cPostProcessorPayloads/OracleCatalogerWithSchemaFilter_19cRDS.json | 204           |                  |                                                                             |
      |                  |       |       | Get          | settings/analyzers/OracleDBCataloger                                     |                                                                                                     | 200           |                  | OracleCatalogerWithSchemaFilter_19cRDS                                      |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*      |                                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter_19cRDS')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*       | ida/jdbcAnalyzerPayloads/oracle19cPostProcessorPayloads/empty.json                                  | 200           |                  |                                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*      |                                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='OracleCatalogerWithSchemaFilter_19cRDS')].status |
      |                  |       |       | Put          | settings/analyzers/OracleDBPostProcessor                                 | ida/jdbcAnalyzerPayloads/oracle19cPostProcessorPayloads/Oracle19cRDS_PostProcessorDryRun.json       | 204           |                  |                                                                             |
      |                  |       |       | Get          | settings/analyzers/OracleDBPostProcessor                                 |                                                                                                     | 200           |                  | Oracle19cRDS_PostProcessorDryRun                                            |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/lineage/OracleDBPostProcessor/* |                                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='Oracle19cRDS_PostProcessorDryRun')].status       |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/lineage/OracleDBPostProcessor/*  | ida/jdbcAnalyzerPayloads/oracle19cPostProcessorPayloads/empty.json                                  | 200           |                  |                                                                             |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/lineage/OracleDBPostProcessor/* |                                                                                                     | 200           | IDLE             | $.[?(@.configurationName=='Oracle19cRDS_PostProcessorDryRun')].status       |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "OracleDBPostProcessor" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "lineage/OracleDBPostProcessor/Oracle19cRDS_PostProcessorDryRun%"
    Then the following metadata values should be displayed
      | metaDataAttribute         | metaDataValue | widgetName  |
      | Number of processed items | 0             | Description |
      | Number of errors          | 0             | Description |
    And user "widget not present" on "Processed Items" in Item view page
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    Then Analysis log "lineage/OracleDBPostProcessor/Oracle19cRDS_PostProcessorDryRun%" should display below info/error/warning
      | type | logValue                                                                                         | logCode       | pluginName            | removableText |
      | INFO | Plugin OracleDBPostProcessor running on dry run mode                                             | ANALYSIS-0069 | OracleDBPostProcessor |               |
      | INFO | Plugin OracleDBPostProcessor processed 0 items on dry run mode and not written to the repository | ANALYSIS-0070 | OracleDBPostProcessor |               |
      | INFO | Plugin completed                                                                                 | ANALYSIS-0020 |                       |               |


  Scenario:SC#6_2_Delete Cluster and all the Analysis log for Oracle
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                           | type                | query | param |
      | SingleItemDelete | Default | idadb.cshey0cobobn.us-east-1.rds.amazonaws.com | Cluster             |       |       |
      | MultipleIDDelete | Default | cataloger/OracleDBCataloger/%                  | Analysis            |       |       |
      | MultipleIDDelete | Default | lineage/OracleDBPostProcessor/%                | Analysis            |       |       |
      | SingleItemDelete | Default | Oracle19C_RDS_PP                               | BusinessApplication |       |       |


  Scenario Outline:SC#7_Delete the credentials for Oracle19cRDS
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                          | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/Oracle19cRDSLineageCred |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBPostProcessor     |      | 204           |                  |          |