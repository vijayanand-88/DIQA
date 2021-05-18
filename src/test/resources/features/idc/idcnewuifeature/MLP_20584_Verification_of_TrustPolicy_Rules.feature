@MLP-20584
Feature:MLP-20584: This feature is to verify the Add/Edit and Delete Rules in Trust Policy Page

  ##7043826##7043828##7043829##
  @MLP-20584 @webtest @regression @positive
  Scenario: SC1#:MLP-20584: Verify the user is able to view + icon with Add new rules for adding rules for itemtypes
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And user "verify presence" in "Trust Policy page"
      | fieldName                    | actionItem          |
      | Predefined Tagging Rule Type | BusinessApplication |
    And User performs following actions in the Trust Policy Page
      | Actiontype                           | ActionItem                                                                                                 | ItemName            |
      | Click                                | Rule                                                                                                       | BusinessApplication |
      | Verify predefined rules for ItemType | ATTRIBUTE_PRESENT,ATTRIBUTE_TRUE,ATTRIBUTE_ENUM,TAGGING,BUSINESS_QUALITY,BUSINESS_CAPTURE,BUSINESS_LINEAGE |                     |
    And user verifies "Add New Rules Button" is "displayed" in "Landing Page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And user verifies "New Rule Form" is "displayed" in "Trust Policy Page"

    ##7043830##7043831##7043832##7043833##7043836##7043848##7043849##
  @MLP-20584 @webtest @regression @positive
  Scenario: SC2#:MLP-20584: Verify the all the itemtypes is listed under itemtype drop down and allows the user to select the itemtypes
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And User performs following actions in the Trust Policy Page
      | Actiontype         | ActionItem     | ItemName          |
      | Select Rule Option | Itemtype       | Table             |
      | Select Rule Option | Factor         | ATTRIBUTE_PRESENT |
      | Select Rule Option | Dimension      | Technical         |
      | Enter rule value   | Weight         | 4                 |
      | Enter rule value   | Filter         | businessOwners    |
      | Enter rule value   | Label          | Business Owners   |
      | Click              | Save Rule form |                   |
    And user "verify presence" in "Trust Policy page"
      | fieldName          | actionItem |
      | Rule for Item Type | Table      |

  ##7043850##7045764##
  @MLP-20594 @webtest @regression @positive
  Scenario: SC3#:MLP-20594: Verify the all the itemtypes is listed under itemtype drop down and allows the user to select the itemtypes
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And User performs following actions in the Trust Policy Page
      | Actiontype         | ActionItem    | ItemName          |
      | Select Rule Option | Itemtype      | Column            |
      | Select Rule Option | Factor        | ATTRIBUTE_PRESENT |
      | Select Rule Option | Dimension     | Technical         |
      | Enter rule value   | Weight        | 4                 |
      | Enter rule value   | Filter        | businessOwners    |
      | Enter rule value   | Label         | Business Owners   |
      | Click              | Delete Factor |                   |
    And user clicks on "Yes" link in the "Trust policy page"
    And User performs following actions in the Trust Policy Page
      | Actiontype          | ActionItem | ItemName |
      | Verify Non Presence | Factor Row |          |

    ##7045765##7045767##7046133##
  @MLP-20594 @webtest @regression @positive
  Scenario: SC4#:MLP-20594: Verify the user is able to delete the rule for itemtype by clicking delete icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And User performs following actions in the Trust Policy Page
      | Actiontype | ActionItem         | ItemName |
      | Click      | Rule               | Table    |
      | Click      | Rule Delete Button | Table    |
    And user verifies the "Delete Itemtype" pop up is "displayed"
    And user "click" on "Popup Cancel button" button in "Delete Itemtype pop up"
    And user "verify presence" in "Trust Policy page"
      | fieldName          | actionItem |
      | Rule for Item Type | Table      |
    And User performs following actions in the Trust Policy Page
      | Actiontype | ActionItem         | ItemName |
      | Click      | Rule Delete Button | Table    |
    And user "click" on "Close button" button in "Delete Itemtype pop up"
    And user "verify presence" in "Trust Policy page"
      | fieldName          | actionItem |
      | Rule for Item Type | Table      |
    And User performs following actions in the Trust Policy Page
      | Actiontype | ActionItem         | ItemName |
      | Click      | Rule Delete Button | Table    |
    And user "click" on "DELETE" button in "popup"
    And User performs following actions in the Trust Policy Page
      | Actiontype          | ActionItem    | ItemName |
      | Verify Non Presence | Rule for Item | Table    |

  ##7058448##7058458##
  @MLP-21363 @webtest @regression @positive
  Scenario: SC#5:MLP-21363:Verify the User is able to see the validation message for Weight field if it is empty
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And User performs following actions in the Trust Policy Page
      | Actiontype                | ActionItem                                                                      | ItemName          |
      | Select Rule Option        | Itemtype                                                                        | Table             |
      | Select Rule Option        | Factor                                                                          | ATTRIBUTE_PRESENT |
      | Enter rule value          | Label                                                                           | Business Owners   |
      | Enter rule value          | Weight                                                                          |                   |
      | Click                     | Save Rule form                                                                  |                   |
      | Verify Validation Message | Weight is a mandatory field. Enter a numeric value greater than or equal to 0.0 |                   |
      | Enter rule value          | Weight                                                                          | Fgf65             |
      | Verify Validation Message | Weight should be a numeric value greater than 0.0                               |                   |
      | Enter rule value          | Weight                                                                          | 65%               |
      | Verify Validation Message | Weight should be a numeric value greater than 0.0                               |                   |

    ##7058460##7077880##
  @MLP-21363 @webtest @regression @positive
  Scenario: SC#6:MLP-21363:Verify the User is able to see the validation message for Label field if user enter the space before start and send of string
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Trust Policy" in "Landing page"
    And user "click" on "Add New Rule" button in "Trust Policy page"
    And User performs following actions in the Trust Policy Page
      | Actiontype                | ActionItem                                                        | ItemName          |
      | Select Rule Option        | Itemtype                                                          | Table             |
      | Select Rule Option        | Factor                                                            | ATTRIBUTE_PRESENT |
      | Enter rule value          | Label                                                             |                   |
      | Enter rule value          | Weight                                                            | 4                 |
      | Click                     | Save Rule form                                                    |                   |
      | Verify Validation Message | Label field is mandatory and cannot begin with a blank character. |                   |
      | Enter rule value          | Label value for validation                                        | Business Owners   |
      | Verify Validation Message | Label cannot begin with a blank character.                        |                   |
