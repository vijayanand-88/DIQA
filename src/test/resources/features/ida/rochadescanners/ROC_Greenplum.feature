@MLPQA-20346
@REQ_MLP-30513
Feature: DI DD 2021 Headless Rochade - Greenplum Wrapper Validation
#Stories: @MLP-34165

  @pre-condition @ROC_Greenplum
  Scenario: Pre: Clearing the EDI subject area before running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


  @ROC_Greenplum
  Scenario:PreCondition#Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                               | jsonPath                                            | node            |
      | ida/ROCGreenplumPayloads/RocGreenplumPluginConfig.json | $.GreenplumScan.configurations.nodeCondition        | HeadlessEDINode |
      | ida/ROCGreenplumPayloads/RocGreenplumPluginConfig.json | $.GreenplumImport.configurations.nodeCondition      | HeadlessEDINode |
      | ida/ROCGreenplumPayloads/RocGreenplumPluginConfig.json | $.GreenplumPostprocess.configurations.nodeCondition | HeadlessEDINode |
      | ida/ROCGreenplumPayloads/RocGreenplumPluginConfig.json | $.GreenplumReconcile.configurations.nodeCondition   | HeadlessEDINode |


  @pre-condition @ROC_Greenplum
  Scenario Outline: Configure Credentials, Data Source for Greenplum wrapper and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                  | bodyFile                                                       | path                       | response code | response message         | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeGreenplumCredentials                     | payloads/ida/ROCGreenplumPayloads/RocGreenplumCredentials.json | $.GreenplumCredentials     | 200           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeGreenplumCredentials                     |                                                                |                            | 200           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeGreenplumSACredentials                   | payloads/ida/ROCGreenplumPayloads/RocGreenplumCredentials.json | $.EDICredentials           | 200           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeGreenplumSACredentials                   |                                                                |                            | 200           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCGreenplumSADataSource/ROCGreenplumSADataSource | payloads/ida/ROCGreenplumPayloads/RocGreenplumDataSource.json  | $.RocGreenplumSADataSource | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCGreenplumSADataSource/ROCGreenplumSADataSource |                                                                |                            | 200           | ROCGreenplumSADataSource |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCGreenplumDataSource/ROCGreenplumDataSource     | payloads/ida/ROCGreenplumPayloads/RocGreenplumDataSource.json  | $.RocGreenplumDataSource   | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCGreenplumDataSource/ROCGreenplumDataSource     |                                                                |                            | 200           | ROCGreenplumDataSource   |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource/EDIBusGreenplumDS                | payloads/ida/ROCGreenplumPayloads/RocGreenplumDataSource.json  | $.EDIBusDataSource         | 204           |                          |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource/EDIBusGreenplumDS                |                                                                |                            | 200           | EDIBusGreenplumDS        |          |


  @pre-condition @ROC_Greenplum
  Scenario Outline: Configure plugins: GreenplumScan, GreenplumImport, GreenplumPostprocess, GreenplumReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                                 | bodyFile                                                        | path                                  | response code | response message            | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GreenplumScan/RochadeGreenplumScan               | payloads/ida/ROCGreenplumPayloads/RocGreenplumPluginConfig.json | $.GreenplumScan.configurations        | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/GreenplumScan/RochadeGreenplumScan               |                                                                 |                                       | 200           | RochadeGreenplumScan        |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GreenplumImport/RochadeGreenplumImport           | payloads/ida/ROCGreenplumPayloads/RocGreenplumPluginConfig.json | $.GreenplumImport.configurations      | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/GreenplumImport/RochadeGreenplumImport           |                                                                 |                                       | 200           | RochadeGreenplumImport      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GreenplumPostprocess/RochadeGreenplumPostprocess | payloads/ida/ROCGreenplumPayloads/RocGreenplumPluginConfig.json | $.GreenplumPostprocess.configurations | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/GreenplumPostprocess/RochadeGreenplumPostprocess |                                                                 |                                       | 200           | RochadeGreenplumPostprocess |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/GreenplumReconcile/RochadeGreenplumReconcile     | payloads/ida/ROCGreenplumPayloads/RocGreenplumPluginConfig.json | $.GreenplumReconcile.configurations   | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/GreenplumReconcile/RochadeGreenplumReconcile     |                                                                 |                                       | 200           | RochadeGreenplumReconcile   |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/EDIBus_Greenplum                          | payloads/ida/ROCGreenplumPayloads/RocGreenplumPluginConfig.json | $.EDIBus.configurations               | 204           |                             |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/EDIBus_Greenplum                          |                                                                 |                                       | 200           | EDIBus_Greenplum            |          |

