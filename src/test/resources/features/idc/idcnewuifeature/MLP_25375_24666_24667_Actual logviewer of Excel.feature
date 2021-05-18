@MLP-25375 @MLP-24666 @MLP-24667
Feature:MLP_25375_Verify Actual Log Viewer of Manage Excel

  # 7157385 # 7134087 # 7134108 # 7134107 # 7134107# 7134113# 7134109# 7134111
  @MLP-25375 @webtest @regression @positive
  Scenario:MLP-25375:SC#1_Import and run Excel With no errors
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And user verifies the "Excel Importer" pop up is "displayed"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem  |
      | Excel Importer Name | ImporttestA |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action            |
      | setAutoDelay    | 1000              |
      | selectExcelFile | Mulit select.xlsx |
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
      | Verify Alert Message | Successful upload of Mulit select.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem              | ItemName                            | Section  |
      | Select Dropdown                          | Sheet Name              | Excell                              | As Input |
      | Select Dropdown                          | Item Type               | BusinessApplication                 | As Input |
      | Click                                    | Checkbox                |                                     |          |
      | Click                                    | Save                    |                                     |          |
      | Verify Imported Alert Message            | Data successfully saved |                                     |          |
      | Click Edit,Clone,Run,Download and Delete | ImporttestA             | Run the excel import                |          |
      | Verify Edit,Clone,Run and Delete         | ImporttestA             | Shows the logs of the configuration |          |
      | Verify Edit,Clone,Run and Delete         | ImporttestA             | Edit the excel import               |          |
      | Verify Edit,Clone,Run and Delete         | ImporttestA             | Shows the logs of the configuration |          |
      | Click Edit,Clone,Run,Download and Delete | ImporttestA             | Shows the logs of the configuration |          |
    And user "verifies presence" of following "Log Breadcrumbs" in Manage Configurations Page
      | Manage Excel Imports  |
      | Log for "ImporttestA" |
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | INFO |

    # 7176496
  @MLP-25375 @webtest @regression @positive
  Scenario:MLP-25375:SC#2_Log Validation for Import and run Excel With no errors
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem  | ItemName                            | Section |
      | Click Edit,Clone,Run,Download and Delete | ImporttestA | Shows the logs of the configuration |         |
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | Import started    |
      | Importing row : 2 |
      | Importing row : 3 |
      | Importing row : 4 |
      | Importing row : 5 |
      | Importing row : 6 |
      | Import ended      |

# 7176497
  @MLP-25375 @webtest @regression @positive
  Scenario:MLP-25375:SC#3_Import and run Excel With error in first row
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And user verifies the "Excel Importer" pop up is "displayed"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem  |
      | Excel Importer Name | ImporttestB |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action             |
      | setAutoDelay    | 1000               |
      | selectExcelFile | FirstRowError.xlsx |
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
      | Verify Alert Message | Successful upload of FirstRowError.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem              | ItemName                            | Section  |
      | Select Dropdown                          | Sheet Name              | Sheet1                              | As Input |
      | Select Dropdown                          | Item Type               | BusinessApplication                 | As Input |
      | Click                                    | Checkbox                |                                     |          |
      | Click                                    | Save                    |                                     |          |
      | Verify Imported Alert Message            | Data successfully saved |                                     |          |
      | Click Edit,Clone,Run,Download and Delete | ImporttestB             | Run the excel import                |          |
      | Verify Edit,Clone,Run and Delete         | ImporttestB             | Shows the logs of the configuration |          |
      | Verify Edit,Clone,Run and Delete         | ImporttestB             | Edit the excel import               |          |
      | Verify Edit,Clone,Run and Delete         | ImporttestB             | Shows the logs of the configuration |          |
      | Click Edit,Clone,Run,Download and Delete | ImporttestB             | Shows the logs of the configuration |          |
    And user "verifies presence" of following "Log Breadcrumbs" in Manage Configurations Page
      | Manage Excel Imports  |
      | Log for "ImporttestB" |
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | ERROR |

     # 7176498
  @MLP-25375 @webtest @regression @positive
  Scenario:MLP-25375:SC#4_Log Validation for Import and run Excel With error in first row
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem  | ItemName                            | Section |
      | Click Edit,Clone,Run,Download and Delete | ImporttestB | Shows the logs of the configuration |         |
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | Import started          |
      | Cannot import row no: 2 |
      | Import ended            |

