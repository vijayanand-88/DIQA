@MLP-19639 @MLP-23642
Feature: MLP-19639 @MLP-23642: Verification of Improvements in Excel Importer

  ##7033126##
  @MLP-19639 @regression @positive @dashboard
  Scenario:MLP-6391:SC#1: Verify if using POST service - user can import the Sheet using API - /import/spreadsheets/{catalogname}/content.
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                 | body                         | response code | response message | jsonPath |
      | application/json |       |       | Post | import/spreadsheets/Default/content | excelupload/Sample File.xlsx | 200           |                  |          |

  ##7033127##
  @MLP-19639 @regression @positive @dashboard
  Scenario Outline:SC#2: Verify if user can GET the list of Column names imported using the Saved ID GET/import/spreadsheets/{id}/columns
    Given user get the column "Sample File.xlsx" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName | criteriaAttribute       |
      | SELECT      | public     | items     | Import   | id         |              | attributes->>'fileName' |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    Then Status code 200 must be returned
    Then Json response message should contains the following value
      | responseMessage |
      | Cluster         |
      | Service         |
      | DB name         |
      | Description     |
      | no of tables    |
      | storage type    |
      | location        |
    Examples:
      | contentType         | acceptType       | type | url                                         | endpoint                                              | body |
      | multipart/form-data | application/json | Get  | import/spreadsheets/Default.Import%3A%3A%3A | /columns?sheetName=Database&containsColumnHeader=true |      |

  ##7033128##
  @MLP-19639 @regression @positive
  Scenario Outline: MLP-19639:SC#3: Verify if user can PUT/Modify the imported excel with new sheet Tables using API - /import/spreadsheets
    Given user get the column "Sample File.xlsx" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName | criteriaAttribute       |
      | SELECT      | public     | items     | Import   | id         |              | attributes->>'fileName' |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And Status code 200 must be returned
    And user update the json file "idc/ExcelUploadPayloads/MLP_19639_updateSpreadSheet.json" for following values using "response"
      | jsonPath    |
      | $..['id']   |
      | $..['name'] |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/ExcelUploadPayloads/MLP_19639_updateSpreadSheet.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    Examples:
      | contentType         | acceptType       | type | url                                         | endpoint | body |
      | multipart/form-data | application/json | Get  | import/spreadsheets/Default.Import%3A%3A%3A |          |      |

  ##7033129##
  @MLP-19639 @regression @positive @dashboard
  Scenario Outline:SC#4: Verify if user can see the attributes - "sheet": "Tables", "importedItemType": "Table" in response body of GET /import/spreadsheets/{id}
    Given user get the column "Sample File.xlsx" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName | criteriaAttribute       |
      | SELECT      | public     | items     | Import   | id         |              | attributes->>'fileName' |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    Then Status code 200 must be returned
    Then Json response message should contains the following value
      | responseMessage            |
      | sheet" : "Tables           |
      | importedItemType" : "Table |
    Examples:
      | contentType         | acceptType       | type | url                                         | endpoint | body |
      | multipart/form-data | application/json | Get  | import/spreadsheets/Default.Import%3A%3A%3A |          |      |

    ##7033130##
  @MLP-19639 @webtest @regression @positive
  Scenario:SC#5:MLP-19639: Verify if in UI Selecting Metadata type 'Database' and Database names 'healthcare, finance, Payments, Customers' are listed
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Hive  [Service]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | Finance    |
      | Payments   |
      | Customers  |
      | healthcare |

    ##7033131##
  @MLP-19639 @webtest @regression @positive
  Scenario:SC#6:MLP-19639: Verify if in UI Selecting Metadata type 'Table' and Table names 'albums, product, TopSellers, customergenres' are listed
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Hive  [Service]" attribute under "Hierarchy" facets in Item Search results page
    Then user "verify presence" of following "Items List" in Item Search Results Page
      | invoices       |
      | product        |
      | albums         |
      | customergenres |
      | customers      |
      | TopSellers     |
      | Transactions   |
      | store          |
      | genres         |

    ##7033132##
  @MLP-19639 @webtest @regression @positive
  Scenario:SC#7:MLP-19639: Verify if searching on Database item 'Payments' - and is displayed with hierarchy 'Hierarchy ClusterDemo > Service > Hive'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Payments" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Hive  [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user "verify presence" of following "hierarchy" in Item Search Results Page
      | ClusterDemo |
      | Hive        |
      | Payments    |

  ##7033133##
  @MLP-19639 @webtest @regression @positive
  Scenario:SC#8:MLP-19639: Verify if searching on Table item 'albums' - and is displayed with hierarchy 'Hierarchy ClusterDemo > Service Hive > Database > healthcare'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "albums" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Hive  [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user "verify presence" of following "hierarchy" in Item Search Results Page
      | ClusterDemo |
      | Hive        |
      | healthcare  |
      | albums      |

  ##7033134##
  @MLP-19639 @webtest @regression @positive
  Scenario:SC#9:MLP-19639: Verify if 'albums' table item has the tag 'SellerInfo'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user clicks on search icon
    Then user "verify tag item presence" of technology tags for the below Type and file names
      | catalogName | name       | facet | Tag        | fileName | userTag |
      | Default     | SellerInfo | Tags  | SellerInfo | albums   |         |

  ##7033135##
  @MLP-19639 @webtest @regression @positive
  Scenario:SC#10:MLP-19639: Verify if item 'albums' itemview has 'Has_Relationship (1)' table
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "albums" and clicks on search
    And user performs "facet selection" in "Database" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Hive  [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item on the item list page
    And user verifies "Widget Header Title presense" for "has_Relationship (1)" in Item view page

  ##7033136##
  @MLP-19639 @webtest @regression @positive
  Scenario:SC#11:MLP-19639: Verify if item 'Transactions' itemview does not have 'Has_Relationship (1)' table
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "Transactions" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Hive  [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item on the item list page
    And user verifies "Widget absense" for "has_Relationship (1)" in Item view page

    ##7033137##
  @MLP-19639 @webtest @regression @positive
  Scenario:SC#12:MLP-19639: Verify if albums item view - Related Tables has the relation to different DB tables 'From albums , To product'
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text "albums" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user performs "facet selection" in "Hive  [Service]" attribute under "Hierarchy" facets in Item Search results page
    And user clicks on first item on the item list page
    Then user performs click and verify in new window
      | Table            | value         | Action               | RetainPrevwindow | indexSwitch |
      | has_Relationship | RelatedTables | click and switch tab | No               |             |
    Then user performs click and verify in new window
      | Table | value   | Action                 | RetainPrevwindow | indexSwitch |
      | from  | albums  | verify widget contains | No               |             |
      | to    | product | verify widget contains | No               |             |

  ##7112251##
  @MLP-23642 @regression @positive @dashboard
  Scenario:MLP-23642:SC#1: Verify if user can upload the excel sheet POST/import/spreadsheets/{catalogname}/content (Enter Catalog and Import Name) Upload the attached excel file
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | multipart/form-data                            |
      | Accept        | application/json                               |
      | Authorization | Basic RGl2eWEuQmhhcmF0aGk6QmVoYXBweUAjNDU2Nzg= |
    And user attaches/upload file "excelupload/Stich_and_copy_excel.xlsx" to request
    And user makes a REST Call for POST request with url "import/spreadsheets/Default/content?name=StichAndCopyExcelUpload"
    And Status code 200 must be returned

  ##7112254##
  @MLP-23642 @regression @positive @dashboard
  Scenario Outline:SC#2:23642: Verify if user can verify if the GET/import/spreadsheets/{id}/columns - displays the Tables sheet column names in response body (verify any two column names)
    Given user get the column "Stich_and_copy_excel.xlsx" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName | criteriaAttribute       |
      | SELECT      | public     | items     | Import   | id         |              | attributes->>'fileName' |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    Then Status code 200 must be returned
    Then Json response message should contains the following value
      | responseMessage |
      | Cluster         |
      | Service         |
    Examples:
      | contentType         | acceptType       | type | url                                         | endpoint                                            | body |
      | multipart/form-data | application/json | Get  | import/spreadsheets/Default.Import%3A%3A%3A | /columns?sheetName=Tables&containsColumnHeader=true |      |

  ##7112252##7112257##7112258##
  @MLP-23642 @regression @positive
  Scenario Outline: MLP-23642:SC#3: Verify if user can use PUT/import/spreadsheets - Append the Import ID, Import Name and Excel File Name to the request json attached to Steps
    Given user get the column "Stich_and_copy_excel.xlsx" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName | criteriaAttribute       |
      | SELECT      | public     | items     | Import   | id         |              | attributes->>'fileName' |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And Status code 200 must be returned
    And user update the json file "idc/ExcelUploadPayloads/MLP_23642_updateSpreadSheet.json" for following values using "response"
      | jsonPath        |
      | $..['id']       |
      | $..['name']     |
      | $..['fileName'] |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/ExcelUploadPayloads/MLP_23642_updateSpreadSheet.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    Examples:
      | contentType         | acceptType       | type | url                                         | endpoint | body |
      | multipart/form-data | application/json | Get  | import/spreadsheets/Default.Import%3A%3A%3A |          |      |

  ##7112259##7112260##7112261##7112262##7112263##
  @MLP-23642 @webtest @regression @positive
  Scenario:SC#4:MLP-23642: Verify in the UI user can search for 'albums1' item
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text " albums1" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "click" the slider to "10" in "SCOPE" section in diagramming page
    And user verifies the "Lineage Icon" is "displayed"
    And user mouse hover on "Copy Lineage Icon" edge icon and click lineage hop info icon
    And user "verifies hop content" in Diagramming Page
      | fieldName | attribute          |
      | Title     | albums1 > product1 |
      | Mode      | Copy               |
    And user "click" on "Item info Close" icon in LineageDiagramming page
    And user mouse hover on "Stich Lineage Icon" edge icon and click lineage hop info icon
    And user "verifies hop content" in Diagramming Page
      | fieldName | attribute         |
      | Title     | product1 > store1 |
      | Mode      | Stitch            |
    And user "click" on "Item info Close" icon in LineageDiagramming page

  ##7112266##7112267##7112268##
  @MLP-23642 @webtest @regression @positive
  Scenario:SC#5:MLP-23642:Verify in the UI user can search for 'genres1' item and navigate to Lineage tab
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And user enters the search text " genres1" and clicks on search
    And user performs "facet selection" in "Table" attribute under "Metadata Type" facets in Item Search results page
    And user clicks on first item on the item list page
    And user "click" on "Lineage" tab in Overview page
    And user "click" the slider to "10" in "SCOPE" section in diagramming page
    And user verifies the "Lineage Icon" is "displayed"
    And user mouse hover on "Stich Lineage Icon" edge icon and click lineage hop info icon
    And user "verifies hop content" in Diagramming Page
      | fieldName | attribute        |
      | Title     | genres1 > store1 |
      | Mode      | Stitch           |
    And user "click" on "Item info Close" icon in LineageDiagramming page

  @MLP-23642 @regression @positive
  Scenario: MLP-23642:Delete the uploaded excel sheet
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name                    | type   | query | param |
      | SingleItemDelete | Default | StichAndCopyExcelUpload | Import |       |       |


