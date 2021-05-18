@MLP-1039
Feature:MLP-1039: This feature is to add existing view configurations to a subject area
  #Author: Venkata Sai

  @MLP-1039 @webtest @Views @regression @positive
  Scenario:MLP-1039: Verify whether add item view in subject area is successful
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And  user get views and clicks on edit views in Subject Area
    And  user add new item view and click on save button
    Then itemviews count should get increased
    And user should be able logoff the IDC

@MLP-1039 @webtest @Views @regression @positive
  Scenario:MLP-1039: Verify whether delete item view in subject area is successful
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And  user get views and clicks on edit views in Subject Area
    And  user delete item view and click on save button
    Then itemviews count should get decreased
    And user should be able logoff the IDC

  @MLP-1039 @webtest @Views @regression @negative
  Scenario:MLP-1039: Verify when duplicate item views is added count is not increased
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    When User click on Subject Area Manager link on the Dashboard page
    And user clicks on mentioned Subject Area in json config file "BigData"
    And  user get views and clicks on edit views in Subject Area
    And  user add existing item view and click on save button
    And  user get views and clicks on edit views in Subject Area
    And  user add existing item view and click on save button
    Then itemviews count is not increased
    And user should be able logoff the IDC

  @MLP-1039 @webtest @subjectArea @positive
  Scenario:MLP-1039: Verification of Views in the New Subject Area panel
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And User click on Subject Area Manager link on the Dashboard page
    Then user clicks on Create Button in Subject Area Management page
    And user verifies views is disabled on  New Catalog panel
    And user clicks on logout button

  @MLP-2251 @webtest @subjectArea @positive
  Scenario:MLP-2251: Verification of mouse hover item in tooltip of the search result list.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user selects the BigData catalog from catalog list
    And user clicks on search icon
    And user selects the "Column" from the Type
    And user hovers on first item in the item list page
    And user verifies whether tooltip displayed with the item name at last with type "Column"
    And user selects the "Table" from the Type
    And user hovers on first item in the item list page
    And user verifies whether tooltip displayed with the item name at last with type "Table"
    And user clicks on logout button
