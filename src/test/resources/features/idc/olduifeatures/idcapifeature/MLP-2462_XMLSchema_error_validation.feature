@MLP-2462
Feature: MLP-2462: Verification of error validation of Xmlschema uri

  @MLP-2462 @regression
  Scenario: MLP-2462 Verification of xmlSchemaUri param error validation
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                    |
      | Accept        | application/xml                    |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "export/BigData?Rochade-Conversion=true"
    And Status code 400 must be returned
    And Verify XML response message contains value
      | responseXmlText                      |
      | Missing xmlSchemaUri parameter value |

  @MLP-2462 @regression
  Scenario: MLP-2462 Verification of incorrect catalog name for Export service
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/xml                    |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "export/Incorrect" with the following query param
      | xmlSchemaUri | http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0.json&Rochade-Conversion=true |
    And Status code 404 must be returned
    And Verify XML response message contains value
      | responseXmlText             |
      | Catalog Incorrect not found |




