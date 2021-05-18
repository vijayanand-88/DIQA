@MLP-1772 @MLP-1982 @excelupload
Feature: MLP-1772 - Verification of uploading a  Excel data files to Hive warehouse
  Bug#MLP-9421

  @MLP-1772 @excelupload @sanity @regression @positive
  Scenario: Deleting the upload catalog if exists
    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "settings/catalogs/Upload"
    Then verify created schema "Upload" doesn't exists in database

  @MLP-1772 @excelupload @sanity @regression @positive
  Scenario: Deleting the upload data catalog if exists
    Given A query param with "deleteData" and "true" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for DELETE request with url "settings/catalogs/Upload%20Data"
    Then verify created schema "UploadData" doesn't exists in database

  @MLP-1772 @excelupload @sanity @regression @positive
  Scenario: Verification of creating a excel upload catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1772_ExcelUploadCatalogCreation.json"
    When user makes a REST Call for POST request with url "settings/catalogs"
    Then Status code 204 must be returned
    Then verify created schema "Upload" exists in database

  @MLP-1772 @excelupload @sanity @regression @positive
  Scenario: Verification of creating a excel upload data catalog
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And supply payload with file name "idc/MLP-1772_ExcelUploadDataCatalogCreation.json"
    When user makes a REST Call for POST request with url "settings/catalogs"
    Then Status code 204 must be returned
    Then verify created schema "UploadData" exists in database

  @MLP-1772 @excelupload @sanity @regression @positive
  Scenario: Verification of uploading xlsx file with allow update as true
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "datasetupload/inventory_fact_1998_sample.xlsx" to request
    When user makes a REST Call for POST request with url "/uploads/Upload" with the following query param
      | databaseName | northwind    |
      | tableName    | categories   |
      | clusterName  | Cluster Demo |
      | allowUpdate  | true         |
    Then Status code 200 must be returned
    And excel "inventory_fact_1998_sample.xlsx" should be uploaded to uploadData table
      | description | schemaName | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | Upload     | V_UploadData | *          | name         | databaseName | tableName  | clusterName | hostName |

  @MLP-1772 @excelupload @sanity @regression @positive
  Scenario: Verification of uploading xlsx file with allow update as flase
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "datasetupload/customer_sample.xlsx" to request
    When user makes a REST Call for POST request with url "/uploads/Upload" with the following query param
      | databaseName | foodmart     |
      | tableName    | customer     |
      | clusterName  | Cluster Demo |
      | allowUpdate  | false        |
    Then Status code 200 must be returned
    And excel "customer_sample.xlsx" should be uploaded to uploadData table
      | description | schemaName | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | Upload     | V_UploadData | *          | name         | databaseName | tableName  | clusterName | hostName |

  @MLP-1772 @excelupload @sanity @regression @negative
  Scenario: Verification of uploading already exitsing xlsx file in a new catalog with same db table and cluster
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "datasetupload/inventory_fact_1998_sample.xlsx" to request
    When user makes a REST Call for POST request with url "/uploads/Upload Data" with the following query param
      | databaseName | northwind    |
      | tableName    | categories   |
      | clusterName  | Cluster Demo |
      | allowUpdate  | false        |
    Then Status code 400 must be returned
    And response body should have "already exist in catalog" message

  @MLP-1772 @excelupload @sanity @regression @positive
  Scenario: Verification of uploading existing xlsx file in a new table and new database with same cluster
    Given user executes the following Query in the Hive JDBC
      | queryEntry                |
      | CreateExceluploadDatabase |
      | CreateInventoryTable      |
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "datasetupload/customer_sample.xlsx" to request
    When user makes a REST Call for POST request with url "uploads/Upload" with the following query param
      | databaseName | excelupload    |
      | tableName    | inventory_fact |
      | clusterName  | Cluster Demo   |
      | allowUpdate  | true           |
    Then Status code 200 must be returned
    And excel "customer_sample.xlsx" should be uploaded to uploadData table "inventory_fact"
      | description | schemaName | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | Upload     | V_UploadData | *          | tableName    | databaseName | tableName  | clusterName | hostName |

