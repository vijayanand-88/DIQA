@MLPQA-20200
@REQ_MLP-30513
Feature: DI DD 2021 Headless Rochade - MSSAS Wrapper Validation
#  Stories: @MLP-34117

  @pre-condition @ROC_MSSAS
  Scenario: Pre: Clearing the EDI subject area before running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


  @ROC_MSSAS
  Scenario:PreCondition#Node Name update in configuration and data source files
    Given User update the ambari host in following files using json path
      | filePath                                       | jsonPath                                      | node            |
      | ida/ROCMSSASPayloads/RocMSSASPluginConfig.json | $.MSSASScan.configurations.nodeCondition      | HeadlessEDINode |
      | ida/ROCMSSASPayloads/RocMSSASPluginConfig.json | $.MSSASImport.configurations.nodeCondition    | HeadlessEDINode |
      | ida/ROCMSSASPayloads/RocMSSASPluginConfig.json | $.MSSASLink.configurations.nodeCondition      | HeadlessEDINode |
      | ida/ROCMSSASPayloads/RocMSSASPluginConfig.json | $.MSSASReconcile.configurations.nodeCondition | HeadlessEDINode |


  @pre-condition @ROC_MSSAS
  Scenario Outline: Configure Credentials, Data Source for SSAS wrapper and EDI Bus Plugins.
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                          | bodyFile                                               | path                   | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/RochadeMSSASSACredentials               | payloads/ida/ROCMSSASPayloads/RocMSSASCredentials.json | $.EDICredentials       | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/RochadeMSSASSACredentials               |                                                        |                        | 200           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCMSSASSADataSource/ROCMSSASSADataSource | payloads/ida/ROCMSSASPayloads/RocMSSASDataSource.json  | $.RocMSSASSADataSource | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCMSSASSADataSource/ROCMSSASSADataSource |                                                        |                        | 200           | ROCMSSASSADataSource |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/ROCMSSASDataSource/ROCMSSASDataSource     | payloads/ida/ROCMSSASPayloads/RocMSSASDataSource.json  | $.RocMSSASDataSource   | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/ROCMSSASDataSource/ROCMSSASDataSource     |                                                        |                        | 200           | ROCMSSASDataSource   |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBusDataSource/EDIBusMSSASDS            | payloads/ida/ROCMSSASPayloads/RocMSSASDataSource.json  | $.EDIBusDataSource     | 204           |                      |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBusDataSource/EDIBusMSSASDS            |                                                        |                        | 200           | EDIBusMSSASDS        |          |


  @pre-condition @ROC_MSSAS
  Scenario Outline: Configure plugins: SSASScan, SSASImport, SSASPostprocess, SSASReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                     | bodyFile                                                | path                            | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MSSASScan/RochadeMSSASScan           | payloads/ida/ROCMSSASPayloads/RocMSSASPluginConfig.json | $.MSSASScan.configurations      | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MSSASScan/RochadeMSSASScan           |                                                         |                                 | 200           | RochadeMSSASScan      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MSSASImport/RochadeMSSASImport       | payloads/ida/ROCMSSASPayloads/RocMSSASPluginConfig.json | $.MSSASImport.configurations    | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MSSASImport/RochadeMSSASImport       |                                                         |                                 | 200           | RochadeMSSASImport    |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MSSASLink/RochadeMSSASLink           | payloads/ida/ROCMSSASPayloads/RocMSSASPluginConfig.json | $.MSSASLink.configurations      | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MSSASLink/RochadeMSSASLink           |                                                         |                                 | 200           | RochadeMSSASLink      |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/MSSASReconcile/RochadeMSSASReconcile | payloads/ida/ROCMSSASPayloads/RocMSSASPluginConfig.json | $.MSSASReconcile.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/MSSASReconcile/RochadeMSSASReconcile |                                                         |                                 | 200           | RochadeMSSASReconcile |          |
      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/analyzers/EDIBus/EDIBus_MSSAS                  | payloads/ida/ROCMSSASPayloads/RocMSSASPluginConfig.json | $.EDIBus.configurations         | 204           |                       |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/analyzers/EDIBus/EDIBus_MSSAS                  |                                                         |                                 | 200           | EDIBus_MSSAS          |          |


  #################################################### Plugin Run #####################################################
  @ROC_MSSAS
  Scenario Outline: Run SSASImport, SSASPostprocess, SSASReconcile, EDIBus Plugins
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    And user waits for the final status to be reflected after "10000" milliseconds
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile | path | response code | response message | jsonPath                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSASScan/RochadeMSSASScan           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSASScan')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSASScan/RochadeMSSASScan            |          |      | 200           |                  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSASScan/RochadeMSSASScan           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSASScan')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSASImport/RochadeMSSASImport       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSASImport')].status    |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSASImport/RochadeMSSASImport        |          |      | 200           |                  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSASImport/RochadeMSSASImport       |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSASImport')].status    |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSASLink/RochadeMSSASLink           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSASLink')].status      |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSASLink/RochadeMSSASLink            |          |      | 200           |                  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSASLink/RochadeMSSASLink           |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSASLink')].status      |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSASReconcile/RochadeMSSASReconcile |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSASReconcile')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/HeadlessEDI/rochade/MSSASReconcile/RochadeMSSASReconcile  |          |      | 200           |                  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/HeadlessEDI/rochade/MSSASReconcile/RochadeMSSASReconcile |          |      | 200           | IDLE             | $.[?(@.configurationName=='RochadeMSSASReconcile')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_MSSAS                    |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_MSSAS')].status          |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_MSSAS                     |          |      | 200           |                  |                                                            |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_MSSAS                    |          |      | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_MSSAS')].status          |


  @ROC_UDB
  Scenario Outline: Sync Solr
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                   | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | searches/fulltext/synchronize/Default |          |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post   | searches/fulltext/synchronize/Default |          |      | 200           |                  |          |



  ##################################################### Verifications #####################################################
  @ROC_MSSAS @TEST_MLPQA-20191 @REQ_MLP-34117 @MLPQA-20177
  Scenario: Verify the Logging Enhancements - Analysis logs for MSSASScan, MSSASImport, MSSASLink, MSSASReconcile
    Given Analysis log "rochade/MSSASScan/RochadeMSSASScan/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                               | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                                         | ANALYSIS-0019 |            |                |
      | INFO | Plugin Name:MSSASScan, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeMSSASScan | ANALYSIS-0071 | MSSASScan  | Plugin Version |
    And Analysis log "rochade/MSSASImport/RochadeMSSASImport/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                   | logCode       | pluginName  | removableText  |
      | INFO | Plugin started                                                                                                                                                                             | ANALYSIS-0019 |             |                |
      | INFO | Plugin Name:MSSASImport, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeMSSASImport | ANALYSIS-0071 | MSSASImport | Plugin Version |
      | INFO | Plugin MSSASImport Start Time:2021-02-11 09:05:08.993, End Time:2021-02-11 09:05:15.642, Errors:0, Warnings:0                                                                              | ANALYSIS-0072 | MSSASImport |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                  | ANALYSIS-0020 |             |                |
    And Analysis log "rochade/MSSASLink/RochadeMSSASLink/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                               | logCode       | pluginName | removableText  |
      | INFO | Plugin started                                                                                                                                                                         | ANALYSIS-0019 |            |                |
      | INFO | Plugin Name:MSSASLink, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeMSSASLink | ANALYSIS-0071 | MSSASLink  | Plugin Version |
      | INFO | Plugin MSSASLink Start Time:2021-02-12 06:11:21.570, End Time:2021-02-12 06:11:24.724, Errors:0, Warnings:0                                                                            | ANALYSIS-0072 | MSSASLink  |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                              | ANALYSIS-0020 |            |                |
    And Analysis log "rochade/MSSASReconcile/RochadeMSSASReconcile/%" should display below info/error/warning
      | type | logValue                                                                                                                                                                                         | logCode       | pluginName     | removableText  |
      | INFO | Plugin started                                                                                                                                                                                   | ANALYSIS-0019 |                |                |
      | INFO | Plugin Name:MSSASReconcile, Plugin Type:rochade, Plugin Version:1.2.0.SNAPSHOT, Node Name:ROCIDANode, Host Name:DIQROCHADE01V.DIQ.QA.ASGINT.LOC, Plugin Configuration name:RochadeMSSASReconcile | ANALYSIS-0071 | MSSASReconcile | Plugin Version |
      | INFO | Plugin MSSASReconcile Start Time:2021-02-12 06:11:41.919, End Time:2021-02-12 06:11:47.469, Errors:0, Warnings:0                                                                                 | ANALYSIS-0072 | MSSASReconcile |                |
      | INFO | Plugin completed processing (elapsed time in (HH:MM:SS.ms): 00:00:04.517)                                                                                                                        | ANALYSIS-0020 |                |                |


  @webtest @ROC_MSSAS @TEST_MLPQA-20193 @REQ_MLP-34117 @MLPQA-20177
  Scenario: Verify the availability of HTML file under analysis items for plugins: MSSASScan, MSSASImport, MSSASLink
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SSAS" and clicks on search
    And user performs "facet selection" in "SSAS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSAS" should get displayed for the column "rochade/MSSASScan/RochadeMSSASScan/%"
    And user enters the search text "SSAS" and clicks on search
    And user performs "facet selection" in "SSAS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSAS" should get displayed for the column "rochade/MSSASImport/RochadeMSSASImport/%"
    And user performs "latest analysis click" in Item Results page for "rochade/MSSASImport/RochadeMSSASImport/%"
    Then user performs click and verify in new window
      | Table | value                | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | MSSAS-ImportLog.html | verify widget contains |                  |             |
    And user enters the search text "SSAS" and clicks on search
    And user performs "facet selection" in "SSAS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSAS" should get displayed for the column "rochade/MSSASLink/RochadeMSSASLink/%"
    And user performs "latest analysis click" in Item Results page for "rochade/MSSASLink/RochadeMSSASLink/%"
    Then user performs click and verify in new window
      | Table | value                  | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | MSSAS-DBLinkerLog.html | verify widget contains |                  |             |
    And user enters the search text "SSAS" and clicks on search
    And user performs "facet selection" in "SSAS" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    Then the following tags "ROC,SSAS" should get displayed for the column "rochade/MSSASReconcile/RochadeMSSASReconcile/%"
    And user should be able logoff the IDC


  @ROC_MSSAS
  Scenario Outline:  user retrieves facets and respective counts of SSAS wrapper items
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                                                                                                     | body                                                     | response code | response message | filePath                                          | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | searches/fulltext/Default?query=*&what=id&what=catalog&advanced=false&natural=false&limit=2500&offset=0&limitFacets=100 | payloads/ida/ROCMSSASPayloads/getFacetsCountRequest.json | 200           |                  | payloads/ida/ROCMSSASPayloads/facetWiseCount.json |          |


  @ROC_MSSAS @TEST_MLPQA-20198 @REQ_MLP-34117 @MLPQA-20177
  Scenario: Verify MSSAS Rochade items are replicated to DD after running EDIBus plugin
    And user gets the items count from json
      | filePath                                          | jsonPath                                          |
      | payloads/ida/ROCMSSASPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Schema')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                 |
      | AP-DATA      | METAAPPS    | PRODUCTION         | XNAME * *  ~/ @* AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_SCHEMA ) |
    And user gets the items count from json
      | filePath                                          | jsonPath                                         |
      | payloads/ida/ROCMSSASPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Table')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                        |
      | AP-DATA      | METAAPPS    | PRODUCTION         | XNAME * *  ~/ @* AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
    And user gets the items count from json
      | filePath                                          | jsonPath                                          |
      | payloads/ida/ROCMSSASPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Column')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                 |
      | AP-DATA      | METAAPPS    | PRODUCTION         | XNAME * *  ~/ @* AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_COLUMN ) |
    And user gets the items count from json
      | filePath                                          | jsonPath                                             |
      | payloads/ida/ROCMSSASPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Dimension')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | XNAME * *  ~/ @* AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_DIMENSION ) |
    And user gets the items count from json
      | filePath                                          | jsonPath                                             |
      | payloads/ida/ROCMSSASPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Hierarchy')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | METAAPPS    | PRODUCTION         | XNAME * *  ~/ @* AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_HIERARCHY ) |
    And user gets the items count from json
      | filePath                                          | jsonPath                                                    |
      | payloads/ida/ROCMSSASPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='AggregationLevel')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                |
      | AP-DATA      | METAAPPS    | PRODUCTION         | XNAME * *  ~/ @* AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_ANL_LEVEL ) |
    Given user gets the items count from json
      | filePath                                          | jsonPath                                            |
      | payloads/ida/ROCMSSASPayloads/facetWiseCount.json | $.facetCounts.type_s.[?(@.value=='Database')].count |
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                  |
      | AP-DATA      | METAAPPS    | PRODUCTION         | XNAME * *  ~/ @* AND ( INSTCFGCNT > 0 ) AND ( TYPE = DWR_RDB_DATABASE) |


  @webtest @ROC_MSSAS @TEST_MLPQA-20194 @REQ_MLP-34117 @MLPQA-20177  @TEST_MLPQA-20195 @REQ_MLP-34117 @MLPQA-20177
  Scenario: 1.  Verify the breadcrumb hierarchy appears correctly when MSSASScan (Database)Rochade items are replicated to DD after running EDIBus plugin
  2. Verify the breadcrumb hierarchy appears correctly when MSSASScan (OlapPackage) Rochade items are replicated to DD after running EDIBus plugin.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SSAS" and clicks on search
    And user performs "facet selection" in "SSAS" attribute under "Technology" facets in Item Search results page
    Then user verify "presence of facets" with following values under "Metadata Type" section in item search results page
      | Measure          |
      | Column           |
      | Dimension        |
      | AggregationLevel |
      | Table            |
      | Hierarchy        |
      | Analysis         |
      | Schema           |
      | Cube             |
      | OlapPackage      |
      | Service          |
    And user enters the search text "Dim_Business_Line" and clicks on search
    And user performs "facet selection" in "Dimension" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Sales Model [Cube]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "Dim_Business_Line" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | DIDROCHADE04V\I2019TAB |
      | Sales Model            |
      | Sales Model            |
      | Dim_Business_Line      |
    And user enters the search text "IsCurrentYear" and clicks on search
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Dim Date [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "IsCurrentYear" item from search results
    Then user "verify presence" of following "breadcrumb" in Item View Page
      | DIDROCHADE04V\I2019TAB [AS]≫DB |
      | CaseReporting                  |
      | Model                          |
      | Dim Date                       |
      | IsCurrentYear                  |
    And user should be able logoff the IDC


  @ROC_MSSAS @TEST_MLPQA-20198 @REQ_MLP-34117 @MLPQA-20177
  Scenario: Verify MSSAS Rochade items are replicated to DD after running EDIBus plugin
    And Verify the metadata properties of the item types via api call
      | widgetName  | filePath                                   | jsonPath                   | Action                    | query                      | ClusterName | ServiceName                    | DatabaseName           | SchemaName  | TableName/Filename | columnName/FieldName | specialCharacters |
      | Description | ida/ROCMSSASPayloads/expectedMetadata.json | $.Service.Description1     | metadataAttributePresence | ServiceQueryWithoutCluster |             | DIDROCHADE04V\I2019TAB [AS]≫DB |                        |             |                    |                      |                   |
      | Description | ida/ROCMSSASPayloads/expectedMetadata.json | $.Service.Description2     | metadataValuePresence     | ServiceQueryWithoutCluster |             | DIDROCHADE04V\I2019TAB [AS]≫DB |                        |             |                    |                      | Yes               |
      | Description | ida/ROCMSSASPayloads/expectedMetadata.json | $.Schema.Description1      | metadataAttributePresence | SchemaQueryWithoutCluster  |             | DIDROCHADE04V\I2019TAB [AS]≫DB | CaseReporting          | Model       |                    |                      |                   |
      | Description | ida/ROCMSSASPayloads/expectedMetadata.json | $.Schema.Description2      | metadataValuePresence     | SchemaQueryWithoutCluster  |             | DIDROCHADE04V\I2019TAB [AS]≫DB | CaseReporting          | Model       |                    |                      |                   |
      | Description | ida/ROCMSSASPayloads/expectedMetadata.json | $.Table.Description1       | metadataAttributePresence | TableQueryWithoutCluster   |             | DIDROCHADE04V\I2019TAB [AS]≫DB | CaseReporting          | Model       | Interaction Type   |                      |                   |
      | Description | ida/ROCMSSASPayloads/expectedMetadata.json | $.Table.Description2       | metadataValuePresence     | TableQueryWithoutCluster   |             | DIDROCHADE04V\I2019TAB [AS]≫DB | CaseReporting          | Model       | Interaction Type   |                      |                   |
      | Lifecycle   | ida/ROCMSSASPayloads/expectedMetadata.json | $.Column.Lifecycle         | metadataAttributePresence | ColumnQueryWithoutCluster  |             | DIDROCHADE04V\I2019TAB [AS]≫DB | CaseReporting          | Model       | Interaction Type   | EffectiveTo          |                   |
      | Statistics  | ida/ROCMSSASPayloads/expectedMetadata.json | $.Column.Statistics        | metadataValuePresence     | ColumnQueryWithoutCluster  |             | DIDROCHADE04V\I2019TAB [AS]≫DB | CaseReporting          | Model       | Interaction Type   | EffectiveTo          |                   |
      | Description | ida/ROCMSSASPayloads/expectedMetadata.json | $.Column.Description       | metadataValuePresence     | ColumnQueryWithoutCluster  |             | DIDROCHADE04V\I2019TAB [AS]≫DB | CaseReporting          | Model       | Interaction Type   | EffectiveTo          |                   |
      | Description | ida/ROCMSSASPayloads/expectedMetadata.json | $.OlapPackage.Description1 | metadataAttributePresence | OlapPackageQuery           |             |                                | DIDROCHADE04V\I2019TAB |             |                    |                      |                   |
      | Description | ida/ROCMSSASPayloads/expectedMetadata.json | $.OlapPackage.Description2 | metadataValuePresence     | OlapPackageQuery           |             |                                | DIDROCHADE04V\I2019TAB |             |                    |                      |                   |
      | Description | ida/ROCMSSASPayloads/expectedMetadata.json | $.Dimension.Description1   | metadataAttributePresence | DimensionQuery             |             |                                | DIDROCHADE04V\I2019TAB | Sales Model | Dim_Campaign       |                      |                   |
      | Description | ida/ROCMSSASPayloads/expectedMetadata.json | $.Dimension.Description2   | metadataValuePresence     | DimensionQuery             |             |                                | DIDROCHADE04V\I2019TAB | Sales Model | Dim_Campaign       |                      |                   |
      | Description | ida/ROCMSSASPayloads/expectedMetadata.json | $.Measure.Description1     | metadataAttributePresence | MeasureQuery               |             |                                | DIDROCHADE04V\I2019TAB | Sales Model | Dim_Campaign       | DSP_SEQ_NO           |                   |
      | Description | ida/ROCMSSASPayloads/expectedMetadata.json | $.Measure.Description2     | metadataValuePresence     | MeasureQuery               |             |                                | DIDROCHADE04V\I2019TAB | Sales Model | Dim_Campaign       | DSP_SEQ_NO           |                   |


  @ROC_MSSAS @TEST_MLPQA-20196 @REQ_MLP-34117 @MLPQA-20177 @TEST_MLPQA-20192 @REQ_MLP-34117 @MLPQA-20177
  Scenario: 1.  Verify Technology tags for replicated items after running MSSAS related & EDIBus plugin
  2. Scenario: Verify the Technology tags for Analysis item for MSSASScan, MSSASFileSystemScan, MSSASImport, MSSASLink, MSSASReconcile
    Given Tag verification of UI items in API for all the DataTypes
      | ClusterName | ServiceName                    | DatabaseName           | SchemaName  | TableName/Filename                            | Column      | Tags     | Query                      | Action      |
      |             | DIDROCHADE04V\I2019TAB [AS]≫DB |                        |             |                                               |             | SSAS,ROC | ServiceQueryWithoutCluster | TagAssigned |
      |             | DIDROCHADE04V\I2019TAB [AS]≫DB |                        |             |                                               |             | SSAS,ROC | ServiceQueryWithoutCluster | TagAssigned |
      |             | DIDROCHADE04V\I2019TAB [AS]≫DB | CaseReporting          | Model       |                                               |             | SSAS,ROC | SchemaQueryWithoutCluster  | TagAssigned |
      |             | DIDROCHADE04V\I2019TAB [AS]≫DB | CaseReporting          | Model       |                                               |             | SSAS,ROC | SchemaQueryWithoutCluster  | TagAssigned |
      |             | DIDROCHADE04V\I2019TAB [AS]≫DB | CaseReporting          | Model       | Interaction Type                              |             | SSAS,ROC | TableQueryWithoutCluster   | TagAssigned |
      |             | DIDROCHADE04V\I2019TAB [AS]≫DB | CaseReporting          | Model       | Interaction Type                              |             | SSAS,ROC | TableQueryWithoutCluster   | TagAssigned |
      |             | DIDROCHADE04V\I2019TAB [AS]≫DB | CaseReporting          | Model       | Interaction Type                              | EffectiveTo | SSAS,ROC | ColumnQueryWithoutCluster  | TagAssigned |
      |             | DIDROCHADE04V\I2019TAB [AS]≫DB | CaseReporting          | Model       | Interaction Type                              | EffectiveTo | SSAS,ROC | ColumnQueryWithoutCluster  | TagAssigned |
      |             | DIDROCHADE04V\I2019TAB [AS]≫DB | CaseReporting          | Model       | Interaction Type                              | EffectiveTo | SSAS,ROC | ColumnQueryWithoutCluster  | TagAssigned |
      |             |                                | DIDROCHADE04V\I2019TAB |             |                                               |             | SSAS,ROC | OlapPackageQuery           | TagAssigned |
      |             |                                | DIDROCHADE04V\I2019TAB |             |                                               |             | SSAS,ROC | OlapPackageQuery           | TagAssigned |
      |             |                                | DIDROCHADE04V\I2019TAB | Sales Model | Dim_Campaign                                  |             | SSAS,ROC | DimensionQuery             | TagAssigned |
      |             |                                | DIDROCHADE04V\I2019TAB | Sales Model | Dim_Campaign                                  |             | SSAS,ROC | DimensionQuery             | TagAssigned |
      |             |                                | DIDROCHADE04V\I2019TAB | Sales Model | Dim_Campaign                                  | DSP_SEQ_NO  | SSAS,ROC | MeasureQuery               | TagAssigned |
      |             |                                | DIDROCHADE04V\I2019TAB | Sales Model | Dim_Campaign                                  | DSP_SEQ_NO  | SSAS,ROC | MeasureQuery               | TagAssigned |
      |             |                                |                        |             | rochade/MSSASScan/RochadeMSSASScan/%          |             | SSAS,ROC | AnalysisQuery              | TagAssigned |
      |             |                                |                        |             | rochade/MSSASImport/RochadeMSSASImport/%      |             | SSAS,ROC | AnalysisQuery              | TagAssigned |
      |             |                                |                        |             | rochade/MSSASLink/RochadeMSSASLink%           |             | SSAS,ROC | AnalysisQuery              | TagAssigned |
      |             |                                |                        |             | rochade/MSSASReconcile/RochadeMSSASReconcile% |             | SSAS,ROC | AnalysisQuery              | TagAssigned |
      |             |                                |                        |             | bulk/EDIBus/EDIBus_MSSAS/%                    |             | SSAS,ROC | AnalysisQuery              | TagAssigned |


  ##################################################### Post Conditions #####################################################
  @post-condition @ROC_MSSAS
  Scenario Outline: Configure EDIBus plugin to perform clean up
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                               | bodyFile                                                | path                           | response code | response message | jsonPath                                          |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/EDIBus/EDIBus_MSSAS                            | payloads/ida/ROCMSSASPayloads/RocMSSASPluginConfig.json | $.EDIBusCleanup.configurations | 204           |                  |                                                   |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/EDIBus/EDIBus_MSSAS                            |                                                         |                                | 200           | EDIBus_MSSAS     |                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_MSSAS |                                                         |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_MSSAS')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus_MSSAS  |                                                         |                                | 200           |                  |                                                   |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus_MSSAS |                                                         |                                | 200           | IDLE             | $.[?(@.configurationName=='EDIBus_MSSAS')].status |


  @webtest @post-condition @ROC_MSSAS @TEST_MLPQA-20199 @REQ_MLP-34117 @MLPQA-20177
  Scenario: Verify all item types collected from MSSAS Rochade items are cleared in DD Platform when EDIBus is executed with the function 'cleanup'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SSAS" and clicks on search
    And user performs "facet selection" in "SSAS" attribute under "Technology" facets in Item Search results page
    Then user verify "non presence of facets" with following values under "Metadata Type" section in item search results page
      | Measure          |
      | Column           |
      | Dimension        |
      | AggregationLevel |
      | Table            |
      | Hierarchy        |
      | Schema           |
      | Cube             |
      | OlapPackage      |
      | Service          |
    And user should be able logoff the IDC


  @post-condition @ROC_MSSAS
  Scenario: PS_Clearing the EDI subject area after running the Rochade wrapper plugins from DD
    Given user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | SCANNER     | STAGING            | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
      | AP-DATA      | METAAPPS    | PRODUCTION         | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


  @post-condition @ROC_MSSAS
  Scenario:  Delete the analysis items for plugins: SSASScan, SSASImport, SSASPostprocess, SSASReconcile, EDIBus
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | MultipleIDDelete | Default | rochade/MSSAS%/%           | Analysis |       |       |
      | MultipleIDDelete | Default | bulk/EDIBus/EDIBus_MSSAS% | Analysis |       |       |
      | MultipleIDDelete | Default | datasource/ROCMSSAS%      | Analysis |       |       |


  @post-condition @ROC_MSSAS
  Scenario Outline:  Delete Credentials, Datasource and plugin config for SSASScan, SSASImport, SSASPostprocess, SSASReconcile, EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                     | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MSSASScan/RochadeMSSASScan           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MSSASImport/RochadeMSSASImport       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MSSASLink/RochadeMSSASLink           |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/MSSASReconcile/RochadeMSSASReconcile |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBus/EDIBus_MSSAS                  |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCMSSASDataSource                   |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/ROCMSSASSADataSource                 |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusMSSASDS       |          |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Delete | settings/credentials/RochadeMSSASSACredentials          |          |      | 200           |                  |          |
