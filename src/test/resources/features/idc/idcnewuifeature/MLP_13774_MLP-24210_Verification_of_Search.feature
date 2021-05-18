@MLP-13774 @MLP-30181
Feature:MLP-13774: This feature is to verify whether as an IDA Admin, I want to be able to search the IDX application



#  ##6819020####6819033##
#  @MLP-13774 @webtest @regression @positive
#  Scenario: SC#1: MLP-13774: Verification of search results with ALL catalog
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType         | actionItem         |
#      | click              | Global Search Icon |
#      | verifies displayed | Search Block       |
#      | click              | globalSearchButton |
#    And user "verifies displayed" the search results with "All" catalog in search reuslts page.
#
# ##6819026##
#  @MLP-13774 @webtest @regression @positive
#  Scenario: SC#2: MLP-13774: Verification of search results with specified catalog
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | Catalog Drop down  |
#      | click      | BigData            |
#    And user "verifies displayed" the search results with "Bigdata" catalog in search reuslts page.
#
#    ##6819029##
#  @MLP-13774 @webtest @regression @positive
#  Scenario: SC#3: MLP-13774: Verification of applying metadatatype filer
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | globalSearchButton |
#    And user "selects" for the following filter in search results page
#      | FilterType    | FilterValues |
#      | Catalog       | BigData      |
#      | MetaData Type | Column       |
#    And user "verifies displayed" with count as "954 Results for " catalog "BigData" in Search results page
#
# ##6819030##
#  @MLP-13774 @webtest @regression @positive
#  Scenario: SC#4: MLP-13774: Verification of applying Hierarchy filer
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | globalSearchButton |
#    And user "selects" for the following filter in search results page
#      | FilterType | FilterValues          |
#      | Catalog    | BigData               |
#      | Hierarchy  | healthcare [Database] |
#    And user "verifies displayed" with count as "590 Results for " catalog "BigData" in Search results page
#
  #Descoped
