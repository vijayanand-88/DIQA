@MLP_18355 @25436
Feature: MLP_18355_To create new tag, Assign unassign tags in popup

   ##6957921##6957939##6957940##6957941##6957948##6957964##
  @MLP-18355 @webtest @regression @positive
  Scenario:MLP-18355:SC#1_Verify the contextual message for Assign a Tag page.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute  | option        |
      | BusinessApplication | Test_Local | Save and Open |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     |
      | Click      | Add Tag Button |
    And user "verifies presence" of following "Contextual Message" in "Add Category" page
      | Assign a Tag to an item. |
    And user verifies "Assign Button" is "disabled" in "Add Tag Page"
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem                  |
      | Click               | Create a tag Button         |
      | Verify Hint Message | Provide a name for the tag. |
    And user verifies "Save Button" is "disabled" in "Add Tag Page"
    And user "Verify Placeholder" in Create new item page
      | option  | Message              |
      | Textbox | Enter a new tag name |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem    |
      | Enter Text | Test_Add_Tag1 |
    And user "click" on "Save" button in "Create Tag Page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem          |
      | Click      | Create a tag Button |
      | Enter Text | Test_Add_Tag1       |
    And user "Verify the Field Error message" in Create new item page
      | fieldName | Message                                                             |
      | Name      | A tag with this name already exists. Please enter a different name. |
    And user verifies "Save Button" is "disabled" in "Add Tag Page"

    #6957965##6957970##6958019##
  @MLP-18355 @webtest @regression @positive
  Scenario:MLP-18355:SC#2_Verify that the user can search for a tag from Select a tag to assign table.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test_Local" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Test_Local" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem       | ItemName      | Section   |
      | Click                          | Add Tag Button   |               |           |
      | Verify Information Message     | Nothing assigned |               |           |
      | Click                          | Search Icon      |               |           |
      | Enter Text                     | Tag Search box   | Email Address | Available |
      | Verify Tag Presence in Section | Email Address    |               | Available |

  ##6957977- Duplicate

   # 6958020
  @MLP-18355 @webtest @regression @positive
  Scenario:MLP-18355:SC#3_Verify the Cancel button functionality during creation of new tag.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test_Local" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Test_Local" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem          |
      | Click      | Add Tag Button      |
      | Click      | Create a tag Button |
      | Enter Text | Test                |
    And user "click" on "Cancel button" button in "Assign a Tag Page"
    And user "click" on "No" button in "Popup Window"
    And user "click" on "Cancel button" button in "Assign a Tag Page"
    And user "click" on "Yes" button in "Popup Window"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     |
      | Click      | Add Tag Button |

   # 6958172
  @MLP-18355 @webtest @regression @positive
  Scenario:MLP-18355:SC#4_Verfify the Close(x) button functionality during creation of new tag.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test_Local" and clicks on search
    And user performs "item click" on "Test_Local" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem          |
      | Click      | Add Tag Button      |
      | Click      | Create a tag Button |
      | Enter Text | Test                |
    And user "click" on "Close button" button in "Create Item Page"
    And user "click" on "No" button in "Popup Window"
    And user "click" on "Close button" button in "Create Item Page"
    And user "click" on "Yes" button in "Popup Window"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     |
      | Click      | Add Tag Button |

   # 6958285
  @MLP-18355 @webtest @regression @positive
  Scenario:MLP-18355:SC#5_Verify the Cancel button functionality during the tag assign.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test_Local" and clicks on search
    And user performs "item click" on "Test_Local" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem    | Section   |
      | Tag Selection                  | Email Address | Available |
      | Verify Tag Presence in Section | Email Address | Assigned  |
    And user "click" on "Cancel button" button in "Assign a Tag Page"
    And user "click" on "No" button in "Popup Window"
    And user "click" on "Cancel button" button in "Assign a Tag Page"
    And user "click" on "Yes" button in "Popup Window"
    And User performs following actions in the Item view Page
      | Actiontype                 | ActionItem       | ItemName | Section |
      | Click                      | Add Tag Button   |          |         |
      | Verify Information Message | Nothing assigned |          |         |

   # 6958286
  @MLP-18355 @webtest @regression @positive
  Scenario:MLP-18355:SC#6_Verfify the Close(x) button functionality during the tag assign
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test_Local" and clicks on search
    And user performs "item click" on "Test_Local" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     | Section |
      | Click      | Add Tag Button |         |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem    | Section   |
      | Tag Selection                  | Email Address | Available |
      | Verify Tag Presence in Section | Email Address | Assigned  |
    And user "click" on "Close button" button in "Create Item Page"
    And user "click" on "No" button in "Popup Window"
    And user "click" on "Close button" button in "Create Item Page"
    And user "click" on "Yes" button in "Popup Window"
    And User performs following actions in the Item view Page
      | Actiontype                 | ActionItem       | ItemName | Section |
      | Click                      | Add Tag Button   |          |         |
      | Verify Information Message | Nothing assigned |          |         |

   # 6958341 - Duplicate: Refer MLP-25436
   # 6957996 - Duplicate: Refer MLP-25436
   # 6958354 - Duplicate : Refer to MLP-25436:SC#2

  # 6958355##6958366
  @MLP-18355 @webtest @regression @positive
  Scenario:MLP-18355:SC#7_Verify that the user can create a new Tag for a Business Application Item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Test_Local" and clicks on search
    And user performs "item click" on "Test_Local" item from search results
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem          |
      | Click      | Add Tag Button      |
      | Click      | Create a tag Button |
      | Enter Text | Auto_App_Tag        |
    And user "click" on "Save" button in "Create Tag Page"
    And user "click" on "Assign" button in "Create Item Page"
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem   |
      | Verify Tag Presence | Auto_App_Tag |

 # 6958367
  @MLP-18355 @webtest @regression @positive
  Scenario:MLP-18355:SC#8_Verify that the user can UnAssign a Tag for Table Item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem     | Section   |
      | Click                          | Add Tag Button |           |
      | Verify Tag Presence in Section | Auto_App_Tag   | Available |
      | Tag Selection                  | Auto_App_Tag   | Available |
    And user "click" on "Assign" button in "Create Item Page"
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem     |
      | Verify Tag Presence | Auto_App_Tag   |
      | Click               | Add Tag Button |
    And User performs following actions in the "Assign a Business Application" popup
      | Actiontype                        | ActionItem   | Section  |
      | Remove tagged item in the Section | Auto_App_Tag | Assigned |
      | Verify Tag Absence in Section     | Auto_App_Tag | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

    # 6958368
  @MLP-18355 @webtest @regression @positive
  Scenario:MLP-18355:SC#9_Verify that the user can create a new Tag for Table Item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem          |
      | Click      | Add Tag Button      |
      | Click      | Create a tag Button |
      | Enter Text | Auto_App_Tag1       |
    And user "click" on "Save" button in "Create Tag Page"
    And user "click" on "Assign" button in "Create Item Page"
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem    |
      | Verify Tag Presence | Auto_App_Tag1 |

   # 6958387#6958388
  @MLP-18355 @webtest @regression @positive
  Scenario:MLP-18355:SC#10_Verify that the user can ASSIGN an existing Tag for a Column Item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem     | Section   |
      | Click                          | Add Tag Button |           |
      | Verify Tag Presence in Section | Auto_App_Tag   | Available |
      | Tag Selection                  | Auto_App_Tag   | Available |
    And user "click" on "Assign" button in "Create Item Page"
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem     |
      | Verify Tag Presence | Auto_App_Tag   |
      | Click               | Add Tag Button |
    And User performs following actions in the "Assign a Business Application" popup
      | Actiontype                        | ActionItem   | Section  |
      | Remove tagged item in the Section | Auto_App_Tag | Assigned |
      | Verify Tag Absence in Section     | Auto_App_Tag | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"

    # 6958389
  @MLP-18355 @webtest @regression @positive
  Scenario:MLP-18355:SC#11_Verify that the user can create a new Tag for Column Item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem          |
      | Click      | Add Tag Button      |
      | Click      | Create a tag Button |
      | Enter Text | Auto_App_Tag2       |
    And user "click" on "Save" button in "Create Tag Page"
    And user "click" on "Assign" button in "Create Item Page"
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem    |
      | Verify Tag Presence | Auto_App_Tag2 |

  Scenario:Delete the BA Item and Tags
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name          | type                |
      | SingleItemDelete | Default | Test_Local    | BusinessApplication |
      | SingleItemDelete | Default | Test_Add_Tag1 | Tag                 |
      | SingleItemDelete | Default | Auto_App_Tag  | Tag                 |
      | SingleItemDelete | Default | Auto_App_Tag2 | Tag                 |
      | SingleItemDelete | Default | Auto_App_Tag1 | Tag                 |

  @MLP-25436
  Scenario:MLP-25436: Create an table item
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                | body                                       | response code | response message | jsonPath |
      | application/json | raw   | false | Post | items/Default/root | idc/IDxPayloads/MLP_25436_Table_Item1.json | 200           |                  |          |
      |                  |       |       | Post | items/Default/root | idc/IDxPayloads/MLP_25436_Table_Item2.json | 200           |                  |          |
      |                  |       |       | Post | items/Default/root | idc/IDxPayloads/MLP_25436_Table_Item3.json | 200           |                  |          |

  @MLP-25436 @webtest
  Scenario:MLP-25436:Create BusinessApplication Item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | SampleBA1 | Save   |
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | SampleBA2 | Save   |
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | SampleBA3 | Save   |
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | SampleBA4 | Save   |

    ##7157810##7157811##7157812##7157813##7157814##7157815##7157816##7157817##7157818##
  @MLP-25436 @webtest @regression @positive
  Scenario:MLP-25436:SC#1:Verify that the user can create a new Tag for Column Item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user "click" on "Search Results Show more" button in "Search results page"
    And user "verifies presence" of following "Search results show more options" in "Search results" page
      | Save Search                           |
      | Assign/Unassign Tags                  |
      | Assign/Unassign Business Applications |
    And user "verifies presence" of following "Search results disabled show more options" in "Search results" page
      | Assign/Unassign Tags                  |
      | Assign/Unassign Business Applications |
    And user enters the search text "TableSingleTest1" and clicks on search
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Business Applications" in "Search results page"
    And user "Verifies popup" is "displayed" for "Assign a Business Application"
    And user "verifies presence" of following "Contextual Message" in "Assign a Business Application" page
      | Assign a Business Application to an item. |
    And User performs following actions in the "Assign a Business Application" popup
      | Actiontype              | Section            |
      | Verify Section Presence | Available,Assigned |
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                    | Section   |
      | Verify Tag Presence in Section | SampleBA1,SampleBA2,SampleBA3 | Available |
      | Tag Selection                  | SampleBA1                     | Available |
      | Verify Tag Presence in Section | SampleBA1                     | Assigned  |
    And User performs following actions in the "Assign a Business Application" popup
      | Actiontype                     | ActionItem | ItemName | Section  |
      | Verify label presence for Item | SampleBA1  | added    | Assigned |

  ##7157819##7157820##7157821##7157822##7157823##7157826##7165911##
  @MLP-25436 @webtest @regression @positive
  Scenario:MLP-25436:SC#2:Verify user able to see the remove(X) option next to the business application name in the 'Assigned' block and clicking on the remove(X) icon moves the Business Application back to Available list
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "TableSingleTest1" and clicks on search
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem           | ItemName | Section          |
      | Verify Top bar section | Business Application | N/A      | TableSingleTest1 |
    And user enters the search text "TableSingleTest1" and clicks on search
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Business Applications" in "Search results page"
    And user verifies "Assign Button" is "disabled" in "Add Tag Page"
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem | Section   |
      | Tag Selection | SampleBA1  | Available |
    And User performs following actions in the "Assign a Business Application" popup
      | Actiontype                        | ActionItem | Section  |
      | Remove tagged item in the Section | SampleBA1  | Assigned |
    And User performs following actions in the Item view Page
      | Actiontype                    | ActionItem | Section  |
      | Verify Tag Absence in Section | SampleBA1  | Assigned |
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem | Section   |
      | Tag Selection | SampleBA2  | Available |
    And user "click" on "Assign" button in "Assign a Business Application popup"
    And user "Verifies presence" on "Alert text" for "Business Applications have been assigned/unassigned for the selected item(s)" in "Search results Page"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name  | facet         | Tag       | fileName         | userTag |
      | Default     | Table | Metadata Type | SampleBA2 | TableSingleTest1 |         |

  ##7157824##7157825##7157827##7157828##7165823##
  @MLP-25436 @webtest @regression @positive
  Scenario:MLP-25436:SC#3:Verify user able to sort the list in both the Available and Assigned Section
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "TableSingleTest1" and clicks on search
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Business Applications" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype                     | ActionItem                    | Section   |
      | Tag Selection                  | SampleBA1                     | Available |
      | Tag Selection                  | SampleBA3                     | Available |
      | Verify Tag Presence in Section | SampleBA1,SampleBA2,SampleBA3 | Available |
      | Sort Section                   |                               | Available |
    And User performs following actions in the "Assign a Business Application" popup
      | Actiontype                    | ActionItem | ItemName | Section  |
      | Verify label absence for Item | SampleBA2  | added    | Assigned |
    And user "verifies sorting order" of following "Available Section items are in ascending order" in "Assign a BusinessApplication" page
      |  |
    And user "verifies sorting order" of following "Available Section items are in descending order" in "Assign a BusinessApplication" page
      |  |
    And user "click" on "Popup Cancel" button in "Assign a BusinessAppilcation popup"
    And user clicks on "Yes" link in the "Assign a BusinessAppilcation popup"
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem           | ItemName  | Section          |
      | Verify Top bar section | Business Application | SampleBA2 | TableSingleTest1 |

    ##7157829##7157830##7157832##7157833##7165824##
  @MLP-25436 @webtest @regression @positive
  Scenario:MLP-25436:SC#4:Verify when user clicks on the option to assign BA for all the selected items, the popup should display the 'partially assigned' BA label with a checkbox
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "TableSingleTest" and clicks on search
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Business Applications" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem | Section   |
      | Tag Selection | SampleBA1  | Available |
      | Tag Selection | SampleBA3  | Available |
    And User performs following actions in the "Assign a Business Application" popup
      | Actiontype                     | ActionItem | ItemName           | Section  |
      | Verify label presence for Item | SampleBA2  | partially assigned | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name  | facet         | Tag                           | fileName         | userTag |
      | Default     | Table | Metadata Type | SampleBA2,SampleBA1,SampleBA3 | TableSingleTest1 |         |
      | Default     | Table | Metadata Type | SampleBA1,SampleBA3           | TableSingleTest2 |         |
      | Default     | Table | Metadata Type | SampleBA1,SampleBA3           | TableSingleTest3 |         |
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Business Applications" in "Search results page"
    And User performs following actions in the "Assign a Business Application" popup
      | Actiontype      | ActionItem | ItemName           | Section  |
      | Select checkbox | SampleBA2  | partially assigned | Assigned |
    And user "click" on "Assign" button in "Assign a Business Application popup"
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name  | facet         | Tag                           | fileName         | userTag |
      | Default     | Table | Metadata Type | SampleBA2,SampleBA1,SampleBA3 | TableSingleTest2 |         |
      | Default     | Table | Metadata Type | SampleBA2,SampleBA1,SampleBA3 | TableSingleTest3 |         |

  ##7165825##7165826##
  @MLP-25735 @webtest @regression @positive
  Scenario:MLP-25735:SC#5:Verify when data element is tagged with three or less than three BusinessApplication user should able to see the BusinessApplication seprated by comma in the Item View Screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "TableSingleTest1" and clicks on search
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem           | ItemName                      | Section          |
      | Verify Top bar section | Business Application | SampleBA1,SampleBA2,SampleBA3 | TableSingleTest1 |
    And user verifies "Item view page title" is "TableSingleTest" in "Item View" page

  ##7165825##7165826##7165827##7165829##7165830##
  @MLP-25735 @webtest @regression @positive
  Scenario:MLP-25735:SC#6:Verify when data element is tagged with more than three BusinessApplication, user should able to see the count(numeric) of the BusinessApplication as a link in the Item View Screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "TableSingleTest1" and clicks on search
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Business Applications" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem | Section   |
      | Tag Selection | SampleBA4  | Available |
    And user "click" on "Assign" button in "Assign a Business Application popup"
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem           | ItemName | Section          |
      | Verify Top bar section | Business Application | 4        | TableSingleTest1 |
      | Click Top bar section  | Business Application | 4        | TableSingleTest1 |
    And user "verify presence" of following "BA List in Top Section bar" in Item Search Results Page
      | SampleBA1 |
      | SampleBA2 |
      | SampleBA3 |
      | SampleBA4 |

  Scenario:Delete the created Items
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name             | type                | query | param |
      | SingleItemDelete | Default | SampleBA1        | BusinessApplication |       |       |
      | SingleItemDelete | Default | SampleBA2        | BusinessApplication |       |       |
      | SingleItemDelete | Default | SampleBA3        | BusinessApplication |       |       |
      | SingleItemDelete | Default | SampleBA4        | BusinessApplication |       |       |
      | SingleItemDelete | Default | TableSingleTest1 | Table               |       |       |
      | SingleItemDelete | Default | TableSingleTest2 | Table               |       |       |
      | SingleItemDelete | Default | TableSingleTest3 | Table               |       |       |
      | SingleItemDelete | Default | SampleBA1        | Tag                 |       |       |
      | SingleItemDelete | Default | SampleBA2        | Tag                 |       |       |
      | SingleItemDelete | Default | SampleBA3        | Tag                 |       |       |
      | SingleItemDelete | Default | SampleBA4        | Tag                 |       |       |

    ##MLPQA-17977##MLPQA-17978##MLPQA-17979##MLPQA-17982##MLPQA-17983##
  @MLP-30682 @webtest @regression @positive
  Scenario:MLP-30682:SC#1:Verify the user is able to assign PII tags and verify the sections
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user "selects" for the following filter in search results page
      | FilterType    | FilterValues |
      | MetaData Type | Table        |
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Set/Reset Item as PII Relevant" in "Search results page"
    And User performs following actions in the "Set/Reset Item as PII Relevant" popup
      | Actiontype              | Section            |
      | Verify Section Presence | Available,Assigned |
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem | Section   |
      | Tag Selection | Wage       | Available |
      | Tag Selection | Salary     | Available |
    And User performs following actions in the "Set/Reset Item as PII Relevant" popup
      | Actiontype                    | ActionItem | ItemName | Section  |
      | Verify label presence for Item | Wage       | added    | Assigned |
    And user "click" on "Assign" button in "Set/Reset Item as PII Relevant popup"
    And user clicks on search icon
    And user "selects" for the following filter in search results page
      | FilterType | FilterValues |
      | PII        | Salary       |
    And user "verifies the selected facets" for the following filter in search results page
      | actionType             | FilterType | FilterValues |
      | Verify facet selection | PII        | Salary       |


    ##MLPQA-17980##MLPQA-17982##
  @MLP-30682 @webtest @regression @positive
  Scenario:MLP-30682:SC#2:Verify the user is able to partially assign PII tags and assign and verify the text
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user "selects" for the following filter in search results page
      | FilterType    | FilterValues |
      | MetaData Type | Table        |
      | MetaData Type | File        |
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Set/Reset Item as PII Relevant" in "Search results page"
    And User performs following actions in the "Set/Reset Item as PII Relevant" popup
      | Actiontype                    | ActionItem | ItemName | Section  |
      | Verify label presence for Item | Wage       |  "partially assigned"     | Assigned |
      | Verify label presence for Item | Salary       |  "partially assigned"     | Assigned |
    And User performs following actions in the "Assign a Business Application" popup
      | Actiontype      | ActionItem | ItemName           | Section  |
      | Select checkbox | Wage  | partially assigned | Assigned |
    And user "click" on "Assign" button in "Set/Reset Item as PII Relevant popup"
    And user "selects" for the following filter in search results page
      | FilterType | FilterValues |
      | PII        | Wage       |
    And user "verifies the selected facets" for the following filter in search results page
      | actionType             | FilterType | FilterValues |
      | Verify facet selection | PII        | Wage       |