#  @MLP-1772 @excelupload @sanity @regression @positive
#  Scenario: Verification of uploading existing xlsx file in a new cluster with old DB and old table
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "datasetupload/customer_sample.xlsx" to request
#    When user makes a REST Call for POST request with url "/uploads/Upload" with the following query param
#      | databaseName | foodmart         |
#      | tableName    | customer_sample  |
#      | clusterName  | Cluster Test New |
#      | allowUpdate  | true             |
#    Then Status code 200 must be returned
#    And excel "customer_sample.xlsx" should be uploaded to new cluster "Cluster Test New"
#      | description | schemaName | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
#      | SELECT      | Upload     | V_UploadData | *          | clusterName  | databaseName | tableName  | clusterName | hostName |

  @MLP-1772 @excelupload @regression @positive
  Scenario: Verification of GET request of Upload file data
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "uploads/Upload/uploaddata" with the following query param
      | databaseName | excelupload    |
      | tableName    | inventory_fact |
      | clusterName  | Cluster Demo   |
    Then Status code 200 must be returned
    And Database "excelupload" and tableName "inventory_fact" and cluster "Cluster Demo" and file "customer_sample.xlsx"should be matching

  @MLP-1772 @excelupload @regression @negative
  Scenario: Verification of GET request of Upload file data for incorrect DB name
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "/uploads/Upload/uploaddata" with the following query param
      | databaseName | test            |
      | tableName    | customer_sample |
      | clusterName  | Cluster Demo    |
    Then Status code 404 must be returned
    And response body should have "not found in catalog" message

  @MLP-1772 @excelupload @regression @negative
  Scenario: Verification of GET request of Upload file data for incorrect table name
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "/uploads/Upload/uploaddata" with the following query param
      | databaseName | foodmart     |
      | tableName    | customerTest |
      | clusterName  | Cluster Demo |
    Then Status code 404 must be returned
    And response body should have "not found in catalog" message

  @MLP-1772 @excelupload @regression @negative
  Scenario: Verification of GET request of Upload file data for incorrect cluster name
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "/uploads/Upload/uploaddata" with the following query param
      | databaseName | foodmart        |
      | tableName    | customer_sample |
      | clusterName  | ClusterTest     |
    Then Status code 404 must be returned
    And response body should have "not found in catalog" message

  @MLP-1772 @excelupload @sanity @regression @negative
  Scenario: Verification of downloading xlsx file
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "/uploads/Upload/content" with the following query param
      | databaseName | northwind    |
      | tableName    | categories   |
      | clusterName  | Cluster Demo |
    Then Status code 200 must be returned
    And user should able to download the file in "DOWNLOAD_FILE_PATH" and save it as "inventory_file.xlsx"
    And both "UPLOAD_FILE_PATH" directory file "inventory_fact_1998_sample.xlsx" and "DOWNLOAD_FILE_PATH" directory file "inventory_file.xlsx" should match

  @MLP-1772 @excelupload @regression @negative
  Scenario: Verification of download request for incorrect database name
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/octet-stream,application/json |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ==        |
    And user makes a REST Call for Get request with url "/uploads/Upload/uploaddata" with the following query param
      | databaseName | foodmar        |
      | tableName    | inventory_fact |
      | clusterName  | Cluster Demo   |
    Then Status code 404 must be returned
    And response body should have "not found in catalog" message

  @MLP-1772 @excelupload @regression @negative
  Scenario: Verification of download request for incorrect table name
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/octet-stream,application/json |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ==        |
    And user makes a REST Call for Get request with url "/uploads/Upload/uploaddata" with the following query param
      | databaseName | excelupload   |
      | tableName    | inventory_fac |
      | clusterName  | Cluster Demo  |
    Then Status code 404 must be returned
    And response body should have "not found in catalog" message

  @MLP-1772 @excelupload @regression @negative
  Scenario: Verification of download request for incorrect cluster name
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/octet-stream,application/json |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ==        |
    And user makes a REST Call for Get request with url "/uploads/Upload/uploaddata" with the following query param
      | databaseName | foodmart       |
      | tableName    | inventory_fact |
      | clusterName  | ClusterTest    |
    Then Status code 404 must be returned
    And response body should have "not found in catalog" message

  @MLP-1772 @excelupload @sanity @regression @positive
  Scenario: Verification of DELETE request for uploaded file
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for DELETE request with url "/uploads/Upload" with the following query param
      | databaseName | foodmart     |
      | tableName    | customer     |
      | clusterName  | Cluster Demo |
    Then Status code 200 must be returned
    And file "customer_sample.xlsx" should be removed from "foodmart" database and "customer" table
      | description | schemaName | tableName    | columnName | criteriaName           |
      | SELECT      | Upload     | V_UploadData | status     | databaseName,tableName |

  @MLP-1772 @excelupload @regression @negative
  Scenario: Verification of DELETE request for incorrect cluster name
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for DELETE request with url "/uploads/Upload" with the following query param
      | databaseName | foodmart         |
      | tableName    | inventory_fact   |
      | clusterName  | Cluster Test New |
    Then Status code 404 must be returned
    And response body should have "not found in catalog" message

  @MLP-1772 @excelupload @regression @negative
  Scenario: Verification of DELETE request for table name
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for DELETE request with url "/uploads/Upload" with the following query param
      | databaseName | foodmart      |
      | tableName    | inventory_fac |
      | clusterName  | Cluster Demo  |
    Then Status code 404 must be returned
    And response body should have "not found in catalog" message

  @MLP-1772 @excelupload @sanity @regression @positive
  Scenario: Verification of uploading xls file with allow update as true
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "datasetupload/store_sample.xls" to request
    When user makes a REST Call for POST request with url "/uploads/Upload" with the following query param
      | databaseName | healthcare   |
      | tableName    | demographics |
      | clusterName  | Cluster Demo |
      | allowUpdate  | true         |
    Then Status code 200 must be returned
    And excel "store_sample.xls" should be uploaded to uploadData table
      | description | schemaName | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | Upload     | V_UploadData | *          | name         | databaseName | tableName  | clusterName | hostName |

  @MLP-1772 @excelupload @regression @positive
  Scenario: Verification of uploading xls file with allow update as flase
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "datasetupload/sales_fact_dec_1998.xls" to request
    When user makes a REST Call for POST request with url "/uploads/Upload" with the following query param
      | databaseName | default      |
      | tableName    | sample_07    |
      | clusterName  | Cluster Demo |
      | allowUpdate  | false        |
    Then Status code 200 must be returned
    And excel "sales_fact_dec_1998.xls" should be uploaded to uploadData table
      | description | schemaName | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | Upload     | V_UploadData | *          | name         | databaseName | tableName  | clusterName | hostName |

  @MLP-1772 @excelupload @sanity @regression @negative
  Scenario: Verification of uploading already exitsing xls file in a new catalog with same db table and cluster
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user attaches/upload file "datasetupload/sales_fact_dec_1998.xls" to request
    When user makes a REST Call for POST request with url "/uploads/Upload Data" with the following query param
      | databaseName | default      |
      | tableName    | sample_07    |
      | clusterName  | Cluster Demo |
      | allowUpdate  | true         |
    Then Status code 400 must be returned
    And response body should have "already exist in catalog" message


  @MLP-1772 @excelupload @regression @positive
  Scenario: Verification of updating uploaded xls file with new DB and new table in same cluster
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | multipart/form-data                |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user executes the following Query in the Hive JDBC
      | queryEntry                  |
      | CreateFacebookmediaDatabase |
      | CreateSalesTable            |
    And user attaches/upload file "datasetupload/sales_fact_dec_1998.xls" to request
    When user makes a REST Call for POST request with url "/uploads/Upload" with the following query param
      | databaseName | facebookmedia |
      | tableName    | sales_info    |
      | clusterName  | Cluster Demo  |
      | allowUpdate  | true          |
    Then Status code 200 must be returned
    And excel "sales_fact_dec_1998.xls" should be uploaded to uploadData table "sales_info"
      | description | schemaName | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
      | SELECT      | Upload     | V_UploadData | *          | tableName    | databaseName | tableName  | clusterName | hostName |

