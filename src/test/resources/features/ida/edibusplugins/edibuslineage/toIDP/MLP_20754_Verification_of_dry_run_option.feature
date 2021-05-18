Feature: MLP-20754 Feature for verification of dry run

    ##7040062##
  @edibus @mlp-20754 @webtest @positive @toIDP
  Scenario Outline:SC1#MLP-20754_Verification of dry run option from EDI to IDX
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                       | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_20754_EDITOIDX.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXDryRun |                                            | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXDryRun')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXDryRun  |                                            | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXDryRun |                                            | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXDryRun')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDItoIDXDryRun" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXDryRun%"
    And METADATA widget should have following item values
      | metaDataItem              | metaDataItemValue |
      | Number of processed items | 0                 |
      | Number of errors          | 0                 |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDItoIDXDryRun%" should display below info/error/warning
      | type | logValue                                                                                                                                             | logCode       | pluginName | removableText |
      | INFO | Plugin EDIBus running on dry run mode                                                                                                                | ANALYSIS-0069 |            |               |
      | INFO | Plugin EDIBus processed 20 items on dry run mode and not written to the repository                                                                   | ANALYSIS-0070 |            |               |
      | INFO | The replication in dryRun mode processed 17 items in 1 cycles and took 1s; 20 items would be written and 0 items would be deleted in the DD catalog. | EDIBUS-I0021  |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name            | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | TestDBSystem≫DB |             |            |          |

  Scenario:SC1#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_20754_EDITOIDX.json" file for following values
      | jsonPath    | jsonValues   |
      | $..function | cleanup |
    And Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                 | body                                       | response code | response message | jsonPath                                            |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_20754_EDITOIDX.json | 204           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXDryRun |                                            | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXDryRun')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXDryRun  |                                            | 200           |                  |                                                     |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXDryRun |                                            | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXDryRun')].status |

  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                        | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/EDItoIDXDryRun% | Analysis |       |       |

# Descoped since DD to EDI flow is disabled
#  @edibus @mlp-7615 @positive @release10.0
#  Scenario:SC2#To create catalog and import items of all types
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/xml                |
#      | Accept        | application/json               |
#    And supply payload with file name "idc/EdiBusPayloads/IDCData.xml"
#    When user makes a REST Call for POST request with url "import/Default?isRnx=false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true"
#    Then Status code 200 must be returned
#
#
#    #7040063#
#  @edibus @mlp-20754 @webtest @positive @toEDI
#  Scenario:SC2#MLP-20754_Verification of dry run option from IDX to EDI
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                       | response code | response message | jsonPath                                            |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_20754_IDXTOEDI.json | 204           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIDryRun |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIDryRun')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIDryRun  |                                            | 200           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIDryRun |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIDryRun')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user enters the search text "IDXtoEDIDryRun" and clicks on search
#    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/IDXtoEDIDryRun%"
#    And METADATA widget should have following item values
#      | metaDataItem              | metaDataItemValue |
#      | Number of processed items | 0                 |
#      | Number of errors          | 0                 |
#    Then user performs click and verify in new window
#      | Table | value | Action               | RetainPrevwindow | indexSwitch |
#      | Data  | log   | click and switch tab | No               |             |
#    And Analysis log "bulk/EDIBus/IDXtoEDIDryRun%" should display below info/error/warning
#      | type | logValue                                                                                                                  | logCode       | pluginName | removableText |
#      | INFO | Plugin EDIBus running on dry run mode                                                                                     | ANALYSIS-0069 |            |               |
#      | INFO | Plugin EDIBus processed 37 items on dry run mode and not written to the repository                                        | ANALYSIS-0070 |            |               |
#      | INFO | replication in dryRun mode read 32 items in 1 cycles in 0s; 37 items would be written and 0 items would be deleted in EDI | EDIBUS-I0044  |            |               |
#    And user connects Rochade Server and "verifies" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      | itemCount |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) | 1         |
#
#
#  Scenario:SC2#Cleanup
#    Given user update the json file "idc/EdiBusPayloads/MLP_20754_IDXTOEDI.json" file for following values
#      | jsonPath    | jsonValues   |
#      | $..function | toIDPCleanup |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                       | response code | response message | jsonPath                                            |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_20754_IDXTOEDI.json | 204           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIDryRun |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIDryRun')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/IDXtoEDIDryRun  |                                            | 200           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/IDXtoEDIDryRun |                                            | 200           | IDLE             | $.[?(@.configurationName=='IDXtoEDIDryRun')].status |
#
#  Scenario:SC2#:Delete the analysis item
#    And Delete multiple values in IDC UI with below parameters
#      | deleteAction     | catalog | name                        | type     | query | param |
#      | SingleItemDelete | Default | bulk/EDIBus/IDXtoEDIDryRun% | Analysis |       |       |
#      | SingleItemDelete | Default | LineageTestCluster          | Cluster  |       |       |
#      | MultipleIDDelete | Default | bulk/EDIBus%                | Analysis |       |       |

  @edibus @positive @release10.0
  Scenario:Clearing of Subject Area
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |


#  lineage verification
#  Scenario Outline: user get all lineage hops id,s and get the source target value from database
#    Given user retrieves all lineage hops values for below parameters
#      | database      | retrive              | catalog | type  | lineageFlow      | name                          | asg_scopeid | targetFile                        | jsonpath |
#      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Class | functions-->hops | Select_Drop                   |             | response/Lineage/bulkLineage.json |          |
#      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Class | functions-->hops | JoinExample                   |             | response/Lineage/bulkLineage.json |          |
#      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Class | functions-->hops | DropDuplicates_Dropna_OrderBy |             | response/Lineage/bulkLineage.json |          |
#      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Class | functions-->hops | NoSourceTarget                |             | response/Lineage/bulkLineage.json |          |
#      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Class | functions-->hops | Alias_Distinct                |             | response/Lineage/bulkLineage.json |          |
#      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Class | functions-->hops | WithColumnRenamed             |             | response/Lineage/bulkLineage.json |          |
#      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Class | functions-->hops | RepartitionByRange            |             | response/Lineage/bulkLineage.json |          |
#      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Class | functions-->hops | UnionByName                   |             | response/Lineage/bulkLineage.json |          |
#      | APPDBPOSTGRES | bulkFunctionHopNames | Default | Class | functions-->hops | Sort_SortwithPartition        |             | response/Lineage/bulkLineage.json |          |
#    And user connects Rochade Server and "verify lineageHopNames" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_TFM_TRANSFORMATION_MAP ) |
#    And user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
#    Examples:
#      | expectedValues                    | actualValues                                   | valueType         | expectedJsonPath | actualJsonPath |
#      | response/Lineage/bulkLineage.json | payloads/idc/EdiBusPayloads/lineageEDIBus.json | stringListCompare | $.LineageHops.*  | $.lineageName  |
