@MLP-21085 @MLP-21985 @MLP-30676
Feature:MLP-21085: This feature is to verify the manage tags page features

 ##7051614##7051615##7051616##7051617##7051622##7051625##7051639##7051619##
  @MLP-21085 @webtest @regression @positive @e2e
  Scenario: SC#1:21085: Verify if the Admin panel displays 'Tag' > 'Manage Tags' menu.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "verify sidebar menu items" of following "Tag" in "Landing" page
      | Manage Tags |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Tags |
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Manage Tags |
    And user "verifies presence" of following "Page Subtitle" in "Manage Tags" page
      | Manage the hierarchy of tags. |
    And user "click" on "Add Category" button in "Manage Tags page"
    Then user verifies the "Add Category" pop up is "displayed"
    And user "verifies presence" of following "Contextual Message" in "Add Category" page
      | Enter details to add a category. |
    And user creates a tag with the following parameters
      | CategoryName  | Definition             | Icon                 | colorWidthHeight | Protected |
      | SampleTestTag | Created for Automation | fa fa-address-book-o | 189,18           | false     |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Tags |
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | SampleTestTag |
    And User performs following actions in the Manage Tags Page
      | Actiontype              | ActionItem                | ItemName             | Attribute |
      | Verifies Tag Icon       | SampleTestTag             | fa fa-address-book-o |           |
      | Verifies Tag Icon Color | SampleTestTag             |                      |           |
      | Click                   | Category Menu buttons     | SampleTestTag        | Add       |
      | Enter Text              | Category Name             | SampleAutoTag        |           |
      | Click                   | Edit category Save Button |                      |           |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Tags |

  ##7108493##7108494##7108499##7108500##7108501##
  @MLP-23675 @webtest @regression @positive @e2e
  Scenario:SC#2: MLP-23675: Verify the discard popup works as expected in manage tags
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName      | Attribute |
      | Click      | Category Menu buttons | SampleTestTag | Edit      |
    And user "Verifies popup" is "displayed" for "Edit Category"
    And user clicks on "Escape" key
    And user "Verifies popup" is "not displayed" for "Unsaved changes"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName      | Attribute |
      | Click      | Category Menu buttons | SampleTestTag | Edit      |
      | Enter Text | Category Name         | Edited        |           |
    And user clicks on "Escape" key
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Edit Category popup"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem                   |
      | Click      | Category popup Cancel button |
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Edit Category popup"
    And user "click" on "Popup Close" button in "Edit Category popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"

    ##7051627##7051628##7051629##7051631##7249007
  @MLP-21085 @webtest @regression @positive @e2e
  Scenario:SC#3:MLP-21085:Verify in search results screen Tag Facet displays the Tag Category and results list displays the correct tag name with icon
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option        |
      | BusinessApplication | SampleBA  | Save and Open |
    And user enters the search text "SampleBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem    | Section   |
      | Verify Tag Presence in Section | SampleAutoTag | Available |
      | Tag Selection                  | SampleAutoTag | Available |
    And user "click" on "Assign" button in "Assign a Tag popup"
    And user enters the search text "SampleBA" and clicks on search
    Then results panel "search item count" should be displayed as "Select all 1 items" in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem    | ItemName             | Section                   |
      | Verify Tag Presence | SampleAutoTag |                      |                           |
      | Verify Tag Category | Category      | SampleAutoTag        | SampleAutoTag             |
      | Verify Tag Type     | Type          | SampleAutoTag        | Structure Information Tag |
      | Verify Tag Icon     | SampleAutoTag | fa fa-address-book-o |                           |

  ##7051626##7051632##7051634##7051635##7249010
  @MLP-21085 @webtest @regression @positive @e2e
  Scenario: SC#4:21085: Verify if mouse hovering on Root Tag Category displays menu buttons 'Add, Edit and Delete'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Expand/Collapse Tag Button" for "SampleTestTag" in "Manage Tags"
    And User performs following actions in the Manage Tags Page
      | Actiontype                     | ActionItem                | ItemName        | Attribute |
      | Verifies Category Menu buttons | SampleTestTag             | Add,Edit,Delete |           |
      | Click                          | Category Menu buttons     | SampleAutoTag   | Edit      |
      | Enter Text                     | Category Name             | Edited          |           |
      | Click                          | Edit category Save Button |                 |           |
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | SampleAutoTagEdited |
    And user enters the search text "SampleBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 1 items" in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem          | ItemName | Section |
      | Verify Tag Presence | SampleAutoTagEdited |          |         |
    And user enters the search text "SampleBA" and clicks on search
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem          | Section  |
      | Verify Tag Presence in Section | SampleAutoTagEdited | Assigned |

  ##7051636##7051640##
  @MLP-21085 @webtest @regression @positive
  Scenario: SC#5:21085: Verify that user can add a Sub Tag to the Root Tag by clicking Add button
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem                | ItemName       | Attribute |
      | Click      | Category Menu buttons     | SampleTestTag  | Add       |
      | Enter Text | Category Name             | SampleTestTag1 |           |
      | Click      | Edit category Save Button |                |           |
      | Click      | Category Menu buttons     | SampleTestTag  | Add       |
      | Enter Text | Category Name             | SampleTestTag2 |           |
      | Click      | Edit category Save Button |                |           |
      | Click      | Category Menu buttons     | SampleTestTag  | Add       |
      | Enter Text | Category Name             | SampleTestTag3 |           |
      | Click      | Edit category Save Button |                |           |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Tags |
    And user "click" on "Expand/Collapse Tag Button" for "SampleTestTag" in "Manage Tags"
    Then user "verifies Tree Sructure of Tags" of following "SampleTestTag" in "Manage Tags" Page
      | SampleTestTag1 |
      | SampleTestTag2 |
      | SampleTestTag3 |

    ##7051641##7051642##7051643
  @MLP-21085 @webtest @regression @positive @e2e
  Scenario:SC#6:MLP-21085:Verify if for any item, system displays the sub tag created in "Available" list
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "SampleBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem     | Section   |
      | Verify Tag Presence in Section | SampleTestTag1 | Available |
      | Verify Tag Presence in Section | SampleTestTag2 | Available |
      | Verify Tag Presence in Section | SampleTestTag3 | Available |
      | Tag Selection                  | SampleTestTag1 | Available |
    And user "click" on "Assign" button in "Create Item Page"
    And user enters the search text "SampleBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    Then results panel "search item count" should be displayed as "Select all 1 items" in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem     |
      | Verify Tag Presence | SampleTestTag1 |
    And user enters the search text "SampleBA" and clicks on search
    And User performs following actions in the Item view Page
      | Actiontype                        | ActionItem     | ItemName             | Section |
      | Verify Tag Icon in Search Results | SampleTestTag1 | fa fa-address-book-o |         |

  ##7051645##7051705##7051720##
  @MLP-21085 @webtest @regression @positive @e2e
  Scenario: SC#7:21085: Verify if Sub Tag can be edited with new Name, Definition
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Expand/Collapse Tag Button" for "SampleTestTag" in "Manage Tags"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem                | ItemName                  | Attribute |
      | Click      | Category Menu buttons     | SampleTestTag1            | Edit      |
      | Enter Text | Tag Name                  | Edited                    |           |
      | Enter Text | Tag Definition            | Tag definition is updated |           |
      | Click      | Edit category Save Button |                           |           |
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | SampleTestTag1Edited |
    Then user "verifies Tree Sructure of Tags" of following "SampleTestTag" in "Manage Tags" Page
      | SampleTestTag1Edited |
      | SampleTestTag2       |
      | SampleTestTag3       |
    And user enters the search text "SampleBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    Then user "Tag List in facet" of following "Tags" in Item View Page
      | SampleTestTag1Edited |
    And User performs following actions in the Item view Page
      | Actiontype                        | ActionItem           | ItemName             | Section |
      | Verify Tag Icon in Search Results | SampleTestTag1Edited | fa fa-address-book-o |         |
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem           | Section  |
      | Verify Tag Presence in Section | SampleTestTag1Edited | Assigned |

  ##7051724##7051741##
  @MLP-21085 @webtest @regression @positive @e2e
  Scenario: SC#8:21085: Verify if Deleting the Sub Tag removes the Tag from Manage Tags List below Root tag
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Expand/Collapse Tag Button" for "SampleTestTag" in "Manage Tags"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName             | Attribute |
      | Click      | Category Menu buttons | SampleTestTag1Edited | Delete    |
    And user "click" on "DELETE" button in "Unsaved changes pop up"
    Then user "verifies missing Tags in Tree Sructure" of following "SampleAutoTagEdited" in "Manage Tags" Page
      | SampleTestTag1Edited |
    And user enters the search text "SampleBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Tag list not contains" in Item View Page
      | SampleTestTag1Edited |
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                   | ActionItem           |
      | Verify Tag absense in widget | SampleTestTag1Edited |

    ##7051744##
  @MLP-21085 @webtest @regression @positive
  Scenario: SC#9:21085: Verify if "Business Application, Technology and PII"(Will be in future -release) tags are displayed with Protected Lock icon
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    Then user "verifies protected lock icon" of following "Tags" in "Manage Tags" Page
      | BusinessApplication |
      | Technology          |

    ##7051742##7051743##
  @MLP-21085 @webtest @regression @positive
  Scenario: SC#10:21085: Verify if Deleting the Sub Tag removes the Tag from Manage Tags List below Root tag
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Expand/Collapse Tag Button" for "SampleTestTag" in "Manage Tags"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName            | Attribute |
      | Click      | Category Menu buttons | SampleAutoTagEdited | Delete    |
    And user "click" on "DELETE" button in "Unsaved changes pop up"
    And user "verifies absence" of following "Tags" in "Manage Tags" page
      | SampleAutoTagEdited |
    And user enters the search text "SampleBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    Then user "verify non presence" of following "Tag list not contains" in Item View Page
      | SampleAutoTagEdited |
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                   | ActionItem          |
      | Verify Tag absense in widget | SampleAutoTagEdited |

  ##7068642##7068644##
  @MLP-21985 @webtest @regression @positive
  Scenario: SC#1:21985: Verify if Root Category Tag can be created and its auto saved. Refreshing the Manage Tags displays the created Tag
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    Then user verifies the "Add Category" pop up is "displayed"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user creates a tag with the following parameters
      | CategoryName  | Definition                     | Icon                | colorWidthHeight | Protected |
      | DemoParentTag | Created for Automation purpose | fa fa-envelope-open | 150,200          | false     |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Tags |
    And user refreshes the application
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | DemoParentTag |
    And User performs following actions in the Manage Tags Page
      | Actiontype              | ActionItem                | ItemName            | Attribute |
      | Verifies Tag Icon       | DemoParentTag             | fa fa-envelope-open |           |
      | Verifies Tag Icon Color | DemoParentTag             |                     |           |
      | Click                   | Category Menu buttons     | DemoParentTag       | Edit      |
      | Enter Text              | Category Name             | Edited              |           |
      | Click                   | Edit category Save Button |                     |           |
    And user refreshes the application
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | DemoParentTagEdited |

  ##7068643##
  @MLP-21985 @webtest @regression @positive
  Scenario: SC#2:21985: Verify if Sub Tag can be created and its auto saved. Refreshing the Manage Tags displays the created Sub Tag
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem                | ItemName            | Attribute |
      | Click      | Category Menu buttons     | DemoParentTagEdited | Add       |
      | Enter Text | Category Name             | DemoSubTag1         |           |
      | Click      | Edit category Save Button |                     |           |
    And user refreshes the application
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Tags |
    And user "click" on "Expand/Collapse Tag Button" for "DemoParentTagEdited" in "Manage Tags"
    Then user "verifies Tree Sructure of Tags" of following "DemoParentTagEdited" in "Manage Tags" Page
      | DemoSubTag1 |

  ##7068646##
  @MLP-21985 @webtest @regression @positive
  Scenario:SC#3:MLP-21985: Verify if the Newly created Root Tag and Sub tag can be tagged to an item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option        |
      | BusinessApplication | DemoBA    | Save and Open |
    And user enters the search text "DemoBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem  | Section   |
      | Verify Tag Presence in Section | DemoSubTag1 | Available |
      | Tag Selection                  | DemoSubTag1 | Available |
    And user "click" on "Assign" button in "Create Item Page"
    And user enters the search text "DemoBA" and clicks on search
    Then results panel "search item count" should be displayed as "Select all 1 items" in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem  |
      | Verify Tag Presence | DemoSubTag1 |

  ##7068645##
  @MLP-21985 @webtest @regression @positive
  Scenario: SC#4:21985: Verify if Sub Tag can be edited and its auto saved. Refreshing the Manage Tags displays the modified Sub Tag
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Expand/Collapse Tag Button" for "DemoParentTagEdited" in "Manage Tags"
    Then user "verifies Tree Sructure of Tags" of following "DemoParentTagEdited" in "Manage Tags" Page
      | DemoSubTag1 |
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem                | ItemName    | Attribute |
      | Click      | Category Menu buttons     | DemoSubTag1 | Edit      |
      | Enter Text | Category Name             | Edited      |           |
      | Click      | Edit category Save Button |             |           |
    And user refreshes the application
    And user "click" on "Expand/Collapse Tag Button" for "DemoParentTagEdited" in "Manage Tags"
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | DemoSubTag1Edited |

    ##7068647##
  @MLP-21985 @webtest @regression @positive
  Scenario:SC#5:MLP-21985: Verify if after modifying the tag Names, check if items are displayed with modified tag names
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "DemoBA" and clicks on search
    Then results panel "search item count" should be displayed as "Select all 1 items" in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem        |
      | Verify Tag Presence | DemoSubTag1Edited |

    ##7068650##
  @MLP-21985 @webtest @regression @positive
  Scenario:SC#6:MLP-21985: Create a Root Tag and Sub Tag ad create a child for the Sub Tag, verify if moving up the child tag changes the tag hierarchy. Refreshing the page displays the Parent with 2 sub tags
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Expand/Collapse Tag Button" for "DemoParentTagEdited" in "Manage Tags"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem                | ItemName          | Attribute |
      | Click      | Category Menu buttons     | DemoSubTag1Edited | Add       |
      | Enter Text | Category Name             | DemoSubTag1       |           |
      | Click      | Edit category Save Button |                   |           |
    And user refreshes the application
    And user "click" on "Expand/Collapse Tag Button" for "DemoParentTagEdited" in "Manage Tags"
    Then user "verifies missing Tags in Tree Sructure" of following "SampleAutoTagEdited" in "Manage Tags" Page
      | DemoSubTag1 |
    And user "click" on "Expand/Collapse Tag Button" for "DemoSubTag1Edited" in "Manage Tags"
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | DemoSubTag1 |
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName    | Attribute |
      | Click      | Category Menu buttons | DemoSubTag1 | Move Up   |
    Then user "verifies Tree Sructure of Tags" of following "DemoParentTagEdited" in "Manage Tags" Page
      | DemoSubTag1Edited |
      | DemoSubTag1       |
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName            | Attribute |
      | Click      | Category Menu buttons | DemoParentTagEdited | Delete    |
    And user "click" on "DELETE" button in "Unsaved changes pop up"
    And user "verifies absence" of following "Tags" in "Manage Tags" page
      | DemoParentTagEdited |

  Scenario:Delete the BA Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                 | type                | query | param |
      | SingleItemDelete | Default | SampleBA             | BusinessApplication |       |       |
      | SingleItemDelete | Default | DemoBA               | BusinessApplication |       |       |
      | SingleItemDelete | Default | DemoParentTagEdited  | Tag                 |       |       |
      | SingleItemDelete | Default | SampleTestTag1Edited | Tag                 |       |       |
      | SingleItemDelete | Default | SampleTestTag        | Tag                 |       |       |

    ##7091266##7091267##7091268####7091269##7091270##
  @MLP-22393 @webtest @regression @positive
  Scenario: SC#1:22393: Verify Color Icon features
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user "Property label" for "Color" in "Add Category" Page
    And user verifies "Color Icon" is "displayed" in "Add Category Popup"
    And user verifies "Color Textbox" is "disabled" in "Add Category Popup"
    And User performs following actions in the Manage Tags Page
      | Actiontype                 | ActionItem             | ItemName |
      | Select Color               | color-slider           | 180,20   |
      | Select Color               | color-palette          | 180,150  |
      | Click                      | Add Category Ok button |          |
      | Verify color in color icon |                        |          |

  ##7091271##7091272## Descoped - Parent tag can't be tagged
