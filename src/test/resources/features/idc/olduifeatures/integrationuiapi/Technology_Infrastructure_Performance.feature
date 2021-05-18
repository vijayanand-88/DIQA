#@SimplifiedConfiguration
#Feature: This feature verifies the ingestion status when the cataloger config properties are modified
#
#  Description:
#  This feature verifies Ambari configuration properties
#
#  @TechnologyInfrastructure @webtest
#  Scenario: This scenario is to verify Cluster Demo ingestion status as Unknown when Ambari is configured without https
#    Given configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And Add a random version for the "idc/CatalogerConfig.json" payload
#    And supply payload with file name "idc/CatalogerConfig.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox"
#    And Status code 200 must be returned
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StopCatalogerService.json"
#    And user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE"
#    And verify the Ambari status with the status code "202"
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StartCatalogerService.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE"
#    And sync the test execution for "15" seconds
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When user click on Ingestion Configurations link
#    Then all the ingestions under Cluster Demo should be in "Unknown" status
#
#
#  @TechnologyInfrastructure @webtest
#  Scenario: This scenario is to verify Cluster Demo ingestion status is Idle when Ambari is configured with https
#    Given configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And Add a random version for the "idc/CatalogerConfigHttps.json" payload
#    And supply payload with file name "idc/CatalogerConfigHttps.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox"
#    And Status code 200 must be returned
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StopCatalogerService.json"
#    And user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE"
#    And verify the Ambari status with the status code "202"
#    And sync the test execution for "15" seconds
#    And configure a new REST API for the service "Ambari"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
#      | X-Requested-By | ambari                     |
#    And supply payload with file name "idc/StartCatalogerService.json"
#    When user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE"
#    And sync the test execution for "15" seconds
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator" role
#    And login must be successful for all users
#    When user click on Ingestion Configurations link
#    Then all the ingestions under Cluster Demo should be in "Idle" status
#
