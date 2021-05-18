@MLP-7275
Feature: MLP-7275: Improve error handling of importer in sort&merge mode (-sm flag)

  @MLP-7275 @regression @positive
  Scenario: MLP-7275_Verification of reading a schema with techdescription as false
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                 | body                        | response code | response message | jsonPath |
      | application/json |       |       | Put  | settings?path=com%2Fasg%2Fdis%2Fplatform%2Fxml_schema%2Fhttp%3A%2F%2Fwww.asg.com%2FDB2%2F9.9.0.json | idc/MLP_7275_SchemaDB2.json | 204           |                  |          |
    And configure a new REST API for the service "IDC"
    And  A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/settings/schemas/list"
    And Status code 200 must be returned
    And response message contains value ""name" : "http://www.asg.com/DB2/9.9.0""
    When user makes a REST Call for Get request with url "settings/schemas?schemaname=http%3A%2F%2Fwww.asg.com%2FDB2%2F9.9.0&techdescription=false&noImport=true"
    And Status code 200 must be returned
    And response message not contains value "techDescription"

  @MLP-7275 @regression @positive
  Scenario: MLP-7275-Verification of reading a schema with techdescription as true
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                                                                                 | body                        | response code | response message | jsonPath |
      | application/json |       |       | Put  | settings?path=com%2Fasg%2Fdis%2Fplatform%2Fxml_schema%2Fhttp%3A%2F%2Fwww.asg.com%2FDB2%2F9.9.0.json | idc/MLP_7275_SchemaDB2.json | 204           |                  |          |
    And configure a new REST API for the service "IDC"
    And  A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/settings/schemas/list"
    And Status code 200 must be returned
    And response message contains value ""name" : "http://www.asg.com/DB2/9.9.0""
    When user makes a REST Call for Get request with url "settings/schemas?schemaname=http%3A%2F%2Fwww.asg.com%2FDB2%2F9.9.0&techdescription=true&noImport=true"
    And Status code 200 must be returned
    And response message contains value "techDescription"