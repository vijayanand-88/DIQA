@MLP_20970 @MLP_21002 @MLP_21003 @MLP_21147
Feature:A_MLP_20370_Verification of BA ItemName can be Modified and Deleted

# 7040064#7040065#7040065
  @MLP-21002 @webtest @regression @positive
  Scenario:MLP-21002:SC#1_Create BusinessApplication Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute   | option        |
      | BusinessApplication | BA_Tag_Test | Save and Open |
    And user rename "BA TagTest before plugin run" BA Item in Itemview page and click "Save" Button
    And user verifies "Item view page title" is "BA TagTest before plugin run" in "Item View" page
    And user "Deletes" BA Item "BA TagTest before plugin run" in Item View Page
    And user "click" on "Confirm" button in "Delete Role Popup"

  @MLP-20979 @webtest @regression @positive
  Scenario:Create BusinessApplication
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute                    | option        |
      | BusinessApplication | BA TagTest before plugin run | Save and Open |

  @MLP-20979 @regression @positive
  Scenario Outline:SC#6_Update License
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url              | body                                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/license | idc/IDxPayloads/license_Update_for_Lienage_and_DS.json | 204           |                  |          |

  @MLP-20979 @regression @positive
  Scenario Outline:SC#6_Add Configuration of Credentials,Data Source,Cataloger,Analyzer and Post Processor for AmazonRedshift
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                        | body                                                                   | response code | response message              | jsonPath                                                           |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/Amazon_Redshift_Credentials                                                           | idc/IDx_DataSource_Credentials_Payloads/AmazonRedshiftCredentials.json | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/credentials/Amazon_Redshift_Credentials                                                           |                                                                        | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                                                | idc/BusinessApplication/AmazonRedshiftDataSource.json                  | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                                                |                                                                        | 200           | RedshiftDataSource            |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                                 | idc/BusinessApplication/AmazonRedshiftCataloger.json                   | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                                 |                                                                        | 200           | Amazon_RedShift_Cataloger     |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/Amazon_RedShift_Cataloger          |                                                                        | 200           | IDLE                          | $.[?(@.configurationName=='Amazon_RedShift_Cataloger')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/Amazon_RedShift_Cataloger           | idc/BusinessApplication/Empty.json                                     | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/Amazon_RedShift_Cataloger          |                                                                        | 200           | IDLE                          | $.[?(@.configurationName=='Amazon_RedShift_Cataloger')].status     |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                                  | idc/BusinessApplication/AmazonRedshiftAnalyzer.json                    | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                                  |                                                                        | 200           | Amazon_Redshift_Analyzer      |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/Amazon_Redshift_Analyzer         |                                                                        | 200           | IDLE                          | $.[?(@.configurationName=='Amazon_Redshift_Analyzer')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/Amazon_Redshift_Analyzer          | idc/BusinessApplication/Empty.json                                     | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/Amazon_Redshift_Analyzer         |                                                                        | 200           | IDLE                          | $.[?(@.configurationName=='Amazon_Redshift_Analyzer')].status      |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftPostProcessor                                                             | idc/BusinessApplication/AmazonRedshiftPostProcessor.json               | 204           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftPostProcessor                                                             |                                                                        | 200           | Amazon_Redshift_PostProcessor |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/lineage/AmazonRedshiftPostProcessor/Amazon_Redshift_PostProcessor |                                                                        | 200           | IDLE                          | $.[?(@.configurationName=='Amazon_Redshift_PostProcessor')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/InternalNode/lineage/AmazonRedshiftPostProcessor/Amazon_Redshift_PostProcessor  | idc/BusinessApplication/Empty.json                                     | 200           |                               |                                                                    |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/InternalNode/lineage/AmazonRedshiftPostProcessor/Amazon_Redshift_PostProcessor |                                                                        | 200           | IDLE                          | $.[?(@.configurationName=='Amazon_Redshift_PostProcessor')].status |

    # 7031080# 7031088
  @MLP-20370 @webtest @regression @positive
  Scenario:MLP-20370:SC#7_Verify if Trust Score header is in yellow color
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA TagTest before plugin run" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype               | ActionItem            | ItemName                  |
      | Click                    | Item view Edit Button |                           |
      | Select Dropdown          | Personal Data         | Yes                       |
      | Select Dropdown          | Business Criticality  | High                      |
      | Select Dropdown          | Data Classification   | Confidential              |
      | Select Dropdown          | Authoritative Source  | Yes                       |
      | Verify Edit Widget value | Business Owners       | Start typing...           |
      | Enter Business Owner     | Business Owners       | Test System Administrator |
      | Click                    | Item view Save Button |                           |
    And user verifies the background color of the BA Header "#f8d106"
    And user refreshes the application

# 7031089
  @MLP-20370 @webtest @regression @positive
  Scenario:MLP-20370:SC#8_Verify Trust score and ChartLegends
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA TagTest after plugin run" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype       | ActionItem  |
      | TrustScoreExpand | Trust Score |
    And User Verifies Trust Score for BA Item

# 7043845
  @MLP-20979 @webtest @regression @positive
  Scenario:MLP-20979:SC#9_ Verify if the created BA item can be renamed as "BA TagTest after plugin run"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA TagTest after plugin run" and clicks on search
    And user verifies "BA TagTest before plugin run" Tag present under "BusinessApplication" Tag
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user rename "BA TagTest after plugin run" BA Item in Itemview page and click "Save" Button

# 7043847
  @MLP-20979 @webtest @regression @positive
  Scenario:MLP-20979:SC#10_ Verify if the created BA item can be renamed as "BA TagTest after plugin run". And verify if the item is displayed in search result
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA TagTest after plugin run" and clicks on search
    And user verifies "BA TagTest after plugin run" Tag present under "BusinessApplication" Tag
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user "verify presence" of following "Items List" in Item Search Results Page
      | BA TagTest after plugin run |

  @MLP-21147 @webtest @regression @positive
  Scenario:MLP-21147:SC#11_ Verify if the Trust score yellow banner is displayed immediately below the BA name
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA TagTest after plugin run" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype       | ActionItem                  |
      | TrustScoreHeader | BA TagTest after plugin run |
    And User performs following actions in the Item view Page
      | Actiontype              | ActionItem |
      | BusinessApplicationTabs | Business   |
    And User performs following actions in the Item view Page
      | Actiontype              | ActionItem   |
      | BusinessApplicationTabs | Architecture |
    And User performs following actions in the Item view Page
      | Actiontype              | ActionItem |
      | BusinessApplicationTabs | Support    |
    And User performs following actions in the Item view Page
      | Actiontype              | ActionItem |
      | BusinessApplicationTabs | Security   |
    And user verifies alignment of Rating After TrustScore Expand


# 7043851# 7043852
  @MLP-21002 @webtest @regression @positive
  Scenario:MLP-21002:SC#12_Verify if cancelling delete, user can still view the BA item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA TagTest after plugin run" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "Deletes" BA Item "BA TagTest after plugin run" in Item View Page
    And user verifies the "Delete Item" pop up is "displayed"
    And user "click" on "Bundles Cancel button" button in "Delete Role Popup"
    And user enters the search text "BA TagTest after plugin run" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user "verify presence" of following "Items List" in Item Search Results Page
      | BA TagTest after plugin run |

# 7043854
  @MLP-21002 @webtest @regression @positive
  Scenario:MLP-21002:SC#13_ Verify item is Deleted on user confirmation of Delete Item Popup
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA TagTest after plugin run" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "Deletes" BA Item "BA TagTest after plugin run" in Item View Page
    And user "click" on "Confirm" button in "Delete Role Popup"

  @MLP-21002 @webtest @regression @positive
  Scenario:MLP-21002:SC#14_ Verify if deleting the BA item "BA TagTest after plugin run", items tagged with this tag should be de-tagged. tag facet should not display "BA TagTest after plugin run"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "" and clicks on search
    And user verifies "BA TagTest after plugin run" Tag not present

# 7040303 #descoped
#  @MLP-21003 @webtest @regression @positive
#  Scenario:MLP-21003:SC#15_ Verify user is able to view "Manage Roles", "Manage Users & Groups", "Manage Test Users" under Manage Access in left side bar
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Admin Link" for "Manage Users & Groups" in "Landing page"
#    And user "verifies presence" of following "Admin page Title" in "" page
#      | Manage Users & Groups |
#    And user "click" on "Admin Link" for "Manage Roles" in "Landing page"
#    And user "verifies presence" of following "Admin page Title" in "" page
#      | Manage Roles |
#    And user "click" on "Admin Link" for "Manage Test Users" in "Landing page"
#    And user "verifies presence" of following "Admin page Title" in "" page
#      | Manage Test Users |

  @MLP-25471 @regression @positive
  Scenario:User Deletes the item from database
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type                | query | param |
      | SingleItemDelete | Default | BA TagTest before plugin run | BusinessApplication |       |       |

  @MLP-21003 @regression @positive
  Scenario:Delete plugin Configurations
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                              | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/AmazonRedshiftDataSource      |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftAnalyzer        |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftCataloger       |      |               |                  |          |
      |                  |       |       | Delete | settings/credentials/Amazon_Redshift_Credentials |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftPostProcessor   |      |               |                  |          |