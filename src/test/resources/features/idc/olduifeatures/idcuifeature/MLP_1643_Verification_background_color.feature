@MLP-1643
Feature:MLP-1643: Change the design of the navigation panel according the visual design
  #Author: Venkata Sai

  @MLP-1643 @webtest @bgcolor @positive
  Scenario:MLP-1643: Verification of facet box background color after checking the checkbox
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "" and clicks on search
    And user checks the checkbox for "BigData" in Catalog
    Then the color of BigData should get changed to grey

  @MLP-1643 @webtest @bgcolor @negative
  Scenario:MLP-1643: Verification of facet box background color before checking the checkbox
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user enters the search text "" and clicks on search
    Then the background color of BigData should be white

  @MLP-1606 @webtest @positive @regression @dashboard
  Scenario:MLP-1606: Verification of placing of Save and Discard button
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Profile Settings button
    And user clicks on Preference Tab
    And user verifies "Save" button is Dispalyed
    And user verifies "Cancel" button is Dispalyed
    And user clicks on "Cancel" button in profile settings panel
    Then profile settings page should get closed

  @MLP-1645 @webtest @positive @regression @dashboard
  Scenario:MLP-1645 : Verification of removal of preselection in the auto suggest list in the search box
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "employees" in the Search Data Intelligence Suite area
    And user verifies auto suggest list should be displayed with no preselection value
    And user clicks on "Enter" key
    And item list with search text should be displayed

  @MLP-1644 @webtest @positive @regression @dashboard
  Scenario:MLP-1644 : Verification of "Show all" and "Show relevant" in the facet
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects the BigData catalog from catalog list
    And user clicks on search icon
    Then user verifies the following actions in DashboardPage
      | action | button        |
      | verify | Show All      |
      | click  | Show All      |
      | verify | Show Relevant |
      | click  | Show Relevant |
      | verify | Show All      |

  @MLP-1646 @webtest @positive @regression @dashboard
  Scenario:MLP-1646 : Verification of removal of preselection in the auto suggest list in the search box
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "_SUCCESS" in the Search Data Intelligence Suite area
    And user clicks on search icon
    And user verifies "2" pane is disaplayed
    And user clicks on first item on the item list page
    And user clicks on minimize icon in the item full view
    And user verifies "3" pane is disaplayed
    Then user verifies search result should be reduced to the middle panel
    And user clicks on close button
    And user verifies "2" pane is disaplayed

