Feature: MLP_17931_24162_24163_24849_Capture_Integrity_Create Item
#  MLP-17931-This feature is to verify whetherAs an IDA Admin I want an option to on-board an Item so that I can on-board any business application with its corresponding name
#  MLP-24162-To enhance the Create Business Application UI Layout with a feature to add responsible owners
#  MLP-24163-To render the responsible owners for ItemType,BusinessApplication and to save the selected owners along with the Business Application
#  MLP-24849-As a user, i need an option to create an another item once i click on the Save button

    ##7108493##7108494##7108499##7108500##7108501##
  @MLP-23675 @webtest @regression @positive
  Scenario:SC#1: MLP-23675: Verify the discard popup works as expected in create item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Verifies popup" is "displayed" for "Create"
    And user clicks on "Escape" key
    And user "Verifies popup" is "not displayed" for "Unsaved changes"
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user clicks on "Escape" key
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Create popup"
    And user "click" on "Popup Cancel" button in "Create popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Create popup"
    And user "click" on "Popup Close" button in "Create popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"

# 6937051# 6937052 #6937054 #6937055 #6937074
  @MLP-17931 @webtest @regression @positive
  Scenario:MLP-17931:SC#1_Verify that Create menu is displayed in the left panel.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "verifies displayed" on "Sidebar Link" for "Create" in "Landing page"
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Verify contextual message" in Create new item page
      | Message            |
      | Create a new item. |
    And user "Verify Placeholder" in Create new item page
      | option   | Message          |
      | Dropdown | Select item type |
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option |
      | BusinessApplication | Item_1    | Save   |
    And user enters the search text "Item_1" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Item_1" item from search results

  # 6937076 # 6937078 #6937079 #6937081
  @MLP-17931 @webtest @regression @positive
  Scenario:MLP-17931:SC#6_Verify that the user can create an Item of type Business Application using SAVE AND OPEN.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user verifies "Save and Open Button" is "disabled" in "Add Configuration pop up"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name |           |
    And user verifies "Save Button" is "disabled" in "Add Configuration pop up"
    And user verifies "Save and Open Button" is "disabled" in "Add Configuration pop up"
    And user "Create Item" in Create new item page
      | fieldName           | attribute | option        |
      | BusinessApplication | Item_1    | Save and Open |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_3    |
    And user "click" on "Cancel button" button in "Create Item Page"
    And user "click" on "No" button in "Popup Window"
    And user "click" on "Cancel button" button in "Create Item Page"
    And user "click" on "Yes" button in "Popup Window"


   # 6937086 #6943618
  @MLP-17931 @webtest @regression @positive
  Scenario:MLP-17931:SC#10_Verfiy the Close (x) button functionality on the Create pop over screen.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_3    |
    And user "click" on "Close button" button in "Create Item Page"
    And user "click" on "No" button in "Popup Window"
    And user "click" on "Close button" button in "Create Item Page"
    And user "click" on "Yes" button in "Popup Window"
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "Verify Placeholder" in Create new item page
      | option  | Message         |
      | Textbox | Enter item name |

    # 6943628 #6944167 #6944332
  @MLP-17931 @webtest @regression @positive
  Scenario:MLP-17931:SC#12_Verification of creating an item with duplicate name.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_3    |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Test/     |
    And user "Verify the Field Error message" in Create new item page
      | fieldName | Message                   |
      | Item Name | characters are forbidden. |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | \Test     |
    And user "Verify the Field Error message" in Create new item page
      | fieldName | Message                   |
      | Item Name | characters are forbidden. |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | \n Test   |
    And user "Verify the Field Error message" in Create new item page
      | fieldName | Message                   |
      | Item Name | characters are forbidden. |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Test \n   |
    And user "Verify the Field Error message" in Create new item page
      | fieldName | Message                   |
      | Item Name | characters are forbidden. |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_3    |
    And user "Verify the Field Error message" in Create new item page
      | fieldName | Message                                                            |
      | Item Name | Item with this name already exists. Please enter a different name. |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name   | type                | query | param |
      | SingleItemDelete | Default | Item_1 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_2 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_3 | BusinessApplication |       |       |

 #QACID-7112980,7112982,7112984,7112990,7113910,7113911,7113912,7113913,7113914,7113916,7112992,7112993,7112994
  @MLP-24162 @MLP-24163 @webtest @regression @positive
  Scenario:MLP-24162:SC#15 Verify user able to add LDAP users to Business owner and save the item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_01   |
    And user "enter owner" in Create new item page
      | fieldName          | attribute       |
      | Business Owner     | Test Data Admin |
      | Technology Owner   | Test Data Admin |
      | Relationship Owner | Test Data Admin |
      | Security Owner     | Test Data Admin |
      | Compliance Owner   | Test Data Admin |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user enters the search text "Item_01" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Item_01" item from search results

  #QACID-7112980,7112982,7112984,7112995,7113910,7113917 #Duplicate to above case
