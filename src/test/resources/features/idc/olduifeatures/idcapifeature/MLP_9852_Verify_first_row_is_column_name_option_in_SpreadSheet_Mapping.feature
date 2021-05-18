@MLP-9852
Feature: MLP-9852: Provide first row is column name option in Spreadsheet Mapping screen

  @MLP-9852 @regression @positive @spreadsheet
  Scenario: MLP-9852_Verification of import service when there is no import
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

  @MLP-9852 @regression @positive @spreadsheet
  Scenario: MLP-9852-Verification getting columns from an xlsx file by enabling the containsColumnHeader option
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/NewTerms.xlsx" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Business Term", "Description", "Definition" ]"

  @MLP-9852 @regression @positive @spreadsheet
  Scenario: MLP-9852-Verification getting columns from an xlsx file by disabling the containsColumnHeader option
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/NewTerms.xlsx" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=false" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "ColumnA", "ColumnB", "ColumnC" ]"

  @MLP-9852 @regression @positive @spreadsheet
  Scenario: MLP-9852-Verification getting columns from an xls file by enabling the containsColumnHeader option
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/NewTerm.xls" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Business Term", "Description", "Definition" ]"

  @MLP-9852 @regression @positive @spreadsheet
  Scenario: MLP-9852-Verification getting columns from an xls file by disabling the containsColumnHeader option
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/NewTerm.xls" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=false" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "ColumnA", "ColumnB", "ColumnC" ]"

  @MLP-9852 @sanity @positive @regression @hbase
  Scenario: Deleting Catalog ImportSpreadSheet
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/catalogs/ImportSpreadSheet?deleteData=true"
