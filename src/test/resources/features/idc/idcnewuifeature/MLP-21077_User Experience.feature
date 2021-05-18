@MLP-21077 @MLP-27305 @MLP-28130
Feature:MLP_21077_MLP-28130_@MLP-27305_To verify the User Experience of the Business Application.

  # MLP 21077 - 7053301,7053299,7053298,7053295,7053296,7053293, 7248215
  @MLP-21077 @webtest @regression @positive @e2e
  Scenario:MLP-21077:SC#1_Validate progress bar completeness for Business,Architecture,Security,Support and Compliance Tab after importing data from excel
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                | ItemName |
      | Enter Excel Importer Name | Green    |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action          |
      | setAutoDelay    | 1000            |
      | selectExcelFile | GreenSheet.xlsx |
      | setAutoDelay    | 1000            |
      | keyPress        | CONTROL         |
      | keyPress        | V               |
      | keyRelease      | CONTROL         |
      | keyRelease      | V               |
      | setAutoDelay    | 1000            |
      | keyPress        | ENTER           |
      | keyRelease      | ENTER           |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                            |
      | Verify Alert Message | Successful upload of GreenSheet.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName   | Section          |
      | Select Dropdown | # of Users | # of Users | In Mapping Value |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem | ItemName             | Section |
      | Click Edit,Clone,Run and Delete | Green      | Run the excel import |         |
    And user enters the search text "GreenBA" and clicks on search
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype           | ActionItem            | ItemName        |
      | click to Tab         | Architecture          |                 |
      | Click                | Item view Edit Button |                 |
      | Enter Business Owner | Technology Owners     | Test Data Admin |
      | Click                | Item view Save Button |                 |
      | click to Tab         | Support               |                 |
      | Click                | Item view Edit Button |                 |
      | Enter Business Owner | Relationship Owners   | Test Data Admin |
      | Click                | Item view Save Button |                 |
      | click to Tab         | Security              |                 |
      | Click                | Item view Edit Button |                 |
      | Enter Business Owner | Security Owners       | Test Data Admin |
      | Enter Business Owner | Security Owners       | Becubic Build   |
      | Click                | Item view Save Button |                 |
    And User performs following actions in the Item view Page
      | Actiontype                            | ActionItem     | ItemName                                          |
      | click Details in Completeness section | Details Header |                                                   |
      | Progress Bar validation               | Business       | width: 100%; background-color: rgb(147, 218, 73); |
      | Progress Bar validation               | Architecture   | width: 100%; background-color: rgb(147, 218, 73); |
      | Progress Bar validation               | Support        | width: 100%; background-color: rgb(147, 218, 73); |
      | Progress Bar validation               | Security       | width: 100%; background-color: rgb(147, 218, 73); |
      | Progress Bar validation               | Compliance     | width: 100%; background-color: rgb(147, 218, 73); |

  @MLP-21077  @regression @positive
  Scenario Outline:MLP-21077:SC#1_Add Configuration of Credentials,Data Source,Cataloger,Analyzer and Post Processor for AmazonRedshift
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type         | url                                                                                               | body                                                         | response code | response message          | jsonPath                                                       |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/credentials/Amazon_Redshift_Credentials                                                  | idc/MLP-21077_User Experience/AmazonRedshiftCredentials.json | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/credentials/Amazon_Redshift_Credentials                                                  |                                                              | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftDataSource                                                       | idc/MLP-21077_User Experience/AmazonRedshiftDataSource.json  | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftDataSource                                                       |                                                              | 200           | RedshiftDataSource        |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Put          | settings/analyzers/AmazonRedshiftCataloger                                                        | idc/MLP-21077_User Experience/AmazonRedshiftCataloger.json   | 204           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | Get          | settings/analyzers/AmazonRedshiftCataloger                                                        |                                                              | 200           | Amazon_RedShift_Cataloger |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/Amazon_RedShift_Cataloger |                                                              | 200           | IDLE                      | $.[?(@.configurationName=='Amazon_RedShift_Cataloger')].status |
      | IDC         | TestSystemUser | application/json | raw   | false | Post         | extensions/analyzers/start/LocalNode/cataloger/AmazonRedshiftCataloger/Amazon_RedShift_Cataloger  | idc/MLP-21077_User Experience/Empty.json                     | 200           |                           |                                                                |
      | IDC         | TestSystemUser | application/json | raw   | false | RecursiveGet | extensions/analyzers/status/LocalNode/cataloger/AmazonRedshiftCataloger/Amazon_RedShift_Cataloger |                                                              | 200           | IDLE                      | $.[?(@.configurationName=='Amazon_RedShift_Cataloger')].status |

    # MLP 21077 - 7053306,7053307,7053292,7053302
  @MLP-21077 @webtest @regression @positive
  Scenario:MLP-21077:SC#1_Validate progress bar completeness for Data Tab after running the Amazon Redshift plugin
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "GreenBA" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                            | ActionItem     | ItemName                                          |
      | click Details in Completeness section | Details Header |                                                   |
      | Progress Bar validation               | Data           | width: 100%; background-color: rgb(147, 218, 73); |
      | Completeness Emotion icon state       | Completeness   | smile                                             |
      | Progress Bar validation               | Completeness   | background-color: rgb(147, 218, 73);              |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name       | type   | query | param |
      | SingleItemDelete | Default | Green.xlsx | Import |       |       |
    And user "Deletes" BA Item "GreenBA" in Item View Page
    And user "click" on "Confirm" button in "Delete Role Popup"

  @MLP-21077 @regression @positive
  Scenario: MLP-21077:SC#1_Delete plugin Configurations
    Given  Execute REST API with following parameters
      | Header           | Query | Param | type   | url                                              | body | response code | response message | jsonPath |
      | application/json |       |       | Delete | settings/analyzers/AmazonRedshiftDataSource      |      |               |                  |          |
      |                  |       |       | Delete | settings/analyzers/AmazonRedshiftCataloger       |      |               |                  |          |
      |                  |       |       | Delete | settings/credentials/Amazon_Redshift_Credentials |      |               |                  |          |

  # MLP 21077 - 7053304
  @MLP-21077 @webtest @regression @positive
  Scenario:MLP-21077:SC#2_Validate Yellow progress bar completeness for Business,Architrcture,Security,Support and Compliance Tab after importing data
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                | ItemName |
      | Enter Excel Importer Name | Yellow   |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action           |
      | setAutoDelay    | 1000             |
      | selectExcelFile | YellowSheet.xlsx |
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
      | Verify Alert Message | Successful upload of YellowSheet.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem | ItemName             | Section |
      | Click Edit,Clone,Run and Delete | Yellow     | Run the excel import |         |
    And user enters the search text "YellowBA" and clicks on search
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                            | ActionItem     | ItemName                            |
      | click Details in Completeness section | Details Header |                                     |
      | Progress Bar validation               | Business       | background-color: rgb(248, 209, 6); |
      | Progress Bar validation               | Architecture   | background-color: rgb(248, 209, 6); |
      | Progress Bar validation               | Support        | background-color: rgb(248, 209, 6); |
      | Progress Bar validation               | Security       | background-color: rgb(248, 209, 6); |
      | Progress Bar validation               | Compliance     | background-color: rgb(248, 209, 6); |
      | Completeness Emotion icon state       | Completeness   | meh                                 |
      | Progress Bar validation               | Completeness   | background-color: rgb(248, 209, 6); |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name        | type   | query | param |
      | SingleItemDelete | Default | Yellow.xlsx | Import |       |       |
    And user "Deletes" BA Item "YellowBA" in Item View Page
    And user "click" on "Confirm" button in "Delete Role Popup"

    # MLP 21077 - 7053303
  @MLP-21077 @webtest @regression @positive
  Scenario:MLP-21077:SC#3_Validate Red progress bar completeness for Business,Architrcture,Security,Support and Compliance Tab after importing data
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                | ItemName |
      | Enter Excel Importer Name | Red      |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action        |
      | setAutoDelay    | 1000          |
      | selectExcelFile | RedSheet.xlsx |
      | setAutoDelay    | 1000          |
      | keyPress        | CONTROL       |
      | keyPress        | V             |
      | keyRelease      | CONTROL       |
      | keyRelease      | V             |
      | setAutoDelay    | 1000          |
      | keyPress        | ENTER         |
      | keyRelease      | ENTER         |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                          |
      | Verify Alert Message | Successful upload of RedSheet.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem | ItemName             | Section |
      | Click Edit,Clone,Run and Delete | Red        | Run the excel import |         |
    And user enters the search text "RedBA" and clicks on search
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                            | ActionItem     | ItemName                          |
      | click Details in Completeness section | Details Header |                                   |
      | Progress Bar validation               | Business       | background-color: rgb(249, 7, 7); |
      | Progress Bar validation               | Architecture   | background-color: rgb(249, 7, 7); |
      | Progress Bar validation               | Support        | background-color: rgb(249, 7, 7); |
      | Progress Bar validation               | Security       | background-color: rgb(249, 7, 7); |
      | Progress Bar validation               | Compliance     | background-color: rgb(249, 7, 7); |
      | Completeness Emotion icon state       | Completeness   | frown                             |
      | Progress Bar validation               | Completeness   | background-color: rgb(249, 7, 7); |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name     | type   | query | param |
      | SingleItemDelete | Default | Red.xlsx | Import |       |       |
    And user "Deletes" BA Item "RedBA" in Item View Page
    And user "click" on "Confirm" button in "Delete Role Popup"

  # MLP 21077 - 7053294

  @MLP-21077 @webtest @regression @positive
  Scenario:MLP-21077:SC#4_Validate Empty progress bar completeness for Business,Architrcture,Security,Support, Compliance and Data Tab after importing data
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                | ItemName  |
      | Enter Excel Importer Name | EmptyData |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action          |
      | setAutoDelay    | 1000            |
      | selectExcelFile | EmptySheet.xlsx |
      | setAutoDelay    | 1000            |
      | keyPress        | CONTROL         |
      | keyPress        | V               |
      | keyRelease      | CONTROL         |
      | keyRelease      | V               |
      | setAutoDelay    | 1000            |
      | keyPress        | ENTER           |
      | keyRelease      | ENTER           |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                            |
      | Verify Alert Message | Successful upload of EmptySheet.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem | ItemName             | Section |
      | Click Edit,Clone,Run and Delete | EmptyData  | Run the excel import |         |
    And user enters the search text "EmptyBA" and clicks on search
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                            | ActionItem     | ItemName                                     |
      | click Details in Completeness section | Details Header |                                              |
      | Progress Bar validation               | Business       | width: 0%; background-color: rgb(249, 7, 7); |
      | Progress Bar validation               | Architecture   | width: 0%; background-color: rgb(249, 7, 7); |
      | Progress Bar validation               | Support        | width: 0%; background-color: rgb(249, 7, 7); |
      | Progress Bar validation               | Security       | width: 0%; background-color: rgb(249, 7, 7); |
      | Progress Bar validation               | Compliance     | width: 0%; background-color: rgb(249, 7, 7); |
      | Completeness Emotion icon state       | Completeness   | frown                                        |
      | Progress Bar validation               | Completeness   | width: 0%; background-color: rgb(249, 7, 7); |
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name           | type   | query | param |
      | SingleItemDelete | Default | EmptyData.xlsx | Import |       |       |
    And user "Deletes" BA Item "EmptyBA" in Item View Page
    And user "click" on "Confirm" button in "Delete Role Popup"

  # MLP 20979 - 7046162,7046164,7046159
  # MLP 21077 - 7053308

  @MLP-21077 @webtest @regression @positive
  Scenario:MLP-21077:SC#5_Validate the changes in Progress Bar in any tab(Business) on removing any filled data.
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                | ItemName         |
      | Enter Excel Importer Name | ParameterRemoval |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action        |
      | setAutoDelay    | 1000          |
      | selectExcelFile | RedSheet.xlsx |
      | setAutoDelay    | 1000          |
      | keyPress        | CONTROL       |
      | keyPress        | V             |
      | keyRelease      | CONTROL       |
      | keyRelease      | V             |
      | setAutoDelay    | 1000          |
      | keyPress        | ENTER         |
      | keyRelease      | ENTER         |
    And User performs following actions in the Excel Importer Page
      | Actiontype           | ActionItem                          |
      | Verify Alert Message | Successful upload of RedSheet.xlsx. |
    And user verifies "Save Button" is "disabled" in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype      | ActionItem | ItemName            | Section  |
      | Select Dropdown | Sheet Name | Sheet1              | As Input |
      | Select Dropdown | Item Type  | BusinessApplication | As Input |
    And User performs following actions in the Excel Importer Page
      | Actiontype | ActionItem |
      | Click      | Checkbox   |
    And user "click" on "Save" button in "Excel Importer Page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                      | ActionItem       | ItemName             | Section |
      | Click Edit,Clone,Run and Delete | ParameterRemoval | Run the excel import |         |
    And user performs following actions in the sidebar
      | actionType | actionItem |
      | click      | DashBoard  |
    And user performs click and verify in new window
      | Table                                  | value | Action               | RetainPrevwindow | indexSwitch |
      | Business Applications with Trust Score | RedBA | click and switch tab | No               |             |
    And User performs following actions in the Item view Page
      | Actiontype                            | ActionItem            | ItemName |
      | click Details in Completeness section | Details Header        |          |
      | Click                                 | Item view Edit Button |          |
    And user validates the change in width percentage after removing "Application ID" parameter under "Details" section in "Business" tab
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                  | type   | query | param |
      | SingleItemDelete | Default | ParameterRemoval.xlsx | Import |       |       |
    And user "Deletes" BA Item "RedBA" in Item View Page
    And user "click" on "Confirm" button in "Delete Role Popup"

    ##7199303##7199304##7199305##7199306##7199309##7199313##
  @MLP-28130 @webtest @regression @positive
  Scenario:MLP-28130:SC#1:Verify Excel Importer popup is launched when the user clicks on the 'Import Business Application via Excel file' button in landing screen
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User validates URL of Demo Data contains "DD/welcome"
    And user "click" on "Import Business Application via Excel file" button in "Welcome page"
    Then user verifies the "Excel Importer" pop up is "displayed"
    And User validates URL of Demo Data contains "DD/welcome"
    And user "click" on "Popup Close" button in "Excel Importer popup"
    And user verifies "Import Business Application via Excel file" is "displayed" in "Welcome page"
    And user "click" on "Import Business Application via Excel file" button in "Welcome page"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem     |
      | Excel Importer Name | ExcelImporter1 |
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
    And user "click" on "first row as column name checkbox" for "ExcelImporter1" in "Manage Excel Imports" page
    And user "click" on "Save" button in "Excel Importer Page"
    And user "verifies presence" of following "Capture and Import Data page Title" in "" page
      | Manage Excel Imports |
    And User validates URL of Demo Data contains "DD/data-capture/excel;excelname=ExcelImporter1"
    And user "Verify Highlighted Excel Import" in "Landing Page"
      | fieldName      | actionItem             |
      | ExcelImporter1 | rgba(157, 157, 157, 1) |

    ##7199307##
  @MLP-28130 @webtest @regression @positive
  Scenario:MLP-28130:SC#2:Verify user should able to redirect to the Manage Excel Imports screen when the excel is saved with the Advanced mapping
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Import Business Application via Excel file" button in "Welcome page"
    Then user verifies the "Excel Importer" pop up is "displayed"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem                |
      | Excel Importer Name | AdvanceMappingExcelImport |
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
    And user "click" on "first row as column name checkbox" for "AdvanceMappingExcelImport" in "Manage Excel Imports" page
    And user "click" on "Advanced Mapping radio button" for "AdvanceExcelImportForTables" in "Manage Excel Imports" page
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
      | Select Scope Values Child  | Link Type            | implementedAs | linkTo     |
    And user "click" on "Save" button in "Excel Importer Page"
    And user "verifies presence" of following "Capture and Import Data page Title" in "" page
      | Manage Excel Imports |

  ##7199310##
  @MLP-28130 @webtest @regression @positive
  Scenario:MLP-28130:SC#3:Verify user adds an excel import with Simple Mapping from the 'Manage Excel Imports' screen the URL should not be changed when showing the popup and after the successful import it should display the 'Manage Excel Imports' screen with same URL
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And User validates URL of Demo Data contains "DD/data-capture/excel"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem          |
      | Excel Importer Name | SimpleExcelImporter |
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
    And user "click" on "2m" for "SimpleExcelImporter" in "Manage Excel Imports" page
    And user "click" on "Save" button in "Excel Importer Page"
    And user "verifies presence" of following "Capture and Import Data page Title" in "" page
      | Manage Excel Imports |
    And User validates URL of Demo Data contains "DD/data-capture/excel"

  ##7199311##
  @MLP-28130 @webtest @regression @positive
  Scenario:MLP-28130:SC#4:Verify when user adds an excel import with Advanced Mapping from the 'Manage Excel Imports' screen the URL should not be changed when showing the popup and after the successful import it should display the 'Manage Excel Imports' screen with same URL
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And User validates URL of Demo Data contains "DD/data-capture/excel"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem                |
      | Excel Importer Name | AdvanceExcelImportMapping |
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
    And user "click" on "first row as column name checkbox" for "AdvanceExcelImportMapping" in "Manage Excel Imports" page
    And user "click" on "Advanced Mapping radio button" for "AdvanceExcelImportMapping" in "Manage Excel Imports" page
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
      | Select Scope Values Child  | Link Type            | implementedAs | linkTo     |
    And user "click" on "Save" button in "Excel Importer Page"
    And user "verifies presence" of following "Capture and Import Data page Title" in "" page
      | Manage Excel Imports |
    And User validates URL of Demo Data contains "DD/data-capture/excel"

  ##7199310##7199312##
  @MLP-28130 @webtest @regression @positive
  Scenario:MLP-28130:SC#5:Verify when user add the import via 'Manage Excel Imports' screen, user should see the 'Manage Excel Imports' screen when import is not saved
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data Link" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Button in Manage Excel Imports Page" button in ""
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem    |
      | Excel Importer Name | ExcelImporter |
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
    And user "click" on "Popup Close" button in "Excel Importer popup"
    And user clicks on "Yes" link in the "Unsaved Changes popup"
    And user "verifies presence" of following "Capture and Import Data page Title" in "" page
      | Manage Excel Imports |
