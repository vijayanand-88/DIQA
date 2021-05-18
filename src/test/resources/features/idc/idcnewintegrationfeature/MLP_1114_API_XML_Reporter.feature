@MLP-1114
Feature: MLP-1114: XMLImporter must be able to handle data in a streamed way internally

  @MLP-1114 @regression
  Scenario: Verification of error when schema is not defined during XMI import
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings" with the following query param
      | path | com%2Fasg%2Fdis%2Fplatform%2Fxml_schema%2Fhttp%3A%2F%2Frochade.asg.com%2FAttTypes%2F1.00.000.json |
    And configure a new REST API for the service "IDC"
    When To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-1114_AttTypesXMI.xml"
    Then user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 400 must be returned
    And response message contains value "Cannot resolve schema for URI http://rochade.asg.com/AttTypes/1.00.000"

  @MLP-1114 @webtest @regression
  Scenario: Verification of XML importer correctly handles XMI import
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1114_schemaAttTypes.json"
    And user makes a REST Call for PUT request with url "settings" with the following query param
      | path | com%2Fasg%2Fdis%2Fplatform%2Fxml_schema%2Fhttp%3A%2F%2Frochade.asg.com%2FAttTypes%2F1.00.000.json |
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    When To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-1114_AttTypesXMI.xml"
    Then user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "tAttType" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "2 Results" in Item Search results page

  @MLP-1114 @regression
  Scenario: Verification of XML importer duplicate names in XMI
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-1114_duplicateNameTestXmi.xml"
    And user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 200 must be returned
#    And response message contains value "non-unique namespace relation clusterNodes"

  @MLP-1114 @regression
  Scenario: Verification of error when uri is given incorrect for XMI
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-1114_AttTypesXMI_Error.xml"
    When user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    Then Status code 400 must be returned
    And response message contains value "Cannot resolve schema for URI http://rochade.asg.com/Att/1.00.000"


  @MLP-1114 @webtest @regression
  Scenario: Verification of XML importer with import mode as keep for XMI
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-1114_AttTypesXMI_New.xml"
    When user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | false&importMode=ITEM%3DKEEP&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 200 must be returned
    Then User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "tAttType" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "4 Results" in Item Search results page

    ##Bug
  @MLP-1114 @webtest @regression
  Scenario: Verification of XML importer with import mode as Remove for XMI
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-1114_AttTypesXMI_New.xml"
    When user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | false&importMode=ITEM%3DREMOVE&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 200 must be returned
    Then User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "tAttType" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "2 Results" in Item Search results page

  @MLP-1114 @webtest @regression
  Scenario: Verification of XML importer accepts the virtual tags attribute
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings" with the following query param
      | path | com%2Fasg%2Fdis%2Fplatform%2Fxml_schema%2Fhttp%3A%2F%2Fwww.asg.com%2FDataAnalyzer%2F1.0.0.json |
    When supply payload with file name "idc/MLP-1114_schemaAnalyzer.json"
    And user makes a REST Call for PUT request with url "settings" with the following query param
      | path | com%2Fasg%2Fdis%2Fplatform%2Fxml_schema%2Fhttp%3A%2F%2Fwww.asg.com%2FDataAnalyzer%2F1.0.0.json |
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-1114_stats_tags.xml"
    And user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 200 must be returned
    Then User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet | Tag       | fileName | userTag |
      | Default     | Tag6 | Tags  | Tag5,Tag6 | city     |         |
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name | facet | Tag       | fileName | userTag |
      | Default     | Tag0 | Tags  | Tag0,Tag1 | address  |         |

  @MLP-1114 @webtest @regression
  Scenario: Verification of XML importer correctly handles RNX import
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings" with the following query param
      | path | com%2Fasg%2Fdis%2Fplatform%2Fxml_schema%2Fhttp%3A%2F%2Frochade.asg.com%2FModeTest.json |
    When supply payload with file name "idc/MLP-1114_schemaModeTestRnx.json"
    And user makes a REST Call for PUT request with url "settings" with the following query param
      | path | com%2Fasg%2Fdis%2Fplatform%2Fxml_schema%2Fhttp%3A%2F%2Frochade.asg.com%2FModeTest.json |
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-1114_modeTestRnx.xml"
    And user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | true&rnxSchemaNamespace=http%3A%2F%2Frochade.asg.com%2FModeTest&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "T1" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "19 Results" in Item Search results page
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "searches/Default/list/T1?limit=0"
    And user stores the values in list from response using jsonpath "$..name"
    And user verifies imported items are matching with xml "idc/MLP-1114_modeTestRnx.xml"


  @MLP-1114 @webtest @regression
  Scenario: Verification of XML importer with import mode as Keep for RNX
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-1114_modeTestRnx_New.xml"
    When user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | true&importMode=ITEM%3DKEEP&importMode=ATTRIBUTE%3DKEEP&rnxSchemaNamespace=http%3A%2F%2Frochade.asg.com%2FModeTest&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "T1" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "22 Results" in Item Search results page

    ##Bug
  @MLP-1114 @webtest @regression
  Scenario: Verification of XML importer with import mode as Remove for RNX
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-1114_modeTestRnx.xml"
    When user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | true&importMode=ITEM%3DREMOVE&importMode=ATTRIBUTE%3DREMOVE&rnxSchemaNamespace=http%3A%2F%2Frochade.asg.com%2FModeTest&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "T1" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "19 Results" in Item Search results page

  @MLP-1114 @regression
  Scenario: Verification of XML importer duplicate names in RNX
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-1114_duplicateNameTestRnx.xml"
    When user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | true&rnxSchemaNamespace=http%3A%2F%2Frochade.asg.com%2FModeTest&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    Then Status code 200 must be returned
#    And response message contains value "non-unique namespace relation"


  @MLP-1114 @regression
  Scenario: Verification of error for invalid catalog during XML importer
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-1114_AttTypesXMI.xml"
    When user makes a REST Call for POST request with url "import/InvalidCatalog" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000 |
    And Status code 404 must be returned
    Then response message contains value "Catalog InvalidCatalog not found"


  @MLP-1114 @regression
  Scenario: Verification of error for invalid catalog during Rnx importer
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-1114_modeTestRnx.xml"
    When user makes a REST Call for POST request with url "import/InvalidCatalog" with the following query param
      | isRnx | true&rnxSchemaNamespace=http%3A%2F%2Frochade.asg.com%2FModeTest&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 404 must be returned
    Then response message contains value "Catalog InvalidCatalog not found"

    ##Bug
  @MLP-1114 @webtest @regression
  Scenario: Verification of XML importer correctly handles XMI import with xmi:id
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/xml                |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And supply payload with file name "idc/MLP-1114_attTypesXmiId.xml"
    When user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
    And Status code 200 must be returned
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "T1" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "2 Results" in Item Search results page

