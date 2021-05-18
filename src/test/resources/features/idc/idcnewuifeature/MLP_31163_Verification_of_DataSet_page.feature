@MLPQA-18144 @MLPQA-18176 @MLPQA-17683 @MLPQA-18351 @MLPQA-19411 @MLPQA-19412 @MLPQA-19362 @MLPQA-19290 @MLPQA-19252 @MLPQA-17918
Feature:MLP-31163_option to Create a Data Set, so that I can Request for the Physical Data with help of Collection Box called Datasets

  @MLP-31167 @webtest @regression @positive @TEST_MLPQA-17602 @TEST_MLPQA-17603 @MLPQA-18083 @TEST_MLPQA-18162 @TEST_MLPQA-18163 @TEST_MLPQA-18164 @TEST_MLPQA-18174 @e2e
  Scenario:MLP-31163:SC#1_Create Dataset
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "verifies presence" of following "Contextual Message" in "Create" page
      | Create a new item. |
    And user "Create Item" in Create new item page
      | fieldName | attribute | Message                  | option        |
      | DataSet   | TestDS    | This is a Sample DataSet | Save and Open |
    And user "verifies displayed" on "Item view page title" for "TestDS" in "Item view page"
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName | attribute | Message                  | option        |
      | DataSet   | DummyDS   | This is a Sample DataSet | Save and Open |
    And user "verifies displayed" on "Item view page title" for "DummyDS" in "Item view page"
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName | attribute | Message                  | option        |
      | DataSet   | AutoDS    | This is a Sample DataSet | Save and Open |
    And user "verifies displayed" on "Item view page title" for "AutoDS" in "Item view page"

  @MLP-31163 @webtest @regression @positive @TEST_MLPQA-18165 @MLPQA-18083 @TEST_MLPQA-18166 @TEST_MLPQA-18168 @TEST_MLPQA-18169 @TEST_MLPQA-18170 @TEST_MLPQA-18171 @TEST_MLPQA-18173 @TEST_MLPQA-17682
  Scenario:MLP-21951:SC#2_Verify if in docker environments all the Demo Data items belong to 'Default' catalog. Click any demo item and verify the item view URL has 'Default' as catalog name
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    Then user verifies the "Create" pop up is "displayed"
    And user "verifies presence" of following "Item type options" in "Create Item" page
      | BusinessApplication |
      | DataSet             |
    And user "verifies presence" of following "Contextual Message" in "Add Category" page
      | Create a new item. |
    And user "click" on "Item type option" for "DataSet" in "Landing page"
    And user "verifies presence" of following "Create Item popup fields" in "Create Item" page
      | Item Type   |
      | Item Name*  |
      | Description |
      | Image       |
    And user "enter text" in "Create Item popup"
      | fieldName | actionItem  |
      | Item Name | TestDataSet |
    And user verifies "Save Button" is "enabled"
    And user verifies "Save and Open Button" is "enabled"
    And user "enter text" in "Create Item popup"
      | fieldName                | actionItem |
      | Create Item Name Ignored |            |
    And user "Validate the Error Message" in Create new item page
      | fieldName | Message                             |
      | Item Name | Item Name field should not be empty |
    And user "enter text" in "Create Item popup"
      | fieldName | actionItem |
      | Item Name | TestDS     |
    And user "Validate the Error Message" in Create new item page
      | fieldName | Message                                                            |
      | Item Name | Item with this name already exists. Please enter a different name. |
    And user "enter text" in "Create Item popup"
      | fieldName                           | actionItem |
      | Create Item Name with Leading Space |            |
    And user "Validate the Error Message" in Create new item page
      | fieldName | Message                   |
      | Item Name | characters are forbidden. |
    And user "enter text" in "Create Item popup"
      | fieldName                            | actionItem |
      | Create Item Name with Trailing Space |            |
    And user "Validate the Error Message" in Create new item page
      | fieldName | Message                   |
      | Item Name | characters are forbidden. |
    And user "enter text" in "Create Item popup"
      | fieldName                           | actionItem |
      | Create Item Name with Forward slash |            |
    And user "Validate the Error Message" in Create new item page
      | fieldName | Message                   |
      | Item Name | characters are forbidden. |
    And user "enter text" in "Create Item popup"
      | fieldName                            | actionItem |
      | Create Item Name with Backward Slash |            |
    And user "Validate the Error Message" in Create new item page
      | fieldName | Message                   |
      | Item Name | characters are forbidden. |

  @MLP-31167 @webtest @regression @positive
  Scenario:31167:Create Tag
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Tags" in "Landing page"
    And user "click" on "Add Category" button in "Manage Tags page"
    And user creates a tag with the following parameters
      | CategoryName      | Definition             | Icon                 | colorWidthHeight | Protected |
      | AutomationTestTag | Created for Automation | fa fa-address-book-o | 189,18           | false     |
    And User performs following actions in the Manage Tags Page
      | Actiontype | ActionItem                | ItemName          | Attribute |
      | Click      | Category Menu buttons     | AutomationTestTag | Add       |
      | Enter Text | Category Name             | AutoTestSubTag1   |           |
      | Click      | Edit category Save Button |                   |           |
      | Click      | Category Menu buttons     | AutomationTestTag | Add       |
      | Enter Text | Category Name             | AutoTestSubTag2   |           |
      | Click      | Edit category Save Button |                   |           |

  @MLP-31167 @webtest @regression @positive  @TEST_MLPQA-17594 @MLPQA-18083 @TEST_MLPQA-17595 @TEST_MLPQA-17596 @TEST_MLPQA-17597 @TEST_MLPQA-17598 @TEST_MLPQA-17599 @TEST_MLPQA-17600 @TEST_MLPQA-17601
  Scenario:MLP-31167:SC#1_Verify user has Option to See All the Available Dataset created by the User
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Data Science and Analytics" in "Landing page"
    And user verifies "Data Science and Analytics title" is "displayed"
    And User validates URL of Demo Data contains "DD/dataset"
    And user perform following actions in Dataset Dashboard Page
      | Actiontype      | ActionItem | ItemName |
      | Verify presence | Data Set   | TestDS   |
      | Verify presence | Data Set   | DummyDS  |
    And user enters the search text "TestDS" and clicks on search
    And user "click" on "Select All checkbox" button in "Item Search Results" page
    And user "click" on "Search Results Show more options" for "Assign/Unassign Tags" in "Search results page"
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem      | Section   |
      | Tag Selection | AutoTestSubTag1 | Available |
    And user "click" on "Assign" button in "Assign a Tag popup"
    And user "click" on "Sidebar Link" for "Data Science and Analytics" in "Landing page"
    And user "click" on "Filter Icon" button in "Data Set dashbaord Page"
    And user "select Data Set filter dropdown" in "Data Set dashbaord Page"
      | fieldName | actionItem      |
      | Tag       | AutoTestSubTag1 |
    And user perform following actions in Dataset Dashboard Page
      | Actiontype          | ActionItem | ItemName |
      | Verify presence     | Data Set   | TestDS   |
      | Verify non presence | Data Set   | DummyDS  |
    And user "select Data Set filter dropdown" in "Data Set dashbaord Page"
      | fieldName | actionItem |
      | Tag       | All        |
      | Data Set  | MyDataset  |
    And user perform following actions in Dataset Dashboard Page
      | Actiontype      | ActionItem | ItemName |
      | Verify presence | Data Set   | TestDS   |
      | Verify presence | Data Set   | DummyDS  |
    And user enters "InvalidDataSet" in search text box
    And user perform following actions in Dataset Dashboard Page
      | Actiontype      | ActionItem           | ItemName |
      | Verify presence | No record found text |          |

  @MLP-31169 @webtest @regression @positive @TEST_MLPQA-17671 @MLPQA-18083 @TEST_MLPQA-17673 @TEST_MLPQA-17674
  Scenario:MLP-31169:SC#1_Verify if clicing on any Data Set from Data Set screen navigates to Data Set item view screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Data Science and Analytics" in "Landing page"
    And user perform following actions in Dataset Dashboard Page
      | Actiontype      | ActionItem | ItemName |
      | Verify presence | Data Set   | DummyDS  |
      | Click Data Set  |            | DummyDS  |
    And user "verifies displayed" on "Item view page title" for "DummyDS" in "Item view page"
    And user enters the search text "DummyDS" and clicks on search
    And user performs "facet selection" in "DataSet" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "verifies displayed" on "Item view page title" for "DummyDS" in "Item view page"
    And User performs following actions in the Item view Page
      | Actiontype              | ActionItem                    |
      | Verifies Item view tabs | Overview,Data,Access Requests |
    And user gives "4" rating in item view page
    And user clicks on search icon
    And user performs "facet selection" in "DataSet" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on rating 4 checkbox and get item count
    And user verifies first item "DummyDS"in item list page
    And user enters the search text "DummyDS" and clicks on search
    And user performs "facet selection" in "DataSet" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem     |
      | Click      | Add Tag Button |
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem      | Section   |
      | Tag Selection | AutoTestSubTag2 | Available |
    And user "click" on "Assign" button in "Assign a Tag popup"
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem      |
      | Verify Tag Presence | AutoTestSubTag1 |
      | Verify Tag Presence | AutoTestSubTag2 |

  @MLP-31169
  Scenario:MLP-31169: Create an table item
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                | body                                       | response code | response message | jsonPath |
      | application/json | raw   | false | Post | items/Default/root | idc/IDxPayloads/MLP_25436_Table_Item1.json | 200           |                  |          |
      |                  |       |       | Post | items/Default/root | idc/IDxPayloads/MLP_25436_Table_Item2.json | 200           |                  |          |

  @MLP-31169 @webtest @regression @positive @TEST_MLPQA-17682 @TEST_MLPQA-17672 @TEST_MLPQA-17675 @MLPQA-18083 @TEST_MLPQA-17676 @TEST_MLPQA-17677 @TEST_MLPQA-17678 @TEST_MLPQA-17679 @TEST_MLPQA-17680 @TEST_MLPQA-17681
  Scenario:MLP-31169:SC#2_Verify if user can Add items using 'Add Data Item / Assign Data' option
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "DummyDS" and clicks on search
    And user performs "facet selection" in "DataSet" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem          | ItemName                  | Section |
      | Verify Top bar section | Data Set Visibility | PUBLIC                    | DummyDS |
      | Verify Top bar section | Owner               | Test System Administrator | DummyDS |
      | Verifies Item Presence | Description         | This is a Sample DataSet  |         |
    And user "click" on "navigatesToTab" for "Data" in "Item View" page
    And User performs following actions in the Item view Page
      | Actiontype      | ActionItem         | ItemName | Section |
      | Verify Presence | Assign Data Button |          |         |
    And User performs following actions in the Item view Page
      | Actiontype      | ActionItem                       | ItemName                 |
      | Verify Presence | Item view Edit Button            |                          |
      | Verify Presence | Item view Show More Icon         |                          |
      | Click           | Item view Show More Icon         |                          |
      | Verify Presence | Options under the Show more icon | Rename,Delete,Visibility |

  @MLP-31171 @webtest @regression @positive @MLP-32843 @MLPQA-18083 @TEST_MLPQA-18180 @TEST_MLPQA-18181 @TEST_MLPQA-18182 @TEST_MLPQA-18183 @TEST_MLPQA-18184 @TEST_MLPQA-18185 @TEST_MLPQA-18186 @TEST_MLPQA-18187 @TEST_MLPQA-18188 @TEST_MLPQA-18189
  Scenario:MLP-31171:SC#1_Verify Option to Update the Visibility and Description for the Data Set in the Item View Screen.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "TestDS" and clicks on search
    And user performs "facet selection" in "DataSet" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "verifies displayed" on "Item view page title" for "TestDS" in "Item view page"
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem                       | ItemName                                |
      | Click                  | Item view Edit Button            |                                         |
      | Enter Description      | Description                      | Description for the Data Set is updated |
      | Click                  | Item view Save Button            |                                         |
      | Verifies Item Presence | Description                      | Description for the Data Set is updated |
      | Click                  | Item view Show More Icon         |                                         |
      | Verify Presence        | Options under the Show more icon | Visibility                              |
      | Click                  | Item view Show more icons        | Visibility                              |
    And user "verifies presence" of following "Set Visibility" in "Add Category" page
      | Set the visibility of a data set. |
    And User performs following actions in the "Set Visibility" popup
      | Actiontype                                    | ActionItem | ItemName                                  |
      | Verify the dropdown option selected for field | Visibility | PUBLIC                                    |
      | Select option from dropdown                   | Visibility | RESTRICTED                                |
