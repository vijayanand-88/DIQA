@22098@21981@21681@21983
Feature:MLP_22098_Rename of OOTB Tags - Make default

  @MLP-22098 @webtest @regression @positive
  Scenario:SC#1_Create BusinessApplication
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute     | option |
      | BusinessApplication | BA_ManageTags | Save   |

# 7066328# 7066329
  @MLP-22098 @webtest @regression @positive
  Scenario:MLP-22098:SC#2_Verify if Manage Tags screens displays these 4 Root Tag categories 'BusinessApplication', 'Technology', 'PII', 'General'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | BusinessApplication |
      | Technology          |
      | PII                 |
    And user "verifies displayed" on "Tag Categories" for "Manage Tags" in "Landing page"

     # 7066330# 7066331
  @MLP-22098 @webtest @regression @positive
  Scenario:MLP-22098:SC#3_Verify if in "Edit Category" screen of "General" root tag, check if Default checkbox is chekmarked and its disabled
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName | Attribute |
      | Click      | Category Menu buttons | General  | Edit      |
    And user "disabled" on "Default Checkbox" for "Manage Tags" in "Landing page"

# 7064567
  @MLP-22098 @webtest @regression @positive
  Scenario:MLP-22098:SC#4_Verify if Assign a Tag screen - clicking 'Create a Tag' displays the tag creation form with displaying Default tag 'General' pre-selected in drop down
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_ManageTags" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype              | ActionItem          |
      | Click                   | Add Tag Button      |
      | Click                   | Create a tag Button |
      | Verify Default Category | General             |

  @MLP-21981 @regression @positive
  Scenario Outline: SC#5_Create TagX
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                     | body                             | response code | response message | filePath | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Put  | tags/Default/structures | payloads\idc\MLP_22098\TagX.json | 200           |                  |          |          |

# 7066332
  @MLP-22098 @webtest @regression @positive
  Scenario:MLP-22098:SC#6_ Create a new Root Category Tag "Tag X" and mark it as "Default"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName | Attribute |
      | Click      | Category Menu buttons | TagX     | Edit      |
    And user "click" on "DefaultCheckbox" for "Manage Tags" in "Landing page"
    And user "click" on "Save" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype                     | ActionItem | ItemName | Attribute |
      | Verifies Category Menu buttons | General    | Add,Edit |           |

    # 7066334
  @MLP-22098 @webtest @regression @positive
  Scenario:MLP-22098:SC#7_Verify if Assign a Tag screen - clicking 'Create a Tag' displays the tag creation form with displaying Default tag 'Tag X' pre-selected in drop down
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_ManageTags" and clicks on search
    And user refreshes the application
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "TagAssign" button in "Create Item Page"
    And User performs following actions in the Item view Page
      | Actiontype              | ActionItem          |
      | Click                   | Add Tag Button      |
      | Click                   | Create a tag Button |
      | Verify Default Category | TagX                |

    # 7067706
  @MLP-22098 @webtest @regression @positive
  Scenario:MLP-22098:SC#8_Verify if the root category tag which is marked as 'Default' cannot be deleted and has the Delete button disabled
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype                            | ActionItem | ItemName | Attribute                          |
      | Verify Delete is disabled for Default |            | Tag X    | Default category cannot be deleted |

    # 7066333
  @MLP-22098 @webtest @regression @positive
  Scenario:MLP-22098:SC#9_Verify if in "Edit Category" screen of "General" root tag, check if Default checkbox is not chekmarked and its enabled
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName | Attribute |
      | Click      | Category Menu buttons | General  | Edit      |
    And user "enabled" on "Default Checkbox Enabled and not selected" for "Manage Tags" in "Landing page"

    # 7064236
  @MLP-21981 @webtest @regression @positive
  Scenario:MLP-21981:SC#10_Verify if the Add Category screen has the checkbox to select the Tag as 'Protected'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    Then user "verifies displayed" on "ProtectedTagCheckBox" for "Manage Tags" in "Landing page"

