#@MLP-15774
#Feature:MLP-15774: As a IDA User, I need to Run the Save / Recent search records so that user can see the search results
#
##  @MLP-15774 @regression @positive    #######Descoped####
#  Scenario:SC#1:MLP-15774: Creation of Multiple catalogs and items for test suite validation
#    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-15774_Creating_Multiple_Catalogs.json"
#    And user makes a REST Call for POST request with url "settings/catalogs"
#    And Status code 204 must be returned
#    And configure a new REST API for the service "IDC"
#    And A query param with "allowUpdate" and "false" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-15774_Multiple_Items_Creation.json"
#    And user makes a REST Call for POST request with url "items/CatalogTest/root"
#    And Status code 200 must be returned
#    And user makes a REST Call for POST request with url "searches/fulltext/synchronize/CatalogTest"
#    And Status code 200 must be returned
#    And configure a new REST API for the service "IDC"
#    And A query param with "allowUpdate" and "false" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-15774_Multiple_Items_Creation.json"
#    When user makes a REST Call for POST request with url "items/CatalogMock/root"
#    And Status code 200 must be returned
#    And user makes a REST Call for POST request with url "searches/fulltext/synchronize/CatalogMock"
#    And Status code 200 must be returned
#
#   ##6886011####Duplicate to MLP-15295
#  @MLP-15774 @webtest @regression @positive
#  Scenario:SC#1:MLP-15774: Verify if Run Saved Search Title, Close and Cancel function
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem          |
#      | click      | Run Search dropdown |
#      | click      | Run Saved Search    |
#    And user verifies the "Run Saved Search" pop up is "displayed"
#    And user verifies "Run Saved Search table" is "displayed"
#    And user "click" on "Cancel button" button in "Run Saved Search popup"
#    And user performs following actions in the header
#      | actionType | actionItem          |
#      | click      | Run Search dropdown |
#      | click      | Run Saved Search    |
#    And user "click" on "Close button" button in "Run Saved Search popup"
#
#
##   ##6873785##6873789##6873790###descoped
#  @MLP-15774 @webtest @regression @positive
#  Scenario:SC#2:MLP-15774: Save Search with multiple catalog results and view the Run Saved Search screen displays the Saved Search
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | globalSearchButton |
#    And user "selects" for the following filter in search results page
#      | FilterType    | FilterValues |
#      | Catalog       | CatalogTest  |
#      | Catalog       | CatalogMock  |
#    Then results panel "items count" should be displayed as "10 Results for "Catalogmock, Catalogtest"" in Item Search results page
#    And user performs following actions in the header
#      | actionType | actionItem   |
#      | click      | SAVE SEARCH  |
#    And user verifies the "Save Search" pop up is "displayed"
#    And user "enter text" in the "Save Search" Page
#      | fieldName   | attribute             |
#      | Name        | Two Catalogs Search   |
#      | Description | MultiItems Search     |
#    And user "click" on "Save Search Result" button in "Save Search page"
#    And user performs following actions in the header
#      | actionType | actionItem          |
#      | click      | Global Search Icon  |
#      | click      | Run Search dropdown |
#      | click      | Run Saved Search    |
#    And user verifies whether following parameters is "displayed" in Run Search Page
#      | searchName           |
#      | Two Catalogs Search  |
#    And user "click" on "Run" button in "Run Saved Search page"
#    Then results panel "items count" should be displayed as "10 Results for "Catalogmock, Catalogtest"" in Item Search results page
#
#
#   ##6873786##6873787##6873789##6873790###descoped
#  @MLP-15774 @webtest @regression @positive
#  Scenario:SC#3:MLP-15774: Save Search with Single catalog results and view the Run Saved Search screen displays the Saved Search
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | globalSearchButton |
#    And user "selects" for the following filter in search results page
#      | FilterType    | FilterValues          |
#      | Catalog       | CatalogTest           |
#      | MetaData Type | Cluster               |
#    And user "verifies displayed" with count as "2 Results for " catalog "Catalogtest" in Search results page
#    And user performs following actions in the header
#      | actionType | actionItem   |
#      | click      | SAVE SEARCH  |
#    And user verifies the "Save Search" pop up is "displayed"
#    And user "enter text" in the "Save Search" Page
#      | fieldName   | attribute          |
#      | Name        | One Catalog Search |
#      | Description | Items Search       |
#    And user "click" on "Save Search Result" button in "Save Search page"
#    And user performs following actions in the header
#      | actionType | actionItem          |
#      | click      | Global Search Icon  |
#      | click      | Run Search dropdown |
#      | click      | Run Saved Search    |
#    And user verifies whether following parameters is "displayed" in Run Search Page
#      | searchName         |
#      | One Catalog Search |
#    And user "click" on "Run" button in "Run Saved Search page"
#    And user "verifies displayed" with count as "2 Results for " catalog "Catalogtest" in Search results page
#
#   ##6873788##6873789##6873790###descoped
#  @MLP-15774 @webtest @regression @positive
#  Scenario:SC#4:MLP-15774: From Search results filter the search by Facets to Save the Search and verify Run Saved Search screen displays the Saved Search
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#    And user "enter text" in "Dashboard Search Page"
#      | fieldName   | actionItem |
#      | Search Area | Cluster    |
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | globalSearchButton |
#    And user "selects" for the following filter in search results page
#      | FilterType    | FilterValues |
#      | Catalog       | CatalogTest  |
#      | Catalog       | CatalogMock  |
#    And user "verifies displayed" with count as "4 Results for " catalog "CatalogMock, CatalogTest" in Search results page
#    And user performs following actions in the header
#      | actionType | actionItem   |
#      | click      | SAVE SEARCH  |
#    And user verifies the "Save Search" pop up is "displayed"
#    And user "enter text" in the "Save Search" Page
#      | fieldName   | attribute         |
#      | Name        | Cluster Search    |
#      | Description | Keyword Search    |
#    And user "click" on "Save Search Result" button in "Save Search page"
#    And user performs following actions in the header
#      | actionType | actionItem          |
#      | click      | Global Search Icon  |
#      | click      | Run Search dropdown |
#      | click      | Run Saved Search    |
#    And user verifies whether following parameters is "displayed" in Run Search Page
#      | searchName     |
#      | Cluster Search |
#    And user "click" on "Run" button in "Run Saved Search page"
#    And user "verifies displayed" with count as "4 Results for " catalog "CatalogMock, CatalogTest" in Search results page
#
#
#    ##6873788##6873789##6873790###descoped
#  @MLP-15774 @webtest @regression @positive
#  Scenario:SC#5:MLP-15774: Delete the Saved Search from UI
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | globalSearchButton |
#    And user "selects" for the following filter in search results page
#      | FilterType    | FilterValues |
#      | Catalog       | CatalogTest  |
#      | Catalog       | CatalogMock  |
#    And user "verifies displayed" with count as "10 Results for " catalog "CatalogMock, CatalogTest" in Search results page
#    And user performs following actions in the header
#      | actionType | actionItem   |
#      | click      | SAVE SEARCH  |
#    And user verifies the "Save Search" pop up is "displayed"
#    And user "enter text" in the "Save Search" Page
#      | fieldName   | attribute          |
#      | Name        | Multi Search       |
#      | Description | MultiItems Search  |
#    And user "click" on "Save Search Result" button in "Save Search page"
#    And user performs following actions in the header
#      | actionType | actionItem          |
#      | click      | Global Search Icon  |
#      | click      | Run Search dropdown |
#      | click      | Run Saved Search    |
#    And user verifies whether following parameters is "deleted" in Run Search Page
#      | searchName   |
#      | Multi Search |
#    And user "click" on "DELETE SAVED SEARCH" button in "Run Saved Search page"
#
#      ##6886009##6886008###descoped
#  @MLP-15774 @webtest @regression @positive
#  Scenario:SC#6:MLP-15774: Verify if user can select a Recent Search and Run it again
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem         |
#      | click      | Global Search Icon |
#      | click      | globalSearchButton |
#    And user "selects" for the following filter in search results page
#      | FilterType    | FilterValues |
#      | Catalog       | CatalogTest  |
#    And user performs following actions in the header
#      | actionType | actionItem          |
#      | click      | Global Search Icon  |
#      | click      | Run Search dropdown |
#      | click      | Run Recent Search   |
#    And user verifies whether following parameters is "displayed" in Run Search Page
#      | searchName   |
#      | CatalogTest  |
#    And user "click" on "Run" button in "Run Saved Search page"
#
#    ##6886010## ##Duplicate to MLP-15295
#  @MLP-15774 @webtest @regression @positive
#  Scenario:SC#7:MLP-15774: Verify if Run Recent Search Title, Close and Cancel function
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user performs following actions in the header
#      | actionType | actionItem          |
#      | click      | Run Search dropdown |
#      | click      | Run Recent Search   |
#    And user verifies the "Run Recent Search" pop up is "displayed"
#    And user verifies "Run Recent Search table" is "displayed"
#    And user "click" on "Cancel button" button in "Run Recent Search popup"
#    And user performs following actions in the header
#      | actionType | actionItem          |
#      | click      | Run Search dropdown |
#      | click      | Run Recent Search   |
#    And user "click" on "Close button" button in "Run Recent Search popup"

