#@MLP-793
#Feature:MLP-793: This feature is to verify Ingestion Configuration
#
#  @MLP-793 @webtest @ingestionconfiguration @sanity
#  Scenario:MLP-793: Verification of Ingestion Configuration on Dashboard page
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    Then login must be success and ingestion configuration is found
#    And user should be able logoff the IDC
#
#  @MLP-793 @webtest @ingestionconfiguration @sanity
#  Scenario:MLP-793: Verification of Ingestion Configuration
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user click on Ingestion Configurations link
#    Then user should be able to see Ingestion configuration
#    And user should be able logoff the IDC
#
#  @MLP-793 @webtest @ingestionconfiguration
#  Scenario:MLP-793: Verification of Ingestion Configuration settings panel
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user click on Ingestion Configurations link
#    And user click on Ingestion Configurations first cluster
#    Then user should be able to see the setting of Ingestion Configuration
#    And user should be able logoff the IDC
#
#  @MLP-793 @webtest @ingestionconfiguration
#  Scenario:MLP-793: Verification of Create button and New Ingestion Configuration panel
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user click on Ingestion Configurations link
#    And user click on create button
#    Then user should be seeing New Ingestion COnfiguration panel
#    And user should see lables of Name Type and Subject area
##   And user should see config type as Cataloger
#    And user should be able logoff the IDC
#
#  @MLP-793 @webtest @ingestionconfiguration @sanity
#  Scenario:MLP-793: Verification of list of available subject Area items
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And User click on Subject Area Manager link on the Dashboard page
#    And User gets to see all the available Subject Areas
#    When user click on Ingestion Configurations link
#    And user click on create button
#    Then user should be seeing New Ingestion COnfiguration panel
#    And user should able to see list of available subject area in subject Area dropdown
#    And user should be able logoff the IDC
#
#  @MLP-793 @webtest @ingestionconfiguration @regression
#  Scenario:MLP-793: Verification of creating a Hive cataloger and HDFS Cataloger
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user click on Ingestion Configurations link
#    And user click on create button
#    And user enters the new ingestion cataloger name
#    And user selects the SubjectArea as BigData and click on link on cataloger
#    And user chooses cataloger type as Hive and add link for filter
#    And user enters the Filter name checks the Tag Big data and Data analytics
#    And user clicks on save and clicks on add Filter to add HDFS cataloger
#    And user chooses cataloger type as HDFS and clicks on add link for filter
#    And user enters the Filter name checks the Tag Big data
#    And user clicks on save on all Scanner Configuration
#    Then user should be able to see the new ingestion cataloger
#    And user should be able logoff the IDC
#
#  @MLP-793 @webtest @ingestionconfiguration @sanity
#  Scenario:MLP-793: Verification of close buttons
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user click on Ingestion Configurations link
#    And user clicks on cataloger and clicks on Hive catalog and Filter link
#    Then user should be able to close the Filter cataloger and Edit scanner settings panel
#    And user should be able logoff the IDC
#
##  @MLP-793 @webtest @ingestionconfiguration @regression
##  Scenario:MLP-793: Verification of Hive ingestion
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator1" role
##    When user click on Ingestion Configurations link
##    And user click on HiveCataloger to run the Hive ingestion
##    Then user should be seeing the Hive cataloger ingestion start and success notification
##    And user should be able logoff the IDC
##
##  @MLP-793 @webtest @ingestionconfiguration @regression
##  Scenario:MLP-793: Verification of HDFS ingestion
##    Given User launch browser and traverse to login page
##    And user enter credentials for "System Administrator1" role
##    When user click on Ingestion Configurations link
##    And user click on HDFSCataloger to run the HDFS ingestion
##    Then user should be seeing the Hive cataloger ingestion start notification
##    And user should be able logoff the IDC
#
#
#
