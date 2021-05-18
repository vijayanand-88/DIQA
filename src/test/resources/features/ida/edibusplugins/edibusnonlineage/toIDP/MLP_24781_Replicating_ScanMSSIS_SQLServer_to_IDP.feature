Feature: MLP_24781 Replicate ScanMSSIS and MS SQL Server technologies to IDP with standard license

  @MLP-24781 @edibus
  Scenario Outline: SC1#-Set the DataSource for MS SQL Server
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                     | bodyFile                                                           | path                                 | response code | response message    | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusSqlDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusSqlDataSource.configurations | 204           |                     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                     |                                                                    |                                      | 200           | EDIBusSqlDataSource |          |

  #7130716#bug id:25312#
  @edibus @mlp-24781 @webtest @positive @toIDP
  Scenario:SC1#MLP-24781 Verification of replication of MS SQL Server technology from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                           | body                                            | response code | response message | jsonPath                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                     | idc/EdiBusPayloads/MLP_24781_SQLTechnology.json | 204           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SQLtoIDP |                                                 | 200           | IDLE             | $.[?(@.configurationName=='SQLtoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/SQLtoIDP  |                                                 | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SQLtoIDP |                                                 | 200           | IDLE             | $.[?(@.configurationName=='SQLtoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/SQLtoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/SQLtoIDP%" should display below info/error/warning
      | type | logValue                  | logCode      | pluginName | removableText |
      | INFO | replication of 6179 items | EDIBUS-I0024 |            |               |
    And user enters the search text "HAPP-DBSQLCN02≫DB" and clicks on search
    And user performs "facet selection" in "HAPP-DBSQLCN02≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "SQL Server" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Column   |
      | Table    |
      | Schema   |
      | Service  |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name     | facet         | Tag            | fileName     | userTag    |
      | Default     | Database | Metadata Type | SQL Server,ROC | Conservation | SQL Server |
    And user enters the search text "HAPP-DBSQLCN02≫DB" and clicks on search
    And user performs "facet selection" in "HAPP-DBSQLCN02≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | SCANSQLSRVR | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_COLUMN ) |
    And user enters the search text "HAPP-DBSQLCN02≫DB" and clicks on search
    And user performs "facet selection" in "HAPP-DBSQLCN02≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                           |
      | AP-DATA      | SCANSQLSRVR | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_TABLE_OR_VIEW ) |
    And user enters the search text "HAPP-DBSQLCN02≫DB" and clicks on search
    And user performs "facet selection" in "HAPP-DBSQLCN02≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                      |
      | AP-DATA      | SCANSQLSRVR | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_DATABASE ) |
    And user enters the search text "HAPP-DBSQLCN02≫DB" and clicks on search
    And user performs "facet selection" in "HAPP-DBSQLCN02≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Schema" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | SCANSQLSRVR | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_RDB_SCHEMA ) |


  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/SQLtoIDP% | Analysis |       |       |

  #7130792#
  @edibus @mlp-24781 @webtest @positive @toIDP
  Scenario Outline:SC2#MLP-24781 Verification of deleting the replicated MS SQL Server items using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                           | body                                         | response code | response message | jsonPath                                      |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                     | idc/EdiBusPayloads/MLP_24781_SQLCleanup.json | 204           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SQLtoIDP |                                              | 200           | IDLE             | $.[?(@.configurationName=='SQLtoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/SQLtoIDP  |                                              | 200           |                  |                                               |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SQLtoIDP |                                              | 200           | IDLE             | $.[?(@.configurationName=='SQLtoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/SQLtoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/SQLtoIDP%" should display below info/error/warning
      | type | logValue           | logCode      | pluginName | removableText |
      | INFO | 6322 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name              | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | HAPP-DBSQLCN02≫DB |             |            |          |


  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/SQLtoIDP% | Analysis |       |       |


  #7130796#
  @edibus @mlp-24781 @webtest @positive @toIDP
  Scenario:SC3#MLP-24781 Verification of replication of  MS SQL Server technology with item types from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                             | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_24781_SQLTechnoTypes.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SQLtoIDPTypes |                                                  | 200           | IDLE             | $.[?(@.configurationName=='SQLtoIDPTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/SQLtoIDPTypes  |                                                  | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SQLtoIDPTypes |                                                  | 200           | IDLE             | $.[?(@.configurationName=='SQLtoIDPTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/SQLtoIDPTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/SQLtoIDPTypes%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 44 items | EDIBUS-I0024 |            |               |
    And user enters the search text "HAPP-DBSQLCN02≫DB" and clicks on search
    And user performs "facet selection" in "HAPP-DBSQLCN02≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "SQL Server" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Database |
      | Schema   |
      | Service  |
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | Table  |
      | Column |


  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/SQLtoIDPTypes% | Analysis |       |       |

    #7130804#
  @edibus @mlp-24781 @webtest @positive @toIDP
  Scenario Outline:SC4#MLP-24781 Verification of deleting the replicated MS SQL Server items with item types using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                              | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_24781_SQLTypesCleanup.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SQLtoIDPTypes |                                                   | 200           | IDLE             | $.[?(@.configurationName=='SQLtoIDPTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/SQLtoIDPTypes  |                                                   | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/SQLtoIDPTypes |                                                   | 200           | IDLE             | $.[?(@.configurationName=='SQLtoIDPTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/SQLtoIDPTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/SQLtoIDPTypes%" should display below info/error/warning
      | type | logValue         | logCode      | pluginName | removableText |
      | INFO | 43 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type     | name         | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Database | Conservation |             |            |          |


  Scenario:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/SQLtoIDPTypes% | Analysis |       |       |


  @MLP-24781 @edibus
  Scenario Outline: SC5#-Set the DataSource for ScanMSSIS
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                       | bodyFile                                                           | path                                   | response code | response message      | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusMSSISDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusMSSISDataSource.configurations | 204           |                       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                       |                                                                    |                                        | 200           | EDIBusMSSISDataSource |          |


    #7161600#
  @edibus @mlp-24781 @webtest @positive @toIDP
  Scenario:SC5#MLP-24781 Verification of replication of ScanMSSIS technology from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                              | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_24781_MSSISTechnology.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSIStoIDP |                                                   | 200           | IDLE             | $.[?(@.configurationName=='MSSIStoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MSSIStoIDP  |                                                   | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSIStoIDP |                                                   | 200           | IDLE             | $.[?(@.configurationName=='MSSIStoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MSSIStoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MSSIStoIDP%" should display below info/error/warning
      | type | logValue                 | logCode      | pluginName | removableText |
      | INFO | replication of 146 items | EDIBUS-I0024 |            |               |
    And user enters the search text "DIDROCHADE04V" and clicks on search
    And user performs "facet selection" in "DIDROCHADE04V≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "SSIS" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Operation |
      | Service   |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name    | facet         | Tag      | fileName                | userTag |
      | Default     | Service | Metadata Type | SSIS,ROC | DIDROCHADE04V≫Operation | SSIS    |
    And user enters the search text "DIDROCHADE04V" and clicks on search
    And user performs "facet selection" in "DIDROCHADE04V≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | SCANMSSIS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) |
    And user enters the search text "DIDROCHADE04V" and clicks on search
    And user performs "facet selection" in "DIDROCHADE04V≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                                   |
      | AP-DATA      | SCANMSSIS   | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION OR TYPE = DWR_TFM_TASK ) |
    And user enters the search text "DRV - Add snapshot id" and clicks on search
    And user performs "facet selection" in "DIDROCHADE04V≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DRV - Add snapshot id" item from search results
    And user "widget not present" on "Lineage Hops" in Item view page


  Scenario:SC5#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MSSIStoIDP% | Analysis |       |       |