#      | Select Owner                                  | Owner      | Test Guest User |
      | Select Member                                 | Member     | Test System Administrator,Test Data Admin |
    And user "click" on "SAVE" button in "Set Visibility popup"
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem          | ItemName   | Section |
      | Verify Top bar section | Data Set Visibility | RESTRICTED | TestDS  |

  @MLP-31177 @webtest @regression @positive @TEST_MLPQA-17947 @MLPQA-18083 @TEST_MLPQA-17948 @TEST_MLPQA-17949 @TEST_MLPQA-17950 @TEST_MLPQA-17951 @TEST_MLPQA-17952 @TEST_MLPQA-17953 @TEST_MLPQA-17954 @TEST_MLPQA-17955 @TEST_MLPQA-17956 @TEST_MLPQA-17957
  Scenario:MLP-31177:SC#1_To verify the user is able to view the "Assign Data" under Data tab
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "DummyDS" and clicks on search
    And user performs "facet selection" in "DataSet" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "navigatesToTab" for "Data" in "Item View" page
    And User performs following actions in the Item view Page
      | Actiontype      | ActionItem                       | ItemName | Section      |
      | Verify Presence | Assign Data Button               |          |              |
      | Assign Data     | TableSingleTest,TableSingleTest2 | DummyDS  | ADD AND OPEN |
    Then user performs click and verify in new window
      | Table | value            | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | TableSingleTest1 | verify widget contains | No               |             |
      | Data  | TableSingleTest2 | verify widget contains | No               |             |
    And Execute REST API with following parameters
      | Header           | Query | Param | type | url                | body                                       | response code | response message | jsonPath |
      | application/json | raw   | false | Post | items/Default/root | idc/IDxPayloads/MLP_25436_Table_Item3.json | 200           |                  |          |
    And User performs following actions in the Item view Page
      | Actiontype      | ActionItem         | ItemName | Section |
      | Verify Presence | Assign Data Button |          |         |
      | Assign Data     | TableSingleTest3   | DummyDS  | ADD     |
    And user enters the search text "DummyDS" and clicks on search
    And user performs "facet selection" in "DataSet" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "navigatesToTab" for "Data" in "Item View" page
    Then user performs click and verify in new window
      | Table | value            | Action                 | RetainPrevwindow | indexSwitch |
      | Data  | TableSingleTest1 | verify widget contains | No               |             |
      | Data  | TableSingleTest2 | verify widget contains | No               |             |
      | Data  | TableSingleTest3 | verify widget contains | No               |             |
    And user "click" on "Sidebar Link" for "Data Science and Analytics" in "Landing page"
    And user perform following actions in Dataset Dashboard Page
      | Actiontype     | ActionItem | ItemName |
      | Click Data Set |            | DummyDS  |
    And user "click" on "navigatesToTab" for "Data" in "Item View" page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem         | ItemName | Section |
      | Click      | Assign Data Button |          |         |
    And user performs following actions in the Search results page
      | actionType | actionItem        |
      | click      | firstItemCheckbox |
      | click      | Add to Data Set   |
    And user "verifies presence" of following "Contextual Message" in "Add item(s) to a data set" page
      | Add the selected data items to data set |
    And User performs following actions in the "Set Visibility" popup
      | Actiontype                                    | ActionItem | ItemName |
      | Verify the dropdown option selected for field | Data Set   | DummyDS  |

  @MLP-31472 @webtest @regression @positive @TEST_MLPQA-18244 @MLPQA-18083 @TEST_MLPQA-18245 @TEST_MLPQA-18246 @TEST_MLPQA-18247 @TEST_MLPQA-18248 @TEST_MLPQA-18249 @TEST_MLPQA-18250 @TEST_MLPQA-18251 @TEST_MLPQA-18252 @TEST_MLPQA-18253
  Scenario:MLP-31472:SC#1_To verify the Option to Add Items to a Data set, so that he/she can directly add items without navigating to corresponding Dataset Item in an Itemview
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs following actions in the Search results page
      | actionType                 | actionItem        |
      | verifies displayed         | Add to Data Set   |
      | verify element is disabled | Add to Data Set   |
      | click                      | firstItemCheckbox |
      | verify element is enabled  | Add to Data Set   |
      | click                      | Add to Data Set   |
    And user "verifies presence" of following "Contextual Message" in "Add item(s) to a data set" page
      | Add the selected data items to data set |
    And User performs following actions in the "Add item(s) to a data set" popup
      | Actiontype                  | ActionItem | ItemName |
      | Select option from dropdown | Data Set   | DummyDS  |
      | click                       | ADD        |          |