#  @MLP-1772 @excelupload @regression @positive
#  Scenario: Verification of updating uploaded xls file in  a new cluster with old DB and old table value
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "datasetupload/sales_fact_dec_1998.xls" to request
#    When user makes a REST Call for POST request with url "/uploads/Upload" with the following query param
#      | databaseName | xademo           |
#      | tableName    | sales_fact       |
#      | clusterName  | Cluster Xls Test |
#      | allowUpdate  | false            |
#    Then Status code 200 must be returned
#    And excel "sales_fact_dec_1998.xls" should be uploaded to new cluster "Cluster Xls Test"
#      | description | schemaName | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
#      | SELECT      | Upload     | V_UploadData | *          | clusterName  | databaseName | tableName  | clusterName | hostName |

  @MLP-1772 @excelupload @positive
  Scenario: Verification of GET request of Upload xls file data
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "/uploads/Upload/uploaddata" with the following query param
      | databaseName | healthcare   |
      | tableName    | demographics |
      | clusterName  | Cluster Demo |
    Then Status code 200 must be returned
    And Database "healthcare" and tableName "demographics" and cluster "Cluster Demo" and file "store_sample.xls"should be matching

  @MLP-1772 @excelupload @negative
  Scenario: Verification of GET request of Upload file data for incorrect table name
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "/uploads/Upload/uploaddata" with the following query param
      | databaseName | healthcare   |
      | tableName    | store_fact   |
      | clusterName  | Cluster Demo |
    Then Status code 404 must be returned
    And response body should have "not found in catalog" message

  @MLP-1772 @excelupload @negative
  Scenario: Verification of GET request of Upload file data for incorrect cluster name
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "/uploads/Upload/uploaddata" with the following query param
      | databaseName | healthcare   |
      | tableName    | store_facts  |
      | clusterName  | Cluster Test |
    Then Status code 404 must be returned
    And response body should have "not found in catalog" message

  @MLP-1772 @excelupload @sanity @regression @positive
  Scenario: Verification of downloading xls file
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/octet-stream           |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "/uploads/Upload/content" with the following query param
      | databaseName | healthcare   |
      | tableName    | demographics |
      | clusterName  | Cluster Demo |
    Then Status code 200 must be returned
    And user should able to download the file in "DOWNLOAD_FILE_PATH" and save it as "store_file.xls"
    And both "UPLOAD_FILE_PATH" directory file "store_sample.xls" and "DOWNLOAD_FILE_PATH" directory file "store_file.xls" should match

  @MLP-1772 @excelupload @regression @negative
  Scenario: Verification of download request for incorrect cluster name
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/octet-stream,application/json |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ==        |
    And user makes a REST Call for Get request with url "/uploads/Upload/uploaddata" with the following query param
      | databaseName | healthcare   |
      | tableName    | demographics |
      | clusterName  | Cluster New  |
    Then Status code 404 must be returned
    And response body should have "not found in catalog" message

  @MLP-1772 @excelupload @negative
  Scenario: Verification of DELETE request for incorrect cluster name
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for DELETE request with url "/uploads/Upload" with the following query param
      | databaseName | default     |
      | tableName    | sample_07   |
      | clusterName  | Cluster New |
    Then Status code 404 must be returned
    And response body should have "not found in catalog" message

  @MLP-1772 @excelupload @sanity @regression @positive
  Scenario: Verification of DELETE request for uploaded xls file
    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for DELETE request with url "/uploads/Upload" with the following query param
      | databaseName | facebookmedia |
      | tableName    | sales_info    |
      | clusterName  | Cluster Demo  |
    Then Status code 200 must be returned
    And file "sales_fact_dec_1998.xls" should be removed from "facebookmedia" database and "sales_info" table
      | description | schemaName | tableName    | columnName | criteriaName           |
      | SELECT      | Upload     | V_UploadData | status     | databaseName,tableName |