#
#  #################################################### Plugin Run #####################################################
  @ROC_Greenplum
  Scenario Outline: Run GreenplumImport, GreenplumPostprocess, GreenplumReconcile, EDIBus Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And user waits for the final status to be reflected after "10000" milliseconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                              | bodyFile | path | response code | response message | jsonPath                                                         |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/GreenplumScan/RochadeGreenplumScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeGreenplumScan')].status        |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/GreenplumScan/RochadeGreenplumScan                |          |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/GreenplumScan/RochadeGreenplumScan               |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeGreenplumScan')].status        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/GreenplumImport/RochadeGreenplumImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeGreenplumImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/GreenplumImport/RochadeGreenplumImport            |          |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/GreenplumImport/RochadeGreenplumImport           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeGreenplumImport')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/GreenplumPostprocess/RochadeGreenplumPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeGreenplumPostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/GreenplumPostprocess/RochadeGreenplumPostprocess  |          |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/GreenplumPostprocess/RochadeGreenplumPostprocess |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeGreenplumPostprocess')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/GreenplumReconcile/RochadeGreenplumReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeGreenplumReconcile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/GreenplumReconcile/RochadeGreenplumReconcile      |          |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/GreenplumReconcile/RochadeGreenplumReconcile     |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeGreenplumReconcile')].status   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Greenplum                            |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Greenplum')].status            |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_Greenplum                             |          |      | 200           |                  |                                                                  |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Greenplum                            |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Greenplum')].status            |


  ##################################################### Verifications #####################################################
  @ROC_Greenplum @TEST_MLPQA-20335 @REQ_MLP-34165 @MLPQA-20287
  Scenario: Verify the Logging Enhancements - Analysis logs for GreenplumScan, GreenplumImport, GreenplumLink, GreenplumReconcile
    Given Analysis log "rochade/GreenplumScan/RochadeGreenplumScan/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                      | logCode       | pluginName    | removableText  |
      | INFO | Plugin started                                                                                                                                                                                                | ANALYSIS-0019 |               |                |
      | INFO | ANALYSIS-0071: Plugin Name:GreenplumScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeGreenplumScan | ANALYSIS-0071 | GreenplumScan | Plugin Version |
      | INFO | ANALYSIS-0072: Plugin GreenplumScan Start Time:2021-03-03 11:29:24.328, End Time:2021-03-03 11:29:40.313, Errors:0, Warnings:0                                                                                | ANALYSIS-0072 | GreenplumScan |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                     | ANALYSIS-0020 |               |                |
    And Analysis log "rochade/GreenplumImport/RochadeGreenplumImport/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                           | logCode       | pluginName      | removableText  |
      | INFO | Plugin started                                                                                                                                                                                     | ANALYSIS-0019 |                 |                |
      | INFO | Plugin Name:GreenplumImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeGreenplumImport | ANALYSIS-0071 | GreenplumImport | Plugin Version |
      | INFO | Plugin GreenplumImport Start Time:2021-02-11 09:05:08.993, End Time:2021-02-11 09:05:15.642, Errors:0, Warnings:0                                                                                  | ANALYSIS-0072 | GreenplumImport |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                          | ANALYSIS-0020 |                 |                |
    And Analysis log "rochade/GreenplumPostprocess/RochadeGreenplumPostprocess/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                     | logCode       | pluginName           | removableText  |
      | INFO | Plugin started                                                                                                                                                                                               | ANALYSIS-0019 |                      |                |
      | INFO | Plugin Name:GreenplumPostprocess, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeGreenplumPostprocess | ANALYSIS-0071 | GreenplumPostprocess | Plugin Version |
      | INFO | Plugin GreenplumPostprocess Start Time:2021-02-12 06:11:21.570, End Time:2021-02-12 06:11:24.724, Errors:0, Warnings:0                                                                                       | ANALYSIS-0072 | GreenplumPostprocess |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                    | ANALYSIS-0020 |                      |                |
    And Analysis log "rochade/GreenplumReconcile/RochadeGreenplumReconcile/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                                 | logCode       | pluginName         | removableText  |
      | INFO | Plugin started                                                                                                                                                                                           | ANALYSIS-0019 |                    |                |
      | INFO | Plugin Name:GreenplumReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeGreenplumReconcile | ANALYSIS-0071 | GreenplumReconcile | Plugin Version |
      | INFO | Plugin GreenplumReconcile Start Time:2021-02-12 06:11:41.919, End Time:2021-02-12 06:11:47.469, Errors:0, Warnings:0                                                                                     | ANALYSIS-0072 | GreenplumReconcile |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                                | ANALYSIS-0020 |                    |                |


  @webtest @ROC_Greenplum @TEST_MLPQA-20337 @REQ_MLP-34165 @MLPQA-20287
  Scenario: Verify the availability of HTML file under analysis items for plugins: GreenplumScan, GreenplumImport, GreenplumLink
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Greenplum" and clicks on search
    And user performs "facet selection" in "Greenplum" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,Greenplum" should get displayed for the column "rochade/GreenplumScan/RochadeGreenplumScan/%"
    And user performs "latest analysis click" in Item Results page for "rochade/GreenplumScan/RochadeGreenplumScan/%"
    Then user performs click and verify in new window
      | Table | value                      | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | ScanGreenplum-ScanLog.html | verify widget contains |                  |             |
    And user enters the search text "Greenplum" and clicks on search
    And user performs "facet selection" in "Greenplum" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,Greenplum" should get displayed for the column "rochade/GreenplumImport/RochadeGreenplumImport/%"
    And user performs "latest analysis click" in Item Results page for "rochade/GreenplumImport/RochadeGreenplumImport/%"
    Then user performs click and verify in new window
      | Table | value                        | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | ScanGreenplum-ImportLog.html | verify widget contains |                  |             |
    And user enters the search text "Greenplum" and clicks on search
    And user performs "facet selection" in "Greenplum" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,Greenplum" should get displayed for the column "rochade/GreenplumPostprocess/RochadeGreenplumPostprocess/%"
    And user performs "latest analysis click" in Item Results page for "rochade/GreenplumPostprocess/RochadeGreenplumPostprocess/%"
    Then user performs click and verify in new window
      | Table | value                      | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | ScanGreenplum-PostLog.html | verify widget contains |                  |             |
    And user enters the search text "Greenplum" and clicks on search
    And user performs "facet selection" in "Greenplum" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,Greenplum" should get displayed for the column "rochade/GreenplumReconcile/RochadeGreenplumReconcile/%"
    And user should be able logoff the IDC


  @ROC_Greenplum
  Scenario Outline:  user retrieves facets and respective counts of Greenplum wrapper items
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                         | response code | response message | filePath                                              | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | payloads/ida/ROCGreenplumPayloads/getFacetsCountRequest.json | 200           |                  | payloads/ida/ROCGreenplumPayloads/facetWiseCount.json |          |


  @ROC_Greenplum @TEST_MLPQA-20341 @REQ_MLP-34165 @MLPQA-20287
  Scenario: Verify Greenplum Rochade items are replicated to DD after running EDIBus plugin
    And user gets the items count from json
      | filePath                                                   | jsonPath                                           |
      | payloads/ida/ROCGreenplumPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Service')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_DB_SYSTEM ) |
    And user gets the items count from json
      | filePath                                                   | jsonPath                                            |
      | payloads/ida/ROCGreenplumPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Database')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_DATABASE ) |
    And user gets the items count from json
      | filePath                                                   | jsonPath                                          |
      | payloads/ida/ROCGreenplumPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Schema')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_SCHEMA ) |
    And user gets the items count from json
      | filePath                                                   | jsonPath                                         |
      | payloads/ida/ROCGreenplumPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Table')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
    And user gets the items count from json
      | filePath                                                   | jsonPath                                          |
      | payloads/ida/ROCGreenplumPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Column')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_COLUMN ) |
    And user gets the items count from json
      | filePath                                                   | jsonPath                                           |
      | payloads/ida/ROCGreenplumPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Routine')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                                  |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ) AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_FUNCTION OR TYPE = DWR_RDB_PROCEDURE ) |


  @webtest @ROC_Greenplum @TEST_MLPQA-20338 @REQ_MLP-34165 @MLPQA-20287
  Scenario: Verify the breadcrumb hierarchy appears correctly when GreenplumScan Rochade items are replicated to DD after running EDIBus plugin
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Greenplum" and clicks on search
    And user performs "facet selection" in "Greenplum" attribute under "Technology" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Column      |
      | Routine     |
      | Table       |
      | DataType    |
      | DataField   |
      | DataPackage |
      | Schema      |
      | Analysis    |
      | Database    |
      | Service     |
    And user enters the search text "comments" and clicks on search
    And user performs "facet selection" in "Greenplum" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "sql_sizing [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "comments" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | DIDGPDB01V.dev.asgint.loc≫DB |
      | tutorial                     |
      | information_schema           |
      | sql_sizing                   |
      | comments                     |
    And user should be able logoff the IDC


  @ROC_Greenplum @TEST_MLPQA-20340 @REQ_MLP-34165 @MLPQA-20287
  Scenario: Metadata verification for items collected after executing Greenplum plugins
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                       | jsonPath                | Action                    | query                       | ClusterName | ServiceName                  | DatabaseName | SchemaName | TableName/Filename     | columnName/FieldName | specialCharacters |
      | Description | ida/ROCGreenplumPayloads/expectedMetadata.json | $.Service.Description1  | metadataAttributePresence | ServiceQueryWithoutCluster  |             | DIDGPDB01V.dev.asgint.loc≫DB |              |            |                        |                      |                   |
      | Description | ida/ROCGreenplumPayloads/expectedMetadata.json | $.Service.Description2  | metadataValuePresence     | ServiceQueryWithoutCluster  |             | DIDGPDB01V.dev.asgint.loc≫DB |              |            |                        |                      |                   |
      | Description | ida/ROCGreenplumPayloads/expectedMetadata.json | $.Database.Description1 | metadataAttributePresence | DatabaseQueryWithoutCluster |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     |            |                        |                      |                   |
      | Description | ida/ROCGreenplumPayloads/expectedMetadata.json | $.Database.Description2 | metadataValuePresence     | DatabaseQueryWithoutCluster |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     |            |                        |                      |                   |
      | Description | ida/ROCGreenplumPayloads/expectedMetadata.json | $.Schema.Description1   | metadataAttributePresence | SchemaQueryWithoutCluster   |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     | public     |                        |                      |                   |
      | Description | ida/ROCGreenplumPayloads/expectedMetadata.json | $.Schema.Description2   | metadataValuePresence     | SchemaQueryWithoutCluster   |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     | public     |                        |                      |                   |
      | Description | ida/ROCGreenplumPayloads/expectedMetadata.json | $.Table.Description1    | metadataAttributePresence | TableQueryWithoutCluster    |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     | public     | rental                 |                      |                   |
      | Description | ida/ROCGreenplumPayloads/expectedMetadata.json | $.Table.Description2    | metadataValuePresence     | TableQueryWithoutCluster    |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     | public     | rental                 |                      |                   |
      | Lifecycle   | ida/ROCGreenplumPayloads/expectedMetadata.json | $.Column.Lifecycle      | metadataAttributePresence | ColumnQueryWithoutCluster   |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     | public     | rental                 | rental_id            |                   |
      | Statistics  | ida/ROCGreenplumPayloads/expectedMetadata.json | $.Column.Statistics     | metadataValuePresence     | ColumnQueryWithoutCluster   |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     | public     | rental                 | rental_id            |                   |
      | Description | ida/ROCGreenplumPayloads/expectedMetadata.json | $.Column.Description    | metadataValuePresence     | ColumnQueryWithoutCluster   |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     | public     | rental                 | rental_id            |                   |
      | Lifecycle   | ida/ROCGreenplumPayloads/expectedMetadata.json | $.Routine.Lifecycle     | metadataAttributePresence | RoutineQueryWithoutCluster  |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     | public     | film_in_stock≫Function |                      |                   |
      | Description | ida/ROCGreenplumPayloads/expectedMetadata.json | $.Routine.Description   | metadataValuePresence     | RoutineQueryWithoutCluster  |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     | public     | film_in_stock≫Function |                      |                   |


  @ROC_Greenplum @TEST_MLPQA-20336 @REQ_MLP-34165 @MLPQA-20287 	@TEST_MLPQA-20339 @REQ_MLP-34165 @MLPQA-20287
  Scenario: 1.  Verify Technology tags for replicated items after running Greenplum related & EDIBus plugin
  2. Verify the Technology tags for Analysis item for GreenplumScan, GreenplumImport, GreenplumLink, GreenplumReconcile
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName                  | DatabaseName | SchemaName | TableName/Filename                                        | Column    | Tags          | Query                       | Action      |
      |             | DIDGPDB01V.dev.asgint.loc≫DB |              |            |                                                           |           | Greenplum,ROC | ServiceQueryWithoutCluster  | TagAssigned |
      |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     |            |                                                           |           | Greenplum,ROC | DatabaseQueryWithoutCluster | TagAssigned |
      |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     | public     |                                                           |           | Greenplum,ROC | SchemaQueryWithoutCluster   | TagAssigned |
      |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     | public     | rental                                                    |           | Greenplum,ROC | TableQueryWithoutCluster    | TagAssigned |
      |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     | public     | rental                                                    | rental_id | Greenplum,ROC | ColumnQueryWithoutCluster   | TagAssigned |
      |             | DIDGPDB01V.dev.asgint.loc≫DB | tutorial     | public     | film_in_stock≫Function                                    |           | Greenplum,ROC | RoutineQueryWithoutCluster  | TagAssigned |
      |             |                              |              |            | rochade/GreenplumScan/RochadeGreenplumScan/%              |           | Greenplum,ROC | AnalysisQuery               | TagAssigned |
      |             |                              |              |            | rochade/GreenplumImport/RochadeGreenplumImport/%          |           | Greenplum,ROC | AnalysisQuery               | TagAssigned |
      |             |                              |              |            | rochade/GreenplumPostprocess/RochadeGreenplumPostprocess% |           | Greenplum,ROC | AnalysisQuery               | TagAssigned |
      |             |                              |              |            | rochade/GreenplumReconcile/RochadeGreenplumReconcile%     |           | Greenplum,ROC | AnalysisQuery               | TagAssigned |
      |             |                              |              |            | bulk/EDIBus/EDIBus_Greenplum/%                            |           | Greenplum,ROC | AnalysisQuery               | TagAssigned |


  ##################################################### Post Conditions #####################################################
  @post-condition @ROC_Greenplum
  Scenario Outline: Configure EDIBus plugin to perform clean up
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | bodyFile                                                        | path                           | response code | response message | jsonPath                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBus_Greenplum                            | payloads/ida/ROCGreenplumPayloads/RocGreenplumPluginConfig.json | $.EDIBusCleanup.configurations | 204           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBus_Greenplum                            |                                                                 |                                | 200           | EDIBus_Greenplum |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Greenplum |                                                                 |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Greenplum')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_Greenplum  |                                                                 |                                | 200           |                  |                                                       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_Greenplum |                                                                 |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_Greenplum')].status |


  @webtest @post-condition @ROC_Greenplum @TEST_MLPQA-20342 @REQ_MLP-34165 @MLPQA-20287
  Scenario: Verify all item types collected from Greenplum Rochade items are cleared in DD Platform when EDIBus is executed with the function 'cleanup'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "Greenplum" and clicks on search
    And user performs "facet selection" in "Greenplum" attribute under "Technology" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Column      |
      | Routine     |
      | Table       |
      | DataType    |
      | DataField   |
      | DataPackage |
      | Schema      |
      | Analysis    |
      | Database    |
      | Service     |
    And user should be able logoff the IDC


  @post-condition @ROC_Greenplum
  Scenario: PS_Clearing the EDI subject area after running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


  @post-condition @ROC_Greenplum
  Scenario:  Delete the analysis items for plugins: GreenplumScan, GreenplumImport, GreenplumPostprocess, GreenplumReconcile, EDIBus
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                          | type     | query | param |
      | MultipleIDDelete | Default | rochade/Greenplum%/%          | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBus_Greenplum% | Analysis |       |       |
      | MultipleIDDelete | Default | datasource/ROCGreenplum%      | Analysis |       |       |


  @post-condition @ROC_Greenplum
  Scenario Outline:  Delete Credentials, Datasource and plugin config for GreenplumScan, GreenplumImport, GreenplumPostprocess, GreenplumReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                 | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GreenplumScan/RochadeGreenplumScan               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GreenplumImport/RochadeGreenplumImport           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GreenplumPostprocess/RochadeGreenplumPostprocess |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/GreenplumReconcile/RochadeGreenplumReconcile     |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBus_Greenplum                          |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCGreenplumDataSource                           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCGreenplumSADataSource                         |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusGreenplumDS               |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeGreenplumSACredentials                  |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeGreenplumCredentials                  |          |      | 200           |                  |          |