#7161601#
  @edibus @mlp-24781 @webtest @positive @toIDP
  Scenario Outline:SC6#MLP-24781 Verification of deleting the replicated ScanMSSIS items using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                             | body                                           | response code | response message | jsonPath                                        |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                       | idc/EdiBusPayloads/MLP_24781_MSSISCleanup.json | 204           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSIStoIDP |                                                | 200           | IDLE             | $.[?(@.configurationName=='MSSIStoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MSSIStoIDP  |                                                | 200           |                  |                                                 |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSIStoIDP |                                                | 200           | IDLE             | $.[?(@.configurationName=='MSSIStoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MSSIStoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MSSIStoIDP%" should display below info/error/warning
      | type | logValue           | logCode      | pluginName | removableText |
      | INFO | 1111 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name                    | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | DIDROCHADE04V≫Operation |             |            |          |


  Scenario:SC6#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MSSIStoIDP% | Analysis |       |       |

  #7161603#
  @edibus @mlp-24781 @webtest @positive @toIDP
  Scenario:SC7#MLP-24781 Verification of replication of ScanMSSIS technology with item types from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                             | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_24781_MSSISTechTypes.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSISTech |                                                  | 200           | IDLE             | $.[?(@.configurationName=='MSSISTech')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MSSISTech  |                                                  | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSISTech |                                                  | 200           | IDLE             | $.[?(@.configurationName=='MSSISTech')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MSSISTech%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MSSISTech%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 13 items | EDIBUS-I0024 |            |               |
    And user enters the search text "DIDROCHADE04V" and clicks on search
    And user performs "facet selection" in "DIDROCHADE04V≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "SSIS" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service |
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | Operation |


  Scenario:SC7#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MSSISTech% | Analysis |       |       |

#7161604#
  @edibus @mlp-24781 @webtest @positive @toIDP
  Scenario Outline:SC8#MLP-24781 Verification of deleting the replicated ScanMSSIS items with item types using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                            | body                                                | response code | response message | jsonPath                                       |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/MLP_24781_MSSISTypesCleanup.json | 204           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSISTech |                                                     | 200           | IDLE             | $.[?(@.configurationName=='MSSISTech')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/MSSISTech  |                                                     | 200           |                  |                                                |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/MSSISTech |                                                     | 200           | IDLE             | $.[?(@.configurationName=='MSSISTech')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/MSSISTech%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/MSSISTech%" should display below info/error/warning
      | type | logValue         | logCode      | pluginName | removableText |
      | INFO | 13 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name                    | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | DIDROCHADE04V≫Operation |             |            |          |


  Scenario:SC8#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                   | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/MSSISTech% | Analysis |       |       |

  @edibus @mlp-24779 @positive @release10.0
  Scenario:MLP-24779 Deleting EDIBus configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                       | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus                                 |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusSqlDataSource   |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusMSSISDataSource |      | 204           |                  |          |