# 7176499
  @MLP-25375 @webtest @regression @positive
  Scenario:MLP-25375:SC#4_Import and run Excel With error in middle row
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And user verifies the "Excel Importer" pop up is "displayed"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem  |
      | Excel Importer Name | ImporttestC |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                   |
      | setAutoDelay    | 1000                     |
      | selectExcelFile | MiddlerowExcelError.xlsx |
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
      | Verify Alert Message | Successful upload of MiddlerowExcelError.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem              | ItemName                            | Section  |
      | Select Dropdown                          | Sheet Name              | Sheet1                              | As Input |
      | Select Dropdown                          | Item Type               | BusinessApplication                 | As Input |
      | Click                                    | Checkbox                |                                     |          |
      | Click                                    | Save                    |                                     |          |
      | Verify Imported Alert Message            | Data successfully saved |                                     |          |
      | Click Edit,Clone,Run,Download and Delete | ImporttestC             | Run the excel import                |          |
      | Verify Edit,Clone,Run and Delete         | ImporttestC             | Shows the logs of the configuration |          |
      | Verify Edit,Clone,Run and Delete         | ImporttestC             | Edit the excel import               |          |
      | Verify Edit,Clone,Run and Delete         | ImporttestC             | Shows the logs of the configuration |          |
      | Click Edit,Clone,Run,Download and Delete | ImporttestC             | Shows the logs of the configuration |          |
    And user "verifies presence" of following "Log Breadcrumbs" in Manage Configurations Page
      | Manage Excel Imports  |
      | Log for "ImporttestC" |
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | ERROR |
      | INFO  |
    And user "select type" in Log Viewer in Manage Configurations
      | fieldName | attribute |
      | INFO      |           |
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | INFO |
    And user "verifies not presence" of following "Log text" in Manage Configurations Page
      | ERROR |

    # 7176500
  @MLP-25375 @webtest @regression @positive
  Scenario:MLP-25375:SC#5_Log Validation for Import and run Excel With error in middle row
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem  | ItemName                            | Section |
      | Click Edit,Clone,Run,Download and Delete | ImporttestC | Shows the logs of the configuration |         |
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | Import started          |
      | Cannot import row no: 4 |
      | Import ended            |

# 7176501
  @MLP-25375 @webtest @regression @positive
  Scenario:MLP-25375:SC#6_Import and run Excel With error in Last row
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And user verifies the "Excel Importer" pop up is "displayed"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem  |
      | Excel Importer Name | ImporttestD |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action                 |
      | setAutoDelay    | 1000                   |
      | selectExcelFile | Lastrowexcelerror.xlsx |
      | setAutoDelay    | 1000                   |
      | keyPress        | CONTROL                |
      | keyPress        | V                      |
      | keyRelease      | CONTROL                |
      | keyRelease      | V                      |
      | setAutoDelay    | 1000                   |
      | keyPress        | ENTER                  |
      | keyRelease      | ENTER                  |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                                   |
      | Verify Alert Message | Successful upload of Lastrowexcelerror.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem              | ItemName                            | Section  |
      | Select Dropdown                          | Sheet Name              | Sheet1                              | As Input |
      | Select Dropdown                          | Item Type               | BusinessApplication                 | As Input |
      | Click                                    | Checkbox                |                                     |          |
      | Click                                    | Save                    |                                     |          |
      | Verify Imported Alert Message            | Data successfully saved |                                     |          |
      | Click Edit,Clone,Run,Download and Delete | ImporttestD             | Run the excel import                |          |
      | Verify Edit,Clone,Run and Delete         | ImporttestD             | Shows the logs of the configuration |          |
      | Verify Edit,Clone,Run and Delete         | ImporttestD             | Edit the excel import               |          |
      | Verify Edit,Clone,Run and Delete         | ImporttestD             | Shows the logs of the configuration |          |
      | Click Edit,Clone,Run,Download and Delete | ImporttestD             | Shows the logs of the configuration |          |
    And user "verifies presence" of following "Log Breadcrumbs" in Manage Configurations Page
      | Manage Excel Imports  |
      | Log for "ImporttestD" |
    And user verifies "Log Viewer" is "displayed" in Manage Configurations panel
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | ERROR |
      | INFO  |
    And user "select type" in Log Viewer in Manage Configurations
      | fieldName | attribute |
      | ERROR     |           |
    And user "verifies not presence" of following "Log text" in Manage Configurations Page
      | INFO |
    And user "click" on "Type checkbox" in "Manage Configurations Log Viewer"
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | INFO  |
      | ERROR |


    # 7176502
  @MLP-25375 @webtest @regression @positive
  Scenario:MLP-25375:SC#7_Log Validation for Import and run Excel With error in Last row
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem  | ItemName                            | Section |
      | Click Edit,Clone,Run,Download and Delete | ImporttestD | Shows the logs of the configuration |         |
    And user "verifies presence" of following "Log text" in Manage Configurations Page
      | Import started          |
      | Cannot import row no: 6 |
      | Import ended            |

  Scenario:MLP-25375:SC#Delete the Import Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name        | type   | query | param |
      | SingleItemDelete | Default | ImporttestA | Import |       |       |
      | SingleItemDelete | Default | ImporttestB | Import |       |       |
      | SingleItemDelete | Default | ImporttestC | Import |       |       |
      | SingleItemDelete | Default | ImporttestD | Import |       |       |