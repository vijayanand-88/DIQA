@26093@26099
Feature:MLP-26093 This feature is to verify Custom Attributes Linked to BA

  @MLP-26093@regression @positive @e2e
  Scenario Outline:SC_create BA
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                    | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP-23661\BusinessApplication1.json | 200           |                  |          |

    # 7170428# 7170429 # 7170430# 7170431# 7170432# 7170434# 7170435# 7170436# 7170437# 7170438# 7170439# 7186724
  @MLP-26093 @webtest @regression @positive @e2e
  Scenario:MLP-26093:SC#1_Verify if user is able to view DataModel (Itemtypes and Attributes) section avilable under settings in DD UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Itemtypes and Attributes" in "Landing page"
    And user "verify sidebar menu items" of following "Data Model" in "Landing" page
      | Itemtypes and Attributes |
    And user "verifies presence" of following "Admin page Title" in "" page
      | Data Model |
    And user "verifies presence" of following "Page Subtitle" in "Manage Tags" page
      | Shows itemtypes, attributes and manage custom attributes. |
    And user "displayed" on "Itemtypes" for "Itemtypes" in "Landing page"
    And user "displayed" on "SchemaCount" for "" in "Landing page"
    And user perform following actions in Custom Attribute Page
      | Actiontype               | ActionItem            | ItemName           | Section     |
      | Click ItemTypes          | BusinessApplication   |                    |             |
      | Validate Itemtype Tab    | BusinessApplication   | Default Attributes |             |
      | Validate Itemtype Tab    | BusinessApplication   | Relationships      |             |
      | Validate Itemtype Tab    | BusinessApplication   | Custom Attributes  |             |
      | Validate Itemtype Column | BusinessApplication   | Default Attributes | name        |
      | Validate Itemtype Column | BusinessApplication   | Default Attributes | type        |
      | Validate Itemtype Column | BusinessApplication   | Default Attributes | displayName |
      | Validate Itemtype Column | BusinessApplicatio    | Default Attributes | values      |
      | Click ItemTypes Tab      | Custom Attributes     | Tabvalue           |             |
      | Validate Itemtype Column | BusinessApplication   | Custom Attributes  | name        |
      | Validate Itemtype Column | BusinessApplication   | Custom Attributes  | type        |
      | Validate Itemtype Column | BusinessApplication   | Custom Attributes  | displayName |
      | Validate Itemtype Column | BusinessApplication   | Custom Attributes  | description |
      | Click ItemTypes Tab      | Add Custom Attributes |                    |             |
    And users performs following actions in Manage access
      | Actiontype                    | ActionItem  | ItemName   | Section |
      | Enter Text in User and Groups | Enter name  | TestCustom |         |
      | Enter Text in User and Groups | Enter label | TestCustom |         |
    And user perform following actions in Custom Attribute Page
      | Actiontype      | ActionItem      | ItemName | Section  |
      | Select Dropdown | Select datatype | STRING   | DataType |
      | Select Dropdown | Select tab      | Business |          |
    And user "click" on "Save" button in "Manage users and groups Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                   | ActionItem | ItemName   | Section |
      | Verify Column Value Contains | Name       | TestCustom |         |

# 7186719
  @MLP-26093 @webtest @regression @positive @e2e
  Scenario:MLP-26099:SC#2_Verify Custom attributes displayed under businessApplication itemtypes
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_Dashboard" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_Dashboard" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem | ItemName |
      | Edit Icon BusinessTab |            |          |
    And user perform following actions in Custom Attribute Page
      | Actiontype     | ActionItem | ItemName  | Section | Actionname |
      | Enter and Edit | text       | customone | BA Edit | TestCustom |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem | ItemName |
      | Click      | Save       |          |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem | ItemName  |
      | Verify presence of Dropdown Values | TestCustom | customone |

# 7186726
  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#3_Verify clicking on edit,changing the label and popup visible after cliking cancel
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Itemtypes and Attributes" in "Landing page"
    And user perform following actions in Custom Attribute Page
      | Actiontype          | ActionItem          | ItemName | Section |
      | Click ItemTypes     | BusinessApplication |          |         |
      | Click ItemTypes Tab | Custom Attributes   | Tabvalue |         |
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem | ItemName               | Section |
      | Click Edit,Clone,Run,Download and Delete | TestCustom | Edit the configuration |         |
    And user "click" on "Cancel button" button in "Manage Testusers Page"
    And user "click" on "Yes" button in "Unsaved changes pop up"