#  @MLP-1772 @excelupload @sanity @regression
#  Scenario: Verification of uploading csv file with allow update as true
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "datasetupload/traveltime.csv" to request
#    When user makes a REST Call for POST request with url "/uploads/Upload" with the following query param
#      | databaseName | media       |
#      | tableName    | traveltime  |
#      | clusterName  | Cluster CSV |
#      | allowUpdate  | true        |
#    Then Status code 200 must be returned
#    And excel "traveltime.csv" should be uploaded to uploadData table
#      | description | schemaName | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
#      | SELECT      | Upload     | V_UploadData | *          | name         | databaseName | tableName  | clusterName | hostName |
#
#  @MLP-1772 @excelupload @regression
#  Scenario: Verification of uploading csv file with allow update as flase
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "datasetupload/product_sample.csv" to request
#    When user makes a REST Call for POST request with url "/uploads/Upload" with the following query param
#      | databaseName | media        |
#      | tableName    | product_fact |
#      | clusterName  | Cluster CSV  |
#      | allowUpdate  | false        |
#    Then Status code 200 must be returned
#    And excel "product_sample.csv" should be uploaded to uploadData table
#      | description | schemaName | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
#      | SELECT      | Upload     | V_UploadData | *          | name         | databaseName | tableName  | clusterName | hostName |