#    And search results page
    And user enters the search text "customer" and clicks on search
    And user performs following actions in the Search results page
      | actionType                | actionItem        |
      | click                     | firstItemCheckbox |
      | verify element is enabled | Add to Data Set   |
      | click                     | Add to Data Set   |
    And User performs following actions in the "Set Visibility" popup
      | Actiontype                  | ActionItem   | ItemName |
      | Select option from dropdown | Data Set     | DummyDS  |
      | click                       | ADD AND OPEN |          |
    And User performs following actions in the Item view Page
      | Actiontype          | ActionItem |
      | Verify Tab Presence | Data       |
    And user clicks on search icon
    And user performs following actions in the Search results page
      | actionType | actionItem        |
      | click      | firstItemCheckbox |
      | click      | Add to Data Set   |
    And User performs following actions in the "Add item(s) to a data set" popup
      | Actiontype                  | ActionItem | ItemName |
      | Select option from dropdown | Data Set   | DummyDS  |
    And user "click" on "Cancel button" button in "Add item(s) to a data set popup"
    And user "Verifies Nested popup" is "displayed" for "Unsaved changes"

  Scenario:Delete the created Table Items
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name             | type  |
      | SingleItemDelete | Default | TableSingleTest1 | Table |
      | SingleItemDelete | Default | TableSingleTest2 | Table |
      | SingleItemDelete | Default | TableSingleTest3 | Table |

  @MLP-31169
  Scenario:MLP-31169: Create an table item
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                | body                                       | response code | response message | jsonPath |
      | application/json | raw   | false | Post | items/Default/root | idc/IDxPayloads/MLP_25436_Table_Item1.json | 200           |                  |          |

  @MLP-31182 @webtest @regression @positive
  Scenario:MLP-31182:SC#1_To verify the section to view all the Data Set Access Request, so that User can get the Holistic View of Request raised for Data Sets
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "AutoDS" and clicks on search
    And user performs "facet selection" in "DataSet" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "navigatesToTab" for "Data" in "Item View" page
    And User performs following actions in the Item view Page
      | Actiontype                   | ActionItem       | ItemName           | Section      |
      | Assign Data                  | TableSingleTest1 | AutoDS             | ADD AND OPEN |
      | Check Item and select option | TableSingleTest1 | Request for Access |              |
    And user "click" on "Capture and Import Data Link" for "Manage Access Requests" in "Landing page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Access Requests |
    And user "verifies presence" of following "Page Subtitle" in "Manage Access Requests" page
      | See the history and the status of data access requests for data sets. |
    And User performs following actions in the Manage Access Requests page
      | Actiontype                                 | ActionItem | ItemName |
      | Verify Access Request Presence for DataSet | AutoDS     |          |
      | Verify Access Request count for DataSet    | AutoDS     | 1        |

  @MLP-31179 @webtest @regression @positive @TEST_MLPQA-19363 @MLPQA-18084 @e2e
  Scenario: SC#1: MLP-31179: Verify the option to view "Access Request" Item so that I can Approve or Reject the Request Received.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage LDAP Users" in "Landing page"
    And user "click" on "Add LDAP User" in Manage Access page
    And user "Verifies popup" is "displayed" for "Add User"
    And users performs following actions in Manage access
      | Actiontype           | ActionItem | ItemName             |
      | Enter Text in field  | LDAP User  | Becubic Build        |
      | Select Role          | Role       | System Administrator |
      | Close Dropdown Popup |            |                      |
    And user "click" on "Save Local User" in Manage Access page

  @git @TEST_MLPQA-19364 @MLPQA-18084
  Scenario: Create Datasource Credentials and Configuration for GitCollector
    Given User update the below "Git Credentials" in following files using json path
      | filePath                                                             | username    | password    |
      | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json | $..userName | $..password |
    And Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body                                                                         | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollectorConfig |                                                                              |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |                                                                              |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/GitCred                       |                                                                              |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/GitCredInvalid                |                                                                              |               |                  |          |              |          |
      |                  |       |       | Put    | settings/credentials/GitCred                       | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Credential_Config.json         | 200           |                  |          |              |          |
      |                  |       |       | Get    | settings/credentials/GitCred                       |                                                                              | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/credentials/GitCredInvalid                | idc/IDX_PluginPayloads/MLP-14102_GitCollector_Invalid_Credential_Config.json | 200           |                  |          |              |          |
      |                  |       |       | Get    | settings/credentials/GitCredInvalid                |                                                                              | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollectorDataSource/GitDS    | idc/IDX_PluginPayloads/MLP-14102_GitCollector_DataSource_Config.json         | 204           |                  |          |              |          |
      |                  |       |       | Get    | settings/analyzers/GitCollectorDataSource/GitDS    |                                                                              | 200           |                  |          |              |          |
      |                  |       |       | Put    | settings/analyzers/GitCollector/GitCollectorConfig | idc/IDX_PluginPayloads/MLP-15889_GitCollector_Plugin_Config.json             | 204           |                  |          |              |          |

  @git
  Scenario: Run the GitCollector Configuration
    Given Execute REST API with following parameters
      | Header           | Query | Param | type         | url                                                                             | body | response code | response message | jsonPath                                                |
      | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollectorConfig')].status |
      |                  |       |       | Post         | extensions/analyzers/start/LocalNode/collector/GitCollector/GitCollectorConfig  |      | 200           |                  |                                                         |
      |                  |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/collector/GitCollector/GitCollectorConfig |      | 200           | IDLE             | $.[?(@.configurationName=='GitCollectorConfig')].status |

  @aws
  Scenario: Update AWS username and password from config file
    Given User update the below "redshift credentials" in following files using json path
      | filePath                                                       | username                             | password                             |
      | idc/IDx_DataSource_Credentials_Payloads/amazonCredentials.json | $.redshiftValidCredentials..userName | $.redshiftValidCredentials..password |

  @aws
  Scenario Outline: Set the Credentials for Redshift Datasource
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                                         | bodyFile                                                                     | path                       | response code | response message   | jsonPath |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Redshift_Credentials   | payloads/idc/IDx_DataSource_Credentials_Payloads/amazonCredentials.json      | $.redshiftValidCredentials | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/credentials/Redshift_Credentials   | payloads/idc/IDx_DataSource_Credentials_Payloads/amazonCredentials.json      | $.redshiftValidCredentials | 200           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Put  | settings/analyzers/AmazonRedshiftDataSource | payloads/idc/IDx_DataSource_Credentials_Payloads/AmazonDataSourceConfig.json | $.RedshiftDataSource       | 204           |                    |          |
      | IDC         | TestSystemUser | application/json | raw   | false | Get  | settings/analyzers/AmazonRedshiftDataSource |                                                                              |                            | 200           | RedshiftDataSource |          |

  @sanity @positive @regression
  Scenario Outline: Run AmazonRedshift @TEST_MLPQA-19365 @MLPQA-18084
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body as string from "<bodyFile>" with "<path>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                       | bodyFile                                                | path                      | response code | response message  | jsonPath                                               |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                | payloads/idc/IDX_PluginPayloads/AmazonPluginConfig.json | $.AmazonRedshiftCataloger | 204           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | Get          | settings/analyzers/AmazonRedshiftCataloger                                |                                                         |                           | 200           | RedShiftCataloger |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/* |                                                         |                           | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |
      | IDC         | TestSystemUser | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/*  |                                                         |                           | 200           |                   |                                                        |
      | IDC         | TestSystemUser | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/* |                                                         |                           | 200           | IDLE              | $.[?(@.configurationName=='RedShiftCataloger')].status |

  @MLP-31179 @webtest @regression @positive @TEST_MLPQA-19366 @MLPQA-18084 @TEST_MLPQA-19367 @TEST_MLPQA-19368 @TEST_MLPQA-19369
  Scenario:MLP-31179:SC#2_To verify option to view "Access Request" Item so that I can Approve or Reject the Request Received.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Sidebar Link" for "Create" in "Landing page"
    And user "Create Item" in Create new item page
      | fieldName | attribute                 | Message                  | option        |
      | DataSet   | Automate DataSet Requests | This is a Sample DataSet | Save and Open |
    And user enters the search text "basetypes.py" and clicks on search
    And user performs "facet selection" in "Git" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs following actions in the Search results page
      | actionType | actionItem        |
      | click      | firstItemCheckbox |
      | click      | Add to Data Set   |
    And User performs following actions in the "Add item(s) to a data set" popup
      | Actiontype                  | ActionItem | ItemName                  |
      | Select option from dropdown | Data Set   | Automate DataSet Requests |
      | click                       | ADD        |                           |
    And user enters the search text "empid" and clicks on search
    And user performs "facet selection" in "Redshift" attribute under "Technology" facets in Item Search results page
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs following actions in the Search results page
      | actionType | actionItem        |
      | click      | firstItemCheckbox |
      | click      | Add to Data Set   |
    And User performs following actions in the "Add item(s) to a data set" popup
      | Actiontype                  | ActionItem   | ItemName                  |
      | Select option from dropdown | Data Set     | Automate DataSet Requests |
      | click                       | ADD AND OPEN |                           |
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem   | ItemName   | Section |
      | Check Item    | basetypes.py |            |         |
      | Verify option | Disabled     | Run Action |         |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem         | ItemName  | Section               |
      | Select All items and select option | Request for Access |           |                       |
      | Verify Column Value for Items      | basetypes.py       | Requested | Access Request Status |
      | Verify Column Value for Items      | empid              | Requested | Access Request Status |

  @MLP-31179 @webtest @regression @positive @TEST_MLPQA-19370 @TEST_MLPQA-19371 @TEST_MLPQA-19372 @TEST_MLPQA-19373 @TEST_MLPQA-19374 @TEST_MLPQA-19375 @TEST_MLPQA-19376 @TEST_MLPQA-19377 @TEST_MLPQA-19378 @TEST_MLPQA-19379 @TEST_MLPQA-19380 @TEST_MLPQA-19381 @TEST_MLPQA-19382 @TEST_MLPQA-19383 @TEST_MLPQA-19384 @TEST_MLPQA-19385 @TEST_MLPQA-19386 @TEST_MLPQA-19387 @TEST_MLPQA-19388 @TEST_MLPQA-19389 @TEST_MLPQA-18972
  Scenario:MLP-31179:SC#3_To verify option to view "Access Request" Item so that I can Approve or Reject the Request Received.
    Given User launch browser and traverse to login page
    When user enter credentials for "Becubic User" role
    And User performs following actions in the Manage Notifications Page
      | Actiontype      | ActionItem                                | ItemName                                                                                              |
      | Click           | Notification bell Icon                    |                                                                                                       |
      | Click           | Open notification by content              | TestSystem requested for access to data in the data set: Automate DataSet Requests                    |
      | Verify Presence | Notification Title and Content            | Request for Access,TestSystem requested for access to data in the data set: Automate DataSet Requests |
      | Click           | Click here to open the request for access |                                                                                                       |
    And User performs following actions in the Item view Page
      | Actiontype             | ActionItem | ItemName                  | Section        |
      | Verify Top bar section | Requester  | Test System Administrator | Access Request |
      | Verify Top bar section | Data Set   | Automate DataSet Requests | Access Request |
    Then user performs click and verify in new window
      | Table    | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Git      | basetypes.py | verify widget contains | No               |             |
      | Redshift | empid        | verify widget contains | No               |             |
    And User performs following actions in the Item view Page
      | Actiontype                       | ActionItem                                           | ItemName                  | Section        |
      | Verify Top bar section           | Requester                                            | Test System Administrator | Access Request |
      | Verify column names inside table | Name,Type,Data Source,Data Credential,Request Status |                           |                |
      | Verify Disabled                  | Grant Access                                         |                           |                |
      | Verify Disabled                  | Reject Access                                        |                           |                |
      | Check Item                       | basetypes.py                                         | Grant Access              |                |
    And user "Verifies popup" is "displayed" for "Grant Access"
    And user "verifies presence" of following "Contextual Message" in "Grant Access" page
      | Assign a data source to the requested data so that access is possible. |
    And user "click" on "Cancel button" button in "Grant Access popup"
    And user "verifies displayed" on "Item view page title" for "Access Request" in "Item view page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem   |
      | Click      | Grant Access |
    And User performs following actions in the "Grant Access" popup
      | Actiontype                                    | ActionItem     | ItemName             |
      | Verify Column names for the table             | Requested Data | Name,Type,Technology |
      | Verify the item names in Requested Data Table | basetypes.py   |                      |
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute      |
      | Data Source | GitDS          |
      | Credential  | GitCredInvalid |
      | Deployment  | LocalNode      |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Failed datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user "select dropdown" in Add Data Source Page
      | fieldName   | attribute |
      | Data Source | GitDS     |
      | Credential  | GitCred   |
      | Deployment  | LocalNode |
    And user "click" on "Test Connection" button in "Add Data Sources pop up"
    And user verifies "Successful datasource connection" is "displayed" in "Step1 Add Data Source pop up"
    And user "click" on "Assign" button in "Grant Access popup"
    And user "verifies displayed" on "Item view page title" for "Access Request" in "Item view page"
    And User performs following actions in the Item view Page
      | Actiontype                    | ActionItem   | ItemName | Section         |
      | Verify Column Value for Items | basetypes.py | Approved | Request Status  |
      | Verify Column Value for Items | basetypes.py | GitDS    | Data Source     |
      | Verify Column Value for Items | basetypes.py | GitCred  | Data Credential |
    And user refreshes the application
    And User performs following actions in the Item view Page
      | Actiontype    | ActionItem   | ItemName   | Section |
      | Verify option | Disabled     | Run Action |         |
      | Check Item    | basetypes.py |            |         |
      | Verify option | Enabled      | Run Action |         |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem | ItemName      | Section |
      | Check Item | empid      | Reject Access |         |

  @MLP-31179 @webtest @regression @positive @TEST_MLPQA-19390 @MLPQA-18084 @TEST_MLPQA-193901 @TEST_MLPQA-18973 @TEST_MLPQA-18974
  Scenario:MLP-31179:SC#4_To verify option to view "Access Request" Item so that I can Approve or Reject the Request Received.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User performs following actions in the Manage Notifications Page
      | Actiontype      | ActionItem                     | ItemName                                                                         |
      | Click           | Notification bell Icon         |                                                                                  |
      | Click           | Open notification by content   | becubic_build granted access to data in the data set                             |
      | Verify Presence | Notification Title and Content | Access Granted,becubic_build granted access to data in the data set              |
      | Click           | Open notification by content   | Access to Automate DataSet Requests for TestSystem has been denied               |
      | Verify Presence | Notification Title and Content | Access Denied,Access to Automate DataSet Requests for TestSystem has been denied |

  @MLP-32011 @webtest @regression @positive @TEST_MLPQA-18970 @MLPQA-18084 @TEST_MLPQA-18971 @TEST_MLPQA-19302 @TEST_MLPQA-19303 @TEST_MLPQA-19304 @TEST_MLPQA-19305
  Scenario:MLP-32011:SC#1_To verify Enable Dataset plugins
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Bundles" in "Landing page"
    And user "verifies presence" of following "Bundles list" in "Manage Bundles" page
      | com.asg.dis.TableauConnector  |
      | com.asg.dis.NotebookConnector |
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                 | body | response code | response message  | jsonPath    |
      | application/json |       |       | Get  | settings/datasets/TableauConnector  |      | 200           | TableauConnector  | $..['name'] |
      |                  |       |       | Get  | settings/datasets/NotebookConnector |      | 200           | IDC Local Jupyter | $..['name'] |
    And user verifies whether the value is present in response using json path "$..['class']"
      | jsonValues                                             |
      | com.asg.dis.common.datasets.DataSetPluginConfiguration |

  Scenario:Delete the created Items
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                      | type    |
      | SingleItemDelete | Default | TableSingleTest1          | Table   |
      | SingleItemDelete | Default | TableSingleTest2          | Table   |
      | SingleItemDelete | Default | TableSingleTest3          | Table   |
      | SingleItemDelete | Default | TableSingleTest4          | Table   |
      | SingleItemDelete | Default | AutomationTestTag         | Tag     |
      | SingleItemDelete | Default | TestDS                    | DataSet |
      | SingleItemDelete | Default | DummyDS                   | DataSet |
      | SingleItemDelete | Default | Automate DataSet Requests | DataSet |

  @git
  Scenario: Delete Datasource Credentials and Configuration for GitCollector
    Given Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                                | body | response code | response message | jsonPath | endpointType | itemName |
      | application/json | raw   | false | Delete | settings/analyzers/GitCollector/GitCollectorConfig |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/GitCollectorDataSource/GitDS    |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/GitCred                       |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/GitCredInvalid                |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftCataloger         |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftDataSource        |      |               |                  |          |              |          |
      |                  |       |       | Delete | settings/credentials/Redshift_Credentials          |      |               |                  |          |              |          |