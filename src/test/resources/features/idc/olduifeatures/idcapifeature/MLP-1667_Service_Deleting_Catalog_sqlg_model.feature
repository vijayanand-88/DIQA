@MLP-1667
Feature: MLP-1667: Service Deleting a catalog should optionally delete also the data and sqlg model

  Description:
  To verify to able to create, update and delete catalog using REST API. For deleting the area name, it must also be deleted in sqlg

  @sanity @positive
  Scenario:MLP-1667: To verify catalog is created with supplied payload
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1667_CreateCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 204 must be returned
    And verify created schema "TestDeleteWithDataSchema" exists in database

  @negative
  Scenario:MLP-1667: To verify 409 return when schema name already exists with different area name
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1667_CreateCatalog_invalidschema3.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 409 must be returned
    And response message contains value "CONFIG-0010"
    And response message contains value "Error create catalog Test - schema name TestDeleteWithDataSchema already used for catalog TestDeleteWithData"

  @negative
  Scenario:MLP-1667: To verify Area name already exists when updating same catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1667_CreateCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 409 must be returned
    And response message contains value "CONFIG-0008"
    And response message contains value "Catalog TestDeleteWithData already exists"

  @negative
  Scenario:MLP-1667: To verify created area name is deleted
    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "/settings/catalogs/TestDeleteWithData"
    Then Status code 204 must be returned
    When user makes a REST Call for Get request with url "/settings/catalogs/TestDeleteWithData"
    And response message contains value "CONFIG-0007"
    And verify created schema "TestDeleteWithDataSchema" doesn't exists in database

  @negative
  Scenario:MLP-1667: To verify 400 return when schema name contains backward slash
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1667_CreateCatalog_invalidschema.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 400 must be returned
    And response message contains value "CONFIG-0021"
    And response message contains value "Schema name TestDelete/WithDataSchema contains unsupported characters"

#  Scenario:MLP-1667: To verify 400 return when schema name contains double slash
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1667_CreateCatalog_invalidschema1.json"
#    When user makes a REST Call for POST request with url "/settings/catalogs"
#    Then Status code 400 must be returned
#    And response message contains value "CONFIG-0021"
#    And response message contains value "Schema name TestDelete\\WithDataSchema contains unsupported characters"
#
#  Scenario:MLP-1667: To verify 400 return when schema name contains more than 63 characters
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1667_CreateCatalog_invalidschema6.json"
#    When user makes a REST Call for POST request with url "/settings/catalogs"
#    Then Status code 400 must be returned
#    And response message contains value "CONFIG-0022"
#    And response message contains value "Schema name TestDeleteWithDataSchemaHellooooooooooooooooooooooooooooooooooos is too long, only 63 characters allowed"
#
#
#  Scenario:MLP-1667: To verify 400 return when schema is empty
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1667_CreateCatalog_invalidschema4.json"
#    When user makes a REST Call for POST request with url "/settings/catalogs"
#    Then Status code 400 must be returned
#    And response message contains value "CONFIG-0009"
#    And response message contains value "Missing schema name for create catalog TestDeleteWithData"
#

  @negative
  Scenario:MLP-1667: To verify 400 return when schema is spaces
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1667_CreateCatalog_invalidschema5.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 400 must be returned
    And response message contains value "CONFIG-0009"
    And response message contains value "Missing schema name for create catalog TestDeleteWithData"
#
#  Scenario:MLP-1667: To verify 400 return when schema contains no schema name
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1667_CreateCatalog_invalidschema7.json"
#    When user makes a REST Call for POST request with url "/settings/catalogs"
#    Then Status code 400 must be returned
#    And response message contains value "CONFIG-0009"
#    And response message contains value "Missing schema name for create catalog TestDeleteWithData"
#
#  Scenario:MLP-1667: To verify 400 return when schema contains comma
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1667_CreateCatalog_invalidschema8.json"
#    When user makes a REST Call for POST request with url "/settings/catalogs"
#    Then Status code 400 must be returned
#    And response message contains value "CONFIG-0021"
#    And response message contains value "Schema name TestDele,teWithDataSchema contains unsupported characters"
#
#  Scenario:MLP-1667: To verify 400 return when schema contains semicolon
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1667_CreateCatalog_invalidschema9.json"
#    When user makes a REST Call for POST request with url "/settings/catalogs"
#    Then Status code 400 must be returned
#    And response message contains value "CONFIG-0021"
#    And response message contains value "Schema name TestDele;eWithDataSchema contains unsupported characters"
#
#  Scenario:MLP-1667: To verify 400 return when schema contains singlequotes
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1667_CreateCatalog_invalidschema10.json"
#    When user makes a REST Call for POST request with url "/settings/catalogs"
#    Then Status code 400 must be returned
#    And response message contains value "CONFIG-0021"
#    And response message contains value "Schema name TestDele'eWithDataSchema contains unsupported characters"
#
#  Scenario:MLP-1667: To verify 400 return when schema contains asterik
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-1667_CreateCatalog_invalidschema11.json"
#    When user makes a REST Call for POST request with url "/settings/catalogs"
#    Then Status code 400 must be returned
#    And response message contains value "CONFIG-0021"
#    And response message contains value "Schema name TestDele*eWithDataSchema contains unsupported characters"

  @positive
  Scenario:MLP-1667: To verify 400 return when schema contains forward slash
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1667_CreateCatalog_invalidschema12.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    Then Status code 400 must be returned
    And response message contains value "CONFIG-0021"
    And response message contains value "Schema name TestDele/eWithDataSchema contains unsupported characters"
