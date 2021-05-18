@MLP-20303
Feature: Z_MLP-20303_Integrate Policy version 2.9.0 in DI

  ##  Please Upload OracleDB Plugin and Ojdbc8 Driver ##

  @MLP-20303 @webtest @positive @regression
  Scenario:MLP-20303:SC#1_1_Delete the Default tagging policy
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Tagging Policy" in "Landing page"
    And User performs following actions in the Tagging Policy Page
      | Actiontype | ActionItem         | ItemName |
      | Click      | Rule               | Default  |
      | Click      | Rule Delete Button | Default  |
    And user "click" on "DELETE" button in "popup"
    And User performs following actions in the Tagging Policy Page
      | Actiontype          | ActionItem           | ItemName |
      | Verify Non Presence | Rule for Plugin Type | Default  |


  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#1_2_Add Credentials and Database for Oracle
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                    | body                                     | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/OracleCredentials | idc/TaggingPolicy/OracleCredentials.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Get  | settings/credentials/OracleCredentials |                                          | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBDataSource  | idc/TaggingPolicy/OracleDataSource.json  | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBDataSource  |                                          | 200           | OracleDS         |          |


  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#1_3_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                  | path             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | tags/Default/structures                                                              | payloads/idc/TaggingPolicy/OraclePIITags.json             | $.PIIConfig      | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/idc/TaggingPolicy/OracleDBTag.json               | $.SC1            | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/idc/TaggingPolicy/OracleCatalogerTagsConfig.json | $.CatalogConfig  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                           |                  | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                           |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                           |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                           |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/idc/TaggingPolicy/OracleAnalyzerTagsConfig.json  | $.AnalyzerConfig | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                           |                  | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                           |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                           |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                           |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |


    ## 7148429 ##
  @MLP-20303 @webtest @positive @regression
  Scenario:MLP-20303:SC#1_4_Verify if user is able to add the tag rule in Tagging Policy and tag should be assigned to the value in DD UI as per rule
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag                                                                      | fileName  | userTag             |
      | Default     | OracleAnalyzer | Tags  | OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY,Email Address | EMAIL     | TAGDETAILS_ALLMATCH |
      | Default     | OracleAnalyzer | Tags  | OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY,Gender        | GENDER    | TAGDETAILS_ALLMATCH |
      | Default     | OracleAnalyzer | Tags  | OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY,IP Address    | IPADDRESS | TAGDETAILS_ALLMATCH |
      | Default     | OracleAnalyzer | Tags  | OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY,SSN           | SSN       | TAGDETAILS_ALLMATCH |
      | Default     | OracleAnalyzer | Tags  | OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY,Full Name     | FULL_NAME | TAGDETAILS_ALLMATCH |


  @MLP-20303 @positive @regression
  Scenario:MLP-20303:SC#1_5_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |

  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#2_1_Add Credentials and Database for Oracle
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                   | body                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBDataSource | idc/TaggingPolicy/OracleDataSource.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBDataSource |                                         | 200           | OracleDS         |          |

  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#2_1_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                  | path      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                               | payloads/idc/TaggingPolicy/OracleDBTag.json               | $.SC2     | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/idc/TaggingPolicy/OracleCatalogerTagsConfig.json | $.Filter1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                           |           | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                           |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                           |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                           |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/idc/TaggingPolicy/OracleAnalyzerTagsConfig.json  | $.Filter1 | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                           |           | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                           |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                           |           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                           |           | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |


    ## 7148430 ##
  @MLP-20303 @webtest @positive @regression
  Scenario:MLP-20303:SC#2_2_Verify if user is able to update the tag rule in Tagging Policy and tag should be assigned to the value in DD UI as per rule
  (Ex: 0.2 - 2 or more rows should have matching column values)- Match Empty is False
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name           | facet | Tag                                                                      | fileName  | userTag                              |
      | Default     | OracleAnalyzer | Tags  | OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY,Email Address | EMAIL     | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | OracleAnalyzer | Tags  | OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY,Gender        | GENDER    | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | OracleAnalyzer | Tags  | OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY,IP Address    | IPADDRESS | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | OracleAnalyzer | Tags  | OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY,SSN           | SSN       | TAGDETAILS_Ratiolessthan05EmptyFalse |
      | Default     | OracleAnalyzer | Tags  | OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY,Full Name     | FULL_NAME | TAGDETAILS_Ratiolessthan05EmptyFalse |


  @MLP-20303 @positive @regression
  Scenario:MLP-20303:SC#2_3_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |


  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#3_1_Delete OracleDBAnalyzer Tagging Policy Rule
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                                                     | bodyFile | path | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Delete | policy/tagging/analysis?dataType=STRUCTURED&pluginName=OracleDBAnalyzer |          |      | 204           |                  |          |

  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#3_2_Add Credentials and Database for Oracle
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                   | body                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBDataSource | idc/TaggingPolicy/OracleDataSource.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBDataSource |                                         | 200           | OracleDS         |          |

  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#3_2_Create OracleDB Plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                  | bodyFile                                                  | path             | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               | payloads/idc/TaggingPolicy/OracleCatalogerTagsConfig.json | $.CatalogConfig  | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBCataloger/OracleDBCataloger                               |                                                           |                  | 200           | OracleDBCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                           |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger   |                                                           |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/OracleDBCataloger  |                                                           |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 | payloads/idc/TaggingPolicy/OracleAnalyzerTagsConfig.json  | $.AnalyzerConfig | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/OracleDBAnalyzer/OracleDBAnalyzer                                 |                                                           |                  | 200           | OracleDBAnalyzer  |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                           |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer  |                                                           |                  | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer |                                                           |                  | 200           | IDLE              | $.[?(@.configurationName=='OracleDBAnalyzer')].status  |


  ## 7148431 ##
  @MLP-20303 @webtest @positive @regression
  Scenario:MLP-20303:SC#3_3_Verify if user is able to delete the tag rule in Tagging Policy and tag should not assigned to the value in DD UI as per rule
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SSN" and clicks on search
    And user performs "facet selection" in "OracleCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TAGDETAILS_ALLMATCH [Table]" attribute under "Hierarchy" facets in Item Search results page
    Then the following tags "OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY" should get displayed for the column "SSN"
    And user enters the search text "FULL_NAME" and clicks on search
    And user performs "facet selection" in "OracleCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "TAGDETAILS_ALLMATCH [Table]" attribute under "Hierarchy" facets in Item Search results page
    Then the following tags "OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY" should get displayed for the column "FULL_NAME"


  @MLP-20303 @positive @regression
  Scenario:MLP-20303:SC#3_4_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                            | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                 | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleDBCataloger%  | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleDBAnalyzer% | Analysis |       |       |


  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#4_1_Validate if policy engine is up and user is able to retrieve all policy tags
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    And user "encodePolicyEngine" value from file "idc/TaggingPolicy/policyEngine/dynamicPassword.txt" and write to file "idc/TaggingPolicy/policyEngine/webToken.txt"
    Examples:
      | ServiceName | user       | Header       | Query | Param | type | url                                                 | body | response code | response message | filePath                                                    | jsonPath   |
      | IDC         | TestSystem | AcceptFormat |       |       | Get  | settings/user?path=com/asg/dis/platform/policy.json |      | 200           |                  | payloads/idc/TaggingPolicy/policyEngine/dynamicPassword.txt | $.password |
    Examples:
      | ServiceName  | user       | Header               | Query | Param | type | url                                                                               | body | response code | response message | filePath                                                 | jsonPath |
      | PolicyEngine | policyUser | AcceptDecisionTables |       |       | Get  | policy/decisionmodels/ASG.DI.DataAnalysis/decisiontables/ASG.DI.DataAnalysisTable |      | 200           |                  | payloads/idc/TaggingPolicy/policyEngine/defaultTags.json |          |


  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#4_2_Update policy engine with new tag
    Given user copy the data from "rest/payloads/idc/TaggingPolicy/policyEngine/defaultTags.json" file to "rest/payloads/idc/TaggingPolicy/policyEngine/updatedTags.json" file
    And user "append" the json file "idc/TaggingPolicy/policyEngine/newTag.json" file for following values
      | jsonPath | jsonObjectFilePath                              |
      | $.rules  | idc/TaggingPolicy/policyEngine/updatedTags.json |
    And user copy the data from "rest/payloads/idc/TaggingPolicy/policyEngine/updatedTags.json" file to "rest/payloads/idc/TaggingPolicy/policyEngine/updatedTags.txt" file
    And user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName  | user       | Header              | Query | Param | type | url                                                                               | body                                                    | response code | response message | filePath | jsonPath |
      | PolicyEngine | policyUser | AcceptDecisionRules |       |       | Put  | policy/decisionmodels/ASG.DI.DataAnalysis/decisiontables/ASG.DI.DataAnalysisTable | payloads/idc/TaggingPolicy/policyEngine/updatedTags.txt | 200           |                  |          |          |

  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#4_3_Add Credentials and Database for Oracle
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                   | body                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBDataSource | idc/TaggingPolicy/OracleDataSource.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBDataSource |                                         | 200           | OracleDS         |          |

  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#4_3_Run the OracleDB Cataloger and Analyzer Plugin to Verify the user defined PII Tag
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                           | response code | response message                        | jsonPath                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | idc/TaggingPolicy/OracleCatalogerWithSchemaAndTableFilter.json | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                | 200           | OracleCatalogerWithSchemaAndTableFilter |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    |                                                                | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | idc/TaggingPolicy/OracleAnalyzer.json                          | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                | 200           | OracleAnalyzer                          |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzer')].status                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  |                                                                | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzer')].status                          |


    ## 7148432 ##
  @MLP-20303 @positive @regression @webtest
  Scenario:MLP-20303:SC#4_4_Verify if user is able to add the tag rule in Policy Engine and tag should be assigned to the value in DD UI as per rule
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "FULL_NAME" and clicks on search
    And user performs "facet selection" in "Oracle" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    Then the following tags "OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY,User Defined PII Tag" should get displayed for the column "FULL_NAME"


  @MLP-20303 @positive @regression
  Scenario:MLP-20303:SC#4_5_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter% | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzer%                        | Analysis |       |       |


  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#5_1_Update policy engine for the existing tag
    Given user "update" the json file "idc/TaggingPolicy/policyEngine/updatedTags.json" file for following values
      | jsonPath                                            | jsonValues                      | type   |
      | $..[?(@.comments=='Full Name')].outputEntry[0].text | "\d{3}[ -]{1}\d{2}[ -]{1}\d{4}" | String |
    And user copy the data from "rest/payloads/idc/TaggingPolicy/policyEngine/updatedTags.json" file to "rest/payloads/idc/TaggingPolicy/policyEngine/updatedTags.txt" file
    And user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName  | user       | Header              | Query | Param | type | url                                                                               | body                                                    | response code | response message | filePath | jsonPath |
      | PolicyEngine | policyUser | AcceptDecisionRules |       |       | Put  | policy/decisionmodels/ASG.DI.DataAnalysis/decisiontables/ASG.DI.DataAnalysisTable | payloads/idc/TaggingPolicy/policyEngine/updatedTags.txt | 200           |                  |          |          |

  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#5_2_Add Credentials and Database for Oracle
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                   | body                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBDataSource | idc/TaggingPolicy/OracleDataSource.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBDataSource |                                         | 200           | OracleDS         |          |

  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#5_2_Run the OracleDB Cataloger and Analyzer Plugin to Verify update data pattern of the user defined PII Tag
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                           | response code | response message                        | jsonPath                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | idc/TaggingPolicy/OracleCatalogerWithSchemaAndTableFilter.json | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                | 200           | OracleCatalogerWithSchemaAndTableFilter |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    |                                                                | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | idc/TaggingPolicy/OracleAnalyzer.json                          | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                | 200           | OracleAnalyzer                          |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzer')].status                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  |                                                                | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzer')].status                          |


  ## 7148433 ##
  @MLP-20303 @positive @regression @webtest
  Scenario:MLP-20303:SC#5_3_Verify if user is able to update the tag rule in Policy Engine and tag should be assigned to the value in DD UI as per rule
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SSN" and clicks on search
    And user performs "facet selection" in "OracleCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    Then the following tags "OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY,User Defined PII Tag" should get displayed for the column "SSN"


  @MLP-20303 @positive @regression
  Scenario:MLP-20303:SC#5_4_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter% | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzer%                        | Analysis |       |       |


  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#6_1_Delete policy engine for the existing tag
    Given user copy the data from "rest/payloads/idc/TaggingPolicy/policyEngine/defaultTags.json" file to "rest/payloads/idc/TaggingPolicy/policyEngine/updatedTags.json" file
    And user copy the data from "rest/payloads/idc/TaggingPolicy/policyEngine/updatedTags.json" file to "rest/payloads/idc/TaggingPolicy/policyEngine/updatedTags.txt" file
    And user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName  | user       | Header              | Query | Param | type | url                                                                               | body                                                    | response code | response message | filePath | jsonPath |
      | PolicyEngine | policyUser | AcceptDecisionRules |       |       | Put  | policy/decisionmodels/ASG.DI.DataAnalysis/decisiontables/ASG.DI.DataAnalysisTable | payloads/idc/TaggingPolicy/policyEngine/updatedTags.txt | 200           |                  |          |          |

  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#6_2_Add Credentials and Database for Oracle
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                   | body                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/OracleDBDataSource | idc/TaggingPolicy/OracleDataSource.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/OracleDBDataSource |                                         | 200           | OracleDS         |          |

  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#6_2_Run the OracleDB Cataloger and Analyzer Plugin to Verify the user defined PII Tag is removed
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                   | body                                                           | response code | response message                        | jsonPath                                                                     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBCataloger                                  | idc/TaggingPolicy/OracleCatalogerWithSchemaAndTableFilter.json | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBCataloger                                  |                                                                | 200           | OracleCatalogerWithSchemaAndTableFilter |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/OracleDBCataloger/*    |                                                                | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/OracleDBCataloger/*   |                                                                | 200           | IDLE                                    | $.[?(@.configurationName=='OracleCatalogerWithSchemaAndTableFilter')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/OracleDBAnalyzer                                   | idc/TaggingPolicy/OracleAnalyzer.json                          | 204           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/OracleDBAnalyzer                                   |                                                                | 200           | OracleAnalyzer                          |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzer')].status                          |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/OracleDBAnalyzer/*  |                                                                | 200           |                                         |                                                                              |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/OracleDBAnalyzer/* |                                                                | 200           | IDLE                                    | $.[?(@.configurationName=='OracleAnalyzer')].status                          |


    ## 7148434 ##
  @MLP-20303 @positive @regression @webtest
  Scenario:MLP-20303:SC#6_3_Verify if user is able to delete the tag rule in Policy Engine and tag should not assigned to the value in DD UI as per rule
    When User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "SSN" and clicks on search
    And user performs "facet selection" in "OracleCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    Then the following tags "OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY" should get displayed for the column "SSN"
    And user enters the search text "FULL_NAME" and clicks on search
    And user performs "facet selection" in "OracleCataloger" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "ORACLE_TAG_DETAILS [Table]" attribute under "Hierarchy" facets in Item Search results page
    Then the following tags "OracleAnalyzer,Oracle,OracleCataloger,Oracle_Cat,Oracle_AY" should get displayed for the column "FULL_NAME"


  @MLP-20303 @positive @regression
  Scenario:MLP-20303:SC#6_4_Delete Cluster , Cataloger and Analyzer Analysis file
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                                 | type     | query | param |
      | SingleItemDelete | Default | diqscanora01v.diq.qa.asgint.loc                                      | Cluster  |       |       |
      | SingleItemDelete | Default | cataloger/OracleDBCataloger/OracleCatalogerWithSchemaAndTableFilter% | Analysis |       |       |
      | SingleItemDelete | Default | dataanalyzer/OracleDBAnalyzer/OracleAnalyzer%                        | Analysis |       |       |


  @MLP-20593@regression @positive
  Scenario Outline:MLP-20303:SC#7_1_Create BusinessApplication
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BATrustPolicy.json | 200           |                  |          |


    ## 7153587 ##
  @MLP-20593 @regression @positive @webtest
  Scenario:MLP-20303:SC#7_2_Verify if user is able to add the trust score rule in Trust Policy and trust score should be assigned to the value in DD UI as per rule
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And User performs following actions in the Trust Policy Page
      | Actiontype       | ActionItem     | ItemName            |
      | Click            | Rule           | BusinessApplication |
      | Enter rule value | Weight         | 4                   |
      | Enter rule value | Filter         | businessOwners      |
      | Enter rule value | Label          | Business Owners     |
      | Click            | Save Rule form |                     |
    And user enters the search text "BA_TrustPolicy" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_TrustPolicy" item from search results
    And User performs following actions in the Item view Page
      | Actiontype           | ActionItem      | ItemName             |
      | Click                | EditBAName      |                      |
      | Enter Business Owner | Business Owners | Venkatesan Rangadass |
      | Click                | SaveBAName      |                      |
    And user refreshes the application
    And User Clicks TrustScore Expand in Item View page
    And User performs following actions in the Item view Page
      | Actiontype               | ActionItem | ItemName        |
      | Verify Trust Score Value | 10.53      | Business Owners |


  @MLP-20593@regression @positive
  Scenario:MLP-20303:SC#7_3_Delete an BA Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name           | type                | query | param |
      | SingleItemDelete | Default | BA_TrustPolicy | BusinessApplication |       |       |


  @MLP-20593@regression @positive
  Scenario Outline:MLP-20303:SC#8_1_Create BusinessApplication
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BATrustPolicy.json | 200           |                  |          |


    ## 7153589 ##
  @MLP-20593 @regression @positive @webtest
  Scenario:MLP-20303:SC#8_2_Verify if user is able to update the trust score rule in Trust Policy and trust score should be assigned to the value in DD UI as per rule
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And User performs following actions in the Trust Policy Page
      | Actiontype       | ActionItem     | ItemName            |
      | Click            | Rule           | BusinessApplication |
      | Enter rule value | Weight         | 5                   |
      | Enter rule value | Filter         | businessOwners      |
      | Enter rule value | Label          | Business Owners     |
      | Click            | Save Rule form |                     |
    And user enters the search text "BA_TrustPolicy" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_TrustPolicy" item from search results
    And User performs following actions in the Item view Page
      | Actiontype           | ActionItem      | ItemName             |
      | Click                | EditBAName      |                      |
      | Enter Business Owner | Business Owners | Venkatesan Rangadass |
      | Click                | SaveBAName      |                      |
    And user refreshes the application
    And User Clicks TrustScore Expand in Item View page
    And User performs following actions in the Item view Page
      | Actiontype               | ActionItem | ItemName        |
      | Verify Trust Score Value | 12.82      | Business Owners |


  @MLP-20593@regression @positive
  Scenario:MLP-20303:SC#8_3_Delete an BA Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name           | type                | query | param |
      | SingleItemDelete | Default | BA_TrustPolicy | BusinessApplication |       |       |


  @MLP-20593@regression @positive
  Scenario Outline:MLP-20303:SC#9_1_Create BusinessApplication
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BATrustPolicy.json | 200           |                  |          |


  ## 7153593 ##
  @MLP-20593 @regression @positive @webtest
  Scenario:MLP-20303:SC#9_2_Verify if user is able to delete the trust score rule in Trust Policy and trust score should not assigned to the value in DD UI as per rule
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And User performs following actions in the Trust Policy Page
      | Actiontype       | ActionItem     | ItemName            |
      | Click            | Rule           | BusinessApplication |
      | Enter rule value | Weight         | 0                   |
      | Enter rule value | Filter         | businessOwners      |
      | Enter rule value | Label          | Business Owners     |
      | Click            | Save Rule form |                     |
    And user enters the search text "BA_TrustPolicy" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_TrustPolicy" item from search results
    And User performs following actions in the Item view Page
      | Actiontype           | ActionItem      | ItemName             |
      | Click                | EditBAName      |                      |
      | Enter Business Owner | Business Owners | Venkatesan Rangadass |
      | Click                | SaveBAName      |                      |
    And user refreshes the application
    And User Clicks TrustScore Expand in Item View page
    And User performs following actions in the Item view Page
      | Actiontype               | ActionItem | ItemName        |
      | Verify Trust Score Value | 0          | Business Owners |


  @MLP-20593@regression @positive
  Scenario:MLP-20303:SC#9_3_Delete an BA Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name           | type                | query | param |
      | SingleItemDelete | Default | BA_TrustPolicy | BusinessApplication |       |       |


  @MLP-20303 @positive @regression
  Scenario Outline:MLP-20303:SC#10_Delete Plugin Configuration
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type   | url                                    | body | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/credentials/OracleCredentials |      | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBDataSource  |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBCataloger   |      | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Delete | settings/analyzers/OracleDBAnalyzer    |      | 204           |                  |          |