#  @MLP-1772 @excelupload  @regression
#  Scenario: Verification of updating uploaded csv file with allow update as flase
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "datasetupload/product_sample.csv" to request
#    When user makes a REST Call for POST request with url "/uploads/Upload Data" with the following query param
#      | databaseName | media        |
#      | tableName    | product_fact |
#      | clusterName  | Cluster CSV  |
#      | allowUpdate  | false        |
#    Then Status code 400 must be returned
#    And response body should have "already exist in catalog" message
#
#  @MLP-1772 @excelupload
#  Scenario: Verification of updating uploaded csv file with in a new table and new DB with old cluster
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "datasetupload/product_sample.csv" to request
#    When user makes a REST Call for POST request with url "/uploads/Upload" with the following query param
#      | databaseName | xademo        |
#      | tableName    | product_infos |
#      | clusterName  | Cluster Csv   |
#      | allowUpdate  | true          |
#    Then Status code 200 must be returned
#    And  excel "product_sample.csv" should be uploaded to uploadData table "product_infos"
#      | description | schemaName | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
#      | SELECT      | Upload     | V_UploadData | *          | tableName    | databaseName | tableName  | clusterName | hostName |
#
#  @MLP-1772 @excelupload @regression
#  Scenario: Verification of updating uploaded xls file in  a new cluster with old DB and old table value
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "datasetupload/traveltime.csv" to request
#    When user makes a REST Call for POST request with url "/uploads/Upload" with the following query param
#      | databaseName | travel_info      |
#      | tableName    | traveltime       |
#      | clusterName  | Cluster Csv Test |
#      | allowUpdate  | false            |
#    Then Status code 200 must be returned
#    And excel "traveltime.csv" should be uploaded to new cluster "Cluster Csv Test"
#      | description | schemaName | tableName    | columnName | criteriaName | firstColName | secColName | clusterName | hostName |
#      | SELECT      | Upload     | V_UploadData | *          | clusterName  | databaseName | tableName  | clusterName | hostName |
#
#  @MLP-1772 @excelupload
#  Scenario: Verification of GET request of Upload csv file data
#    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user makes a REST Call for Get request with url "/uploads/Upload/uploaddata" with the following query param
#      | databaseName | travel_info      |
#      | tableName    | traveltime       |
#      | clusterName  | Cluster Csv Test |
#    Then Status code 200 must be returned
#    And  Database "travel_info" and tableName "traveltime" and cluster "Cluster Csv Test" and file "traveltime.csv"should be matching
#
#  @MLP-1772 @excelupload
#  Scenario: Verification of GET request of Upload file data for incorrect cluster Name
#    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user makes a REST Call for Get request with url "/uploads/Upload/uploaddata" with the following query param
#      | databaseName | travel_info |
#      | tableName    | traveltime  |
#      | clusterName  | Cluster Csv |
#    Then Status code 404 must be returned
#    And response body should have "not found in catalog" message
#
#  @MLP-1772 @excelupload
#  Scenario: Verification of GET request of Upload file data for incorrect database name
#    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user makes a REST Call for Get request with url "/uploads/Upload/uploaddata" with the following query param
#      | databaseName | travel           |
#      | tableName    | traveltime       |
#      | clusterName  | Cluster Csv Test |
#    Then Status code 404 must be returned
#    And response body should have "not found in catalog" message
#
#  @MLP-1772 @excelupload @sanity @regression
#  Scenario: Verification of downloading csv file
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Accept        | application/octet-stream           |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user makes a REST Call for Get request with url "/uploads/Upload/filedata" with the following query param
#      | databaseName | travel_info      |
#      | tableName    | traveltime       |
#      | clusterName  | Cluster Csv Test |
#    Then Status code 200 must be returned
#    And user should able to download the file in "DOWNLOAD_FILE_PATH" and save it as "traveltime_file.csv"
#    And both "UPLOAD_FILE_PATH" directory file "traveltime.csv" and "DOWNLOAD_FILE_PATH" directory file "traveltime_file.csv" should match

