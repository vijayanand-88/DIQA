Feature: MLP-3101 Feature for configuration of IDX/EDI integration


     #################################Scenarios################################

    ##6518977##
  @edibus @mlp-3507 @webtest @positive @release10.0 @toIDP @sanity
  Scenario:SC1#MLP-3507_MLP-7229_Full Replication of data from EDI to IDX and verify all items replicated in IDX
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                                        | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/EDITOIDXConfigTypes.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXAutomation |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXAutomation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXAutomation  |                                             | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXAutomation |                                             | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXAutomation')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "TestDBSystem" and clicks on search
    And user performs "facet selection" in "TestDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Column   |
      | Database |
      | Service  |
      | Table    |
      | Schema   |
    And user enters the search text "DataPackage" and clicks on search
    And user performs "facet selection" in "DataPackage [DataPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | DataDomain  |
      | DataPackage |
      | DataType    |
    And user enters the search text "TFMSystem" and clicks on search
    And user performs "facet selection" in "TFMSystem≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Operation |
      | Service   |
    And user enters the search text "TestFileSystem" and clicks on search
    And user performs "facet selection" in "TestFileSystem≫FS [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | Directory |
    And user enters the search text "TestFile" and clicks on search
    And user performs "facet selection" in "TestFile [File]" attribute under "Hierarchy" facets in Item Search results page
    And user "verifies presence" for listed "Metadata Type" facet in Search results page
      | File  |
      | Field |
    And user enters the search text "TestTable" and clicks on search
    And user performs "facet selection" in "TestDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TestTable" item from search results
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Table Type        | VIEW          |
    And user enters the search text "Transformation" and clicks on search
    And user performs "facet selection" in "TFMSystem≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "Transformation" item from search results
    Then user performs click and verify in new window
      | Table        | value             | Action                 | RetainPrevwindow | indexSwitch |
      | Lineage Hops | TransformationMap | verify widget contains | No               |             |
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXAutomation%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDItoIDXAutomation%" should display below info/error/warning
      | type | logValue                | logCode      | pluginName | removableText |
      | INFO | replication of 19 items | EDIBUS-I0024 |            |               |

  @sanity
  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                            | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/EDItoIDXAutomation% | Analysis |       |       |

  @edibus @mlp-3101 @webtest @positive @release10.0 @toIDP @sanity
  Scenario Outline:SC2#MLP-3101 Run EDIBUS with IDPCleanUp as function parameter and validate data is cleaned up in IDP
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                     | body                               | response code | response message | jsonPath                                                |
      | application/json |       |       | Put          | settings/analyzers/EDIBus                                               | idc/EdiBusPayloads/IDPCleanup.json | 204           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXAutomation |                                    | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXAutomation')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDItoIDXAutomation  |                                    | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDItoIDXAutomation |                                    | 200           | IDLE             | $.[?(@.configurationName=='EDItoIDXAutomation')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "EDIBus" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/EDItoIDXAutomation%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    Then user performs click and verify in new window
      | Table | value | Action               | RetainPrevwindow | indexSwitch |
      | Data  | log   | click and switch tab | No               |             |
    And Analysis log "bulk/EDIBus/EDItoIDXAutomation%" should display below info/error/warning
      | type | logValue         | logCode      | pluginName | removableText |
      | INFO | 22 items deleted | EDIBUS-I0010 |            |               |

    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name            | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | TestDBSystem≫DB |             |            |          |

  @sanity
  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                            | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/EDItoIDXAutomation% | Analysis |       |       |

  @edibus @positive @release10.0 @sanity
  Scenario:Clearing of Subject Area
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

#
#  @webtest @mlp-3101 @positive @regression @pluginManager
#  Scenario: MLP-3101 Verification of creating a node for running a plugin controller for non restricted character
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#      | Content-Type  | application/json               |
#      | Accept        | application/json               |
#    And supply payload with file name "/idc/EdiBusPayloads/MLP_3101_IDXTOEDI.json"
#    When user makes a REST Call for PUT request with url "settings/analyzers/EDIBus" with the following query param
#      | raw | false |
#    And Status code 204 must be returned

#  ##5692987##6638663##
#  @webtest @mlp-3101 @mlp-10310 @positive @regression @toIDP
#  Scenario Outline: MLP-3101_MLP-10310_Verification of running a plugin with non restricted characters
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Administration" dashboard
#    And user "click" on "CATALOG MANAGER" dashboard
#    And user creates a catalog with name "<catalogName>" and save it in Catalog manager page
#    And user clicks on home button
#    And user clicks on Plugin Manager in Administration dashboard
#    And user click on Analysis plugin label and navigate to "EDIBus" from the available plugin list in Plugin Manager
#    And user clicks on the configuration Name "EDIBus"
#    And user selects "<catalogName>" catalog from the dropdown in the Plugin configuration panel in Plugin manager
#    And user click Apply button in "PLUGIN CONFIGURATION" page
#    And user click Apply button in "EDIBUS CONFIGURATIONS" page
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                         | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus |      | 200           | IDLE             |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type | url                                                        | body | response code | response message |
#      |        |       |       | Post | extensions/analyzers/start/InternalNode/bulk/EDIBus/EDIBus |      | 200           |                  |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                         | body | response code | response message |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/EDIBus |      | 200           | IDLE             |
#    And user refreshes the application
#    And user selects "<catalogName>" catalog from catalog list
#    And user selects the "Analysis" from the Type
#    And user clicks on first item on the item list page
#    And user verifies the METADATA errors is displayed as "0"
#
#    Examples:
#      | catalogName            |
#      | Testing`               |
#      | Testing!               |
#      | Testing@               |
#      | Testing^               |
#      | Testing&               |
#      | Testing(               |
#      | Testing=               |
#      | Testing$               |
#      | Testing<               |
#      | Testing>               |
#      | Testing)               |
#      | Testing+               |
#      | Testing-               |
#      | Testing_               |
#      | Testing*               |
#      | Testing.               |
#      | Testing'               |
#      | Testing:               |
#      | Testing,               |
#      | Testing;               |
#      | Testing#               |
#      | Testing%               |
#      | Testing~               |
#      | @Testing%~.#*          |
#      | Testing.EDIBus_Catalog |
#
#  @webtest @MLP-2961 @positive @regression @toIDP
#  Scenario Outline: MLP-2961 Deleting the catalog created
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Administration" dashboard
#    And user "click" on "CATALOG MANAGER" dashboard
#    And user clicks on mentioned catalog "<catalogName>" to be deleted
#    And user clicks on Delete button in the New Subject Area page
#
#    Examples:
#      | catalogName            |
#      | Testing`               |
#      | Testing!               |
#      | Testing@               |
#      | Testing^               |
#      | Testing&               |
#      | Testing(               |
#      | Testing=               |
#      | Testing$               |
#      | Testing<               |
#      | Testing>               |
#      | Testing)               |
#      | Testing+               |
#      | Testing-               |
#      | Testing_               |
#      | Testing*               |
#      | Testing.               |
#      | Testing'               |
#      | Testing:               |
#      | Testing,               |
#      | Testing;               |
#      | Testing#               |
#      | Testing%               |
#      | Testing~               |
#      | @Testing%~.#*          |
#      | Testing.EDIBus_Catalog |
#
#  @edibus @positive @release10.0
#  Scenario:Clearing of Subject Area
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/catalogs/IDCData?deleteData=true"
#    And Status code 204 must be returned
#    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
#    And Status code 204 must be returned
#    And user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                      |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |
