#@MLP-938 @HiveTags
#Feature: MLP-938: Update Hive items(databases/tables/columns) with tags
#
#  @MLP-938 @HiveTags @sanity @regression @positive
#  Scenario: Verification of creating a cluster
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-938_create_cluster_Cluster_Test.json"
#    When user makes a REST Call for PUT request with url "/settings/analyzers/Cluster%20Test"
#    Then Status code 204 must be returned
#    And New cluster Cluster Test should be created
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | public     | V_Setting | data       | path         |
#
#  @MLP-938 @HiveTags @sanity @regression @positive
#  Scenario:MLP-938: To verify 204 is return using API Wrapper test when user invoke post request
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-938_postreq.json"
#    When user makes a REST Call for PUT request with url "/settings/analyzers/Cluster%20Test"
#    Then Status code 204 must be returned
#
#  @MLP-938 @HiveTags @regression @positive
#  Scenario:MLP-938: To verify 200 is return using API Wrapper test
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for Get request with url "/settings/analyzers/Cluster%20Test"
#    Then Status code 200 must be returned
#    And response body should have the config from postgres DB
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | public     | V_Setting | data       | path         |
#
#  @MLP-938 @HiveTags @regression @positive
#  Scenario:MLP-938: To verify 204 is return using API Wrapper test when user invoke DEL request.
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user makes a REST Call for DELETE request with url "/settings/analyzers/Cluster%20Test"
#    Then Status code 204 must be returned
#    And cluster Test should be deleted from schema "public" of "V_Setting" table





