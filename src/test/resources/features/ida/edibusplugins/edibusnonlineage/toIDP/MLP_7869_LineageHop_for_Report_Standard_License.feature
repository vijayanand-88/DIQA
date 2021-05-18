Feature: MLP-7869 LineageHops in IDP for lineage relevant link relationships in EDI with standard license

##6363767#
  @edibus @mlp-7869 @webtest @positive @toIDP
  Scenario:MLP-7869_verification of Lineage hop for Report for the items replicated from EDI to IDP
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                    | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus/ReportLineage                            | idc/EdiBusPayloads/MLP_7869_Config.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ReportLineage |                                         | 200           | IDLE             | $.[?(@.configurationName=='ReportLineage')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ReportLineage  |                                         | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ReportLineage |                                         | 200           | IDLE             | $.[?(@.configurationName=='ReportLineage')].status |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ReportLineage" and clicks on search
    And user performs "facet selection" in "Analysis" attribute under "Metadata Type" facets in Item Search results page
    And user performs "latest analysis click" in Item Results page for "bulk/EDIBus/ReportLineage%"
    And the following metadata values should be displayed
      | metaDataAttribute | metaDataValue |
      | Number of errors  | 0             |
    And user enters the search text "TESTGC_RPT_PCK" and clicks on search
    And user performs "facet selection" in "TESTGC_RPT_PCK [ReportPackage]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "facet selection" in "Report" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "TESTGC-REPORT1" item from search results
    And user "widget not present" on "Lineage Hops" in Item view page


    ##6363891##
  @edibus @mlp-7864 @webtest @positive @toIDP
  Scenario:MLP-7864 Verification of replicating stitching items in incremental mode  from EDI to IDP
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "ORGANIZATION_KEY" and clicks on search
    And user performs "facet selection" in "EMP_RANKING_FACT [Table]" attribute under "Hierarchy" facets in Item Search results page
    And user performs "item click" on "ORGANIZATION_KEY" item from search results
    And user "widget not present" on "Lineage Hops" in Item view page


  Scenario:SC1#Cleanup
    Given user update the json file "idc/EdiBusPayloads/MLP_7869_Config.json" file for following values
      | jsonPath    | jsonValues |
      | $..function | cleanup    |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                | body                                    | response code | response message | jsonPath                                           |
      | application/json |       |       | Put          | settings/analyzers/EDIBus/ReportLineage                            | idc/EdiBusPayloads/MLP_7869_Config.json | 204           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ReportLineage |                                         | 200           | IDLE             | $.[?(@.configurationName=='ReportLineage')].status |
      |                  |       |       | Post         | extensions/analyzers/start/InternalNode/bulk/EDIBus/ReportLineage  |                                         | 200           |                  |                                                    |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/InternalNode/bulk/EDIBus/ReportLineage |                                         | 200           | IDLE             | $.[?(@.configurationName=='ReportLineage')].status |

  Scenario:SC1#:Delete the analysis item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                       | type     | query | param |
      | MultipleIDDelete | Default | bulk/EDIBus/ReportLineage% | Analysis |       |       |

  @edibus @mlp-9314 @webtest @positive
  Scenario:Clearing of Subject Area
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/analyzers/EDIBus"
    And Status code 204 must be returned







