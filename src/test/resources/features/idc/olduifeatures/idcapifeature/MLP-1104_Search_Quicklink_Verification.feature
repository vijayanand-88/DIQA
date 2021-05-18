@MLP-1104
Feature: MLP-1104: Save current context and actual navigation panel parameters and selections and add it as quick link

  Description:
  Creating a quicklink for search on any catalog

  @MLP-1104 @quicklink
  Scenario: Deleteing all existing quicklinks from postgres db
    Given When query is ran to delete all quicklinks in "public" schema of "V_Setting" table
    Then Quicklink should not be found in "public" schema of "V_Setting" table

  @MLP-1104 @sanity @regression @quicklink
  Scenario: Verification of creating a quick link for single widget
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1104_quicklink_singlewidget.json"
    When user makes a REST Call for POST request with url "quicklinks"
    Then Status code 200 must be returned
    And verify created quicklink is available for TestSystem User
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |

  @MLP-1104 @sanity @regression @quicklink
  Scenario: Verification of creating a quicklink for multiple Widget
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1104_quicklink_multiwidget.json"
    When user makes a REST Call for POST request with url "quicklinks"
    Then Status code 200 must be returned
    And verify created quicklink is available for multiwidget in TestSystem User
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |

  @MLP-1104 @sanity @regression @quicklink
  Scenario: Verification of creating a solr search quicklink
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1104_quicklink_SolrSearch.json"
    When user makes a REST Call for POST request with url "quicklinks"
    Then Status code 200 must be returned
    And verify created quicklink for Solr search is available for TestSystem user
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |

  @MLP-1104  @regression @quicklink
  Scenario: Verification of creating a duplicate quicklink
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1104_quicklink_singlewidget.json"
    When user makes a REST Call for POST request with url "quicklinks"
    Then Status code 400 must be returned

  @MLP-1104 @quicklink
  Scenario: Verification of GET request by quicklink id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "quicklinks/1"
    Then Status code 200 must be returned
    And response body quick link should match the saved quicklink json in V_Setting table
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |


  @MLP-1104 @quicklink
  Scenario: Verification of GET request for invalid quicklink id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "quicklinks/15"
    Then Status code 404 must be returned
    And response body should have "Missing configuration with id : 15" message

  @MLP-1104 @quicklink
  Scenario: Verification of GET request for quicklinks by WidgetName
    Given A query param with "widget" and "BigData" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "quicklinks"
    Then Status code 200 must be returned
    And Quicklinks from BigData Widget should be displaying
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |

  @MLP-1104 @regression @quicklink
  Scenario: Verification of updating a quicklink
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1104_update_quicklink.json"
    When user makes a REST Call for PUT request with url "quicklinks/1"
    Then Status code 204 must be returned
    And updated quicklink json in should be saved config table
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |

  @MLP-1104 @sanity @regression @quicklink @positive
  Scenario: Verification of DELETE request by quicklink id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "quicklinks/1"
    Then Status code 204 must be returned
    And Quick link with id 1 should not be found in postgres
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |

  @MLP-1104  @quicklink @negative
  Scenario: Verification of DELETE request by invalid quicklink id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "quicklinks/15"
    Then Status code 404 must be returned
    And response body should have "Missing configuration with id : 15" message

  @MLP-1104 @quicklink @positive
  Scenario: Deleteing all Created quicklinks from postgres db
    Given When query is ran to delete all quicklinks in "public" schema of "V_Setting" table
    Then Quicklink should not be found in "public" schema of "V_Setting" table