# 7186720
  @MLP-26093 @webtest @regression @positive @e2e
  Scenario:MLP-26099:SC#4_Verify add new custom attributes is displayed under custom attributes
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Itemtypes and Attributes" in "Landing page"
    And user perform following actions in Custom Attribute Page
      | Actiontype          | ActionItem            | ItemName | Section |
      | Click ItemTypes     | BusinessApplication   |          |         |
      | Click ItemTypes Tab | Custom Attributes     | Tabvalue |         |
      | Click ItemTypes Tab | Add Custom Attributes |          |         |
    And users performs following actions in Manage access
      | Actiontype                    | ActionItem  | ItemName      | Section |
      | Enter Text in User and Groups | Enter name  | TestCustomINT |         |
      | Enter Text in User and Groups | Enter label | TestCustomINT |         |
    And user perform following actions in Custom Attribute Page
      | Actiontype      | ActionItem      | ItemName | Section  |
      | Select Dropdown | Select datatype | INT      | DataType |
      | Select Dropdown | Select tab      | Business |          |
    And user "click" on "Save" button in "Manage users and groups Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                   | ActionItem | ItemName      | Section |
      | Verify Column Value Contains | Name       | TestCustomINT |         |

# 7186721# 7186723
  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#5_ Verfiy clicking on add new custom attributes add custom attributes popup opens
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Itemtypes and Attributes" in "Landing page"
    And user perform following actions in Custom Attribute Page
      | Actiontype          | ActionItem            | ItemName | Section |
      | Click ItemTypes     | BusinessApplication   |          |         |
      | Click ItemTypes Tab | Custom Attributes     | Tabvalue |         |
      | Click ItemTypes Tab | Add Custom Attributes |          |         |
    And users performs following actions in Manage access
      | Actiontype                    | ActionItem  | ItemName          | Section |
      | Enter Text in User and Groups | Enter name  | TestCustomBoolean |         |
      | Enter Text in User and Groups | Enter label | TestCustomBoolean |         |
    And user perform following actions in Custom Attribute Page
      | Actiontype      | ActionItem      | ItemName | Section  |
      | Select Dropdown | Select datatype | BOOLEAN  | DataType |
      | Select Dropdown | Select tab      | Business |          |
    And user "click" on "Save" button in "Manage users and groups Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                   | ActionItem | ItemName          | Section |
      | Verify Column Value Contains | Name       | TestCustomBoolean |         |


  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#6_Verify if user can create custom Attributes Datatype string with valuelist
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Itemtypes and Attributes" in "Landing page"
    And user perform following actions in Custom Attribute Page
      | Actiontype          | ActionItem            | ItemName       | Section   |
      | Click ItemTypes     | BusinessApplication   |                |           |
      | Click ItemTypes Tab | Custom Attributes     | Tabvalue       |           |
      | Click ItemTypes Tab | Add Custom Attributes |                |           |
      | Enter and Edit      |                       | custom,default | EnterText |
    And users performs following actions in Manage access
      | Actiontype                    | ActionItem  | ItemName          | Section |
      | Enter Text in User and Groups | Enter name  | ArrayofStringtype |         |
      | Enter Text in User and Groups | Enter label | ArrayofStringtype |         |
    And user perform following actions in Custom Attribute Page
      | Actiontype      | ActionItem      | ItemName         | Section  |
      | Select Dropdown | Select datatype | ARRAY OF STRINGS | DataType |
      | Select Dropdown | Select tab      | Business         |          |
    And user "click" on "Save" button in "Manage users and groups Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                   | ActionItem | ItemName          | Section |
      | Verify Column Value Contains | Name       | ArrayofStringtype |         |


  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#8_Verify if user can create custom Attributes Datatype as date
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Itemtypes and Attributes" in "Landing page"
    And user perform following actions in Custom Attribute Page
      | Actiontype          | ActionItem            | ItemName | Section |
      | Click ItemTypes     | BusinessApplication   |          |         |
      | Click ItemTypes Tab | Custom Attributes     | Tabvalue |         |
      | Click ItemTypes Tab | Add Custom Attributes |          |         |
    And users performs following actions in Manage access
      | Actiontype                    | ActionItem  | ItemName | Section |
      | Enter Text in User and Groups | Enter name  | Datetype |         |
      | Enter Text in User and Groups | Enter label | Datetype |         |
    And user perform following actions in Custom Attribute Page
      | Actiontype      | ActionItem      | ItemName                 | Section  |
      | Select Dropdown | Select datatype | STANDARD ZONED DATE/TIME | DataType |
      | Select Dropdown | Select tab      | Business                 |          |
    And user "click" on "Save" button in "Manage users and groups Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                   | ActionItem | ItemName | Section |
      | Verify Column Value Contains | Name       | Datetype |         |

  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#9_Verify if user can map Custom Attributesto BA
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_Dashboard" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_Dashboard" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem | ItemName |
      | Edit Icon BusinessTab |            |          |
    And user perform following actions in Custom Attribute Page
      | Actiontype     | ActionItem | ItemName | Section           | Actionname    |
      | Enter and Edit | number     |          | BA Edit and click | TestCustomINT |
    And user press "ARROW_UP" key using key press event
    And user perform following actions in Custom Attribute Page
      | Actiontype     | ActionItem | ItemName | Section                   | Actionname        |
      | Enter and Edit |            |          | BA Edit and  click Toggle | TestCustomBoolean |
    And User performs following actions in the Item view Page
      | Actiontype                 | ActionItem        | ItemName |
      | Select Dropdown of Details | ArrayofStringtype | custom   |
    And user perform following actions in Custom Attribute Page
      | Actiontype     | ActionItem | ItemName   | Section | Actionname |
      | Enter and Edit | date       | 11/20/2020 | BA Edit | Datetype   |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem | ItemName |
      | Click      | Save       |          |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem        | ItemName   |
      | Verify presence of Dropdown Values | TestCustomINT     | 1          |
      | Verify presence of Dropdown Values | TestCustomBoolean | true       |
      | Verify presence of Dropdown Values | TestCustom        | one        |
      | Verify presence of Dropdown Values | ArrayofStringtype | custom     |
      | Verify presence of Dropdown Values | Datetype          | 2020-11-20 |

