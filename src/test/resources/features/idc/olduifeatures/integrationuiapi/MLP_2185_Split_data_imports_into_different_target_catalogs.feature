@MLP-2185
Feature: MLP-2185: Splitting of data imports into different target catalogs in dependency on item types

  @MLP-2185 @regression @positive
  Scenario: Verification of spliting a data import into different catalogs
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat1"
    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat2"
    And user makes a REST Call for DELETE request with url "settings/catalogs/Default"
    And supply payload with file name "idc/MLP-2185_CreateCatalogs.json"
    And user makes a REST Call for POST request with url "settings/catalogs"
    And Status code 204 must be returned
    And supply payload with file name "idc/BrowserBGXmlSchema.json"
    And user makes a REST Call for PUT request with url "settings" with the following query param
      | path | com%2Fasg%2Fdis%2Fplatform%2Fxml_schema%2Fhttp%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0.json |
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    When To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "idc/MLP_2185_RDBMS.xml"
    Then user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | true&rnxSchemaNamespace=http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&typeByGroup=Member%3DOrgMember&typeByGroup=DataPackage%3DColumn&groupByCatalog=Cat1%3DMember&groupByCatalog=Cat2%3DDataPackage&sortAndMerge=false&writeWholeSchema=true |
    And Status code 200 must be returned
    And row count "1" should be displayed in database
      | description | schemaName | tableName   | columnName | criteriaName |
      | SELECT      | Cat1       | V_OrgMember | *          |              |
    And row count "6" should be displayed in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | Cat2       | V_Column  | *          |              |
    And row count "1" should be displayed in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | Default    | V_Table   | *          |              |


  @MLP-2185 @webtest @regression @positive
  Scenario: Verification of importing an xml items to default catalog when typeByGroup has incorrect sqlg types
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "/settings/catalogs/Cat3"
    And user makes a REST Call for DELETE request with url "/settings/catalogs/Cat4"
    And supply payload with file name "idc/MLP-2185_CreateCatalog.json"
    And user makes a REST Call for POST request with url "settings/catalogs"
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    When To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "idc/MLP_2185_RDBMS.xml"
    And user makes a REST Call for POST request with url "import/Cat4" with the following query param
      | isRnx | true&rnxSchemaNamespace=http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000&typeByGroup=BrowserImport%3DDB&typeByGroup=BrowserImport%3DCol&typeByGroup=BrowserImport%3DSc&typeByGroup=BrowserImport%3DDat&groupByCatalog=Cat3%3DBrowserImport |
    And Status code 200 must be returned
    Then User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
    And user selects "Cat4" catalog from catalog list
    And user clicks on search icon
#    And user selects the "Cat4" from the Type
    And user verifies "11" items found
    And user verifies imported items are matching with xml "MLP_2185_RDBMS.xml"
    And user selects "Cat3" catalog from catalog list
    And user clicks on search icon
    And user verifies "0" items found


  @MLP-2185  @regression @positive
  Scenario: Verification of importing xml items to default catalog with partial typeByGroup has incorrect sqlg types
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "/settings/catalogs/Cat6"
    And user makes a REST Call for DELETE request with url "/settings/catalogs/Cat5"
    And supply payload with file name "idc/MLP-2185_CreateCatalogGroup.json"
    And user makes a REST Call for POST request with url "settings/catalogs"
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "idc/MLP_2185_RDBMS.xml"
    When user makes a REST Call for POST request with url "import/Cat5" with the following query param
      | isRnx | true&rnxSchemaNamespace=http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000&typeByGroup=BrowserImport%3DTable&typeByGroup=BrowserImport%3DCol&typeByGroup=BrowserImport%3DOrgMember&groupByCatalog=Cat6%3DBrowserImport |
    And Status code 200 must be returned
    Then row count "1" should be displayed in database
      | description | schemaName | tableName   | columnName | criteriaName |
      | SELECT      | Cat6       | V_OrgMember | *          |              |
    And row count "1" should be displayed in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | Cat6       | V_Table   | *          |              |
    And row count "6" should be displayed in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | Cat5       | V_Column  | *          |              |
    And row count "1" should be displayed in database
      | description | schemaName | tableName  | columnName | criteriaName |
      | SELECT      | Cat5       | V_Database | *          |              |
    And row count "1" should be displayed in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | Cat5       | V_Service | *          |              |
    And row count "1" should be displayed in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | Cat5       | V_Schema  | *          |              |


  @MLP-2185 @webtest @regression @positive
  Scenario: Verification of XML import items to default catalog when typeByGroup has incorrect name
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat7"
    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat8"
    And supply payload with file name "idc/MLP-2185_CreateCatalogCat7.json"
    And user makes a REST Call for POST request with url "settings/catalogs"
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "idc/MLP_2185_RDBMS.xml"
    When user makes a REST Call for POST request with url "import/Cat7" with the following query param
      | isRnx | true&rnxSchemaNamespace=http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000&typeByGroup=BrowserImport%3DTable&typeByGroup=BrowserImport%3DColumn&typeByGroup=BrowserImport%3DOrgMember&groupByCatalog=Cat8%3DBrowser |
    And Status code 200 must be returned
    Then User launch browser and traverse to login page
    And user enter credentials for "System Administrator" role
