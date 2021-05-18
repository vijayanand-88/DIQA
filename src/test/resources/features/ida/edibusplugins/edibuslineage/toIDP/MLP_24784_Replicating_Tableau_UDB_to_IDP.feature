Feature: MLP_24784 Replicate Tableau Scanner and UDB technologies to IDP

  @MLP-24784 @edibus
  Scenario Outline: SC1#-Set the DataSource for UDB
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                     | bodyFile                                                           | path                                 | response code | response message    | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusUDBDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusUDBDataSource.configurations | 204           |                     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                     |                                                                    |                                      | 200           | EDIBusUDBDataSource |          |

  #7133609#
  @edibus @mlp-24784 @webtest @positive @toIDP
  Scenario:SC1#MLP-24784 Verification of replication of UDB technology from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                            | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_24784_UDBTechnology.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/UDBTechtoIDP |                                                 | 200           | IDLE             | $.[?(@.configurationName=='UDBTechtoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/UDBTechtoIDP  |                                                 | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/UDBTechtoIDP |                                                 | 200           | IDLE             | $.[?(@.configurationName=='UDBTechtoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/UDBTechtoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/UDBTechtoIDP%" should display below info/error/warning
      | type | logValue                   | logCode      | pluginName | removableText |
      | INFO | replication of 10320 items | EDIBUS-I0024 |            |               |
    And user enters the search text "DIQDB211501V≫DB" and clicks on search
    And user performs "facet selection" in "DIQDB211501V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DB2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Column   |
      | Table    |
      | Routine  |
      | Schema   |
      | Trigger  |
      | Database |
      | Service  |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag     | fileName | userTag |
      | Default     | Database | Metadata Type | DB2,ROC | SAMPLE   | DB2     |
    And user enters the search text "DIQDB211501V≫DB" and clicks on search
    And user performs "facet selection" in "DIQDB211501V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | UDB         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
    And user enters the search text "DIQDB211501V≫DB" and clicks on search
    And user performs "facet selection" in "DIQDB211501V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | UDB         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
    And user enters the search text "DIQDB211501V≫DB" and clicks on search
    And user performs "facet selection" in "DIQDB211501V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
      | AP-DATA      | UDB         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
    And user enters the search text "DIQDB211501V≫DB" and clicks on search
    And user performs "facet selection" in "DIQDB211501V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | UDB         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA ) |
    And user enters the search text "DIQDB211501V≫DB" and clicks on search
    And user performs "facet selection" in "DIQDB211501V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Routine" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                                  |
      | AP-DATA      | UDB         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_FUNCTION OR TYPE = DWR_RDB_PROCEDURE ) |
    And user enters the search text "DIQDB211501V≫DB" and clicks on search
    And user performs "facet selection" in "DIQDB211501V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Trigger" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     |
      | AP-DATA      | UDB         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TRIGGER ) |


  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/UDBTechtoIDP% | Analysis |       |       |

  #7133632#
  @edibus @mlp-24784 @webtest @positive @toIDP
  Scenario Outline:SC2#MLP-24784 Verification of deleting the replicated UDB items using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                         | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_24784_UDBCleanup.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/UDBTechtoIDP |                                              | 200           | IDLE             | $.[?(@.configurationName=='UDBTechtoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/UDBTechtoIDP  |                                              | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/UDBTechtoIDP |                                              | 200           | IDLE             | $.[?(@.configurationName=='UDBTechtoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/UDBTechtoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/UDBTechtoIDP%" should display below info/error/warning
      | type | logValue            | logCode      | pluginName | removableText |
      | INFO | 10703 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name            | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | DIQDB211501V≫DB |             |            |          |


  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/UDBTechtoIDP% | Analysis |       |       |


  #7133637#
  @edibus @mlp-24784 @webtest @positive @toIDP
  Scenario:SC3#MLP-24784 Verification of replication of UDB technology with item types from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                           | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_24784_UDBTechTypes.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/UDBTechTypes |                                                | 200           | IDLE             | $.[?(@.configurationName=='UDBTechTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/UDBTechTypes  |                                                | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/UDBTechTypes |                                                | 200           | IDLE             | $.[?(@.configurationName=='UDBTechTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/UDBTechTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/UDBTechTypes%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 15 items | EDIBUS-I0010 |            |               |
    And user enters the search text "DIQDB211501V≫DB" and clicks on search
    And user performs "facet selection" in "DIQDB211501V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DB2" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Schema   |
      | Service  |
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | Table   |
      | Column  |
      | Routine |
      | Trigger |


  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/UDBTechTypes% | Analysis |       |       |

    #7133643#
  @edibus @mlp-24784 @webtest @positive @toIDP
  Scenario Outline:SC4#MLP-24784 Verification of deleting the replicated UDB items with item types using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                              | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_24784_UDBTypesCleanup.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/UDBTechTypes |                                                   | 200           | IDLE             | $.[?(@.configurationName=='UDBTechTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/UDBTechTypes  |                                                   | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/UDBTechTypes |                                                   | 200           | IDLE             | $.[?(@.configurationName=='UDBTechTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/UDBTechTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/UDBTechTypes%" should display below info/error/warning
      | type | logValue         | logCode      | pluginName | removableText |
      | INFO | 15 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type     | name   | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Database | SAMPLE |             |            |          |


  Scenario:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/UDBTechTypes% | Analysis |       |       |


  @MLP-24784 @edibus
  Scenario Outline: SC5#-Set the DataSource for Scan Tableau
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                         | bodyFile                                                           | path                                     | response code | response message        | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusTableauDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusTableauDataSource.configurations | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusTableauDataSource |          |

 #7133646#
  @edibus @mlp-24784 @webtest @positive @toIDP
  Scenario:SC5#MLP-24784 Verification of replication of  Tableau technology from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                          | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_24784_TableauTech.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TableautoIDP |                                               | 200           | IDLE             | $.[?(@.configurationName=='TableautoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TableautoIDP  |                                               | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TableautoIDP |                                               | 200           | IDLE             | $.[?(@.configurationName=='TableautoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/TableautoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/TableautoIDP%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 31 items | EDIBUS-I0024 |            |               |
    And user enters the search text "cfgtableau" and clicks on search
    And user performs "facet selection" in "https://cfgtableauqa/t/BusinessServicesAnalyticsandReporting/workbooks/NetezzaMockDB [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Tableau" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | DataField    |
      | Report       |
      | DataType     |
      | ReportSchema |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name         | facet         | Tag         | fileName   | userTag |
      | Default     | ReportSchema | Metadata Type | Tableau,ROC | Dashboards | Tableau |
    And user enters the search text "cfgtableau" and clicks on search
    And user performs "facet selection" in "https://cfgtableauqa/t/BusinessServicesAnalyticsandReporting/workbooks/NetezzaMockDB [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DataField" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | SCANTAB     | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_RPT_FIELD ) |
    And user enters the search text "cfgtableau" and clicks on search
    And user performs "facet selection" in "https://cfgtableauqa/t/BusinessServicesAnalyticsandReporting/workbooks/NetezzaMockDB [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Report" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | SCANTAB     | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_REPORT ) |
    And user enters the search text "cfgtableau" and clicks on search
    And user performs "facet selection" in "https://cfgtableauqa/t/BusinessServicesAnalyticsandReporting/workbooks/NetezzaMockDB [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DataType" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | SCANTAB     | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_RPT_STRUCTURE ) |
    And user enters the search text "cfgtableau" and clicks on search
    And user performs "facet selection" in "https://cfgtableauqa/t/BusinessServicesAnalyticsandReporting/workbooks/NetezzaMockDB [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "ReportSchema" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                        |
      | AP-DATA      | SCANTAB     | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_RPT_SCHEMA ) |
    And user enters the search text "cfgtableau" and clicks on search
    And user performs "facet selection" in "https://cfgtableauqa/t/BusinessServicesAnalyticsandReporting/workbooks/NetezzaMockDB [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Report" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Netezza Data" item from search results
    Then user performs click and verify in new window
      | Table        | value            | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | Netezza Data     | verify widget contains | No               |             |
      | Lineage Hops | [:Measure Names] | verify widget contains | No               |             |
    And user enters the search text "cfgtableau" and clicks on search
    And user performs "facet selection" in "https://cfgtableauqa/t/BusinessServicesAnalyticsandReporting/workbooks/NetezzaMockDB [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Report" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Net Income vs Interest Expense" item from search results
    Then user performs click and verify in new window
      | Table        | value                            | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | CPDM_DE_SPT.As Of Dt             | verify widget contains | No               |             |
      | Lineage Hops | CPDM_DE_SPT.Interest Expense Amt | verify widget contains | No               |             |
      | Lineage Hops | CPDM_DE_SPT.Net Income Amt       | verify widget contains | No               |             |
      | Lineage Hops | Net Income vs Interest Expense   | verify widget contains | No               |             |
    And user enters the search text "cfgtableau" and clicks on search
    And user performs "facet selection" in "https://cfgtableauqa/t/BusinessServicesAnalyticsandReporting/workbooks/NetezzaMockDB [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Report" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Interest Income vs Interest Expense" item from search results
    Then user performs click and verify in new window
      | Table        | value                               | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | CPDM_DE_SPT.As Of Dt                | verify widget contains | No               |             |
      | Lineage Hops | CPDM_DE_SPT.Interest Expense Amt    | verify widget contains | No               |             |
      | Lineage Hops | CPDM_DE_SPT.Interest Income Amt     | verify widget contains | No               |             |
      | Lineage Hops | Interest Income vs Interest Expense | verify widget contains | No               |             |
    And user enters the search text "cfgtableau" and clicks on search
    And user performs "facet selection" in "https://cfgtableauqa/t/BusinessServicesAnalyticsandReporting/workbooks/NetezzaMockDB [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Report" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Net Income vs Interest Income" item from search results
    Then user performs click and verify in new window
      | Table        | value                           | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | CPDM_DE_SPT.As Of Dt            | verify widget contains | No               |             |
      | Lineage Hops | CPDM_DE_SPT.Interest Income Amt | verify widget contains | No               |             |
      | Lineage Hops | CPDM_DE_SPT.Net Income Amt      | verify widget contains | No               |             |
      | Lineage Hops | Net Income vs Interest Income   | verify widget contains | No               |             |

  Scenario:SC5#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/TableautoIDP% | Analysis |       |       |

     #7133632#
  @edibus @mlp-24784 @webtest @positive @toIDP
  Scenario Outline:SC6#MLP-24784 Verification of deleting the replicated Tableau items using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                             | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_24784_TableauCleanup.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TableautoIDP |                                                  | 200           | IDLE             | $.[?(@.configurationName=='TableautoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TableautoIDP  |                                                  | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TableautoIDP |                                                  | 200           | IDLE             | $.[?(@.configurationName=='TableautoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/TableautoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/TableautoIDP%" should display below info/error/warning
      | type | logValue         | logCode      | pluginName | removableText |
      | INFO | 35 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type          | name                                                                                 | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | ReportPackage | https://cfgtableauqa/t/BusinessServicesAnalyticsandReporting/workbooks/NetezzaMockDB |             |            |          |


  Scenario:SC6#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/TableautoIDP% | Analysis |       |       |


     #7134820#
  @edibus @mlp-24784 @webtest @positive @toIDP
  Scenario:SC7#MLP-24784 Verification of replication of Tableau technology with item types from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                           | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_24784_TableauTypes.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TableauTypes |                                                | 200           | IDLE             | $.[?(@.configurationName=='TableauTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TableauTypes  |                                                | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TableauTypes |                                                | 200           | IDLE             | $.[?(@.configurationName=='TableauTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/TableauTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/TableauTypes%" should display below info/error/warning
      | type | logValue               | logCode      | pluginName | removableText |
      | INFO | replication of 3 items | EDIBUS-I0024 |            |               |
    And user enters the search text "cfgtableau" and clicks on search
    And user performs "facet selection" in "https://cfgtableauqa/t/BusinessServicesAnalyticsandReporting/workbooks/NetezzaMockDB [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Tableau" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | ReportSchema  |
      | ReportPackage |
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | DataType |
      | DatField |
      | Report   |

  Scenario:SC7#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/TableauTypes% | Analysis |       |       |


       #7134845#
  @edibus @mlp-24784 @webtest @positive @toIDP
  Scenario Outline:SC8#MLP-24784 Verification of deleting the replicated Tableau items with item types using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                               | body                                                  | response code | response message | jsonPath                                          |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_24784_TableauTypesCleanup.json | 204           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TableauTypes |                                                       | 200           | IDLE             | $.[?(@.configurationName=='TableauTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/TableauTypes  |                                                       | 200           |                  |                                                   |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/TableauTypes |                                                       | 200           | IDLE             | $.[?(@.configurationName=='TableauTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/TableauTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/TableauTypes%" should display below info/error/warning
      | type | logValue        | logCode      | pluginName | removableText |
      | INFO | 3 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type         | name       | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | ReportSchema | Worksheets |             |            |          |

  Scenario:SC8#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/TableauTypes% | Analysis |       |       |


  @edibus @mlp-24779 @positive @release10.0
  Scenario:MLP-24779 Deleting EDIBus configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                         | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus                                   |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusUDBDataSource     |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusTableauDataSource |      | 204           |                  |          |



