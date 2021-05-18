@MLP-5223
Feature: MLP-5223: Improve error handling of importer in sort&merge mode (-sm flag)

  @MLP-5223 @regression @positive @spreadsheet
  Scenario: MLP-5223_Verification of import with sortAndMerge as false
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And Execute REST API with following parameters
      | Header | Query | Param | type | url                                                                                                                 | body                            | response code | response message | jsonPath |
      |        |       |       | Put  | settings?path=com%2Fasg%2Fdis%2Fplatform%2Fxml_schema%2Fhttp%3A%2F%2Frochade.asg.com%2FScanOracleTest%2F2.00.0.json | idc/MLP_5223_Schema_Oracle.json | 204           |                  |          |
    And configure a new REST API for the service "IDC"
    When To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP_5223_OracleDB_with_Error.xml"
    Then user makes a REST Call for POST request with url "import/Default?isRnx=true&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true"
    And Status code 400 must be returned
    And user compares the following value from response using json path
      | jsonValues                                                            | jsonPath            |
      | IllegalStateException                                                 | $..['code']         |
      | 3:21: IMPORTER-0014: unexpected element <xmi:Documentation ...> | $..['errorMessage'] |


  @MLP-5223 @regression @positive @spreadsheet
  Scenario: MLP-5223_Verification of import with sortAndMerge as true
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP_5223_OracleDB_with_Error.xml"
    Then user makes a REST Call for POST request with url "import/Default?isRnx=true&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=true&writeWholeSchema=true"
    And Status code 400 must be returned
    And user compares the following value from response using json path
      | jsonValues            | jsonPath    |
      | IllegalStateException | $..['code'] |
    And response message contains value "[3:43/origPos=3:21]: IMPORTER-0014: unexpected element <xmi:Documentation ...>"
