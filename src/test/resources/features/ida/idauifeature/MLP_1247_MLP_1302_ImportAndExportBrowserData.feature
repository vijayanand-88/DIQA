Feature:MLP-1247-MLP-1302: Import from IDC to EDI and Export from EDI to IDC is covered in this feature

  @regression @sanity @positive
  Scenario: Create a Catalog for BrowserData and import data into IDC
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "ida/create_browserdata_payload.json"
    And user makes a REST Call for POST request with url "configuration/catalogs"
    And Status code 204 must be returned
    And verify created schema "BrowserData" exists in database

  @webtest @regression @sanity @positive
  Scenario: Import Data
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And set the content type "application/xml"
    And supply payload with file name "ida/browserdatafromrochade.xml"
    And build a request with query parameters
      | isRnx  | true |
      | rnxSchemaNamespace    | http://rochade.asg.com/BROWSER_BG/1.00.0 |
      | progressIntMillis  |10000 |
      | isTypedValuesDisabled | false           |
      | isWriteUnconditional | false          |
    And user makes a REST Call for POST request with url "import/BrowserData"
    And Status code 200 must be returned
    And verify the content "GOSALESDW" is successfully imported into the database
    And User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    When user enters the search text "GOSALESDW" and clicks on search
    And verify the imported content "GOSALESDW" in IDC UI

  @regression @sanity @positive
  Scenario: Export Data
    Given build a request with header to accept "text/xml" response
    And build a request with query parameters
      | xmlSchemaUri    | http://rochade.asg.com/BROWSER_BG/1.00.0 |
      | areaName  | BrowserData |
      | Tag-Conversion        |true                                      |
    When user makes a REST Call for Get request with url "export/BrowserData"
    Then Status code 200 must be returned
    And the exported data should contain the item "FIN_FINANCE_FACT"

  @regression @sanity @positive
  Scenario: Delete the BrowserData Catalog for cleanup
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "configuration/catalogs/BrowserData"
    Then Status code 204 must be returned