Feature: MLP_24787_28343 Replicate Sybase and MicroStrategy technologies to IDP

  @MLP-24787 @edibus
  Scenario Outline: SC1#-Set the DataSource for Sybase
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                        | bodyFile                                                           | path                                    | response code | response message       | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusSybaseDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusSybaseDataSource.configurations | 204           |                        |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                        |                                                                    |                                         | 200           | EDIBusSybaseDataSource |          |

#7173607#7177357#7201804#
  @edibus @mlp-24787 @mlp-23048 @webtest @positive @toIDP
  Scenario:SC1#MLP-24787_23048_Verification of replication of Sybase technology from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                               | response code | response message | jsonPath                                         |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                        | idc/EdiBusPayloads/MLP_24787_SybaseTechnology.json | 204           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SybasetoIDP |                                                    | 200           | IDLE             | $.[?(@.configurationName=='SybasetoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/SybasetoIDP  |                                                    | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SybasetoIDP |                                                    | 200           | IDLE             | $.[?(@.configurationName=='SybasetoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/SybasetoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
      | Warnings          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/SybasetoIDP%" should display below info/error/warning
      | type | logValue                  | logCode      | pluginName | removableText |
      | INFO | replication of 2902 items | EDIBUS-I0024 |            |               |
    And user enters the search text "DIGPDB01V" and clicks on search
    And user performs "facet selection" in "DIGPDB01V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Sybase/SAP ASE" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Column   |
      | Table    |
      | Schema   |
      | Service  |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag                | fileName  | userTag        |
      | Default     | Database | Metadata Type | Sybase/SAP ASE,ROC | sybmgmtdb | Sybase/SAP ASE |
    And user enters the search text "DIGPDB01V" and clicks on search
    And user performs "facet selection" in "DIGPDB01V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | SYBASE      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
    And user enters the search text "DIGPDB01V" and clicks on search
    And user performs "facet selection" in "DIGPDB01V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | SYBASE      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
    And user enters the search text "DIGPDB01V" and clicks on search
    And user performs "facet selection" in "DIGPDB01V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
      | AP-DATA      | SYBASE      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
    And user enters the search text "DIGPDB01V" and clicks on search
    And user performs "facet selection" in "DIGPDB01V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | SYBASE      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA ) |
    And user enters the search text "SybaseDataTypes" and clicks on search
    And user performs "facet selection" in "$$SybaseDataTypes [DataPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DataPackage" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                     |
      | AP-DATA      | SYBASE      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_PACKAGE ) |


  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                     | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/SybasetoIDP% | Analysis |       |       |


#bug id:26921#7173608#7177358#
  @edibus @mlp-24787 @mlp-23048 @webtest @positive @toIDP
  Scenario Outline:SC2#MLP-24787_23048_Verification of deleting the replicated Sybase items using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                            | response code | response message | jsonPath                                         |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                        | idc/EdiBusPayloads/MLP_24787_SybaseCleanup.json | 204           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SybasetoIDP |                                                 | 200           | IDLE             | $.[?(@.configurationName=='SybasetoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/SybasetoIDP  |                                                 | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SybasetoIDP |                                                 | 200           | IDLE             | $.[?(@.configurationName=='SybasetoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/SybasetoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
      | Warnings          | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/SybasetoIDP%" should display below info/error/warning
      | type | logValue           | logCode      | pluginName | removableText |
      | INFO | 2919 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name         | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | DIGPDB01V≫DB |             |            |          |

  #7201807#
  Scenario Outline:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                     | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/SybasetoIDP% | Analysis |       |       |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type | name | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Tag  | ROC  |             |            |          |

