@MLP-25471@MLP-25469
Feature:A_MLP-25471: This feature is to release the tagged data elements that were added via plugin configuration under capture Tab
  MLP-25469: This feature is to release the Assign the plugin configuration into the capture Tab

  Scenario Outline: Create Credential and Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | body                                                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Spectrum_Credentials   | ida/MLP-14361_Payloads/CredentialsSuccess.json                  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/Spectrum_Credentials   |                                                                 | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonSpectrumDataSource | ida/AmazonSpectrumPayloads/AmazonSpectromDatasource_Config.json | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonSpectrumDataSource |                                                                 | 200           | SpectrumDS       |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Redshift_Credentials   | ida/AmazonSpectrumPayloads/AmazonRedshiftCredentials.json       | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/credentials/Redshift_Credentials   |                                                                 | 200           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftDataSource | ida/AmazonSpectrumPayloads/AmazonRedshiftDataSource.json        | 204           |                  |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonRedshiftDataSource |                                                                 | 200           | RedshiftDS       |          |

  @MLP-25471 @webtest @regression @positive
  Scenario:MLP-25471:SC#1.0 Verify user https://dechedocker01v.asg.com/IDP/logs/log-node/messages.log?length=2000able to create business application
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | Item_511  | Save   |

  ##7148123#7148124#7148125s
  @MLP-25471 @sanity @positive @regression @PIITag
  Scenario Outline:SC#1.1: Create spectrum cataloger plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile                                                                 | path            | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger           | payloads/idc/IDX_PluginPayloads/MLP-24954_technology_BA_PIIrelevant.json | $.CatalogConfig | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger           |                                                                          |                 | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/* |                                                                          |                 | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/AmazonSpectrumCataloger/*  |                                                                          |                 | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/* |                                                                          |                 | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonRedshiftAnalyzer/AmazonRedshiftAnalyzer             | payloads/idc/IDX_PluginPayloads/MLP-24954_technology_BA_PIIrelevant.json | $.Redshift      | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonRedshiftAnalyzer/AmazonRedshiftAnalyzer             |                                                                          |                 | 200           | AmazonRedshiftAnalyzer  |                                                              |

  ##7148121
  @positve @regression @sanity @webtest @PIITag
  Scenario:SC#1.2:Verify Tag is set for the column when match empty is false
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                                     | fileName | userTag             |
      | Default     | Redshift Spectrum | Tags  | Redshift Spectrum,spectrumctag,Item_511 | email    | redhsifttagallempty |

  ##7148115#7148116#7148118#7148119#7148120#7153656
  @MLP-25471 @webtest @regression @positive
  Scenario:MLP-25471:SC#1.3:verify the user validates plugin configuration under Data Tab in business application
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                 | ItemName                   | Section                 |
      | Plugin Configuration Accordion | Expand Accordion           | AmazonSpectrumCataloger    |                         |
      | Plugin Configuration Accordion | Verify Header Menu options | Unassign the configuration | AmazonSpectrumCataloger |
      | Plugin Configuration Accordion | Click Header Menu options  | Unassign the configuration | AmazonSpectrumCataloger |
      | Click                          | BAeditdisable              | Edit                       |                         |

  ##7148115#7148116#7148118#7148119#7148120#
  @MLP-25471 @webtest @regression @positive
  Scenario:MLP-25471:SC#1.4:verify the user have an option to release the plugin configuration under Data Tab in business application
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                 | ItemName                   | Section                 |
      | Plugin Configuration Accordion | Expand Accordion           | AmazonSpectrumCataloger    |                         |
      | Plugin Configuration Accordion | Verify Header Menu options | Unassign the configuration | AmazonSpectrumCataloger |
      | Plugin Configuration Accordion | Click Header Menu options  | Unassign the configuration | AmazonSpectrumCataloger |
    And user "click" on "CANCEL" button in "Popup Window"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                 | ItemName                   | Section                 |
      | Plugin Configuration Accordion | Verify Header Menu options | Unassign the configuration | AmazonSpectrumCataloger |

  ##7148115#7148116#7148117#7148118#7148119#7148120#
  @MLP-25471 @webtest @regression @positive
  Scenario:MLP-25471:SC#1.5:verify the user have an option to release the plugin configuration under Data Tab in business application
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                 | ItemName                   | Section                 |
      | Plugin Configuration Accordion | Expand Accordion           | AmazonSpectrumCataloger    |                         |
      | Plugin Configuration Accordion | Verify Header Menu options | Unassign the configuration | AmazonSpectrumCataloger |
      | Plugin Configuration Accordion | Click Header Menu options  | Unassign the configuration | AmazonSpectrumCataloger |
    And user "click" on "UNASSIGN" button in "Popup Window"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem        | ItemName                | Section |
      | Plugin Configuration Accordion | Accordion absence | AmazonSpectrumCataloger |         |

  ##7148115#7148116#7148118#7148119#7148122#7148120#
  @MLP-25471 @webtest @regression @positive
  Scenario:SC#1.6:MLP-25471: Verify the Business application is detached for the release plugin configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Configurations" in "Landing page"
    And user performs "click" operation in Manage Configurations panel
      | button          | actionItem   |
      | Open Deployment | InternalNode |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem         | ItemName                |
      | Plugin Configuration Accordion | Accordion presence | AmazonSpectrumCataloger |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem         | ItemName                | Section |
      | Plugin Configuration Accordion | Accordion presence | AmazonSpectrumCataloger |         |
      | Plugin Configuration Accordion | Expand Accordion   | AmazonSpectrumCataloger |         |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem                        | ItemName |
      | Verify Plugin Configuration Values | Assigned to Business Application: | N/A      |

  #7148122
  @positve @regression @sanity @webtest
  Scenario:SC#1.7:Verify Tag is set for the column when match empty is false
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name              | facet | Tag                            | fileName | userTag             |
      | Default     | Redshift Spectrum | Tags  | Redshift Spectrum,spectrumctag | email    | redhsifttagallempty |

  @MLP-25471 @regression @positive
  Scenario:User Deletes the item from database
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type     | query | param |
      | SingleItemDelete | Default | cataloger/AmazonSpectrumCataloger/AmazonSpectrumCataloger/%      | Analysis |       |       |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster  |       |       |

  @cr-data @sanity @positive
  Scenario:Delete Git Cred
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                          | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/GitCred |      |               |                  |          |

  @git
  Scenario: Create Datasource and Credentials for GitCollector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                             | body                                                                 | response code | response message |
      | application/json | raw   | false | Put  | settings/credentials/GitCred                    | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | 200           |                  |
      |                  |       |       | Get  | settings/credentials/GitCred                    |                                                                      | 200           |                  |
      |                  |       |       | Put  | settings/analyzers/GitCollectorDataSource/GitDS | idc/IDX_PluginPayloads/MLP-14102_GitCollector_DataSource_Config.json | 204           |                  |
      |                  |       |       | Get  | settings/analyzers/GitCollectorDataSource/GitDS |                                                                      | 200           | GitDS            |

  @git
  Scenario: Create Plugin for GitCollector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                | body                                                             | response code | response message   | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Put  | settings/analyzers/GitCollector/GitCollectorConfig | idc/IDX_PluginPayloads/MLP-14104_GitCollector_Plugin_Config.json | 204           |                    |          |              |          |
      |                  |       |       | Get  | settings/analyzers/GitCollector/GitCollectorConfig |                                                                  | 200           | GitCollectorConfig |          |              |          |


  @git @precondition
  Scenario:SC2#Run the Git Collector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message |
      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           |                  |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorConfig  |      | 200           |                  |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           |                  |

  ##7148123#7148124#7148125
  @MLP-25471 @sanity @positive @regression
  Scenario Outline:SC#2: Create spectrum cataloger plugin config and start it
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                          | bodyFile                                                                 | path            | response code | response message        | jsonPath                                                     |
      | IDC         | TestSystemUser | application/json |       |       | Put          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger           | payloads/idc/IDX_PluginPayloads/MLP-24954_technology_BA_PIIrelevant.json | $.CatalogConfig | 204           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonSpectrumCataloger/AmazonSpectrumCataloger           |                                                                          |                 | 200           | AmazonSpectrumCataloger |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/* |                                                                          |                 | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/InternalNode/cataloger/AmazonSpectrumCataloger/*  |                                                                          |                 | 200           |                         |                                                              |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/cataloger/AmazonSpectrumCataloger/* |                                                                          |                 | 200           | IDLE                    | $.[?(@.configurationName=='AmazonSpectrumCataloger')].status |


  #7148101#7148109
  @MLP-25469 @webtest @regression @positive
  Scenario:MLP-25469:SC#2.1:verify the user validates contextual message in plugin configuration and assign button disabled by default
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user "click" on "Assign existing configuration" button in "Item View page"
    And user "Verify contextual message" in Create new item page
      | Message                                                             |
      | Select a plugin configuration and assign it to Business Application |
    And user verifies "Assign Button" is "disabled" in "Assign existing Configuration to Business Application"

  ##7148101#7148102
  @MLP-25469 @webtest @regression @positive
  Scenario:MLP-25469:SC#2.2_Verify that the user can search for a plugin config and selects the configuration.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user "click" on "Assign existing configuration" button in "Item View page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem  |
      | Click      | Search Icon |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem                                         |
      | Searchconfig | Collector for GitCollector is "GitCollectorConfig" |
    Then user verify "Presence of Search Configuration" with following values under "Tag Search in Itew View " section in item search results page
      | Collector for GitCollector is "GitCollectorConfig" |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Click      | Close      |

  ##7148101##7148103
  @MLP-25469 @webtest @regression @positive
  Scenario:MLP-25469:SC#2.3_Verify the information label when no configuration is added
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user "click" on "Assign existing configuration" button in "Item View page"
    And User performs following actions in the Item view Page
      | Actiontype                        | ActionItem                |
      | Verify Plugin Information Message | No Configuration selected |


  ##7148101##7148104#7148105#7148107
  @MLP-25469 @webtest @regression @positive
  Scenario:MLP-25469:SC#2.4_Verify validate the added label and remove the configuration from the selected configuration section
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user "click" on "Assign existing configuration" button in "Item View page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem  |
      | Click      | Search Icon |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem                                         |
      | Searchconfig | Collector for GitCollector is "GitCollectorConfig" |
    Then user verify "Presence of Search Configuration" with following values under "Tag Search in Item View " section in item search results page
      | Collector for GitCollector is "GitCollectorConfig" |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem      | Section                                            |
      | Click      | Configselection | Collector for GitCollector is "GitCollectorConfig" |
    Then user verify "Presence of Search Configuration" with following values under "Tag Search in Item View " section in item search results page
      | Collector for GitCollector is "GitCollectorConfig" |
    And User performs following actions in the Item view Page
      | Actiontype            | ItemName | ActionItem                                         | Section                |
      | Verify Label Presence | "added"  | Collector for GitCollector is "GitCollectorConfig" | Selected Configuration |
    And User performs following actions in the "Assign a Business Application" popup
      | Actiontype                        | ActionItem                                         | Section                |
      | Remove tagged item in the Section | Collector for GitCollector is "GitCollectorConfig" | Selected Configuration |
    And user verifies "Assign Button" is "disabled" in "Assign existing Configuration to Business Application"

  #7148108
  @MLP-25469 @webtest @regression @positive
  Scenario:MLP-18355:SC#2.5_Verify cancel functionality in the in assign configuration page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user "click" on "Assign existing configuration" button in "Item View page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem  |
      | Click      | Search Icon |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem                                         |
      | Searchconfig | Collector for GitCollector is "GitCollectorConfig" |
    Then user verify "Presence of Search Configuration" with following values under "Tag Search in Item View " section in item search results page
      | Collector for GitCollector is "GitCollectorConfig" |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem      | Section                                            |
      | Click      | Configselection | Collector for GitCollector is "GitCollectorConfig" |
    And user "click" on "Cancel button" button in "Assign existing Configuration to Business Application"
    And user "click" on "Yes" button in "Popup Window"
    And user verifies whether "Item view page title" is "displayed" for "Item_511" Item view page

  #7148108#7148110
  @MLP-25469 @webtest @regression @positive
  Scenario:MLP-18355:SC#2.6_Verify assign functionality after adding plugin configuration .
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user "click" on "Assign existing configuration" button in "Item View page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem  |
      | Click      | Search Icon |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem                                         |
      | Searchconfig | Collector for GitCollector is "GitCollectorConfig" |
    Then user verify "Presence of Search Configuration" with following values under "Tag Search in Item View " section in item search results page
      | Collector for GitCollector is "GitCollectorConfig" |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem      | Section                                            |
      | Click      | Configselection | Collector for GitCollector is "GitCollectorConfig" |
    And user "click" on "Cancel button" button in "Assign existing Configuration to Business Application"
    And user "click" on "No" button in "Popup Window"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem   |
      | Click      | Assignconfig |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem         | ItemName           |
      | Plugin Configuration Accordion | Accordion presence | GitCollectorConfig |

  #7148108
  @MLP-25469 @webtest @regression @positive
  Scenario:MLP-18355:SC#2.7_Verify plugin validation after unasign functionality
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                   | Section            |
      | Plugin Configuration Accordion | Expand Accordion          | GitCollectorConfig         |                    |
      | Plugin Configuration Accordion | Click Header Menu options | Unassign the configuration | GitCollectorConfig |
    And user "click" on "UNASSIGN" button in "Popup Window"
    And user "click" on "Assign existing configuration" button in "Item View page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem  |
      | Click      | Search Icon |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem                                         |
      | Searchconfig | Collector for GitCollector is "GitCollectorConfig" |
    Then user verify "Presence of Search Configuration" with following values under "Tag Search in Item View " section in item search results page
      | Collector for GitCollector is "GitCollectorConfig" |


  ##7148101##7148106#7148108#7148111#7148112#7148113
  @MLP-25469 @webtest @regression @positive
  Scenario:MLP-18355:SC#2.8_Verify multiple plugin assign functionality
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem         | ItemName                |
      | Plugin Configuration Accordion | Accordion presence | AmazonSpectrumCataloger |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                   | Section                 |
      | Plugin Configuration Accordion | Expand Accordion          | AmazonSpectrumCataloger    |                         |
      | Plugin Configuration Accordion | Click Header Menu options | Unassign the configuration | AmazonSpectrumCataloger |
    And user "click" on "UNASSIGN" button in "Popup Window"
    And user "click" on "Assign existing configuration" button in "Item View page"
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem                                                         |
      | Click        | Search Icon                                                        |
      | Searchconfig | Cataloger for AmazonSpectrumCataloger is "AmazonSpectrumCataloger" |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem      | Section                                                            |
      | Click      | Configselection | Cataloger for AmazonSpectrumCataloger is "AmazonSpectrumCataloger" |
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem                                         |
      | Click        | Close                                              |
      | Click        | Search Icon                                        |
      | Searchconfig | Collector for GitCollector is "GitCollectorConfig" |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem      | Section                                            |
      | Click      | Configselection | Collector for GitCollector is "GitCollectorConfig" |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem   |
      | Click      | Close        |
      | Click      | Assignconfig |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem         | ItemName                |
      | Plugin Configuration Accordion | Accordion presence | AmazonSpectrumCataloger |
      | Plugin Configuration Accordion | Accordion presence | GitCollectorConfig      |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                   | Section            |
      | Plugin Configuration Accordion | Expand Accordion          | GitCollectorConfig         |                    |
      | Plugin Configuration Accordion | Click Header Menu options | Unassign the configuration | GitCollectorConfig |
    And user "click" on "UNASSIGN" button in "Popup Window"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                   | Section                 |
      | Plugin Configuration Accordion | Expand Accordion          | AmazonSpectrumCataloger    |                         |
      | Plugin Configuration Accordion | Click Header Menu options | Unassign the configuration | AmazonSpectrumCataloger |
    And user "click" on "UNASSIGN" button in "Popup Window"

  ##7148101##7148108
  @MLP-254695 @webtest @regression @positive
  Scenario:MLP-18355:SC#2.9_Verify sort validation in plugin configuration section.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user "click" on "Assign existing configuration" button in "Item View page"
    And user "click" on "popSectionList" button in "Item View page"
    And user "verifies sorting order" of following "plugin configuration in ascending order" in "Manage DataSource" page
      |  |
    And user "click" on "popSectionList" button in "Item View page"
    And user "verifies sorting order" of following "plugin configuration in descending order" in "Manage DataSource" page
      |  |

  ##7148101##7148104#7148114
  @MLP-25469 @webtest @regression @positive
  Scenario:MLP-18355:SC#2.10_Verify plugin validation after deleting the configuration
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Item view Tab" for "Capture" in "Item View Page"
    And user "click" on "Assign existing configuration" button in "Item View page"
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem                                                         |
      | Click        | Search Icon                                                        |
      | Searchconfig | Cataloger for AmazonSpectrumCataloger is "AmazonSpectrumCataloger" |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem      | Section                                                            |
      | Click      | Configselection | Cataloger for AmazonSpectrumCataloger is "AmazonSpectrumCataloger" |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem   |
      | Click      | Assignconfig |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                | ItemName                 | Section                 |
      | Plugin Configuration Accordion | Expand Accordion          | AmazonSpectrumCataloger  |                         |
      | Plugin Configuration Accordion | Click Header Menu options | Delete the configuration | AmazonSpectrumCataloger |
    And user "click" on "DELETE" button in "Popup Window"
    And user "click" on "Assign existing configuration" button in "Item View page"
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem                                                         |
      | Click        | Search Icon                                                        |
      | Searchconfig | Cataloger for AmazonSpectrumCataloger is "AmazonSpectrumCataloger" |
    And User performs following actions in the Item view Page
      | Actiontype                        | ActionItem                 |
      | Verify Plugin Information Message | No Configuration available |

  @MLP-25471 @regression @positive
  Scenario:SC#3.1_User Deletes the item from database
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                                                             | type                | query | param |
      | SingleItemDelete | Default | Item_511                                                         | BusinessApplication |       |       |
      | SingleItemDelete | Default | cataloger/AmazonSpectrumCataloger/AmazonSpectrumCataloger/%      | Analysis            |       |       |
      | SingleItemDelete | Default | redshift-cluster-1.csvp5wcqqxvw.us-east-1.redshift.amazonaws.com | Cluster             |       |       |

  @regression @positiveRedshiftDataSource
  Scenario:SC#3.2_Delete Configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                         | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/Spectrum_Credentials   |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonSpectrumDataSource |      |               |                  |          |
      |                  |       |       | Delete | settings/credentials/Redshift_Credentials   |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftDataSource |      |               |                  |          |

  @cr-data @sanity @positive
  Scenario:SC#3.3_Delete Configurations
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body | response code | response message | jsonPath |
      | application/json | raw   | false | Delete | settings/credentials/GitCred                       |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource          |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/GitCollector/GitCollectorConfig |      |               |                  |          |