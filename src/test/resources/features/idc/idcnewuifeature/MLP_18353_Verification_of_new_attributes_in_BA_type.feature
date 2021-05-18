@MLP-18353
Feature:MLP-18353: This feature is to verify Add new attributes to business application item type

  ##6965664##6965666##6965668##
  @MLP-18353 @webtest @regression @positive
  Scenario: SC1#:MLP-18353: Verification of To additional attributes is added for the item type "Business Application"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Click      | EditBAName |
    Then user "verify Item View page attributes" section has following values
      | Application ID | Acronym | Profile Date | Business Criticality | # of Users | Location | Data Source Origin | Internal/External (Third Party) | Authoritative Source | Data Domain | Data Classification | Personal Data | Tier Level |
    And user "enter text" in "Item View page"
      | fieldName      | actionItem     |
      | Application ID | Attribute text |
    And user "verifies sorting order" of following "BA attributes are in ascending order" in "Item View" page
      |  |

  ##6965686##6965687##6965689##6965695##6965692##
  @MLP-18454 @webtest @regression @positive
  Scenario: SC2#:MLP-18353: Verification of To additional attributes is added for the item type "Business Application"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user "verify multiAttribute widgets for BA" section has following values
      | Business | Architecture | Support | Security | Compliance | Data |
    And user "click" on "Item view Tab" for "Architecture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Click      | EditBAName |
    Then user "verify Item View page attributes" section has following values
      | Last Certified | Status |
    Then user "verify Item View page attributes" section has following values
      | Environment | Environment Type | Deployment Style |
    Then user "verify Item View page attributes" section has following values
      | Platforms | EOL Date | Current Version? | Platform Version |
    Then user "verify Item View page attributes" section has following values
      | Languages | EOL Date | Current Version? | Language Version |
    Then user "verify Item View page attributes" section has following values
      | Host Architecture | SDLC Environments | Location | Deployment in Production |
    Then user "verify Item View page attributes" section has following values
      | Services/Interfaces | Input/Output Architecture | Interfaces Protocol | Method |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Click      | SaveBAName |
    And user "click" on "Item view Tab" for "Security" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Click      | EditBAName |
    Then user "verify Item View page attributes" section has following values
      | Entitlements | Platform Access | Level of Access | Role of ISA | Audit Logging |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Click      | SaveBAName |
    And user "click" on "Item view Tab" for "Compliance" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Click      | EditBAName |
    Then user "verify Item View page attributes" section has following values
      | Sensitive Data | Security Classification | IS Risk |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Click      | SaveBAName |

  ##6965664##6965666##6965668##
  @MLP-29985 @webtest @regression @positive
  Scenario: SC1#:MLP-29985: verify whether the user is able to import the values of business location and Physical location through excel importer
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And user "click" on "Add Excel Import" button in "Manage Excel Imports page"
    And user "enter text" in "Landing Page"
      | fieldName           | actionItem       |
      | Excel Importer Name | BANEWFIELDUPDATE |
    And user "click" on "BROWSE FILES" button in "Excel Importer Page"
    And user upload file
      | Method          | Action               |
      | setAutoDelay    | 1000                 |
      | selectExcelFile | BANEWFIELDUPDATE.xls |
      | setAutoDelay    | 1000                 |
      | keyPress        | CONTROL              |
      | keyPress        | V                    |
      | keyRelease      | CONTROL              |
      | keyRelease      | V                    |
      | setAutoDelay    | 1000                 |
      | keyPress        | ENTER                |
      | keyRelease      | ENTER                |
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
      | Click Edit,Clone,Run and Delete | BANEWFIELDUPDATE | Run the excel import |         |
    And user enters the search text "NewFieldUpdate" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype                  | ActionItem        | ItemName    |
      | Verify Details Widget Value | Business Location | Data Center |
    And user "click" on "Item view Tab" for "Architecture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype                  | ActionItem        | ItemName    |
      | Verify Details Widget Value | Physical Location | Data Center |

    ##MLPQA-3276##MLPQA-3277##MLPQA-3275##7261377##7261374####7261375##
  @MLP-29985 @webtest @regression @positive
  Scenario: SC2#:MLP-29985: Verification of To rename of attributes  for "Business Application"
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "NewFieldUpdate" and clicks on search
    And user performs "facet selection" in "BusinessApplication" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Click      | EditBAName |
    Then user "verify Item View page attributes" section has following values
      | Business Location |
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Click      | SaveBAName |
    And user "click" on "Item view Tab" for "Architecture" in "Item View Page"
    And User performs following actions in the Item view Page
      | Actiontype | ActionItem |
      | Click      | EditBAName |
    Then user "verify Item View page attributes" section has following values
      | Physical Location |