# 7064248
  @MLP-21981 @webtest @regression @positive
  Scenario:MLP-21981:SC#11_Verify if the saved Root Category tag is displayed with a Lock symbol in Manage Tags screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user creates a tag with the following parameters
      | CategoryName | Definition             | Icon                 | colorWidthHeight | Protected |
      | TAGB         | Created for Automation | fa fa-address-book-o |                  | true      |
    Then user "verifies protected lock icon" of following "Tags" in "Manage Tags" Page
      | TAGB |

    # 7064249
  @MLP-21981 @webtest @regression @positive
  Scenario:MLP-21981:SC#12_Verify if Add and Edit buttons are displayed for the Custom Tags
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName | Attribute |
      | Click      | Category Menu buttons | General  | Edit      |
    And user "click" on "DefaultCheckbox" for "Manage Tags" in "Landing page"
    And user "click" on "Save" for "Manage Tags" in "Landing page"


  @MLP-21981 @regression @positive
  Scenario:MLP-21981:SC#13 Delete Tagx
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name | type | query | param |
      | SingleItemDelete | Default | TagX | Tag  |       |       |


  # 7064250# 7064251# 7064252
  @MLP-21981 @webtest @regression @positive
  Scenario:MLP-21981:SC#14_Verify if clicking on the Lock symbol on a Root Tag displays the pop up 'Protected Category'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName | Attribute |
      | Click      | Category Menu buttons | TAGB     | Protected |
    And user "verifies displayed" on "ProtectedTagPopup" button in "ProtectedTag"
    And user "click" on "Yes" button in "Unsaved changes pop up"
    Then User performs following actions in the Manage Tags Page
      | Actiontype                     | ActionItem | ItemName        | Attribute |
      | Verifies Category Menu buttons | TAGB       | Add,Edit,Delete |           |

    # 7064253
  @MLP-21981 @webtest @regression @positive
  Scenario:MLP-21981:SC#15_Verify if user can edit the root tag details and its reflected in Manage Tags screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype                     | ActionItem            | ItemName        | Attribute |
      | Verifies Category Menu buttons | TAGB                  | Add,Edit,Delete |           |
      | Click                          | Category Menu buttons | TAGB            | Edit      |
      | Enter Text                     | Category Name         | TEST            |           |
    And user "click" on "Save" for "Manage Tags" in "Landing page"
