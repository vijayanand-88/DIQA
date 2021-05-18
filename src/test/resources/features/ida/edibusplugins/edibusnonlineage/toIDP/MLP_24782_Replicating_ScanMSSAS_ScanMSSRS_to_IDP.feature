Feature: MLP_24782 Replicate ScanMSSAS and ScanMSSRS technologies to IDP with standard license

  @MLP-24782 @edibus
  Scenario Outline: SC1#-Set the DataSource for ScanMSSAS
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                           | path                                   | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusMSSASDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusMSSASDataSource.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                       |                                                                    |                                        | 200           | EDIBusMSSASDataSource |          |

  #7163591#
  @edibus @mlp-24782 @webtest @positive @toIDP
  Scenario:SC1#MLP-24782 Verification of replication of ScanMSSAS technology from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                              | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_24782_MSSASTechnology.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSAStoIDP |                                                   | 200           | IDLE             | $.[?(@.configurationName=='MSSAStoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MSSAStoIDP  |                                                   | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSAStoIDP |                                                   | 200           | IDLE             | $.[?(@.configurationName=='MSSAStoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MSSAStoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MSSAStoIDP%" should display below info/error/warning
      | type | logValue                 | logCode      | pluginName | removableText |
      | INFO | replication of 162 items | EDIBUS-I0024 |            |               |
    And user enters the search text "Automatically generated" and clicks on search
    And user performs "facet selection" in "Automatically generated [AS]≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Automatically generated [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "SSAS" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Column           |
      | Dimension        |
      | Measure          |
      | Table            |
      | AggregationLevel |
      | Hierarchy        |
      | OlapSchema       |
      | Database         |
      | OlapPackage      |
      | Schema           |
      | Service          |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name    | facet         | Tag      | fileName                        | userTag |
      | Default     | Service | Metadata Type | SSAS,ROC | Automatically generated [AS]≫DB | SSAS    |
    And user enters the search text "Automatically generated" and clicks on search
    And user performs "facet selection" in "Automatically generated [AS]≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | SCANMSSAS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DB_SYSTEM ) |
    And user enters the search text "Automatically generated" and clicks on search
    And user performs "facet selection" in "Automatically generated [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "OlapPackage" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                          |
      | AP-DATA      | SCANMSSAS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_OLAP_PACKAGE ) |
    And user enters the search text "Automatically generated" and clicks on search
    And user performs "facet selection" in "Automatically generated [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "OlapSchema" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
      | AP-DATA      | SCANMSSAS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_OLAP_SCHEMA ) |
    And user enters the search text "Automatically generated" and clicks on search
    And user performs "facet selection" in "Automatically generated [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Hierarchy" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | SCANMSSAS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_HIERARCHY ) |
    And user enters the search text "Automatically generated" and clicks on search
    And user performs "facet selection" in "Automatically generated [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "AggregationLevel" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
      | AP-DATA      | SCANMSSAS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_LEVEL ) |
    And user enters the search text "Automatically generated" and clicks on search
    And user performs "facet selection" in "Automatically generated [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Dimension" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | SCANMSSAS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_DIMENSION ) |
    And user enters the search text "Automatically generated" and clicks on search
    And user performs "facet selection" in "Automatically generated [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Measure" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | SCANMSSAS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_MEMBER ) |
    And user enters the search text "Automatically generated" and clicks on search
    And user performs "facet selection" in "Automatically generated [AS]≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
      | AP-DATA      | SCANMSSAS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
    And user enters the search text "Automatically generated" and clicks on search
    And user performs "facet selection" in "Automatically generated [AS]≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | SCANMSSAS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
    And user enters the search text "Automatically generated" and clicks on search
    And user performs "facet selection" in "Automatically generated [AS]≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | SCANMSSAS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
    And user enters the search text "Date [Table]" and clicks on search
    And user performs "facet selection" in "Automatically generated [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Dimension" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Date [Table]" item from search results
    And user "widget not present" on "Lineage Hops" in Item view page


  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MSSAStoIDP% | Analysis |       |       |

  #7163592#bug id:25089#
  @edibus @mlp-24782 @webtest @positive @toIDP
  Scenario Outline:SC2#MLP-24782 Verification of deleting the replicated ScanMSSAS items using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                           | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_24782_MSSASCleanup.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSAStoIDP |                                                | 200           | IDLE             | $.[?(@.configurationName=='MSSAStoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MSSAStoIDP  |                                                | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSAStoIDP |                                                | 200           | IDLE             | $.[?(@.configurationName=='MSSAStoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MSSAStoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MSSAStoIDP%" should display below info/error/warning
      | type | logValue          | logCode      | pluginName | removableText |
      | INFO | 162 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name                            | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | Automatically generated [AS]≫DB |             |            |          |


  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MSSAStoIDP% | Analysis |       |       |

  #7163593#
  @edibus @mlp-24782 @webtest @positive @toIDP
  Scenario:SC3#MLP-24782 Verification of replication of ScanMSSAS technology with item types from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                             | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_24782_MSSASTechTypes.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSASTypes |                                                  | 200           | IDLE             | $.[?(@.configurationName=='MSSASTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MSSASTypes  |                                                  | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSASTypes |                                                  | 200           | IDLE             | $.[?(@.configurationName=='MSSASTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MSSASTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MSSASTypes%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 10 items | EDIBUS-I0024 |            |               |
    And user enters the search text "Automatically generated" and clicks on search
    And user performs "facet selection" in "Automatically generated [AS]≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "SSAS" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Table    |
      | Database |
      | Schema   |
      | Service  |
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | Column |


  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MSSASTypes% | Analysis |       |       |

