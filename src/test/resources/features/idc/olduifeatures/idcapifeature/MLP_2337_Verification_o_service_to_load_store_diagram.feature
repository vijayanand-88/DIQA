@MLP-2337
Feature: MLP-2337: Implement service to load/store diagrams

  @regression @MLP-2337 @positive
  Scenario:MLP-2337: To verify that the diagram can be saved
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-2337_SaveDiagramConfiguration.json"
    When user makes a REST Call for PUT request with url "settings/diagram/Custom_h"
    Then Status code 204 must be returned
    And user verifies that a JSON file is created for the diagram
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | *          | path         |

  @regression @MLP-2337 @negative
  Scenario:MLP-2337: Verification of error when getting diagram configuration with invalid name
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "settings/diagram/Test"
    Then Status code 404 must be returned
    And response message contains value "Missing configuration with path : com/asg/dis/platform/diagram/Test.json"

  @regression @MLP-2337 @positive
  Scenario:MLP-2337: Verification of listing diagram configuration with diagram name
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "settings/diagram/Custom_h"
    Then Status code 200 must be returned
    And response query definition for "Custom_h" should match with the table in database for diagram
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |

  @regression @MLP-2337 @positive
  Scenario:MLP-2337: Verification of updating diagram configuration
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-2337_Sample_Diagram_Updtaed.json"
    When user makes a REST Call for PUT request with url "settings/diagram/Custom_h"
    Then Status code 204 must be returned
    And response query definition for "Custom_h" updated should match with the table in database for diagrams
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |

  @regression @MLP-2337 @positive
  Scenario:MLP-2337: Verification of listing diagram configuration
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "settings/diagram"
    Then Status code 200 must be returned
    And response should match with database for "diagram"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | path       |              |

  @regression @MLP-2337 @positive
  Scenario:MLP-2337: Verification of deleting diagram configuration
    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "settings/diagram/Custom_h"
    Then Status code 204 must be returned
    And verify created schema "Custom_h" doesn't exists in database

  @regression @MLP-2337 @negative
  Scenario:MLP-2337: Verification of deleting diagram configuration with invalid name
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "settings/diagram/Test"
    Then Status code 404 must be returned
    And response message contains value "Missing configuration with path : com/asg/dis/platform/diagram/Test.json"


  @regression @MLP-2337 @positive
  Scenario:MLP-2337: To verify that the diagram themes can be saved
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-2337_Sample_Theme.json"
    When user makes a REST Call for PUT request with url "settings/theme/Sample%20Theme"
    Then Status code 204 must be returned
    And created diagram theme should be present in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | *          | path         |

  @regression @MLP-2337 @negative
  Scenario:MLP-2337: Verification of error when getting diagram themes with invalid name
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "settings/theme/Test"
    Then Status code 404 must be returned
    And response message contains value "Missing configuration with path : com/asg/dis/platform/theme/Test.json"

  @regression @MLP-2337 @negative
  Scenario:MLP-2337: Verification of deleting diagram themes with invalid name
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "settings/theme/Test"
    Then Status code 404 must be returned
    And response message contains value "Missing configuration with path : com/asg/dis/platform/theme/Test.json"

  @regression @MLP-2337 @positive
  Scenario:MLP-2337: Verification of listing diagram themes with diagram name
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "settings/theme/Sample%20Theme"
    Then Status code 200 must be returned
    And response diagram theme for "Sample Theme" should match with database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |


  @regression @MLP-2337 @positive
  Scenario:MLP-2337: Verification of updating diagram theme
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-2337_SampleTheme_Updated.json"
    When user makes a REST Call for PUT request with url "settings/theme/Sample%20Theme"
    Then Status code 204 must be returned
    And response diagram theme updated for "Sample Theme" should match with database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |

  @regression @MLP-2337 @positive
  Scenario:MLP-2337: Verification of listing diagram themes
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "settings/theme"
    Then Status code 200 must be returned
    And response should match with database for "theme"
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | path       |              |

  @regression @MLP-2337 @positive
  Scenario:MLP-2337: Verification of deleting diagram theme
    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "settings/theme/Sample%20Theme"
    Then Status code 204 must be returned
    And verify theme "Sample Theme" not present in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | *          | path         |



