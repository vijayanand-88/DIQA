Feature: Verification of adding a Comments to a data element

  @MLP-1205 @webtest @addingcomments @regression @positive
  Scenario:MLP-1205: Verification of Comment section for an item with default text message
    Given User launch browser and traverse to login page
    And  user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on Create button in ItemView Management Panel
    And user enters name as "itemview_TableType" and definition as "Test Attribute View" for the item view
    And user chooses catalog "BigData" in CATALOGS
    And user enters the Supported Type as "Table" for Item View and click add button
    And user clicks on visual composer button
    And user clicks on add button in the Create New Item View panel
    And User drag and drop a "COMMENTS WIDGET" widget to the page from the displayed widget sets
    And user clicks on apply button on visual composer
    And user clicks on Save button in the Create New Item View panel
    And user clicks on home button
    And user clicks on Quickstart Dashoboard
    And  user enters the search text for adding a comment and clicks on search on Subject Area page
    And user selects the "Table" from the Type
    When user clicks on first item on the item list page
    Then user should be seeing Comments and no comments Label
    And user should be able logoff the IDC

  @MLP-1205 @webtest @addingcomments @regression @sanity @negative
  Scenario:MLP-1205: Verification of Comment section for an empty comment
    Given User launch browser and traverse to login page
    And  user enter credentials for "System Administrator1" role
    And  user enters the search text for adding a comment and clicks on search on Subject Area page
    And user selects the "Table" from the Type
    When user clicks on first item on the item list page
    And user clicks on Leave comment link and give empty comment
    Then user should not be able to add a comment
    And user should be able logoff the IDC

  @MLP-1205 @webtest @addingcomments @regression @sanity @positive
  Scenario:MLP-1205: Verification of Comment section for text comment
    Given User launch browser and traverse to login page
    And  user enter credentials for "System Administrator1" role
    And  user enters the search text for adding a comment and clicks on search on Subject Area page
    And user selects the "Table" from the Type
    When user clicks on first item on the item list page
    And user clicks on Leave comment link and give some text comment
    Then user should be able to add a comment
    And user should be able logoff the IDC

  @MLP-1205 @webtest @addingcomments @regression @positive
  Scenario:MLP-1205: Verification of Editing an Existing Comment
    Given User launch browser and traverse to login page
    And  user enter credentials for "System Administrator1" role
    And  user enters the search text for adding a comment and clicks on search on Subject Area page
    And user selects the "Table" from the Type
    When user clicks on first item on the item list page
#    And user clicks on compress button
#    And user clicks on view all comments
    And user edits the posted comment and clicks on post comment
    Then comment should be saved
    And user should be able logoff the IDC

  @MLP-1205 @webtest @addingcomments @regression @positive
  Scenario:MLP-1205: Verification of Giving reply to existing an Comment
    Given User launch browser and traverse to login page
    And  user enter credentials for "System Administrator1" role
    And  user enters the search text for adding a comment and clicks on search on Subject Area page
    And user selects the "Table" from the Type
    When user clicks on first item on the item list page
    And user Clicks on reply button and writes a reply and click on Send button
    Then Reply should be saved and visble in the comments page
    And user should be able logoff the IDC

  @MLP-1205 @webtest @addingcomments @positive
  Scenario:MLP-1205: Verification of Timestamp of a Comment
    Given User launch browser and traverse to login page
    And  user enter credentials for "System Administrator1" role
    And  user enters the search text for adding a comment and clicks on search on Subject Area page
    And user selects the "Table" from the Type
    When user clicks on first item on the item list page
    Then user should be able to see the Date and time of the comment
    And user should be able logoff the IDC

  @MLP-1205 @webtest @addingcomments @positive
  Scenario:MLP-1205: Verification of image icon of Comment
    Given User launch browser and traverse to login page
    And  user enter credentials for "System Administrator1" role
    And  user enters the search text for adding a comment and clicks on search on Subject Area page
    And user selects the "Table" from the Type
    When user clicks on first item on the item list page
    Then User should see the image icon in comments
    And user should be able logoff the IDC

  @MLP-1205 @webtest @addingcomments @sanity @positive
  Scenario:MLP-1205: Verification of Delete button in Comment section in other user profiles than a user created profile
    Given User launch browser and traverse to login page
    And  user enter credentials for "Information User" role
    And  user enters the search text for adding a comment and clicks on search on Subject Area page
    And user selects the "Table" from the Type
    When user clicks on first item on the item list page
    Then user should not be able to see Delete the button for Comment
    And user should be able logoff the IDC


  @MLP-1205 @webtest @addingcomments @sanity @positive
  Scenario:MLP-1205: Verification of Edit button in Comment section in other user profiles than a user created profile
    Given User launch browser and traverse to login page
    And  user enter credentials for "Information User" role
    And  user enters the search text for adding a comment and clicks on search on Subject Area page
    And user selects the "Table" from the Type
    When user clicks on first item on the item list page
    Then user should not be able to see Edit button for Comment
    And user should be able logoff the IDC

  @MLP-1205 @webtest @addingcomments @regression @positive
  Scenario:MLP-1205: Verification of Deleting a Comment
    Given User launch browser and traverse to login page
    And  user enter credentials for "System Administrator1" role
    And  user enters the search text for adding a comment and clicks on search on Subject Area page
    And user selects the "Table" from the Type
    When user clicks on first item on the item list page
    And user clicks on Delete button on comment
    And user accepts the alerts
    Then comment should be deleted
    And user should be able logoff the IDC

  @MLP-1205 @webtest @addingcomments @regression @positive
  Scenario:MLP-1205: Verification of Deleting the attribute
    Given User launch browser and traverse to login page
    And  user enter credentials for "System Administrator1" role
    And user clicks on Administration widget
    And user clicks on Item View Management
    And user clicks on "itemview_TableType" from item view list
    And user clicks on Delete button in the  Edit Item View panel
    And user should be able logoff the IDC