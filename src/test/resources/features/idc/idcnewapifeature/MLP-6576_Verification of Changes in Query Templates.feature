@MLP-6576
Feature: MLP-6576: Verification of changes in Query Templates

  Description:
  View changes in Query Templates

  @regression
  Scenario: MLP-6576: Verification of properties in Query Templates
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "settings/queries/ColumnTypesInTable"
    Then Status code 200 must be returned
    And user verifies whether the value is present in response using json path "$..['parameters']"
      | jsonValues           |
      | name                 |
      | label                |
      | availableValuesQuery |
      | availableValues      |

  @regression
  Scenario: MLP-6576: Verification of changes in Query Templates
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "settings/queries"
    Then Status code 200 must be returned
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues              |
      | AnalysisHistoryLog      |
      | ColumnTypesInTable      |
      | dataTagging             |
      | ItemsProcessedByPlugins |
      | pagingQuery             |
      | queryDiagramIn          |
      | queryDiagramInRecursive |
      | queryDiagramOut         |
      | queryDiagramOutRecursive|
      | solrQuery               |
      | TopTags                 |
