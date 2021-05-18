#Feature: MLP_5439 Replicating PII tag from EDI to IDP
#
#  @edibus @mlp-5439 @webtest @positive @release10.0 @toIDP
#  Scenario:MLP-5439 Verification of replicating PII tag from EDI to IDP through IDPGDPR function
#    Given user update json file "idc/EdiBusPayloads/IDPGDPRConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                            | body                                  | response code | response message | jsonPath                                       |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/IDPGDPRConfig.json | 204           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPGDPR |                                       | 200           | IDLE             | $.[?(@.configurationName=='toIDPGDPR')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPGDPR  |                                       | 200           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPGDPR |                                       | 200           | IDLE             | $.[?(@.configurationName=='toIDPGDPR')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user selects "Business Glossary" catalog from catalog list
#    And user enters the search text "EDIGENDER" and clicks on search
#    And user selects the "PIIAttribute" from the Type
#    And user clicks on "EDIGENDER" item name link
#    And user enters the search text "EDIGENDER" and clicks on search
#    And user selects the "PIIProperty" from the Type
#    And user clicks on "gender_2" item name link
#    And user clicks on cross button in the Search Data Intelligence Suite area
#    And user selects "Business Glossary" catalog from catalog list
#    And user selects the "Analysis" from the Type
#    And user "click" on "AnalysisItem" containing "toIDPGDPR"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user clicks on logout button
#
#
#  @edibus @mlp-5587 @webtest @positive @toIDP
#  Scenario:MLP-5587 Verification of replicating the  PII attributes of in IDP after editing in EDI
#    Given user connects Rochade Server and "rename" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemType                 | itemName  | renameName      |
#      | AP-DATA      | PIITAG      | 1.0                | GDP_PERSONAL_INFORMATION | EDIGENDER | EDIGENDERUPDATE |
#    And user update json file "idc/EdiBusPayloads/IDPGDPRConfig.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                            | body                                  | response code | response message | jsonPath                                       |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                      | idc/EdiBusPayloads/IDPGDPRConfig.json | 204           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPGDPR |                                       | 200           | IDLE             | $.[?(@.configurationName=='toIDPGDPR')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPGDPR  |                                       | 200           |                  |                                                |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPGDPR |                                       | 200           | IDLE             | $.[?(@.configurationName=='toIDPGDPR')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user selects "Business Glossary" catalog from catalog list
#    And user enters the search text "EDIGENDER" and clicks on search
#    And user selects the "PIIAttribute" from the Type
#    Then user "verify presence" of following "Items List" in Item Search Results Page
#      | EDIGENDER       |
#      | EDIGENDERUPDATE |
#    And user enters the search text "EDIGENDERUPDATE" and clicks on search
#    And user selects the "PIIProperty" from the Type
#    And user clicks on "gender_2" item name link
#    And user clicks on cross button in the Search Data Intelligence Suite area
#    And user selects "Business Glossary" catalog from catalog list
#    And user selects the "Analysis" from the Type
#    And user "click" on "AnalysisItem" containing "toIDPGDPR"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 0                 |
#    And user clicks on logout button
#
#
#  @edibus @mlp-5439 @webtest @positive @release10.0 @toIDP
#  Scenario:MLP-5439 Verification of error when replicating the PII from EDI to IDP without glossary spacificaitons
#    Given user update json file "idc/EdiBusPayloads/MLP_5439_IDPGDPRConfigError.json" file for following values using property loader
#      | jsonPath                                           | jsonValues    |
#      | $..configurations[-1:].['EDI access'].['EDI host'] | EDIHostName   |
#      | $..configurations[-1:].['EDI access'].['EDI port'] | EDIPortNumber |
#    And Execute REST API with following parameters
#      | Header           | Query | Param | type         | url                                                                 | body                                                | response code | response message | jsonPath                                            |
#      | application/json |       |       | Put          | settings/analyzers/EDIBus                                           | idc/EdiBusPayloads/MLP_5439_IDPGDPRConfigError.json | 204           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPGDPRError |                                                     | 200           | IDLE             | $.[?(@.configurationName=='toIDPGDPRError')].status |
#      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/toIDPGDPRError  |                                                     | 200           |                  |                                                     |
#      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/toIDPGDPRError |                                                     | 200           | IDLE             | $.[?(@.configurationName=='toIDPGDPRError')].status |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user selects "Business Glossary" catalog from catalog list
#    And user selects the "Analysis" from the Type
#    And user "click" on "AnalysisItem" containing "toIDPGDPRError"
#    And METADATA widget should have following item values
#      | metaDataItem     | metaDataItemValue |
#      | Number of errors | 2                 |
#    And user clicks on log link and opens the log
#    And Analysis log should display the analysis info for below parameters
#      | type  | logValue                         | logLine      |
#      | ERROR | Glossary name must not be empty. | EDIBUS-E1307 |
#    And user clicks on logout button
#
#
#  @edibus @mlp-5439 @positive @release10.0
#  Scenario:MLP-5439 Clearing items created
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
#    And Status code 204 must be returned
#    And user get the column "gender_2" id from the following query
#      | description | schemaName       | tableName     | columnName | criteriaName |
#      | SELECT      | BusinessGlossary | V_PIIProperty | ID         | name         |
#    And user makes a REST Call to DELETE dataset "items/BusinessGlossary/BusinessGlossary.PIIProperty:::"
#    And user get the column "EDIGENDER" id from the following query
#      | description | schemaName       | tableName      | columnName | criteriaName |
#      | SELECT      | BusinessGlossary | V_PIIAttribute | ID         | name         |
#    And user makes a REST Call to DELETE dataset "items/BusinessGlossary/BusinessGlossary.PIIAttribute:::"
#    And user connects Rochade Server and "rename" the items in EDI subject area
#      | databaseName | subjectArea | subjectAreaVersion | itemType                 | itemName        | renameName |
#      | AP-DATA      | PIITAG      | 1.0                | GDP_PERSONAL_INFORMATION | EDIGENDERUPDATE | EDIGENDER  |
#    And user get the column "EDIGENDERUPDATE" id from the following query
#      | description | schemaName       | tableName      | columnName | criteriaName |
#      | SELECT      | BusinessGlossary | V_PIIAttribute | ID         | name         |
#    And user makes a REST Call to DELETE dataset "items/BusinessGlossary/BusinessGlossary.PIIAttribute:::"
#
