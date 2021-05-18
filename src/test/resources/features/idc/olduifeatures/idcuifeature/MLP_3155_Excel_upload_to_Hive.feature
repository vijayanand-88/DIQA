#@MLP-3155
#Feature:MLP-3155: This feature is to verify the excel upload to Hive
#
#  @MLP-3155 @excelUpload @regression @positive @sanity
#  Scenario: MLP-3155 Updating the config of upload Hive plugin with target host
#    Given update the upload Hive config to use target host from file "idc/uploadHive.json"
#
#  @MLP-3155 @positve @excelUpload @regression @sanity
#  Scenario Outline: Updating the config for Upload Hive plugin
#    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | Header           | Query | Param | type | url                              | body                                                       | response code | response message |
#      | application/json | raw   | false | Put  | settings/analyzers/UploadHive    | idc/uploadHive.json                                        | 204           |                  |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive @sanity
#  Scenario:MLP-3155: Verify xlsx file upload to Hive
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    And user clicks Upload Excel File button
#    And user clicks on browse button
#    And user upload file
#      | Method       | Action                   |
#      | setAutoDelay | 1000                     |
#      | selectAFile  | person_address_info.xlsx |
#      | setAutoDelay | 1000                     |
#      | keyPress     | CONTROL                  |
#      | keyPress     | V                        |
#      | keyRelease   | CONTROL                  |
#      | keyRelease   | V                        |
#      | setAutoDelay | 1000                     |
#      | keyPress     | ENTER                    |
#      | keyRelease   | ENTER                    |
#    And user clicks on "CATALOG" and choose "BigData"
#    And user clicks on "CLUSTER" and choose "Cluster Demo"
#    And user enters "DATABASE" name as "default"
#    And user enters "TABLE NAME" name as "prsn_address_info"
#    And user clicks on submit button
#    And user refreshes the application
#    Then user should be able to see upload data of "person_address_info.xlsx"
#    And user get the ID for data set "person_address_info.xlsx" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And user verifies the upload data for "person_address_info.xlsx" file
#      | allowUpdate | clusterName  | createdTableNames | databaseName | Host name | ID | message           | Sheet name | Status   | tableName         |
#      | false       | Cluster Demo | prsn_address_info | default      |           |    | Upload Successful |            | UPLOADED | prsn_address_info |
#    And user checks the existence of Hive table through JDBC and verify that row count is 5
#      | queryList    |
#      | prsn_address |
#    And inedx 1 columns and its index 2 datatype should match for "prsn_address_info" table
#      | name   | ssn    | ee_id  | ip_address | gender  | address |
#      | string | string | bigint | string     | char(1) | string  |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive @sanity
#  Scenario:MLP-3155: Verify xlsx upload to Hive
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    When user makes a REST Call for DELETE request with url "/uploads/BigData" with the following query param
#      | catalogname  | BigData           |
#      | databaseName | default           |
#      | tableName    | prsn_address_info |
#      | clusterName  | Cluster Demo      |
#    And user attaches/upload file "excelupload/person_address_info.xlsx" to request
#    And user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | default           |
#      | tableName    | prsn_address_info |
#      | clusterName  | Cluster Demo      |
#      | allowUpdate  | false             |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    Then user should be able to see upload data of "person_address_info.xlsx"
#    And user get the ID for data set "person_address_info.xlsx" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And user verifies the upload data for "person_address_info.xlsx" file
#      | allowUpdate | clusterName  | createdTableNames | databaseName | Host name | ID | message           | Sheet name | Status   | tableName         |
#      | false       | Cluster Demo | prsn_address_info | default      |           |    | Upload Successful |            | UPLOADED | prsn_address_info |
#    And user checks the existence of Hive table through JDBC and verify that row count is 5
#      | queryList    |
#      | prsn_address |
#    And inedx 1 columns and its index 2 datatype should match for "prsn_address_info" table
#      | name   | ssn    | ee_id  | ip_address | gender  | address |
#      | string | string | bigint | string     | char(1) | string  |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive @sanity
#  Scenario Outline: Verification of prsn address parquet file
#    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                              | body | response code | response message          |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/prsn_address_info?op=LISTSTATUS |      | 200           | prsn_address_info.parquet |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive @sanity
#  Scenario:MLP-3155: Verify xls file upload to Hive
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    When user makes a REST Call for DELETE request with url "/uploads/BigData" with the following query param
#      | databaseName | default          |
#      | tableName    | prsn_system_info |
#      | clusterName  | Cluster Demo     |
#      | allowUpdate  | false            |
#    And user attaches/upload file "excelupload/person_system_info.xls" to request
#    And user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | default          |
#      | tableName    | prsn_system_info |
#      | clusterName  | Cluster Demo     |
#      | allowUpdate  | false            |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    Then user should be able to see upload data of "person_system_info.xls"
#    And user get the ID for data set "person_system_info.xls" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And user verifies the upload data for "person_system_info.xls" file
#      | allowUpdate | clusterName  | createdTableNames | databaseName | Host name | ID | message           | Sheet name | Status   | tableName        |
#      | false       | Cluster Demo | prsn_system_info  | default      |           |    | Upload Successful |            | UPLOADED | prsn_system_info |
#    And user checks the existence of Hive table through JDBC and verify that row count is 30
#      | queryList   |
#      | prsn_system |
#    And inedx 1 columns and its index 2 datatype should match for "prsn_system_info" table
#      | name   | ssn    | employee_id | system_address | os_platform | software |
#      | string | string | bigint      | string         | string      | string   |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive @sanity
#  Scenario Outline: Verification of prsn system parquet file
#    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                             | body | response code | response message         |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/prsn_system_info?op=LISTSTATUS |      | 200           | prsn_system_info.parquet |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive @sanity
#  Scenario:MLP-3155: Verify xlsx upload using sheetName parameter
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "excelupload/Person Data.xlsx" to request
#    And user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | default            |
#      | tableName    | prsn_family_info   |
#      | sheetName    | Family Information |
#      | clusterName  | Cluster Demo       |
#      | allowUpdate  | false              |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    Then user should be able to see upload data of "Person Data.xlsx"
#    And user get the ID for data set "Person Data.xlsx" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And user verifies the upload data for "Person Data.xlsx" file
#      | allowUpdate | clusterName  | createdTableNames | databaseName | Host name | ID | message           | Sheet name         | Status   | tableName        |
#      | false       | Cluster Demo | prsn_family_info  | default      |           |    | Upload Successful | Family Information | UPLOADED | prsn_family_info |
#    And user checks the existence of Hive table through JDBC and verify that row count is 31
#      | queryList   |
#      | prsn_family |
#    And inedx 1 columns and its index 2 datatype should match for "prsn_family_info" table
#      | name   | social_security_number | marital_status | spouse_name | spouse_ssn | relation_ship | ex_spouse_name | ex_spouse_ssn | child_1 | ssn    | relation_ship_status |
#      | string | string                 | string         | string      | string     | string        | string         | string        | string  | string | string               |
#
#  @MLP-3155  @excelUpload @regression @positive @sanity
#  Scenario Outline: Verification of prsn family parquet file
#    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                             | body | response code | response message         |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/prsn_family_info?op=LISTSTATUS |      | 200           | prsn_family_info.parquet |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verify multi sheet xlsx upload
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "excelupload/PII.xlsx" to request
#    When user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | default      |
#      | tableName    | pii          |
#      | clusterName  | Cluster Demo |
#      | allowUpdate  | false        |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    Then user should be able to see upload data of "PII.xlsx"
#    And user get the ID for data set "PII.xlsx" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And user verifies the upload data for "PII.xlsx" file
#      | allowUpdate | clusterName  | createdTableNames               | databaseName | Host name | ID | message           | Sheet name | Status   | tableName |
#      | false       | Cluster Demo | pii_Data,pii_Address,pii_Family | default      |           |    | Upload Successful |            | UPLOADED | pii       |
#    And user checks the existence of Hive table through JDBC and verify that row count is 9
#      | queryList |
#      | data      |
#      | address   |
#      | family    |
#    And inedx 1 columns and its index 2 datatype should match for "pii_data" table
#      | first_name | middle_name | last_name | social_security_number | date_of_birth | full_name | marital_status | disablity | employee_id | work_location | work_location_state_code | employement_status |
#      | string     | string      | string    | string                 | string        | string    | string         | string    | bigint      | string        | string                   | string             |
#    And inedx 1 columns and its index 2 datatype should match for "pii_address" table
#      | person_name | social_security_number | address_line_1 | adreess_line_2 | adreess_line_3 | city   | state  | zip_code | personal_mobile_number | work__number | personal_email | work_email |
#      | string      | string                 | string         | string         | string         | string | string | string   | string                 | string       | string         | string     |
#    And inedx 1 columns and its index 2 datatype should match for "pii_family" table
#      | name   | social_security_number | marital_status | spouse_name | spouse_ssn | relation_ship | child_1 | ssn    | relation_ship_status |
#      | string | string                 | string         | string      | string     | string        | string  | string | string               |
#
#  @MLP-3155  @excelUpload @regression @positive
#  Scenario Outline: Verification of pii multisheet parquet file
#    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                        | body | response code | response message    |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/pii_Data?op=LISTSTATUS    |      | 200           | pii_Data.parquet    |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/pii_Address?op=LISTSTATUS |      | 200           | pii_Address.parquet |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/pii_Family?op=LISTSTATUS  |      | 200           | pii_Family.parquet  |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verify multi sheet xls upload
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "excelupload/prsn_profile.xls" to request
#    When user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | default      |
#      | tableName    | pii_xls      |
#      | clusterName  | Cluster Demo |
#      | allowUpdate  | false        |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    Then user should be able to see upload data of "prsn_profile.xls"
#    And user get the ID for data set "prsn_profile.xls" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And user verifies the upload data for "prsn_profile.xls" file
#      | allowUpdate | clusterName  | createdTableNames                               | databaseName | Host name | ID | message           | Sheet name | Status   | tableName |
#      | false       | Cluster Demo | pii_xls_system,pii_xls_identity,pii_xls_profile | default      |           |    | Upload Successful |            | UPLOADED | pii_xls   |
#    And user checks the existence of Hive table through JDBC and verify that row count is 30
#      | queryList |
#      | system    |
#      | identity  |
#      | profile   |
#    And inedx 1 columns and its index 2 datatype should match for "pii_xls_system" table
#      | name   | ssn    | employee_id | system_addreess | os_platform | software |
#      | string | string | bigint      | string          | string      | string   |
#    And inedx 1 columns and its index 2 datatype should match for "pii_xls_identity" table
#      | name   | social_security_number | employee_id | father_name | mother_name | birth_place | driving_license_number | vechicle_registration_number | ccn_number |
#      | string | string                 | bigint      | string      | string      | string      | string                 | string                       | bigint     |
#    And inedx 1 columns and its index 2 datatype should match for "pii_xls_profile" table
#      | name   | social_security_number | employee_id | education_qualification | employment_start_date | designation | nationality | passport_identification | user_name | password | higly_compensated_employee | salary_account_number | bank_name |
#      | string | string                 | bigint      | string                  | string                | string      | string      | string                  | string    | string   | string                     | double                | string    |
#
#
#  @MLP-3155  @excelUpload @regression @positive
#  Scenario Outline: Verification of pii xls multisheet parquet file
#    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                             | body | response code | response message         |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/pii_xls_system?op=LISTSTATUS   |      | 200           | pii_xls_system.parquet   |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/pii_xls_profile?op=LISTSTATUS  |      | 200           | pii_xls_profile.parquet  |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/pii_xls_identity?op=LISTSTATUS |      | 200           | pii_xls_identity.parquet |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of uploading new line character in xlsx
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "excelupload/New line through space1.xlsx" to request
#    When user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | default         |
#      | tableName    | new_line_space1 |
#      | clusterName  | Cluster Demo    |
#      | allowUpdate  | false           |
#    And Status code 200 must be returned
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    And user should be able to see upload data of "New line through space1.xlsx"
#    And user get the ID for data set "New line through space1.xlsx" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And user verifies the upload data for "New line through space1.xlsx" file
#      | allowUpdate | clusterName  | createdTableNames | databaseName | Host name | ID | message           | Sheet name | Status   | tableName       |
#      | false       | Cluster Demo | new_line_space1   | default      |           |    | Upload Successful |            | UPLOADED | new_line_space1 |
#    And user checks the existence of Hive table through JDBC and verify that row count is 2
#      | queryList |
#      | new line  |
#    And inedx 1 columns and its index 2 datatype should match for "new_line_space" table
#      | name   | age    | address |
#      | string | string | string  |
#
#  @MLP-3155  @excelUpload @regression @positive
#  Scenario Outline: Verification of new line character xlsx parquet file
#    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                            | body | response code | response message        |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/new_line_space1?op=LISTSTATUS |      | 200           | new_line_space1.parquet |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of uploading new line character in xls
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "excelupload/Newline.xls" to request
#    When user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | default      |
#      | tableName    | new_line_xls |
#      | clusterName  | Cluster Demo |
#      | allowUpdate  | false        |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    Then user should be able to see upload data of "Newline.xls"
#    And user get the ID for data set "Newline.xls" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And user verifies the upload data for "Newline.xls" file
#      | allowUpdate | clusterName  | createdTableNames | databaseName | Host name | ID | message           | Sheet name | Status   | tableName    |
#      | false       | Cluster Demo | new_line_xls      | default      |           |    | Upload Successful |            | UPLOADED | new_line_xls |
#    And user checks the existence of Hive table through JDBC and verify that row count is 2
#      | queryList    |
#      | xls new line |
#    And inedx 1 columns and its index 2 datatype should match for "new_line_xls" table
#      | full_name_midddle_name | profession__act__department | re_mark_feedback |
#      | string                 | string                      | string           |
#
#  @MLP-3155  @excelUpload @regression @positive
#  Scenario Outline: Verification of new line character xls parquet file
#    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                         | body | response code | response message     |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/new_line_xls?op=LISTSTATUS |      | 200           | new_line_xls.parquet |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of updating a table from xlsx file upload
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "excelupload/person_address_info_updated.xlsx" to request
#    When user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | default           |
#      | tableName    | prsn_address_info |
#      | clusterName  | Cluster Demo      |
#      | allowUpdate  | true              |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    Then user should be able to see upload data of "person_address_info_updated.xlsx"
#    And user get the ID for data set "person_address_info_updated.xlsx" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And user verifies the upload data for "person_address_info_updated.xlsx" file
#      | allowUpdate | clusterName  | createdTableNames | databaseName | Host name | ID | message           | Sheet name | Status   | tableName         |
#      | true        | Cluster Demo | prsn_address_info | default      |           |    | Upload Successful |            | UPLOADED | prsn_address_info |
#    And user checks the existence of Hive table through JDBC and verify that row count is 10
#      | queryList    |
#      | prsn_address |
#    And inedx 1 columns and its index 2 datatype should match for "prsn_address_info" table
#      | name   | ssn    | ee_id  | ip_address | gender  | address | designation | experience |
#      | string | string | bigint | string     | char(1) | string  | string      | double     |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario Outline: Verification of updated prsn address parquet file
#    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                              | body | response code | response message          |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/prsn_address_info?op=LISTSTATUS |      | 200           | prsn_address_info.parquet |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of updating a table from xls file upload
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "excelupload/person_system_info_updated.xls" to request
#    When user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | default          |
#      | tableName    | prsn_system_info |
#      | clusterName  | Cluster Demo     |
#      | allowUpdate  | true             |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    Then user should be able to see upload data of "person_system_info_updated.xls"
#    And user get the ID for data set "person_system_info_updated.xls" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And user verifies the upload data for "person_system_info_updated.xls" file
#      | allowUpdate | clusterName  | createdTableNames | databaseName | Host name | ID | message           | Sheet name | Status   | tableName        |
#      | true        | Cluster Demo | prsn_system_info  | default      |           |    | Upload Successful |            | UPLOADED | prsn_system_info |
#    And user checks the existence of Hive table through JDBC and verify that row count is 17
#      | queryList   |
#      | prsn_system |
#    And inedx 1 columns and its index 2 datatype should match for "prsn_system_info" table
#      | name   | employee_id | system_address | os_platform | software |
#      | string | bigint      | string         | string      | string   |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario Outline: Verification of updated prsn system parquet file
#    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                             | body | response code | response message         |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/prsn_system_info?op=LISTSTATUS |      | 200           | prsn_system_info.parquet |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of different data types
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "excelupload/diffTypeColumns.xlsx" to request
#    When user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | default        |
#      | tableName    | diff_type_cols |
#      | clusterName  | Cluster Demo   |
#      | allowUpdate  | false          |
#    And Status code 200 must be returned
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    Then user should be able to see upload data of "diffTypeColumns.xlsx"
#    And user get the ID for data set "diffTypeColumns.xlsx" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And user verifies the upload data for "diffTypeColumns.xlsx" file
#      | allowUpdate | clusterName  | createdTableNames | databaseName | Host name | ID | message           | Sheet name | Status   | tableName      |
#      | false       | Cluster Demo | diff_type_cols    | default      |           |    | Upload Successful |            | UPLOADED | diff_type_cols |
#    And user checks the existence of Hive table through JDBC and verify that row count is 10
#      | queryList |
#      | diff cols |
#    And inedx 1 columns and its index 2 datatype should match for "diff_type_cols" table
#      | name   | birth_date | age    | cgpa   | gender  | start_time | own_vehicle | insurance_number | conduct |
#      | string | string     | bigint | double | char(1) | string     | boolean     | double           | string  |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario Outline: Verification of different type columns parquet file
#    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                           | body | response code | response message       |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/diff_type_cols?op=LISTSTATUS |      | 200           | diff_type_cols.parquet |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of uploading excel with null value columns
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "excelupload/null values check.xlsx" to request
#    When user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | default      |
#      | tableName    | null_check   |
#      | clusterName  | Cluster Demo |
#      | allowUpdate  | false        |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    Then user should be able to see upload data of "null values check.xlsx"
#    And user get the ID for data set "null values check.xlsx" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And user verifies the upload data for "null values check.xlsx" file
#      | allowUpdate | clusterName  | createdTableNames | databaseName | Host name | ID | message           | Sheet name | Status   | tableName  |
#      | false       | Cluster Demo | null_check        | default      |           |    | Upload Successful |            | UPLOADED | null_check |
#    And user checks the existence of Hive table through JDBC and verify that row count is 6
#      | queryList  |
#      | null check |
#    And inedx 1 columns and its index 2 datatype should match for "null_check" table
#      | name   | id     | dob    | gender  | experience | education | insurance_number | bilablity | license |
#      | string | bigint | string | char(1) | double     | string    | bigint           | boolean   | string  |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario Outline: Verification of null check parquet file
#    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                       | body | response code | response message   |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/null_check?op=LISTSTATUS |      | 200           | null_check.parquet |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of xlsx file upload in new database
#    Given user creates a new database "exceluploaddemo"
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "excelupload/Employee Insurance coverage details.xlsx" to request
#    And user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | exceldemo         |
#      | tableName    | ee_insurance_info |
#      | clusterName  | Cluster Demo      |
#      | allowUpdate  | false             |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And  user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    And user should be able to see upload data of "Employee Insurance coverage details.xlsx"
#    And user get the ID for data set "Employee Insurance coverage details.xlsx" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And user verifies the upload data for "Employee Insurance coverage details.xlsx" file
#      | allowUpdate | clusterName  | createdTableNames | databaseName | Host name | ID | message           | Sheet name | Status   | tableName         |
#      | false       | Cluster Demo | ee_insurance_info | exceldemo    |           |    | Upload Successful |            | UPLOADED | ee_insurance_info |
#    And user checks the existence of Hive table through JDBC and verify that row count is 30
#      | queryList    |
#      | ee insuarnce |
#    And inedx 1 columns and its index 2 datatype should match for "ee_insuarnce_info" table
#      | name   | ssn    | ee_id  | basic_life | supp_life | spouse_life | child_life | acci_insu |
#      | string | string | bigint | string     | string    | string      | string     | string    |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario Outline: Verification of ee insurance info parquet file
#    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                              | body | response code | response message          |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/ee_insurance_info?op=LISTSTATUS |      | 200           | ee_insurance_info.parquet |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of xls file upload in new database
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "excelupload/person pay data.xls" to request
#    And user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | exceldemo     |
#      | tableName    | prsn_pay_data |
#      | clusterName  | Cluster Demo  |
#      | allowUpdate  | false         |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    Then user should be able to see upload data of "person pay data.xls"
#    And user get the ID for data set "person pay data.xls" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And user verifies the upload data for "person pay data.xls" file
#      | allowUpdate | clusterName  | createdTableNames | databaseName | Host name | ID | message           | Sheet name | Status   | tableName     |
#      | false       | Cluster Demo | prsn_pay_data     | exceldemo    |           |    | Upload Successful |            | UPLOADED | prsn_pay_data |
#    And user checks the existence of Hive table through JDBC and verify that row count is 30
#      | queryList |
#      | pay data  |
#    And inedx 1 columns and its index 2 datatype should match for "prsn_pay_data" table
#      | name   | ssn    | ee_id  | payroll | annual_compensation | bonus_amount | leave_bonus | claims | savings |
#      | string | string | bigint | string  | bigint              | bigint       | bigint      | bigint | bigint  |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario Outline: Verification of prsn pay info parquet file
#    When configure dynamic endpoint for "<ServiceName>" having multiple header "<Authorization>" "<X-Requested-By>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | ServiceName  | Authorization              | X-Requested-By | type | url                                          | body | response code | response message      |
#      | HdfsNameNode | Basic cmFqX29wczpyYWpfb3Bz | ambari         | Get  | home/excelUpload/prsn_pay_data?op=LISTSTATUS |      | 200           | prsn_pay_data.parquet |
#
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of deleting a hive table from xlsx upload
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user makes a REST Call for DELETE request with url "/uploads/BigData" with the following query param
#      | databaseName | exceldemo         |
#      | tableName    | ee_insurance_info |
#      | clusterName  | Cluster Demo      |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    And user should be able to see upload data of "Employee Insurance coverage details.xlsx"
#    And user get the ID for data set "Employee Insurance coverage details.xlsx" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And  user verifies the upload data for "Employee Insurance coverage details.xlsx" file
#      | allowUpdate | clusterName  | createdTableNames | databaseName | Host name | ID | message                                                        | Sheet name | Status  | tableName         |
#      | false       | Cluster Demo | ee_insurance_info | exceldemo    |           |    | Delete Operation Successful: Tables Deleted: ee_insurance_info |            | DELETED | ee_insurance_info |
##    Then user should see the following tables in "exceldemo" database in col 1
##      | prsn_pay_data |
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of deleting a hive table from xls upload
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user makes a REST Call for DELETE request with url "/uploads/BigData" with the following query param
#      | databaseName | exceldemo     |
#      | tableName    | prsn_pay_data |
#      | clusterName  | Cluster Demo  |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    And user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    And user should be able to see upload data of "person pay data.xls"
#    And user get the ID for data set "person pay data.xls" from below query
#      | description | schemaName | tableName    | columnName | criteriaName |
#      | SELECT      | BigData    | V_UploadData | ID         | name         |
#    And  user verifies the upload data for "person pay data.xls" file
#      | allowUpdate | clusterName  | createdTableNames | databaseName | Host name | ID | message                                                    | Sheet name | Status  | tableName     |
#      | false       | Cluster Demo | prsn_pay_data     | exceldemo    |           |    | Delete Operation Successful: Tables Deleted: prsn_pay_data |            | DELETED | prsn_pay_data |
#
#  @MLP-3155 @webtest @excelUpload @regression @negative
#  Scenario:MLP-3155: Verification of incorrect xlsx file upload
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "excelupload/Incorrect_file.xlsx" to request
#    And user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | exceldemo            |
#      | tableName    | incorrect_file_check |
#      | clusterName  | Cluster Demo         |
#      | allowUpdate  | false                |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    Then user should be able to see upload data of "Incorrect_file.xlsx"
#    And user clicks on upload data "Incorrect_file.xlsx"
#    Then user should be seeing the "Status" as "FAILED"
#
#  @MLP-3155 @webtest @excelUpload @regression @negative
#  Scenario:MLP-3155: Verification of incorrect xls file upload
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "excelupload/Incorrect_file.xls" to request
#    And user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | exceldemo                |
#      | tableName    | incorrect_xls_file_check |
#      | clusterName  | Cluster Demo             |
#      | allowUpdate  | false                    |
#    And Status code 200 must be returned
#    And User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    Then user should be able to see upload data of "Incorrect_file.xls"
#    And user clicks on upload data "Incorrect_file.xls"
#    Then user should be seeing the "Status" as "FAILED"
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of Excel upload mandatory fields
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    And user clicks Upload Excel File button
#    Then user should be seeing "CLUSTER" as mandatory field
#    And  user should be seeing "CATALOG" as mandatory field
#    And  user should be seeing "TABLE NAME" as a mandatory field
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of uploading a new excel file to existing table without checking the allow update
#    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
#      | Content-Type  | multipart/form-data                |
#      | Accept        | application/json                   |
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#    And user attaches/upload file "excelupload/prsn_profile.xls" to request
#    And user makes a REST Call for POST request with url "/uploads/BigData" with the following query param
#      | databaseName | default          |
#      | tableName    | prsn_system_info |
#      | clusterName  | Cluster Demo     |
#      | allowUpdate  | false            |
#    And Status code 400 must be returned
#    Then response body should have "Upload data for hive table name: 'prsn_system_info', hive database: 'default' and cluster: 'Cluster Demo'  already exist in catalog: 'BigData'" message
#
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of unsaved message popup for Excel upload
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    And user clicks Upload Excel File button
#    And user clicks on browse button
#    And user upload "person_address_info.xlsx" file
#    And user clicks on "CATALOG" and choose "BigData"
#    And user clicks on "CLUSTER" and choose "Cluster Demo"
#    And user enters "DATABASE" name as "default"
#    And user enters "TABLE NAME" name as "prsn_address_info"
#    And user clicks on close button
#    Then user verifies the popup alert content
#    And user clicks on No button in alert message
#    Then user should be still seeing panel "UPLOAD EXCEL FILE"
#    And user clicks on close button
#    And user clicks Yes on the alert window
#    Then user should be still seeing panel "EXCEL UPLOAD MANAGER"
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of Excel upload manager Widget
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user should see the widget "EXCEL UPLOAD MANAGER"
#
#  @MLP-3155 @webtest @excelUpload @regression @positive
#  Scenario:MLP-3155: Verification of Excel upload management panel
#    Given User launch browser and traverse to login page
#    When user enter credentials for "System Administrator1" role
#    And user clicks on Administration widget
#    And user clicks on Excel Upload Manager in Administration dashboard
#    Then user should be still seeing panel "EXCEL UPLOAD MANAGER"
#
