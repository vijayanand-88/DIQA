@MLP-15295 @MLP-15180
Feature:MLP-15295 MLP-15180: This feature is to verify SEARCH DROPDOWN - As an IDA Admin, I was to be able to see search dropdown for run searches- UI changes

  ##6866124##  ##6868572##6868588##  ##6866155##
  @MLP-15295 @webtest @regression @positive
  Scenario:SC#1:MLP-15295:Verify the X icon to clear the search data
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-12929_SingleParam_false.json"
    When user makes a REST Call for POST request with url "settings/eula/accept"
    And Status code 204 must be returned
    And supply payload with file name "idc/IDx_DataSource_Credentials_Payloads/MLP-13697_Default_empty_view.json"
    When user makes a REST Call for POST request with url "settings/preferences/form"
    And Status code 204 must be returned
    And User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user "click" on "AGREE" button in "License page"
    And user "enter text" in "Manage DataSource popup"
      | fieldName   | actionItem |
      | Search Area | Customer   |
    And user performs following actions in the header
      | actionType             | actionItem          |
      | click                  | Search Cross button |
      | verifies not displayed | Search Text         |
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Run Search dropdown |
    And user "verify submenus" for the following submenus under "Search" menu
      | Run Saved Search  |
      | Run Recent Search |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Run Recent Search |
    And user verifies the "Run Recent Search" pop up is "displayed"
    And user verifies "Run Recent Search table" is "displayed"
    And user "click" on "Popup Close button" button in "Run Recent Search popup"
    And user verifies "Welcome message under settings icon" is "displayed" in "Welcome page"

  ##6868589##  ##6868578##
  @MLP-15180 @webtest @regression @positive
  Scenario:SC#2:MLP-15180: Verify that the Run Recent Search table is displayed
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Run Search dropdown |
    And user performs following actions in the sidebar
      | actionType | actionItem        |
      | click      | Run Recent Search |
    And user verifies the "Run Recent Search" pop up is "displayed"
    And user verifies "Run Recent Search table" is "displayed"
    And user "click" on "Cancel button" button in "Run Recent Search popup"
    And user verifies "Welcome message under settings icon" is "displayed" in "Welcome page"

    ####Descoped###

#  ##6863343##6863346##6863347##6863348###descoped
#  @MLP-15541 @webtest @regression @positive
#  Scenario:SC#6:MLP-15541: Verify that the user can select multiple catalogs and it is displayed in the search box
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user select "BigData" catalog and search "" items at top end
#    Then results panel "catalog search result" should be displayed as "Bigdata" in Item Search results page
#    And user select "Business Glossary" catalog and search "" items at top end
#    Then results panel "catalog search result" should be displayed as "Bigdata, Businessglossary" in Item Search results page
#    And user "verifies the selected attributes" for the following filter in search results page
#      | FilterType | FilterValues     |
#      | Catalog    | BigData          |
#      | Catalog    | BusinessGlossary |
#    And user select "Business Glossary" catalog and search "" items at top end
#    And user "verifies the selected attributes" for the following filter in search results page
#      | FilterType | FilterValues |
#      | Catalog    | BigData      |
#    And user select "BigData" catalog and search "" items at top end
#    And user performs following actions in the header
#      | actionType | actionItem    |
#      | click      | Search Button |
#    Then results panel "catalog search result" should be displayed as "Results for" in Item Search results page

  ##6881464##
  @MLP-13787 @webtest @regression @positive
  Scenario:SC#7:MLP-13787 : verify that Tool tip is displaying for the seraches in the Run Recent Search page
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user "click" on "Search Results Show more options" for "Save Search" in "Search results page"
    And user "enter text" in "Save Search popup"
      | fieldName                       | actionItem                                                         |
      | Save Search Name textbox        | Customer1                                                          |
      | Save Search description textbox | This is sample text with multiple line description for save search |
    And user "click" on "Save Search Save Button" button in "Save Search pop up"
    And user performs following actions in the sidebar
      | actionType | actionItem          |
      | click      | Run Search dropdown |
      | click      | Run Saved Search    |
    And user waits for the final status to be reflected after "2000" milliseconds
    And user verifies "Save Search tooltip validation" is displayed under the fields in "Run Save Search" Popup
      | fieldName | validationMessage                                                  |
      | Customer1 | This is sample text with multiple line description for save search |

  ##6881486##
  @MLP-13787 @webtest @regression @positive
  Scenario:SC#8:MLP-13787 : Verification of creating a save search with name as forward and backward slash (forbiden characters).
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user "click" on "Search Results Show more options" for "Save Search" in "Search results page"
    And user "enter text" in "Save Search popup"
      | fieldName                | actionItem |
      | Save Search Name textbox | /Test      |
    And user verifies "validation message" is displayed under the fields in "Save Search" Popup
      | fieldName | validationMessage                                                            |
      | Name      | Invalid name. Leading/trailing blanks, '/' and '\' characters are forbidden. |
    And user verifies "Save Search Save Button" is "disabled" in "Save Search pop up"
    And user "enter text" in "Save Search popup"
      | fieldName                | actionItem |
      | Save Search Name textbox | Test\      |
    And user verifies "validation message" is displayed under the fields in "Save Search" Popup
      | fieldName | validationMessage                                                            |
      | Name      | Invalid name. Leading/trailing blanks, '/' and '\' characters are forbidden. |
    And user verifies "Save Search Save Button" is "disabled" in "Save Search pop up"

  ##6881495##
  @MLP-13787 @webtest @regression @positive
  Scenario:SC#9:MLP-13787 : Verification of creating a save search with name as Leading and Trailing space (forbiden characters).
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user "click" on "Search Results Show more options" for "Save Search" in "Search results page"
    And user "enter text" in "Save Search popup"
      | fieldName                            | actionItem |
      | Leading space in Save Search textbox | Test       |
    And user verifies "validation message" is displayed under the fields in "Save Search" Popup
      | fieldName | validationMessage                                                            |
      | Name      | Invalid name. Leading/trailing blanks, '/' and '\' characters are forbidden. |
    And user verifies "Save Search Save Button" is "disabled" in "Save Search pop up"
    And user "enter text" in "Save Search popup"
      | fieldName                             | actionItem |
      | Trailing space in Save Search textbox | Test       |
    And user verifies "validation message" is displayed under the fields in "Save Search" Popup
      | fieldName | validationMessage                                                            |
      | Name      | Invalid name. Leading/trailing blanks, '/' and '\' characters are forbidden. |
    And user verifies "Save Search Save Button" is "disabled" in "Save Search pop up"