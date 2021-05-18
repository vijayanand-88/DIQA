Feature: MLP_24779 Replicate DB2 and ScanGreenPlum technologies to IDP with standard license

  @MLP-24779 @edibus
  Scenario Outline: SC1#-Set the DataSource for DB2
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                     | bodyFile                                                           | path                                 | response code | response message    | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusDB2DataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusDB2DataSource.configurations | 204           |                     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                     |                                                                    |                                      | 200           | EDIBusDB2DataSource |          |

  #7126923#
  @edibus @mlp-24779 @webtest @positive @toIDP
  Scenario:SC1#MLP-24779 Verification of replication of  DB2 technology from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                           | body                                            | response code | response message | jsonPath                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                     | idc/EdiBusPayloads/MLP_24779_DB2Technology.json | 204           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DB2toIDP |                                                 | 200           | IDLE             | $.[?(@.configurationName=='DB2toIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/DB2toIDP  |                                                 | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DB2toIDP |                                                 | 200           | IDLE             | $.[?(@.configurationName=='DB2toIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/DB2toIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/DB2toIDP%" should display below info/error/warning
      | type | logValue                  | logCode      | pluginName | removableText |
      | INFO | replication of 8262 items | EDIBUS-I0024 |            |               |
    And user enters the search text "DB2" and clicks on search
    And user performs "facet selection" in "GECHCAE-COL1.ASG.COM≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DB2" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Column   |
      | Table    |
      | Schema   |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag     | fileName | userTag |
      | Default     | Database | Metadata Type | DB2,ROC | sample   | DB2     |
    And user enters the search text "DB2" and clicks on search
    And user performs "facet selection" in "GECHCAE-COL1.ASG.COM≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | SCANDB2     | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
    And user enters the search text "DB2" and clicks on search
    And user performs "facet selection" in "GECHCAE-COL1.ASG.COM≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | SCANDB2     | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
    And user enters the search text "DB2" and clicks on search
    And user performs "facet selection" in "GECHCAE-COL1.ASG.COM≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
      | AP-DATA      | SCANDB2     | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
    And user enters the search text "DB2" and clicks on search
    And user performs "facet selection" in "GECHCAE-COL1.ASG.COM≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | SCANDB2     | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA ) |


  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/DB2toIDP% | Analysis |       |       |

  #7126925#bug id:25089#
  @edibus @mlp-24779 @webtest @positive @toIDP
  Scenario Outline:SC2#MLP-24779 Verification of deleting the replicated DB2 items using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                           | body                                         | response code | response message | jsonPath                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                     | idc/EdiBusPayloads/MLP_24779_DB2Cleanup.json | 204           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DB2toIDP |                                              | 200           | IDLE             | $.[?(@.configurationName=='DB2toIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/DB2toIDP  |                                              | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DB2toIDP |                                              | 200           | IDLE             | $.[?(@.configurationName=='DB2toIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/DB2toIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/DB2toIDP%" should display below info/error/warning
      | type | logValue           | logCode      | pluginName | removableText |
      | INFO | 8592 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name                    | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | GECHCAE-COL1.ASG.COM≫DB |             |            |          |


  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/DB2toIDP% | Analysis |       |       |


  #7127015#
  @edibus @mlp-24779 @webtest @positive @toIDP
  Scenario:SC3#MLP-24779 Verification of replication of  DB2 technology with item types from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                             | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_24779_DB2TechnoTypes.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DB2toIDPTypes |                                                  | 200           | IDLE             | $.[?(@.configurationName=='DB2toIDPTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/DB2toIDPTypes  |                                                  | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DB2toIDPTypes |                                                  | 200           | IDLE             | $.[?(@.configurationName=='DB2toIDPTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/DB2toIDPTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/DB2toIDP%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 18 items | EDIBUS-I0024 |            |               |
    And user enters the search text "DB2" and clicks on search
    And user performs "facet selection" in "GECHCAE-COL1.ASG.COM≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DB2" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Schema   |
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | Table  |
      | Column |


  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/DB2toIDPTypes% | Analysis |       |       |

    #7127406#
  @edibus @mlp-24779 @webtest @positive @toIDP
  Scenario Outline:SC4#MLP-24779 Verification of deleting the replicated DB2 items with item types using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                              | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_24779_DB2TypesCleanup.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DB2toIDPTypes |                                                   | 200           | IDLE             | $.[?(@.configurationName=='DB2toIDPTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/DB2toIDPTypes  |                                                   | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DB2toIDPTypes |                                                   | 200           | IDLE             | $.[?(@.configurationName=='DB2toIDPTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/DB2toIDPTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/DB2toIDPTypes%" should display below info/error/warning
      | type | logValue         | logCode      | pluginName | removableText |
      | INFO | 19 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type     | name   | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Database | sample |             |            |          |


  Scenario:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/DB2TypesCleanup% | Analysis |       |       |

  @MLP-24779 @edibus
  Scenario Outline: SC5#-Set the DataSource for ScanGreenPlum
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                     | bodyFile                                                           | path                                 | response code | response message    | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusSGPDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusSGPDataSource.configurations | 204           |                     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                     |                                                                    |                                      | 200           | EDIBusSGPDataSource |          |


     #7127490#
  @edibus @mlp-24779 @webtest @positive @toIDP
  Scenario:SC5#MLP-24779 Verification of replication of SCANGREENPLUM technology from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                            | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_24779_SGPTechnology.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SGPTechno |                                                 | 200           | IDLE             | $.[?(@.configurationName=='SGPTechno')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/SGPTechno  |                                                 | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SGPTechno |                                                 | 200           | IDLE             | $.[?(@.configurationName=='SGPTechno')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/SGPTechno%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/SGPTechno%" should display below info/error/warning
      | type | logValue                   | logCode      | pluginName | removableText |
      | INFO | replication of 29967 items | EDIBUS-I0024 |            |               |
    And user enters the search text "10.216.83.77" and clicks on search
    And user performs "facet selection" in "10.216.83.77≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Greenplum" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Column   |
      | Table    |
      | Schema   |
      | Service  |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag           | fileName | userTag   |
      | Default     | Database | Metadata Type | Greenplum,ROC | onstar   | Greenplum |
    And user enters the search text "10.216.83.77" and clicks on search
    And user performs "facet selection" in "10.216.83.77≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | SCANGP      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
    And user enters the search text "10.216.83.77" and clicks on search
    And user performs "facet selection" in "10.216.83.77≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | SCANGP      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
    And user enters the search text "10.216.83.77" and clicks on search
    And user performs "facet selection" in "10.216.83.77≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
      | AP-DATA      | SCANGP      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
    And user enters the search text "10.216.83.77" and clicks on search
    And user performs "facet selection" in "10.216.83.77≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | SCANGP      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA ) |

  Scenario:SC5#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/SGPTechno% | Analysis |       |       |

     #7127714#bug id:25089#
  @edibus @mlp-24779 @webtest @positive @toIDP
  Scenario Outline:SC6#MLP-24779 Verification of deleting the replicated SCANGREENPLUM items using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                             | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_24779_SGPTechCleanup.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SGPTechno |                                                  | 200           | IDLE             | $.[?(@.configurationName=='SGPTechno')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/SGPTechno  |                                                  | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SGPTechno |                                                  | 200           | IDLE             | $.[?(@.configurationName=='SGPTechno')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/SGPTechno%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/SGPTechno%" should display below info/error/warning
      | type | logValue            | logCode      | pluginName | removableText |
      | INFO | 29964 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name            | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | 10.216.83.77≫DB |             |            |          |

  Scenario:SC6#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/SGPTechno% | Analysis |       |       |


    #7127943#
  @edibus @mlp-24779 @webtest @positive @toIDP
  Scenario:SC7#MLP-24779 Verification of replication of SCANGREENPLUM technology with item types from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                           | body                                             | response code | response message | jsonPath                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                     | idc/EdiBusPayloads/MLP_24779_SGPTechnoTypes.json | 204           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SGPTypes |                                                  | 200           | IDLE             | $.[?(@.configurationName=='SGPTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/SGPTypes  |                                                  | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SGPTypes |                                                  | 200           | IDLE             | $.[?(@.configurationName=='SGPTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/SGPTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/SGPTypes%" should display below info/error/warning
      | type | logValue               | logCode      | pluginName | removableText |
      | INFO | replication of 5 items | EDIBUS-I0024 |            |               |
    And user enters the search text "10.216.83.77" and clicks on search
    And user performs "facet selection" in "10.216.83.77≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Schema   |
      | Service  |
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | Table  |
      | Column |


  Scenario:SC7#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/SGPTypes% | Analysis |       |       |

        #7127943#
  @edibus @mlp-24779 @webtest @positive @toIDP
  Scenario Outline:SC8#MLP-24779 Verification of deleting the replicated SCANGREENPLUM items with item types using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                           | body                                              | response code | response message | jsonPath                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                     | idc/EdiBusPayloads/MLP_24779_SGPTypesCleanup.json | 204           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SGPTypes |                                                   | 200           | IDLE             | $.[?(@.configurationName=='SGPTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/SGPTypes  |                                                   | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SGPTypes |                                                   | 200           | IDLE             | $.[?(@.configurationName=='SGPTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/SGPTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/SGPTypes%" should display below info/error/warning
      | type | logValue        | logCode      | pluginName | removableText |
      | INFO | 4 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name            | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | 10.216.83.77≫DB |             |            |          |

  Scenario:SC8#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/SGPTypes% | Analysis |       |       |

  @edibus @mlp-24779 @positive @release10.0
  Scenario:MLP-24779 Deleting EDIBus configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                     | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus                               |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusDB2DataSource |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusSGPDataSource |      | 204           |                  |          |




