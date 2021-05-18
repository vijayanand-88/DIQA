Feature: MLP-3101 Feature for configuration of IDX/EDI integration with standard license


     #################################PreConditions################################
  @edibus @mlp-3101 @positive @release10.0
  Scenario: To update license key with lineage
    Given user connects Rochade Server and "licenseUpdate" the items in EDI subject areas
      | databaseName | licenseInfo       |
      | AP-DATA      | windowsNonLineage |

  @precondition
  Scenario:SC1#Update credential payload json for EDIBus
    Given User update the below "ediBus credentials" in following files using json path
      | filePath                                              | username                           | password                           |
      | idc/EdiBusPayloads/Credentials/EDIBusCredentials.json | $.edibusValidCredentials..userName | $.edibusValidCredentials..password |
    And User update the below "ediBus host" in following files using json path
      | filePath                                                  | username                             | password                             |
      | idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusAutoDataSource..['EDI host'] | $.EDIBusAutoDataSource..['EDI port'] |


  @MLP-3101 @edibus
  Scenario Outline: SC1#-Set the Credentials for EDIBus
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                               | bodyFile                                                       | path                           | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusValidCredentials       | payloads/idc/EdiBusPayloads/Credentials/EDIBusCredentials.json | $.edibusValidCredentials       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusValidCredentials       |                                                                |                                | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusUserInValidCredentials | payloads/idc/EdiBusPayloads/Credentials/EDIBusCredentials.json | $.edibusUserInvalidCredentials | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusUserInValidCredentials |                                                                |                                | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusEmptyCredentials       | payloads/idc/EdiBusPayloads/Credentials/EDIBusCredentials.json | $.edibusEmptyCredentials       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusEmptyCredentials       |                                                                |                                | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusReportCredentials      | payloads/idc/EdiBusPayloads/Credentials/EDIBusCredentials.json | $.edibusReportCredentials      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusReportCredentials      |                                                                |                                | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/EDIBusInValidCredentials     | payloads/idc/EdiBusPayloads/Credentials/EDIBusCredentials.json | $.edibusInValidCredentials     | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/EDIBusInValidCredentials     |                                                                |                                | 200           |                  |          |


  @MLP-3101 @edibus
  Scenario Outline: Set the DataSource for EDIBus toIDPCases
    And endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                                         | bodyFile                                                           | path                                     | response code | response message        | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusIDPDataSource     | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusIDPDataSource.configurations     | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusIDPDataSource     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusOrcDataSource     | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusOrcDataSource.configurations     | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusOrcDataSource     |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusMetaDataSource    | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusMetaDataSource.configurations    | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusMetaDataSource    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusCognosDataSource  | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusCognosDataSource.configurations  | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusCognosDataSource  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusDBDataSource      | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusDBDataSource.configurations      | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusDBDataSource      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusIDCOrcDataSource  | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusIDCOrcDataSource.configurations  | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusIDCOrcDataSource  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusERDataSource      | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusERDataSource.configurations      | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusERDataSource      |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusStitchDataSource  | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusStitchDataSource.configurations  | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusStitchDataSource  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusLineageDataSource | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusLineageDataSource.configurations | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusLineageDataSource |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusReportDataSource  | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusReportDataSource.configurations  | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusReportDataSource  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusAutoDataSource    | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusAutoDataSource.configurations    | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusAutoDataSource    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/EDIBusDataSource/EDIBusDBDataSource      | payloads/idc/EdiBusPayloads/DataSource/EDIBusDataSourceConfig.json | $.EDIBusDBDataSource.configurations      | 204           |                         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/EDIBusDataSource                         |                                                                    |                                          | 200           | EDIBusDBDataSource      |          |

     #################################Scenarios################################

    ##6518977##
  @edibus @mlp-3507 @webtest @positive @release10.0 @toIDP
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
    And user enters the search text "TestTable" and clicks on search
    And user performs "facet selection" in "TestDBSystem≫DB [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "TestTable" item from search results
    And METADATA widget should have following item values
      | metaDataItem | metaDataItemValue |
      | Table Type   | VIEW              |
    And user enters the search text "Transformation" and clicks on search
    And user performs "facet selection" in "TFMSystem≫Operation [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "Transformation" item from search results
    And user "widget not present" on "Lineage Hops" in Item view page
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
      | type | logValue              | logCode      | pluginName | removableText |
      | INFO | 21 items were written | EDIBUS-I0024 |            |               |


  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                            | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/EDItoIDXAutomation% | Analysis |       |       |

  @edibus @mlp-3101 @webtest @positive @release10.0 @toIDP
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
      | INFO | 21 items deleted | EDIBUS-I0010 |            |               |
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive   | catalog | type    | name            | asg_scopeid | targetFile | jsonpath |
      | APPDBPOSTGRES | deletedID | Default | Service | TestDBSystem≫DB |             |            |          |

  Scenario:SC2#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                            | type     | query | param |
      | SingleItemDelete | Default | bulk/EDIBus/EDItoIDXAutomation% | Analysis |       |       |

  @edibus @positive @release10.0
  Scenario:Clearing of Subject Area
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned
    And user connects Rochade Server and "clears" the items in EDI subject area
      | databaseName | subjectArea | subjectAreaVersion | query                                      |
      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ) |

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
