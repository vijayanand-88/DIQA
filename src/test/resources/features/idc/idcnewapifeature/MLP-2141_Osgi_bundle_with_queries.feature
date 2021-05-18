@MLP-2141
Feature: MLP-2141 - Verification of uploading a osgi bundle with queries

  @MLP-2141 @regression @positive
  Scenario: Verification of uploading a osgi bundle with queries
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data            |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for DELETE request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1"
    And user attaches/upload file "osgibundle/Osgi1-0.0.1-SNAPSHOT.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    And Status code 200 must be returned
    And response query definition for "com/asg/dis/platform/query/com.asg.idc.Osgi1-0.0.1.SNAPSHOT-query_list.json" in database should match with the file "idc/MLP-2141_Uploading_Bundle_Query_definition.json"
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Setting  | attributes | name         |


  @MLP-2141 @regression @positive
  Scenario: Verification of updating a bundle with queries
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data            |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    And user attaches/upload file "osgibundle/Osgi1-0.0.1-SNAPSHOT_queryupdated.jar" to request
    When user makes a REST Call for POST request with url "extensions/bundles"
    And Status code 200 must be returned
    And response query definition for "com/asg/dis/platform/query/com.asg.idc.Osgi1-0.0.1.SNAPSHOT-query_list.json" in database should match with the file "idc/MLP-2141_Updating_Bundle_Query_definition.json"
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Setting  | attributes | name         |


  @MLP-2027 @regression @positive
  Scenario: Verification of deleting a bundle deletes the query
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json               |
      | Accept        | application/json               |
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
    When user makes a REST Call for DELETE request with url "extensions/bundles/TestPlugin/com.asg.idc.Osgi1/0.0.1.SNAPSHOT"
    And Status code 204 must be returned
    Then user makes a REST Call for Get request with url "settings/queries/com.asg.idc.Osgi1-0.0.1.SNAPSHOT-query_list"
    And Status code 404 must be returned
    And response message contains value "Stored query com.asg.idc.Osgi1-0.0.1.SNAPSHOT-query_list does not exist"
    And deleted query definition "com/asg/dis/platform/query/com.asg.idc.Osgi1-0.0.1.SNAPSHOT-query_list.json" should not be present in database
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | Setting  | attributes | name         |



