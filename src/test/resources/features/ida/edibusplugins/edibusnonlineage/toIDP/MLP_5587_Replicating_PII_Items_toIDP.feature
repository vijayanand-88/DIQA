#Feature: MLP_5587 Replicating PII tag from EDI to IDP
#
#  @edibus @mlp-5587 @webtest @positive @release10.0 @toIDP
#  Scenario:MLP-5587 Verification of full replication of PII attributes, field and PII property with PII attributes from EDI to IDP
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/catalogs/TagCatalog?deleteData=true"
#    And user update json file "idc/EdiBusPayloads/MLP_5587_TagConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                               | body                                        | response code | response message | jsonPath                                          |
#      | application/json |       |       | Post         | settings/catalogs                                                 | idc/EdiBusPayloads/MLP_5587_TagCatalog.json | 204           |                  |                                                   |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                         | idc/EdiBusPayloads/MLP_5587_TagConfig.json  | 204           |                  |                                                   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPGDPRTag |                                             | 200           | IDLE             | $.[?(@.configurationName=='toIDPGDPRTag')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPGDPRTag  |                                             | 200           |                  |                                                   |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPGDPRTag |                                             | 200           | IDLE             | $.[?(@.configurationName=='toIDPGDPRTag')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects "TagCatalog" catalog from catalog list
#    And user selects the "PIIAttribute" from the Type
#    And user clicks on first item on the item list page
#    And METADATA widget should have following item values
#      | metaDataItem             | metaDataItemValue |
#      | Classification           | Normal            |
#      | Personally Identifiable? | false             |
#      | Sensitive?               | Yes               |
#    And user selects "TagCatalog" catalog from catalog list
#    And user clicks on search icon
#    And user selects the "PIIProperty" from the Type
#    And user clicks on first item on the item list page
#    And METADATA widget should have following item values
#      | metaDataItem  | metaDataItemValue                 |
#      | Data Pattern  | \d{3}[ -]{0,1}\d{2}[ -]{0,1}\d{4} |
#      | Minimum Ratio | 0.9                               |
#      | Type Pattern  | *.pdf                             |
#    And user clicks on logout button
#
#  @edibus @mlp-5587 @webtest @positive @release10.0 @toIDP
#  Scenario:MLP-5587 Verification of replication of PII attributes from EDI to IDP with incremental "False"
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/catalogs/TagCatalog?deleteData=true"
#    And user update json file "idc/EdiBusPayloads/MLP_5587_TagConfigIncr.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And configure a new REST API for the service "IDC"
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                   | body                                           | response code | response message | jsonPath                                              |
#      | application/json |       |       | Post         | settings/catalogs                                                     | idc/EdiBusPayloads/MLP_5587_TagCatalog.json    | 204           |                  |                                                       |
#      |                  |       |       | Put          | settings/analyzers/EDIBus                                             | idc/EdiBusPayloads/MLP_5587_TagConfigIncr.json | 204           |                  |                                                       |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPGDPRTagIncr |                                                | 200           | IDLE             | $.[?(@.configurationName=='toIDPGDPRTagIncr')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPGDPRTagIncr  |                                                | 200           |                  |                                                       |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPGDPRTagIncr |                                                | 200           | IDLE             | $.[?(@.configurationName=='toIDPGDPRTagIncr')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects "TagCatalog" catalog from catalog list
#    And user clicks on search icon
#    And user clicks on "EDIGENDER" in the items listed
#    And user clicks on close button in the item full view page
#    And user clicks on "gender_2" in the items listed
#    And user clicks on close button in the item full view page
#    And user selects the "Analysis" from the Type
#    And user "click" on "AnalysisItem" containing "toIDPGDPRTagIncr"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user clicks on logout button
#
#
#  @edibus @edibus @mlp-5587 @positive @release10.0
#  Scenario:Clearing of Subject Area
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/catalogs/TagCatalog?deleteData=true"
#    And Status code 204 must be returned
#    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
#    And Status code 204 must be returned
#