#  @MLP-1772 @excelupload @regression
#  Scenario: Verification of download request for incorrect table name
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Accept        | application/octet-stream,application/json |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ==        |
#    And user makes a REST Call for Get request with url "/uploads/Upload/filedata" with the following query param
#      | databaseName | travel_info      |
#      | tableName    | travel           |
#      | clusterName  | Cluster Csv Test |
#    Then Status code 404 must be returned
#    And response body should have "not found in catalog" message
#
#  @MLP-1772 @excelupload
#  Scenario: Verification of DELETE request for incorrect table name
#    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user makes a REST Call for DELETE request with url "/uploads/Upload" with the following query param
#      | databaseName | travel_info      |
#      | tableName    | travel           |
#      | clusterName  | Cluster Csv Test |
#    Then Status code 404 must be returned
#    And response body should have "not found in catalog" message
#
#  @MLP-1772 @excelupload @sanity @regression
#  Scenario: Verification of DELETE request for uploaded csv file
#    Given  To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user makes a REST Call for DELETE request with url "/uploads/Upload" with the following query param
#      | databaseName | media        |
#      | tableName    | product_fact |
#      | clusterName  | Cluster CSV  |
#    Then Status code 200 must be returned
#    And file "product_sample.csv" should be removed from "media" database and "product_fact" table
#      | description | schemaName | tableName    | columnName | criteriaName           |
#      | SELECT      | Upload     | V_UploadData | status     | databaseName,tableName |

  @MLP-1772 @excelupload @sanity @regression @positive
  Scenario: Deleting newly created database and table
    Given user executes the following Query in the Hive JDBC
      | queryEntry                |
      | DropInventoryTable        |
      | DropExceluploadDatabase   |
      | DropSalesTable            |
      | DropFacebookmediaDatabase |