@MLP-8487
Feature: MLP-8487: Service to get the list of Columns in spread sheet and to verify import status

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487_Verification of import service when there is no import
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

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487-Verification of importing and upadting an xlsx file
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/person_address_info.xlsx" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues             | jsonPath      |
      | ["person_sample_info"] | $..['sheets'] |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_updatexlsxSpreadSheet.json" file for following values
      | jsonPath                | jsonValues         |
      | $..['sheet']            | person_sample_info |
      | $..['catalog']          | ImportSpreadSheet  |
      | $..['importedItemType'] | BusinessTerm       |
      | $..['status']           | IN_PROGRESS        |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_updatexlsxSpreadSheet.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_updatexlsxSpreadSheet.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_updatexlsxSpreadSheet.json" for following values using "db values"
      | jsonPath        |
      | $..['fileName'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=person_sample_info&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Name", "SSN", "EE_ID", "IP address", "Gender", "Address" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8487_updatexlsxSpreadSheet.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user stores the value from response using jsonpath"$..['id']"
    And user makes a REST Call for Get request with url "/import/spreadsheets?catalogname=ImportSpreadSheet"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues               | jsonPath         |
      | person_address_info.xlsx | $.[-1:].fileName |
      | IN_PROGRESS              | $.[-1:].status   |
      | ImportSpreadSheet        | $.[-1:].catalog  |
      | person_sample_info       | $.[-1:].sheet    |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "IN_PROGRESS" value are same

  @MLP-8490 @regression @positive @spreadsheet
  Scenario: MLP-8490_Verification of getting the items by status as IN_PROGRESS
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/import/spreadsheets/ImportSpreadSheet/bystatus?statuses=IN_PROGRESS"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues               | jsonPath                 |
      | person_address_info.xlsx | $.[-1:].fileName         |
      | person_sample_info       | $.[-1:].sheet            |
      | ImportSpreadSheet        | $.[-1:].catalog          |
      | BusinessTerm             | $.[-1:].importedItemType |
      | IN_PROGRESS              | $.[-1:].status           |

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487-Verification of deleting an file
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/import/spreadsheets?catalogname=ImportSpreadSheet"
    And Status code 200 must be returned
    And user stores the value from response using jsonpath"$.[-1:].id"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for "DELETE" request with url "import/spreadsheets/storedText/content" and path ""
    And Status code 200 must be returned
    And row count "1" should be displayed in database
      | description | schemaName        | tableName | columnName | criteriaName |
      | SELECT      | ImportSpreadSheet | V_Import  | *          |              |
    When user makes a REST Call for "DELETE" request with url "import/spreadsheets/storedText" and path ""
    And Status code 200 must be returned
    And deleted bundle "person_address_info.xlsx" should not be present in database
      | description | schemaName        | tableName | columnName | criteriaName |
      | SELECT      | ImportSpreadSheet | V_Import  | *          | fileName     |

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487-Verification of sending and updating an xls file
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/ImportUpdate.xls" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | ["Sheet1"] | $..['sheets'] |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_updatexlsSpreadSheet.json" file for following values
      | jsonPath                | jsonValues        |
      | $..['sheet']            | Sheet1            |
      | $..['catalog']          | ImportSpreadSheet |
      | $..['importedItemType'] | BusinessTerm      |
      | $..['status']           | COMPLETED         |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_updatexlsSpreadSheet.json" for following values using "response"
      | jsonPath  |
      | $..['id'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | name       |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_updatexlsSpreadSheet.json" for following values using "db values"
      | jsonPath    |
      | $..['name'] |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user update the json file "idc/spreadSheetLoaderPayloads/MLP_8487_updatexlsSpreadSheet.json" for following values using "db values"
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
    And supply payload with file name "idc/spreadSheetLoaderPayloads/MLP_8487_updatexlsSpreadSheet.json"
    And user makes a REST Call for PUT request with url "/import/spreadsheets"
    And Status code 200 must be returned
    And user makes a recursive REST Call for GET request "/import/spreadsheets?catalogname=ImportSpreadSheet" till the status becomes "COMPLETED" with maximum threshhold of "5" times
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues        | jsonPath         |
      | ImportUpdate.xls  | $.[-1:].fileName |
      | COMPLETED         | $.[-1:].status   |
      | ImportSpreadSheet | $.[-1:].catalog  |
      | Sheet1            | $.[-1:].sheet    |
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "COMPLETED" value are same

  @MLP-8490 @regression @positive @spreadsheet
  Scenario: MLP-8490_Verification of getting the items by status as COMPLETED
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/import/spreadsheets/ImportSpreadSheet/bystatus?statuses=COMPLETED"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues        | jsonPath                 |
      | ImportUpdate.xls  | $.[-1:].fileName         |
      | Sheet1            | $.[-1:].sheet            |
      | ImportSpreadSheet | $.[-1:].catalog          |
      | BusinessTerm      | $.[-1:].importedItemType |
      | COMPLETED         | $.[-1:].status           |

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487_Verification of Deleting an imported item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/import/spreadsheets?catalogname=ImportSpreadSheet"
    And Status code 200 must be returned
    And user stores the value from response using jsonpath"$.[-1:].id"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "DELETE" request with url "import/spreadsheets/storedText" and path ""
    And Status code 200 must be returned
    And deleted bundle "ImportUpdate.xls" should not be present in database
      | description | schemaName        | tableName | columnName | criteriaName |
      | SELECT      | ImportSpreadSheet | V_Import  | *          | fileName     |

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487-Verification of importing an xlsx file with null columns
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/HealthCoverage.xlsx" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues                      | jsonPath      |
      | ["Helath Coverage Information"] | $..['sheets'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=Helath%20Coverage%20Information&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Name", "Social Security Number", "Employee id", "Medical plan", "Health savings account", "Medicare Plan", "Prescriptrion Drug Plan", "Dental plan", "Vision Plan", "Health care flexible spending account", "Dependent day care flexible spending account" ]"
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "NOT_STARTED" value are same
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user verify postgres column value generated from the query and the "HealthCoverage.xlsx" value are same

  @MLP-8490 @regression @positive @spreadsheet
  Scenario: MLP-8490_Verification of getting the items by status as NOT_STARTED
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/import/spreadsheets/ImportSpreadSheet/bystatus?statuses=NOT_STARTED"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues          | jsonPath         |
      | HealthCoverage.xlsx | $.[-1:].fileName |
      | ImportSpreadSheet   | $.[-1:].catalog  |
      | NOT_STARTED         | $.[-1:].status   |

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487-Verification of importing an xls file with null columns
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/HealthCoverage.xls" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues  | jsonPath      |
      | ["EmpData"] | $..['sheets'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "/import/spreadsheets/storedText/columns?sheetName=EmpData&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Name", "Social Security Number", "Employee id", "Payroll", "Annual Compensation", "Bonus Amount", "Address" ]"
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "NOT_STARTED" value are same
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user verify postgres column value generated from the query and the "HealthCoverage.xls" value are same

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487-Verification of importing New line character in .xls file
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/Newline.xls" to request
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
    And response message contains value "[ "Full Name Midddle Name", "Profession  Act  Department", "Re mark Feedback" ]"
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "NOT_STARTED" value are same
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user verify postgres column value generated from the query and the "Newline.xls" value are same

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487-Verification of importing New line character in .xlsx file
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/Newline.xlsx" to request
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
    And response message contains value "[ "Full Name Midddle Name", "Profession  Act  Department", "Re mark Feedback" ]"
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "NOT_STARTED" value are same
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user verify postgres column value generated from the query and the "Newline.xlsx" value are same

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487_Verification of getting the content of an imported item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/import/spreadsheets?catalogname=ImportSpreadSheet"
    And Status code 200 must be returned
    And user stores the value from response using jsonpath"$.[-1:].id"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "import/spreadsheets/storedText" and path ""
    And Status code 200 must be returned

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487-Verification of importing an xlsx file with multiple sheets
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/prsn_profile.xlsx" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues                | jsonPath      |
      | [system,identity,profile] | $..['sheets'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "import/spreadsheets/storedText/columns?sheetName=system&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Name", "SSN", "Employee id", "System addreess", "OS Platform", "Software" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "import/spreadsheets/storedText/columns?sheetName=identity&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Name", "Social Security Number", "Employee id", "Father Name", "Mother Name", "Birth Place", "Driving license Number", "Vechicle Registration Number", "CCN Number" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "import/spreadsheets/storedText/columns?sheetName=profile&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Name", "Social Security Number", "Employee id", "Education qualification", "Employment start Date", "Designation", "Nationality", "Passport Identification", "User Name", "Password", "Higly Compensated Employee", "Salary Account number", "Bank Name" ]"
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user verify postgres column value generated from the query and the "prsn_profile.xlsx" value are same
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "NOT_STARTED" value are same

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487- Verification of importing an xls file with multiple sheets
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/prsn_profile.xls" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues                | jsonPath      |
      | [system,identity,profile] | $..['sheets'] |
    And user stores the value from response using jsonpath"$..['id']"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "import/spreadsheets/storedText/columns?sheetName=system&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Name", "SSN", "Employee id", "System addreess", "OS Platform", "Software" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "import/spreadsheets/storedText/columns?sheetName=identity&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Name", "Social Security Number", "Employee id", "Father Name", "Mother Name", "Birth Place", "Driving license Number", "Vechicle Registration Number", "CCN Number" ]"
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with url "import/spreadsheets/storedText/columns?sheetName=profile&containsColumnHeader=true" and path ""
    And Status code 200 must be returned
    And response message contains value "[ "Name", "Social Security Number", "Employee id", "Education qualification", "Employment start Date", "Designation", "Nationality", "Passport Identification", "User Name", "Password", "Higly Compensated Employee", "Salary Account number", "Bank Name" ]"
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user verify postgres column value generated from the query and the "prsn_profile.xls" value are same
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "NOT_STARTED" value are same

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487-Verification of importing an xlsx file with different types of columns
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/diffTypeColumns.xlsx" to request
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
    And response message contains value "[ "Name", "Birth Date", "Age", "CGPA", "Gender", "Start time", "Own Vehicle", "insurance number", "conduct" ]"
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | fileName   |
    And user verify postgres column value generated from the query and the "diffTypeColumns.xlsx" value are same
    And user connect to the database and execute query for the following parameters
      | dataBaseName  | dataBaseType | queryPath     | queryPage                | queryField           | storeResults   | columnName |
      | APPDBPOSTGRES | STRUCTURED   | json/IDC.json | SpreadSheetLoaderQueries | getSpreadSheetValues | rowStringValue | status     |
    And user verify postgres column value generated from the query and the "NOT_STARTED" value are same

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487_Verification of Deleting the content item with an invalid import ID
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/import/spreadsheets/ImportSpreadSheet.import%3A%3A%3A50"
    And Status code 404 must be returned
    And user compares the following value from response using json path
      | jsonValues                                                | jsonPath            |
      | Item with id ImportSpreadSheet.import:::50 does not exist | $..['errorMessage'] |

  @MLP-8487 @regression @positive @spreadsheet
  Scenario: MLP-8487_Verification of importing an unsupported file type
    Given  A query param with "" and "" and supply authorized users, contentType and Accept headers
    And configure a new REST API for the service "IDC"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "spreadSheetPayloads/sampledata.csv" to request
    And user makes a REST Call for POST request with url "/import/spreadsheets/ImportSpreadSheet/content"
    And Status code 500 must be returned
    And user compares the following value from response using json path
      | jsonValues                                     | jsonPath            |
      | Excel file: sampledata.csv - Not an excel file | $..['errorMessage'] |

  @MLP-8487 @sanity @positive @regression @hbase
  Scenario: Deleting Catalog ImportSpreadSheet
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for DELETE request with url "settings/catalogs/ImportSpreadSheet?deleteData=true"