@MLP-18397
Feature:MLP_18397_MLP_21160_MLP_21162_MLP_21165_MLP_26031_MLP_27342_To Verify the Functionality of Excel Importer



 #6959547
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#1_Verification of hint text for Excel Importer pop over.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Manage Excel Imports |
    And user "verifies presence" of following "Page Subtitle" in "Manage Excel Imports" page
      | Create, Edit and Run Excel Imports. |

  # 6959548
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#2_Verify the SAVE button is disabled by default.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user verifies the "Excel Importer" pop up is "displayed"
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"

  # 6959549
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#3_Verification of Cancel button functionalilty in the Excel Importer pop over.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user verifies the "Excel Importer" pop up is "displayed"
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem |
      | Excel Importer Name | ImportOne  |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | BusinessApplications.xlsx |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "click" on "Cancel button" button in "Excel Importer Page"
    And user "click" on "No" button in "Popup Window"
    And user "click" on "Cancel button" button in "Excel Importer Page"
    And user "click" on "Yes" button in "Popup Window"

   # 6959550
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#4_Verification of Close button functionalilty in the Excel Importer pop over.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user verifies the "Excel Importer" pop up is "displayed"
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem |
      | Excel Importer Name | ImportOne  |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | BusinessApplications.xlsx |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "click" on "Close button" button in "Excel Importer Page"
    And user "click" on "No" button in "Popup Window"
    And user "click" on "Close button" button in "Excel Importer Page"
    And user "click" on "Yes" button in "Popup Window"

    # 6959551
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#5_Verify that the user is able to upload a jpg/png/jpeg (Unsupported Types) files.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user verifies the "Excel Importer" pop up is "displayed"
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem               |
      | Excel Importer Name | ImportUnsupportedFormat  |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action         |
      | setAutoDelay    | 1000           |
      | selectExcelFile | Test_Image.jpg |
      | setAutoDelay    | 1000           |
      | keyPress        | CONTROL        |
      | keyPress        | V              |
      | keyRelease      | CONTROL        |
      | keyRelease      | V              |
      | setAutoDelay    | 1000           |
      | keyPress        | ENTER          |
      | keyRelease      | ENTER          |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                       |
      | Verify Alert Message | Please upload the Excel with xls/xlsx extensions |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"

   # 6959552
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#6_Verification of importing an xlsx file for Business Application types.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem |
      | Excel Importer Name | ImportOne  |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | BusinessApplications.xlsx |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                      |
      | Verify Alert Message | Successful upload of BusinessApplications.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem  | ItemName    | Section          |
      | Select Dropdown | Name        | Name        | In Mapping Value |
      | Select Dropdown | Description | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | ImportOne  | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName                  | SheetNumber | WithColumnName |
      | BusinessApplications.xlsx | 0           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Test Designer" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem    |
      | Verify Item Full View | Test Designer |

    # 6973296
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#7_Verification of importing an xls file for Business Application types.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem |
      | Excel Importer Name | ImportTwo  |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                   |
      | setAutoDelay    | 1000                     |
      | selectExcelFile | BusinessApplications.xls |
      | setAutoDelay    | 1000                     |
      | keyPress        | CONTROL                  |
      | keyPress        | V                        |
      | keyRelease      | CONTROL                  |
      | keyRelease      | V                        |
      | setAutoDelay    | 1000                     |
      | keyPress        | ENTER                    |
      | keyRelease      | ENTER                    |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                     |
      | Verify Alert Message | Successful upload of BusinessApplications.xls. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem  | ItemName    | Section          |
      | Select Dropdown | Name        | Name        | In Mapping Value |
      | Select Dropdown | Description | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | ImportTwo  | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName                 | SheetNumber | WithColumnName |
      | BusinessApplications.xls | 0           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Travel Apps" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem  |
      | Verify Item Full View | Travel Apps |

 # 6959561
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#8_Verification of importing the same xlsx file which is already imported as a Business Application type.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user verifies the "Excel Importer" pop up is "displayed"
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem  |
      | Excel Importer Name | ImportThree |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | BusinessApplications.xlsx |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                      |
      | Verify Alert Message | Successful upload of BusinessApplications.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem  | ItemName    | Section          |
      | Select Dropdown | Name        | Name        | In Mapping Value |
      | Select Dropdown | Description | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem  | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | ImportThree | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName                  | SheetNumber | WithColumnName |
      | BusinessApplications.xlsx | 0           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Test Designer" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem    |
      | Verify Item Full View | Test Designer |

    # 6959562
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#9_Verification of importing the same xls file which is already imported as a Business Application type.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem |
      | Excel Importer Name | ImportFour |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                   |
      | setAutoDelay    | 1000                     |
      | selectExcelFile | BusinessApplications.xls |
      | setAutoDelay    | 1000                     |
      | keyPress        | CONTROL                  |
      | keyPress        | V                        |
      | keyRelease      | CONTROL                  |
      | keyRelease      | V                        |
      | setAutoDelay    | 1000                     |
      | keyPress        | ENTER                    |
      | keyRelease      | ENTER                    |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                     |
      | Verify Alert Message | Successful upload of BusinessApplications.xls. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem  | ItemName    | Section          |
      | Select Dropdown | Name        | Name        | In Mapping Value |
      | Select Dropdown | Description | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | ImportFour | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName                 | SheetNumber | WithColumnName |
      | BusinessApplications.xls | 0           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Travel Apps" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem  |
      | Verify Item Full View | Travel Apps |

  Scenario Outline:SC#9_User Retrives Item id  and copy to a json file "Business Application"
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                | type                | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | Default | Test User           | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_1.id |
      | APPDBPOSTGRES | Default | Test Designer       | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_2.id |
      | APPDBPOSTGRES | Default | Travel Apps         | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_3.id |
      | APPDBPOSTGRES | Default | Communication Apps  | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_4.id |
      | APPDBPOSTGRES | Default | Mobile Payment Apps | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_5.id |
      | APPDBPOSTGRES | Default | Mind-Mapping Apps   | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_6.id |

  Scenario Outline:SC#9_User Deletes the item from database using dynamic id stored in json "Business Application"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                   | inputFile                                     |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_1.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_2.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_3.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_4.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_5.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_6.id | payloads\idc\BusinessApplication\itemIds.json |

  ## Failed due to bug - MLP-25973
   # 6959632
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#10_Verification of importing an xlsx file with one column name missing.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem              |
      | Excel Importer Name | ImportColumnMissingXLSX |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | OneColumNameMissing.xlsx. |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                     |
      | Verify Alert Message | Successful upload of OneColumNameMissing.xlsx. |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName | Section  |
      | Select Dropdown | Sheet Name | Sheet1   | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                                                                        |
      | Verify PopUp Message | Excel file: OneColumNameMissing.xlsx - Sheet Name: Sheet1 - Column name not defined for column: A |

   ## Failed due to bug - MLP-25973
    # 6959633
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#11_Verification of importing an xls file with one column name missing.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem             |
      | Excel Importer Name | ImportColumnMissingXLS |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                   |
      | setAutoDelay    | 1000                     |
      | selectExcelFile | OneColumnNameMissing.xls |
      | setAutoDelay    | 1000                     |
      | keyPress        | CONTROL                  |
      | keyPress        | V                        |
      | keyRelease      | CONTROL                  |
      | keyRelease      | V                        |
      | setAutoDelay    | 1000                     |
      | keyPress        | ENTER                    |
      | keyRelease      | ENTER                    |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                     |
      | Verify Alert Message | Successful upload of OneColumnNameMissing.xls. |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName | Section  |
      | Select Dropdown | Sheet Name | Sheet1   | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                                                                        |
      | Verify PopUp Message | Excel file: OneColumnNameMissing.xls - Sheet Name: Sheet1 - Column name not defined for column: 1 |

    # 6959690
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#12_Verification of importing an xlsx file with no column name.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem       |
      | Excel Importer Name | NoColumnNameXLSX |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action            |
      | setAutoDelay    | 1000              |
      | selectExcelFile | NoColumnName.xlsx |
      | setAutoDelay    | 1000              |
      | keyPress        | CONTROL           |
      | keyPress        | V                 |
      | keyRelease      | CONTROL           |
      | keyRelease      | V                 |
      | setAutoDelay    | 1000              |
      | keyPress        | ENTER             |
      | keyRelease      | ENTER             |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                              |
      | Verify Alert Message | Successful upload of NoColumnName.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName    | Section          |
      | Select Dropdown | ColumnA    | Name        | In Mapping Value |
      | Select Dropdown | ColumnB    | Description | In Mapping Value |
      | Select Dropdown | ColumnC    | Acronym     | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem       | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | NoColumnNameXLSX | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName          | SheetNumber | WithColumnName |
      | NoColumnName.xlsx | 0           | No             |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Xero" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem |
      | Verify Item Full View | Xero       |

    # 6959793
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#13_Verification of importing an xls file with no column name.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem      |
      | Excel Importer Name | NoColumnNameXLS |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action           |
      | setAutoDelay    | 1000             |
      | selectExcelFile | NoColumnName.xls |
      | setAutoDelay    | 1000             |
      | keyPress        | CONTROL          |
      | keyPress        | V                |
      | keyRelease      | CONTROL          |
      | keyRelease      | V                |
      | setAutoDelay    | 1000             |
      | keyPress        | ENTER            |
      | keyRelease      | ENTER            |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                             |
      | Verify Alert Message | Successful upload of NoColumnName.xls. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName    | Section          |
      | Select Dropdown | ColumnA    | Name        | In Mapping Value |
      | Select Dropdown | ColumnB    | Description | In Mapping Value |
      | Select Dropdown | ColumnC    | Acronym     | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem      | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | NoColumnNameXLS | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName         | SheetNumber | WithColumnName |
      | NoColumnName.xls | 0           | No             |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Enterprise-specific Apps" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem               |
      | Verify Item Full View | Enterprise-specific Apps |

  Scenario Outline:SC#13_User Retrives Item id  and copy to a json file "Business Application"
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                  | type                | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | Default | Xero                                  | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_1.id |
      | APPDBPOSTGRES | Default | TaxJar                                | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_2.id |
      | APPDBPOSTGRES | Default | Bench                                 | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_3.id |
      | APPDBPOSTGRES | Default | Tools and Utility Apps for Businesses | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_4.id |
      | APPDBPOSTGRES | Default | Enterprise-specific Apps              | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_5.id |


  Scenario Outline:SC#13_User Deletes the item from database using dynamic id stored in json "Business Application"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                   | inputFile                                     |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_1.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_2.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_3.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_4.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_5.id | payloads\idc\BusinessApplication\itemIds.json |

  # 6959929
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#14_Verification of importing an xlsx file with new line character.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem        |
      | Excel Importer Name | BAWithNewLineXLSX |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action             |
      | setAutoDelay    | 1000               |
      | selectExcelFile | BAWithNewLine.xlsx |
      | setAutoDelay    | 1000               |
      | keyPress        | CONTROL            |
      | keyPress        | V                  |
      | keyRelease      | CONTROL            |
      | keyRelease      | V                  |
      | setAutoDelay    | 1000               |
      | keyPress        | ENTER              |
      | keyRelease      | ENTER              |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                               |
      | Verify Alert Message | Successful upload of BAWithNewLine.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem  | ItemName    | Section          |
      | Select Dropdown | Name        | Name        | In Mapping Value |
      | Select Dropdown | Description | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem         | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | BAWithNewLineXLSX  | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName           | SheetNumber | WithColumnName |
      | BAWithNewLine.xlsx | 0           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Yield" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem |
      | Verify Item Full View | Yield      |

    # 6959930
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#15_Verification of importing an xls file with new line character.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem       |
      | Excel Importer Name | BAWithNewLineXLS |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action            |
      | setAutoDelay    | 1000              |
      | selectExcelFile | BAWithNewLine.xls |
      | setAutoDelay    | 1000              |
      | keyPress        | CONTROL           |
      | keyPress        | V                 |
      | keyRelease      | CONTROL           |
      | keyRelease      | V                 |
      | setAutoDelay    | 1000              |
      | keyPress        | ENTER             |
      | keyRelease      | ENTER             |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                              |
      | Verify Alert Message | Successful upload of BAWithNewLine.xls. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem  | ItemName    | Section          |
      | Select Dropdown | Name        | Name        | In Mapping Value |
      | Select Dropdown | Description | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem        | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | BAWithNewLineXLS  | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName          | SheetNumber | WithColumnName |
      | BAWithNewLine.xls | 0           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Call for \nProposal" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem          |
      | Verify Item Full View | Call for \nProposal |

  Scenario Outline:SC#15_User Retrives Item id  and copy to a json file "Business Application"
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                     | type                | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | Default | Zero interest rates      | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_1.id |
      | APPDBPOSTGRES | Default | Zombie funds             | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_2.id |
      | APPDBPOSTGRES | Default | Yield                    | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_3.id |
      | APPDBPOSTGRES | Default | Yen carry trade          | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_4.id |
      | APPDBPOSTGRES | Default | Channel Partner          | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_5.id |
      | APPDBPOSTGRES | Default | Champion/Challenger Test | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_6.id |

  Scenario Outline:SC#15_User Deletes the item from database using dynamic id stored in json "Business Application"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                   | inputFile                                     |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_1.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_2.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_3.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_4.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_5.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_6.id | payloads\idc\BusinessApplication\itemIds.json |

    # 6960055#7248147
  @MLP-18397 @webtest @regression @positive @e2e
  Scenario:MLP-18397:SC#16_Verification of importing an xls file with column name has space.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem             |
      | Excel Importer Name | ColumnNameWithSpaceXLS |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                  |
      | setAutoDelay    | 1000                    |
      | selectExcelFile | ColumnNameWithSpace.xls |
      | setAutoDelay    | 1000                    |
      | keyPress        | CONTROL                 |
      | keyPress        | V                       |
      | keyRelease      | CONTROL                 |
      | keyRelease      | V                       |
      | setAutoDelay    | 1000                    |
      | keyPress        | ENTER                   |
      | keyRelease      | ENTER                   |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                    |
      | Verify Alert Message | Successful upload of ColumnNameWithSpace.xls. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem                     | ItemName    | Section          |
      | Select Dropdown | Name of the Application        | Name        | In Mapping Value |
      | Select Dropdown | Description of the Application | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem              | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | ColumnNameWithSpaceXLS  | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName                | SheetNumber | WithColumnName |
      | ColumnNameWithSpace.xls | 0           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Chargify" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem |
      | Verify Item Full View | Chargify   |

    # 6960056
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#17_Verification of importing an xlsx file with column name has space.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem              |
      | Excel Importer Name | ColumnNameWithSpaceXLSX |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                   |
      | setAutoDelay    | 1000                     |
      | selectExcelFile | ColumnNameWithSpace.xlsx |
      | setAutoDelay    | 1000                     |
      | keyPress        | CONTROL                  |
      | keyPress        | V                        |
      | keyRelease      | CONTROL                  |
      | keyRelease      | V                        |
      | setAutoDelay    | 1000                     |
      | keyPress        | ENTER                    |
      | keyRelease      | ENTER                    |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                     |
      | Verify Alert Message | Successful upload of ColumnNameWithSpace.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem                     | ItemName    | Section          |
      | Select Dropdown | Name of the Application        | Name        | In Mapping Value |
      | Select Dropdown | Description of the Application | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem               | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | ColumnNameWithSpaceXLSX  | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName                 | SheetNumber | WithColumnName |
      | ColumnNameWithSpace.xlsx | 0           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Workday" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem |
      | Verify Item Full View | Workday    |

  Scenario Outline:SC#17_User Retrives Item id  and copy to a json file "Business Application"
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name        | type                | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | Default | Chargify    | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_1.id |
      | APPDBPOSTGRES | Default | Hiveage     | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_2.id |
      | APPDBPOSTGRES | Default | Jobber      | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_3.id |
      | APPDBPOSTGRES | Default | When I Work | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_4.id |
      | APPDBPOSTGRES | Default | Humanity    | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_5.id |
      | APPDBPOSTGRES | Default | Workday     | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_6.id |

  Scenario Outline:SC#17_User Deletes the item from database using dynamic id stored in json "Business Application"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                   | inputFile                                     |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_1.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_2.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_3.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_4.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_5.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_6.id | payloads\idc\BusinessApplication\itemIds.json |

   # 6960061
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#18_Verification of importing an xlsx file with blank column values for Business Application type.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem                 |
      | Excel Importer Name | ColumnValuesWithBlanksXLSX |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                      |
      | setAutoDelay    | 1000                        |
      | selectExcelFile | ColumnValuesWithBlanks.xlsx |
      | setAutoDelay    | 1000                        |
      | keyPress        | CONTROL                     |
      | keyPress        | V                           |
      | keyRelease      | CONTROL                     |
      | keyRelease      | V                           |
      | setAutoDelay    | 1000                        |
      | keyPress        | ENTER                       |
      | keyRelease      | ENTER                       |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                        |
      | Verify Alert Message | Successful upload of ColumnValuesWithBlanks.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem  | ItemName    | Section          |
      | Select Dropdown | Name        | Name        | In Mapping Value |
      | Select Dropdown | Description | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem                  | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | ColumnValuesWithBlanksXLSX  | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName                    | SheetNumber | WithColumnName |
      | ColumnValuesWithBlanks.xlsx | 0           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Test Informer" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem    |
      | Verify Item Full View | Test Informer |

    # 6960062
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#19_Verification of importing an xls file with blank column values for Business Application type.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem                |
      | Excel Importer Name | ColumnValuesWithBlanksXLS |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                     |
      | setAutoDelay    | 1000                       |
      | selectExcelFile | ColumnValuesWithBlanks.xls |
      | setAutoDelay    | 1000                       |
      | keyPress        | CONTROL                    |
      | keyPress        | V                          |
      | keyRelease      | CONTROL                    |
      | keyRelease      | V                          |
      | setAutoDelay    | 1000                       |
      | keyPress        | ENTER                      |
      | keyRelease      | ENTER                      |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                       |
      | Verify Alert Message | Successful upload of ColumnValuesWithBlanks.xls. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem  | ItemName    | Section          |
      | Select Dropdown | Name        | Name        | In Mapping Value |
      | Select Dropdown | Description | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem                | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | ColumnValuesWithBlanksXLS | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName                   | SheetNumber | WithColumnName |
      | ColumnValuesWithBlanks.xls | 0           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Testing Profile" item from search results
    And User performs following actions in the Item view Page
      | Actiontype            | ActionItem      |
      | Verify Item Full View | Testing Profile |

  Scenario Outline:SC#19_User Retrieves Item id  and copy to a json file "Business Application"
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name            | type                | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | Default | Test Guider     | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_1.id |
      | APPDBPOSTGRES | Default | Test Informer   | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_2.id |
      | APPDBPOSTGRES | Default | Testing Profile | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_3.id |
      | APPDBPOSTGRES | Default | Manual Tester   | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_4.id |

  Scenario Outline:SC#19_User Deletes the item from database using dynamic id stored in json "Business Application"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                   | inputFile                                     |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_1.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_2.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_3.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_4.id | payloads\idc\BusinessApplication\itemIds.json |

    # 6960068   # 6960069
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#20_1_Verification of importing an updated xlsx file with new Business Application values.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem                |
      | Excel Importer Name | BASheetBeforeUpdationXLSX |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                     |
      | setAutoDelay    | 1000                       |
      | selectExcelFile | BASheetBeforeUpdation.xlsx |
      | setAutoDelay    | 1000                       |
      | keyPress        | CONTROL                    |
      | keyPress        | V                          |
      | keyRelease      | CONTROL                    |
      | keyRelease      | V                          |
      | setAutoDelay    | 1000                       |
      | keyPress        | ENTER                      |
      | keyRelease      | ENTER                      |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                       |
      | Verify Alert Message | Successful upload of BASheetBeforeUpdation.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem           | ItemName                        | Section          |
      | Select Dropdown | Name                 | Name                            | In Mapping Value |
      | Select Dropdown | Acronym              | Acronym                         | In Mapping Value |
      | Select Dropdown | ApplicationId        | Application ID                  | In Mapping Value |
      | Select Dropdown | IntExt               | Internal/External (Third Party) | In Mapping Value |
      | Select Dropdown | Authoritative Source | Authoritative Source            | In Mapping Value |
      | Select Dropdown | Locations            | Location                        | In Mapping Value |
      | Select Dropdown | Data Classification  | Data Classification             | In Mapping Value |
      | Select Dropdown | DataDomain           | Data Domain                     | In Mapping Value |
      | Select Dropdown | PII                  | Personal Data                   | In Mapping Value |
      | Select Dropdown | UsersCount           | # of Users                      | In Mapping Value |
      | Select Dropdown | Description          | Description                     | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem                | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | BASheetBeforeUpdationXLSX | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName                   | SheetNumber | WithColumnName |
      | BASheetBeforeUpdation.xlsx | 0           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Time Management Software" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                  | ActionItem          | ItemName   |
      | Verify Details Widget Value | Data Classification | Restricted |
      | Verify Details Widget Value | Data Domain         | Marketing  |

 # 6960068
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#20_2_Verification of importing an updated xlsx file with new Business Application values.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem               |
      | Excel Importer Name | BASheetAfterUpdationXLSX |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | BASheetAfterUpdation.xlsx |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                      |
      | Verify Alert Message | Successful upload of BASheetAfterUpdation.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem           | ItemName                        | Section          |
      | Select Dropdown | Name                 | Name                            | In Mapping Value |
      | Select Dropdown | Acronym              | Acronym                         | In Mapping Value |
      | Select Dropdown | ApplicationId        | Application ID                  | In Mapping Value |
      | Select Dropdown | IntExt               | Internal/External (Third Party) | In Mapping Value |
      | Select Dropdown | Authoritative Source | Authoritative Source            | In Mapping Value |
      | Select Dropdown | Locations            | Location                        | In Mapping Value |
      | Select Dropdown | Data Classification  | Data Classification             | In Mapping Value |
      | Select Dropdown | DataDomain           | Data Domain                     | In Mapping Value |
      | Select Dropdown | PII                  | Personal Data                   | In Mapping Value |
      | Select Dropdown | UsersCount           | # of Users                      | In Mapping Value |
      | Select Dropdown | Description          | Description                     | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem                | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | BASheetAfterUpdationXLSX  | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName                  | SheetNumber | WithColumnName |
      | BASheetAfterUpdation.xlsx | 0           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Time Management Software" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                  | ActionItem          | ItemName     |
      | Verify Details Widget Value | Data Classification | Confidential |
      | Verify Details Widget Value | Data Domain         | HR           |

  Scenario Outline:SC#20_3_User Retrieves Item id  and copy to a json file "Business Application"
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                      | type                | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | Default | Productivity Software     | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_1.id |
      | APPDBPOSTGRES | Default | Time Management Software  | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_2.id |
      | APPDBPOSTGRES | Default | Educational Software      | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_3.id |
      | APPDBPOSTGRES | Default | Test Business Application | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_4.id |

  Scenario Outline:SC#20_3_User Deletes the item from database using dynamic id stored in json "Business Application"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                   | inputFile                                     |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_1.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_2.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_3.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_4.id | payloads\idc\BusinessApplication\itemIds.json |

 # 6960069
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#21_1_Verification of importing an updated xls file with new Business Application values.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem          |
      | Excel Importer Name | BABeforeUpdationXLS |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action               |
      | setAutoDelay    | 1000                 |
      | selectExcelFile | BABeforeUpdation.xls |
      | setAutoDelay    | 1000                 |
      | keyPress        | CONTROL              |
      | keyPress        | V                    |
      | keyRelease      | CONTROL              |
      | keyRelease      | V                    |
      | setAutoDelay    | 1000                 |
      | keyPress        | ENTER                |
      | keyRelease      | ENTER                |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                 |
      | Verify Alert Message | Successful upload of BABeforeUpdation.xls. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem          | ItemName            | Section          |
      | Select Dropdown | Name                | Name                | In Mapping Value |
      | Select Dropdown | Acronym             | Acronym             | In Mapping Value |
      | Select Dropdown | ApplicationId       | Application ID      | In Mapping Value |
      | Select Dropdown | Locations           | Location            | In Mapping Value |
      | Select Dropdown | Data Classification | Data Classification | In Mapping Value |
      | Select Dropdown | DataDomain          | Data Domain         | In Mapping Value |
      | Select Dropdown | PII                 | Personal Data       | In Mapping Value |
      | Select Dropdown | UsersCount          | # of Users          | In Mapping Value |
      | Select Dropdown | Description         | Description         | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem           | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | BABeforeUpdationXLS  | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName             | SheetNumber | WithColumnName |
      | BABeforeUpdation.xls | 0           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Travel Apps" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                  | ActionItem  | ItemName                                                                                                     |
      | Verify Details Widget Value | Users       | 20                                                                                                           |
      | Verifies Item Presence      | Description | Travel being an important part of every person's life, these apps finds a lot of relevance in today's world. |

 # 6960069
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#21_2_Verification of importing an updated xls file with new Business Application values.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem         |
      | Excel Importer Name | BAAfterUpdationXLS |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action              |
      | setAutoDelay    | 1000                |
      | selectExcelFile | BAAfterUpdation.xls |
      | setAutoDelay    | 1000                |
      | keyPress        | CONTROL             |
      | keyPress        | V                   |
      | keyRelease      | CONTROL             |
      | keyRelease      | V                   |
      | setAutoDelay    | 1000                |
      | keyPress        | ENTER               |
      | keyRelease      | ENTER               |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                |
      | Verify Alert Message | Successful upload of BAAfterUpdation.xls. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem          | ItemName            | Section          |
      | Select Dropdown | Name                | Name                | In Mapping Value |
      | Select Dropdown | Acronym             | Acronym             | In Mapping Value |
      | Select Dropdown | ApplicationId       | Application ID      | In Mapping Value |
      | Select Dropdown | Locations           | Location            | In Mapping Value |
      | Select Dropdown | Data Classification | Data Classification | In Mapping Value |
      | Select Dropdown | DataDomain          | Data Domain         | In Mapping Value |
      | Select Dropdown | PII                 | Personal Data       | In Mapping Value |
      | Select Dropdown | UsersCount          | # of Users          | In Mapping Value |
      | Select Dropdown | Description         | Description         | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem          | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | BAAfterUpdationXLS  | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName            | SheetNumber | WithColumnName |
      | BAAfterUpdation.xls | 0           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Travel Apps" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                  | ActionItem  | ItemName        |
      | Verify Details Widget Value | Users       | 50              |
      | Verifies Item Presence      | Description | Part of Testing |

  Scenario Outline:SC#21_3_User Retrieves Item id  and copy to a json file "Business Application"
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                                  | type                | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | Default | Office Productivity Apps              | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_1.id |
      | APPDBPOSTGRES | Default | Travel Apps                           | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_2.id |
      | APPDBPOSTGRES | Default | Tools and Utility Apps for Businesses | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_3.id |
      | APPDBPOSTGRES | Default | Enterprise-specific Apps              | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_4.id |
      | APPDBPOSTGRES | Default | Communication Apps                    | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_5.id |

  Scenario Outline:SC#21_3_User Deletes the item from database using dynamic id stored in json "Business Application"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                   | inputFile                                     |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_1.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_2.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_3.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_4.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_5.id | payloads\idc\BusinessApplication\itemIds.json |

  # 6960071
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#22_Verification of importing an xls file for business application types with multiple sheet names.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem          |
      | Excel Importer Name | BAMultipleSheetsXLS |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action               |
      | setAutoDelay    | 1000                 |
      | selectExcelFile | BAMultipleSheets.xls |
      | setAutoDelay    | 1000                 |
      | keyPress        | CONTROL              |
      | keyPress        | V                    |
      | keyRelease      | CONTROL              |
      | keyRelease      | V                    |
      | setAutoDelay    | 1000                 |
      | keyPress        | ENTER                |
      | keyRelease      | ENTER                |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                 |
      | Verify Alert Message | Successful upload of BAMultipleSheets.xls. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype             | ActionItem | ItemName     |
      | Verify Dropdown Values | Sheet Name | BA Softwares |
      | Verify Dropdown Values | Sheet Name | BA Items     |
      | Verify Dropdown Values | Sheet Name | Test Items   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | BA Softwares        | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem           | ItemName                        | Section          |
      | Select Dropdown | Name                 | Name                            | In Mapping Value |
      | Select Dropdown | Acronym              | Acronym                         | In Mapping Value |
      | Select Dropdown | ApplicationId        | Application ID                  | In Mapping Value |
      | Select Dropdown | IntExt               | Internal/External (Third Party) | In Mapping Value |
      | Select Dropdown | Authoritative Source | Authoritative Source            | In Mapping Value |
      | Select Dropdown | Locations            | Location                        | In Mapping Value |
      | Select Dropdown | Data Classification  | Data Classification             | In Mapping Value |
      | Select Dropdown | DataDomain           | Data Domain                     | In Mapping Value |
      | Select Dropdown | PII                  | Personal Data                   | In Mapping Value |
      | Select Dropdown | UsersCount           | # of Users                      | In Mapping Value |
      | Select Dropdown | Description          | Description                     | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem           | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | BAMultipleSheetsXLS  | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName             | SheetNumber | WithColumnName |
      | BAMultipleSheets.xls | 1           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Time Management Software" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                  | ActionItem          | ItemName   |
      | Verify Details Widget Value | Data Classification | Restricted |
      | Verify Details Widget Value | Data Domain         | Marketing  |

    # 6960072
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#23_Verification of importing an xlsx file for business application types with multiple sheet names.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem           |
      | Excel Importer Name | BAMultipleSheetsXLSX |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                |
      | setAutoDelay    | 1000                  |
      | selectExcelFile | BAMultipleSheets.xlsx |
      | setAutoDelay    | 1000                  |
      | keyPress        | CONTROL               |
      | keyPress        | V                     |
      | keyRelease      | CONTROL               |
      | keyRelease      | V                     |
      | setAutoDelay    | 1000                  |
      | keyPress        | ENTER                 |
      | keyRelease      | ENTER                 |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                  |
      | Verify Alert Message | Successful upload of BAMultipleSheets.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype             | ActionItem | ItemName     |
      | Verify Dropdown Values | Sheet Name | BA Softwares |
      | Verify Dropdown Values | Sheet Name | BA Items     |
      | Verify Dropdown Values | Sheet Name | Test Items   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | BA Items            | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem           | ItemName             | Section          |
      | Select Dropdown | Name                 | Name                 | In Mapping Value |
      | Select Dropdown | ApplicationId        | Application ID       | In Mapping Value |
      | Select Dropdown | Locations            | Location             | In Mapping Value |
      | Select Dropdown | DataDomain           | Data Domain          | In Mapping Value |
      | Select Dropdown | PII                  | Personal Data        | In Mapping Value |
      | Select Dropdown | Description          | Description          | In Mapping Value |
      | Select Dropdown | Business Criticality | Business Criticality | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem            | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | BAMultipleSheetsXLSX  | Run the excel import  |         |
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And User Compare Imported Excel Items with UI Items
      | FileName              | SheetNumber | WithColumnName |
      | BAMultipleSheets.xlsx | 1           | Yes            |
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "CRM" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                  | ActionItem  | ItemName |
      | Verify Details Widget Value | Location    | France   |
      | Verify Details Widget Value | Data Domain | Finance  |

  Scenario Outline:SC#23_User Retrieves Item id  and copy to a json file "Business Application"
    Given user connects "<database>" and run query using "<catalog>" with "<name>" and "<type>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | catalog | name                     | type                | targetFile                                    | jsonpath                    |
      | APPDBPOSTGRES | Default | Productivity Software    | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_1.id |
      | APPDBPOSTGRES | Default | Time Management Software | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_2.id |
      | APPDBPOSTGRES | Default | Educational Software     | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_3.id |
      | APPDBPOSTGRES | Default | CAC                      | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_4.id |
      | APPDBPOSTGRES | Default | CRM                      | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_5.id |
      | APPDBPOSTGRES | Default | CSS                      | BusinessApplication | payloads\idc\BusinessApplication\itemIds.json | $..BusinessApplication_6.id |

  Scenario Outline:SC#23_User Deletes the item from database using dynamic id stored in json "Business Application"
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a delete request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>"
    Examples:
      | url                                                 | responseCode | inputJson                   | inputFile                                     |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_1.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_2.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_3.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_4.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_5.id | payloads\idc\BusinessApplication\itemIds.json |
      | items/Default/Default.BusinessApplication:::dynamic | 204          | $..BusinessApplication_6.id | payloads\idc\BusinessApplication\itemIds.json |

 # 6960073
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#24_Verification of importing an xls file for business application types by selecting same item attributes for column mapping.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem                 |
      | Excel Importer Name | SameNameMultipleMappingXLS |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                   |
      | setAutoDelay    | 1000                     |
      | selectExcelFile | BusinessApplications.xls |
      | setAutoDelay    | 1000                     |
      | keyPress        | CONTROL                  |
      | keyPress        | V                        |
      | keyRelease      | CONTROL                  |
      | keyRelease      | V                        |
      | setAutoDelay    | 1000                     |
      | keyPress        | ENTER                    |
      | keyRelease      | ENTER                    |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                     |
      | Verify Alert Message | Successful upload of BusinessApplications.xls. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem  | ItemName | Section          |
      | Select Dropdown | Name        | Name     | In Mapping Value |
      | Select Dropdown | Description | Name     | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                                                                                    |
      | Verify Error Message | Same Item Attribute cannot be mapped with multiple spreadsheet columns. Note - Name are mapped multiple times |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"


    # 6960074
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#25_Verification of importing an xlsx file for business application types by selecting same item attributes for column mapping.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem                  |
      | Excel Importer Name | SameNameMultipleMappingXLSX |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | BusinessApplications.xlsx |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                      |
      | Verify Alert Message | Successful upload of BusinessApplications.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem  | ItemName | Section          |
      | Select Dropdown | Name        | Name     | In Mapping Value |
      | Select Dropdown | Description | Name     | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                                                                                    |
      | Verify Error Message | Same Item Attribute cannot be mapped with multiple spreadsheet columns. Note - Name are mapped multiple times |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"

   # 6961293
  @MLP-18397 @webtest @regression @positive
  Scenario:MLP-18397:SC#26_Verification of "name" attribute validation for Excel Importer pop over
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem             |
      | Excel Importer Name | WithoutNameMappingXLSX |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | BusinessApplications.xlsx |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                      |
      | Verify Alert Message | Successful upload of BusinessApplications.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName    | Section          |
      | Select Dropdown | ColumnA    | Acronym     | In Mapping Value |
      | Select Dropdown | ColumnB    | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                                 |
      | Verify Error Message | Attribute, name should be mapped with a spreadsheet column |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"

    ##########################################################################################################################################

     ##7045773##7045774##7045775##7045778##
  @MLP-21160 @webtest @regression @positive
  Scenario: SC#1:21160: Verify if Admin menu has "Manage Excel Imports" label displayed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |
    And user "verifies presence" of following "Landed page Title is Bold" in "" page
      | Manage Excel Imports |
    And user "verifies presence" of following "Page Subtitle" in "Manage Excel Imports" page
      | Create, Edit and Run Excel Imports. |
    And user "verifies presence" of following "Column Names" in "Manage Excel Imports" page
      | Name              |
      | Imported Itemtype |
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user verifies the "Excel Importer" pop up is "displayed"

    ##7045781##
  @MLP-21160 @webtest @regression @positive
  Scenario:MLP-21160:SC#2 Upload an Excel file as Business Application type. Verify if after successful upload system redirects to "Manage Excel Imports" screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user verifies the "Excel Importer" pop up is "displayed"
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem            |
      | Excel Importer Name | SampleExcelFileUpload |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                     |
      | setAutoDelay    | 1000                       |
      | selectExcelFile | SampleExcelUploadFile.xlsx |
      | setAutoDelay    | 1000                       |
      | keyPress        | CONTROL                    |
      | keyPress        | V                          |
      | keyRelease      | CONTROL                    |
      | keyRelease      | V                          |
      | setAutoDelay    | 1000                       |
      | keyPress        | ENTER                      |
      | keyRelease      | ENTER                      |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName    | Section          |
      | Select Dropdown | ColumnA    | Name        | In Mapping Value |
      | Select Dropdown | ColumnB    | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And user verifies "Manage Excel Imports page" is "displayed"

    ##7045782##
  @MLP-21160 @webtest @regression @positive
  Scenario:MLP-21160:SC#3 Verify if the excel file 'Name' is displayed correct and 'Imported ItemType' is displayed as "Business Application"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                  | ActionItem        | ItemName                   |
      | verify column list contains | Name              | SampleExcelFileUpload.xlsx |
      | verify column list contains | Imported Itemtype | BusinessApplication        |

     ##7045783##7045784##
  @MLP-21160 @webtest @regression @positive
  Scenario:MLP-21160:SC#4 Upload an Excel file as 'Database' type. Verify if after successful upload system redirects to "Manage Excel Imports" screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user verifies the "Excel Importer" pop up is "displayed"
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem                  |
      | Excel Importer Name | SampleDatabaseTypeExcelFile |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action           |
      | setAutoDelay    | 1000             |
      | selectExcelFile | Sample File.xlsx |
      | setAutoDelay    | 1000             |
      | keyPress        | CONTROL          |
      | keyPress        | V                |
      | keyRelease      | CONTROL          |
      | keyRelease      | V                |
      | setAutoDelay    | 1000             |
      | keyPress        | ENTER            |
      | keyRelease      | ENTER            |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName | Section  |
      | Select Dropdown | Sheet Name | Database | As Input |
      | Select Dropdown | Item Type  | Database | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName    | Section          |
      | Select Dropdown | ColumnA    | Name        | In Mapping Value |
      | Select Dropdown | ColumnB    | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And user verifies "Manage Excel Imports page" is "displayed"
    And User performs following actions in the Excel Importer Page
      | Actiontype                  | ActionItem        | ItemName                    |
      | verify column list contains | Name              | SampleDatabaseTypeExcelFile |
      | verify column list contains | Imported Itemtype | Database                    |

    ##7045785##
  @MLP-21160 @webtest @regression @positive
  Scenario:MLP-21160:SC#5 Verify if Cancelling the Excel Import after uploading a file, redirects to Manage Excel Imports screen. Also the cancelled import excel sheet name should not be listed
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user verifies the "Excel Importer" pop up is "displayed"
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem             |
      | Excel Importer Name | SampleDatabaseTypeFile |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action           |
      | setAutoDelay    | 1000             |
      | selectExcelFile | Person Data.xlsx |
      | setAutoDelay    | 1000             |
      | keyPress        | CONTROL          |
      | keyPress        | V                |
      | keyRelease      | CONTROL          |
      | keyRelease      | V                |
      | setAutoDelay    | 1000             |
      | keyPress        | ENTER            |
      | keyRelease      | ENTER            |
    And user "click" on "Close button" button in "Excel Importer pop up"
    And user clicks on "Yes" link in the "Excel Importer pop up"
    And user verifies "Manage Excel Imports page" is "displayed"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem       |
      | verify column list not contains | Person Data.xlsx |

