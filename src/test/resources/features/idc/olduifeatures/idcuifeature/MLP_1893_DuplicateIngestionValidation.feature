#@MLP-1893
#Feature:MLP-1758: This feature is to verify Error validation for Duplicate Ingestion
#
#  @MLP-1893 @webtest @ingestionconfiguration @regression
#  Scenario:MLP-1893: Verification of error message handling while creating a catalog with leading blanks
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator" role
#    And user click on Ingestion Configurations link
#    And user click on create button
#    And user enters the new ingestion cataloger name
#    And user clicks on save button on the New Ingestion panel
#    And user click on create button
#    And user enters the new ingestion cataloger name
#    Then Error message should be displayed as "Configuration with this name already exists. Please enter a different name."
#    And user clicks on logout button
#    And user clicks on Yes button in warning message
#
#  @MLP-1893 @webtest @ingestionconfiguration @regression
#  Scenario:MLP-1893: Verification of error message handling while creating a catalog with leading blanks
#    Given User launch browser and traverse to login page
#    When user enter credentials for "Data Administrator" role
#    And user click on Ingestion Configurations link
#    And user click on create button
#    And user enters the new ingestion cataloger name
#    And user clicks on save button on the New Ingestion panel
#    And user click on create button
#    And user enters the new ingestion cataloger name
#    Then Error message should be displayed as "Configuration with this name already exists. Please enter a different name."
#    And user clicks on logout button
#    And user clicks on Yes button in warning message
#
#

