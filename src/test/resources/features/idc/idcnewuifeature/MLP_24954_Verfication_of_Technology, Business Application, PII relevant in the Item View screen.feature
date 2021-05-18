@MLP-24954
Feature:A_MLP- 24954 This feature is to verify the Technology, Business application and PII relevant is set or not

  ########################################################################Credential and DataSource Creation#######################################################################
  @regression @positiveRedshiftDataSource
  Scenario:Delete Credentials
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                         | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/Spectrum_Credentials   |      |               |                  |          |
      |                  |       |       | Delete | settings/credentials/AWS_Amazon_Credentials |      |               |                  |          |
      |                  |       |       | Delete | settings/credentials/Redshift_Credentials   |      |               |                  |          |

  Scenario Outline: Create Credential and Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | body                                                            | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Spectrum_Credentials   | ida/MLP-14361_Payloads/CredentialsSuccess.json                  | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/Spectrum_Credentials   |                                                                 | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonSpectrumDataSource | ida/AmazonSpectrumPayloads/AmazonSpectromDatasource_Config.json | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonSpectrumDataSource |                                                                 | 200           | SpectrumDS         |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/AWS_Amazon_Credentials | ida/AmazonSpectrumPayloads/Amzons3Credentials.json              | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/AWS_Amazon_Credentials |                                                                 | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Redshift_Credentials   | ida/AmazonSpectrumPayloads/AmazonRedshiftCredentials.json       | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/Redshift_Credentials   |                                                                 | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonS3DataSource       | ida/AmazonSpectrumPayloads/AmazonS3DataSourceConfig.json        | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonS3DataSource       |                                                                 | 200           | AmazonS3DataSource |          |

  @MLP-23104 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline: Create PII tags
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | bodyFile                                                              | path                | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | tags/Default/structures | payloads/ida/AmazonSpectrumPayloads/policyEngine/PIItagscreation.json | $.typePatterntagset | 200           |                  |          |


