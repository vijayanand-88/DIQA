@MLP-5324
Feature: MLP-5324: Verification of importing xml with source text

  @MLP-5324 @webtest @regression
  Scenario: MLP-5324 Verification of importing xml with source text
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-5324_LineageMultiplewithSource.xml"
    Then user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false |
    And Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "LineageTestCluster" and clicks on search
    Then results panel "search item count" should be displayed as "30 Results" in Item Search results page
