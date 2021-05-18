Feature: Design and implementation of navigation concept - Part 3

  @positive
  Scenario: Verification of Get facet configuration service
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "settings/searches"
    And Status code 200 must be returned
    And Response return in swagger should match with response returned from "data" column from path "com/asg/dis/platform/search.json"  in database table
      | description | schemaName | tableName | columnName | criteriaName |
      | SELECT      | public     | V_Setting | data       | path         |

  @positive
  Scenario: Verification of Deletion of index
    Given A query param with "raw" and "false" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc\MLP-1667_Oracledatacreation.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    And user makes a REST Call for DELETE request with url "searches/fulltext/synchronize/TestOracle"
    And Status code 200 must be returned
    Then oracle index "TestOracleDataSchema" should get deleted from  database
      | description | schemaName | tableName        | columnName | criteriaName |
      | SELECT      | sqlg_solr  | V_DbOperationReg | schema     | schema       |
    And user makes a REST Call for DELETE request with url "/settings/catalogs/TestOracle"

  @positive
  Scenario: Verification of field names to get all areas
    Given A query param with "namesOnly" and "true" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "settings/searches/fields"
    And Status code 200 must be returned
    And user get all the column names from database "%V_%' and is_nullable='YES"
      | description | schemaName         | tableName | columnName  | criteriaName |
      | SELECT      | information_schema | columns   | column_name | table_name |
