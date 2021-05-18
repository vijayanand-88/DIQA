#Feature: MLP_8677 Replicate PII data found in unstructured files
#
#  ##6771500##
#  @edibus @mlp-8677 @webtest @positive @toEDI
#  Scenario:SC1#_MLP_8677 Verification of PII Data in unstructured files to EDI
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/catalogs/EDITagData?deleteData=true"
#    And user update json file "idc/EdiBusPayloads/MLP-8677_IDPGDPRConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                  | body                                           | response code | response message | jsonPath                                             |
#      | application/json |       |       | Post         | settings/catalogs                                                    | idc/EdiBusPayloads/EDITagDataCatalog.json      | 204           |                  |                                                      |
#      |                  |       |       | Put          | settings/analyzers/EDIBus/toIDPGDPRConfig                            | idc/EdiBusPayloads/MLP-8677_IDPGDPRConfig.json | 204           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPGDPRConfig |                                                | 200           | IDLE             | $.[?(@.configurationName=='toIDPGDPRConfig')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPGDPRConfig  |                                                | 200           |                  |                                                      |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPGDPRConfig |                                                | 200           | IDLE             | $.[?(@.configurationName=='toIDPGDPRConfig')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user selects "Business Glossary" catalog from catalog list
#    And user selects the "Analysis" from the Type
#    And user "click" on "AnalysisItem" containing "toIDPGDPR"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user enters the search text "EDIGENDERTAG" and clicks on search
#    And user selects the "PIIAttribute" from the Type
#    And user clicks on "EDIGENDERTAG" item name link
#    And user clicks on close button in the item full view page
#    And user selects "Business Glossary" catalog from catalog list
#    And user enters the search text "EDIGENDERTAG" and clicks on search
#    And user selects the "PIIProperty" from the Type
#    And user clicks on "GenderProperty" item name link
#    And user clicks on close button in the item full view page
#    And user clicks on home button
#    And user "click" on "Administration" dashboard
#    And User "click" on "CATALOG MANAGER" link on the Dashboard page
#    And user clicks on "EDITagData" catalog in catalog management
#    And user clicks on view tags in edit subject area
#    And user clicks on add tag template button
#    And user selects "PII - BusinessGlossary" template in the list of tag templates
#    Then the "PII - BusinessGlossary" template should get displayed in the Add Tags page
#    And user clicks on active panel save button
#    And user clicks on active panel save button
#    And user clicks on logout button
#
#
#  Scenario Outline: SC2#-Set the Credentials for Git Datasource and Cataloger
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                   | response code | response message | jsonPath |
#      | IDC         | TestSystemUser | application/json |       |       | Put  | settings/credentials/EDIGitCredentials | idc/EdiBusPayloads/GitCredentials.json | 200           |                  |          |
#
#
#  Scenario: SC2#-Set the Datasource
#    Given Execute REST API with following parameters
#      | Header           | Query | Param | type | url                                       | body                                  | response code | response message | jsonPath               |
#      | application/json | raw   | false | Put  | settings/analyzers/GitCollectorDataSource | idc/EdiBusPayloads/GitDataSource.json | 204           |                  |                        |
#      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource |                                       | 200           |                  | GitCollectorDataSource |
#
#
#  @edibus @sanity @positive
#  Scenario Outline: SC2# Run the Plugin configurations for Git and UnstructuredDataAnalyzer
#    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
#    Examples:
#      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                  | body                                                | response code | response message         | jsonPath                                                      |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/GitCollector/GitEDI                                                               | idc/EdiBusPayloads/MLP-8677_GitConfig.json          | 204           |                          |                                                               |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/GitCollector/GitEDI                                                               |                                                     | 200           | GitEDI                   |                                                               |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitEDI                                  |                                                     | 200           | IDLE                     | $.[?(@.configurationName=='GitEDI')].status                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitEDI                                   |                                                     | 200           |                          |                                                               |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitEDI                                  |                                                     | 200           | IDLE                     | $.[?(@.configurationName=='GitEDI')].status                   |
#      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer                                 | idc/EdiBusPayloads/MLP-8677_UnstructuredConfig.json | 204           |                          |                                                               |
#      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer                                 |                                                     | 200           | UnstructuredDataAnalyzer |                                                               |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer |                                                     | 200           | IDLE                     | $.[?(@.configurationName=='UnstructuredDataAnalyzer')].status |
#      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer  |                                                     | 200           |                          |                                                               |
#      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/UnstructuredDataAnalyzer/UnstructuredDataAnalyzer |                                                     | 200           | IDLE                     | $.[?(@.configurationName=='UnstructuredDataAnalyzer')].status |
#
#
#  @edibus @mlp-8677 @webtest @positive @toEDI
#  Scenario:SC2#_MLP_8677 Verification of toEDIGDPR
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user selects "EDITagData" catalog from catalog list
#    And user enters the search text "gender.txt" and clicks on search
#    And user selects the "File" from the Type
#    And user clicks on "gender.txt" item name link
#    And user verifies the text "EDIGENDERTAG" inside the Tag section
#    And user clicks on logout button
#    And user update json file "idc/EdiBusPayloads/MLP-8677_toEDIConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                              | body                                         | response code | response message | jsonPath                                         |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus/toEDIConfig                            | idc/EdiBusPayloads/MLP-8677_toEDIConfig.json | 204           |                  |                                                  |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIConfig |                                              | 200           | IDLE             | $.[?(@.configurationName=='toEDIConfig')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toEDIConfig  |                                              | 200           |                  |                                                  |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIConfig |                                              | 200           | IDLE             | $.[?(@.configurationName=='toEDIConfig')].status |
#    And user connects Rochade Server and "verifies" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
#      | AP-DATA      | TAG         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) | 11        |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                  | body                                             | response code | response message | jsonPath                                             |
#      |        |       |       | Put          | settings/analyzers/EDIBus/toEDIGDPRConfig                            | idc/EdiBusPayloads/MLP-8677_toEDIGDPRConfig.json | 204           |                  |                                                      |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIGDPRConfig |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toEDIGDPRConfig')].status |
#      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toEDIGDPRConfig  |                                                  | 200           |                  |                                                      |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIGDPRConfig |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toEDIGDPRConfig')].status |
#    And user connects Rochade Server and "verify attributeValues" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemName              | itemType                 | attributeName              | attributeValue                      |
#      | AP-DATA      | TAG         | 1.0                | EDIGENDERTAG          | GDP_PERSONAL_INFORMATION | RBG/TECHNICAL_DATA_CATALOG | gender.txt                          |
#      | AP-DATA      | TAG         | 1.0                | NEWGLOSS.EDIGENDERTAG | DWR_DAT_FIELD            | DWR_DAT_AT_POS             | [0, 6], [7, 11], [12, 13], [14, 15] |
#
#
#  @edibus @mlp-8677 @positive @release10.0
#  Scenario:SC3#_MLP-8677 Clearing PII attributes replicated
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user get the ID for data set "GenderProperty" from below query
#      | description | schemaName       | tableName     | columnName | criteriaName |
#      | SELECT      | BusinessGlossary | V_PIIProperty | ID         | name         |
#    And user makes a REST Call to DELETE "items/BusinessGlossary/BusinessGlossary.PIIProperty:::"
#    And user get the ID for data set "EDIGENDERTAG" from below query
#      | description | schemaName       | tableName      | columnName | criteriaName |
#      | SELECT      | BusinessGlossary | V_PIIAttribute | ID         | name         |
#    And user makes a REST Call to DELETE "items/BusinessGlossary/BusinessGlossary.PIIAttribute:::"
#
#
#    ##6784866##6268692#
#  @edibus @mlp-8677 @webtest @positive @toEDI
#  Scenario:SC3#_MLP_8677_MLP-5439_Verification of deleting replicated PII Attribute and PII Property
#    Given user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                                                                                               |
#      | AP-DATA      | TAG         | 1.0                | (XNAME * *  ~/ @* ),AND,( TYPE = DWR_IDC_REPLICATIONDATE OR TYPE = DWR_DAT_FILE_SYSTEM OR TYPE = DWR_DAT_DIRECTORY OR TYPE = DWR_DAT_FIELD OR TYPE = DWR_DAT_FILE ) |
#    And user update json file "idc/EdiBusPayloads/MLP-8677_toEDIConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                              | body                                         | response code | response message | jsonPath                                         |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus/toEDIConfig                            | idc/EdiBusPayloads/MLP-8677_toEDIConfig.json | 204           |                  |                                                  |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIConfig |                                              | 200           | IDLE             | $.[?(@.configurationName=='toEDIConfig')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toEDIConfig  |                                              | 200           |                  |                                                  |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIConfig |                                              | 200           | IDLE             | $.[?(@.configurationName=='toEDIConfig')].status |
#    And user connects Rochade Server and "verifies" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemCount |
#      | AP-DATA      | TAG         | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FILE ) | 11        |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                       | body                                                  | response code | response message | jsonPath                                                  |
#      |        |       |       | Put          | settings/analyzers/EDIBus/toEDIGDPRErrorConfig                            | idc/EdiBusPayloads/MLP-8677_toEDIGDPRErrorConfig.json | 204           |                  |                                                           |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIGDPRErrorConfig |                                                       | 200           | IDLE             | $.[?(@.configurationName=='toEDIGDPRErrorConfig')].status |
#      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toEDIGDPRErrorConfig  |                                                       | 200           |                  |                                                           |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIGDPRErrorConfig |                                                       | 200           | IDLE             | $.[?(@.configurationName=='toEDIGDPRErrorConfig')].status |
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user selects "EDITagData" catalog from catalog list
#    And user selects the "Analysis" from the Type
#    And user "click" on "AnalysisItem" containing "toEDIGDPRErrorConfig"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 1                 |
#    And user clicks on log link and opens the log
#    And Analysis log should display the analysis info for below parameters
#      | type  | logValue                        | logLine      |
#      | ERROR | EDIBus reported an error        | EDIBUS-E0002 |
#      | ERROR | Glossary name must not be empty | EDIBUS-E1307 |
#    And Execute REST API with following parameters
#      | Header | Query | Param | type         | url                                                                  | body                                             | response code | response message | jsonPath                                             |
#      |        |       |       | Put          | settings/analyzers/EDIBus/toEDIGDPRConfig                            | idc/EdiBusPayloads/MLP-8677_toEDIGDPRConfig.json | 204           |                  |                                                      |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIGDPRConfig |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toEDIGDPRConfig')].status |
#      |        |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toEDIGDPRConfig  |                                                  | 200           |                  |                                                      |
#      |        |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toEDIGDPRConfig |                                                  | 200           | IDLE             | $.[?(@.configurationName=='toEDIGDPRConfig')].status |
#    And user connects Rochade Server and "verify attributeValues notFound" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemName     | itemType                 | attributeName              | attributeValue |
#      | AP-DATA      | TAG         | 1.0                | EDIGENDERTAG | GDP_PERSONAL_INFORMATION | RBG/TECHNICAL_DATA_CATALOG | gender.txt     |
#    And user connects Rochade Server and "verify itemNames notFound" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                  | itemNames             |
#      | AP-DATA      | AUTOMATION  | 1.0                | (XNAME * *  ~/ @* ),AND,( INSTCFGCNT > 0 ),AND,( TYPE = DWR_DAT_FIELD) | NEWGLOSS.EDIGENDERTAG |
#
#
#  @edibus @mlp-8677 @positive @release10.0
#  Scenario:SC4#_MLP-8677 Clearing items created
#    Given user connects Rochade Server and "clears" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | query                                                                                                                                                               |
#      | AP-DATA      | TAG         | 1.0                | (XNAME * *  ~/ @* ),AND,( TYPE = DWR_IDC_REPLICATIONDATE OR TYPE = DWR_DAT_FILE_SYSTEM OR TYPE = DWR_DAT_DIRECTORY OR TYPE = DWR_DAT_FIELD OR TYPE = DWR_DAT_FILE ) |
#    And  Execute REST API with following parameters
#      | Header           | Query      | Param | type   | url                                       | body | response code | response message | jsonPath |
#      | application/json |            |       | Delete | settings/analyzers/EDIBus                 |      | 204           |                  |          |
#      |                  |            |       | Delete | settings/credentials/EDIGitCredentials    |      | 200           |                  |          |
#      |                  |            |       | Delete | settings/analyzers/GitCollectorDataSource |      | 204           |                  |          |
#      |                  | deleteData | true  | Delete | settings/catalogs/EDITagData              |      | 204           |                  |          |