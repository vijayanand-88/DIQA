@MLP-1120
Feature:MLP-1120: As an Administrator I can collapse/uncollapse the super tags
  Description: Catalog Manager provides the Option administer tags for this catalog. Actually it is not possible to collapse/uncollapse the super tags for a better Navigation within this area. The Administrator should be enabled to collapse/Uncollapse for a better Usability and the execution of specific Actions which includes all tags assigned to this supertag.

  @MLP-1120 @webtest @sanity @positive
  Scenario:MLP-1120: Verification of Collapsing a Super Tag as an Administrator
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user clicks on view tags in edit subject area
    And user clicks on add tag template button
    And user selects "Data Analysis" template in the list of tag templates
    And user clicks on minus button near the parent tag
    Then all the child tags should be hidden

  @MLP-1120 @webtest @sanity @positive
  Scenario:MLP-1120: Verification of Uncollapsing a Super Tag as an Administrator
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user clicks on view tags in edit subject area
    And user clicks on add tag template button
    And user selects "Data Analysis" template in the list of tag templates
    And user clicks on minus button near the parent tag
    And user clicks on plus button near the parent tag
    Then all the child tags should be shown