##################################################################################################################

  ## MLP-21162 - Verification reuse functionlaity in Excel Import##

  ##7083295##
  @MLP-21162 @webtest @regression @positive
  Scenario:SC#1:MLP-21162: Uploading an Excel file as Business Application type and verifying the successful upload
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user verifies the "Excel Importer" pop up is "displayed"
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem             |
      | Excel Importer Name | ReUseImportExcelUpload |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | BusinessApplications.xlsx |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And user "click" on "first row as column name checkbox" for "ReUseImportExcelUpload" in "Manage Excel Imports" page
    And user "click" on "Save" button in "Excel Importer Page"
    And user verifies "Manage Excel Imports page" is "displayed"
    And User performs following actions in the Excel Importer Page
      | Actiontype          | ActionItem             | ItemName              |
      | Verify Menu Buttons | ReUseImportExcelUpload | Edit the excel import |

    ##7083326##7083333##
  @MLP-21162 @webtest @regression @positive
  Scenario:SC#2:MLP-21162: Verify if clicking on the Reuse for an import function opens the 'Excel Importer' screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Edit the excel import" for "ReUseImportExcelUpload" in "Manage Excel Imports" page
    And user verifies the "Edit Excel Import" pop up is "displayed"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | BusinessApplications.xlsx |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem  | ItemName            |
      | Verify prepopulated value        | Sheet Name  | Sheet1              |
      | Verify prepopulated value        | Item Type   | BusinessApplication |
      | Verify prepopulated column value | Name        | Name                |
      | Verify prepopulated column value | Description | Description         |

  ##7083334##
  @MLP-21162 @webtest @regression @positive
  Scenario:SC#3:MLP-21162: Modify the excel sheet with New Column name and try to Reuse import > Verify if on uploading the excel file with new column name throws alert message
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Edit the excel import" for "ReUseImportExcelUpload" in "Manage Excel Imports" page
    And user verifies the "Edit Excel Import" pop up is "displayed"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                       |
      | setAutoDelay    | 1000                         |
      | selectExcelFile | ExcelWithDiffColumnName.xlsx |
      | setAutoDelay    | 1000                         |
      | keyPress        | CONTROL                      |
      | keyPress        | V                            |
      | keyRelease      | CONTROL                      |
      | keyRelease      | V                            |
      | setAutoDelay    | 1000                         |
      | keyPress        | ENTER                        |
      | keyRelease      | ENTER                        |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                              |
      | Verify Alert Message | Required Column Name does not exist in the Sheet Sheet1 |

  ##7083335##
  @MLP-21162 @webtest @regression @positive
  Scenario:SC#4:MLP-21162: Modify the excel sheet by removing a Column and try to Reuse import > Verify if on uploading the excel file with removed column throws alert message
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Edit the excel import" for "ReUseImportExcelUpload" in "Manage Excel Imports" page
    And user verifies the "Edit Excel Import" pop up is "displayed"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                     |
      | setAutoDelay    | 1000                       |
      | selectExcelFile | ExcelWithSingleColumn.xlsx |
      | setAutoDelay    | 1000                       |
      | keyPress        | CONTROL                    |
      | keyPress        | V                          |
      | keyRelease      | CONTROL                    |
      | keyRelease      | V                          |
      | setAutoDelay    | 1000                       |
      | keyPress        | ENTER                      |
      | keyRelease      | ENTER                      |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                              |
      | Verify Alert Message | Required Column Name does not exist in the Sheet Sheet1 |

    ##7083371##7083373##7083372##
  @MLP-21162 @webtest @regression @positive
  Scenario:SC#5:MLP-21162: Modify the excel sheet by adding a Column and try to Reuse import > Verify if on uploading the excel file with added column successfully pre-populates all the earlier mapped values displaying new column value
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Edit the excel import" for "ReUseImportExcelUpload" in "Manage Excel Imports" page
    And user verifies the "Edit Excel Import" pop up is "displayed"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                        |
      | setAutoDelay    | 1000                          |
      | selectExcelFile | ExcelWithDiffExtraColumn.xlsx |
      | setAutoDelay    | 1000                          |
      | keyPress        | CONTROL                       |
      | keyPress        | V                             |
      | keyRelease      | CONTROL                       |
      | keyRelease      | V                             |
      | setAutoDelay    | 1000                          |
      | keyPress        | ENTER                         |
      | keyRelease      | ENTER                         |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                          |
      | Verify Alert Message | Successful upload of ExcelWithDiffExtraColumn.xlsx. |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName | Section          |
      | Select Dropdown | Acronym    | Acronym  | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem              | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | ReUseImportExcelUpload  | Run the excel import  |         |
    And user verifies "Manage Excel Imports page" is "displayed"
    And user enters the search text "Test User" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Test User" item from search results
    And user verifies "Item view page title" is "Test User" in "Item View" page
    And User performs following actions in the Item view Page
      | Actiontype                  | ActionItem                                | ItemName  |
      | Verify Description Content  | Have access to control all functonalities |           |
      | Verify Details Widget Value | Acronym                                   | function1 |

  ##7083434##7083438##
  @MLP-21162 @webtest @regression @positive
  Scenario:SC#6:MLP-21162: Verify if user can see the Delete button for every import that appears in Manage Excel Imports screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Delete the excel import" for "ReUseImportExcelUpload" in "Manage Excel Imports" page
    And user "click" on "DELETE" button in "popup"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem             |
      | verify column list not contains | ReUseImportExcelUpload |

