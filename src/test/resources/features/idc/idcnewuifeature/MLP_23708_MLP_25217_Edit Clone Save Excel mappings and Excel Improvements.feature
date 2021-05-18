@MLP-23708 @MLP-24999 @MLP-23718
Feature:MLP_23708_Edit Clone and Save Excel Import mappings and MLP_23718 : To Verify the Excel Import Username and Time

  ##7123263##7123264##
  @MLP-23708 @webtest @regression @positive
  Scenario:SC#1:MLP-23708: Uploading an Excel file as Business Application type and verifying Edit and Clone button
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And user verifies the "Excel Importer" pop up is "displayed"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem            |
      | Excel Importer Name | EditImportExcelUpload |
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
    And user "click" on "first row as column name checkbox" for "EditImportExcelUpload" in "Manage Excel Imports" page
    And user "click" on "Save" button in "Excel Importer Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem            | ItemName               | Section |
      | Verify Edit,Clone,Run and Delete | EditImportExcelUpload | Edit the excel import  |         |
      | Verify Edit,Clone,Run and Delete | EditImportExcelUpload | Clone the excel import |         |

  ##7123265##7123266##7123268##
  @MLP-23708 @webtest @regression @positive
  Scenario:SC#2:MLP-23708: Verify if clicking on the Edit for an import function opens the 'Edit Excel Import' screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem            | ItemName              | Section |
      | Click Edit,Clone,Run and Delete | EditImportExcelUpload | Edit the excel import |         |
    And user verifies the "Edit Excel Import" pop up is "displayed"
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                      |
      | Verify Alert Message | Successful upload of BusinessApplications.xlsx. |
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem  | ItemName            |
      | Verify prepopulated value        | Sheet Name  | Sheet1              |
      | Verify prepopulated value        | Item Type   | BusinessApplication |
      | Verify prepopulated column value | Name        | Name                |
      | Verify prepopulated column value | Description | Description         |
    And user "click" on "Save" button in "Excel Importer Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |

  ##7123269##7123270##7123271##7123272##
  @MLP-23708 @webtest @regression @positive
  Scenario:SC#3:MLP-23708: Modify the excel sheet by adding a Column and try to Edit import > Verify if on uploading the excel file with added column successfully pre-populates all the earlier mapped values displaying new column value
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem            | ItemName              | Section |
      | Click Edit,Clone,Run and Delete | EditImportExcelUpload | Edit the excel import |         |
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
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem            | ItemName             | Section |
      | Click Edit,Clone,Run and Delete | EditImportExcelUpload | Run the excel import |         |
    And user enters the search text "Test User" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Test User" item from search results
    And user verifies "Item view page title" is "Test User" in "Item View" page
    And User performs following actions in the Item view Page
      | Actiontype                  | ActionItem                                | ItemName  |
      | Verify Description Content  | Have access to control all functonalities |           |
      | Verify Details Widget Value | Acronym                                   | function1 |

  ##7123273##7123274##7123275##
  @MLP-23708 @webtest @regression @positive
  Scenario:SC#4:MLP-23708: Verify if clicking on the Clone for an import function opens the 'Clone Excel Import' screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem            | ItemName               | Section |
      | Verify Edit,Clone,Run and Delete | EditImportExcelUpload | Clone the excel import |         |
      | Click Edit,Clone,Run and Delete  | EditImportExcelUpload | Clone the excel import |         |
    And user verifies the "Clone Excel Import" pop up is "displayed"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem             |
      | Excel Importer Name | CloneImportExcelUpload |
    And user "click" on "Drag and Drop" button in "Clone Excel Import page"
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                        |
      | Verify Alert Message | Successful upload of CloneImportExcelUpload.xlsx. |
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem  | ItemName            |
      | Verify prepopulated value        | Sheet Name  | Sheet1              |
      | Verify prepopulated value        | Item Type   | BusinessApplication |
      | Verify prepopulated column value | Name        | Name                |
      | Verify prepopulated column value | Description | Description         |
      | Verify prepopulated column value | Acronym     | Acronym             |
    And user "click" on "Save" button in "Excel Importer Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |

  ##7123312##7123313##7123314##7123315##
  @MLP-23708 @webtest @regression @positive
  Scenario:SC#5:MLP-23708: Verify if clicking on the Clone and Modifying an attribute value displays the new value in item view page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem             | ItemName               | Section |
      | Verify Edit,Clone,Run and Delete | CloneImportExcelUpload | Clone the excel import |         |
      | Click Edit,Clone,Run and Delete  | CloneImportExcelUpload | Clone the excel import |         |
    And user verifies the "Clone Excel Import" pop up is "displayed"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem              |
      | Excel Importer Name | CloneImportExcelUpload1 |
    And user "click" on "Drag and Drop" button in "Clone Excel Import page"
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                         |
      | Verify Alert Message | Successful upload of CloneImportExcelUpload1.xlsx. |
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem  | ItemName            |
      | Verify prepopulated value        | Sheet Name  | Sheet1              |
      | Verify prepopulated value        | Item Type   | BusinessApplication |
      | Verify prepopulated column value | Name        | Name                |
      | Verify prepopulated column value | Description | Description         |
      | Verify prepopulated column value | Acronym     | Acronym             |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName   | Section          |
      | Select Dropdown | Acronym    | Department | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem              | ItemName             | Section |
      | Click Edit,Clone,Run and Delete | CloneImportExcelUpload1 | Run the excel import |         |
    And user enters the search text "Test User" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user performs "item click" on "Test User" item from search results
    And user verifies "Item view page title" is "Test User" in "Item View" page
    And User performs following actions in the Item view Page
      | Actiontype                  | ActionItem                                | ItemName  |
      | Verify Description Content  | Have access to control all functonalities |           |
      | Verify Details Widget Value | Department                                | function1 |
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"

  ##7123273##7123274##7123275##
  @MLP-23708 @webtest @regression @positive
  Scenario:SC#6:MLP-23708: Verify if user can delete the created excel imports
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem            | ItemName                | Section |
      | Click Edit,Clone,Run and Delete | EditImportExcelUpload | Delete the excel import |         |
    And user "click" on "DELETE" button in "popup"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem             | ItemName                | Section |
      | Click Edit,Clone,Run and Delete | CloneImportExcelUpload | Delete the excel import |         |
    And user "click" on "DELETE" button in "popup"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem              | ItemName                | Section |
      | Click Edit,Clone,Run and Delete | CloneImportExcelUpload1 | Delete the excel import |         |
    And user "click" on "DELETE" button in "popup"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |

##################################################################################################################

  ## MLP-25217 - Excel Mapping Improvements##

  ##7143487##7143488##
  @MLP-25217 @webtest @regression @positive
  Scenario:SC#1:MLP-25217: Verify if the Scope dropdown values in import screen are sorted ascending and keyboard type works
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
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
      | Actiontype            | ActionItem | ItemName | Section |
      | Input Item Attributes | Scope      | Cluster  |         |
    And user "enter text" in "Excel Import Advance Mapping"
      | fieldName                 | actionItem |
      | Advance Mapping Attribute | Cluster    |
    And user "verifies sorting order" of following "Excel Import Scope Drop Down" in "Excel Import" page
      |  |

  ##7143489##7143490##
  @MLP-25217 @webtest @regression @positive
  Scenario:SC#2:MLP-25217: Verification of importing item attributes for without Name attribute and verifying alert message and saving form without an item value
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem    |
      | Excel Importer Name | BAItemsImport |
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
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem  | ItemName    | Section          |
      | Select Dropdown | Name        | Department  | In Mapping Value |
      | Select Dropdown | Description | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                                 |
      | Verify Error Message | Attribute, name should be mapped with a spreadsheet column |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem  | ItemName | Section          |
      | Select Dropdown | Name        | Name     | In Mapping Value |
      | Select Dropdown | Description |          | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |

  ##7143491##7143492##
  @MLP-25217 @webtest @regression @positive
  Scenario:SC#3:MLP-25217: Verification of importing item attributes With Same values and verifying alert message and saving form rectifying the same value mapping
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem     |
      | Excel Importer Name | BAItemsImport1 |
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
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem  | ItemName    | Section          |
      | Select Dropdown | Name        | Name        | In Mapping Value |
      | Select Dropdown | Description | Description | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem     | ItemName              | Section |
      | Verify Edit,Clone,Run and Delete | BAItemsImport1 | Edit the excel import |         |

  ##7143491##7143492##
  @MLP-25217 @webtest @regression @positive
  Scenario:SC#4:MLP-25217: Verify if user can delete the created excel imports
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem    | ItemName                | Section |
      | Click Edit,Clone,Run and Delete | BAItemsImport | Delete the excel import |         |
    And user "click" on "DELETE" button in "popup"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem     | ItemName                | Section |
      | Click Edit,Clone,Run and Delete | BAItemsImport1 | Delete the excel import |         |
    And user "click" on "DELETE" button in "popup"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |

      ##7142593##7142594##7142596## #Descoped