#
#    ##6819031##
#  @MLP-13774 @webtest @regression @positive
#  Scenario: SC#5: MLP-13774: Verification of applying Last Modified filer
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | globalSearchButton |
#    And user "selects" for the following filter in search results page
#      | FilterType    | FilterValues       |
#      | Catalog       | BigData            |
#      | Last Modified | 1 day up to 1 week |
#    And user "verifies displayed" with count as "1578 Results for " catalog "BigData" in Search results page
#
#     ##6819032##
#  @MLP-13774 @webtest @regression @positive
#  Scenario: SC#6: MLP-13774: Verification of applying combination of filer
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | globalSearchButton |
#    And user "selects" for the following filter in search results page
#      | FilterType    | FilterValues          |
#      | Catalog       | BigData               |
#      | MetaData Type | Column                |
#      | Hierarchy     | healthcare [Database] |
#      | Last Modified | 1 day up to 1 week    |
#    And user "verifies displayed" with count as "580 Results for " catalog "BigData" in Search results page
#
#   ##6852320##6852315##
#  @MLP-14783 @webtest @regression @positive
#  Scenario:SC#1:MLP-14783: Verify that the sub menu is displaying only when the parent menu is active
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the sidebar
#      | actionType  | actionItem            |
#      | mouse hover | Settings Icon         |
#      | click       | Manage Configurations |
#    And user "click" on "Report" icon from left panel
#    And user "verifies not displayed" the "Manage Configurations" menu get closed
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | globalSearchButton |
#    And user "verifies displayed" the "None" text is displayed in sort drop down

  @MLP-24210 @webtest @regression @positive
  Scenario Outline:SC#1_Create BusinessApplication
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BusinessApplication.json | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BATrustScore0to25.json   | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BATrustScore25to50.json  | 200           |                  |          |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BATrustScore50to75.json  | 200           |                  |          |

  #7113776##7113778##7113779##
  @MLP-24210 @webtest @regression @positive
  Scenario: SC#2: MLP-24210: Verification of facets filter range from 0 to 25
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType | actionItem         |
      | click      | globalSearchButton |
    And user "selects" for the following filter in search results page
      | FilterType  | FilterValues |
      | Trust Score | Upto 25      |
    And user "verifies displayed" the search results with "Select all 1 items" catalog in search reuslts page.

    ##7113780##
  @MLP-24210 @webtest @regression @positive
  Scenario: SC#3: MLP-24210: Verification of facets filter range from 25 to 50
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType | actionItem         |
      | click      | globalSearchButton |
    And user "selects" for the following filter in search results page
      | FilterType  | FilterValues     |
      | Trust Score | Above 25 upto 50 |
    And user "verifies displayed" the search results with "Select all 1 items" catalog in search reuslts page.

    ##7113780##
  @MLP-24210 @webtest @regression @positive
  Scenario: SC#4: MLP-24210: Verification of facets filter range from 50 to 75
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType | actionItem         |
      | click      | Global Search Icon |
      | click      | globalSearchButton |
    And user "selects" for the following filter in search results page
      | FilterType  | FilterValues     |
      | Trust Score | Above 50 upto 75 |
    And user "verifies displayed" the search results with "Select all 1 items" catalog in search reuslts page.

  ##7113780##
  @MLP-24210 @webtest @regression @positive
  Scenario Outline:SC#5_Add Configuration of Credentials,Data Source,Cataloger,Analyzer and Post Processor for AmazonRedshift
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                                | body                                                                   | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/Amazon_Redshift_Credentials                                                   | idc/IDx_DataSource_Credentials_Payloads/AmazonRedshiftCredentials.json | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/credentials/Amazon_Redshift_Credentials                                                   |                                                                        | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                                        | idc/BusinessApplication/AmazonRedshiftDataSource.json                  | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                                        |                                                                        | 200           | RedshiftDataSource        |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                         | idc/BusinessApplication/AmazonRedshiftCataloger.json                   | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                         |                                                                        | 200           | Amazon_RedShift_Cataloger |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/Amazon_RedShift_Cataloger  |                                                                        | 200           | IDLE                      | $.[?(@.configurationName=='Amazon_RedShift_Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/Amazon_RedShift_Cataloger   | idc/BusinessApplication/Empty.json                                     | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/Amazon_RedShift_Cataloger  |                                                                        | 200           | IDLE                      | $.[?(@.configurationName=='Amazon_RedShift_Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftAnalyzer                                                          | idc/BusinessApplication/AmazonRedshiftAnalyzer.json                    | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftAnalyzer                                                          |                                                                        | 200           | Amazon_Redshift_Analyzer  |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/Amazon_Redshift_Analyzer |                                                                        | 200           | IDLE                      | $.[?(@.configurationName=='Amazon_Redshift_Analyzer')].status  |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/Amazon_Redshift_Analyzer  | idc/BusinessApplication/Empty.json                                     | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/AmazonRedshiftAnalyzer/Amazon_Redshift_Analyzer |                                                                        | 200           | IDLE                      | $.[?(@.configurationName=='Amazon_Redshift_Analyzer')].status  |

  ##7113780##7113782##
  @MLP-24210 @webtest @regression @positive
  Scenario: SC#6: MLP-24210: Verification of facets filter range from 75 to 100
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType | actionItem         |
      | click      | Global Search Icon |
      | click      | globalSearchButton |
    And user "selects" for the following filter in search results page
      | FilterType  | FilterValues      |
      | Trust Score | Above 75 upto 100 |
    And user "verifies displayed" the search results with "Select all 1 items" catalog in search reuslts page.


  @MLP-24210 @webtest @regression @positive
  Scenario: SC#7_Delete plugin Configurations
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                              | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/AmazonRedshiftDataSource      |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftAnalyzer        |      | 204           |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftCataloger       |      | 204           |                  |          |
      |                  |       |       | Delete | settings/credentials/Amazon_Redshift_Credentials |      | 200           |                  |          |

  ##7113781##
  @MLP-24210 @webtest @regression @positive
  Scenario: SC#8: MLP-24210: Verification of  sort of Trust Score in ascending and Descending Order
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType | actionItem         |
      | click      | globalSearchButton |
    And user "selects" for the following filter in search results page
      | FilterType  | FilterValues      |
      | Trust Score | Above 75 upto 100 |
    And user performs following actions in the header
      | actionType | actionItem                 |
      | click      | Trust score Sort Ascending |
    And user "verifies sorting order" of following "Trust Score are in ascending order" in "Manage DataSource" page
      |  |
    And user performs following actions in the header
      | actionType | actionItem                  |
      | click      | Trust score Sort Descending |
    And user "verifies sorting order" of following "Trust Score are in Descending order" in "Manage DataSource" page
      |  |

   ##7113783##7113784##
  @MLP-24210 @webtest @regression @positive
  Scenario: SC#9: MLP-24210: Verification of  selection of header check box of Trust score facets filter
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType | actionItem                   |
      | click      | globalSearchButton           |
      | click      | Header Trust score check box |
    And user "verifies displayed" the search results with "Select all 1 items" catalog in search reuslts page.

  ##7113785##
  @MLP-24210 @webtest @regression @positive
  Scenario: SC#10: MLP-24210: Verification of  Expand/Collapse Trust score facets filter
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType | actionItem          |
      | click      | globalSearchButton  |
      | click      | ExpandCollapse icon |
    And user "verifies displayed" the search results with "Facet filters of Trust" catalog in search reuslts page.
    And user performs following actions in the header
      | actionType | actionItem          |
      | click      | ExpandCollapse icon |
    And user "verifies not displayed" the search results with "Facet filters of Trust" catalog in search reuslts page.
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                         | type                | query | param |
      | SingleItemDelete | Default | BA TagTest before plugin run | BusinessApplication |       |       |
      | SingleItemDelete | Default | TestBAItem1                  | BusinessApplication |       |       |
      | SingleItemDelete | Default | TestBAItem2                  | BusinessApplication |       |       |
      | SingleItemDelete | Default | TEstdata3                    | BusinessApplication |       |       |

    ##7191372##
  @MLP-27280 @webtest @regression @positive
  Scenario: SC#1: MLP-27280: Verification of  Expand/Collapse all of facets filter
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType | actionItem         |
      | click      | globalSearchButton |
    And user performs following actions in the Search results page
      | actionType             | actionItem     |
      | click                  | Collapse All   |
      | verifies displayed     | Facets filters |
      | click                  | Expand All     |
      | verifies not displayed | Facets filters |

      ##7191374##7191377##
  @MLP-27280 @webtest @regression @positive
  Scenario: SC#2: MLP-27280: Verification of  header count in facets filter header
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the header
      | actionType | actionItem         |
      | click      | globalSearchButton |
    And user "selects" for the following filter in search results page
      | FilterType    | FilterValues |
      | MetaData Type | Column       |
      | MetaData Type | Table        |
    And user performs following actions in the Search results page
      | actionType         | actionItem   |
      | verifies displayed | Header Count |


    ##7265814##
  @MLP-24210 @webtest @regression @positive
  Scenario: SC#10: MLP-24210: Verification of  Expand/Collapse Trust score facets filter
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "verify presence" of following "facets" in Item Search Results Page
      | SampleBA1 |
      | SampleBA2 |
    ##7261323##MLPQA-3300##72613264##MLPQA-3299##72613265##MLPQA-3298##72613266##MLPQA-3297##72613251##MLPQA-3296##7261359##MLPQA-3289##
  @MLP-30185 @webtest @regression @positive
  Scenario:MLP-30185:SC#1_Verify facet selection tag in search results page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user "selects" for the following filter in search results page
      | FilterType    | FilterValues |
      | MetaData Type | Column       |
    And user "verifies the selected facets" for the following filter in search results page
      | actionType             | FilterType    | FilterValues |
      | Verify facet selection | MetaData Type | Column       |
    And user performs following actions in the Search results page
      | actionType | actionItem       |
      | click      | Facet close icon |
    And user "selects" for the following filter in search results page
      | FilterType    | FilterValues |
      | MetaData Type | Column       |
      | MetaData Type | Table        |
    And user "verifies the selected facets" for the following filter in search results page
      | actionType             | FilterType    | FilterValues    |
      | Verify facet selection | MetaData Type | Column or Table |
    And user performs following actions in the Search results page
      | actionType | actionItem       |
      | click      | Facet close icon |
    And user "selects" for the following filter in search results page
      | FilterType    | FilterValues |
      | MetaData Type | Column       |
      | MetaData Type | Table        |
      | MetaData Type | File         |
    And user "verifies the selected facets" for the following filter in search results page
      | actionType             | FilterType    | FilterValues |
      | Verify facet selection | MetaData Type | 3 selected   |
    And user performs following actions in the Search results page
      | actionType | actionItem       |
      | click      | Facet close icon |

   ##7261355##MLPQA-3293##7261356##MLPQA-3292##7261358##MLPQA-3290##
  @MLP-30185 @webtest @regression @positive
  Scenario:MLP-30185:SC#1_Verify facet selection tag  foucs in search results page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user "selects" for the following filter in search results page
      | FilterType    | FilterValues |
      | MetaData Type | Column       |
    And user "verifies the selected facets" for the following filter in search results page
      | actionType             | FilterType    | FilterValues |
      | Verify facet selection | MetaData Type | Column       |
    And user "click" for the following filter in search results page
      | actionType             | FilterType    | FilterValues |
      | Verify facet selection | MetaData Type | Column       |
    And user press "TAB" key using key press event
    And user press "ENTER" key using key press event
    And user "selects" for the following filter in search results page
      | FilterType    | FilterValues |
      | MetaData Type | Column       |

 ##7261353##MLPQA-3294##
  @MLP-30185 @webtest @regression @positive
  Scenario:MLP-30185:SC#3_Verify search results get updated when removing the facet selection from facets filters
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user "selects" for the following filter in search results page
      | FilterType    | FilterValues |
      | MetaData Type | Column       |
    And user "verifies the selected facets" for the following filter in search results page
      | actionType             | FilterType    | FilterValues |
      | Verify facet selection | MetaData Type | Column       |
    And user "selects" for the following filter in search results page
      | FilterType    | FilterValues |
      | MetaData Type | Column       |

      ##MLPQA-17998##MLPQA-18000##
  @MLP-30644 @webtest @regression @positive
  Scenario:MLP-30644:SC#1_Verification of moving and collapsing the focus to search facets filter using TAB key
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user press the "TAB" key  for "11" times using key press event
    And user press "ENTER" key using key press event
    And user performs following actions in the Search results page
      | actionType             | actionItem     |
      | verifies not displayed | Facets filters |

     ##MLPQA-17999##MLPQA-18002##MLPQA-18001##
  @MLP-30644 @webtest @regression @positive
  Scenario:MLP-30644:SC#2_Verify Tab Order for checkbox select and unselect in search page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs following actions in the Search results page
      | actionType | actionItem       |
      | click      | Hirerachy Header |
    And user press the "TAB" key  for "2" times using key press event
    And user press "ENTER" key using key press event
    And user "verifies the selected facets" for the following filter in search results page
      | actionType             | FilterType    | FilterValues |
      | Verify facet selection | Hierarchy | 165 selected       |
    And user press the "TAB" key  for "2" times using key press event
    And user press "ENTER" key using key press event

     ##MLPQA-17999##MLPQA-18002##
  @MLP-30644 @webtest @regression @positive
  Scenario:MLP-30644:SC#3_Verify Tab Order for  caret up and down in search page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs following actions in the Search results page
      | actionType | actionItem       |
      | click      | Hirerachy Header |
    And user press the "TAB" key  for "14" times using key press event
    And user press "ENTER" key using key press event
    And user performs following actions in the Search results page
      | actionType         | actionItem         |
      | verifies displayed | Facets caret Right |
    And user press "ENTER" key using key press event
    And user performs following actions in the Search results page
      | actionType         | actionItem        |
      | verifies displayed | Facets caret Down |
