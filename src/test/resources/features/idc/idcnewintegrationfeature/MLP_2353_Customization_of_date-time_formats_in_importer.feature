@MLP-2353
Feature: MLP-2353: Verification of customization of supported date-time formats in importer

  @MLP-2353 @regression @webtest
  Scenario: MLP-2353 Verification of XML importer supports date time format
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-2353_Date.xml"
    And user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "ImporterTag" attribute under "Tags" facets in Item Search results page
    Then results panel "search item count" should be displayed as "8 Results" in Item Search results page

  @MLP-2353 @regression @webtest
  Scenario: MLP-2353_Verification of XML importer error when date time format is not configured
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-2353_DateError.xml"
    And user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000 |
    And Status code 400 must be returned
    And response body should have "Illegal value for LOCAL_DATE_TIME_ISO attribute createdAt: 2016/10/06 02/05/10" message

  Scenario Outline: user retrieves ID with catalog name and type
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type  | name       | asg_scopeid | targetFile                                                  | jsonpath        |
      | APPDBPOSTGRES | ID      | Default | Table | SeedTabOne |             | payloads/idc/IDX_Integration_Payloads/MLP-2353_Item_id.json | $..has_Table.id |

  @MLP-2462 @regression
  Scenario Outline: MLP-2462 Verification of reading a incorrect schema configuration
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDX_Integration_Payloads/MLP-2353_Blank.json"
    And user makes a REST Call for PUT request with url "settings" with the following query param
      | path | com%2Fasg%2Fdis%2Fplatform%2Fxml_schema%2Fhttp%3A%2F%2Frochade.asg.com%2FScanHive%2F2.10.000.json |
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    When To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                |
      | Accept        | application/xml                |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    And Verify XML response message contains value
      | responseXmlText                                                                                                      |
      | Missing configuration with path : com/asg/dis/platform/xml_schema/http://rochade.asg.com/ScanHive/2.10.000.json.json |
    Examples:
      | url                                                                                                                                         | responseCode | inputJson       | inputFile                                                   | outPutFile | outPutJson |
      | export/Default/query/dataTagging/Default.Table:::dynamic?xmlSchemaUri=http://rochade.asg.com/ScanHive/2.10.000.json&Rochade-Conversion=true | 404          | $..has_Table.id | payloads/idc/IDX_Integration_Payloads/MLP-2353_Item_id.json |            |            |



