@MLP-23704
Feature:MLP_23704 Verify Run Excel mappings configuration

  # 7112197# 7112204# 7112198# 7112201# 7112207
  @MLP-23704 @webtest @regression @positive
  Scenario:MLP-23704:SC#1_ Verify if on saving the excel import, system displays the message 'Data Saved Successfully'
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                | ItemName |
      | Enter Excel Importer Name | TestA    |
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
      | Actiontype                    | ActionItem              | ItemName            | Section  |
      | Select Dropdown               | Sheet Name              | Excell              | As Input |
      | Select Dropdown               | Item Type               | BusinessApplication | As Input |
      | Click                         | Checkbox                |                     |          |
      | Click                         | Save                    |                     |          |
      | Verify Imported Alert Message | Data successfully saved |                     |          |

# 7112213# 7112203# 7112211# 7112200
  @MLP-23704 @webtest @regression @positive
  Scenario:MLP-23704:SC#2_ Verify if after successful import the items imported are displayed in UI with correct values
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem        | ItemName                | Section |
      | Verify Column Value Contains             | Name              | TestA                   |         |
      | Verify Status                            | TestA             | warning                 | Image   |
      | verify column value                      | Imported Itemtype |                         |         |
      | Verify Edit,Clone,Run and Delete         | TestA             | Run the excel import    |         |
      | Verify Tooltip of Run                    | TestA             | Run the excel import    |         |
      | Click Edit,Clone,Run,Download and Delete | TestA             | Delete the excel import |         |
    And user "click" on "Confirm" for "Manage Excel Imports" in "Landing page"

  @MLP-23704 @webtest @regression @positive
  Scenario:MLP-23704:SC#3_Import error excel and run
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                | ItemName  |
      | Enter Excel Importer Name | TestError |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action     |
      | setAutoDelay    | 1000       |
      | selectExcelFile | Error.xlsx |
      | setAutoDelay    | 1000       |
      | keyPress        | CONTROL    |
      | keyPress        | V          |
      | keyRelease      | CONTROL    |
      | keyRelease      | V          |
      | setAutoDelay    | 1000       |
      | keyPress        | ENTER      |
      | keyRelease      | ENTER      |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                       |
      | Verify Alert Message | Successful upload of Error.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem              | ItemName             | Section  |
      | Select Dropdown                          | Sheet Name              | Sheet1               | As Input |
      | Select Dropdown                          | Item Type               | BusinessApplication  | As Input |
      | Click                                    | Checkbox                |                      |          |
      | Click                                    | Save                    |                      |          |
      | Verify Imported Alert Message            | Data successfully saved |                      |          |
      | Verify Status                            | TestError               | warning              | Image    |
      | Verify Edit,Clone,Run and Delete         | TestError               | Run the excel import |          |
      | Click Edit,Clone,Run,Download and Delete | TestError               | Run the excel import |          |

# 7112214# 7112215# 7112204# 7112212
  @MLP-23704 @webtest @regression @positive
  Scenario:MLP-23704:SC#4_Verify if clicking on the 'i' icon is displays the fail error message
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem    | ItemName                | Section |
      | Verify Status                            | TestError     | stopped                 | Image   |
      | Click Status                             | TestError     | error                   |         |
      | Validate error Message                   | Error Message |                         |         |
      | Click Edit,Clone,Run,Download and Delete | TestError     | Delete the excel import |         |
    And user "click" on "Confirm" for "Manage Excel Imports" in "Landing page"

  @MLP-22144 @regression @positive
  Scenario Outline:SC#4_Create BusinessApplication
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                       | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc/BusinessApplication/BATrustPolicy.json | 200           |                  |          |

    # 7075406
  @MLP-22144 @webtest @regression @positive
  Scenario:MLP-22144:SC#5_Verify if the Admin panel displays 'Tag' > 'Manage Tags' menu.
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                | ItemName |
      | Enter Excel Importer Name | TestA    |
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
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem              | ItemName                            | Section  |
      | Select Dropdown                          | Sheet Name              | Excell                              | As Input |
      | Select Dropdown                          | Item Type               | BusinessApplication                 | As Input |
      | Click                                    | Checkbox                |                                     |          |
      | Click                                    | Save                    |                                     |          |
      | Verify Imported Alert Message            | Data successfully saved |                                     |          |
      | Verify Edit,Clone,Run and Delete         | TestA                   | Download the excel file             |          |
      | Click Edit,Clone,Run,Download and Delete | TestA                   | Run the excel import                |          |
      | Verify Edit,Clone,Run and Delete         | TestA                   | Shows the logs of the configuration |          |
      | Verify Edit,Clone,Run and Delete         | TestA                   | Clone the excel import              |          |
      | Verify Edit,Clone,Run and Delete         | TestA                   | Delete the excel import             |          |
      | Verify Edit,Clone,Run and Delete         | TestA                   | Edit the excel import               |          |

  @MLP-22144 @regression @positive
  Scenario:MLP-22144:Delete the BA Item
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name           | type                | query | param |
      | SingleItemDelete | Default | BA_TrustPolicy | BusinessApplication |       |       |