#7163621#
  @edibus @mlp-24782 @webtest @positive @toIDP
  Scenario Outline:SC4#MLP-24782 Verification of deleting the replicated ScanMSSAS items with item types using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                                | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_24782_MSSASTypesCleanup.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSASTypes |                                                     | 200           | IDLE             | $.[?(@.configurationName=='MSSASTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MSSASTypes  |                                                     | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSASTypes |                                                     | 200           | IDLE             | $.[?(@.configurationName=='MSSASTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MSSASTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MSSASTypes%" should display below info/error/warning
      | type | logValue        | logCode      | pluginName | removableText |
      | INFO | 10 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name                            | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | Automatically generated [AS]≫DB |             |            |          |

  Scenario:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MSSASTypes% | Analysis |       |       |

  @MLP-24782 @edibus
  Scenario Outline: SC5#-Set the DataSource for ScanMSSRS
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                           | path                                   | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusMSSRSDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusMSSRSDataSource.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                       |                                                                    |                                        | 200           | EDIBusMSSRSDataSource |          |

  #7163622#
  @edibus @mlp-24782 @webtest @positive @toIDP
  Scenario:SC5#MLP-24782 Verification of replication of ScanMSSRS technology from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                              | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_24782_MSSRSTechnology.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSRStoIDP |                                                   | 200           | IDLE             | $.[?(@.configurationName=='MSSRStoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MSSRStoIDP  |                                                   | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSRStoIDP |                                                   | 200           | IDLE             | $.[?(@.configurationName=='MSSRStoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MSSRStoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MSSRStoIDP%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 78 items | EDIBUS-I0024 |            |               |
    And user enters the search text "DECHEQADI02V" and clicks on search
    And user performs "facet selection" in "DECHEQADI02V [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "SSRS" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | DataField     |
      | DataType      |
      | Report        |
      | ReportSchema  |
      | ReportPackage |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name          | facet         | Tag      | fileName     | userTag |
      | Default     | ReportPackage | Metadata Type | SSRS,ROC | DECHEQADI02V | SSRS    |
    And user enters the search text "DECHEQADI02V" and clicks on search
    And user performs "facet selection" in "DECHEQADI02V [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DataField" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | SCANMSSRS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_RPT_FIELD ) |
    And user enters the search text "DECHEQADI02V" and clicks on search
    And user performs "facet selection" in "DECHEQADI02V [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DataType" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | SCANMSSRS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_RPT_STRUCTURE ) |
    And user enters the search text "DECHEQADI02V" and clicks on search
    And user performs "facet selection" in "DECHEQADI02V [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DataType" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | SCANMSSRS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_REPORT ) |
    And user enters the search text "DECHEQADI02V" and clicks on search
    And user performs "facet selection" in "DECHEQADI02V [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "ReportSchema" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                        |
      | AP-DATA      | SCANMSSRS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_RPT_SCHEMA ) |
    And user enters the search text "DECHEQADI02V" and clicks on search
    And user performs "facet selection" in "DECHEQADI02V [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "ReportPackage" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
      | AP-DATA      | SCANMSSRS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_RPT_PACKAGE ) |

  Scenario:SC5#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MSSRStoIDP% | Analysis |       |       |

    #7163624#
  @edibus @mlp-24782 @webtest @positive @toIDP
  Scenario Outline:SC6#MLP-24782 Verification of deleting the replicated ScanMSSRS items using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                           | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_24782_MSSRSCleanup.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSRStoIDP |                                                | 200           | IDLE             | $.[?(@.configurationName=='MSSRStoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MSSRStoIDP  |                                                | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSRStoIDP |                                                | 200           | IDLE             | $.[?(@.configurationName=='MSSRStoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MSSRStoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MSSRStoIDP%" should display below info/error/warning
      | type | logValue          | logCode      | pluginName | removableText |
      | INFO | 117 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type          | name         | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | ReportPackage | DECHEQADI02V |             |            |          |

  Scenario:SC6#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MSSRStoIDP% | Analysis |       |       |

    #7163626#7168358#
  @edibus @mlp-24782 @webtest @positive @toIDP
  Scenario:SC7#MLP-24782_MLP_25515_Verification of replication of ScanMSSRS technology with item types from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                             | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_24782_MSSRSTechTypes.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSRSTypes |                                                  | 200           | IDLE             | $.[?(@.configurationName=='MSSRSTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MSSRSTypes  |                                                  | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSRSTypes |                                                  | 200           | IDLE             | $.[?(@.configurationName=='MSSRSTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MSSRSTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MSSRSTypes%" should display below info/error/warning
      | type | logValue               | logCode      | pluginName | removableText |
      | INFO | replication of 7 items | EDIBUS-I0024 |            |               |
    And user enters the search text "DECHEQADI02V" and clicks on search
    And user performs "facet selection" in "DECHEQADI02V [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "SSRS" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | ReportPackage |
      | ReportSchema  |
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | DataField |
      | DataType  |
      | Report    |
    And user verifies "asg_createdat" column is updated with "targetID"
      | database      | catalogName | columnName | type          |
      | APPDBPOSTGRES | Default     | Q4_Testing | ReportPackage |
    And user verifies "asg_replicatedat" column is updated with "targetID"
      | database      | catalogName | columnName | type          |
      | APPDBPOSTGRES | Default     | Q4_Testing | ReportPackage |
    And user verifies "asg_modifiedat" column is updated with "targetID"
      | database      | catalogName | columnName | type          |
      | APPDBPOSTGRES | Default     | Q4_Testing | ReportPackage |
    And user verifies "asg_createdby" column is updated with "ServiceID"
      | database      | catalogName | columnName | type          |
      | APPDBPOSTGRES | Default     | Q4_Testing | ReportPackage |
    And user verifies "asg_replicatedby" column is updated with "ServiceID"
      | database      | catalogName | columnName | type          |
      | APPDBPOSTGRES | Default     | Q4_Testing | ReportPackage |
    And user verifies "asg_modifiedby" column is updated with "ServiceID"
      | database      | catalogName | columnName | type          |
      | APPDBPOSTGRES | Default     | Q4_Testing | ReportPackage |


  Scenario:SC7#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MSSRSTypes% | Analysis |       |       |

  #7163627#
  @edibus @mlp-24782 @webtest @positive @toIDP
  Scenario Outline:SC8#MLP-24782 Verification of deleting the replicated ScanMSSRS items with item types using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                                | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_24782_MSSRSTypesCleanup.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSRSTypes |                                                     | 200           | IDLE             | $.[?(@.configurationName=='MSSRSTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MSSRSTypes  |                                                     | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSRSTypes |                                                     | 200           | IDLE             | $.[?(@.configurationName=='MSSRSTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MSSRSTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MSSRSTypes%" should display below info/error/warning
      | type | logValue        | logCode      | pluginName | removableText |
      | INFO | 7 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type          | name         | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | ReportPackage | DECHEQADI02V |             |            |          |

  Scenario:SC8#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MSSRSTypes% | Analysis |       |       |


  @edibus @mlp-24779 @positive @release10.0
  Scenario:MLP-24779 Deleting EDIBus configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus                                 |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusMSSASDataSource |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusMSSRSDataSource |      | 204           |                  |          |







