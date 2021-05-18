@MLP-2568
Feature: MLP-2568: Verification of exporting items

  @MLP-2568 @regression @positive @exportItems
  Scenario: @MLP-2568 Verification of exporting items when typeByGroup has incorrect sqlg types
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "/settings/catalogs/TestCat1"
    And user makes a REST Call for DELETE request with url "/settings/catalogs/ImportFour"
    And supply payload with file name "idc/MLP-2568_CreateCatalogs.json"
    And user makes a REST Call for POST request with url "settings/catalogs"
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    When To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "idc/MLP_2967_lineage.xml"
    Then user makes a REST Call for POST request with url "import/TestCat1" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 200 must be returned
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1114_CreateCatalog4.json"
    And user makes a REST Call for POST request with url "/settings/catalogs"
    And Status code 204 must be returned
#    When supply payload with file name "idc/MLP-1114_schemaAnalyzer.json"
#    And user makes a REST Call for PUT request with url "settings" with the following query param
#      | path | com%2Fasg%2Fdis%2Fplatform%2Fxml_schema%2Fhttp%3A%2F%2Fwww.asg.com%2FDataAnalyzer%2F1.0.0.json |
#    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "idc/MLP-2568_stats_tags.xml"
    And user makes a REST Call for POST request with url "import/ImportFour" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 200 must be returned
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/xml                    |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "export/ImportFour" with the following query param
      | xmlSchemaUri | http%3A%2F%2Fwww.asg.com%2FAnalyzer%2F10.0.0&typeByGroup=BrowserImport%3DCol&typeByGroup=BrowserImport%3DDatata&groupByCatalog=TestCat1%3DBrowserImport |
    And Status code 200 must be returned
    And Verify XML response message not contains value
      | responseXmlText |
      | TestCat1        |

  @MLP-2568 @regression @positive @exportItems
  Scenario: @MLP-2568 Verification of exporting items when typeByGroup has partial  incorrect sqlg types
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/xml                    |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "export/ImportFour" with the following query param
      | xmlSchemaUri | http%3A%2F%2Fwww.asg.com%2FAnalyzer%2F10.0.0&typeByGroup=BrowserImport%3DCol&typeByGroup=BrowserImport%3DTable&groupByCatalog=TestCat1%3DBrowserImport&Rochade-Conversion=false |
    And Status code 200 must be returned
    And Verify XML response message not contains value
      | responseXmlText |
      | TestCat1.Column |
    And Verify XML response message contains value
      | responseXmlText |
      | TestCat1.Table  |

  @MLP-2568 @regression @positive @exportItems
  Scenario: @MLP-2568 Verification of exporting items when typeByGroup has incorrect name
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/xml                    |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "export/TestCat1" with the following query param
      | xmlSchemaUri | http%3A%2F%2Fwww.asg.com%2FAnalyzer%2F10.0.0&typeByGroup=BrowserImport%3DDatabase&typeByGroup=BrowserImport%3DSchema&typeByGroup=BrowserImport%3DColumn&groupByCatalog=ImportFour%3DBrowser&Rochade-Conversion=true |
    And Status code 200 must be returned
    And Verify XML response message not contains value
      | responseXmlText |
      | ImportFour      |
    And Verify XML response message contains value
      | responseXmlText |
      | TestCat1        |


#   //Bug has been raised for this
#   //Expected : 400 Actual : 500
#  @MLP-2568 @regression @positive @exportItems
#  Scenario: @MLP-2568 Verification of exporting items when groupByCatalog has incorrect catalog name
#    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/TestCat1"
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/ImportFour"
#    And supply payload with file name "idc/MLP-2568_CreateCatalogs.json"
#    And user makes a REST Call for POST request with url "settings/catalogs"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    When To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/xml                    |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And supply payload with file name "idc/MLP_2568_RDBMS.xml"
#    Then user makes a REST Call for POST request with url "import/TestCat1" with the following query param
#      | isRnx | true&rnxSchemaNamespace=http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000 |
#    And Status code 200 must be returned
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1114_CreateCatalog4.json"
#    And user makes a REST Call for POST request with url "/settings/catalogs"
#    And Status code 204 must be returned
#    When supply payload with file name "idc/MLP-1114_schemaAnalyzer.json"
#    And user makes a REST Call for PUT request with url "settings" with the following query param
#      | path | com%2Fasg%2Fdis%2Fplatform%2Fxml_schema%2Fhttp%3A%2F%2Fwww.asg.com%2FDataAnalyzer%2F1.0.0.json |
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | application/xml                    |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And supply payload with file name "idc/MLP-1114_stats_tags.xml"
#    And user makes a REST Call for POST request with url "import/ImportFour" with the following query param
#      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000 |
#    And Status code 200 must be returned
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/xml                    |
#      | Accept        | application/xml                    |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user makes a REST Call for Get request with url "export/ImportFour" with the following query param
#      | xmlSchemaUri | http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&typeByGroup=BrowserImport%3DDatabase&groupByCatalog=Cat10%3DBrowserImport&Rochade-Conversion=true |
#    And Status code 200 must be returned
#    And response message not contains value "Catalog Cat10 not found" for XML

  @MLP-2568 @regression @positive @exportItems
  Scenario: @MLP-2568 Verification of exporting data with non exisiting catalog
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                    |
      | Accept        | application/xml                    |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "export/InValidCatalog" with the following query param
      | xmlSchemaUri | http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&typeByGroup=BrowserImport%3DColumn&typeByGroup=BrowserImport%3DService&groupByCatalog=TestCat1%3DBrowserImport&Rochade-Conversion=true |
    Then Status code 404 must be returned
    And Verify XML response message contains value
      | responseXmlText                  |
      | Catalog InValidCatalog not found |

