@MLP-21951
Feature:MLP-21951_verify Move the demo items to Default catalog

  # 7083730
  @MLP-21951 @webtest @regression @positive
  Scenario:MLP-21951:SC#1_Verify if in docker environments all the Demo Data items belong to 'Default' catalog. Click any demo item and verify the item view URL has 'Default' as catalog name
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Cluster 1" and clicks on search
    And user performs "facet selection" in "Cluster" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Cluster 1" item from search results
    And User validates URL of Demo Data contains "catalogs=Default"

  @MLP-21951@regression @positive
  Scenario Outline:MLP-21951:SC#2_Verify if in docker environments all the Demo Data items belong to 'Default' catalog.
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                       | body | response code | response message | filePath                                                       | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Get  | settings/catalogs/BigData |      | 404           |                  | payloads\idc\IDC_payloads_Default_Catalog_Demodata\Actual.json |          |

    # 7083746
  @MLP-21951 @regression @positive
  Scenario Outline:SC#3 Compare Json values of Response with Expected Json Value
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                   | actualValues                                                   | valueType     | expectedJsonPath | actualJsonPath  |
      | payloads\idc\IDC_payloads_Default_Catalog_Demodata\Expected.json | payloads\idc\IDC_payloads_Default_Catalog_Demodata\Actual.json | stringCompare | $..value         | $..errorMessage |

  @MLP-21951@regression @positive
  Scenario Outline:MLP-21951:SC#4_Verify if in docker environments all the Demo Data items belong to 'Default' catalog.
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                                | body | response code | response message | filePath                                                              | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Get  | settings/catalogs?catalogtype=DATA |      | 200           |                  | payloads\idc\IDC_payloads_Default_Catalog_Demodata\DefaultActual.json |          |

    # 7083731# 7083738
  @MLP-21951@regression @positive
  Scenario Outline:SC#5 Compare Json values of Response with Expected Json Value
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                                          | actualValues                                                          | valueType         | expectedJsonPath | actualJsonPath                 |
      | payloads\idc\IDC_payloads_Default_Catalog_Demodata\DefaultExpected.json | payloads\idc\IDC_payloads_Default_Catalog_Demodata\DefaultActual.json | stringCompare     | $..name          | $.[?(@.label=='Default')].name |
      | payloads\idc\IDC_payloads_Default_Catalog_Demodata\DefaultExpected.json | payloads\idc\IDC_payloads_Default_Catalog_Demodata\DefaultActual.json | stringNonPresence | $..name1         | $.[?(@.label=='Default')].name |

