@MLP-3297
Feature: MLP-3297: Dataset Services Testcases

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of creating a DataSets with no dataElements
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3297_DataSets_with_no_Elements.json"
    When user makes a REST Call for POST request with url "datasets"
    Then Status code 200 must be returned
    And verify DataSet is created with name "DataSet with No DataElements", Description "data set with no DataElements" and status as "PUBLIC"
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of creating a DataSets with dataElements
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3297_DataSets_with_data_Elements.json"
    When user makes a REST Call for POST request with url "datasets"
    Then Status code 200 must be returned
    And verify DataSet is created with name "DataSet with DataElements", Description "Table items" and status as "PUBLIC" and has data items
      | dataElements     |
      | BigData.File:::1 |
      | BigData.File:::2 |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of creating a Duplicate DataSets
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3297_DataSets_with_data_Elements.json"
    When user makes a REST Call for POST request with url "datasets"
    Then Status code 200 must be returned
    And verify DataSet is created with name "DataSet with DataElements", Description "Table items" and status as "PUBLIC" and has data items
      | dataElements     |
      | BigData.File:::1 |
      | BigData.File:::2 |
    And supply payload with file name "idc/MLP-3297_DataSets_with_data_Elements.json"
    When user makes a REST Call for POST request with url "datasets"
    Then Status code 400 must be returned
    And response body should have "Item with type DataSet and name DataSet with DataElements already exists" message
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of Adding a dataElements to DataSet
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3297_DataSets_with_no_Elements.json"
    When user makes a REST Call for POST request with url "datasets"
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And supply payload with file name "idc/MLP-3297_Adding_DataElements.json"
    When user makes a REST Call for "POST" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path "/dataelements"
    Then Status code 200 must be returned
    And  verify DataSet is created with name "DataSet with No DataElements", Description "data set with no DataElements" and status as "PUBLIC" and has data items
      | dataElements      |
      | BigData.File:::1  |
      | BigData.File:::2  |
      | BigData.Field:::3 |
    When user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of Adding a dataElements to non exist DataSet
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3297_Adding_DataElements.json"
    When user makes a REST Call for POST request with url "datasets/DataSets.DataSet%3A%3A%3A15/dataelements"
    Then Status code 404 must be returned
    And  response body should have "DataSet with id DataSets.DataSet:::15 not found" message

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of unassingning an existing items and assigning a new items to dataElements to DataSet
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3297_DataSets_with_data_Elements.json"
    When user makes a REST Call for POST request with url "datasets"
    Then Status code 200 must be returned
    And verify DataSet is created with name "DataSet with DataElements", Description "Table items" and status as "PUBLIC" and has data items
      | dataElements     |
      | BigData.File:::1 |
      | BigData.File:::2 |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And supply payload with file name "idc/MLP-3297_assign_and_unassign_dataset.json"
    When user makes a REST Call for "POST" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path "/dataelements"
    Then Status code 200 must be returned
    And verify DataSet is created with name "DataSet with DataElements", Description "Table items" and status as "PUBLIC" and has data items
      | dataElements         |
      | BigData.Column:::1   |
      | BigData.Column:::2   |
      | BigData.Column:::3   |
      | BigData.Database:::4 |
      | BigData.Database:::3 |
      | BigData.Database:::1 |
      | BigData.Database:::2 |
      | BigData.File:::1     |
      | BigData.File:::2     |
    When user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of Adding a dataElements to non exist DataSet
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3297_Adding_DataElements.json"
    When user makes a REST Call for POST request with url "datasets/DataSets.DataSet%3A%3A%3A15/dataelements"
    Then Status code 404 must be returned
    And response body should have "DataSet with id DataSets.DataSet:::15 not found" message

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of updating a description of a DataSets
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3297_PUT_Dataset_File.json"
    When user makes a REST Call for POST request with url "datasets"
    Then Status code 200 must be returned
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And supply payload with file name "idc/MLP-3297_PUT_Dataset_desc_update_File.json"
    When user makes a REST Call for "PUT" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned
    And verify DataSet is created with name "Table DataSet", Description "Updated - Table Set" and status as "PUBLIC"
    When user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of updating a status of a DataSets
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3297_PUT_Dataset_status_create_File.json"
    When user makes a REST Call for POST request with url "datasets"
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And supply payload with file name "idc/MLP-3297_PUT_Dataset_status_PUBLIC_Update_File.json"
    When user makes a REST Call for "PUT" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned
    And verify DataSet is created with name "Cluster DataSets", Description "cluster data items" and status as "PUBLIC" and has data items
      | dataElements        |
      | BigData.Cluster:::1 |
      | BigData.Cluster:::2 |
    When user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of Adding a Data Elements through PUT request
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3297_PUT_Adding_Elements.json"
    When user makes a REST Call for POST request with url "datasets"
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And supply payload with file name "idc/MLP-3297_PUT_Data_Elements_add.json"
    When user makes a REST Call for "PUT" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned
    And verify DataSet is created with name "DataType Set", Description "DataTypes" and status as "PUBLIC" and has data items
      | dataElements         |
      | BigData.DataType:::5 |
      | BigData.DataType:::6 |
      | BigData.DataType:::7 |
      | BigData.DataType:::8 |
    When user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of Removing a Data Elements through PUT request
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3297_PUT_Adding_Elements.json"
    When user makes a REST Call for POST request with url "datasets"
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And supply payload with file name "idc/MLP-3297_PUT_Data_Elements_add.json"
    When user makes a REST Call for "PUT" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned
    And verify DataSet is created with name "DataType Set", Description "DataTypes" and status as "PUBLIC" and has data items
      | dataElements         |
      | BigData.DataType:::5 |
      | BigData.DataType:::6 |
      | BigData.DataType:::7 |
      | BigData.DataType:::8 |
    When supply payload with file name "idc/MLP-3297_PUT_Data_Elements_removal.json"
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "PUT" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned
    And verify DataSet is created with name "DataType Set", Description "DataTypes" and status as "PUBLIC" and has data items
      | dataElements         |
      | BigData.DataType:::5 |
    When user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of Empty Data Elements assignment for DataSet through PUT request
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3297_PUT_Emptying_Elements.json"
    When user makes a REST Call for POST request with url "datasets"
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And supply payload with file name "idc/MLP-3297_PUT_empty_assignment.json"
    When user makes a REST Call for "PUT" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned
    And verify DataSet is created with name "Column Set", Description "Column set" and status as "PUBLIC" and has data items
      | dataElements |
    When user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of Adding a Data Elements through PUT request for incorrect DataSet
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When supply payload with file name "idc/MLP-3297_PUT_Data_Elements_add.json"
    And user makes a REST Call for PUT request with url "datasets/DataSets.DataSet%3A%3A%3A15"
    Then Status code 404 must be returned
    And response body should have "DataSet with id DataSets.DataSet:::15 not found" message

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of GET specific DataSets
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3297_DataSets_with_data_Elements.json"
    When user makes a REST Call for POST request with url "datasets"
    Then Status code 200 must be returned
    And verify DataSet is created with name "DataSet with DataElements", Description "Table items" and status as "PUBLIC" and has data items
      | dataElements     |
      | BigData.File:::1 |
      | BigData.File:::2 |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "GET" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    And verify DataSet is created with name "DataSet with DataElements", Description "Table items" and status as "PUBLIC" and has data items
      | dataElements     |
      | BigData.File:::1 |
      | BigData.File:::2 |
    And user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""


  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of GET specific DataSets for non existent id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "datasets/DataSets.DataSet%3A%3A%3A1500"
    Then Status code 404 must be returned
    And response body should have "DataSet with id DataSets.DataSet:::1500 not found" message

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of DELETE specific DataSets
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-3297_DataSets_with_data_Elements.json"
    When user makes a REST Call for POST request with url "datasets"
    Then Status code 200 must be returned
    And verify DataSet is created with name "DataSet with DataElements", Description "Table items" and status as "PUBLIC" and has data items
      | dataElements     |
      | BigData.File:::1 |
      | BigData.File:::2 |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of Delete specific DataSets for non existent id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "datasets/DataSets.DataSet%3A%3A%3A1500"
    Then Status code 200 must be returned
#    And response body should have "DataSet with id DataSets.DataSet:::1500 not found" message

  @MLP-3297 @sanity @regression @datasets
  Scenario: Verification of GET for list of DataSets
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "datasets"
    Then Status code 200 must be returned
    And All DataSets should be listed
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | DataSets   | V_DataSet | name       |              |



#  @MLP-3297 @datasets @sanity @regression
#  Scenario: Deleting the DataSets catalog if exists
#    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "settings/catalogs/DataSets"
#    Then verify created schema "DataSets" doesn't exists in database
#
#  @MLP-3297 @datasets @sanity @regression
#  Scenario: Verification of creating a DataSets catalog
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-3297_DataSets_Catalog_creation.json"
#    When user makes a REST Call for POST request with url "settings/catalogs"
#    Then Status code 204 must be returned
#    Then verify created schema "DataSets" exists in database


