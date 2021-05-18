@MLP-8484
Feature: MLP-8484: Service to get the list of Services

  @MLP-8484 @regression @positive @spreadsheet
  Scenario: MLP-8484_Verification of import service when there is no import
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/catalogs/ImportSpreadSheet?deleteData=true"
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8484_CreateCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    And Status code 204 must be returned
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/import/spreadsheets?catalogname=ImportSpreadSheet"
    And Status code 200 must be returned
    And empty response body should be displayed

  @MLP-8484 @regression @positive @spreadsheet
  Scenario: MLP-8484_Verification of getting list of imports
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/ImportFile.xls" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8484_updateSpreadSheet.json" file for following values
      | jsonPath                | jsonValues        |
      | $..['sheet']            | Sheet1            |
      | $..['catalog']          | ImportSpreadSheet |
      | $..['importedItemType'] | BusinessTerm      |
      | $..['status']           | TRIGGERED         |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8484_updateSpreadSheet.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8484_updateSpreadSheet.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8484_updateSpreadSheet.json" for following values using "db values"
      | jsonPath        |
      | $..['fileName'] |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8484_updateSpreadSheet.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user makes a recursive REST Call for GET request "/import/spreadsheets?catalogname=ImportSpreadSheet" till the status becomes "COMPLETED" with maximum threshhold of "5" times
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues     | jsonPath        |
      | ImportFile.xls | $..['fileName'] |

  @MLP-8484 @regression @positive @spreadsheet
  Scenario: MLP-8484_Verification of deleting the imported Item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/import/spreadsheets?catalogname=ImportSpreadSheet"
    And Status code 200 must be returned
    And user stores the value from response using jsonpath"$.[-1:].id"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "import/spreadsheets/storedText" and path ""
    And Status code 200 must be returned
    And deleted bundle "ImportFile.xls" should not be present in database
      | description | schemaName        | tableName | columnName | criteriaName |
      | SELECT      | ImportSpreadSheet | V_Import  | *          | fileName     |

  @MLP-8484 @regression @positive @spreadsheet
  Scenario: MLP-8484_Verification of getting an invalid item details
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/import/spreadsheets/ImportSpreadSheet.Import%3A%3A%3A134/content"
    And Status code 404 must be returned
    And user compares the following value from response using json path
      | jsonValues                                                 | jsonPath            |
      | Item with id ImportSpreadSheet.Import:::134 does not exist | $..['errorMessage'] |

  @MLP-8484 @sanity @positive @spreadsheet
  Scenario: Deleting Catalog ImportSpreadSheet
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/catalogs/ImportSpreadSheet?deleteData=true"