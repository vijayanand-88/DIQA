@MLP-981
Feature:MLP-981: Move a toplevel tag within the catalog administration should also move all subtags
  Description: In the catalog Administration an Administrator is able to manage the tags for a catalog. To improve the Usability it should be possible to move a complete tag hierachy (supertag with sub-tags) within this control

  @MLP-981 @webtest @sanity @positive
  Scenario:MLP-981: Verification of moving a super tag to a new location
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user clicks on view tags in edit subject area
    And user clicks on add tag template button
    And user selects "Data Analysis" template in the list of tag templates
    And user clicks on left triangle button for the child tag "Confidential"
    And user clicks on save button in the subject area item view page
    And user clicks on view tags in edit subject area
    And user drag and drops "Confidential" parent tag to top
    Then "Confidential" parent tag should be in top of the list

  @MLP-981 @webtest @sanity @positive
  Scenario:MLP-981: Verification of moving a child tag to a new location
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user clicks on view tags in edit subject area
    And user clicks on add tag template button
    And user selects "Data Analysis" template in the list of tag templates
    And user clicks on save button in the subject area item view page
    And user clicks on view tags in edit subject area
    And user drag and drops "Private" child tag to top
    Then "Private" child tag should be in top of the list

