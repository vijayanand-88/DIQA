@MLP-1736
Feature:MLP-1736: Improve UI to delete tags from tag structure of a catalog
  Description: Currently you can only delete a single tag, automatically the next tag jumps to the root level automatically.
  Better: delete a tag and all subtags... at once from tag structure

  @MLP-1736 @webtest @sanity @positive
  Scenario:MLP-1736: Verification Editing a Parent Tag in a Tag Template while creating a catalog
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters Name and Description of New Subject Area using json config "Test Data1"
    And user clicks on active panel save button
    And user clicks on mentioned Subject Area in json config file "Test Data1"
    And user clicks on view tags in edit subject area
    And user clicks on add tag template button
    And user selects "Data Analysis" template in the list of tag templates
    Then the "Data Analysis" template should get displayed in the Add Tags page
    And user clicks on active panel save button
    And user clicks on active panel save button
    And user clicks on mentioned Subject Area in json config file "Test Data1"
    And user clicks on view tags in edit subject area
    And user clicks on edit button near the parent tag "Data Analysis"
    And user enters the new tag name as " Edited"
    And user clicks on save button in the edit properties page
    Then the "Data Analysis Edited" modified template should get displayed in the Add Tags page
    And user clicks on active panel save button
    Then the tags count in the New Subject Area page should be "1"
    And user clicks on save button in New Subject Area page
    And user clicks on mentioned Subject Area in json config file "Test Data1"
    And user clicks on view tags in edit subject area
    Then the "Edited" template should get displayed in the Add Tags page
    And user clicks on close button in the Edit Tags page
    And user clicks on Delete button in the New Subject Area page
    And user clicks on logout button

  @MLP-1736 @webtest @sanity @positive
  Scenario:MLP-1736: Verification Editing a Child Tag in a Tag Template while creating a catalog
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user enters Name and Description of New Subject Area using json config "Test Data1"
    And user clicks on view tags in edit subject area
    And user clicks on add tag template button
    And user selects "Data Analysis" template in the list of tag templates
    Then the "Data Analysis" template should get displayed in the Add Tags page
    And user clicks on active panel save button
    And user clicks on active panel save button
    And user clicks on mentioned Subject Area in json config file "Test Data1"
    And user clicks on view tags in edit subject area
    And user clicks on edit button near the child tag "Critical"
    And user enters the new tag name as " Edited"
    And user clicks on save button in the edit properties page
    Then the "Critical Edited" modified template should get displayed in the Add child Tags page
    And user clicks on active panel save button
    Then the tags count in the New Subject Area page should be "1"
    And user clicks on save button in New Subject Area page
    And user clicks on mentioned Subject Area in json config file "Test Data1"
    And user clicks on view tags in edit subject area
    Then the "Critical Edited" child tag should get displayed in the Add Tags page
    And user clicks on close button in the Edit Tags page
    And user clicks on Delete button in the New Subject Area page
    And user should be able logoff the IDC

  @MLP-1736 @webtest @sanity @positive
  Scenario:MLP-1736: Verification of deleting a parent tag from a Tag Structure
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user clicks on view tags in edit subject area
    And user clicks on add tag template button
    And user selects "Data Analysis" template in the list of tag templates
    Then the "Data Analysis" template should get displayed in the Add Tags page
    And user clicks on remove button near parent tag
    Then entire tag template should get removed
    And user clicks on active panel save button
    Then the tags count in the New Subject Area page should be "0"
    And user should be able logoff the IDC

  @MLP-1736 @webtest @sanity @positive
  Scenario:MLP-1736: Verification of deleting a child tag from a Tag Structure
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on Create Button in Subject Area Management page
    And user clicks on view tags in edit subject area
    And user clicks on add tag template button
    And user selects "Data Analysis" template in the list of tag templates
    Then the "Data Analysis" template should get displayed in the Add Tags page
    And user clicks on remove button near child tag "Critical"
    And user clicks on active panel save button
    Then the tags count in the New Subject Area page should be "1"
    And user clicks on view tags in edit subject area
    Then the removed "Critical" tag should not be present in the Tag Structure
    And user should be able logoff the IDC

