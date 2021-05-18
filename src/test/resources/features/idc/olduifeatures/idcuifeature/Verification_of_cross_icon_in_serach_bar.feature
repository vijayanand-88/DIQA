@crossicon
Feature: This feature verifies the cross icon functionality in the search area

  @webtest @login  @sanity @positive
  Scenario:To verify the display of cross button in the Search Data Intelligence Suite area
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator" role
    And user enters the search text "Test" in the Search Data Intelligence Suite area
    Then cross button should get displayed in the Search Data Intelligence Suite area

  @webtest @login  @sanity @positive
  Scenario:To verify the secure connection of IDC URL in chrome
    Given User launch browser and traverse to login page
    When user enter credentials for "Data Administrator" role
    And user enters the search text "Test" in the Search Data Intelligence Suite area
    And cross button should get displayed in the Search Data Intelligence Suite area
    And user clears the text in the Search Data Intelligence Suite area
    Then cross button should not get displayed in the Search Data Intelligence Suite area

 @MLP-1756 @webtest @positive
  Scenario:To Verify two cross buttons are not displayed when start typing in the search box
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test" in the Search Data Intelligence Suite area
    And two cross button should not be displayed in the Search area
