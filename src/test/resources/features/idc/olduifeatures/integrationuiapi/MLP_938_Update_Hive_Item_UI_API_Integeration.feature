#@MLP-35XX, @MLP-55XX
#Feature: MLP-938 This suite for UI and API integration
#  As a user I'm able to call put request in API
#  so that I can see the tag in UI
#
#  @webtest
#  Scenario: To verify tag presents in UI after invoking put request in API
#    Given A query param with "raw" and "false" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-938_postreq.json"
#    When user makes a REST Call for PUT request with url "/settings/analyzers/Cluster%20Test"
#    And User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user click on Ingestion Configurations link
#    Then created configuration must be listed

#  @webtest
#  Scenario: To verify tag must be deleted in UI after invoking delete request in API
#    Given A query param with no value
#    When user invoke DELETE Request with URL "/IDC/services/configuration/ingestion/cataloger/Cluster%20Test"
#    And User traverse to "https://dechedocker02v.asg.com/IDC" IDC home page
#    When user enter credentials for "admin" role
#    And user click on Ingestion Configurations link
#    Then created configuration must not be listed