#7173609#7177354#7201814#
  @edibus @mlp-24787 @mlp-23048 @webtest @positive @toIDP
  Scenario:SC3#MLP-24787_MLP_23048_Verification of replication of Sybase technology with item types from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                          | response code | response message | jsonPath                                         |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                        | idc/EdiBusPayloads/MLP_24787_SybaseTypes.json | 204           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SybaseTypes |                                               | 200           | IDLE             | $.[?(@.configurationName=='SybaseTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/SybaseTypes  |                                               | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SybaseTypes |                                               | 200           | IDLE             | $.[?(@.configurationName=='SybaseTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/SybaseTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
      | Warnings          | 1             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/SybaseTypes%" should display below info/error/warning
      | type | logValue                                                                                                 | logCode      | pluginName | removableText |
      | INFO | replication of 42 items                                                                                  | EDIBUS-I0024 |            |               |
      | WARN | Not all scope types were defined for these types to be replicated: "[DWR_RDB_DATABASE, DWR_RDB_SCHEMA]". | EDIBUS-W0202 |            |               |
    And user enters the search text "DIGPDB01V" and clicks on search
    And user performs "facet selection" in "DIGPDB01V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Sybase/SAP ASE" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Schema   |
      | Service  |
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | Table  |
      | Column |
    And user enters the search text "DIGPDB01V" and clicks on search
    And user performs "facet selection" in "DIGPDB01V≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Schema   |
      | Service  |
      | Table    |
      | Column   |

  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                     | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/SybaseTypes% | Analysis |       |       |

#7173610#7177356#
  @edibus @mlp-24787 @mlp-23048 @webtest @positive @toIDP
  Scenario Outline:SC4#MLP-24787_MLP_23048_Verification of deleting the replicated Sybase items with item types using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                              | body                                                 | response code | response message | jsonPath                                         |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                        | idc/EdiBusPayloads/MLP_24787_SybaseTypesCleanup.json | 204           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SybaseTypes |                                                      | 200           | IDLE             | $.[?(@.configurationName=='SybaseTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/SybaseTypes  |                                                      | 200           |                  |                                                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SybaseTypes |                                                      | 200           | IDLE             | $.[?(@.configurationName=='SybaseTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/SybaseTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
      | Warnings          | 1             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/SybaseTypes%" should display below info/error/warning
      | type | logValue                                                                                                 | logCode      | pluginName | removableText |
      | INFO | 42 items deleted                                                                                         | EDIBUS-I0024 |            |               |
      | WARN | Not all scope types were defined for these types to be replicated: "[DWR_RDB_DATABASE, DWR_RDB_SCHEMA]". | EDIBUS-W0202 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name         | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | DIGPDB01V≫DB |             |            |          |