##################################################################Technology present , Business Application Present and PII relevant Yes #####################################################

  @MLP-24954 @webtest @regression @positive
  Scenario:MLP-24954:SC#1.0 Verify user able to add business application
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | Item_511  | Save   |


  @MLP-24954 @sanity @positive @regression @PIITag
  Scenario Outline:SC#1.1: Create spectrum cataloger, S3 Cataloger and spectrum analyser plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                 | bodyFile                                                                   | path                | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                              | payloads/ida/AmazonSpectrumPayloads/policyEngine/amazonspectrumpiitag.json | $.typePatterntagset | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger                                  | payloads/idc/IDX_PluginPayloads/MLP-24954_technology_BA_PIIrelevant.json   | $.CatalogConfig     | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger                                  |                                                                            |                     | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger/AmazonS3Cataloger                                              | payloads/idc/IDX_PluginPayloads/MLP-24954_technology_BA_PIIrelevant.json   | $.S3CatalogConfig   | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger/AmazonS3Cataloger                                              |                                                                            |                     | 200           | AmazonS3Cataloger       |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer                                    | payloads/idc/IDX_PluginPayloads/MLP-24954_technology_BA_PIIrelevant.json   | $.typePatterntagset | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer                                    |                                                                            |                     | 200           | AmazonSpectrumAnalyzer  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                            |                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/AmazonSpectrumCataloger/*                         |                                                                            |                     | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                            |                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonS3Cataloger/*                              |                                                                            |                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/AmazonS3Cataloger/*                               |                                                                            |                     | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonS3Cataloger/*                              |                                                                            |                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                            |                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer  |                                                                            |                     | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                            |                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |


 #QACID-7131189,7131190,7131191,7131192,7131193,7131195,7131197,7131198
  @MLP-24954 @webtest @regression @positive
  Scenario:MLP-24954:SC#1.2 Verify user able Technology present,Business Application Present and PII relevant Yes in UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "redshifttagallmatch" and clicks on search
    And user performs "facet selection" in "Cloud Data Warehouses" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "email" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ItemName             | Section           |
      | topbar     | Technology           | Redshift Spectrum |
      | topbar     | PII relevant         | Yes               |
      | topbar     | Business Application | Item_511          |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Item_511 |

  @MLP-24954 @regression @positive
  Scenario:SC#1.3_User Deletes the item from database
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type                | query | param |
      | SingleItemDelete | Default | cataloger/AmazonSpectrumCataloger/AmazonSpectrumCataloger/%      | Analysis            |       |       |
      | SingleItemDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer%      | Analysis            |       |       |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster             |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Cataloger%                   | Analysis            |       |       |
      | SingleItemDelete | Default | amazonaws.com                                                    | Cluster             |       |       |
      | SingleItemDelete | Default | Item_511                                                         | BusinessApplication |       |       |

  ####################################################################Technology present , Business Application N/A and PII relevant Yes #####################################################

  @MLP-24954 @sanity @positive @regression @PIITag
  Scenario Outline:SC#2.1: Create spectrum cataloger plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                 | bodyFile                                                                   | path                | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | policy/tagging/actions                                                                              | payloads/ida/AmazonSpectrumPayloads/policyEngine/amazonspectrumpiitag.json | $.namePatterntagset | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger                                  | payloads/idc/IDX_PluginPayloads/MLP-24954_technology_BA_PIIrelevant.json   | $.CatalogConfigone  | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger                                  |                                                                            |                     | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonS3Cataloger/AmazonS3Cataloger                                              | payloads/idc/IDX_PluginPayloads/MLP-24954_technology_BA_PIIrelevant.json   | $.S3CatalogConfig   | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonS3Cataloger/AmazonS3Cataloger                                              |                                                                            |                     | 200           | AmazonS3Cataloger       |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer                                    | payloads/idc/IDX_PluginPayloads/MLP-24954_technology_BA_PIIrelevant.json   | $.namePatterntagset | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer                                    |                                                                            |                     | 200           | AmazonSpectrumAnalyzer  |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                            |                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/AmazonSpectrumCataloger/*                         |                                                                            |                     | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/*                        |                                                                            |                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonS3Cataloger/*                              |                                                                            |                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/AmazonS3Cataloger/*                               |                                                                            |                     | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonS3Cataloger/*                              |                                                                            |                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonS3Cataloger')].status       |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                            |                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer  |                                                                            |                     | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer |                                                                            |                     | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumAnalyzer')].status  |

  #QACID-7131189,7131190,7131191,7131192,7131196,7131197,7131198
  @MLP-24954 @webtest @regression @positive
  Scenario:MLP-24954:SC#2.2 Verify user able see Technology present , Business Application N/A and PII relevant Yes
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "redshifttagallmatch" and clicks on search
    And user performs "facet selection" in "Cloud Data Warehouses" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "email" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ItemName             | Section           |
      | topbar     | Technology           | Redshift Spectrum |
      | topbar     | PII relevant         | Yes               |
      | topbar     | Business Application | N/A               |

  @MLP-24954 @regression @positive
  Scenario:SC#2.3_User Deletes the item from database
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type                | query | param |
      | SingleItemDelete | Default | cataloger/AmazonSpectrumCataloger/AmazonSpectrumCataloger/%      | Analysis            |       |       |
      | SingleItemDelete | Default | dataanalyzer/AmazonSpectrumAnalyzer/AmazonSpectrumAnalyzer%      | Analysis            |       |       |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster             |       |       |
      | SingleItemDelete | Default | cataloger/AmazonS3Cataloger/AmazonS3Cataloger%                   | Analysis            |       |       |
      | SingleItemDelete | Default | amazonaws.com                                                    | Cluster             |       |       |
      | SingleItemDelete | Default | Item_511                                                         | BusinessApplication |       |       |

  ####################################################################Technology present , Business Application Present and PII relevant No(tags assigned)#####################################################

  @MLP-24954 @webtest @regression @positive
  Scenario:MLP-24954:SC#3.0 Verify user able add Business application
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_511  |
    And user "click" on "Save" button in "Create Item Page"
    And user "click" on "PopUp X" button in "Create Item Page"


  @MLP-24954 @sanity @positive @regression @PIITag
  Scenario Outline:SC#3.1: Create spectrum cataloger plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile                                                                 | path                 | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger           | payloads/idc/IDX_PluginPayloads/MLP-24954_technology_BA_PIIrelevant.json | $.CatalogConfignotag | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger           |                                                                          |                      | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/* |                                                                          |                      | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/AmazonSpectrumCataloger/*  |                                                                          |                      | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/* |                                                                          |                      | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |


  #QACID-7131189,7131190,7131191,7131192,7131193,7131195,7131197,7131198
  @MLP-24954 @webtest @regression @positive
  Scenario:MLP-24954:SC#3.2 Verify user able see Technology present , Business Application Present and PII relevant No(tags assigned)
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "redhsifttagallempty" and clicks on search
    And user performs "facet selection" in "Cloud Data Warehouses" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "email" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ItemName             | Section           |
      | topbar     | Technology           | Redshift Spectrum |
      | topbar     | PII relevant         | No                |
      | topbar     | Business Application | Item_511          |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Item_511 |

  @MLP-24954 @regression @positive
  Scenario:SC#3.3_User Deletes the item from database
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type                | query | param |
      | SingleItemDelete | Default | Item_511                                                         | BusinessApplication |       |       |
      | SingleItemDelete | Default | cataloger/AmazonSpectrumCataloger/AmazonSpectrumCataloger/%      | Analysis            |       |       |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster             |       |       |


  ####################################################################Technology present , Business Application N/A and PII relevant No(General tags assigned)#####################################################

  @MLP-24954 @sanity @positive @regression @PIITag
  Scenario Outline:SC#4.1: Create spectrum cataloger plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile                                                                 | path                      | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger           | payloads/idc/IDX_PluginPayloads/MLP-24954_technology_BA_PIIrelevant.json | $.CatalogConfignoPIItagba | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger           |                                                                          |                           | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/* |                                                                          |                           | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/AmazonSpectrumCataloger/*  |                                                                          |                           | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/* |                                                                          |                           | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |


  #QACID-7131189,7131190,7131191,7131192,7131193,7131195,7131196,7131197,7131198
  @MLP-24954 @webtest @regression @positive
  Scenario:MLP-24954:SC#4.2 Verify user able see Technology present , Business Application N/A and PII relevant No(General tags assigned)
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "redhsifttagallempty" and clicks on search
    And user performs "facet selection" in "Cloud Data Warehouses" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "email" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ItemName             | Section           |
      | topbar     | Technology           | Redshift Spectrum |
      | topbar     | PII relevant         | No                |
      | topbar     | Business Application | N/A               |

  @MLP-24954 @regression @positive
  Scenario:SC#4.3_User Deletes the item from database
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type                | query | param |
      | SingleItemDelete | Default | Item_511                                                         | BusinessApplication |       |       |
      | SingleItemDelete | Default | cataloger/AmazonSpectrumCataloger/AmazonSpectrumCataloger/%      | Analysis            |       |       |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster             |       |       |

  ####################################################################Technology present , Business Application Present and PII relevant No#####################################################

  @MLP-24954 @webtest @regression @positive
  Scenario:MLP-24954:SC#5.0 Verify user able to create buisness application
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_511  |
    And user "click" on "Save" button in "Create Item Page"
    And user "click" on "PopUp X" button in "Create Item Page"

  @MLP-24954 @sanity @positive @regression @PIITag
  Scenario Outline:SC#5.1 : Create spectrum cataloger plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile                                                                 | path                    | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger           | payloads/idc/IDX_PluginPayloads/MLP-24954_technology_BA_PIIrelevant.json | $.CatalogConfignoPIItag | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger           |                                                                          |                         | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/* |                                                                          |                         | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/AmazonSpectrumCataloger/*  |                                                                          |                         | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/* |                                                                          |                         | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |


  #QACID-7131189,7131190,7131191,7131192,7131193,7131195,7131197,7131198
  @MLP-24954 @webtest @regression @positive
  Scenario:MLP-24954:SC#5.2 Verify user able see Technology present , Business Application Present and PII relevant No
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "redshifttagallmatch" and clicks on search
    And user performs "facet selection" in "Cloud Data Warehouses" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "email" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ItemName             | Section           |
      | topbar     | Technology           | Redshift Spectrum |
      | topbar     | PII relevant         | No                |
      | topbar     | Business Application | Item_511          |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Item_511 |

  @MLP-24954 @regression @positive
  Scenario:SC#5.3_User Deletes the item from database
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type                | query | param |
      | SingleItemDelete | Default | Item_511                                                         | BusinessApplication |       |       |
      | SingleItemDelete | Default | cataloger/AmazonSpectrumCataloger/AmazonSpectrumCataloger/%      | Analysis            |       |       |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster             |       |       |

  ####################################################################Technology present , Business Application N/A and PII relevant No#####################################################

  @MLP-24954 @sanity @positive @regression @snowflake @PIITag
  Scenario Outline:SC#6.1: Create spectrum cataloger plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile                                                                 | path                         | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger           | payloads/idc/IDX_PluginPayloads/MLP-24954_technology_BA_PIIrelevant.json | $.CatalogConfignoPIItagandBa | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger           |                                                                          |                              | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/* |                                                                          |                              | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/AmazonSpectrumCataloger/*  |                                                                          |                              | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/* |                                                                          |                              | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |

  #QACID-7131189,7131190,7131191,7131192,7131196,7131197,7131198
  @MLP-24954 @webtest @regression @positive
  Scenario:MLP-24954:SC#6.2 Verify user able see Technology present , Business Application N/A and PII relevant No
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "redshifttagallmatch" and clicks on search
    And user performs "facet selection" in "Cloud Data Warehouses" attribute under "Tags" facets in Item Search results page
    And user performs "item click" on "email" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ItemName             | Section           |
      | topbar     | Technology           | Redshift Spectrum |
      | topbar     | PII relevant         | No                |
      | topbar     | Business Application | N/A               |

  @MLP-24954 @regression @positive
  Scenario:SC#6.3:user deletes the item from database
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | cataloger/AmazonSpectrumCataloger/AmazonSpectrumCataloger/%      | Analysis |       |       |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

  ####################################################################Technology N/A , Business Application N/A and PII relevant No#####################################################

   #QACID-7131189,7131190,7131191,7131192,7131196,7131197,7131198
  @MLP-24954 @webtest @regression @positive
  Scenario: SC#7:MLP-24954: To Verify the user is able to see Technology N/A , Business Application N/A and PII relevant No
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "employees_full" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ItemName             | Section |
      | topbar     | Technology           | N/A     |
      | topbar     | Business Application | N/A     |
      | topbar     | PII relevant         | No      |


  ########################################################################Tag, Credential and Data Source deletion######################################################################

  @MLP-24954 @sanity @positive @regression @PIITag
  Scenario Outline:Replace original PII tags
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                     | bodyFile                                                                 | path                | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Put  | tags/Default/structures | payloads/ida/AmazonSpectrumPayloads/policyEngine/PIItagsreplacement.json | $.typePatterntagset | 200           |                  |          |

  @regression @positiveRedshiftDataSource
  Scenario:Delete Configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                         | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/Spectrum_Credentials   |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/AWS_Amazon_Credentials |      | 200           |                  |          |
      |                  |       |       | Delete | settings/credentials/Redshift_Credentials   |      | 200           |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonSpectrumDataSource |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonS3DataSource       |      | 204           |                  |          |