#  @MLP-24999 @webtest @regression @positive
#  Scenario:MLP-24999:SC#1_Verification of importing the same xls file which is already imported as a Business Application type.
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
#    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
#    And user "enter text" in "Landing Page"
#      | fieldName           | actionItem     |
#      | Excel Importer Name | NEWROLESIMPORT |
#    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
#    And user upload file
#      | Method          | Action                |
#      | setAutoDelay    | 1000                  |
#      | selectExcelFile | RolesImportwithBA.xls |
#      | setAutoDelay    | 1000                  |
#      | keyPress        | CONTROL               |
#      | keyPress        | V                     |
#      | keyRelease      | CONTROL               |
#      | keyRelease      | V                     |
#      | setAutoDelay    | 1000                  |
#      | keyPress        | ENTER                 |
#      | keyRelease      | ENTER                 |
#    And User performs following actions in the Excel Importer Page
#      | Actiontype      | ActionItem | ItemName            | Section  |
#      | Select Dropdown | Sheet Name | Sheet1              | As Input |
#      | Select Dropdown | Item Type  | BusinessApplication | As Input |
#    And user "click" on "first row as column name checkbox" for "AdvanceExcelImportMappingForTables" in "Manage Excel Imports" page
#    And user "click" on "Save" button in "Excel Importer Page"
#    And user performs "click" operation in Manage Configurations panel
#      | button | actionItem     |
#      | Start  | NEWROLESIMPORT |
#    And user performs following actions in the sidebar
#      | actionType | actionItem            |
#      | click      | Manage Users & Groups |
#    And user "verifies displayed" on "becubic_build" button in "Manage Access Page"
#    And user performs "click" operation in Manage Configurations panel
#      | button | actionItem    |
#      | Edit   | becubic_build |
#    And user "verifies displayed" in "Add Roles" Manage Access Page
#      | fieldName          |
#      | Business Owner     |
#      | Compliance Owner   |
#      | Security Owner     |
#      | Technology Owner   |
#      | Relationship Owner |

      ##7122916##7122917##
  @MLP-23718 @webtest @regression @positive
  Scenario: SC#1:23718: Verify if Manage Excel Imports screen displays the Columns 'Created By' and 'Modified At'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user "verifies presence" of following "Column Names" in "Manage Excel Imports" page
      | Created By  |
      | Modified At |

  ##7122918##
  @MLP-23718 @webtest @regression @positive
  Scenario: SC#2:23718: - Verify if for each excel import item system displays the User name who has started the import
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And user verifies the "Excel Importer" pop up is "displayed"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem              |
      | Excel Importer Name | Re-UseImportExcelUpload |
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
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And user "click" on "first row as column name checkbox" for "Re-UseImportExcelUpload" in "Manage Excel Imports" page
    And user "click" on "Save" button in "Excel Importer Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |
    And user refreshes the application
    And User performs following actions in the Excel Importer Page
      | Actiontype                  | ActionItem        | ItemName                |
      | verify column list contains | Name              | Re-UseImportExcelUpload |
      | verify column list contains | Imported Itemtype | BusinessApplication     |
      | verify column list contains | Created By        | TestSystem              |

  ##7122920##
  @MLP-23718 @regression @positive
  Scenario: SC#3:23718: Verification of adding becubic user and mapping admin role to edit the excel imported
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url          | body                                 | response code | response message | jsonPath |
      | application/json |       |       | Put  | rolemappings | idc/MLP-5875_BecubicRoleMapping.json | 204           |                  |          |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header              | Query | Param | type | url   | body | response code | response message | jsonPath |
      | multipart/form-data |       |       | Get  | users |      | 200           |                  |          |

  ##7122919##7122920##7122921##
  @MLP-23718 @webtest @regression @positive
  Scenario: SC#4:23718: Verify if on Editing the import by different user does not change user name and updates the Date&Time
    Given User launch browser and traverse to login page
    And user enter credentials for "Becubic User" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user should be able to see the "Created" Date and time of the "Re-UseImportExcelUpload" excel import
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem              | ItemName              | Section |
      | Click Edit,Clone,Run and Delete | Re-UseImportExcelUpload | Edit the excel import |         |
    And user verifies the "Edit Excel Import" pop up is "displayed"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And user "click" on "first row as column name checkbox" for "Re-UseImportExcelUpload" in "Manage Excel Imports" page
    And user "click" on "first row as column name checkbox" for "Re-UseImportExcelUpload" in "Manage Excel Imports" page
    And user "click" on "Save" button in "Excel Importer Page"
    And user "verifies presence" of following "Admin page Title" in "" page
      | Manage Excel Imports |
    And User performs following actions in the Excel Importer Page
      | Actiontype                  | ActionItem        | ItemName                |
      | verify column list contains | Name              | Re-UseImportExcelUpload |
      | verify column list contains | Imported Itemtype | BusinessApplication     |
      | verify column list contains | Created By        | TestSystem              |
    And user should be able to see the "Modified" Date and time of the "Re-UseImportExcelUpload" excel import

