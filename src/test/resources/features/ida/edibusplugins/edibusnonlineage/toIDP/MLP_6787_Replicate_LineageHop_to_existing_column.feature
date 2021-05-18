#Feature: MLP-6787 Replicating LineageHop to EDI with standard license
# Descoped since DD to EDI flow is disabled
#  @edibus @mlp-6787 @webtest @positive @release10.0 @toIDP
#  Scenario:SC1#MLP-6787_Run full replication from EDI to IDX
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                             |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_6787_EDITOIDXConfig.json | 204           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/LineageEDItoIDX |                                                 | 200           | IDLE             | $.[?(@.configurationName=='LineageEDItoIDX')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/LineageEDItoIDX  |                                                 | 200           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/LineageEDItoIDX |                                                 | 200           | IDLE             | $.[?(@.configurationName=='LineageEDItoIDX')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "LineageEDItoIDX" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/LineageEDItoIDX%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#
#  Scenario Outline:SC1#user retrieves Service item ID
#    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
#    Examples:
#      | database      | retrive | catalog | type    | name           | asg_scopeid | targetFile                          | jsonpath          |
#      | APPDBPOSTGRES | ID      | Default | Service | DBSystemOne≫DB |             | response/edibus/actual/itemIds.json | $..has_Service.id |
#
#  Scenario Outline:SC1#Create Service item
#    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
#    Examples:
#      | contentType      | acceptType       | type | url                                                                  | body                                                    | responseCode | inputJson         | inputFile                           | responseMessage |
#      | application/json | application/json | Post | items/Default/Default.Service:::dynamic/operations?allowUpdate=false | idc/EdiBusPayloads/MLP-6787_Item_OperationCreation.json | 200          | $..has_Service.id | response/edibus/actual/itemIds.json |                 |
#
#
#  Scenario Outline:SC1#user retrieves Operation item ID
#    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
#    Examples:
#      | database      | retrive | catalog | type      | name         | asg_scopeid | targetFile                          | jsonpath          |
#      | APPDBPOSTGRES | ID      | Default | Operation | IDCOperation |             | response/edibus/actual/itemIds.json | $..has_Service.id |
#
#  Scenario Outline:SC1#Create Operation item
#    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
#    Examples:
#      | contentType      | acceptType       | type | url                                                                    | body                                              | responseCode | inputJson         | inputFile                           | responseMessage |
#      | application/json | application/json | Post | items/Default/Default.Operation:::dynamic/operations?allowUpdate=false | idc/EdiBusPayloads/MLP-6787_Item_HopCreation.json | 200          | $..has_Service.id | response/edibus/actual/itemIds.json |                 |
#
#
#  Scenario Outline: user updates the ID in json
#    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
#    Examples:
#      | database      | retrive      | catalog | type       | name      | asg_scopeid | targetFile                                                  | jsonpath                                       |
#      | APPDBPOSTGRES | JsonIDUpdate | Default | LineageHop | HopEDI    |             | payloads/idc/EdiBusPayloads/MLP-6787_Item_EdgeCreation.json | $..[?(@.edgelabel=='lineageTo')]['sourceId']   |
#      | APPDBPOSTGRES | JsonIDUpdate | Default | LineageHop | HopEDI    |             | payloads/idc/EdiBusPayloads/MLP-6787_Item_EdgeCreation.json | $..[?(@.edgelabel=='lineageFrom')]['sourceId'] |
#      | APPDBPOSTGRES | JsonIDUpdate | Default | Column     | ColumnOne |             | payloads/idc/EdiBusPayloads/MLP-6787_Item_EdgeCreation.json | $..[?(@.edgelabel=='lineageFrom')]['targetId'] |
#      | APPDBPOSTGRES | JsonIDUpdate | Default | Column     | ColumnTwo |             | payloads/idc/EdiBusPayloads/MLP-6787_Item_EdgeCreation.json | $..[?(@.edgelabel=='lineageTo')]['targetId']   |
#
#  Scenario Outline:SC1#Link lineage item
#    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
#    Examples:
#      | contentType      | acceptType       | type | url           | body                                               | responseCode | inputJson         | inputFile                           | responseMessage |
#      | application/json | application/json | Post | edges/Default | idc/EdiBusPayloads/MLP-6787_Item_EdgeCreation.json | 200          | $..has_Service.id | response/edibus/actual/itemIds.json |                 |
#
#
#  @edibus @mlp-6787 @webtest @positive @release10.0 @toIDP
#  Scenario:SC1#MLP-6787_Verification of lineage from EDI to IDX
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "IDCOperation" and clicks on search
#    And user performs "item click" on "IDCOperation" item from search results
#    Then user performs click and verify in new window
#      | Table        | value  | Action               | RetainPrevwindow | indexSwitch |
#      | Lineage Hops | HopEDI | click and switch tab | No               |             |
#    Then user performs click and verify in new window
#      | Table          | value     | Action                 | RetainPrevwindow | indexSwitch |
#      | Lineage Source | ColumnOne | verify widget contains | No               |             |
#      | Lineage Target | ColumnTwo | verify widget contains | No               |             |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                      | response code | response message | jsonPath                                             |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_6787_IDXTOEDI.json | 204           |                  |                                                      |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDILineage  |                                           | 200           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDILineage |                                           | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDILineage')].status |
#    And user enters the search text "IDXtoEDILineage" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDILineage%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user connects Rochade Server and "verifies" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                | itemCount |
#      | AP-DATA      | DATABASE    | 1.0                | (XNAME * *  ~/ @*IDCOPERATION@* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK ) | 1         |
#    And user connects Rochade Server and "verifies" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                        | itemCount |
#      | AP-DATA      | DATABASE    | 1.0                | (XNAME * *  ~/ @*HOPEDI@* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION_MAP ) | 0         |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                                                                                                                                   |
#      | AP-DATA      | DATABASE    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_IDC_REPLICATIONDATE OR TYPE = DWR_TFM_TASK OR TYPE = DWR_TFM_TRANSFORMATION_MAP OR TYPE = DWR_TFM_SYSTEM OR TYPE = DWR_TFM_TRANSFORMATION ) |
#
#  Scenario:SC1#Cleanup
#    Given user update the json file "idc/EdiBusPayloads/MLP_6787_EDITOIDXConfig.json" file for following values
#      | jsonPath    | jsonValues   |
#      | $..function | toIDPCleanup |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                             |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_6787_EDITOIDXConfig.json | 204           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/LineageEDItoIDX |                                                 | 200           | IDLE             | $.[?(@.configurationName=='LineageEDItoIDX')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/LineageEDItoIDX  |                                                 | 200           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/LineageEDItoIDX |                                                 | 200           | IDLE             | $.[?(@.configurationName=='LineageEDItoIDX')].status |
#
#  Scenario:SC1#:Delete the analysis item
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                         | type      | query | param |
#      | MultipleIDDelete | Default | bulk/EDIBus/LineageEDItoIDX% | Analysis  |       |       |
#      | SingleItemDelete | Default | bulk/EDIBus/LineageEDItoIDX% | Analysis  |       |       |
#      | SingleItemDelete | Default | IDCOperation                 | Operation |       |       |
#      | SingleItemDelete | Default | DBSystemOne≫DB               | Service   |       |       |
#
#
#  @edibus @mlp-6787 @webtest @positive @release10.0 @toIDP
#  Scenario:SC2#MLP-6787_Run incremental replication from EDI to IDX
#    Given user update the json file "idc/EdiBusPayloads/MLP_6787_EDITOIDXConfig.json" file for following values
#      | jsonPath    | jsonValues |
#      | $..function | toIDP      |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                             |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_6787_EDITOIDXConfig.json | 204           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/LineageEDItoIDX |                                                 | 200           | IDLE             | $.[?(@.configurationName=='LineageEDItoIDX')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/LineageEDItoIDX  |                                                 | 200           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/LineageEDItoIDX |                                                 | 200           | IDLE             | $.[?(@.configurationName=='LineageEDItoIDX')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "LineageEDItoIDX" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/LineageEDItoIDX%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#
#  Scenario Outline:SC2#user retrieves Service item ID
#    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
#    Examples:
#      | database      | retrive | catalog | type    | name           | asg_scopeid | targetFile                          | jsonpath          |
#      | APPDBPOSTGRES | ID      | Default | Service | DBSystemOne≫DB |             | response/edibus/actual/itemIds.json | $..has_Service.id |
#
#  Scenario Outline:SC2#Create Service item
#    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
#    Examples:
#      | contentType      | acceptType       | type | url                                                                  | body                                                    | responseCode | inputJson         | inputFile                           | responseMessage |
#      | application/json | application/json | Post | items/Default/Default.Service:::dynamic/operations?allowUpdate=false | idc/EdiBusPayloads/MLP-6787_Item_OperationCreation.json | 200          | $..has_Service.id | response/edibus/actual/itemIds.json |                 |
#
#
#  Scenario Outline:SC2#user retrieves Operation item ID
#    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
#    Examples:
#      | database      | retrive | catalog | type      | name         | asg_scopeid | targetFile                          | jsonpath          |
#      | APPDBPOSTGRES | ID      | Default | Operation | IDCOperation |             | response/edibus/actual/itemIds.json | $..has_Service.id |
#
#  Scenario Outline:SC2#Create Operation item
#    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
#    Examples:
#      | contentType      | acceptType       | type | url                                                                    | body                                              | responseCode | inputJson         | inputFile                           | responseMessage |
#      | application/json | application/json | Post | items/Default/Default.Operation:::dynamic/operations?allowUpdate=false | idc/EdiBusPayloads/MLP-6787_Item_HopCreation.json | 200          | $..has_Service.id | response/edibus/actual/itemIds.json |                 |
#
#
#  Scenario Outline:SC2#user updates the ID in json
#    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
#    Examples:
#      | database      | retrive      | catalog | type       | name      | asg_scopeid | targetFile                                                  | jsonpath                                       |
#      | APPDBPOSTGRES | JsonIDUpdate | Default | LineageHop | HopEDI    |             | payloads/idc/EdiBusPayloads/MLP-6787_Item_EdgeCreation.json | $..[?(@.edgelabel=='lineageTo')]['sourceId']   |
#      | APPDBPOSTGRES | JsonIDUpdate | Default | LineageHop | HopEDI    |             | payloads/idc/EdiBusPayloads/MLP-6787_Item_EdgeCreation.json | $..[?(@.edgelabel=='lineageFrom')]['sourceId'] |
#      | APPDBPOSTGRES | JsonIDUpdate | Default | Column     | ColumnOne |             | payloads/idc/EdiBusPayloads/MLP-6787_Item_EdgeCreation.json | $..[?(@.edgelabel=='lineageFrom')]['targetId'] |
#      | APPDBPOSTGRES | JsonIDUpdate | Default | Column     | ColumnTwo |             | payloads/idc/EdiBusPayloads/MLP-6787_Item_EdgeCreation.json | $..[?(@.edgelabel=='lineageTo')]['targetId']   |
#
#  Scenario Outline:SC2#Link lineage item
#    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
#    Examples:
#      | contentType      | acceptType       | type | url           | body                                               | responseCode | inputJson         | inputFile                           | responseMessage |
#      | application/json | application/json | Post | edges/Default | idc/EdiBusPayloads/MLP-6787_Item_EdgeCreation.json | 200          | $..has_Service.id | response/edibus/actual/itemIds.json |                 |
#
#  @edibus @mlp-6787 @webtest @positive @release10.0 @toIDP
#  Scenario:SC2#MLP-6787_Verification of lineage incremental replicationfrom EDI to IDX
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "IDCOperation" and clicks on search
#    And user performs "item click" on "IDCOperation" item from search results
#    Then user performs click and verify in new window
#      | Table        | value  | Action               | RetainPrevwindow | indexSwitch |
#      | Lineage Hops | HopEDI | click and switch tab | No               |             |
#    Then user performs click and verify in new window
#      | Table          | value     | Action                 | RetainPrevwindow | indexSwitch |
#      | Lineage Source | ColumnOne | verify widget contains | No               |             |
#      | Lineage Target | ColumnTwo | verify widget contains | No               |             |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                      | body                                          | response code | response message | jsonPath                                                 |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                                | idc/EdiBusPayloads/MLP_6787_IDXTOEDIIncr.json | 204           |                  |                                                          |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDILineageIncr |                                               | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDILineageIncr')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDILineageIncr  |                                               | 200           |                  |                                                          |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDILineageIncr |                                               | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDILineageIncr')].status |
#    And user enters the search text "IDXtoEDILineageIncr" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDILineageIncr%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user connects Rochade Server and "verifies" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                | itemCount |
#      | AP-DATA      | DATABASE    | 1.0                | (XNAME * *  ~/ @*IDCOPERATION@* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TASK ) | 1         |
#    And user connects Rochade Server and "verifies" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                        | itemCount |
#      | AP-DATA      | DATABASE    | 1.0                | (XNAME * *  ~/ @*HOPEDI@* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION_MAP ) | 0         |
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                                                                                                                                   |
#      | AP-DATA      | DATABASE    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_IDC_REPLICATIONDATE OR TYPE = DWR_TFM_TASK OR TYPE = DWR_TFM_TRANSFORMATION_MAP OR TYPE = DWR_TFM_SYSTEM OR TYPE = DWR_TFM_TRANSFORMATION ) |
#
#
#  Scenario:SC2#Cleanup
#    Given user update the json file "idc/EdiBusPayloads/MLP_6787_EDITOIDXConfig.json" file for following values
#      | jsonPath    | jsonValues   |
#      | $..function | toIDPCleanup |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                            | response code | response message | jsonPath                                             |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_6787_EDITOIDXConfig.json | 204           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/LineageEDItoIDX |                                                 | 200           | IDLE             | $.[?(@.configurationName=='LineageEDItoIDX')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/LineageEDItoIDX  |                                                 | 200           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/LineageEDItoIDX |                                                 | 200           | IDLE             | $.[?(@.configurationName=='LineageEDItoIDX')].status |
#
#  Scenario:SC2#:Delete the analysis item
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                         | type      | query | param |
#      | MultipleIDDelete | Default | bulk/EDIBus/LineageEDItoIDX% | Analysis  |       |       |
#      | SingleItemDelete | Default | bulk/EDIBus/LineageEDItoIDX% | Analysis  |       |       |
#      | SingleItemDelete | Default | IDCOperation                 | Operation |       |       |
#      | SingleItemDelete | Default | DBSystemOne≫DB               | Service   |       |       |
#
#  @edibus @edibus @mlp-6787 @positive @release10.0
#  Scenario:Clearing of Subject Area
#    Given user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                                                                                                                                   |
#      | AP-DATA      | DATABASE    | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_IDC_REPLICATIONDATE OR TYPE = DWR_TFM_TASK OR TYPE = DWR_TFM_TRANSFORMATION_MAP OR TYPE = DWR_TFM_SYSTEM OR TYPE = DWR_TFM_TRANSFORMATION ) |