#  @MLP-24162 @MLP-24163 @webtest @regression @positive
#  Scenario:MLP-24162:SC#20 Verify user able to add LDAP users in owner section and save the item.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Sidebar Link" for "Create" in "Landing page"
#    And user "select dropdown" in Create new item page
#      | fieldName | attribute           |
#      | Item Type | BusinessApplication |
#    And user "enter text" in Create new item page
#      | fieldName | attribute |
#      | Item Name | Item_06   |
#    And user "enter owner" in Create new item page
#      | fieldName          | attribute                                 |
#      | Business Owner     | Test Data Admin                           |
#      | Technology Owner   | Test Guest User,Test System Administrator |
#      | Relationship Owner | Test Data Admin                           |
#      | Security Owner     | Test Data Admin                           |
#      | Compliance Owner   | Test Data Admin                           |
#    And user "click" on "Save" button in "Create Item Page"
#    And user enters the search text "Item_06" and clicks on search
#    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
#    And user performs "item click" on "Item_06" item from search results

  #QACID-7123395,7123405,7113910,7113917
  @MLP-24162 @MLP-24163 @webtest @regression @positive
  Scenario:MLP-24162:SC#21 Verify user able to delete the selected LDAP users in owner section and save the item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_07   |
    And user "enter owner" in Create new item page
      | fieldName          | attribute                                 |
      | Business Owner     | Test Data Admin                           |
      | Technology Owner   | Test Guest User,Test System Administrator |
      | Relationship Owner | Test Data Admin                           |
      | Security Owner     | Test Data Admin                           |
      | Compliance Owner   | Test Data Admin                           |
    And user "delete owner" in Create new item page
      | fieldName          | attribute                                 |
      | Business Owner     | Test Data Admin                           |
      | Technology Owner   | Test Guest User,Test System Administrator |
      | Relationship Owner | Test Data Admin                           |
      | Security Owner     | Test Data Admin                           |
      | Compliance Owner   | Test Data Admin                           |
    And user "click" on "Save and Open" button in "Create Item Page"

  #QACID-7123395,7123405,7113910,7113917
  @MLP-24162 @MLP-24163 @webtest @regression @positive
  Scenario:MLP-24162:SC#22 Verify user able to delete multiple LDAP users in owner section.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_07   |
    And user "enter owner" in Create new item page
      | fieldName          | attribute                                                 |
      | Business Owner     | Test Data Admin,Test Guest User,Test System Administrator |
      | Technology Owner   | Test Guest User,Test System Administrator,Test Data Admin |
      | Relationship Owner | Test Data Admin,Test Guest User,Test System Administrator |
      | Security Owner     | Test Data Admin,Test Guest User,Test System Administrator |
      | Compliance Owner   | Test Data Admin,Test Guest User,Test System Administrator |
    And user "delete owner" in Create new item page
      | fieldName          | attribute                                                 |
      | Business Owner     | Test Data Admin,Test Guest User,Test System Administrator |
      | Technology Owner   | Test Guest User,Test System Administrator,Test Data Admin |
      | Relationship Owner | Test Data Admin,Test Guest User,Test System Administrator |
      | Security Owner     | Test Data Admin,Test Guest User,Test System Administrator |
      | Compliance Owner   | Test Data Admin,Test Guest User,Test System Administrator |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name    | type                | query | param |
      | SingleItemDelete | Default | Item_01 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_02 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_03 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_04 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_05 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_06 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_07 | BusinessApplication |       |       |

  #QACID-7123395,7123405,7113910,7113911,7113919
  @MLP-24162 @MLP-24163 @webtest @regression @positive
  Scenario:MLP-24162:SC#24 Verify user able to add LDAP users to Business owner field and able to click on save and open the item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_01   |
    And user "enter owner" in Create new item page
      | fieldName      | attribute       |
      | Business Owner | Test Data Admin |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Item_01 |

  #QACID-7123395,7123405,7113910,7113912,7113919
  @MLP-24162 @MLP-24163 @webtest @regression @positive
  Scenario:MLP-24162:SC#25 Verify user able to add LDAP users to Technology owner field and able to click on save and open the item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_02   |
    And user "enter owner" in Create new item page
      | fieldName        | attribute       |
      | Technology Owner | Test Data Admin |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Item_02 |

  #QACID-7123395,7123405,7113910,7113913,7113919
  @MLP-24162 @MLP-24163 @webtest @regression @positive
  Scenario:MLP-24162:SC#26 Verify user able to add LDAP users to Relationship owner field and able to click on save and open the item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_03   |
    And user "enter owner" in Create new item page
      | fieldName          | attribute       |
      | Relationship Owner | Test Data Admin |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Item_03 |

  #QACID-7123395,7123405,7113910,7113914,7113919
  @MLP-24162 @MLP-24163 @webtest @regression @positive
  Scenario:MLP-24162:SC#27 Verify user able to add LDAP users to Security owner field and able to click on save and open the item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_04   |
    And user "enter owner" in Create new item page
      | fieldName      | attribute       |
      | Security Owner | Test Data Admin |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Item_04 |

  #QACID-7123395,7123405,7113910,7113916,7113919
  @MLP-24162 @MLP-24163 @webtest @regression @positive
  Scenario:MLP-24162:SC#28 Verify user able to add LDAP users to Compliance owner field and able to click on save and open the item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_05   |
    And user "enter owner" in Create new item page
      | fieldName        | attribute       |
      | Compliance Owner | Test Data Admin |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Item_05 |

  #QACID-7123395,7123405,7113910,7113917,7113918,7113919
  @MLP-24162 @MLP-24163 @webtest @regression @positive
  Scenario:MLP-24162:SC#29 Verify user able to add LDAP users in owner field and able to click on save and open the item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_06   |
    And user "enter owner" in Create new item page
      | fieldName          | attribute                                 |
      | Business Owner     | Test Data Admin                           |
      | Technology Owner   | Test Guest User,Test System Administrator |
      | Relationship Owner | Test Data Admin                           |
      | Security Owner     | Test Data Admin                           |
      | Compliance Owner   | Test Data Admin                           |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Item_06 |

  #QACID-7123395,7123405,7113910,7113917,7113918,7113919,7113920
  @MLP-24162 @MLP-24163 @webtest @regression @positive
  Scenario:MLP-24162:SC#30 Verify user able to add LDAP users in owner field and able to click on save and open the item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_07   |
    And user "enter owner" in Create new item page
      | fieldName          | attribute                                                 |
      | Business Owner     | Test Data Admin,Test Guest User,Test System Administrator |
      | Technology Owner   | Test Guest User,Test System Administrator,Test Data Admin |
      | Relationship Owner | Test Data Admin,Test Guest User,Test System Administrator |
      | Security Owner     | Test Data Admin,Test Guest User,Test System Administrator |
      | Compliance Owner   | Test Data Admin,Test Guest User,Test System Administrator |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Item_07 |

  #QACID-7123395,7123405,7113910,7113917,7113920
  @MLP-24162 @MLP-24163 @webtest @regression @positive
  Scenario:MLP-24162:SC#31 Verify user able to add LDAP users in owner field and able to click on cancel
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_07   |
    And user "enter owner" in Create new item page
      | fieldName          | attribute                                                 |
      | Business Owner     | Test Data Admin,Test Guest User,Test System Administrator |
      | Technology Owner   | Test Guest User,Test System Administrator,Test Data Admin |
      | Relationship Owner | Test Data Admin,Test Guest User,Test System Administrator |
      | Security Owner     | Test Data Admin,Test Guest User,Test System Administrator |
      | Compliance Owner   | Test Data Admin,Test Guest User,Test System Administrator |
    And user "click" on "Cancel button" button in "Create Item Page"
    And user "click" on "No" button in "Popup Window"
    And user "click" on "Cancel button" button in "Create Item Page"
    And user "click" on "Yes" button in "Popup Window"

  @MLP-24162 @MLP-24163 @regression @positive
  Scenario:SC#32_User Deletes the item from database using "Business Application" name
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name    | type                | query | param |
      | SingleItemDelete | Default | Item_01 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_02 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_03 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_04 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_05 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_06 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_07 | BusinessApplication |       |       |

  #QACID-7123395,7123405,7113910,71139171277457,7113918,7113920
  @MLP-24163 @webtest @regression @positive
  Scenario:MLP-24162:SC#33 Verify user able to add LDAP users in owner field and able to click on save and open the item.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_01   |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Item_01 |

  Scenario Outline:SC#34_User Retrieves Item id  and copy to a json file "Business Application"
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name    | type                | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | Default | Item_01 | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_1.id |

  #QACID-7127745
  @MLP-24163 @regression @positive
  Scenario Outline: SC#35_User enters the owners using dynamic id stored in json for Itemtype "Business Application"
    Given user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type | url                                                  | body                                        | responseCode | inputJson                   | inputFile                                     | responseMessage |
      | application/json | application/json | Put  | /items/Default/Default.BusinessApplication:::dynamic | idc\BusinessApplication\expectedowners.json | 204          | $..BusinessApplication_1.id | payloads\idc\BusinessApplication\itemIds.json |                 |

  #QACID-7127744
  @MLP-24163
  Scenario Outline:SC36#user retrieves the owners information for the business application
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                  | responseCode | inputJson                   | inputFile                                     | outPutFile                                         | outPutJson |
      | /items/Default/Default.BusinessApplication:::dynamic | 200          | $..BusinessApplication_1.id | payloads\idc\BusinessApplication\itemIds.json | payloads\idc\BusinessApplication\actualowners.json |            |

  #QACID-7127744,7127745
  @MLP-24163
  Scenario Outline:SC37#Validate the owner information
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                       | actualValues                                       | valueType     | expectedJsonPath      | actualJsonPath        |
      | payloads\idc\BusinessApplication\expectedowners.json | payloads\idc\BusinessApplication\actualowners.json | stringCompare | $..technologyOwners   | $..technologyOwners   |
      | payloads\idc\BusinessApplication\expectedowners.json | payloads\idc\BusinessApplication\actualowners.json | stringCompare | $..businessOwners     | $..businessOwners     |
      | payloads\idc\BusinessApplication\expectedowners.json | payloads\idc\BusinessApplication\actualowners.json | stringCompare | $..relationshipOwners | $..relationshipOwners |
      | payloads\idc\BusinessApplication\expectedowners.json | payloads\idc\BusinessApplication\actualowners.json | stringCompare | $..complianceOwners   | $..complianceOwners   |
      | payloads\idc\BusinessApplication\expectedowners.json | payloads\idc\BusinessApplication\actualowners.json | stringCompare | $..securityOwners     | $..securityOwners     |

  @MLP-24163 @MLP-24163 @regression @positive
  Scenario:SC#38_User Deletes the item from database using "Business Application" name
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name    | type                | query | param |
      | SingleItemDelete | Default | Item_01 | BusinessApplication |       |       |

  #QACID-7131201,7131203,7131205,7131206,7131208
  @MLP-24849 @webtest @regression @positive
  Scenario:MLP-24849:SC#39 Verify user able add and save multiple item type in the same page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_511  |
    And user "click" on "Save" button in "Create Item Page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_611  |
    And user "click" on "Save" button in "Create Item Page"
    And user "click" on "PopUp X" button in "Create Item Page"
    And user enters the search text "Item_611" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Item_611" item from search results
    And user enters the search text "Item_511" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Item_511" item from search results


  #QACID-7131201,7131203,7131205,7131206,7131208.7131209
  @MLP-24849 @webtest @regression @positive
  Scenario:MLP-24849:SC#39 Verify user able add and save, save and open multiple item type in the same page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_512  |
    And user "click" on "Save" button in "Create Item Page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_612  |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Item_612 |
    And user enters the search text "Item_512" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Item_512" item from search results


  #QACID-7131201,7131203,7131205,7131207,7131208
  @MLP-24849 @webtest @regression @positive
  Scenario:MLP-24849:SC#40 Verify user able add and save multiple item type including owners in the same page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_513  |
    And user "enter owner" in Create new item page
      | fieldName        | attribute                 |
      | Business Owner   | Test Data Admin           |
      | Technology Owner | Test System Administrator |
    And user "click" on "Save" button in "Create Item Page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_613  |
    And user "enter owner" in Create new item page
      | fieldName          | attribute                 |
      | Relationship Owner | Test Guest User           |
      | Security Owner     | Test System Administrator |
      | Compliance Owner   | Test Guest User           |
    And user "click" on "Save" button in "Create Item Page"
    And user "click" on "PopUp X" button in "Create Item Page"
    And user enters the search text "Item_613" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Item_613" item from search results
    And user enters the search text "Item_513" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Item_513" item from search results

  Scenario Outline:SC#41_User Retrieves Item id  and copy to a json file "Business Application"
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name     | type                | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | Default | Item_613 | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_1.id |

  @MLP-24849
  Scenario Outline:SC42#user retrieves the owners information for the business application
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                  | responseCode | inputJson                   | inputFile                                     | outPutFile                                         | outPutJson |
      | /items/Default/Default.BusinessApplication:::dynamic | 200          | $..BusinessApplication_1.id | payloads\idc\BusinessApplication\itemIds.json | payloads\idc\BusinessApplication\actualowners.json |            |

  @MLP-24849
  Scenario Outline:SC43#Validate the owner information that was saved
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                       | actualValues                                       | valueType     | expectedJsonPath      | actualJsonPath        |
      | payloads\idc\BusinessApplication\expectedowners.json | payloads\idc\BusinessApplication\actualowners.json | stringCompare | $..relationshipOwners | $..relationshipOwners |
      | payloads\idc\BusinessApplication\expectedowners.json | payloads\idc\BusinessApplication\actualowners.json | stringCompare | $..complianceOwners   | $..complianceOwners   |
      | payloads\idc\BusinessApplication\expectedowners.json | payloads\idc\BusinessApplication\actualowners.json | stringCompare | $..securityOwners     | $..securityOwners     |

  #QACID-7131201,7131203,7131205,7131206,7131208,7131209
  @MLP-24849 @webtest @regression @positive
  Scenario:MLP-24162:SC#44_Verify user able add and save, save and open multiple item type including owners in the same page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_514  |
    And user "enter owner" in Create new item page
      | fieldName        | attribute                 |
      | Business Owner   | Test Data Admin           |
      | Technology Owner | Test System Administrator |
    And user "click" on "Save" button in "Create Item Page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_614  |
    And user "enter owner" in Create new item page
      | fieldName          | attribute                 |
      | Relationship Owner | Test Guest User           |
      | Security Owner     | Test System Administrator |
      | Compliance Owner   | Test Guest User           |
    And user "click" on "Save and Open" button in "Create Item Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Item_614 |
    And user enters the search text "Item_514" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Item_514" item from search results

  Scenario Outline:SC#45_User Retrieves Item id  and copy to a json file "Business Application"
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name     | type                | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | Default | Item_514 | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_1.id |


  @MLP-24849
  Scenario Outline:SC#46_user retrieves the owners information for the business application
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                  | responseCode | inputJson                   | inputFile                                     | outPutFile                                         | outPutJson |
      | /items/Default/Default.BusinessApplication:::dynamic | 200          | $..BusinessApplication_1.id | payloads\idc\BusinessApplication\itemIds.json | payloads\idc\BusinessApplication\actualowners.json |            |

  @MLP-24849
  Scenario Outline:SC47#Validate the owner information that was saved
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                                       | actualValues                                       | valueType     | expectedJsonPath    | actualJsonPath      |
      | payloads\idc\BusinessApplication\expectedowners.json | payloads\idc\BusinessApplication\actualowners.json | stringCompare | $..technologyOwners | $..technologyOwners |
      | payloads\idc\BusinessApplication\expectedowners.json | payloads\idc\BusinessApplication\actualowners.json | stringCompare | $..businessOwners   | $..businessOwners   |


  #QACID-7131201,7131210
  @MLP-24849 @MLP-24163 @webtest @regression @positive
  Scenario:MLP-24162:SC#48 Verify user able exit without saving the second item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_515  |
    And user "enter owner" in Create new item page
      | fieldName        | attribute                 |
      | Business Owner   | Test Data Admin           |
      | Technology Owner | Test System Administrator |
    And user "click" on "Save" button in "Create Item Page"
    And user "select dropdown" in Create new item page
      | fieldName | attribute           |
      | Item Type | BusinessApplication |
    And user "enter text" in Create new item page
      | fieldName | attribute |
      | Item Name | Item_614  |
    And user "enter owner" in Create new item page
      | fieldName          | attribute                 |
      | Relationship Owner | Test Guest User           |
      | Security Owner     | Test System Administrator |
      | Compliance Owner   | Test Guest User           |
    And user "click" on "PopUp X" button in "Create Item Page"
    And user "verifies presence" of following "Admin Welcome Page" in "" page
      | Hello, Test System Administrator. |

  @MLP-24849 @regression @positive
  Scenario:SC#49_User Deletes the item from database using "Business Application" name
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name     | type                | query | param |
      | SingleItemDelete | Default | Item_611 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_511 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_612 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_512 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_613 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_513 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_614 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_514 | BusinessApplication |       |       |
      | SingleItemDelete | Default | Item_515 | BusinessApplication |       |       |
