
Feature: Verification of viewing the list of all comments assigned to a data element

  @MLP-1106 @webtest @addingcomments @sanity @positive
  Scenario:MLP-1106: This scenario verifies list of all comments assigned to a data element can be viewed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on mentioned itemview to be deleted "itemView_Table" in json config file
    And user clicks on visual composer button
    And User drag and drop a "COMMENTS WIDGET" widget to the page from the displayed widget sets
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    And user clicks on home button
    And user clicks on Quickstart Dashoboard
    When user clicks on Bigdata widget title link in the dashboard page
    And user click Show All button in type facets
    And  user checks the BigData checkbox in the BigData Subject Area Structure page
    And  user click on item type "0" from item list
    And user clicks on join the discussion button
    And user adds comments and post it
    And user clicks on close button
#    And  user checks comment section with count is displayed
    And  user clicks on view all comments
    Then all comments assigned to a data element should be displayed
    And user should be able logoff the IDC

  @MLP-1106 @webtest @addingcomments @regression @positive
  Scenario:MLP-1106: This scenario involves verification of filtering comments for info user
    Given User launch browser and traverse to login page
    And user enter credentials for "Information User" role
    When user clicks on Bigdata widget title link in the dashboard page
    And user click Show All button in type facets
    And  user checks the BigData checkbox in the BigData Subject Area Structure page
    And  user click on item type "0" from item list
    And  user clicks on view all comments and add user comments
    And  user check show comments and selects info user dropdown
    Then comments related to info user should be displayed
    And user should be able logoff the IDC

  @MLP-1106 @webtest @addingcomments @regression @positive
  Scenario:MLP-1106: This scenario involves verification of filtering comments for admin user
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    When user clicks on Bigdata widget title link in the dashboard page
    And user click Show All button in type facets
    And  user checks the BigData checkbox in the BigData Subject Area Structure page
    And  user click on item type "0" from item list
    And  user clicks on view all comments and add admin comments
    And  user check show comments and selects all user dropdown
    Then comments related to all users should be displayed
    And user clicks on home button
    And user clicks on Yes button in warning message
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on mentioned itemview to be deleted "itemView_Table" in json config file
    And user clicks on visual composer button
    And user removes widget "COMMENTS WIDGET" from the visual composer for the item
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    And user clicks on logout button





