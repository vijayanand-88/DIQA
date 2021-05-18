@MLP_24156
Feature:MLP_24156_Download uploaded excel from Manage excel

  # 7125910# 7125912# 7125914# 7125911# 7176493# 7125913
  @MLP-24156 @webtest @regression @positive
  Scenario:MLP-24156:SC#1_Verify if user can save the excel import and the saved import is displayed in 'Manage Excel Imports' screen
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                | ItemName      |
      | Enter Excel Importer Name | TestDemoExcel |
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
      | Verify Edit,Clone,Run and Delete         | TestDemoExcel           | Download the excel file             |          |
      | Click Edit,Clone,Run,Download and Delete | TestDemoExcel           | Download the excel file             |          |
      | Verify Edit,Clone,Run and Delete         | TestDemoExcel           | Shows the logs of the configuration |          |
      | Verify Edit,Clone,Run and Delete         | TestDemoExcel           | Clone the excel import              |          |
      | Verify Edit,Clone,Run and Delete         | TestDemoExcel           | Delete the excel import             |          |
      | Verify Edit,Clone,Run and Delete         | TestDemoExcel           | Edit the excel import               |          |
    And user verifies excel values of filenames "\\Mulit select.xlsx" and "Mulit select.xlsx" sheetnumbers "Excell" and "Excell" and compare "Equal"
    And user connects to the SFTP server for below parameters
      | sftpAction      | remoteDir | localfile         | dest |
      | deleteLocalFile |           | Mulit select.xlsx |      |

# 7176494
  @MLP-24156 @webtest @regression @positive
  Scenario:MLP-24156:SC#2_Verify uploaded and edited excel file after download are not same
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem    | ItemName                | Section |
      | Click Edit,Clone,Run,Download and Delete | TestDemoExcel | Download the excel file |         |
      | Click Edit,Clone,Run,Download and Delete | TestDemoExcel | Edit the excel import   |         |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action      |
      | setAutoDelay    | 1000        |
      | selectExcelFile | Edited.xlsx |
      | setAutoDelay    | 1000        |
      | keyPress        | CONTROL     |
      | keyPress        | V           |
      | keyRelease      | CONTROL     |
      | keyRelease      | V           |
      | setAutoDelay    | 1000        |
      | keyPress        | ENTER       |
      | keyRelease      | ENTER       |
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem                        | ItemName                            | Section |
      | Verify Alert Message                     | Successful upload of Edited.xlsx. |                                     |         |
      | Click                                    | Save                              |                                     |         |
      | Click Edit,Clone,Run,Download and Delete | TestDemoExcel                     | Download the excel file             |         |
      | Verify Edit,Clone,Run and Delete         | TestDemoExcel                     | Shows the logs of the configuration |         |
    And user verifies excel values of filenames "\\Mulit select.xlsx" and "Edited.xlsx" sheetnumbers "Excell" and "Excell" and compare "Notequal"
    And user connects to the SFTP server for below parameters
      | sftpAction      | remoteDir | localfile         | dest |
      | deleteLocalFile |           | Mulit select.xlsx |      |
      | deleteLocalFile |           | Edited.xlsx       |      |
    And User performs following actions in the Excel Importer Page
      | Actiontype                               | ActionItem    | ItemName                | Section |
      | Click Edit,Clone,Run,Download and Delete | TestDemoExcel | Delete the excel import |         |
    And user "click" on "Confirm" for "Manage Excel Imports" in "Landing page"

  ######################################################################################################

  ###MLP-28102: To verify Download Audit Log

  ##7206793##7206794##
  @MLP-28102 @webtest @regression @positive
  Scenario: SC#1:28102: Verify if user can see and Download as CSV for Audti Logs
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "View Audit Log" in "Landing page"
    And users performs following actions in Audit Log page
      | Actiontype                        | ActionItem  | ItemName                 | Section |
      | Verifies Download Link Displayed  |             | Download as CSV          |         |
    And user connects to the SFTP server for below parameters
      | sftpAction      | remoteDir | localfile | dest |
      | deleteLocalFile |           | audit.asv |      |

  ######################################################################################################