#  @MLP-22393 @webtest @regression @positive
#  Scenario: SC#3:22393: Verify if the selected color is applied to the root tag icon in Manage Tags screen
#    Given User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user "click" on "Sidebar Link" for "Create" in "Landing page"
#    And user "Create Item" in Create new item page
#      | fieldName           | attribute | option        |
#      | BusinessApplication | TestBA    | Save and Open |
#    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
#    And user "click" on "Add Category" button in "Manage Tags page"
#    And user creates a tag with the following parameters
#      | CategoryName | Definition             | Icon                 | colorWidthHeight | Protected |
#      | AutoTestTag  | Created for Automation | fa fa-address-book-o | 120,150          | false     |
#    And user "verifies presence" of following "Tags" in "Manage Tags" page
#      | AutoTestTag |
#    And User performs following actions in the Manage Tags Page
#      | Actiontype              | ActionItem  | ItemName             |
#      | Verifies Tag Icon       | AutoTestTag | fa fa-address-book-o |
#      | Verifies Tag Icon Color | AutoTestTag |                      |
#    And User performs following actions in the Manage Tags Page
#      | Actiontype | ActionItem                | ItemName     | Attribute |
#      | Click      | Category Menu buttons     | AutoTestTag  | Add       |
#      | Enter Text | Category Name             | AutoTestTag1 |           |
#      | Click      | Edit category Save Button |              |           |
#    And user enters the search text "TestBA" and clicks on search
#    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
#    And user "click" on "Select All checkbox" button in "Item Search Results" page
#    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
#    And User performs following actions in the Item view Page
#      | Actiontype                     | ActionItem   | Section   |
#      | Verify Tag Presence in Section | AutoTestTag1 | Available |
#      | Tag Selection                  | AutoTestTag1 | Available |
#    And user "click" on "Assign" button in "Create Item Page"
#    And user enters the search text "TestBA" and clicks on search
#    Then results panel "search item count" should be displayed as "Select all 1 items" in Item Search results page
#    And user clicks on first item on the item list page
#    And User performs following actions in the Item view Page
#      | Actiontype              | ActionItem   | ItemName             | Section |
#      | Verify Tag Presence     | AutoTestTag1 |                      |         |
#      | Verify Tag Icon         | AutoTestTag1 | fa fa-address-book-o |         |
#      | Verifies Tag Icon Color | AutoTestTag1 |                      |         |

  Scenario:22393:Create a new tag
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option        |
      | BusinessApplication | TestBA    | Save and Open |
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user creates a tag with the following parameters
      | CategoryName | Definition             | Icon                 | colorWidthHeight | Protected |
      | AutoTestTag  | Created for Automation | fa fa-address-book-o | 120,150          | false     |
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | AutoTestTag |

  ##7091273##7091274##7091275##7091276##
  @MLP-22393 @webtest @regression @positive
  Scenario: SC#4:22393:Verify if in 'Edit Category' Change the icon and color and clicking cancel, retains the old icon and color
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user creates a tag with the following parameters
      | CategoryName | Definition             | Icon                 | colorWidthHeight | Protected |
      | TestDemoTag  | Created for Automation | fa fa-address-book-o | 150,150          | false     |
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | TestDemoTag |
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName    | Attribute |
      | Click      | Category Menu buttons | TestDemoTag | Edit      |
    And User performs following actions in the Manage Tags Page
      | Actiontype                   | ActionItem                 | ItemName |
      | Select Color                 | color-palette              | 10,240   |
      | Click                        | Add Category Cancel button |          |
      | Verify Old Color is retained |                            |          |
    And User performs following actions in the Manage Tags Page
      | Actiontype   | ActionItem    | ItemName |
      | Select Color | color-palette | 180,150  |
    And user "click" on "Close" button in "Edit Category page"
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | TestDemoTag |
    And User performs following actions in the Manage Tags Page
      | Actiontype                      | ActionItem  | ItemName             |
      | Verifies Tag Icon               | TestDemoTag | fa fa-address-book-o |
      | Verifies Tag Icon Color is same | TestDemoTag |                      |
    And User performs following actions in the Manage Tags Page
      | Actiontype                 | ActionItem             | ItemName    | Attribute |
      | Click                      | Category Menu buttons  | TestDemoTag | Edit      |
      | Select Color               | color-slider           | 5,5         |           |
      | Select Color               | color-palette          | 80,150      |           |
      | Click                      | Add Category Ok button |             |           |
      | Verify color in color icon |                        |             |           |
    And user "click" on "Add Category Save" button in "Edit Category"
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | TestDemoTag |
    And User performs following actions in the Manage Tags Page
      | Actiontype              | ActionItem            | ItemName    | Attribute |
      | Verifies Tag Icon Color | TestDemoTag           |             |           |
      | Click                   | Category Menu buttons | TestDemoTag | Delete    |
    And user "click" on "DELETE" button in "Unsaved changes pop up"
    And user "verifies absence" of following "Tags" in "Manage Tags" page
      | TestDemoTag |
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName    | Attribute |
      | Click      | Category Menu buttons | AutoTestTag | Delete    |
    And user "click" on "DELETE" button in "Unsaved changes pop up"
    And user "verifies absence" of following "Tags" in "Manage Tags" page
      | AutoTestTag |

  Scenario:Delete the TestBA Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name        | type                | query | param |
      | SingleItemDelete | Default | TestBA      | BusinessApplication |       |       |
      | SingleItemDelete | Default | AutoTestTag | Tag                 |       |       |
      | SingleItemDelete | Default | TestDemoTag | Tag                 |       |       |

    #############################################################################################
  ##7266863##7266871##7249006
  @MLP-30676 @webtest @regression @positive @e2e
  Scenario: SC#1:30676: Verify tags can be expanded and collapsed in all the root tags component
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype           | ActionItem          | ItemName                                                                        |
      | Verify tag absence   | PII                 | Email Address,Phone Number,Fax Number,Social Security Number,Postal Code        |
      | Expand tag hierarchy | PII                 |                                                                                 |
      | Verify tag presence  | PII                 | Email Address,Phone Number,Fax Number,Social Security Number,Postal Code        |
      | Verify readonly text | Technology          | Read only access. These tags are managed through the Data Discover application. |
      | Verify readonly text | BusinessApplication | Read only access. These tags are managed through the Data Discover application. |

  #7266856#7266857##7266858##7266859##7266861##7266862##7266864##7266865##
  @MLP-30676 @webtest @regression @positive @e2e
  Scenario: SC#2:30676: Verify if the Admin panel displays 'Tag' > 'Manage Tags' menu.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype                         | ActionItem                                         | ItemName                                                                                                                                    | Attribute |
      | Verifies Default Root tags Section |                                                    | Structure Information Tags,PII Tags,Technology Tags,Business Application Tags                                                               |           |
      | Verify Default Sub tags            | General                                            | Backward Lineage Candidate,Forward Lineage Candidate                                                                                        |           |
      | Verify Default Sub tags            | PII                                                | Email Address,Phone Number,Fax Number,Social Security Number,Postal Code,State,IP Address,Gender,Full Name,First Name,Last Name,Middle Name |           |
      | Verify Default Sub tags            | Technology                                         | Cloud Data,Big Data,Enterprise Data                                                                                                         |           |
      | Verify Add Hierarchy icon Absence  | PII Tags,Technology Tags,Business Application Tags |                                                                                                                                             |           |
    And user "click" on "Add Category" button in "Manage Tags page"
    Then user verifies the "Add Category" pop up is "displayed"
    And user "verifies presence" of following "Contextual Message" in "Add Category" page
      | Enter details to add a category. |
    And user creates a tag with the following parameters
      | CategoryName | Definition             | Icon                 | colorWidthHeight | Protected |
      | AutoTestTag  | Created for Automation | fa fa-address-book-o | 189,18           | false     |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Tags |
    And User performs following actions in the Manage Tags Page
      | Actiontype          | ActionItem                 | ItemName    | Attribute |
      | Verify tag presence | Structure Information Tags | AutoTestTag |           |
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem                | ItemName    | Attribute |
      | Click      | Category Menu buttons     | AutoTestTag | Edit      |
      | Enter Text | Category Name             | Edited      |           |
      | Click      | Edit category Save Button |             |           |
    And User performs following actions in the Manage Tags Page
      | Actiontype                  | ActionItem                 | ItemName          | Attribute |
      | Verify tag presence         | Structure Information Tags | AutoTestTagEdited |           |
      | Click Category Menu buttons | Structure Information Tags | AutoTestTag       | Delete    |
    And user "click" on "Confirm" button in "Manage Tags Page"
    And User performs following actions in the Manage Tags Page
      | Actiontype                                | ActionItem                 | ItemName          | Attribute                          |
      | Verify tag absence                        | Structure Information Tags | AutoTestTagEdited |                                    |
      | Verify Category Menu buttons are disabled | Structure Information Tags | General           | Default category cannot be deleted |

  ##7266866##7266866##7249004
  @MLP-30676 @webtest @regression @positive @e2e
  Scenario: SC#3:30676: Verify user able to create, edit and delete tags under the tag hierarchies
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user creates a tag with the following parameters
      | CategoryName | Definition             | Icon                 | colorWidthHeight | Protected |
      | AutoTestTag  | Created for Automation | fa fa-address-book-o | 189,18           | false     |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Tags |
    And User performs following actions in the Manage Tags Page
      | Actiontype          | ActionItem                 | ItemName    | Attribute |
      | Verify tag presence | Structure Information Tags | AutoTestTag |           |
    And User performs following actions in the Manage Tags Page
      | Actiontype                  | ActionItem                | ItemName                              | Attribute |
      | Click                       | Category Menu buttons     | AutoTestTag                           | Add       |
      | Enter Text                  | Category Name             | AutoTestSubTag1                       |           |
      | Click                       | Edit category Save Button |                                       |           |
      | Click                       | Category Menu buttons     | AutoTestTag                           | Add       |
      | Enter Text                  | Category Name             | AutoTestSubTag2                       |           |
      | Click                       | Edit category Save Button |                                       |           |