# 7186725
  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#10_Verify if user is Edit the custom Attributes for array of strings datatype
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Itemtypes and Attributes" in "Landing page"
    And user perform following actions in Custom Attribute Page
      | Actiontype          | ActionItem          | ItemName | Section |
      | Click ItemTypes     | BusinessApplication |          |         |
      | Click ItemTypes Tab | Custom Attributes   | Tabvalue |         |
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem | ItemName               | Section |
      | Click Edit,Clone,Run,Download and Delete | TestCustom | Edit the configuration |         |
    And user perform following actions in Custom Attribute Page
      | Actiontype      | ActionItem | ItemName     | Section |
      | Select Dropdown | Business   | Architecture |         |
    And user "click" on "Save" button in "Manage users and groups Page"


  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#11_Verify if user can able to see custom attribute in architecture tab
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_Dashboard" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_Dashboard" item from search results
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem   | ItemName |
      | click to Tab | Architecture |          |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem | ItemName  |
      | Verify presence of Dropdown Values | TestCustom | customone |

  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#12_Verify if user is Edit the custom Attributes for array of strings datatype
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Itemtypes and Attributes" in "Landing page"
    And user perform following actions in Custom Attribute Page
      | Actiontype          | ActionItem          | ItemName | Section |
      | Click ItemTypes     | BusinessApplication |          |         |
      | Click ItemTypes Tab | Custom Attributes   | Tabvalue |         |
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem | ItemName               | Section |
      | Click Edit,Clone,Run,Download and Delete | TestCustom | Edit the configuration |         |
    And user perform following actions in Custom Attribute Page
      | Actiontype      | ActionItem   | ItemName | Section |
      | Select Dropdown | Architecture | Support  |         |
    And user "click" on "Save" button in "Manage users and groups Page"

  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#13_Verify if user can able to see custom attribute in Support tab
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_Dashboard" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_Dashboard" item from search results
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | ItemName |
      | click to Tab | Support    |          |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem | ItemName |
      | Verify presence of Dropdown Values | TestCustom | one      |

  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#14_Verify if user is Edit the custom Attributes for array of strings datatype
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Itemtypes and Attributes" in "Landing page"
    And user perform following actions in Custom Attribute Page
      | Actiontype          | ActionItem          | ItemName | Section |
      | Click ItemTypes     | BusinessApplication |          |         |
      | Click ItemTypes Tab | Custom Attributes   | Tabvalue |         |
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem | ItemName               | Section |
      | Click Edit,Clone,Run,Download and Delete | TestCustom | Edit the configuration |         |
    And user perform following actions in Custom Attribute Page
      | Actiontype      | ActionItem | ItemName | Section |
      | Select Dropdown | Support    | Security |         |
    And user "click" on "Save" button in "Manage users and groups Page"

  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#15_Verify if user can able to see custom attribute in Security tab
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_Dashboard" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_Dashboard" item from search results
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | ItemName |
      | click to Tab | Security   |          |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem | ItemName |
      | Verify presence of Dropdown Values | TestCustom | one      |

 # 7186725
  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#16_Verify if user is Edit the custom Attributes for array of strings datatype
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Itemtypes and Attributes" in "Landing page"
    And user perform following actions in Custom Attribute Page
      | Actiontype          | ActionItem          | ItemName | Section |
      | Click ItemTypes     | BusinessApplication |          |         |
      | Click ItemTypes Tab | Custom Attributes   | Tabvalue |         |
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem | ItemName               | Section |
      | Click Edit,Clone,Run,Download and Delete | TestCustom | Edit the configuration |         |
    And user perform following actions in Custom Attribute Page
      | Actiontype      | ActionItem | ItemName   | Section |
      | Select Dropdown | Security   | Compliance |         |
    And user "click" on "Save" button in "Manage users and groups Page"

  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#17_Verify if user can able to see custom attribute in Compliance tab
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_Dashboard" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_Dashboard" item from search results
    And User performs following actions in the Item view Page
      | Actiontype   | ActionItem | ItemName |
      | click to Tab | Compliance |          |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem | ItemName  |
      | Verify presence of Dropdown Values | TestCustom | customone |


  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#18_Verify if user can map Custom Attributesto BA
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "BA_Dashboard" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "BA_Dashboard" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem | ItemName |
      | Edit Icon BusinessTab |            |          |
    And user perform following actions in Custom Attribute Page
      | Actiontype     | ActionItem | ItemName   | Section | Actionname |
      | Enter and Edit | date       | 02/20/2020 | BA Edit | Datetype   |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem | ItemName |
      | Click      | Save       |          |
    And User performs following actions in the Item view Page
      | Actiontype                         | ActionItem | ItemName  |
      | Verify presence of Dropdown Values | Datetype   | 2020-02-20 |


  @MLP-26093 @webtest @regression @positive
  Scenario:MLP-26099:SC#19_Delete CA
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Itemtypes and Attributes" in "Landing page"
    And user perform following actions in Custom Attribute Page
      | Actiontype          | ActionItem          | ItemName | Section |
      | Click ItemTypes     | BusinessApplication |          |         |
      | Click ItemTypes Tab | Custom Attributes   | Tabvalue |         |
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem    | ItemName                 | Section |
      | Click Edit,Clone,Run,Download and Delete | TestCustomINT | Delete the configuration |         |
    And user "click" on "Confirm" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem | ItemName                 | Section |
      | Click Edit,Clone,Run,Download and Delete | Datetype   | Delete the configuration |         |
    And user "click" on "Confirm" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem        | ItemName                 | Section |
      | Click Edit,Clone,Run,Download and Delete | TestCustomBoolean | Delete the configuration |         |
    And user "click" on "Confirm" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem | ItemName                 | Section |
      | Click Edit,Clone,Run,Download and Delete | TestCustom | Delete the configuration |         |
    And user "click" on "Confirm" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem        | ItemName                 | Section |
      | Click Edit,Clone,Run,Download and Delete | ArrayofStringtype | Delete the configuration |         |
    And user "click" on "Confirm" for "Manage Excel Imports" in "Landing page"


  Scenario:Delete the BA Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type                | query | param |
      | SingleItemDelete | Default | BA_Dashboard | BusinessApplication |       |       |