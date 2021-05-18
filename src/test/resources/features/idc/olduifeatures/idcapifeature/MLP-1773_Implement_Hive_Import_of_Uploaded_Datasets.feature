@MLP-1772 @MLP-1982 @excelupload
Feature: MLP-1773 - Implement Hive Import of Uploaded Datasets
  Bug#MLP-9421

  @MLP-1773 @excelupload @sanity @regression @positive
  Scenario: Deleting the upload catalog if exists
    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "settings/catalogs/Excel%20Upload"
    Then verify created schema "ExcelUpload" doesn't exists in database

  @MLP-1773 @excelupload @sanity @regression @positive
  Scenario: Verification of creating a excel upload catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1773_ExcelUploadCatalogCreation.json"
    When user makes a REST Call for POST request with url "settings/catalogs"
    Then Status code 204 must be returned
    Then verify created schema "ExcelUpload" exists in database

  @MLP-1773 @excelupload @sanity @regression @positive
  Scenario: Verification of POST/ uploads/{catalogname}/uploadStatus(NEW)
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user executes the following Query in the Hive JDBC
      | queryEntry            |
      | CreatePIIDatabase     |
      | CreatePersonInfoTable |
    And user attaches/upload file "datasetupload/Person_Data.xlsx" to request
    And user makes a REST Call for POST request with url "/uploads/Excel Upload" with the following query param
      | databaseName | piidata      |
      | tableName    | person_info  |
      | clusterName  | Cluster Demo |
      | allowUpdate  | true         |
      | sheetName    | Person Data  |
    And Status code 200 must be returned
    And excel "Person_Data.xlsx" should be uploaded to uploadData table
      | description | schemaName  | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | ExcelUpload | V_UploadData | *          | name         | databaseName | tableName  | clusterName | hostName |
    When user makes a REST Call for POST request with url "uploads/Excel Upload/updatestatus" with the following query param
      | id      | ExcelUpload.UploadData:::1             |
      | status  | NEW                                    |
      | message | Changed the status from UPDATED to NEW |
    Then excel "Person_Data.xlsx" status should be updated to "NEW"
    And  excel "Person_Data.xlsx" message should be "Changed the status from UPDATED to NEW"
    And excel "Person_Data.xlsx" should be uploaded to uploadData table
      | description | schemaName  | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | ExcelUpload | V_UploadData | *          | name         | databaseName | tableName  | clusterName | hostName |

  @MLP-1773 @excelupload @sanity @regression @positive
  Scenario: Verification of POST/ uploads/{catalogname}/uploadStatus(UPDATED)
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user executes the following Query in the Hive JDBC
      | queryEntry                 |
      | CreatePersonAddreInfoTable |
    And user attaches/upload file "datasetupload/Person_Data.xlsx" to request
    And user makes a REST Call for POST request with url "/uploads/Excel Upload" with the following query param
      | databaseName | piidata          |
      | tableName    | person_addr_info |
      | clusterName  | Cluster Demo     |
      | allowUpdate  | false            |
      | sheetName    | Person Address   |
    And Status code 200 must be returned
    And excel "Person_Data.xlsx" should be uploaded to uploadData table with sheetName "Person Address"
      | description | schemaName  | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | ExcelUpload | V_UploadData | *          | sheetName    | databaseName | tableName  | clusterName | hostName |
    When user makes a REST Call for POST request with url "uploads/Excel Upload/updatestatus" with the following query param
      | id      | ExcelUpload.UploadData:::2             |
      | status  | UPDATED                                |
      | message | Changed the status from NEW to UPDATED |
    And Status code 200 must be returned
    Then excel "Person_Data.xlsx" status should be updated to "UPDATED"
    And  excel "Person_Data.xlsx" message should be "Changed the status from NEW to UPDATED"
    And excel "Person_Data.xlsx" should be uploaded to uploadData table with sheetName "Person Address"
      | description | schemaName  | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | ExcelUpload | V_UploadData | *          | sheetName    | databaseName | tableName  | clusterName | hostName |

  @MLP-1773 @excelupload @sanity @regression @positive
  Scenario: Verification of POST/ uploads/{catalogname}/uploadStatus(UPLOADED)
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "datasetupload/Person_Data.xlsx" to request
    And user makes a REST Call for POST request with url "/uploads/Excel Upload" with the following query param
      | databaseName | piidata            |
      | tableName    | person_family_info |
      | clusterName  | Cluster Demo        |
      | allowUpdate  | false              |
      | sheetName    | Family Information |
    And Status code 200 must be returned
    And excel "Person_Data.xlsx" should be uploaded to uploadData table with sheetName "Family Information"
      | description | schemaName  | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | ExcelUpload | V_UploadData | *          | sheetName    | databaseName | tableName  | clusterName | hostName |
    When user makes a REST Call for POST request with url "uploads/Excel Upload/updatestatus" with the following query param
      | id      | ExcelUpload.UploadData:::3              |
      | status  | UPLOADED                                |
      | message | Changed the status from NEW to UPLOADED |
    And Status code 200 must be returned
    Then excel "Person_Data.xlsx" status should be updated to "UPLOADED"
    And  excel "Person_Data.xlsx" message should be "Changed the status from NEW to UPLOADED"
    And excel "Person_Data.xlsx" should be uploaded to uploadData table with sheetName "Family Information"
      | description | schemaName  | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | ExcelUpload | V_UploadData | *          | sheetName    | databaseName | tableName  | clusterName | hostName |

  @MLP-1773 @excelupload @sanity @regression @positive
  Scenario: Verification of POST/ uploads/{catalogname}/uploadStatus(FAILED)
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "datasetupload/Person_Pay_Data.xlsx" to request
    And user makes a REST Call for POST request with url "/uploads/Excel Upload" with the following query param
      | databaseName | piidata         |
      | tableName    | person_pay_info |
      | clusterName  | Cluster Demo     |
      | allowUpdate  | false           |
    And Status code 200 must be returned
    And excel "Person_Pay_Data.xlsx" should be uploaded to uploadData table
      | description | schemaName  | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | ExcelUpload | V_UploadData | *          | name         | databaseName | tableName  | clusterName | hostName |
    When user makes a REST Call for POST request with url "uploads/Excel Upload/updatestatus" with the following query param
      | id      | ExcelUpload.UploadData:::4            |
      | status  | FAILED                                |
      | message | Changed the status from NEW to FAILED |
    And Status code 200 must be returned
    Then excel "Person_Pay_Data.xlsx" status should be updated to "FAILED"
    And  excel "Person_Pay_Data.xlsx" message should be "Changed the status from NEW to FAILED"
    And excel "Person_Pay_Data.xlsx" should be uploaded to uploadData table
      | description | schemaName  | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | ExcelUpload | V_UploadData | *          | name         | databaseName | tableName  | clusterName | hostName |

  @MLP-1773 @excelupload @sanity @regression @negative
  Scenario: Verification of POST/ uploads/{catalogname}/uploadStatus for incorrect uploadData id
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for POST request with url "uploads/Excel Upload/updatestatus" with the following query param
      | id      | ExcelUpload.UploadData:::12           |
      | status  | FAILED                                |
      | message | Changed the status from NEW to FAILED |
    And Status code 404 must be returned

  @MLP-1773 @excelupload @sanity @regression @positive
  Scenario: Verification of GET /uploads/{catalogname}/uploaddatabystatus (NEW)
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "uploads/Excel Upload/uploaddatabystatus" with the following query param
      | catalogname | Excel Upload |
      | statuses    | NEW          |
    Then Status code 200 must be returned
    And status "NEW" should return the UploadData "ExcelUpload.UploadData:::1"
      | description | schemaName  | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName | name |
      | SELECT      | ExcelUpload | V_UploadData | *          | status       | databaseName | tableName  | clusterName | hostName | name |

  @MLP-1773 @excelupload @sanity @regression @positive
  Scenario: Verification of GET /uploads/{catalogname}/uploaddatabystatus (UPDATED)
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "uploads/Excel Upload/uploaddatabystatus" with the following query param
      | catalogname | Excel Upload |
      | statuses    | UPDATED      |
    Then Status code 200 must be returned
    And status "UPDATED" should return the UploadData "ExcelUpload.UploadData:::2"
      | description | schemaName  | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName | name |
      | SELECT      | ExcelUpload | V_UploadData | *          | status       | databaseName | tableName  | clusterName | hostName | name |

  @MLP-1773 @excelupload @sanity @regression @positive
  Scenario: Verification of GET /uploads/{catalogname}/uploaddatabystatus (UPLOADED)
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "uploads/Excel Upload/uploaddatabystatus" with the following query param
      | catalogname | Excel Upload |
      | statuses    | UPLOADED     |
    Then Status code 200 must be returned
    And status "UPLOADED" should return the UploadData "ExcelUpload.UploadData:::3"
      | description | schemaName  | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName | name |
      | SELECT      | ExcelUpload | V_UploadData | *          | status       | databaseName | tableName  | clusterName | hostName | name |

  @MLP-1773 @excelupload @sanity @regression @positive
  Scenario: Verification of GET /uploads/{catalogname}/uploaddatabystatus (FAILED)
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "uploads/Excel Upload/uploaddatabystatus" with the following query param
      | catalogname | Excel Upload |
      | statuses    | FAILED       |
    Then Status code 200 must be returned
    And status "FAILED" should return the UploadData "ExcelUpload.UploadData:::4"
      | description | schemaName  | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName | name |
      | SELECT      | ExcelUpload | V_UploadData | *          | status       | databaseName | tableName  | clusterName | hostName | name |

  @MLP-1773 @excelupload @sanity @regression @positive
  Scenario: Verification of GET /uploads/{catalogname}/filedatabyid
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "uploads/Excel Upload/contentbyid" with the following query param
      | catalogname | Excel Upload               |
      | id          | ExcelUpload.UploadData:::3 |
    Then Status code 200 must be returned
    And user should able to download the file in "DOWNLOAD_FILE_PATH" and save it as "personalData.xlsx"
    And both "UPLOAD_FILE_PATH" directory file "Person_Data.xlsx" and "DOWNLOAD_FILE_PATH" directory file "personalData.xlsx" should match

  @MLP-1773 @excelupload @sanity @regression @negative
  Scenario: Verification of GET /uploads/{catalogname}/filedatabyid for incorrect UploadData id
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "uploads/Excel Upload/contentbyid" with the following query param
      | catalogname | Excel Upload               |
      | id          | ExcelUpload.UploadData:::5 |
    Then Status code 404 must be returned

  @MLP-1773 @excelupload @sanity @regression @negative
  Scenario: Verification of DELETE /uploads/{catalogname}/filedatabyid
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "uploads/Excel Upload/contentbyid" with the following query param
      | catalogname | Excel Upload               |
      | id          | ExcelUpload.UploadData:::2 |
    Then Status code 200 must be returned
    And deleted file data should be from the excel "Person_Data.xlsx"
    And user makes a REST Call for Get request with url "uploads/Excel Upload/contentbyid" with the following query param
      | catalogname | Excel Upload               |
      | id          | ExcelUpload.UploadData:::2 |
    And Status code 404 must be returned

  @MLP-1773 @excelupload @regression @negative
  Scenario: Verification of DELETE /uploads/{catalogname}/filedatabyid for incorrect uploaddata id
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for DELETE request with url "uploads/Excel Upload/contentbyid" with the following query param
      | catalogname | Excel Upload               |
      | id          | ExcelUpload.UploadData:::5 |
    Then Status code 404 must be returned

  @MLP-1773 @excelupload @regression
  Scenario: Verification of DELETE /uploads/{catalogname}/filedatabyid for incorrect uploaddata id
    Given user executes the following Query in the Hive JDBC
      | queryEntry          |
      | DropPersonInfoTable |
      | DropPIIDatabase     |