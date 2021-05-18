Feature: MLP_24785 Replicate ScanDataStage and ScanInformatica technologies to IDP

  @MLP-24785 @edibus
  Scenario Outline: SC1#-Set the DataSource for ScanInformatica
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                      | bodyFile                                                           | path                                  | response code | response message     | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusInfoDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusInfoDataSource.configurations | 204           |                      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                      |                                                                    |                                       | 200           | EDIBusInfoDataSource |          |

#7148396#
  @edibus @mlp-24785 @webtest @positive @toIDP
  Scenario:SC1#MLP-24785 Verification of replication of ScanInformatica technology from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                             | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_24785_InfoTechnology.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScanInfotoIDP |                                                  | 200           | IDLE             | $.[?(@.configurationName=='ScanInfotoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScanInfotoIDP  |                                                  | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScanInfotoIDP |                                                  | 200           | IDLE             | $.[?(@.configurationName=='ScanInfotoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScanInfotoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ScanInfotoIDP%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 27 items | EDIBUS-I0024 |            |               |
    And user enters the search text "InfaTraining" and clicks on search
    And user performs "facet selection" in "InfaTraining≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Informatica PowerCenter" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service   |
      | Operation |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name    | facet         | Tag                         | fileName               | userTag                 |
      | Default     | Service | Metadata Type | Informatica PowerCenter,ROC | InfaTraining≫Operation | Informatica PowerCenter |
    And user enters the search text "InfaTraining" and clicks on search
    And user performs "facet selection" in "InfaTraining≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | SCANINFO    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) |
    And user enters the search text "InfaTraining" and clicks on search
    And user performs "facet selection" in "InfaTraining≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                                   |
      | AP-DATA      | SCANINFO    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION OR TYPE = DWR_TFM_TASK ) |
    And user enters the search text "InfaTraining" and clicks on search
    And user performs "facet selection" in "InfaTraining≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "EXPTRANS [1549879]" item from search results
    Then user performs click and verify in new window
      | Table          | value      | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops   | FIRST_NAME | verify widget contains | No               |             |
      | Lineage Hops   | FULL_NAME  | verify widget contains | No               |             |
      | Lineage Hops   | LAST_NAME  | click and switch tab   | No               |             |
      | Lineage Source | LAST_NAME  | verify widget contains | No               |             |
      | Lineage Target | FULL_NAME  | verify widget contains | No               |             |
    And user enters the search text "InfaTraining" and clicks on search
    And user performs "facet selection" in "InfaTraining≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "SQ_Shortcut_to_HR_EMPLOYEES_SOURCE [1549881]" item from search results
    Then user performs click and verify in new window
      | Table        | value          | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | COMMISSION_PCT | verify widget contains | No               |             |
      | Lineage Hops | DEPARTMENT_ID  | verify widget contains | No               |             |
      | Lineage Hops | EMAIL          | verify widget contains | No               |             |
      | Lineage Hops | EMPLOYEE_ID    | verify widget contains | No               |             |
      | Lineage Hops | FIRST_NAME     | verify widget contains | No               |             |
      | Lineage Hops | HIRE_DATE      | verify widget contains | No               |             |
      | Lineage Hops | JOB_ID         | verify widget contains | No               |             |
      | Lineage Hops | LAST_NAME      | verify widget contains | No               |             |
      | Lineage Hops | MANAGER_ID     | verify widget contains | No               |             |
      | Lineage Hops | PHONE_NUMBER   | verify widget contains | No               |             |
      | Lineage Hops | SALARY         | verify widget contains | No               |             |
    And user enters the search text "InfaTraining" and clicks on search
    And user performs "facet selection" in "InfaTraining≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "T.Shortcut_to_HR_EMPLOYEES_TARGET [1549882]" item from search results
    Then user performs click and verify in new window
      | Table        | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | EMAIL        | verify widget contains | No               |             |
      | Lineage Hops | EMPLOYEE_ID  | verify widget contains | No               |             |
      | Lineage Hops | FULL_NAME    | verify widget contains | No               |             |
      | Lineage Hops | HIRE_DATE    | verify widget contains | No               |             |
      | Lineage Hops | PHONE_NUMBER | verify widget contains | No               |             |
      | Lineage Hops | SALARY       | verify widget contains | No               |             |
    And user enters the search text "InfaTraining" and clicks on search
    And user performs "facet selection" in "InfaTraining≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "T.Shortcut_to_HR_EMPLOYEES_TARGET [1549882]" item from search results
    Then user performs click and verify in new window
      | Table        | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | EMAIL        | verify widget contains | No               |             |
      | Lineage Hops | EMPLOYEE_ID  | verify widget contains | No               |             |
      | Lineage Hops | FULL_NAME    | verify widget contains | No               |             |
      | Lineage Hops | HIRE_DATE    | verify widget contains | No               |             |
      | Lineage Hops | PHONE_NUMBER | verify widget contains | No               |             |
      | Lineage Hops | SALARY       | verify widget contains | No               |             |


  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScanInfotoIDP% | Analysis |       |       |

  #7148397 #
  @edibus @mlp-24785 @webtest @positive @toIDP
  Scenario Outline:SC2#MLP-24785 Verification of deleting the replicated ScanInformatica items using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                          | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_24785_InfoCleanup.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScanInfotoIDP |                                               | 200           | IDLE             | $.[?(@.configurationName=='ScanInfotoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScanInfotoIDP  |                                               | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScanInfotoIDP |                                               | 200           | IDLE             | $.[?(@.configurationName=='ScanInfotoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScanInfotoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ScanInfotoIDP%" should display below info/error/warning
      | type | logValue         | logCode      | pluginName | removableText |
      | INFO | 28 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name                   | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | InfaTraining≫Operation |             |            |          |


  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScanInfotoIDP% | Analysis |       |       |


  #7148398#
  @edibus @mlp-24785 @webtest @positive @toIDP
  Scenario:SC3#MLP-24785 Verification of replication of ScanInformatica technology with item types from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                        | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_24785_InfoTypes.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScanInfoTypes |                                             | 200           | IDLE             | $.[?(@.configurationName=='ScanInfoTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScanInfoTypes  |                                             | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScanInfoTypes |                                             | 200           | IDLE             | $.[?(@.configurationName=='ScanInfoTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScanInfoTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ScanInfoTypes%" should display below info/error/warning
      | type | logValue               | logCode      | pluginName | removableText |
      | INFO | replication of 3 items | EDIBUS-I0024 |            |               |
    And user enters the search text "InfaTraining≫Operation" and clicks on search
    And user performs "facet selection" in "InfaTraining≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Informatica PowerCenter" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service |
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | Operation |


  Scenario:SC3#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScanInfoTypes% | Analysis |       |       |

    #7149064#
  @edibus @mlp-24785 @webtest @positive @toIDP
  Scenario Outline:SC4#MLP-24781 Verification of deleting the replicated ScanInformatica items with item types using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                               | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                          | idc/EdiBusPayloads/MLP_24785_InfoTypesCleanup.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScanInfoTypes |                                                    | 200           | IDLE             | $.[?(@.configurationName=='ScanInfoTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ScanInfoTypes  |                                                    | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ScanInfoTypes |                                                    | 200           | IDLE             | $.[?(@.configurationName=='ScanInfoTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ScanInfoTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/ScanInfoTypes%" should display below info/error/warning
      | type | logValue        | logCode      | pluginName | removableText |
      | INFO | 3 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name                   | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | InfaTraining≫Operation |             |            |          |


  Scenario:SC4#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/ScanInfoTypes% | Analysis |       |       |

  @MLP-24785 @edibus
  Scenario Outline: SC5#-Set the DataSource for ScanDataStage
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                    | bodyFile                                                           | path                                | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusDSDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusDSDataSource.configurations | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                    |                                                                    |                                     | 200           | EDIBusDSDataSource |          |

    #7149793#
  @edibus @mlp-24785 @webtest @positive @toIDP
  Scenario:SC5#MLP-24785 Verification of replication of ScanDataStage technology from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                         | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_24785_DStageTech.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DataStagetoIDP |                                              | 200           | IDLE             | $.[?(@.configurationName=='DataStagetoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/DataStagetoIDP  |                                              | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DataStagetoIDP |                                              | 200           | IDLE             | $.[?(@.configurationName=='DataStagetoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/DataStagetoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/DataStagetoIDP%" should display below info/error/warning
      | type | logValue                 | logCode      | pluginName | removableText |
      | INFO | replication of 145 items | EDIBUS-I0024 |            |               |
    And user enters the search text "SDA11V08" and clicks on search
    And user performs "facet selection" in "SDA11V08≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DataStage" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ROC" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service   |
      | Operation |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name    | facet         | Tag           | fileName           | userTag   |
      | Default     | Service | Metadata Type | DataStage,ROC | SDA11V08≫Operation | DataStage |
    And user enters the search text "SDA11V08" and clicks on search
    And user performs "facet selection" in "SDA11V08≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Service" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                    |
      | AP-DATA      | DSTAGE      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_SYSTEM ) |
    And user enters the search text "SDA11V08" and clicks on search
    And user performs "facet selection" in "SDA11V08≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user gets the items search count
    And user connects Rochade Server and "compare count" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                                                                                   |
      | AP-DATA      | DSTAGE      | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION OR TYPE = DWR_TFM_TASK ) |
    And user enters the search text "DB2_TR_B2MI_PRM_RGL_SEG" and clicks on search
    And user performs "facet selection" in "SDA11V08≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "DB2_TR_B2MI_PRM_RGL_SEG" item from search results
    Then user performs click and verify in new window
      | Table          | value                                    | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops   | Ln_INPUT_DB2_TR_B2MI_PRM_RGL_SEG.VLR_PRM | verify widget contains | No               |             |
      | Lineage Hops   | Ln_INPUT_DB2_TR_B2MI_PRM_RGL_SEG.ID_RGL  | verify widget contains | No               |             |
      | Lineage Hops   | Ln_INPUT_DB2_TR_B2MI_PRM_RGL_SEG.ID_PRM  | click and switch tab   | No               |             |
      | Lineage Source | ID_PRM                                   | verify widget contains | No               |             |
      | Lineage Target | Ln_Cp_PRM_RGL_SEG_Grp1.ID_PRM            | verify widget contains | No               |             |
    And user enters the search text "Tr_CalcSegPdt_2_a_22" and clicks on search
    And user performs "facet selection" in "SDA11V08≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Operation" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Tr_CalcSegPdt_2_a_22" item from search results
    Then user performs click and verify in new window
      | Table          | value                                               | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops   | Ln_Tr_CalcSegPdt_2_a_22.CD_SEG_B2MI_PDT             | verify widget contains | No               |             |
      | Lineage Hops   | Ln_Tr_CalcSegPdt_2_a_22.NO_CNT_COM                  | verify widget contains | No               |             |
      | Lineage Hops   | Ln_Tr_CalcSegPdt_2_a_22.NO_CNT_DET                  | verify widget contains | No               |             |
      | Lineage Hops   | V0S211-VarCdRgl [Stage Variable]                    | verify widget contains | No               |             |
      | Lineage Hops   | V0S211-VarCdSegN2B2miCtp [Stage Variable]           | verify widget contains | No               |             |
      | Lineage Hops   | Ln_Tr_CalcSegPdt_2_a_22.CD_RGL_SEG_B2MI_PDT         | click and switch tab   | No               |             |
      | Lineage Source | V0S211-VarCdRgl [Stage Variable]                    | verify widget contains | No               |             |
      | Lineage Target | Ln_Fu_CalcSegPdt_1_a_22_ou_Null.CD_RGL_SEG_B2MI_PDT | verify widget contains | No               |             |

  Scenario:SC5#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/DataStagetoIDP% | Analysis |       |       |


     #7149794#
  @edibus @mlp-24785 @webtest @positive @toIDP
  Scenario Outline:SC6#MLP-24785 Verification of deleting the replicated ScanDataStage items using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                            | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_24785_DStageCleanup.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DataStagetoIDP |                                                 | 200           | IDLE             | $.[?(@.configurationName=='DataStagetoIDP')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/DataStagetoIDP  |                                                 | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DataStagetoIDP |                                                 | 200           | IDLE             | $.[?(@.configurationName=='DataStagetoIDP')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/DataStagetoIDP%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/DataStagetoIDP%" should display below info/error/warning
      | type | logValue          | logCode      | pluginName | removableText |
      | INFO | 145 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name               | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | SDA11V08≫Operation |             |            |          |

  Scenario:SC6#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/DataStagetoIDP% | Analysis |       |       |

     #7149797#
  @edibus @mlp-24785 @webtest @positive @toIDP
  Scenario:SC7#MLP-24785 Verification of replication of ScanInformatica technology with item types from EDI to DD
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                          | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_24785_DStageTypes.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DataStageTypes |                                               | 200           | IDLE             | $.[?(@.configurationName=='DataStageTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/DataStageTypes  |                                               | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DataStageTypes |                                               | 200           | IDLE             | $.[?(@.configurationName=='DataStageTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/DataStageTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/DataStageTypes%" should display below info/error/warning
      | type | logValue               | logCode      | pluginName | removableText |
      | INFO | replication of 2 items | EDIBUS-I0024 |            |               |
    And user enters the search text "SDA11V08" and clicks on search
    And user performs "facet selection" in "SDA11V08≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "DataStage" attribute under "Tags" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Service |
    Then user verify "non presence of facets" with following values under "Type" section in item search results page
      | Operation |


  Scenario:SC7#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/DataStageTypes% | Analysis |       |       |

    #7149799#
  @edibus @mlp-24785 @webtest @positive @toIDP
  Scenario Outline:SC8#MLP-24785 Verification of deleting the replicated ScanDatastage items with item types using toIDPCleanup
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                             | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_24785_DSTypesCleanup.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DataStageTypes |                                                  | 200           | IDLE             | $.[?(@.configurationName=='DataStageTypes')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/DataStageTypes  |                                                  | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/DataStageTypes |                                                  | 200           | IDLE             | $.[?(@.configurationName=='DataStageTypes')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/DataStageTypes%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/DataStageTypes%" should display below info/error/warning
      | type | logValue        | logCode      | pluginName | removableText |
      | INFO | 2 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name               | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | SDA11V08≫Operation |             |            |          |


  Scenario:SC8#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/DataStageTypes% | Analysis |       |       |

  @edibus @mlp-24779 @positive @release10.0
  Scenario:MLP-24779 Deleting EDIBus configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                      | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/EDIBus                                |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusInfoDataSource |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/EDIBusDataSource/EDIBusDSDataSource   |      | 204           |                  |          |