#    And user selects "Cat7" catalog from catalog list
    And user clicks on search icon
    And user selects "Cat7" catalog from catalog list
    And user verifies "11" items found
    And user verifies imported items are matching with xml "MLP_2185_RDBMS.xml"
    And user selects "Cat8" catalog from catalog list
    And user clicks on search icon
    And user verifies "0" items found
#    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat7"
#    And Status code 204 must be returned
#    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat8"
#    And Status code 204 must be returned

  @MLP-2185 @regression @positive
  Scenario: Verification importing a xml in a catalog which has a imported data with different xml file
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat9"
    And supply payload with file name "idc/MLP-2185_CreateCatalogCat9.json"
    And user makes a REST Call for POST request with url "settings/catalogs"
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "idc/MLP_2185_RDBMS.xml"
    Then user makes a REST Call for POST request with url "import/Default" with the following query param
      | isRnx | true&rnxSchemaNamespace=http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000&typeByGroup=BrowserImport%3DDbSystem&typeByGroup=BrowserImport%3DDatabase&typeByGroup=BrowserImport%3DSchema&typeByGroup=BrowserImport%3DColumn&groupByCatalog=Cat9%3DBrowserImport |
    And Status code 200 must be returned
    And row count "1" should be displayed in database
      | description | schemaName | tableName  | columnName | criteriaName |
      | SELECT      | Cat9       | V_Database | *          |              |
    And row count "6" should be displayed in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | Cat9       | V_Column  | *          |              |
    And row count "1" should be displayed in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | Cat9       | V_Schema  | *          |              |
#    And row count "1" should be displayed in database
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | Cat9       | V_Service | *          |              |
    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat9"
    And Status code 204 must be returned
    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat1"
    And Status code 204 must be returned
    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat2"
    And Status code 204 must be returned
    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat3"
    And Status code 204 must be returned
    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat4"
    And Status code 204 must be returned
    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat5"
    And Status code 204 must be returned
    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat6"
    And Status code 204 must be returned
    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat7"
    And Status code 204 must be returned
    And user makes a REST Call for DELETE request with url "settings/catalogs/Cat8"
    And Status code 204 must be returned
    And user makes a REST Call for DELETE request with url "settings/catalogs/Default"
    And Status code 204 must be returned



  @MLP-2185 @regression @negative
  Scenario: Verification of import in nonExist catalog
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/xml                    |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "idc/MLP_2185_RDBMS.xml"
    When user makes a REST Call for POST request with url "import/ErrorCatalog" with the following query param
      | isRnx | true&rnxSchemaNamespace=http%3A%2F%2Frochade.asg.com%2FBROWSER_BG%2F1.00.0&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&streamStartItemCount=50000&typeByGroup=Member%3DOrgMember&typeByGroup=Data%3DDatabase&typeByGroup=DataPackage%3DColumn&groupByCatalog=Cat1%3DMember&groupByCatalog=Cat2%3DDataPackage&groupByCatalog=Cat3%3DData |
    And Status code 404 must be returned
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    Then response message contains value "Catalog ErrorCatalog not found"

