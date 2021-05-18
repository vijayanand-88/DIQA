@MLP-2462
Feature: MLP-2462: Exporter fails with NPE if no schema uri provided

  @MLP-2462 @sanity @regression @negative
  Scenario: MLP-2462 Verification of xmlSchemaUri param error validation
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/xml                    |
    And user makes a REST Call for Get request with url "export/BigData?Rochade-Conversion=true"
    And Status code 400 must be returned
    Then Verify XML response message contains value
      | responseXmlText                       |
      | Missing xmlSchemaUri parameter value. |

  @MLP-2462 @sanity @regression @negative
  Scenario: MLP-2462 Verification of incorrect catalog name for Export service
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/xml                    |
    And user makes a REST Call for Get request with url "export/BigDatas?Rochade-Conversion=true" with the following query param
      | xmlSchemaUri | http://rochade.asg.com/BROWSER_BG/1.00.0 |
    And Status code 404 must be returned
    Then Verify XML response message contains value
      | responseXmlText            |
      | Catalog BigDatas not found |

  @MLP-2462 @sanity @regression @negative
  Scenario: MLP-2462 Verification of reading a incorrect schema configuration
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
      | Content-Type  | application/xml                    |
    And user makes a REST Call for Get request with url "export/BigData/query/dataTagging/BigData.Table:::1" with the following query param
      | xmlSchemaUri       | http://rochade.asg.com/BROWSERS_BG/1.00.1 |
      | Rochade-Conversion | true                                      |
    And Status code 404 must be returned
    Then Verify XML response message contains value
      | responseXmlText                  |
      | Missing configuration with path |