#      | Click                          | Edit category Save Button |                 |           |
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | TAGBTEST |

    # 7064254
  @MLP-21981 @webtest @regression @positive
  Scenario:MLP-21981:SC#16_Verify if user can Add a Sub tag to the root tag and it is displayed as a child to the root tag
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName  | Attribute |
      | Click      | Category Menu buttons | TAGBTEST  | Add       |
      | Enter Text | Category Name         | TAGBTEST1 |           |
    And user "click" on "Save" for "Manage Tags" in "Landing page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Tags |
    And user "click" on "Expand/Collapse Tag Button" for "TAGBTEST" in "Manage Tags"
    Then user "verifies Tree Sructure of Tags" of following "TAGBTEST" in "Manage Tags" Page
      | TAGBTEST1 |

     # 7064255
  @MLP-21981 @webtest @regression @positive
  Scenario:MLP-21981:SC#17_Verify if use can map an item with the created or edited tag from 'Assign a Tag' screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_ManageTags" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     |
      | Click      | Add Tag Button |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem  |
      | Click      | Search Icon |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Search     | TAGBTEST1  |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem   | Section   |
      | Click      | Select a Tag | TAGBTEST1 |
    And user "click" on "Assign" button in "Create Item Page"
    And user enters the search text "" and clicks on search
    Then user verifies "TAGBTEST1" Tag present under "TAGBTEST" Tag

    # 7064256
  @MLP-21981 @webtest @regression @positive
  Scenario:MLP-21981:SC#18_Verify if the Parent Tag is marked as Protected, its sub tags should also be displayed with lock symbol
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName | Attribute |
      | Click      | Category Menu buttons | TAGBTEST | Edit      |
    And user "click" on "ProtectedCheckBox" for "Manage Tags" in "Landing page"
    And user "click" on "Save" for "Manage Tags" in "Landing page"
    Then User performs following actions in the Manage Tags Page
      | Actiontype                     | ActionItem | ItemName  | Attribute |
      | Verifies Category Menu buttons | TAGBTEST   | Protected |           |
    And user "click" on "Expand/Collapse Tag Button" for "TAGBTEST" in "Manage Tags"
    Then user "verifies Tree Sructure of Tags" of following "TAGBTEST" in "Manage Tags" Page
      | TAGBTEST1 |
    Then User performs following actions in the Manage Tags Page
      | Actiontype                     | ActionItem | ItemName  | Attribute |
      | Verifies Category Menu buttons | TAGBTEST1  | Protected |           |

    # 7064257
  @MLP-21981 @webtest @regression @positive
  Scenario:MLP-21981:SC#19_Verify if the Parent Tag is not marked as Protected, its sub tags should not be displayed with lock symbol
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName | Attribute |
      | Click      | Category Menu buttons | TAGBTEST | Protected |
    And user "verifies displayed" on "ProtectedTagPopup" button in "ProtectedTag"
    And user "click" on "Yes" button in "Unsaved changes pop up"
    Then User performs following actions in the Manage Tags Page
      | Actiontype                     | ActionItem | ItemName        | Attribute |
      | Verifies Category Menu buttons | TAGBTEST   | Add,Edit,Delete |           |
    And user "click" on "Expand/Collapse Tag Button" for "TAGBTEST" in "Manage Tags"
    Then user "verifies Tree Sructure of Tags" of following "TAGBTEST" in "Manage Tags" Page
      | TAGBTEST1 |

  @MLP-21981 @regression @positive
  Scenario:MLP-21981:SC#20 Delete TAGBTEST
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name      | type | query | param |
      | SingleItemDelete | Default | TAGBTEST  | Tag  |       |       |
      | SingleItemDelete | Default | TAGBTEST1 | Tag  |       |       |

    # 7066302# 7066303# 7066306# 7066307
  @MLP-21681 @webtest @regression @positive
  Scenario:MLP-21681:SC#21_Verify if the Add Category displays the icon button next to 'Definition' label
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user "verifies displayed" on "DefinitionIcon" button in "Add Category"
    And user creates a tag with the following parameters
      | CategoryName | Definition             | Icon                 | colorWidthHeight | Protected |
      | TAGTESTA     | Created for Automation | fa fa-address-book-o |                  | false     |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Tags |
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | TAGTESTA |
    And User performs following actions in the Manage Tags Page
      | Actiontype              | ActionItem | ItemName             |
      | Verifies Tag Icon       | TAGTESTA   | fa fa-address-book-o |
      | Verifies Tag Icon Color | TAGTESTA   |                      |

    # 7066304
  @MLP-21681 @webtest @regression @positive
  Scenario:MLP-21681:SC#22_Verify if the Root Category Tag is displayed with the selected icon in Managed Tags screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user "verifies presence" of following "Tags" in "Manage Tags" page
      | TAGTESTA |

     # 7066305
  @MLP-21681 @webtest @regression @positive
  Scenario:MLP-21681:SC#23_Verify if the Add Category displays the 'Select Color' text box and it is not editable
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user "disabled" on "SelectColor" button in "Manage Tags page"

    # 7066307 # 7066308# 7066310 # 7066312
  @MLP-21681 @webtest @regression @positive
  Scenario:MLP-21681:SC#24_ Verify if after editing the Category root tag icon and color, check if the already assigned tag has latest icon and color
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName | Attribute |
      | Click      | Category Menu buttons | TAGTESTA | Edit      |
    And user Edit a Tag with following Parameter
      | actionType | Definition | Icon | colorWidthHeight | Protected | colorWidthHeightslider | editIcon | Tempsavecolor |
      | Color      |            |      | 40,-50           |           | 0,40                   |          | true          |
    And User performs following actions in the Manage Tags Page
      | Actiontype                         | ActionItem                | ItemName | Attribute |
      | Click                              | Edit category Save Button |          |           |
      | Verifies Tag Icon Color after edit | TAGTESTA                  |          |           |


    # 7066309
  @MLP-21681 @webtest @regression @positive
  Scenario:MLP-21681:SC#25_ Verify if in 'Edit Category' Change the icon and color and clicking Close, retains the old icon and color
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype                         | ActionItem            | ItemName | Attribute |
      | capture Tag icon color before edit | TAGTESTA              |          |           |
      | Click                              | Category Menu buttons | TAGTESTA | Edit      |
    And user Edit a Tag with following Parameter
      | actionType | Definition | Icon                 | colorWidthHeight | Protected | colorWidthHeightslider | editIcon             | Tempsavecolor |
      | Icon       |            | fa fa-address-card-o |                  |           |                        | fa fa-address-book-o |               |
      | Color      |            |                      | 41,-50           |           | 0,41                   |                      | false         |
    And user "click" on "ManageTagSCancel" button in "ManageTags Edit Cateory"
    And user "click" on "Yes" button in "Unsaved changes pop up"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Tags |
    And User performs following actions in the Manage Tags Page
      | Actiontype                         | ActionItem | ItemName |
      | Verifies Tag Icon Color after edit | TAGTESTA   |          |
    And User performs following actions in the Manage Tags Page
      | Actiontype        | ActionItem | ItemName             |
      | Verifies Tag Icon | TAGTESTA   | fa fa-address-book-o |

