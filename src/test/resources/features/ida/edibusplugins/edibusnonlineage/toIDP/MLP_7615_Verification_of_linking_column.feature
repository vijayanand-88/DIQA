#Feature: MLP_7615_Verification_of_linking_column with standard license
#DD to EDI flow is disabled
#  @edibus @mlp-7615 @positive @release10.0
#  Scenario:SC1#To create catalog and import items of all types
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/xml                |
#      | Accept        | application/json               |
#    And supply payload with file name "idc/EdiBusPayloads/IDCData.xml"
#    When user makes a REST Call for POST request with url "import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true"
#    Then Status code 200 must be returned
#
##6400068#bug id:21467#
#  @edibus @mlp-7615 @webtest @positive @toIDP
#  Scenario:SC1#MLP-7615_Verification of replicating lineage hop to IDP
#    Given user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                               | body                                          | response code | response message | jsonPath                                          |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_7615_EDIBusConfig.json | 204           |                  |                                                   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConfig |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConfig')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusConfig  |                                               | 200           |                  |                                                   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConfig |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConfig')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "EDIBusConfig" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusConfig%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user connects Rochade Server and "add" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName     |
#      | AP-DATA      | AUTOMATION  | 1.0                | DWR_TFM_SYSTEM | NewTFMSystem |
#    And user connects Rochade Server and "addChildItem" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemType               | itemName          | childItemType              | childItemName        | attributeName        |
#      | AP-DATA      | AUTOMATION  | 1.0                | DWR_TFM_SYSTEM         | NewTFMSystem      | DWR_TFM_TASK               | NewTFMTask           | DWR_TFM_HAS_TFM_TASK |
#      | AP-DATA      | AUTOMATION  | 1.0                | DWR_TFM_TASK           | NewTFMTask        | DWR_TFM_TRANSFORMATION     | NewTransformation    | DWR_TFM_PERFORMS     |
#      | AP-DATA      | AUTOMATION  | 1.0                | DWR_TFM_TRANSFORMATION | NewTransformation | DWR_TFM_TRANSFORMATION_MAP | NewTransformationMap | DWR_TFM_HAS_TFM_MAP  |
#    And user connects Rochade Server and "linkItem" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemType                   | itemName             | linkItemType   | linkItemName | attributeName | operationName |
#      | AP-DATA      | AUTOMATION  | 1.0                | DWR_TFM_TRANSFORMATION_MAP | NewTransformationMap | DWR_RDB_COLUMN | Col1         | DWR_TFM_FROM  | SET           |
#      | AP-DATA      | AUTOMATION  | 1.0                | DWR_TFM_TRANSFORMATION_MAP | NewTransformationMap | DWR_RDB_COLUMN | Col2         | DWR_TFM_TO    | SET           |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                              | body                                         | response code | response message | jsonPath                                         |
#      |        |       |       | Put          | settings/analyzers/EDIBus                                        | idc/EdiBusPayloads/MLP_7615_toIDPConfig.json | 204           |                  |                                                  |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBustoIDP |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBustoIDP')].status |
#      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBustoIDP  |                                              | 200           |                  |                                                  |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBustoIDP |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBustoIDP')].status |
#    And user enters the search text "EDIBustoIDP" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBustoIDP%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "NewTransformation" and clicks on search
#    And user performs "item click" on "NewTransformation" item from search results
#    And user "widget not present" on "Lineage Hops" in Item view page
#
#
#  Scenario:SC1#Cleanup
#    Given user update the json file "idc/EdiBusPayloads/MLP_7615_toIDPConfig.json" file for following values
#      | jsonPath    | jsonValues   |
#      | $..function | toIDPCleanup |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                              | body                                         | response code | response message | jsonPath                                         |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                        | idc/EdiBusPayloads/MLP_7615_toIDPConfig.json | 204           |                  |                                                  |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBustoIDP |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBustoIDP')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBustoIDP  |                                              | 200           |                  |                                                  |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBustoIDP |                                              | 200           | IDLE             | $.[?(@.configurationName=='EDIBustoIDP')].status |
#
#  Scenario:SC1#:Delete the analysis item
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                      | type     | query | param |
#      | MultipleIDDelete | Default | bulk/EDIBus/EDIBustoIDP%  | Analysis |       |       |
#      | SingleItemDelete | Default | LineageTestCluster        | Cluster  |       |       |
#      | SingleItemDelete | Default | bulk/EDIBus/EDIBusConfig% | Analysis |       |       |
#
#
#  @edibus @mlp-7615 @positive @release10.0
#  Scenario:SC2#To import items of all types
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/xml                |
#      | Accept        | application/json               |
#    And supply payload with file name "idc/EdiBusPayloads/IDCData.xml"
#    When user makes a REST Call for POST request with url "import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false"
#    Then Status code 200 must be returned
#
##6401981##bug id:21467#
#  @edibus @mlp-7615 @webtest @positive @toIDP
#  Scenario:SC2#MLP-7615_Verification of replicating lineage hop to IDP  with incremental true
#    Given user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                               | body                                          | response code | response message | jsonPath                                          |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_7615_EDIBusConfig.json | 204           |                  |                                                   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConfig |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConfig')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBusConfig  |                                               | 200           |                  |                                                   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBusConfig |                                               | 200           | IDLE             | $.[?(@.configurationName=='EDIBusConfig')].status |
#    When User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "EDIBusConfig" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBusConfig%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user connects Rochade Server and "add" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemType       | itemName     |
#      | AP-DATA      | AUTOMATION  | 1.0                | DWR_TFM_SYSTEM | NewTFMSystem |
#    And user connects Rochade Server and "addChildItem" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemType               | itemName          | childItemType              | childItemName        | attributeName        |
#      | AP-DATA      | AUTOMATION  | 1.0                | DWR_TFM_SYSTEM         | NewTFMSystem      | DWR_TFM_TASK               | NewTFMTask           | DWR_TFM_HAS_TFM_TASK |
#      | AP-DATA      | AUTOMATION  | 1.0                | DWR_TFM_TASK           | NewTFMTask        | DWR_TFM_TRANSFORMATION     | NewTransformation    | DWR_TFM_PERFORMS     |
#      | AP-DATA      | AUTOMATION  | 1.0                | DWR_TFM_TRANSFORMATION | NewTransformation | DWR_TFM_TRANSFORMATION_MAP | NewTransformationMap | DWR_TFM_HAS_TFM_MAP  |
#    And user connects Rochade Server and "linkItem" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemType                   | itemName             | linkItemType   | linkItemName | attributeName | operationName |
#      | AP-DATA      | AUTOMATION  | 1.0                | DWR_TFM_TRANSFORMATION_MAP | NewTransformationMap | DWR_RDB_COLUMN | Col1         | DWR_TFM_FROM  | SET           |
#      | AP-DATA      | AUTOMATION  | 1.0                | DWR_TFM_TRANSFORMATION_MAP | NewTransformationMap | DWR_RDB_COLUMN | Col2         | DWR_TFM_TO    | SET           |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                  | body                                             | response code | response message | jsonPath                                             |
#      |        |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_7615_toIDPConfigIncr.json | 204           |                  |                                                      |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBustoIDPIncr |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBustoIDPIncr')].status |
#      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBustoIDPIncr  |                                                  | 200           |                  |                                                      |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBustoIDPIncr |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBustoIDPIncr')].status |
#    And user enters the search text "EDIBustoIDP" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDIBustoIDPIncr%"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "NewTransformation" and clicks on search
#    And user "widget not present" on "Lineage Hops" in Item view page
#
#
#  Scenario:SC2#Cleanup
#    Given user update the json file "idc/EdiBusPayloads/MLP_7615_toIDPConfigIncr.json" file for following values
#      | jsonPath    | jsonValues   |
#      | $..function | toIDPCleanup |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                             | response code | response message | jsonPath                                             |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                            | idc/EdiBusPayloads/MLP_7615_toIDPConfigIncr.json | 204           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBustoIDPIncr |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBustoIDPIncr')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBustoIDPIncr  |                                                  | 200           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBustoIDPIncr |                                                  | 200           | IDLE             | $.[?(@.configurationName=='EDIBustoIDPIncr')].status |
#
#  Scenario:SC2#:Delete the analysis item
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                         | type     | query | param |
#      | MultipleIDDelete | Default | bulk/EDIBus/EDIBustoIDPIncr% | Analysis |       |       |
#      | SingleItemDelete | Default | LineageTestCluster           | Cluster  |       |       |
#      | SingleItemDelete | Default | bulk/EDIBus/EDIBusConfig%    | Analysis |       |       |
#
#
#  @edibus @positive
#  Scenario:SC3#Clearing of Subject Area
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
#    And Status code 204 must be returned
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |