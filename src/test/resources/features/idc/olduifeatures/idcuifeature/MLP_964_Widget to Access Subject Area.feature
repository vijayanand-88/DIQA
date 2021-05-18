@MLP-964
Feature:MLP-964: This feature is to verify the widget for Subject Area

#  @MLP-964 @webtest @subjectArea @regression
#  Scenario:MLP-964: To Verify edit Subject Area name is successful
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on edit subject area icon
#    And  user edit the subject area name and click on save
#    Then updated subject area name should be displayed on the Dashboard
#    And user should be able logoff the IDC
#
#  @MLP-964 @webtest @subjectArea @sanity
#  Scenario:MLP-964: To Verify edit Subject Area description is successful
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on edit subject area icon
#    And  user edit the subject area description and click on save
#    Then updated subject area description should be displayed on the Dashboard
#    And user should be able logoff the IDC


#  @MLP-964 @webtest @subjectArea @regression
#  Scenario:MLP-964: To Verify edit Quick links of subject Area is successful
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on edit subject area icon
#    And  user edit the quick links and click on save
#    Then updated quick links should be displayed on the Dashboard
#    And user should be able logoff the IDC
#    Note: Same Scenario will be covered in another story

  @MLP-964 @webtest @subjectArea @sanity @positive
  Scenario:MLP-964: To Verify  Quick links labels of subject Area is displayed
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then Quick links of Subject Area should be displayed on the Dashboard
    And user should be able logoff the IDC

  @MLP-964 @webtest @subjectArea @sanity @positive
  Scenario:MLP-964: To Verify  Recent link labels of subject Area is displayed
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    Then Recent label of Subject Area should be displayed on the Dashboard
    And user should be able logoff the IDC

# This is blocked due to solr wrapper
# @MLP-964 @webtest @subjectArea @regression
#  Scenario:MLP-964: To Verify search subject Area is successful
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on search subject area icon
#    And  user enters the search text and clicks on search
#    Then item list with search text should be displayed
#    And user should be able logoff the IDC

#  @webtest @subjectArea @regression
#  Scenario:MLP-964: To Verify widget supports to open a subject Area
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    When user clicks on Bigdata widget title link in the dashboard page
#    Then subject Area tag structure should be displayed
#    And user should be able logoff the IDC
