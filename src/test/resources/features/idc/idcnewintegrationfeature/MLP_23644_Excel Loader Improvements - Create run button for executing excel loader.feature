@MLP-23644
Feature: MLP-23644_MLP-24161: Excel Loader Improvements - Create run button for executing excel loader

  ##7121150##
  @MLP-23644 @regression @positive @dashboard
  Scenario:MLP-23644:SC#1: Verify if using POST service - user can import the Sheet using API - /import/spreadsheets/{catalogname}/content.
    Given Execute REST API with following parameters
      | Header              | Query | Param | type  | url                                                    | body                                   | response code | response message | jsonPath |
      | multipart/form-data |       |       | Post  | /import/spreadsheets/Default/content?name=Import_23644 | excelupload/Sample File_23644.xlsx     | 200           |                  |          |

  ##7121152##71211523##
  @MLP-23644 @regression @positive @dashboard
  Scenario:MLP-23644:SC#2: Verify if using GET service - user can view the import status NOT_STARTED
    Given Execute REST API with following parameters
      | Header              | Query | Param | type | url                                                       | body | response code | response message | jsonPath |
      | multipart/form-data |       |       | Get  | import/spreadsheets/Default/bystatus?statuses=NOT_STARTED |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage        |
      | Import_23644           |
      | Sample File_23644.xlsx |

  ##7121151####7121154##
  @MLP-23644 @regression @positive @dashboard
  Scenario Outline: MLP-23644:SC#3: Verify if user can PUT/Modify the imported excel with new sheet Tables using API - /import/spreadsheets
    Given user get the column "Sample File_23644.xlsx" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName | criteriaAttribute       |
      | SELECT      | public     | items     | Import   | id         |              | attributes->>'fileName' |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And Status code 200 must be returned
    And user update the json file "idc/ExcelUploadPayloads/MLP_23644_excelImportForStatus.json" for following values using "response"
      | jsonPath    |
      | $..['id']   |
      | $..['name'] |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query  | Param | type | url                  | body                                                        | response code | response message | jsonPath |
      | application/json |        |       | Put  | /import/spreadsheets | idc/ExcelUploadPayloads/MLP_23644_excelImportForStatus.json | 200           |                  |          |
    Examples:
      | contentType         | acceptType       | type | url                                         | endpoint | body |
      | multipart/form-data | application/json | Get  | import/spreadsheets/Default.Import%3A%3A%3A |          |      |

  ##7121155##7121156##
  @MLP-23644 @regression @positive @dashboard
  Scenario:MLP-23644:SC#4: Verify if using GET service - user can view the import status NOT_STARTED
    Given Execute REST API with following parameters
      | Header              | Query | Param | type | url                                                       | body | response code | response message | jsonPath |
      | multipart/form-data |       |       | Get  | import/spreadsheets/Default/bystatus?statuses=NOT_STARTED |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage        |
      | Import_23644           |
      | Sample File_23644.xlsx |
      | Tables                 |
      | NOT_STARTED            |

  ##7121157##7121158##
  @MLP-23644 @regression @positive @dashboard
  Scenario Outline: MLP-23644:SC#5: Verify if user can see the attributes - "Name": "Import_23644", "status": "NOT_STARTED" in response body of GET /import/spreadsheets/{id}
    Given user get the column "Sample File_23644.xlsx" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName | criteriaAttribute       |
      | SELECT      | public     | items     | Import   | id         |              | attributes->>'fileName' |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    Then Status code 200 must be returned
    Then Json response message should contains the following value
      | responseMessage |
      | Import_23644    |
      | NOT_STARTED     |
    Examples:
      | contentType         | acceptType       | type | url                                         | endpoint | body |
      | multipart/form-data | application/json | Get  | import/spreadsheets/Default.Import%3A%3A%3A |          |      |

  ##7121159##7121160##7121161##
  @MLP-23644 @regression @positive @dashboard @webtest
  Scenario:MLP-23644:SC#6: Verify in UI - Manage Excel Import screen has the import item 'Import_23644' displayed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem       | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | Import_23644     | Run the excel import  |         |
    And user clicks on search icon

  ##7121162##7121163##
  @MLP-23644 @regression @positive @dashboard
  Scenario:MLP-23644:SC#7: Verify if using GET service - user can view the import status COMPLETED
    Given Execute REST API with following parameters
      | Header              | Query | Param | type | url                                                       | body | response code | response message | jsonPath |
      | multipart/form-data |       |       | Get  | import/spreadsheets/Default/bystatus?statuses=COMPLETED   |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage        |
      | Import_23644           |
      | Sample File_23644.xlsx |
      | Tables                 |
      | COMPLETED              |

  ##7121150##
  @MLP-23644 @regression @positive @dashboard
  Scenario:MLP-23644:SC#8: Verify if using POST service - user can import the Sheet using API - /import/spreadsheets/{catalogname}/content.
    Given Execute REST API with following parameters
      | Header              | Query | Param | type  | url                                                          | body                                   | response code | response message | jsonPath |
      | multipart/form-data |       |       | Post  | import/spreadsheets/Default/content?name=ImportWarning_23644 | excelupload/ImportWarning_23644.xlsx   | 200           |                  |          |

  ##7121152##71211523##
  @MLP-23644 @regression @positive @dashboard
  Scenario:MLP-23644:SC#9: Verify if using the GET service - user can view the import status NOT_STARTED
    Given Execute REST API with following parameters
      | Header              | Query | Param | type | url                                                       | body | response code | response message | jsonPath |
      | multipart/form-data |       |       | Get  | import/spreadsheets/Default/bystatus?statuses=NOT_STARTED |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage          |
      | ImportWarning_23644      |
      | ImportWarning_23644.xlsx |

  ##7121164####7121154##
  @MLP-23644 @regression @positive @dashboard
  Scenario Outline: MLP-23644:SC#10: Verify if user the can PUT/Modify the imported excel with new sheet Tables using API - /import/spreadsheets
    Given user get the column "ImportWarning_23644.xlsx" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName | criteriaAttribute       |
      | SELECT      | public     | items     | Import   | id         |              | attributes->>'fileName' |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And Status code 200 must be returned
    And user update the json file "idc/ExcelUploadPayloads/MLP_23644_excelImportForWarningStatus.json" for following values using "response"
      | jsonPath    |
      | $..['id']   |
      | $..['name'] |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query  | Param | type | url                  | body                                                               | response code | response message | jsonPath |
      | application/json |        |       | Put  | /import/spreadsheets | idc/ExcelUploadPayloads/MLP_23644_excelImportForWarningStatus.json | 200           |                  |          |
    Examples:
      | contentType         | acceptType       | type | url                                         | endpoint | body |
      | multipart/form-data | application/json | Get  | import/spreadsheets/Default.Import%3A%3A%3A |          |      |

  ##7121165##
  @MLP-23644 @regression @positive @dashboard @webtest
  Scenario:MLP-23644:SC#11: Verify in UI - Manage Excel Import screen has the import item 'ImportWarning_23644' displayed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem           | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | ImportWarning_23644  | Run the excel import  |         |
    And user clicks on search icon

  ##7121166##7121167##
  @MLP-23644 @regression @positive @dashboard
  Scenario:MLP-23644:SC#12: Verify if using GET service - user can view the import status COMPLETED_WITH_WARNINGS
    Given Execute REST API with following parameters
      | Header              | Query | Param | type | url                                                                    | body | response code | response message | jsonPath |
      | multipart/form-data |       |       | Get  | import/spreadsheets/Default/bystatus?statuses=COMPLETED_WITH_WARNINGS  |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage          |
      | ImportWarning_23644.xlsx |
      | COMPLETED_WITH_WARNINGS  |

 ########################################################################################

  ## MLP-24161 - Excel Loader Improvements - Backend changes for Log Functionality##

  ##7156987##
  @MLP-24161 @regression @positive @dashboard
  Scenario:MLP-24161:SC#1: Verify if using POST service - user can import the Sheet using API - /import/spreadsheets/{catalogname}/content.
    Given Execute REST API with following parameters
      | Header              | Query | Param | type  | url                                                    | body                                   | response code | response message | jsonPath |
      | multipart/form-data |       |       | Post  | /import/spreadsheets/Default/content?name=Import_24161 | excelupload/Sample File_24161.xlsx     | 200           |                  |          |

  ##7156987##
  @MLP-24161 @regression @positive @dashboard
  Scenario Outline: MLP-24161:SC#2: Verify if user can PUT/Modify the imported excel with new sheet Tables using API - /import/spreadsheets
    Given user get the column "Sample File_24161.xlsx" id from the following query
      | description | schemaName | tableName | typeName | columnName | criteriaName | criteriaAttribute       |
      | SELECT      | public     | items     | Import   | id         |              | attributes->>'fileName' |
    When user fetches "<contentType>" and "<acceptType>" request type "<type>" with url "<url>", dynamic id "<endpoint>" and body "<body>" for "TestSystemUser" user
    And Status code 200 must be returned
    And user update the json file "idc/ExcelUploadPayloads/MLP_24161_excelImportForRunID.json" for following values using "response"
      | jsonPath    |
      | $..['id']   |
      | $..['name'] |
    And configure a new REST API for the service "IDC"
    And Execute REST API with following parameters
      | Header           | Query  | Param | type | url                  | body                                                        | response code | response message | jsonPath |
      | application/json |        |       | Put  | /import/spreadsheets | idc/ExcelUploadPayloads/MLP_24161_excelImportForRunID.json  | 200           |                  |          |
    Examples:
      | contentType         | acceptType       | type | url                                         | endpoint | body |
      | multipart/form-data | application/json | Get  | import/spreadsheets/Default.Import%3A%3A%3A |          |      |

  ##7157002##
  @MLP-24161 @regression @positive @dashboard @webtest
  Scenario:MLP-24161:SC#3: Verify in UI - Manage Excel Import screen has the import item 'Import_24161' displayed
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Capture and Import Data & Configure" for "Manage Excel Imports" in "Landing page"
    And User performs following actions in the Excel Importer Page
      | Actiontype                       | ActionItem       | ItemName              | Section |
      | Click Edit,Clone,Run and Delete  | Import_24161     | Run the excel import  |         |
    And user clicks on search icon

  ##7157002##
  @MLP-24161 @regression @positive @dashboard
  Scenario Outline: MLP-24161:SC#4: Verify if user can Get the import Run ID
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a Get request with dynamic ID generated within "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Then Status code 200 must be returned
    Then Json response message should contains the following value
      | responseMessage   |
      | Default.ImportRun |
    Examples:
      | url                                                        | responseCode | inputJson | inputFile                                                           | outPutFile | outPutJson |
      | import/spreadsheets/Default.Import%3A%3A%3Adynamic/loglist | 200          | $.id      | payloads/idc/ExcelUploadPayloads/MLP_24161_excelImportForRunID.json |            |            |

