@MLP-8488
Feature: MLP-8488: Perform the actual import

  //Bug id:MLP-13080

  @MLP-8488 @regression @positive @spreadsheet
  Scenario: MLP-8488 Creating Data Catalog ImportSpreadSheet
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/catalogs/ImportSpreadSheet?deleteData=true"
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8787_CreateDataCatalog.json"
    When user makes a REST Call for POST request with url "/settings/catalogs"
    And Status code 204 must be returned

  @webtest @MLP-8488 @regression @positive @spreadsheet
  Scenario: MLP-8488 #6577888 Verification of sending and updating an xls file and sending actual import for an updated xls file
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/Test.xls" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsSpreadSheet.json" file for following values
      | jsonPath                | jsonValues        |
      | $..['sheet']            | Sheet1            |
      | $..['catalog']          | ImportSpreadSheet |
      | $..['importedItemType'] | BusinessTerm      |
      | $..['status']           | TRIGGERED         |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsSpreadSheet.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsSpreadSheet.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsSpreadSheet.json" for following values using "db values"
      | jsonPath        |
      | $..['fileName'] |
    And user stores the value from response using jsonpath"$..['id']"
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsSpreadSheet.json" for following values using "db values"
      | jsonPath  |
      | $..['id'] |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Name", "Description", "Definition" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsSpreadSheet.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user makes a recursive REST Call for GET request "/import/spreadsheets?catalogname=ImportSpreadSheet" till the status becomes "COMPLETED" with maximum threshhold of "8" times
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues        | jsonPath         |
      | Test.xls          | $.[-1:].fileName |
      | COMPLETED         | $.[-1:].status   |
      | ImportSpreadSheet | $.[-1:].catalog  |
      | Sheet1            | $.[-1:].sheet    |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "COMPLETED" value are same
    And user stores the value from response using jsonpath"$..['id']"
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on notification icon in the left panel
    And "Spreadsheet import finished!" notification should have content "Import COMPLETED" in the notifications tab
    And user "click" on open statistic link for "Spreadsheet import finished!" in notifications panel
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "IMPORT EXECUTION" section for the "Test.xls"
      | notificationPropertyName | notificationPropertyValue |
      | Status                   | COMPLETED                 |
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "ITEM IMPORT STATISTICS" section for the "Test.xls"
      | notificationPropertyName | notificationPropertyValue |
      | Total                    | 5                         |
      | Type                     | BusinessTerm              |
    And user verifies "IMPORT EXECUTION" section in Notification panel has following values
      | Execution |
      | Duration  |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "/import/spreadsheets/storedText" and path ""
    And configure a new REST API for the service "IDC"
    And  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/Test_Updated.xls" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsSpreadSheet.json" file for following values
      | jsonPath                | jsonValues        |
      | $..['sheet']            | Sheet1            |
      | $..['catalog']          | ImportSpreadSheet |
      | $..['importedItemType'] | BusinessTerm      |
      | $..['status']           | TRIGGERED         |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsSpreadSheet.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsSpreadSheet.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsSpreadSheet.json" for following values using "db values"
      | jsonPath        |
      | $..['fileName'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Name", "Description", "Definition" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsSpreadSheet.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user makes a recursive REST Call for GET request "/import/spreadsheets?catalogname=ImportSpreadSheet" till the status becomes "COMPLETED" with maximum threshhold of "8" times
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues        | jsonPath         |
      | Test_Updated.xls  | $.[-1:].fileName |
      | COMPLETED         | $.[-1:].status   |
      | ImportSpreadSheet | $.[-1:].catalog  |
      | Sheet1            | $.[-1:].sheet    |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "COMPLETED" value are same
    And user stores the value from response using jsonpath"$..['id']"
#    And user clicks on sign in as a different user link
#    And user enter credentials for "System Administrator1" role
    And user clicks on home button
    And user clicks on notification icon in the left panel
    And "Spreadsheet import finished!" notification should have content "Import COMPLETED" in the notifications tab
    And user "click" on open statistic link for "Spreadsheet import finished!" in notifications panel
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "IMPORT EXECUTION" section for the "Test_Updated.xls"
      | notificationPropertyName | notificationPropertyValue |
      | Status                   | COMPLETED                 |
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "ITEM IMPORT STATISTICS" section for the "Test_Updated.xls"
      | notificationPropertyName | notificationPropertyValue |
      | Total                    | 7                         |
      | Type                     | BusinessTerm              |
    And user verifies "IMPORT EXECUTION" section in Notification panel has following values
      | Execution |
      | Duration  |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "/import/spreadsheets/storedText" and path ""

  @webtest @MLP-8488 @regression @positive @spreadsheet
  Scenario: MLP-8488 #6577556 Verification of performing the actual import for an xlsx file and actual import for an updated xlsx file
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/Test.xlsx" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsxSpreadSheet.json" file for following values
      | jsonPath                | jsonValues        |
      | $..['sheet']            | Sheet1            |
      | $..['catalog']          | ImportSpreadSheet |
      | $..['importedItemType'] | BusinessTerm      |
      | $..['status']           | TRIGGERED         |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsxSpreadSheet.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsxSpreadSheet.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsxSpreadSheet.json" for following values using "db values"
      | jsonPath        |
      | $..['fileName'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Term", "Description" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsxSpreadSheet.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user makes a recursive REST Call for GET request "/import/spreadsheets?catalogname=ImportSpreadSheet" till the status becomes "COMPLETED" with maximum threshhold of "5" times
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues        | jsonPath         |
      | Test.xlsx         | $.[-1:].fileName |
      | COMPLETED         | $.[-1:].status   |
      | ImportSpreadSheet | $.[-1:].catalog  |
      | Sheet1            | $.[-1:].sheet    |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "COMPLETED" value are same
    And user stores the value from response using jsonpath"$..['id']"
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on notification icon in the left panel
    And "Spreadsheet import finished!" notification should have content "Import COMPLETED" in the notifications tab
#    And "Spreadsheet import finished!" notification should have content "Import COMPLETED" in the notifications tab
    And user "click" on open statistic link for "Spreadsheet import finished!" in notifications panel
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "IMPORT EXECUTION" section for the "Test.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Status                   | COMPLETED                 |
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "ITEM IMPORT STATISTICS" section for the "Test.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Total                    | 5                         |
      | Type                     | BusinessTerm              |
    And user verifies "IMPORT EXECUTION" section in Notification panel has following values
      | Execution |
      | Duration  |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "/import/spreadsheets/storedText" and path ""
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "/import/spreadsheets/storedText" and path ""
    And  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/Test_Updated.xlsx" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsxSpreadSheet.json" file for following values
      | jsonPath                | jsonValues        |
      | $..['sheet']            | Sheet1            |
      | $..['catalog']          | ImportSpreadSheet |
      | $..['importedItemType'] | BusinessTerm      |
      | $..['status']           | TRIGGERED         |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsxSpreadSheet.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsxSpreadSheet.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsxSpreadSheet.json" for following values using "db values"
      | jsonPath        |
      | $..['fileName'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Term", "Description" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8488_updatexlsxSpreadSheet.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user makes a recursive REST Call for GET request "/import/spreadsheets?catalogname=ImportSpreadSheet" till the status becomes "COMPLETED" with maximum threshhold of "5" times
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues        | jsonPath         |
      | Test_Updated.xlsx | $.[-1:].fileName |
      | COMPLETED         | $.[-1:].status   |
      | ImportSpreadSheet | $.[-1:].catalog  |
      | Sheet1            | $.[-1:].sheet    |
    And user stores the value from response using jsonpath"$..['id']"
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "COMPLETED" value are same
    And user stores the value from response using jsonpath"$..['id']"
#    And user clicks on sign in as a different user link
#    And user enter credentials for "System Administrator1" role
    And user clicks on home button
    And user clicks on notification icon in the left panel
    And "Spreadsheet import finished!" notification should have content "Import COMPLETED" in the notifications tab
#    And "Spreadsheet import finished!" notification should have content "Import COMPLETED" in the notifications tab
    And user "click" on open statistic link for "Spreadsheet import finished!" in notifications panel
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "IMPORT EXECUTION" section for the "Test_Updated.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Status                   | COMPLETED                 |
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "ITEM IMPORT STATISTICS" section for the "Test_Updated.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Total                    | 7                         |
      | Type                     | BusinessTerm              |
    And user verifies "IMPORT EXECUTION" section in Notification panel has following values
      | Execution |
      | Duration  |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "/import/spreadsheets/storedText" and path ""

  @webtest @MLP-8488 @regression @positive @spreadsheet
  Scenario: MLP-8488 Verification of importing an xlsx file with blank column values
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/WithBlankColumns.xlsx" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_withBlankColumns.json" file for following values
      | jsonPath                | jsonValues        |
      | $..['sheet']            | Sheet1            |
      | $..['catalog']          | ImportSpreadSheet |
      | $..['importedItemType'] | BusinessTerm      |
      | $..['status']           | TRIGGERED         |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_withBlankColumns.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_withBlankColumns.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_withBlankColumns.json" for following values using "db values"
      | jsonPath        |
      | $..['fileName'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Term", "Description", "Definition" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_withBlankColumns.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user makes a recursive REST Call for GET request "/import/spreadsheets?catalogname=ImportSpreadSheet" till the status becomes "FAILED" with maximum threshhold of "5" times
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues            | jsonPath         |
      | WithBlankColumns.xlsx | $.[-1:].fileName |
      | FAILED                | $.[-1:].status   |
      | ImportSpreadSheet     | $.[-1:].catalog  |
      | Sheet1                | $.[-1:].sheet    |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "FAILED" value are same
    And user stores the value from response using jsonpath"$..['id']"
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on notification icon in the left panel
    And "Spreadsheet import finished!" notification should have content "Import FAILED" in the notifications tab
    And user "click" on open statistic link for "Spreadsheet import finished!" in notifications panel
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "IMPORT EXECUTION" section for the "WithBlankColumns.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Status                   | FAILED                    |
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "ITEM IMPORT STATISTICS" section for the "WithBlankColumns.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Total                    | 6                         |
      | Type                     | BusinessTerm              |
    And user verifies "IMPORT EXECUTION" section in Notification panel has following values
      | Execution |
      | Duration  |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "/import/spreadsheets/storedText" and path ""

  @webtest @MLP-8488 @regression @positive @spreadsheet
  Scenario: MLP-8488 Verification of importing an xls file with blank column values
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/WithBlankColumns.xls" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_withBlankColumns.json" file for following values
      | jsonPath                | jsonValues        |
      | $..['sheet']            | Sheet1            |
      | $..['catalog']          | ImportSpreadSheet |
      | $..['importedItemType'] | BusinessTerm      |
      | $..['status']           | TRIGGERED         |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_withBlankColumns.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_withBlankColumns.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_withBlankColumns.json" for following values using "db values"
      | jsonPath        |
      | $..['fileName'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Term", "Description", "Definition" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_withBlankColumns.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user makes a recursive REST Call for GET request "/import/spreadsheets?catalogname=ImportSpreadSheet" till the status becomes "FAILED" with maximum threshhold of "5" times
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues           | jsonPath         |
      | WithBlankColumns.xls | $.[-1:].fileName |
      | FAILED               | $.[-1:].status   |
      | ImportSpreadSheet    | $.[-1:].catalog  |
      | Sheet1               | $.[-1:].sheet    |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "FAILED" value are same
    And user stores the value from response using jsonpath"$..['id']"
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on notification icon in the left panel
    And "Spreadsheet import finished!" notification should have content "Import FAILED" in the notifications tab
    And user "click" on open statistic link for "Spreadsheet import finished!" in notifications panel
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "IMPORT EXECUTION" section for the "WithBlankColumns.xls"
      | notificationPropertyName | notificationPropertyValue |
      | Status                   | FAILED                    |
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "ITEM IMPORT STATISTICS" section for the "WithBlankColumns.xls"
      | notificationPropertyName | notificationPropertyValue |
      | Total                    | 6                         |
      | Type                     | BusinessTerm              |
    And user verifies "IMPORT EXECUTION" section in Notification panel has following values
      | Execution |
      | Duration  |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "/import/spreadsheets/storedText" and path ""

  @webtest @MLP-8488 @regression @positive @spreadsheet
  Scenario: MLP-8488 Verification of importing an xlsx file with wrong column name mapping
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/WithBlankColumns.xlsx" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_wrongColumn_mapping.json" file for following values
      | jsonPath                | jsonValues        |
      | $..['sheet']            | Sheet1            |
      | $..['catalog']          | ImportSpreadSheet |
      | $..['importedItemType'] | BusinessTerm      |
      | $..['status']           | TRIGGERED         |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_wrongColumn_mapping.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_wrongColumn_mapping.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_wrongColumn_mapping.json" for following values using "db values"
      | jsonPath        |
      | $..['fileName'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Term", "Description", "Definition" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_wrongColumn_mapping.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user makes a recursive REST Call for GET request "/import/spreadsheets?catalogname=ImportSpreadSheet" till the status becomes "FAILED" with maximum threshhold of "5" times
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues            | jsonPath         |
      | WithBlankColumns.xlsx | $.[-1:].fileName |
      | FAILED                | $.[-1:].status   |
      | ImportSpreadSheet     | $.[-1:].catalog  |
      | Sheet1                | $.[-1:].sheet    |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "FAILED" value are same
    And user stores the value from response using jsonpath"$..['id']"
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on notification icon in the left panel
    And "Spreadsheet import finished!" notification should have content "Import FAILED" in the notifications tab
    And user "click" on open statistic link for "Spreadsheet import finished!" in notifications panel
    And user verifies "IMPORT EXECUTION" section in Notification panel has following values
      | Execution |
      | Duration  |
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "IMPORT EXECUTION" section for the "WithBlankColumns.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Status                   | FAILED                    |
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "ITEM IMPORT STATISTICS" section for the "WithBlankColumns.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Total                    | 6                         |
      | Type                     | BusinessTerm              |
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "ITEM IMPORT FAILURES" section for the "WithBlankColumns.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Total failed             | 6                         |
    And user "click" "Open errors and Warnings" link under deatils label under open notification panel
    And user verfies whether "SPREADSHEET IMPORT ISSUES" notification panel contains the expected text for the "IMPORT ERRORS" section for the "WithBlankColumns.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      |                          | sheetWithBlankColumnError |
    And user verfies whether "SPREADSHEET IMPORT ISSUES" notification panel contains the expected text for the "IMPORT WARNINGS" section for the "WithBlankColumns.xlsx"
      | notificationPropertyName | notificationPropertyValue    |
      |                          | sheetWithBlankColumnWarnings |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "/import/spreadsheets/storedText" and path ""

  @webtest @MLP-8488 @regression @positive @spreadsheet
  Scenario: MLP-8488 Verification of importing an xlsx file with column name has space
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/SeviceColumnNametWithSpace.xlsx" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Data"]   | $..['sheets'] |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_xlsxSpreadSheet_withSpace.json" file for following values
      | jsonPath                | jsonValues        |
      | $..['sheet']            | Data              |
      | $..['catalog']          | ImportSpreadSheet |
      | $..['importedItemType'] | BusinessTerm      |
      | $..['status']           | TRIGGERED         |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_xlsxSpreadSheet_withSpace.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_xlsxSpreadSheet_withSpace.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_xlsxSpreadSheet_withSpace.json" for following values using "db values"
      | jsonPath        |
      | $..['fileName'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Data&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Business Term", "Description of the Term", "Definition of the Term" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8487_xlsxSpreadSheet_withSpace.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user makes a recursive REST Call for GET request "/import/spreadsheets?catalogname=ImportSpreadSheet" till the status becomes "COMPLETED" with maximum threshhold of "5" times
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues                      | jsonPath         |
      | SeviceColumnNametWithSpace.xlsx | $.[-1:].fileName |
      | COMPLETED                       | $.[-1:].status   |
      | ImportSpreadSheet               | $.[-1:].catalog  |
      | Data                            | $.[-1:].sheet    |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "COMPLETED" value are same
    And user stores the value from response using jsonpath"$..['id']"
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on notification icon in the left panel
    And "Spreadsheet import finished!" notification should have content "Import COMPLETED" in the notifications tab
    And user "click" on open statistic link for "Spreadsheet import finished!" in notifications panel
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "IMPORT EXECUTION" section for the "SeviceColumnNametWithSpace.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Status                   | COMPLETED                 |
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "ITEM IMPORT STATISTICS" section for the "SeviceColumnNametWithSpace.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Total                    | 5                         |
      | Type                     | BusinessTerm              |
    And user verifies "IMPORT EXECUTION" section in Notification panel has following values
      | Execution |
      | Duration  |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "/import/spreadsheets/storedText" and path ""

  @webtest @MLP-8488 @regression @positive @spreadsheet
  Scenario: MLP-8488 Verification of importing an xls file with column name has space
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/SeviceColumnNameWithSpace.xls" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_xlsSpreadSheet_withSpace.json" file for following values
      | jsonPath                | jsonValues        |
      | $..['sheet']            | Sheet1            |
      | $..['catalog']          | ImportSpreadSheet |
      | $..['importedItemType'] | BusinessTerm      |
      | $..['status']           | TRIGGERED         |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_xlsSpreadSheet_withSpace.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_xlsSpreadSheet_withSpace.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_xlsSpreadSheet_withSpace.json" for following values using "db values"
      | jsonPath        |
      | $..['fileName'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Description of the Term", "Business Term", "Definition" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8487_xlsSpreadSheet_withSpace.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user makes a recursive REST Call for GET request "/import/spreadsheets?catalogname=ImportSpreadSheet" till the status becomes "COMPLETED" with maximum threshhold of "5" times
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues                    | jsonPath         |
      | SeviceColumnNameWithSpace.xls | $.[-1:].fileName |
      | COMPLETED                     | $.[-1:].status   |
      | ImportSpreadSheet             | $.[-1:].catalog  |
      | Sheet1                        | $.[-1:].sheet    |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "COMPLETED" value are same
    And user stores the value from response using jsonpath"$..['id']"
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on notification icon in the left panel
    And "Spreadsheet import finished!" notification should have content "Import COMPLETED" in the notifications tab
    And user "click" on open statistic link for "Spreadsheet import finished!" in notifications panel
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "IMPORT EXECUTION" section for the "SeviceColumnNameWithSpace.xls"
      | notificationPropertyName | notificationPropertyValue |
      | Status                   | COMPLETED                 |
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "ITEM IMPORT STATISTICS" section for the "SeviceColumnNameWithSpace.xls"
      | notificationPropertyName | notificationPropertyValue |
      | Total                    | 5                         |
      | Type                     | BusinessTerm              |
    And user verifies "IMPORT EXECUTION" section in Notification panel has following values
      | Execution |
      | Duration  |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "/import/spreadsheets/storedText" and path ""

  @webtest @MLP-8488 @regression @positive @spreadsheet
  Scenario: MLP-8488 Verification of performing the actual import for an xlsx file with newline character
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/WithNewLine.xlsx" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json" file for following values
      | jsonPath                | jsonValues        |
      | $..['sheet']            | Sheet1            |
      | $..['catalog']          | ImportSpreadSheet |
      | $..['importedItemType'] | BusinessTerm      |
      | $..['status']           | TRIGGERED         |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json" for following values using "db values"
      | jsonPath        |
      | $..['fileName'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Term", "Description", "Definition" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user makes a recursive REST Call for GET request "/import/spreadsheets?catalogname=ImportSpreadSheet" till the status becomes "COMPLETED" with maximum threshhold of "5" times
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues        | jsonPath         |
      | WithNewLine.xlsx  | $.[-1:].fileName |
      | COMPLETED         | $.[-1:].status   |
      | ImportSpreadSheet | $.[-1:].catalog  |
      | Sheet1            | $.[-1:].sheet    |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "COMPLETED" value are same
    And user stores the value from response using jsonpath"$..['id']"
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on notification icon in the left panel
    And "Spreadsheet import finished!" notification should have content "Import COMPLETED" in the notifications tab
    And user "click" on open statistic link for "Spreadsheet import finished!" in notifications panel
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "IMPORT EXECUTION" section for the "WithNewLine.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Status                   | COMPLETED                 |
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "ITEM IMPORT STATISTICS" section for the "WithNewLine.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Total                    | 4                         |
      | Type                     | BusinessTerm              |
    And user verifies "IMPORT EXECUTION" section in Notification panel has following values
      | Execution |
      | Duration  |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "/import/spreadsheets/storedText" and path ""

  @webtest @MLP-8488 @regression @positive @spreadsheet
  Scenario: MLP-8488 Verification of performing the actual import for an xls file with newline character
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/WithNewLine.xls" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json" file for following values
      | jsonPath                | jsonValues        |
      | $..['sheet']            | Sheet1            |
      | $..['catalog']          | ImportSpreadSheet |
      | $..['importedItemType'] | BusinessTerm      |
      | $..['status']           | TRIGGERED         |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json" for following values using "db values"
      | jsonPath        |
      | $..['fileName'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Term", "Description", "Definition" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user makes a recursive REST Call for GET request "/import/spreadsheets?catalogname=ImportSpreadSheet" till the status becomes "COMPLETED" with maximum threshhold of "5" times
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues        | jsonPath         |
      | WithNewLine.xls   | $.[-1:].fileName |
      | COMPLETED         | $.[-1:].status   |
      | ImportSpreadSheet | $.[-1:].catalog  |
      | Sheet1            | $.[-1:].sheet    |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "COMPLETED" value are same
    And user stores the value from response using jsonpath"$..['id']"
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on notification icon in the left panel
    And "Spreadsheet import finished!" notification should have content "Import COMPLETED" in the notifications tab
    And user "click" on open statistic link for "Spreadsheet import finished!" in notifications panel
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "IMPORT EXECUTION" section for the "WithNewLine.xls"
      | notificationPropertyName | notificationPropertyValue |
      | Status                   | COMPLETED                 |
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "ITEM IMPORT STATISTICS" section for the "WithNewLine.xls"
      | notificationPropertyName | notificationPropertyValue |
      | Total                    | 6                         |
      | Type                     | BusinessTerm              |
    And user verifies "IMPORT EXECUTION" section in Notification panel has following values
      | Execution |
      | Duration  |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "/import/spreadsheets/storedText" and path ""

  @webtest @MLP-8488 @regression @positive @spreadsheet
  Scenario: MLP-8488 Verification of importing the same xlsx file which is already imported
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/WithNewLine.xlsx" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json" file for following values
      | jsonPath                | jsonValues        |
      | $..['sheet']            | Sheet1            |
      | $..['catalog']          | ImportSpreadSheet |
      | $..['importedItemType'] | BusinessTerm      |
      | $..['status']           | TRIGGERED         |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json" for following values using "db values"
      | jsonPath        |
      | $..['fileName'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Sheet1&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Term", "Description", "Definition" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8488_SpreadSheet_with_newLineCharacter.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user makes a recursive REST Call for GET request "/import/spreadsheets?catalogname=ImportSpreadSheet" till the status becomes "COMPLETED" with maximum threshhold of "5" times
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues        | jsonPath         |
      | WithNewLine.xlsx  | $.[-1:].fileName |
      | COMPLETED         | $.[-1:].status   |
      | ImportSpreadSheet | $.[-1:].catalog  |
      | Sheet1            | $.[-1:].sheet    |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "COMPLETED" value are same
    And user stores the value from response using jsonpath"$..['id']"
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on notification icon in the left panel
    And "Spreadsheet import finished!" notification should have content "Import COMPLETED" in the notifications tab
    And user "click" on open statistic link for "Spreadsheet import finished!" in notifications panel
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "IMPORT EXECUTION" section for the "WithNewLine.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Status                   | COMPLETED                 |
    And user verfies whether "NOTIFICATION DETAILS" notification panel contains the expected text for the "ITEM IMPORT STATISTICS" section for the "WithNewLine.xlsx"
      | notificationPropertyName | notificationPropertyValue |
      | Total                    | 4                         |
      | Type                     | BusinessTerm              |
    And user verifies "IMPORT EXECUTION" section in Notification panel has following values
      | Execution |
      | Duration  |
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "/import/spreadsheets/storedText" and path ""