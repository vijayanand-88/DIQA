@MLP-2027
Feature: MLP-2027 - Verification of uploading a osgi bundle

  @MLP-2027 @regression @positive
  Scenario: Verification of uploading a osgi bundle
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for DELETE request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1"
    And user attaches/upload file "osgibundle/Osgi1-0.0.1.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    Then Status code 200 must be returned
    And response returns with the following items
      | description                    | searchItems | expectedResults |
      | ResponseBody_ReturnSingleValue | type        | TestPlugin      |
    And "com.asg.idc.Osgi1-0.0.1" osgi bundle should be uploaded to bundle table
      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
      | SELECT      | public     | V_Bundle  | *          | name,version | version      | plugins    |


  @MLP-2027 @regression @negative
  Scenario: Verification of uploading a incorrect format as xlsx
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "datasetupload/customer_sample.xlsx" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    Then Status code 400 must be returned
    And response message contains value "Input stream not recognized as a bundle"


  @MLP-2027 @regression @positive
  Scenario: Verification of uploading bundles with same bundle name but with different versions
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "osgibundle/Osgi1-0.0.1-SNAPSHOT.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    Then Status code 200 must be returned
    And response returns with the following items
      | description                    | searchItems | expectedResults |
      | ResponseBody_ReturnSingleValue | type        | TestPlugin      |
    And "com.asg.idc.Osgi1-0.0.1.SNAPSHOT" osgi bundle should be uploaded to bundle table
      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
      | SELECT      | public     | V_Bundle  | *          | name,version | version      | plugins    |


  @MLP-2027 @regression @positive
  Scenario: Verification of getting plugin schemes
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1/0.0.1.SNAPSHOT/plugins/OService1/scheme"
    Then Status code 200 must be returned
    And response of schemes should match with "idc/MLP-2027_PluginSchemes.json"


  @MLP-2027 @regression @positive
  Scenario: Verification of getting bundle version schemes
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1/0.0.1.SNAPSHOT/schemes"
    Then Status code 200 must be returned
    And response of schemes should match with "idc/MLP-2027_Schemes.json"


  @MLP-2027 @regression @positive
  Scenario: Verification of listing all bundle types
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "extensions/bundles"
    Then Status code 200 must be returned
    And response of bundle types should match with the table in database
      | description | schemaName | tableName    | columnName | criteriaName |
      | SELECT      | public     | V_BundleType | name       |              |

  @MLP-2027 @regression @positive
  Scenario: Verification of uploading a bundle with same version as previous should replace the old bundle
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "osgibundle/Osgi1-0.0.1-SNAPSHOT_updated.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    Then Status code 200 must be returned
    And response returns with the following items
      | description                    | searchItems | expectedResults |
      | ResponseBody_ReturnSingleValue | type        | TestPlugin      |
      | ResponseBody_ReturnSingleValue | plugins     | OService1       |
    And "com.asg.idc.Osgi1-0.0.1.SNAPSHOT" osgi bundle should be uploaded to bundle table
      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
      | SELECT      | public     | V_Bundle  | *          | name,version | version      | plugins    |


  @MLP-2027 @regression @negative
  Scenario: Verification of getting latest version of bundle with invalid bundle name
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "extensions/bundles/Invalid/com.asg.idc.Osgi1/0.0.1"
    Then Status code 404 must be returned
    And response message contains value "Bundle type Invalid not found"


  @MLP-2027 @regression @negative
  Scenario: Verification of getting bundle version schemes with invalid version
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1/0.0.45/schemes"
    Then Status code 404 must be returned
    And response message contains value "Bundle com.asg.idc.Osgi1 of type TestPlugin not found in version 0.0.45"


  @MLP-2027 @regression @negative
  Scenario: Verification of listing all bundles with invalid type
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "extensions/bundles/InvalidType"
    Then Status code 404 must be returned
    And response message contains value "Bundle type InvalidType not found"

  @MLP-2027 @regression @negative
  Scenario: Verification of getting plugin schemes with invalid plugin
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1/0.0.1.SNAPSHOT/plugins/Oservice4/scheme"
    Then Status code 404 must be returned
    And response message contains value "Plugin Oservice4 scheme not found in bundle com.asg.idc.Osgi1 of type TestPlugin, version 0.0.1.SNAPSHOT"

  @MLP-2027 @regression @negative
  Scenario: Verification of listing all known bundle version with invalid bundle name
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "extensions/bundles/TestPlugin/InvalidBundle"
    Then Status code 404 must be returned
    And response message contains value "Bundle InvalidBundle of type TestPlugin not found"

  @MLP-2027 @regression @negative
  Scenario: Verification of deleting all version of bundle with invalid name
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "extensions/bundles/TestPlugin/InvalidBundle"
    Then Status code 404 must be returned
    And response message contains value "Bundle InvalidBundle of type TestPlugin not found"


  @MLP-2027 @regression @negative
  Scenario: MLP-2027 Verification of error when deleting a bundle type which has bundles
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "extensions/bundles/TestPlugin"
    Then Status code 412 must be returned
    And response message contains value "Bundle type TestPlugin has 2 bundles"


  @MLP-2027 @regression @negative
  Scenario: Verification of uploading a bundle without bundle type
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "osgibundle/Osgi1-0.0.1_Error.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    Then Status code 400 must be returned
    And response message contains value "Cannot detect bundle type in Bundle com.asg.idc.Osgi1-0.0.1"

  @MLP-2027 @regression @positive
  Scenario: Verification of listing bundle version
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1"
    Then Status code 200 must be returned
    And response of bundle "com.asg.idc.Osgi1-0.0.1" version should match with the table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Bundle  | version    | name         |
    And response of bundle "com.asg.idc.Osgi1-0.0.1.SNAPSHOT" version should match with the table in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Bundle  | version    | name         |


  @MLP-2027 @regression @negative
  Scenario: MLP-2027 Verification of deleting a bundle type with invalid type
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "extensions/bundles/InvalidType"
    Then Status code 404 must be returned
    And response message contains value "Bundle type InvalidType not found"


  @MLP-2027 @regression @positive
  Scenario: Verification of listing all bundles
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "extensions/bundles/TestPlugin"
    Then Status code 200 must be returned
    And all bundles "com.asg.idc.Osgi1-0.0.1" should match with database
      | description | schemaName | tableName | columnName   | criteriaName        |
      | SELECT      | public     | V_Bundle  | version,name | asg.modifiedBy,name |
    And all bundles "com.asg.idc.Osgi1-0.0.1.SNAPSHOT" should match with database
      | description | schemaName | tableName | columnName   | criteriaName        |
      | SELECT      | public     | V_Bundle  | version,name | asg.modifiedBy,name |


  @MLP-2027 @regression @positive
  Scenario: Verification of getting latest version of bundle
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "osgibundle/Osgi1-9.5.1.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    Then Status code 200 must be returned
    And user attaches/upload file "osgibundle/Osgi1-0.9.0.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    Then Status code 200 must be returned
    When user makes a REST Call for Get request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1/LATEST"
    Then Status code 200 must be returned
    And response returns with the following items
      | description                    | searchItems | expectedResults |
      | ResponseBody_ReturnSingleValue | version     | 9.5.1           |


  @MLP-2027 @regression @positive
  Scenario: Verification of deleting a version of bundle
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1/0.0.1"
    Then Status code 204 must be returned
    And deleted bundle "com.asg.idc.Osgi1" of version "0.0.1" should not be present in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Bundle  | *          | name,version |

  @MLP-2027 @regression @positive
  Scenario: Verification of deleting all version of bundle
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1"
    Then Status code 204 must be returned
    And deleted bundle "com.asg.idc.Osgi1" should not be present in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Bundle  | *          | name         |


  @MLP-2027 @regression @positive
  Scenario: MLP-2027 Verification of deleting a bundle type which has no bundles
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "extensions/bundles/TestPlugin"
    Then Status code 204 must be returned
    And user makes a REST Call for Get request with url "extensions/bundles"
    And Status code 200 must be returned
    And response should not contain deleted bundle type


  @MLP-2027 @regression @positive
  Scenario: Verification of uploading a osgi bundle for WebService type
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "extensions/bundles/WebService/com.asg.idc.Osgi1"
    And user attaches/upload file "osgibundle/Osgi1-1.0.1_WebService.jar" to request
    And user makes a REST Call for POST request with url "extensions/bundles"
    Then Status code 200 must be returned
    And response returns with the following items
      | description                    | searchItems | expectedResults |
      | ResponseBody_ReturnSingleValue | type        | WebService      |
    And "com.asg.idc.Osgi1-1.0.1" osgi bundle should be uploaded to bundle table
      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
      | SELECT      | public     | V_Bundle  | *          | name,version | version      | plugins    |
    And user makes a REST Call for DELETE request with url "extensions/bundles/WebService/com.asg.idc.Osgi1"
    And Status code 204 must be returned

  @MLP-2027 @regression @positive
  Scenario: Verification of uploading a osgi bundle for Analysis type
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user attaches/upload file "osgibundle/Osgi1-0.0.1_Analysis.jar" to request
    And user makes a REST Call for POST request with url "extensions/bundles"
    Then Status code 200 must be returned
    And response returns with the following items
      | description                    | searchItems | expectedResults |
      | ResponseBody_ReturnSingleValue | type        | Analysis        |
    And "com.asg.idc.Osgi1-0.0.1" osgi bundle should be uploaded to bundle table
      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
      | SELECT      | public     | V_Bundle  | *          | name,version | version      | plugins    |
    And user makes a REST Call for DELETE request with url "extensions/bundles/Analysis/com.asg.idc.Osgi1"
    And Status code 204 must be returned


  @MLP-2027 @regression @positive
  Scenario: Verification of uploading a osgi bundle for BackOffice type
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user attaches/upload file "osgibundle/Osgi1-0.0.1_BackOffice.jar" to request
    And user makes a REST Call for POST request with url "extensions/bundles"
    Then Status code 200 must be returned
    And response returns with the following items
      | description                    | searchItems | expectedResults |
      | ResponseBody_ReturnSingleValue | type        | BackOffice      |
    And "com.asg.idc.Osgi1-0.0.1" osgi bundle should be uploaded to bundle table
      | description | schemaName | tableName | columnName | criteriaName | firstColName | secColName |
      | SELECT      | public     | V_Bundle  | *          | name,version | version      | plugins    |
    And user makes a REST Call for DELETE request with url "extensions/bundles/BackOffice/com.asg.idc.Osgi1"
    And Status code 204 must be returned

  @MLP-2027 @regression @positive
  Scenario: Verification of creating and deleting a bundle type
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for DELETE request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1"
    And user attaches/upload file "osgibundle/Osgi1-0.0.1.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    Then Status code 200 must be returned
    And user makes a REST Call for Get request with url "extensions/bundles/TestPlugin?order=false"
    And Status code 200 must be returned
    And user makes a REST Call for DELETE request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1"
    And Status code 204 must be returned
    When user makes a REST Call for DELETE request with url "extensions/bundles/TestPlugin"
    Then Status code 204 must be returned
    And deleted bundle "com.asg.idc.Osgi1-0.0.1" should not be present in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Bundle  | *          | name         |

  @MLP-2027  @regression @positive
  Scenario: MLP-2027 Verification of uploading a bundle with incorrect type
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "osgibundle/PlainTextExample.txt" to request
    And user makes a REST Call for POST request with url "extensions/bundles"
    Then Status code 400 must be returned
    And response message contains value "BUNDLES-0007"
    And response message contains value "Input stream not recognized as a bundle"
    And Verify response header contains value
      | HeaderValue                             |
      | application/json; vnd.di-api.version=v1 |




