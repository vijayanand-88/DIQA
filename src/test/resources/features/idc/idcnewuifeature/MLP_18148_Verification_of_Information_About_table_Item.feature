@MLP-18148
Feature:MLP-18148: This feature is to verify Add new attributes to business application item type

  ##6973311##
  @MLP-18148 @webtest @regression @positive
  Scenario: SC1#:MLP-18148: Verification of To additional attributes is added for the item type "Business Application"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "regions" and clicks on search
    And user clicks on first item on the item list page
    Then user "verify Item View page Info labels" section has following values
      | Description | Lifecycle | Statistics | Columns |

   ##6973314##
  @MLP-18148 @webtest @regression @positive
  Scenario: SC2#:MLP-18148: Verify if the Classification headers can be expanded and collapsed
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "regions" and clicks on search
    And user clicks on first item on the item list page
    And user "click" in "Item Full view page"
      | fieldName | actionItem  |
      | Collapse  | Description |
    And user verifies whether "Hidden Item View Widget" is "displayed" for "Description" Item view page
    And user "click" in "Item Full view page"
      | fieldName  | actionItem  |
      | Uncollapse | Description |
    And user verifies whether "Item View Widget" is "displayed" for "Description" Item view page
    And user "click" in "Item Full view page"
      | fieldName | actionItem |
      | Collapse  | Lifecycle  |
    And user verifies whether "Hidden Item View Widget" is "displayed" for "Lifecycle" Item view page
    And user "click" in "Item Full view page"
      | fieldName  | actionItem |
      | Uncollapse | Lifecycle  |
    And user verifies whether "Item View Widget" is "displayed" for "Lifecycle" Item view page
    And user "click" in "Item Full view page"
      | fieldName | actionItem |
      | Collapse  | Statistics |
    And user verifies whether "Hidden Item View Widget" is "displayed" for "Statistics" Item view page
    And user "click" in "Item Full view page"
      | fieldName  | actionItem |
      | Uncollapse | Statistics |
    And user verifies whether "Item View Widget" is "displayed" for "Statistics" Item view page
    And user "click" in "Item Full view page"
      | fieldName | actionItem |
      | Collapse  | Columns    |
    And user verifies whether "Table Widget Container" is "not displayed" for "Columns" Item view page
    And user "click" in "Item Full view page"
      | fieldName  | actionItem |
      | Uncollapse | Columns |

  ##6973318##6973319##6973316##
  @MLP-18148 @webtest @regression @positive
  Scenario: SC3#:MLP-18148: Verify of the Column table has the Count and number of Columns list
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "regions" and clicks on search
    And user clicks on first item on the item list page
    And user verifies whether "Row list count" is "displayed" for "Columns" Item view page
    Then user "verify Column widget headers" section has following values
      | Name | Data Type | Length | Sequence Number |
    And user "verifies sorting order" of following "Sequence Number is in ascending order" in "Manage DataSource" page
      |  |