#  @MLP-2568 @regression @positive @webtest @exportItems
#  Scenario: @MLP-2568 Verification of exporting data with tag conversion as true
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "tags/TestCat1/tags/QAAUTOMATION%20TAG"
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects "TestCat1" catalog from catalog list
#    And user clicks on search icon
#    And user click on tag item "AMOUNT_MONTH" from item list
#    And user click on create new tag in the Add tags panel
#    And user enters tag details and click save
#    And user assigns "QAAutomation Tag" tag to the item
#    And user should be able logoff the IDC
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/xml                    |
#      | Accept        | application/xml                    |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user makes a REST Call for Get request with url "export/TestCat1" with the following query param
#      | xmlSchemaUri | http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&Rochade-Conversion=true |
#    Then Status code 200 must be returned
#    And Verify XML response message contains value
#      | responseXmlText  |
#      | QAAUTOMATION TAG |
#
#  @MLP-2568 @regression @positive @webtest @exportItems
#  Scenario: @MLP-2568 Verification of exporting data with tag conversion as false
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "tags/TestCat1/tags/QAAUTOMATION%20TAG"
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects "TestCat1" catalog from catalog list
#    And user clicks on search icon
#    And user click on tag item "AMOUNT_YEAR_TO_DATE" from item list
#    And user click on create new tag in the Add tags panel
#    And user enters tag details and click save
#    And user assigns "QAAutomation Tag" tag to the item
#    And user should be able logoff the IDC
#    And configure a new REST API for the service "IDC"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/xml                    |
#      | Accept        | application/xml                    |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user makes a REST Call for Get request with url "export/TestCat1" with the following query param
#      | xmlSchemaUri | http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&Rochade-Conversion=false |
#    Then Status code 200 must be returned
#    And Verify XML response message not contains value
#      | responseXmlText  |
#      | QAAutomation Tag |

  @MLP-2568 @regression @positive @exportItems
  Scenario: @MLP-2568 Verification of exporting data with query for not existing catalog
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/xml                    |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "export/TestCat/query/queryForwCol/TestCat.Table%3A%3A%3A1" with the following query param
      | xmlSchemaUri | http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&Rochade-Conversion=true |
    Then Status code 404 must be returned
    And Verify XML response message contains value
      | responseXmlText           |
      | Catalog TestCat not found |

  @MLP-2568 @regression @positive @exportItems
  Scenario: @MLP-2568 Verification of exporting data with invalid queryname
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/xml                    |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "export/TestCat1/query/queryTest/TestCat1.Table%3A%3A%3A1" with the following query param
      | xmlSchemaUri | http%3A%2F%2Fwww.asg.com%2FAnalyzer%2F10.0.0&Rochade-Conversion=true |
    Then Status code 404 must be returned
    And Verify XML response message contains value
      | responseXmlText                       |
      | Stored query queryTest does not exist |

  @MLP-2568 @regression @positive @exportItems
  Scenario: @MLP-2568 Verification of exporting data with query for not existing item id
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/xml                    |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "export/TestCat1/query/queryForwCol/TestCat1.Table%3A%3A%3A1755" with the following query param
      | xmlSchemaUri | http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&Rochade-Conversion=true |
    Then Status code 404 must be returned
    And Verify XML response message contains value
      | responseXmlText                                   |
      | Item with id TestCat1.Table:::1755 does not exist |

  @MLP-2568 @regression @positive @exportItems
  Scenario: @MLP-2568 Verification of exporting data with query
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/xml                    |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "export/TestCat1/query/queryDiagramIn/TestCat1.Table%3A%3A%3A1" with the following query param
      | xmlSchemaUri | http%3A%2F%2Fwww.asg.com%2FAnalyzer%2F10.0.0&Rochade-Conversion=false |
    Then Status code 200 must be returned
    And Verify XML response message contains value
      | responseXmlText     |
      | itemType='Database' |
      | itemType='Table'    |








