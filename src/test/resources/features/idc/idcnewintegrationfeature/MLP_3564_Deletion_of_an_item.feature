#@MLP-3564
#Feature: MLP-3564 - Verification of soft deletion and hard deletion of an item
#
#  ##MLP-10977 - Open bug for soft deletion
#
#  @MLP-3564 @webtest @regression @positive @itemdeletion
#  Scenario: MLP-3564_Verification of soft deletion of an item
#    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "settings/catalogs/Deletion"
#    And user makes a REST Call for DELETE request with url "settings" with the following query param
#      | path | com%2Fasg%2Fdis%2Fplatform%2Fxml_schema%2Fhttp%3A%2F%2Frochade.asg.com%2FScanHive%2F2.10.000.json |
#    And supply payload with file name "idc/MLP-3564_CreateCatalog.json"
#    And user makes a REST Call for POST request with url "/settings/catalogs"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    When To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | application/xml                |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    And supply payload with file name "idc/MLP-3564_Sample.xml"
#    And user makes a REST Call for POST request with url "import/Deletion" with the following query param
#      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects "Deletion" catalog from catalog list
#    And user clicks on search icon
#    And user verifies "9" items found
#    And user get the column "col1" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | Deletion   | V_Column  | ID         | name         |
#    And user makes a REST Call for DELETE request with url "items/Deletion/Deletion.Column" with softdelete as "true"
#    And Status code 204 must be returned
#    Then user verifies deletedBy column is updated for "col1"
#      | description | schemaName | tableName | columnName    | criteriaName |
#      | SELECT      | Deletion   | V_Column  | asg.deletedBy | name         |
#    And user makes a REST Call for GET request with url "items/Deletion/Deletion.Column" for the stored id
#    And user compares the response with the database for "col1"
#      | description | schemaName | tableName | columnName    | criteriaName |
#      | SELECT      | Deletion   | V_Column  | asg.deletedAt | name         |
#    And user clicks on home button
#    And user selects "Deletion" catalog from catalog list
#    And user enters the search text "col1" in the Search Data Intelligence Suite area
#    And user clicks on search icon
#    And user verifies "1" items found
#    And user should be able logoff the IDC
#
#  @MLP-3564 @webtest @regression @positive @itemdeletion
#  Scenario: MLP-3564_Verification of hard deletion of an item
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user get the column "col1" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | Deletion   | V_Column  | ID         | name         |
#    And user makes a REST Call for GET request with url "items/Deletion/Deletion.Column" for the stored id
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for POST request with url "items/Deletion/harddelete?timestamp=" with timestamp
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    Then user selects "Deletion" catalog from catalog list
#    And user enters the search text "col1" in the Search Data Intelligence Suite area
#    And user clicks on search icon
#    And user verifies "0" items found
#    And user should be able logoff the IDC
#    And deleted item "col1" should not be present in database
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | Deletion   | V_Column  | ID         | name         |
#
#
#  @MLP-3564 @webtest @regression @positive @itemdeletion
#  Scenario: MLP-3564_Verification of soft deletion as false for an item
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user get the column "col2" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | Deletion   | V_Column  | ID         | name         |
#    When user makes a REST Call for DELETE request with url "items/Deletion/Deletion.Column" with softdelete as "false"
#    And Status code 204 must be returned
#    And deleted item "col2" should not be present in database
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | Deletion   | V_Column  | ID         | name         |
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    Then user selects "Deletion" catalog from catalog list
#    And user enters the search text "col2" in the Search Data Intelligence Suite area
#    And user clicks on search icon
#    And user verifies "0" items found
#    And user should be able logoff the IDC
#
#  @MLP-3564 @webtest @regression @positive @itemdeletion
#  Scenario: MLP-3564_Verification of soft deletion as false when importing
#    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/ImportNew"
#    And supply payload with file name "idc/MLP-3564_CreateCatalog1.json"
#    And user makes a REST Call for POST request with url "/settings/catalogs"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    When To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | application/xml                |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    And supply payload with file name "idc/MLP-3564_Sample.xml"
#    And user makes a REST Call for POST request with url "import/ImportNew" with the following query param
#      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    Then user selects "ImportNew" catalog from catalog list
#    And user clicks on search icon
#    And user selects the "Column" from the Type
#    And user verifies "2" items found
#    And supply payload with file name "idc/MLP-3564_SampleNew.xml"
#    And user makes a REST Call for POST request with url "import/ImportNew" with the following query param
#      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&softdelete=false&sortAndMerge=false&writeWholeSchema=true |
#    And Status code 200 must be returned
#    And user clicks on home button
#    Then user selects "ImportNew" catalog from catalog list
#    And user clicks on search icon
#    And user selects the "Column" from the Type
#    And user verifies "1" items found
#    And user should be able logoff the IDC
#    And deleted item "col2" should not be present in database
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | ImportNew  | V_Column  | ID         | name         |
#
#  @MLP-3564 @webtest @regression @positive @itemdeletion
#  Scenario: MLP-3564_Verification of soft deletion when importing
#    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/ImportNew"
#    And supply payload with file name "idc/MLP-3564_CreateCatalog1.json"
#    And user makes a REST Call for POST request with url "/settings/catalogs"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    When To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/xml                |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    And supply payload with file name "idc/MLP-3564_Sample.xml"
#    And user makes a REST Call for POST request with url "import/ImportNew" with the following query param
#      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    Then user selects "ImportNew" catalog from catalog list
#    And user clicks on search icon
#    And user selects the "Column" from the Type
#    And user verifies "2" items found
#    And supply payload with file name "idc/MLP-3564_SampleNew.xml"
#    And user makes a REST Call for POST request with url "import/ImportNew" with the following query param
#      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&softdelete=true&sortAndMerge=false&writeWholeSchema=true |
#    And Status code 200 must be returned
#    And user clicks on home button
#    Then user selects "ImportNew" catalog from catalog list
#    And user clicks on search icon
#    And user selects the "Column" from the Type
#    And user verifies "2" items found
#    And user should be able logoff the IDC
#    And user get the column "col2" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | ImportNew  | V_Column  | ID         | name         |
#    Then user verifies deletedBy column is updated for "col2"
#      | description | schemaName | tableName | columnName    | criteriaName |
#      | SELECT      | ImportNew  | V_Column  | asg.deletedBy | name         |
#    And user makes a REST Call for GET request with url "items/ImportNew/ImportNew.Column" for the stored id
#    And user compares the response with the database for "col2"
#      | description | schemaName | tableName | columnName    | criteriaName |
#      | SELECT      | ImportNew  | V_Column  | asg.deletedAt | name         |
#
#
#  @MLP-3564 @webtest @regression @positive @itemdeletion
#  Scenario: MLP-3564_Verification of soft deletion of multiple items
#    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/Sample"
#    And supply payload with file name "idc/MLP-3564_CreateCatalog2.json"
#    And user makes a REST Call for POST request with url "/settings/catalogs"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    When To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | application/xml                |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    And supply payload with file name "idc/MLP-3564_Sample.xml"
#    And user makes a REST Call for POST request with url "import/Sample" with the following query param
#      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    Then user selects "Sample" catalog from catalog list
#    And user clicks on search icon
#    And user selects the "Column" from the Type
#    And user verifies "2" items found
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-3564_Deletion.json"
#    And user makes a REST Call for POST request with url "items/Sample/delete" with the following query param
#      | softdelete | true |
#    And Status code 204 must be returned
#    And user selects "Sample" catalog from catalog list
#    And user clicks on search icon
#    And user selects the "Column" from the Type
#    And user verifies "2" items found
#    And user should be able logoff the IDC
#    And user get the column "col1" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | Sample     | V_Column  | ID         | name         |
#    Then user verifies deletedBy column is updated for "col1"
#      | description | schemaName | tableName | columnName    | criteriaName |
#      | SELECT      | Sample     | V_Column  | asg.deletedBy | name         |
#    And user makes a REST Call for GET request with url "items/Sample/Sample.Column" for the stored id
#    And user compares the response with the database for "col1"
#      | description | schemaName | tableName | columnName    | criteriaName |
#      | SELECT      | Sample     | V_Column  | asg.deletedAt | name         |
#    And user get the column "col2" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | Sample     | V_Column  | ID         | name         |
#    Then user verifies deletedBy column is updated for "col2"
#      | description | schemaName | tableName | columnName    | criteriaName |
#      | SELECT      | Sample     | V_Column  | asg.deletedBy | name         |
#    And user makes a REST Call for GET request with url "items/Sample/Sample.Column" for the stored id
#    And user compares the response with the database for "col2"
#      | description | schemaName | tableName | columnName    | criteriaName |
#      | SELECT      | Sample     | V_Column  | asg.deletedAt | name         |
#
#
#  @MLP-3564 @webtest @regression @positive @itemdeletion
#  Scenario: MLP-3564_Verification of hard deletion of multiple items which was soft deleted
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user get the column "col1" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | Sample     | V_Column  | ID         | name         |
#    And user makes a REST Call for GET request with url "items/Sample/Sample.Column" for the stored id
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for POST request with url "items/Sample/harddelete?timestamp=" with timestamp
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    Then user selects "Sample" catalog from catalog list
#    And user enters the search text "col1" in the Search Data Intelligence Suite area
#    And user clicks on search icon
#    And user verifies "0" items found
#    And user enters the search text "col2" in the Search Data Intelligence Suite area
#    And user clicks on search icon
#    And user verifies "0" items found
#    And user should be able logoff the IDC
#    And deleted item "col1" should not be present in database
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | Sample     | V_Column  | ID         | name         |
#    And deleted item "col2" should not be present in database
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | Sample     | V_Column  | ID         | name         |
#
#  @MLP-3564 @webtest @regression @positive @itemdeletion
#  Scenario: MLP-3564_Verification of soft deletion as false for multiple items
#    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/Sample"
#    And supply payload with file name "idc/MLP-3564_CreateCatalog2.json"
#    And user makes a REST Call for POST request with url "/settings/catalogs"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    When To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | application/xml                |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    And supply payload with file name "idc/MLP-3564_Sample.xml"
#    And user makes a REST Call for POST request with url "import/Sample" with the following query param
#      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    Then user selects "Sample" catalog from catalog list
#    And user clicks on search icon
#    And user selects the "Column" from the Type
#    And user verifies "2" items found
#    And configure a new REST API for the service "IDC"
#    And A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-3564_Deletion.json"
#    And user makes a REST Call for POST request with url "items/Sample/delete" with the following query param
#      | softdelete | false |
#    And Status code 204 must be returned
#    And user selects "Sample" catalog from catalog list
#    And user enters the search text "col1" in the Search Data Intelligence Suite area
#    And user clicks on search icon
#    And user verifies "0" items found
#    And user enters the search text "col2" in the Search Data Intelligence Suite area
#    And user clicks on search icon
#    And user verifies "0" items found
#    And user should be able logoff the IDC
#    And deleted item "col1" should not be present in database
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | Sample     | V_Column  | ID         | name         |
#    And deleted item "col2" should not be present in database
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | Sample     | V_Column  | ID         | name         |
#
#
#  @MLP-3564 @webtest @regression @positive @itemdeletion
#  Scenario: MLP-3564_Verification of soft deletion as false when importing with groupbyCatalog
#    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/NewOne"
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/NewTwo"
#    And supply payload with file name "idc/MLP-3564_CreateCatalogs.json"
#    And user makes a REST Call for POST request with url "/settings/catalogs"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    When To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/xml                |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    And supply payload with file name "idc/MLP-3564_Sample.xml"
#    And user makes a REST Call for POST request with url "import/NewOne" with the following query param
#      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&typeByGroup=Data%3DColumn&groupByCatalog=NewTwo%3DData&sortAndMerge=false&writeWholeSchema=true |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects "NewTwo" catalog from catalog list
#    And user clicks on search icon
#    And user selects the "Column" from the Type
#    And user verifies "2" items found
#    And user selects "NewOne" catalog from catalog list
#    And user clicks on search icon
#    And user verifies "7" items found
#    And supply payload with file name "idc/MLP-3564_SampleNew.xml"
#    And user makes a REST Call for POST request with url "import/NewOne" with the following query param
#      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&typeByGroup=Data%3DColumn&groupByCatalog=NewTwo%3DData&softdelete=false&sortAndMerge=false&writeWholeSchema=true |
#    And Status code 200 must be returned
#    And user clicks on home button
#    Then user selects "NewTwo" catalog from catalog list
#    And user clicks on search icon
#    And user selects the "Column" from the Type
#    And user verifies "1" items found
#    And user selects "NewOne" catalog from catalog list
#    And user clicks on search icon
#    And user verifies "7" items found
#    And user should be able logoff the IDC
#    And deleted item "col2" should not be present in database
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | NewTwo     | V_Column  | ID         | name         |
#
#  @MLP-3564 @webtest @regression @positive @itemdeletion
#  Scenario: MLP-3564_Verification of soft deletion as true when importing with groupbyCatalog
#    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/NewOne"
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/NewTwo"
#    And supply payload with file name "idc/MLP-3564_CreateCatalogs.json"
#    And user makes a REST Call for POST request with url "/settings/catalogs"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    When To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Content-Type  | application/xml                |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    And supply payload with file name "idc/MLP-3564_Sample.xml"
#    And user makes a REST Call for POST request with url "import/NewOne" with the following query param
#      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&typeByGroup=Data%3DColumn&groupByCatalog=NewTwo%3DData&sortAndMerge=false&writeWholeSchema=true |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects "NewTwo" catalog from catalog list
#    And user clicks on search icon
#    And user selects the "Column" from the Type
#    And user verifies "2" items found
#    And user selects "NewOne" catalog from catalog list
#    And user clicks on search icon
#    And user verifies "7" items found
#    And supply payload with file name "idc/MLP-3564_SampleNew.xml"
#    And user makes a REST Call for POST request with url "import/NewOne" with the following query param
#      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&typeByGroup=Data%3DColumn&groupByCatalog=NewTwo%3DData&softdelete=true&sortAndMerge=false&writeWholeSchema=true |
#    And Status code 200 must be returned
#    And user clicks on home button
#    Then user selects "NewTwo" catalog from catalog list
#    And user clicks on search icon
#    And user selects the "Column" from the Type
#    And user verifies "2" items found
#    And user selects "NewOne" catalog from catalog list
#    And user clicks on search icon
#    And user verifies "7" items found
#    And user should be able logoff the IDC
#    And user get the column "col2" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | NewTwo     | V_Column  | ID         | name         |
#    Then user verifies deletedBy column is updated for "col2"
#      | description | schemaName | tableName | columnName    | criteriaName |
#      | SELECT      | NewTwo     | V_Column  | asg.deletedBy | name         |
#    And user makes a REST Call for GET request with url "items/NewTwo/NewTwo.Column" for the stored id
#    And user compares the response with the database for "col2"
#      | description | schemaName | tableName | columnName    | criteriaName |
#      | SELECT      | NewTwo     | V_Column  | asg.deletedAt | name         |
#
#
#  @MLP-1799 @webtest @regression @positive
#  Scenario: MLP-1799_Verification of deleting a catalog with data deletes the solr index data
#    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/Sample"
#    And supply payload with file name "idc/MLP-3564_CreateCatalog2.json"
#    And user makes a REST Call for POST request with url "/settings/catalogs"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    When To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | application/xml                |
#      | Accept        | application/json               |
#      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
#    And supply payload with file name "idc/MLP-3564_Sample.xml"
#    And user makes a REST Call for POST request with url "import/Sample" with the following query param
#      | isRnx | false&progressIntMillis=10000&isTypedValuesDisabled=false&isWriteUnconditional=false&sortAndMerge=false&writeWholeSchema=true |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And user selects "Sample" catalog from catalog list
#    And user clicks on search icon
#    And user verifies "9" items found
#    And user get the column "Sample" id from the following query
#      | description | schemaName | tableName        | columnName | criteriaName |
#      | SELECT      | sqlg_solr  | V_DbOperationReg | ID         | schema       |
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/Sample"
#    And deleted item "Sample" should not be present in database
#      | description | schemaName | tableName        | columnName | criteriaName |
#      | SELECT      | sqlg_solr  | V_DbOperationReg | ID         | schema       |
#
#
#  @MLP-2353 @regression @webtest
#  Scenario: MLP-2353 Deleting catalogs used
#    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "/settings/catalogs/Sample"
#    And Status code 204 must be returned
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/Deletion"
#    And Status code 204 must be returned
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/ImportNew"
#    And Status code 204 must be returned
#    And user makes a REST Call for DELETE request with url "/settings/catalogs/NewOne"
#    Then Status code 204 must be returned
#