# 7064564
  @MLP-21983 @webtest @regression @positive
  Scenario:MLP-21983:SC#26_Verify if Create a Tag displays 'Name and Definition' fields
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user "verifies displayed" on "Add Category" button in "Manage Tags page"
    And User performs following actions in the Manage Tags Page
      | Actiontype           | ActionItem    | ItemName |
      | Verifies Tags labels | Category Name |          |
      | Verifies Tags labels | Definition    |          |

     # 7064580
  @MLP-21983 @webtest @regression @positive
  Scenario:MLP-21983:SC#27_Verify if Manage Tags screen displays the newly created sub tag below the 'General' root tag
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName | Attribute |
      | Click      | Category Menu buttons | General  | Add       |
      | Enter Text | Category Name         | TagAB    |           |
    And user "click" on "Save" for "Manage Tags" in "Landing page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Tags |
    And user "click" on "Expand/Collapse Tag Button" for "General" in "Manage Tags"
    Then user "verifies Tree Sructure of Tags" of following "General" in "Manage Tags" Page
      | TagAB |

  @MLP-21981 @regression @positive
  Scenario:MLP-21981:SC#28 Delete TagAB
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name  | type | query | param |
      | SingleItemDelete | Default | TagAB | Tag  |       |       |


  @MLP-21981 @regression @positive
  Scenario Outline: SC#29_Create GerealOne
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url                     | body                                  | response code | response message | filePath | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Put  | tags/Default/structures | payloads\idc\MLP_22098\GerealOne.json | 200           |                  |          |          |


  @MLP-21983 @webtest @regression @positive
  Scenario:MLP-21983:SC#30_Verify if user can create a Category Root Tag "General One" and set it as default. Save the Category Tag changes
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName   | Attribute |
      | Click      | Category Menu buttons | GeneralOne | Edit      |
    And user "click" on "DefaultCheckbox" for "Manage Tags" in "Landing page"
    And user "click" on "Save" for "Manage Tags" in "Landing page"

    # 7064589
  @MLP-21983 @webtest @regression @positive
  Scenario:MLP-21983:SC#31_Verify if Assign a Tag screen - clicking 'Create a Tag' displays the tag creation form with displaying Default tag 'General' pre-selected in drop down
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_ManageTags" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "TagAssign" button in "Create Item Page"
    And User performs following actions in the Item view Page
      | Actiontype              | ActionItem          |
      | Click                   | Add Tag Button      |
      | Click                   | Create a tag Button |
      | Verify Default Category | GeneralOne          |


  @MLP-21983 @webtest @regression @positive
  Scenario:MLP-21983:SC#32_Revert General Tag Default
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem            | ItemName | Attribute |
      | Click      | Category Menu buttons | General  | Edit      |
    And user "click" on "DefaultCheckbox" for "Manage Tags" in "Landing page"
    And user "click" on "Save" for "Manage Tags" in "Landing page"
    And user "verifies displayed" on "Tag Categories" for "Manage Tags" in "Landing page"
    And user "verifies protected lock icon" of following "Tags" in "Manage Tags" Page
      | BusinessApplication |
      | Technology          |


  Scenario:Delete the BA Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name          | type                | query | param |
      | SingleItemDelete | Default | BA_ManageTags | BusinessApplication |       |       |
      | SingleItemDelete | Default | TAGTESTA      | Tag                 |       |       |
      | SingleItemDelete | Default | GeneralOne    | Tag                 |       |       |