#7201815#
  Scenario Outline:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                     | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/SybaseTypes% | Analysis |       |       |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type | name | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Tag  | ROC  |             |            |          |


  @MLP-24787 @edibus
  Scenario Outline: SC5#-Set the DataSource for MicroStrategy
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                           | path                                   | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusMicroDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusMicroDataSource.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                       |                                                                    |                                        | 200           | EDIBusMicroDataSource |          |

    #7173611#
  @edibus @mlp-24787 @webtest @positive @toIDP
  Scenario:SC5#MLP-24787 Verification of replication of MicroStrategy technology from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                              | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_24787_MicroTechnology.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MicrotoIDP |                                                   | 200           | IDLE             | $.[?(@.configurationName=='MicrotoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MicrotoIDP  |                                                   | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MicrotoIDP |                                                   | 200           | IDLE             | $.[?(@.configurationName=='MicrotoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MicrotoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MicrotoIDP%" should display below info/error/warning
      | type | logValue                  | logCode      | pluginName | removableText |
      | INFO | replication of 4702 items | EDIBUS-I0024 |            |               |
    And user enters the search text "MicroStrategy" and clicks on search
    And user performs "facet selection" in "MicroStrategy Secure Enterprise [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "MicroStrategy" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Measure          |
      | AggregationLevel |
      | Dimension        |
      | OlapSchema       |
      | Hierarchy        |
      | OlapPackage      |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name        | facet         | Tag           | fileName                        | userTag       |
      | Default     | OlapPackage | Metadata Type | MicroStrategy | MicroStrategy Secure Enterprise | MicroStrategy |
    And user enters the search text "MicroStrategy" and clicks on search
    And user performs "facet selection" in "MicroStrategy Secure Enterprise [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Measure" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | MICROSTAT   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_MEMBER ) |
    And user enters the search text "MicroStrategy" and clicks on search
    And user performs "facet selection" in "MicroStrategy Secure Enterprise [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "AggregationLevel" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                   |
      | AP-DATA      | MICROSTAT   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_LEVEL ) |
    And user enters the search text "MicroStrategy" and clicks on search
    And user performs "facet selection" in "MicroStrategy Secure Enterprise [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Dimension" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | MICROSTAT   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_DIMENSION ) |
    And user enters the search text "MicroStrategy" and clicks on search
    And user performs "facet selection" in "MicroStrategy Secure Enterprise [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "OlapSchema" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                         |
      | AP-DATA      | MICROSTAT   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_OLAP_SCHEMA ) |
    And user enters the search text "MicroStrategy" and clicks on search
    And user performs "facet selection" in "MicroStrategy Secure Enterprise [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Hierarchy" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                       |
      | AP-DATA      | MICROSTAT   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_HIERARCHY ) |
    And user enters the search text "MicroStrategy" and clicks on search
    And user performs "facet selection" in "MicroStrategy Secure Enterprise [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "OlapPackage" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                          |
      | AP-DATA      | MICROSTAT   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_ANL_OLAP_PACKAGE ) |
    And user enters the search text "Ruleset" and clicks on search
    And user performs "facet selection" in "MicroStrategy Secure Enterprise [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Dimension" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Ruleset" item from search results
    Then user performs click and verify in new window
      | Table          | value                                   | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops   | Propensity of Telco Churn               | verify widget contains | No               |             |
      | Lineage Hops   | TelcoChurn (Ruleset) (Confidence)       | verify widget contains | No               |             |
      | Lineage Hops   | TelcoChurn (Ruleset) (Scoring)          | click and switch tab   | No               |             |
      | Lineage Source | Household Count                         | verify widget contains | No               |             |
      | Lineage Source | Income Bracket                          | verify widget contains | No               |             |
      | Lineage Source | Phone Usage                             | verify widget contains | No               |             |
      | Lineage Target | TelcoChurn (Ruleset) (Scoring) [Metric] | verify widget contains | No               |             |

  Scenario:SC5#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MicrotoIDP% | Analysis |       |       |

     #7173612#
  @edibus @mlp-24787 @webtest @positive @toIDP
  Scenario Outline:SC6#MLP-24787 Verification of deleting the replicated MicroStrategy items using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                           | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_24787_MicroCleanup.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MicrotoIDP |                                                | 200           | IDLE             | $.[?(@.configurationName=='MicrotoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MicrotoIDP  |                                                | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MicrotoIDP |                                                | 200           | IDLE             | $.[?(@.configurationName=='MicrotoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MicrotoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MicrotoIDP%" should display below info/error/warning
      | type | logValue           | logCode      | pluginName | removableText |
      | INFO | 4702 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type        | name                            | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | OlapPackage | MicroStrategy Secure Enterprise |             |            |          |


  Scenario:SC6#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MicrotoIDP% | Analysis |       |       |

    #7173613#
  @edibus @mlp-24787 @webtest @positive @toIDP
  Scenario:SC7#MLP-24787 Verification of replication of MicroStrategy technology with item types from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                         | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_24787_MicroTypes.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MicroTypes |                                              | 200           | IDLE             | $.[?(@.configurationName=='MicroTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MicroTypes  |                                              | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MicroTypes |                                              | 200           | IDLE             | $.[?(@.configurationName=='MicroTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MicroTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MicroTypes%" should display below info/error/warning
      | type | logValue                 | logCode      | pluginName | removableText |
      | INFO | replication of 158 items | EDIBUS-I0024 |            |               |
    And user enters the search text "MicroStrategy" and clicks on search
    And user performs "facet selection" in "MicroStrategy Secure Enterprise [OlapPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "MicroStrategy" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | OlapSchema  |
      | OlapPackage |
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | Measure          |
      | AggregationLevel |
      | Dimension        |
      | Hierarchy        |


  Scenario:SC7#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MicroTypes% | Analysis |       |       |

#7173614#
  @edibus @mlp-24787 @webtest @positive @toIDP
  Scenario Outline:SC8#MLP-24787 Verification of deleting the replicated MicroStrategy items with item types using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                                | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_24787_MicroTypesCleanup.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MicroTypes |                                                     | 200           | IDLE             | $.[?(@.configurationName=='MicroTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MicroTypes  |                                                     | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MicroTypes |                                                     | 200           | IDLE             | $.[?(@.configurationName=='MicroTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MicroTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MicroTypes%" should display below info/error/warning
      | type | logValue          | logCode      | pluginName | removableText |
      | INFO | 158 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type        | name                            | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | OlapPackage | MicroStrategy Secure Enterprise |             |            |          |


  Scenario:SC8#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MicroTypes% | Analysis |       |       |

  @edibus @mlp-24787 @positive @release10.0
  Scenario:MLP-24787 Deleting EDIBus configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                        | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus                                  |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusSybaseDataSource |      | 204           |                  |          |





