@MLP-1105
Feature: MLP-1105: Implement generic item creation/update services
  Description:
  Exclude	Definition	Dev Test	comments
  Item can be created	 	                          3 services:
  POST /items/{areaName}/root
  POST /items/{areaName}/{scopeId}
  POST /items/{areaName}/{scopeId}/{scopeAttrName}
  Existing item can be changed
  (add/update/remove properties)	 	              service: PUT /items/{areaName}/{id}
  Existing items can be changed at once
  (add/update/remove properties)	 	              same services as for create, specify parameter allowUpdate=true
  Automated JUnit tests prove the functionality	   JUnit test class: com.asg.dis.platform.data.ItemsWriteTes

  @positive
  Scenario:MLP-1105: To verify single item is created with allowUpdate is true
    Given A query param with "allowUpdate" and "true" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1105_postreq_allowupdate_true.json"
    When user makes a REST Call for POST request with url "items/Default/root"
    Then Status code 200 must be returned
    And Response id return in json format must match with the value "Default" in database
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | TestNew  | id         | catalog      |

  @positive
  Scenario:MLP-1105: To verify single item is updated with name changes in payload and allowUpdate is false
    Given A query param with "allowUpdate" and "false" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1105_postreq_allowupdate_false_NameModify.json"
    When user makes a REST Call for POST request with url "items/Default/root"
    Then Status code 200 must be returned
    And Response id return in json format must match with the value "Default" in database
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | TestNew  | id         | catalog      |

  @negative
  Scenario:MLP-1105: To verify 400 must be returned if id already exists with allowupdate is false
    Given A query param with "allowUpdate" and "false" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1105_postreq_allowupdate_true.json"
    When user makes a REST Call for POST request with url "items/Default/root"
    Then Status code 400 must be returned
    And response message contains value "ITEM-0013"
    And response message contains value "Item with type TestNew and name updateable already exists"

  @positive
  Scenario:MLP-1105: To verify single item is created with allowupdate is false when no data exists in database
    Given delete the record in database with table name "items" and type name "TestNew"
    And deleted item "TestNew" should not be present in database
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | items     | id         | type         |
    And A query param with "allowUpdate" and "false" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1105_postreq_allowupdate_true.json"
    When user makes a REST Call for POST request with url "items/Default/root"
    Then Status code 200 must be returned
    And Response id return in json format must match with the value "Default" in database
      | description | schemaName | tableName | typeName | columnName | criteriaName |
      | SELECT      | public     | items     | TestNew  | id         | catalog      |

  @positive
  Scenario:MLP-1105: To verify multiple items are created if payload contains multiple values
    Given A query param with "allowUpdate" and "true" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1105_create_MultiItem.json"
    When user makes a REST Call for POST request with url "items/Default/root"
    Then Status code 200 must be returned
    And compare the response ID between REST API response and Postgres database with Schema name "Default" are same
      | description | schemaName | tableName | typeName  | columnName | criteriaName |
      | SELECT      | public     | items     | TestItems | id         | catalog      |

  @positive
  Scenario:MLP-1105: To verify multiple items are created if payload contains multiple values with allowupdate is false and no data exists in database
    Given delete the record in database with table name "items" and type name "TestItems"
    And A query param with "allowUpdate" and "false" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1105_create_MultiItem.json"
    When user makes a REST Call for POST request with url "items/Default/root"
    Then Status code 200 must be returned
    And compare the response ID between REST API response and Postgres database with Schema name "Default" are same
      | description | schemaName | tableName | typeName  | columnName | criteriaName |
      | SELECT      | public     | items     | TestItems | id         | catalog      |


  Scenario:Delete the updateTable
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name       | type    | query | param |
      | SingleItemDelete | Default | updateable | TestNew |       |       |