#      | Expand tag hierarchy        | AutoTestTag               |                                       |           |
      | Verify tag presence         | AutoTestTag               | AutoTestSubTag1,AutoTestSubTag2       |           |
      | Click                       | Category Menu buttons     | AutoTestSubTag1                       | Edit      |
      | Enter Text                  | Category Name             | Edited                                |           |
      | Click                       | Edit category Save Button |                                       |           |
      | Verify tag presence         | AutoTestTag               | AutoTestSubTag1Edited,AutoTestSubTag2 |           |
      | Click Category Menu buttons | AutoTestTag               | AutoTestSubTag1Edited                 | Delete    |
    And user "click" on "Confirm" button in "Manage Tags Page"
    And User performs following actions in the Manage Tags Page
      | Actiontype         | ActionItem  | ItemName              | Attribute |
      | Verify tag absence | AutoTestTag | AutoTestSubTag1Edited |           |

  ##7266869##7249008
  @MLP-30676 @webtest @regression @positive @e2e
  Scenario: SC#4:30676: Verify user able to create, edit and delete PII tags
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add PII Category" button in "Manage Tags page"
    And User performs following actions in the Manage Tags Page
      | Actiontype          | ActionItem                | ItemName   | Attribute |
      | Enter Text          | Category Name             | PIITestTag |           |
      | Click               | Edit category Save Button |            |           |
      | Verify tag presence | PII                       | PIITestTag |           |
    And User performs following actions in the Manage Tags Page
      | Actiontype                  | ActionItem                | ItemName                            | Attribute |
      | Click                       | Category Menu buttons     | PIITestTag                          | Add       |
      | Enter Text                  | Category Name             | PIITestSubTag1                      |           |
      | Click                       | Edit category Save Button |                                     |           |
      | Click                       | Category Menu buttons     | PIITestTag                          | Add       |
      | Enter Text                  | Category Name             | PIITestSubTag2                      |           |
      | Click                       | Edit category Save Button |                                     |           |
      | Verify tag presence         | PIITestTag                | PIITestSubTag1,PIITestSubTag2       |           |
      | Click                       | Category Menu buttons     | PIITestSubTag1                      | Edit      |
      | Enter Text                  | Category Name             | Edited                              |           |
      | Click                       | Edit category Save Button |                                     |           |
      | Verify tag presence         | PIITestTag                | PIITestSubTag1Edited,PIITestSubTag2 |           |
      | Click Category Menu buttons | PIITestTag                | PIITestSubTag1Edited                | Delete    |
    And user "click" on "Confirm" button in "Manage Tags Page"
    And User performs following actions in the Manage Tags Page
      | Actiontype         | ActionItem | ItemName             | Attribute |
      | Verify tag absence | PIITestTag | PIITestSubTag1Edited |           |

      ##7249005##7246807
  @MLP-30676 @webtest @regression @positive @e2e
  Scenario: SC#5:30676: Verify if BA Items created are displayed as tags and it can be seen in Business Application tag hierarchy
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name      | type                | query | param |
      | SingleItemDelete | Default | SampleBA1 | BusinessApplication |       |       |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option        |
      | BusinessApplication | SampleBA1 | Save and Open |
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype           | ActionItem          | ItemName  |
      | Expand tag hierarchy | BusinessApplication |           |
      | Verify tag presence  | BusinessApplication | SampleBA1 |


  ##7261364##MLPQA-3285##7261363##MLPQA-3286##7261362##MLPQA-3287####7261361##MLPQA-3288##
  @MLP-29540 @webtest @regression @positive
  Scenario:MLP-29540:SC#1_Create a tag Icon Search filter
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user "click" on "TagIcon" button in "Manage Tags page"
    And user "click" on "TagIconSearch" button in "Manage Tags page"
    And User performs following actions in the Manage Tags Page
      | Actiontype              | ActionItem               | ItemName | Attribute |
      | Click                   | Tag Icon                 |          |           |
      | Click                   | Tag Icon Search          |          |           |
      | Enter Text              | Tag Icon Search Text box | wifi     |           |
      | Verify Tag icon Results | wifi                     |          |           |
      | Click                   | Tag Icon Search close    |          |           |
      | Click                   | Tag Icon Search          |          |           |
      | Enter Text              | Tag Icon Search Text box | help     |           |

     ##MLPQA-17991##MLPQA-17992##MLPQA-17993##MLPQA-17994##MLPQA-17995##MLPQA-17996##
  @MLP-30679 @webtest @regression @positive
  Scenario: SC#1:30679: Verify new palette features
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem   | ItemName | Attribute |
      | Enter Text | Category Name | ColorTag |           |
      | Click      | Tag Icon      |          |           |
    And user press "PAGE_DOWN" key using key press event
    And User performs following actions in the Manage Tags Page
      | Actiontype   | ActionItem    | ItemName |
      | Select Color | color-slider  | 50,250   |
      | Select Color | color-palette | 125,125  |
    And user verifies the background color of the page
      | StyleType        | ColorCode             | Page       |
      | background-color | rgba(63, 127, 124, 1) | Color Icon |
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem             | ItemName | Attribute |
      | Click      | Add Category Ok button |          |           |
    And user verifies the background color of the page
      | StyleType | ColorCode             | Page     |
      | color     | rgba(63, 127, 124, 1) | Tag Icon |
    And user "click" on "Add Category Save" button in "Edit Category"
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | ColorTag |
    And user verifies the background color of the page
      | StyleType | ColorCode             | Page     |
      | color     | rgba(63, 127, 124, 1) | ColorTag |

    ##MLPQA-3128##7268390##MLPQA-17997##
  @MLP-30679 @MLP-30680 @webtest @regression @positive
  Scenario: SC#2:30679 30680: Verify saving the tag using tab order
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user press "TAB" key using key press event
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem    | ItemName | Attribute |
      | Enter Text | Category Name | KeyTag   |           |
    And user press "TAB" key using key press event
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem    | ItemName | Attribute |
      | Enter Text | Tag Definition | KeyTag Definition  |           |
    And user press "TAB" key using key press event
    And user press "ENTER" key using key press event
    And user press "TAB" key using key press event
    And user press "ENTER" key using key press event
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem               | ItemName | Attribute |
      | Enter Text | Tag Icon Search Text box | wifi   |           |
    And user press "TAB" key using key press event
    And user press "TAB" key using key press event
    And user press "ENTER" key using key press event
    And user press "TAB" key using key press event
    And user press "ENTER" key using key press event
    And user press "TAB" key using key press event
    And user press "ENTER" key using key press event

  @MLP-30679
  Scenario:Delete the tag Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name     | type | query | param |
      | SingleItemDelete | Default | KeyTag   | Tag  |       |       |
      | SingleItemDelete | Default | ColorTag | Tag  |       |       |

  ##MLPQA-3270##7261393##MLPQA-3271##7261388##MLPQA-3172##7261387##MLPQA-3173##7261386##
  @MLP-MLP-30674 @webtest @regression @positive
  Scenario: SC#1:MLP-30674: Verify helper section in Manage tags page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Helper" button in "Manage Tags page"
    And user "Verifies displayed" on "Helper Layout" button in "Manage Tags page"
    And user "click" on "Close button" button in "Manage Tags page"
    And user "Verifies not displayed" on "Helper Layout" button in "Manage Tags page"

    ##MLPQA-3268##7261395##MLPQA-3269##7261394##
  @MLP-30674 @webtest @regression @positive
  Scenario: SC#2:MLP-30674: Verify Documentaion link in  Manage tags page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Helper" button in "Manage Tags page"
    And user "click" on "Data Discovery Documentation" button in "Manage Tags page"

    ##MLPQA-2130##7268388##
  @MLP-30680 @webtest @regression @positive
  Scenario: SC#1:MLP-30680: Verify contextual message in  Manage tags page
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user "verifies presence" of following "Contextual Message" in "Add Category" page
      | Enter details to a tag hierarchy. |
      | Add Tag Hierarchy                 |

  Scenario:Delete the SampleBA1 Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name      | type                | query | param |
      | SingleItemDelete | Default | SampleBA1 | BusinessApplication |       |       |