##################################################################################################################

  ## MLP-21165 - Verification of advancing mapping functionlaity in Excel Import##

  ##7083688##
  @MLP-21165 @webtest @regression @positive
  Scenario:SC#1:MLP-21165: Verify if user can upload an excel file and enter a name for upload (Attached Excel Used for Advanced Mapping)
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user verifies the "Excel Importer" pop up is "displayed"
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem                |
      | Excel Importer Name | AdvanceMappingExcelUpload |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | AdvanceMapping_Excel.xlsx |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                      |
      | Verify Alert Message | Successful upload of AdvanceMapping_Excel.xlsx. |

    ##7083689##7083690##7083692##
  @MLP-21165 @webtest @regression @positive
  Scenario:SC#2:MLP-21165: Verify if user can select sheet name as 'Database' and Item Type as 'Database'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user verifies the "Excel Importer" pop up is "displayed"
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem                |
      | Excel Importer Name | AdvanceMappingExcelUpload |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | AdvanceMapping_Excel.xlsx |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                      |
      | Verify Alert Message | Successful upload of AdvanceMapping_Excel.xlsx. |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName | Section  |
      | Select Dropdown | Sheet Name | Database | As Input |
      | Select Dropdown | Item Type  | Database | As Input |
    And user "click" on "first row as column name checkbox" for "AdvanceMappingExcelUpload" in "Manage Excel Imports" page
    And user "click" on "Advanced Mapping radio button" for "AdvanceMappingExcelUpload" in "Manage Excel Imports" page
    And User performs following actions in the Excel Importer Page
      | Actiontype             | ActionItem                          |
      | Verify Mapping Table   | Advanced Mapping                    |
      | Verify Mapping Columns | Spreadsheet columns,Item Attributes |

    ##7083696##7083697##7083698##7083699##
  @MLP-21165 @webtest @regression @positive
  Scenario:SC#3:MLP-21165: Verify if Column 'Description' field is as 'Attribute' and pre-selected as 'Description'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem                |
      | Excel Importer Name | AdvanceMappingExcelUpload |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | AdvanceMapping_Excel.xlsx |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                      |
      | Verify Alert Message | Successful upload of AdvanceMapping_Excel.xlsx. |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName | Section  |
      | Select Dropdown | Sheet Name | Database | As Input |
      | Select Dropdown | Item Type  | Database | As Input |
    And user "click" on "first row as column name checkbox" for "AdvanceMappingExcelUpload" in "Manage Excel Imports" page
    And user "click" on "Advanced Mapping radio button" for "AdvanceMappingExcelUpload" in "Manage Excel Imports" page
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem     | ItemName       |
      | Verify prepopulated column value | Description    | Description    |
      | Verify prepopulated column field | Description    | Attribute      |
      | Verify prepopulated column value | Technical Data | Technical Data |
      | Verify prepopulated column field | Technical Data | Attribute      |
      | Verify prepopulated column value | storage type   | Storage type   |
      | Verify prepopulated column field | storage type   | Attribute      |
      | Verify prepopulated column value | location       | Location       |
      | Verify prepopulated column field | location       | Attribute      |

  ##7083693##7083694##7083695##
  @MLP-21165 @webtest @regression @positive
  Scenario:SC#4:MLP-21165: Verify if Column 'Cluster' can be mapped as 'Scope' item > Scope Item Type 'Cluster', Scope Link Type 'ROOT' and Scope Level as '1'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem                |
      | Excel Importer Name | AdvanceMappingExcelUpload |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | AdvanceMapping_Excel.xlsx |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName | Section  |
      | Select Dropdown | Sheet Name | Database | As Input |
      | Select Dropdown | Item Type  | Database | As Input |
    And user "click" on "first row as column name checkbox" for "AdvanceMappingExcelUpload" in "Manage Excel Imports" page
    And user "click" on "Advanced Mapping radio button" for "AdvanceMappingExcelUpload" in "Manage Excel Imports" page
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem           | ItemName    | Section          |
      | Input Item Attributes            | Scope                | Cluster     |                  |
      | Select Scope Values Parent       | Scope Item Type      | Cluster     | Cluster          |
      | Select Scope Values Child        | Scope Link Type      | ROOT        | Cluster          |
      | Enter text                       | Scope Level          | 1           | Cluster          |
      | Input Item Attributes            | Scope                | Service     |                  |
      | Select Scope Values Parent       | Scope Item Type      | Service     | Service          |
      | Select Scope Values Child        | Scope Link Type      | definitions | Service          |
      | Enter text                       | Scope Level          | 2           | Service          |
      | Select Dropdown                  | DB name              | Name        | In Mapping Value |
      | Verify prepopulated column field | DB name              | Attribute   |                  |
      | Select Scope Values Child        | Scope Attribute Name | definitions | DB name          |
    And user "click" on "Save" button in "Excel Importer Page"
    And user verifies "Manage Excel Imports page" is "displayed"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem                 | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | AdvanceMappingExcelUpload  | Run the excel import  |         |
    And user verifies "Manage Excel Imports page" is "displayed"

    ##7083700##7083701##
  @MLP-21162 @webtest @regression @positive
  Scenario:SC#6:MLP-21165: Verify if after successful import, the Database items are displayed in UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user "verify presence" of following "Items List" in Item View Page
      | healthcare |
      | Payments   |
      | Finance    |
      | Customers  |
    And user enters the search text "Payments" and clicks on search
    And user clicks on first item on the item list page
    Then user "verify presence" of following "hierarchy" in Item View Page
      | ClusterDemo |
      | Hive        |
      | Payments    |

  ##7083706##
  @MLP-21165 @webtest @regression @positive
  Scenario:SC#7:MLP-21165: Attached 'Advance Import Using UI for Databases and Tables.docx' > Do the mappings for Table items and import
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem                  |
      | Excel Importer Name | AdvanceExcelImportForTables |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                    |
      | setAutoDelay    | 1000                      |
      | selectExcelFile | AdvanceMapping_Excel.xlsx |
      | setAutoDelay    | 1000                      |
      | keyPress        | CONTROL                   |
      | keyPress        | V                         |
      | keyRelease      | CONTROL                   |
      | keyRelease      | V                         |
      | setAutoDelay    | 1000                      |
      | keyPress        | ENTER                     |
      | keyRelease      | ENTER                     |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName | Section  |
      | Select Dropdown | Sheet Name | Tables   | As Input |
      | Select Dropdown | Item Type  | Table    | As Input |
    And user "click" on "first row as column name checkbox" for "AdvanceExcelImportForTables" in "Manage Excel Imports" page
    And user "click" on "Advanced Mapping radio button" for "AdvanceExcelImportForTables" in "Manage Excel Imports" page
    And User performs following actions in the Excel Importer Page
      | Actiontype                  | ActionItem           | ItemName      | Section    |
      | Input Item Attributes       | Scope                | Cluster       |            |
      | Select Scope Values Parent  | Scope Item Type      | Cluster       | Cluster    |
      | Select Scope Values Child   | Scope Link Type      | ROOT          | Cluster    |
      | Enter text                  | Scope Level          | 1             | Cluster    |
      | Input Item Attributes       | Scope                | Service       |            |
      | Select Scope Values Parent  | Scope Item Type      | Service       | Service    |
      | Select Scope Values Child   | Scope Link Type      | definitions   | Service    |
      | Enter text                  | Scope Level          | 2             | Service    |
      | Input Item Attributes       | Scope                | Database      |            |
      | Select Scope Values Parent  | Scope Item Type      | Database      | Database   |
      | Select Scope Values Child   | Scope Link Type      | definitions   | Database   |
      | Enter text                  | Scope Level          | 3             | Database   |
      | Select Scope Values Child   | Scope Attribute Name | definitions   | Database   |
      | Input Item Attributes       | Tags                 | tags          |            |
      | Input Item Attributes       | LinkScope            | ToCluster     |            |
      | Select Scope Values Child   | Scope Item Type      | Cluster       | ToCluster  |
      | Select Scope Values Child   | Scope Link Type      | ROOT          | ToCluster  |
      | Enter text                  | Scope Level          | 1             | ToCluster  |
      | Input Item Attributes       | LinkScope            | ToService     |            |
      | Select Scope Values Child   | Scope Item Type      | Service       | ToService  |
      | Select Scope Values Child   | Scope Link Type      | definitions   | ToService  |
      | Enter text                  | Scope Level          | 2             | ToService  |
      | Input Item Attributes       | LinkScope            | ToDatabase    |            |
      | Select Scope Values Child   | Scope Item Type      | Database      | ToDatabase |
      | Select Scope Values Child   | Scope Link Type      | definitions   | ToDatabase |
      | Enter text                  | Scope Level          | 3             | ToDatabase |
      | Input Item Attributes       | Link                 | linkTo        |            |
      | Select Scope Values Child   | Target Item Type     | Table         | linkTo     |
      | Select Scope Values Child   | Target Link Type     | definitions   | linkTo     |
      | Select Scope Values Child   | Link Type           | implementedAs | linkTo     |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem                  | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | AdvanceExcelImportForTables | Run the excel import  |         |
    And user verifies "Manage Excel Imports page" is "displayed"

  ##7083707##7083708##
  @MLP-21162 @webtest @regression @positive
  Scenario:SC#8:MLP-21165: Verify if after successful import, the Table items are displayed in UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Customers" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Hive  [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table  | value          | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | customergenres | verify widget contains | No               |             |
      | Tables | customers      | verify widget contains | No               |             |
    And user enters the search text "Payments" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Hive  [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table  | value        | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | TopSellers   | verify widget contains | No               |             |
      | Tables | Transactions | verify widget contains | No               |             |
    And user enters the search text "Finance" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Hive  [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table  | value   | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | product | verify widget contains | No               |             |
      | Tables | store   | verify widget contains | No               |             |
    And user enters the search text "healthcare" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Hive  [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table  | value    | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | albums   | verify widget contains | No               |             |
      | Tables | genres   | verify widget contains | No               |             |
      | Tables | invoices | verify widget contains | No               |             |
    Then user "verify presence" of following "hierarchy" in Item View Page
      | ClusterDemo |
      | Hive        |
      | healthcare  |

  ##7083709##
  @MLP-21162 @webtest @regression @positive
  Scenario:SC#9:MLP-21165: Verify if the Table item is mapped with correct tag name in UI when compared to excel sheet
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "SellerInfo" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "GeneralInfo" attribute under "Tags" facets in Item Search results page
    And user performs "facet selection" in "CustomerInfo" attribute under "Tags" facets in Item Search results page
    And user "verify presence" of following "Items List" in Item View Page
      | store          |
      | product        |
      | albums         |
      | TopSellers     |
      | invoices       |
      | genres         |
      | Transactions   |
      | customergenres |
      | customers      |

  @MLP-21165 @webtest @regression @positive
  Scenario:SC#10:MLP-21165: Attached 'Advance Import Using UI for Databases and Tables.docx' > Do the mappings for added extra Table items and import
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem                         |
      | Excel Importer Name | AdvanceExcelImportMappingForTables |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                                    |
      | setAutoDelay    | 1000                                      |
      | selectExcelFile | AdvanceMapping_With_Extra_Rows_Excel.xlsx |
      | setAutoDelay    | 1000                                      |
      | keyPress        | CONTROL                                   |
      | keyPress        | V                                         |
      | keyRelease      | CONTROL                                   |
      | keyRelease      | V                                         |
      | setAutoDelay    | 1000                                      |
      | keyPress        | ENTER                                     |
      | keyRelease      | ENTER                                     |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName | Section  |
      | Select Dropdown | Sheet Name | Tables   | As Input |
      | Select Dropdown | Item Type  | Table    | As Input |
    And user "click" on "first row as column name checkbox" for "AdvanceExcelImportMappingForTables" in "Manage Excel Imports" page
    And user "click" on "Advanced Mapping radio button" for "AdvanceExcelImportMappingForTables" in "Manage Excel Imports" page
    And User performs following actions in the Excel Importer Page
      | Actiontype                 | ActionItem           | ItemName      | Section    |
      | Input Item Attributes      | Scope                | Cluster       |            |
      | Select Scope Values Parent | Scope Item Type      | Cluster       | Cluster    |
      | Select Scope Values Child  | Scope Link Type      | ROOT          | Cluster    |
      | Enter text                 | Scope Level          | 1             | Cluster    |
      | Input Item Attributes      | Scope                | Service       |            |
      | Select Scope Values Parent | Scope Item Type      | Service       | Service    |
      | Select Scope Values Child  | Scope Link Type      | definitions   | Service    |
      | Enter text                 | Scope Level          | 2             | Service    |
      | Input Item Attributes      | Scope                | Database      |            |
      | Select Scope Values Parent | Scope Item Type      | Database      | Database   |
      | Select Scope Values Child  | Scope Link Type      | definitions   | Database   |
      | Enter text                 | Scope Level          | 3             | Database   |
      | Select Scope Values Child  | Scope Attribute Name | definitions   | Database   |
      | Input Item Attributes      | Tags                 | tags          |            |
      | Input Item Attributes      | LinkScope            | ToCluster     |            |
      | Select Scope Values Child  | Scope Item Type      | Cluster       | ToCluster  |
      | Select Scope Values Child  | Scope Link Type      | ROOT          | ToCluster  |
      | Enter text                 | Scope Level          | 1             | ToCluster  |
      | Input Item Attributes      | LinkScope            | ToService     |            |
      | Select Scope Values Child  | Scope Item Type      | Service       | ToService  |
      | Select Scope Values Child  | Scope Link Type      | definitions   | ToService  |
      | Enter text                 | Scope Level          | 2             | ToService  |
      | Input Item Attributes      | LinkScope            | ToDatabase    |            |
      | Select Scope Values Child  | Scope Item Type      | Database      | ToDatabase |
      | Select Scope Values Child  | Scope Link Type      | definitions   | ToDatabase |
      | Enter text                 | Scope Level          | 3             | ToDatabase |
      | Input Item Attributes      | Link                 | linkTo        |            |
      | Select Scope Values Child  | Target Item Type     | Table         | linkTo     |
      | Select Scope Values Child  | Target Link Type     | definitions   | linkTo     |
      | Select Scope Values Child  | Link Type           | implementedAs | linkTo     |
    And user "click" on "SAVE" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem                         | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | AdvanceExcelImportMappingForTables | Run the excel import  |         |
    And user verifies "Manage Excel Imports page" is "displayed"

  ##7083710##7083711##
  @MLP-21162 @webtest @regression @positive
  Scenario:SC#11:MLP-21165: Verify if the Table item 'Jhonney' has the 'ImplementedAs' table 'TopSellers'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Customers" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Hive  [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table  | value          | Action                 | RetainPrevwindow | indexSwitch |
      | Tables | Jhonney        | verify widget contains | No               |             |
      | Tables | TopSellers     | verify widget contains | No               |             |
      | Tables | customergenres | verify widget contains | No               |             |
      | Tables | customers      | verify widget contains | No               |             |
    And user "click" on "Relationships" tab in Overview page
    Then following items should "get" displayed in Lineage Diagram
      | lineageNodeName | lineageNodeType |
      | Customers       | Database        |
      | Jhonney         | Table           |
      | TopSellers      | Table           |
      | customergenres  | Table           |
      | customers       | Table           |

  @MLP-21165 @webtest @regression @positive
  Scenario:SC#12:MLP-21165: Verify if user can delete the advance mapping excel import
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Delete the excel import" for "AdvanceExcelImportMappingForTables" in "Manage Excel Imports" page
    And user "click" on "DELETE" button in "popup"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem                         |
      | verify column list not contains | AdvanceExcelImportMappingForTables |

    ##7108493##7108494##7108499##7108500##7108501##
  @MLP-23675 @webtest @regression @positive
  Scenario:SC#1: MLP-23675: Verify the discard popup works as expected in manage excel imports
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "Verifies popup" is "displayed" for "Excel Importer"
    And user clicks on "Escape" key
    And user "Verifies popup" is "not displayed" for "Unsaved changes"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem      |
      | Excel Importer Name | SampleExcelFile |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action           |
      | setAutoDelay    | 1000             |
      | selectExcelFile | Person Data.xlsx |
      | setAutoDelay    | 1000             |
      | keyPress        | CONTROL          |
      | keyPress        | V                |
      | keyRelease      | CONTROL          |
      | keyRelease      | V                |
      | setAutoDelay    | 1000             |
      | keyPress        | ENTER            |
      | keyRelease      | ENTER            |
    And user clicks on "Escape" key
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Edit Data Source popup"
    And user "click" on "Popup Cancel" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"
    And user clicks on "No" link in the "Edit Data Source popup"
    And user "click" on "Popup Close" button in "Edit Data Source popup"
    And user "Verifies popup" is "displayed" for "Unsaved changes"


 #####################################################################################################################

  ## MLP-26031 - Verification of Excel Stitch functionality in Excel Import##

  ##7173289##
  @MLP-26031 @webtest @regression @positive
  Scenario:SC#1:MLP-26031: Verify if user is able to create a Stitch between Table to Table
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem         |
      | Excel Importer Name | StitchTabletoTable |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                          |
      | setAutoDelay    | 1000                            |
      | selectExcelFile | Stitch_Table&Columns&Files.xlsx |
      | setAutoDelay    | 1000                            |
      | keyPress        | CONTROL                         |
      | keyPress        | V                               |
      | keyRelease      | CONTROL                         |
      | keyRelease      | V                               |
      | setAutoDelay    | 1000                            |
      | keyPress        | ENTER                           |
      | keyRelease      | ENTER                           |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName | Section  |
      | Select Dropdown | Sheet Name | Tables   | As Input |
      | Select Dropdown | Item Type  | Table    | As Input |
    And user "click" on "first row as column name checkbox" for "Stitch_Table&Columns&Files" in "Manage Excel Imports" page
    And user "click" on "Advanced Mapping radio button" for "Stitch_Table&Columns&Files" in "Manage Excel Imports" page
    And User performs following actions in the Excel Importer Page
      | Actiontype                 | ActionItem           | ItemName      | Section    |
      | Input Item Attributes      | Scope                | Cluster       |            |
      | Select Scope Values Parent | Scope Item Type      | Cluster       | Cluster    |
      | Select Scope Values Child  | Scope Link Type      | ROOT          | Cluster    |
      | Enter text                 | Scope Level          | 1             | Cluster    |
      | Input Item Attributes      | Scope                | Service       |            |
      | Select Scope Values Parent | Scope Item Type      | Service       | Service    |
      | Select Scope Values Child  | Scope Link Type      | definitions   | Service    |
      | Enter text                 | Scope Level          | 2             | Service    |
      | Input Item Attributes      | Scope                | Database      |            |
      | Select Scope Values Parent | Scope Item Type      | Database      | Database   |
      | Select Scope Values Child  | Scope Link Type      | definitions   | Database   |
      | Enter text                 | Scope Level          | 3             | Database   |
      | Select Scope Values Child  | Scope Attribute Name | definitions   | Database   |
      | Input Item Attributes      | LinkScope            | ToCluster     |            |
      | Select Scope Values Child  | Scope Item Type      | Cluster       | ToCluster  |
      | Select Scope Values Child  | Scope Link Type      | ROOT          | ToCluster  |
      | Enter text                 | Scope Level          | 1             | ToCluster  |
      | Input Item Attributes      | LinkScope            | ToService     |            |
      | Select Scope Values Child  | Scope Item Type      | Service       | ToService  |
      | Select Scope Values Child  | Scope Link Type      | definitions   | ToService  |
      | Enter text                 | Scope Level          | 2             | ToService  |
      | Input Item Attributes      | LinkScope            | ToDatabase    |            |
      | Select Scope Values Child  | Scope Item Type      | Database      | ToDatabase |
      | Select Scope Values Child  | Scope Link Type      | definitions   | ToDatabase |
      | Enter text                 | Scope Level          | 3             | ToDatabase |
      | Input Item Attributes      | Link                 | ToTable       |            |
      | Select Scope Values Child  | Target Item Type     | Table         | ToTable    |
      | Select Scope Values Child  | Target Link Type     | definitions   | ToTable    |
      | Select Scope Values Child  | Link Type            | Stitch        | ToTable    |
    And user "click" on "SAVE" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem         | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | StitchTabletoTable | Run the excel import  |         |
    And user refreshes the application
    And user enters the search text "albums_Stitch" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "albums_Stitch" item from search results
    And user "click" on "Lineage" tab in Overview page
    And user "click" the slider to "4" in "EXPAND SCOPE" section in diagramming page
    And user verifies the "Lineage Icon" is "displayed"
    And user mouse hover on "Stich Lineage Icon" edge icon and click lineage hop info icon
    And user "verifies hop content" in Diagramming Page
      | fieldName | attribute              |
      | Title     | albums_Stitch > genres |
      | Mode      | Stitch                 |
    And user "click" on "Item info Close" icon in LineageDiagramming page

  ##7173290##
  @MLP-26031 @webtest @regression @positive
  Scenario:SC#2:MLP-26031: Verify if user is able to create a Stitch between Column to Column
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem           |
      | Excel Importer Name | StitchColumntoColumn |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                          |
      | setAutoDelay    | 1000                            |
      | selectExcelFile | Stitch_Table&Columns&Files.xlsx |
      | setAutoDelay    | 1000                            |
      | keyPress        | CONTROL                         |
      | keyPress        | V                               |
      | keyRelease      | CONTROL                         |
      | keyRelease      | V                               |
      | setAutoDelay    | 1000                            |
      | keyPress        | ENTER                           |
      | keyRelease      | ENTER                           |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName | Section  |
      | Select Dropdown | Sheet Name | Columns  | As Input |
      | Select Dropdown | Item Type  | Column   | As Input |
    And user "click" on "first row as column name checkbox" for "Stitch_Table&Columns&Files" in "Manage Excel Imports" page
    And user "click" on "Advanced Mapping radio button" for "Stitch_Table&Columns&Files" in "Manage Excel Imports" page
    And User performs following actions in the Excel Importer Page
      | Actiontype                 | ActionItem           | ItemName      | Section    |
      | Input Item Attributes      | Scope                | Cluster       |            |
      | Select Scope Values Parent | Scope Item Type      | Cluster       | Cluster    |
      | Select Scope Values Child  | Scope Link Type      | ROOT          | Cluster    |
      | Enter text                 | Scope Level          | 1             | Cluster    |
      | Input Item Attributes      | Scope                | Service       |            |
      | Select Scope Values Parent | Scope Item Type      | Service       | Service    |
      | Select Scope Values Child  | Scope Link Type      | definitions   | Service    |
      | Enter text                 | Scope Level          | 2             | Service    |
      | Input Item Attributes      | Scope                | Database      |            |
      | Select Scope Values Parent | Scope Item Type      | Database      | Database   |
      | Select Scope Values Child  | Scope Link Type      | definitions   | Database   |
      | Enter text                 | Scope Level          | 3             | Database   |
      | Input Item Attributes      | Scope                | Table         |            |
      | Select Scope Values Parent | Scope Item Type      | Table         | Table      |
      | Select Scope Values Child  | Scope Link Type      | definitions   | Table      |
      | Enter text                 | Scope Level          | 4             | Table      |
      | Select Scope Values Child  | Scope Attribute Name | definitions   | Database   |
      | Input Item Attributes      | LinkScope            | ToCluster     |            |
      | Select Scope Values Child  | Scope Item Type      | Cluster       | ToCluster  |
      | Select Scope Values Child  | Scope Link Type      | ROOT          | ToCluster  |
      | Enter text                 | Scope Level          | 1             | ToCluster  |
      | Input Item Attributes      | LinkScope            | ToService     |            |
      | Select Scope Values Child  | Scope Item Type      | Service       | ToService  |
      | Select Scope Values Child  | Scope Link Type      | definitions   | ToService  |
      | Enter text                 | Scope Level          | 2             | ToService  |
      | Input Item Attributes      | LinkScope            | ToDatabase    |            |
      | Select Scope Values Child  | Scope Item Type      | Database      | ToDatabase |
      | Select Scope Values Child  | Scope Link Type      | definitions   | ToDatabase |
      | Enter text                 | Scope Level          | 3             | ToDatabase |
      | Input Item Attributes      | LinkScope            | ToTable       |            |
      | Select Scope Values Child  | Scope Item Type      | Table         | ToTable    |
      | Select Scope Values Child  | Scope Link Type      | definitions   | ToTable    |
      | Enter text                 | Scope Level          | 4             | ToTable    |
      | Input Item Attributes      | Link                 | ToColumn      |            |
      | Select Scope Values Child  | Target Item Type     | Column        | ToColumn   |
      | Select Scope Values Child  | Target Link Type     | definitions   | ToColumn   |
      | Select Scope Values Child  | Link Type            | Stitch        | ToColumn   |
    And user "click" on "SAVE" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem           | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | StitchColumntoColumn | Run the excel import  |         |
    And user refreshes the application
    And user enters the search text "customerid_Stitch" and clicks on search
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "customerid_Stitch" item from search results
    And user "click" on "Lineage" tab in Overview page
    And user "click" the slider to "4" in "EXPAND SCOPE" section in diagramming page
    And user verifies the "Lineage Icon" is "displayed"
    And user mouse hover on "Stich Lineage Icon" edge icon and click lineage hop info icon
    And user "verifies hop content" in Diagramming Page
      | fieldName | attribute                         |
      | Title     | customerid_Stitch > custid_Stitch |
      | Mode      | Stitch                            |
    And user "click" on "Item info Close" icon in LineageDiagramming page

  ##7173291##
  @MLP-26031 @webtest @regression @positive
  Scenario:SC#3:MLP-26031: Verify if user is able to create a Stitch between File to File
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem       |
      | Excel Importer Name | StitchFiletoFile |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                          |
      | setAutoDelay    | 1000                            |
      | selectExcelFile | Stitch_Table&Columns&Files.xlsx |
      | setAutoDelay    | 1000                            |
      | keyPress        | CONTROL                         |
      | keyPress        | V                               |
      | keyRelease      | CONTROL                         |
      | keyRelease      | V                               |
      | setAutoDelay    | 1000                            |
      | keyPress        | ENTER                           |
      | keyRelease      | ENTER                           |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName | Section  |
      | Select Dropdown | Sheet Name | Files    | As Input |
      | Select Dropdown | Item Type  | File     | As Input |
    And user "click" on "first row as column name checkbox" for "Stitch_Table&Columns&Files" in "Manage Excel Imports" page
    And user "click" on "Advanced Mapping radio button" for "Stitch_Table&Columns&Files" in "Manage Excel Imports" page
    And User performs following actions in the Excel Importer Page
      | Actiontype                 | ActionItem           | ItemName      | Section    |
      | Input Item Attributes      | Scope                | Cluster       |            |
      | Select Scope Values Parent | Scope Item Type      | Cluster       | Cluster    |
      | Select Scope Values Child  | Scope Link Type      | ROOT          | Cluster    |
      | Enter text                 | Scope Level          | 1             | Cluster    |
      | Input Item Attributes      | Scope                | Service       |            |
      | Select Scope Values Parent | Scope Item Type      | Service       | Service    |
      | Select Scope Values Child  | Scope Link Type      | definitions   | Service    |
      | Enter text                 | Scope Level          | 2             | Service    |
      | Input Item Attributes      | Scope                | Directory     |            |
      | Select Scope Values Parent | Scope Item Type      | Directory     | Directory  |
      | Select Scope Values Child  | Scope Link Type      | definitions   | Directory  |
      | Enter text                 | Scope Level          | 3             | Directory  |
      | Select Scope Values Child  | Scope Attribute Name | definitions   | Directory  |
      | Input Item Attributes      | LinkScope            | ToCluster     |            |
      | Select Scope Values Child  | Scope Item Type      | Cluster       | ToCluster  |
      | Select Scope Values Child  | Scope Link Type      | ROOT          | ToCluster  |
      | Enter text                 | Scope Level          | 1             | ToCluster  |
      | Input Item Attributes      | LinkScope            | ToService     |            |
      | Select Scope Values Child  | Scope Item Type      | Service       | ToService  |
      | Select Scope Values Child  | Scope Link Type      | definitions   | ToService  |
      | Enter text                 | Scope Level          | 2             | ToService  |
      | Input Item Attributes      | LinkScope            | ToDirectory   |            |
      | Select Scope Values Child  | Scope Item Type      | Directory     | ToDirectory|
      | Select Scope Values Child  | Scope Link Type      | definitions   | ToDirectory|
      | Enter text                 | Scope Level          | 3             | ToDirectory|
      | Input Item Attributes      | Link                 | ToFile        |            |
      | Select Scope Values Child  | Target Item Type     | File          | ToFile     |
      | Select Scope Values Child  | Target Link Type     | definitions   | ToFile     |
      | Select Scope Values Child  | Link Type            | Stitch        | ToFile     |
    And user "click" on "SAVE" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem        | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | StitchFiletoFile  | Run the excel import  |         |
    And user refreshes the application
    And user enters the search text "File _7" and clicks on search
    And user performs "facet selection" in "File" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "File _7" item from search results
    And user "click" on "Lineage" tab in Overview page
    And user "click" the slider to "10" in "SCOPE" section in diagramming page
    And user verifies the "Lineage Icon" is "displayed"
    And user mouse hover on "Stich File Lineage Icon" edge icon and click lineage hop info icon
    And user "verifies hop content" in Diagramming Page
      | fieldName | attribute        |
      | Title     | File _7 > File 6 |
      | Mode      | Stitch           |
    And user "click" on "Item info Close" icon in LineageDiagramming page

  @MLP-26031 @webtest @regression @positive
  Scenario:SC#4:MLP-26031: Verify if user can delete the excel import items
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Delete the excel import" for "StitchTabletoTable" in "Manage Excel Imports" page
    And user "click" on "DELETE" button in "popup"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem         |
      | verify column list not contains | StitchTabletoTable |
    And user "click" on "Delete the excel import" for "StitchColumntoColumn" in "Manage Excel Imports" page
    And user "click" on "DELETE" button in "popup"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem           |
      | verify column list not contains | StitchColumntoColumn |
    And user "click" on "Delete the excel import" for "StitchFiletoFile" in "Manage Excel Imports" page
    And user "click" on "DELETE" button in "popup"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem       |
      | verify column list not contains | StitchFiletoFile |

  ################################################################################################################
  ## MLP-27342 - Add Excel loader sample template for importing table and column and BA

  ##7197205##
  @MLP-27342 @webtest @regression @positive
  Scenario:SC#1:MLP-27341: Verify if user can view the default excel templates for every build
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem                  | ItemName              | Section |
      | Verify Edit,Clone,Run and Delete | TechnicalMetadataTemplate1  | Run the excel import  |         |
      | Verify Edit,Clone,Run and Delete | TechnicalMetadataTemplate2  | Run the excel import  |         |
      | Verify Edit,Clone,Run and Delete | BizAppsUsersTemplate        | Run the excel import  |         |
      | Verify Edit,Clone,Run and Delete | BizAppsSupportTemplate      | Run the excel import  |         |
      | Verify Edit,Clone,Run and Delete | BizAppsSecurityTemplate     | Run the excel import  |         |
      | Verify Edit,Clone,Run and Delete | BizAppsComplianceTemplate   | Run the excel import  |         |
      | Verify Edit,Clone,Run and Delete | BizAppsBusinessTemplate     | Run the excel import  |         |
      | Verify Edit,Clone,Run and Delete | BizAppsArchitectureTemplate | Run the excel import  |         |

  ##7197206##
  @MLP-27342 @webtest @regression @positive
  Scenario:SC#2:MLP-27341: Verify if user can run the excel template
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem                  | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | TechnicalMetadataTemplate1  | Run the excel import  |         |
      | Click Edit,Clone,Run and Delete  | TechnicalMetadataTemplate2  | Run the excel import  |         |
      | Click Edit,Clone,Run and Delete  | BizAppsUsersTemplate        | Run the excel import  |         |
      | Click Edit,Clone,Run and Delete  | BizAppsSupportTemplate      | Run the excel import  |         |
      | Click Edit,Clone,Run and Delete  | BizAppsSecurityTemplate     | Run the excel import  |         |
      | Click Edit,Clone,Run and Delete  | BizAppsComplianceTemplate   | Run the excel import  |         |
      | Click Edit,Clone,Run and Delete  | BizAppsBusinessTemplate     | Run the excel import  |         |
      | Click Edit,Clone,Run and Delete  | BizAppsArchitectureTemplate | Run the excel import  |         |

  ##7197207##7197208##
  @MLP-27342 @webtest @regression @positive
  Scenario:SC#3:MLP-27341: Verify if user can View the sample BA Items in UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Human Resource System" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Human Resource System" item from search results
    And User performs following actions in the Item view Page
      | Actiontype                  | ActionItem          | ItemName     |
      | Verify Details Widget Value | Data Classification | Confidential |
      | Verify Details Widget Value | Acronym             | HR           |

  ##7197207##7197208##
  @MLP-27342 @webtest @regression @positive
  Scenario:SC#4:MLP-27341: Verify if user can View the sample Table Items in UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "asg_regions" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "asg_regions" item from search results
    And user "click" on "Lineage" tab in Overview page
    And user "click" the slider to "10" in "SCOPE" section in diagramming page

  ##7197207##7197208##
  @MLP-27342 @webtest @regression @positive
  Scenario:SC#5:MLP-27341: Verify if user can View the sample Column Items in UI
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "asg_territoryid" and clicks on search
    And user performs "facet selection" in "Column" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "asg_territoryid" item from search results
    And user "click" on "Lineage" tab in Overview page
    And user "click" the slider to "10" in "SCOPE" section in diagramming page
