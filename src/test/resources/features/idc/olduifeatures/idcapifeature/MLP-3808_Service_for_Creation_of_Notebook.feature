@MLP-3808
Feature: MLP-3808: Verfication of creation of notebook and export

  @MLP-3808 @sanity @regression @datasets
  Scenario: MLP-3808 Verification of exporting a notebook for incorrect Notebook id
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/octet-stream           |
      | Accept        | application/octet-stream           |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "datasets/DataSets.Notebook%3A%3A%3A2245/Analysis.html/content?deletetempfiles=true"
    And Status code 404 must be returned
    Then response body should have "DataSet with id DataSets.Notebook:::2245 not found" message

  @MLP-3808 @sanity @regression @datasets
  Scenario: MLP-3808 Verification of exporting a notebook for incorrect file format
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Content-Type  | application/octet-stream           |
      | Accept        | application/octet-stream           |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user makes a REST Call for Get request with url "datasets/DataSets.Notebook%3A%3A%3A1/Analysis.md/content?deletetempfiles=true"
    Then Status code 404 must be returned

#  @MLP-3808 @sanity @regression @datasets
#  Scenario Outline: Run Collector Plugin to validate the new plugin status
#    Given endpoint having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>"
#    Examples:
#      | Header           | Query | Param | type         | url                                                                    | body                               | response code | response message |
#      | application/json | raw   | false | Put          | settings/analyzers/LocalNode                                           | idc/MLP_3808_NotebookAnalyzer.json | 204           |                  |
#      | application/json |       |       | Get          | settings/analyzers/LocalNode                                           |                                    | 200           | NotebookAnalyzer |
#      | application/json |       |       | Get          | settings/analyzers/LocalNode                                           |                                    | 200           | NB               |
#      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/NotebookAnalyzer/NB |                                    | 200           | IDLE             |
#      | application/json |       |       | Post         | extensions/analyzers/start/LocalNode/dataanalyzer/NotebookAnalyzer/NB  |                                    | 200           | IDLE             |
#      | application/json |       |       | RecursiveGet | extensions/analyzers/status/LocalNode/dataanalyzer/NotebookAnalyzer/NB |                                    | 200           | IDLE             |


#  @MLP-3808 @sanity @regression @datasets
#  Scenario: MLP-3808 Verification of Export Notebook as a html
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And supply payload with file name "idc/MLP-3808_NewDataSets.json"
#    When user makes a REST Call for POST request with url "datasets"
#    Then Status code 200 must be returned
#    And user get the column "NewDataSet" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    And supply payload with file name "idc/MLP-3808_NewNotebook.json"
#    And user makes a REST Call for POST request with url "datasets/" for the stored dataset id
#    And Status code 200 must be returned
#    And supply payload with file name "idc/MLP_3808_NotebookAnalyzer.json"
#    And user makes a REST Call for PUT request with url "settings/analyzers/LocalNode"
#    And Status code 204 must be returned
#    And user update dataset id in "idc/MLP-3808_Create.json" file with json path "$.notebookID"
#    And user update the json file "idc/MLP-3808_Create.json" file for following values
#      | jsonPath   | jsonValues  |
#      | $.exportTo | Analysis.md |
#    And supply payload with file name "idc/MLP-3808_Create.json"
#    And user makes a REST Call for POST request with url "extensions/analyzers/start/LocalNode/dataanalyzer/NotebookAnalyzer/NB"
#    And Status code 200 must be returned
#    And configure a new REST API for the service "IDC"
#    And sync the test execution for "25" seconds
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/octet-stream           |
#      | Accept        | application/octet-stream           |
#    And user makes a REST Call for Get request with url "datasets/DataSets.Notebook%3A%3A%3A" and file Name "/Analysis.md/content"
#    And Status code 200 must be returned
#    And sync the test execution for "20" seconds
#    Then user should able to download the file in "DOWNLOAD_FILE_PATH" and save it as "Analysis.md"
#
#
#
#
#  @MLP-3808 @sanity @regression @datasets
#  Scenario: MLP-3808 Verification of Export Notebook as a md
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user get the column "NewDataSet" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    And user makes a REST Call to DELETE dataset "datasets/DataSets.DataSet:::"
#    And Status code 200 must be returned
#    And supply payload with file name "idc/MLP-3808_NewDataSets.json"
#    When user makes a REST Call for POST request with url "datasets"
#    And Status code 200 must be returned
#    And user get the column "NewDataSet" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    And supply payload with file name "idc/MLP-3808_NewNotebook.json"
#    And user makes a REST Call for POST request with url "datasets/" for the stored dataset id
#    And Status code 200 must be returned
#    And supply payload with file name "idc/MLP_3808_NotebookAnalyzer.json"
#    And user makes a REST Call for PUT request with url "settings/analyzers/LocalNode"
#    And Status code 204 must be returned
#    And user update dataset id in "idc/MLP-3808_Create.json" file with json path "$.notebookID"
#    And user update the json file "idc/MLP-3808_Create.json" file for following values
#      | jsonPath   | jsonValues  |
#      | $.exportTo | Analysis.md |
#    And supply payload with file name "idc/MLP-3808_Create.json"
#    And user makes a REST Call for POST request with url "extensions/analyzers/start/LocalNode/dataanalyzer/NotebookAnalyzer/NB"
#    And Status code 200 must be returned
#    And configure a new REST API for the service "IDC"
#    And sync the test execution for "25" seconds
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/octet-stream           |
#      | Accept        | application/octet-stream           |
#    And user makes a REST Call for Get request with url "datasets/DataSets.Notebook%3A%3A%3A" and file Name "/Analysis.md/content?deletetempfiles=true"
#    And Status code 200 must be returned
#    And sync the test execution for "15" seconds
#    Then user should able to download the file in "DOWNLOAD_FILE_PATH" and save it as "Analysis.md"
#
#
#
#  @MLP-3808 @sanity @regression @datasets
#  Scenario: MLP-3808 Verification of Export Notebook as a py
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    And user get the column "NewDataSet" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    And user makes a REST Call to DELETE dataset "datasets/DataSets.DataSet:::"
#    And Status code 200 must be returned
#    And supply payload with file name "idc/MLP-3808_NewDataSets.json"
#    When user makes a REST Call for POST request with url "datasets"
#    Then Status code 200 must be returned
#    And user get the column "NewDataSet" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    And supply payload with file name "idc/MLP-3808_NewNotebook.json"
#    And user makes a REST Call for POST request with url "datasets/" for the stored dataset id
#    And Status code 200 must be returned
#    And supply payload with file name "idc/MLP_3808_NotebookAnalyzer.json"
#    And user makes a REST Call for PUT request with url "settings/analyzers/LocalNode"
#    And Status code 204 must be returned
#    And user update dataset id in "idc/MLP-3808_Create.json" file with json path "$.notebookID"
#    And user update the json file "idc/MLP-3808_Create.json" file for following values
#      | jsonPath   | jsonValues  |
#      | $.exportTo | Analysis.py |
#    And supply payload with file name "idc/MLP-3808_Create.json"
#    And user makes a REST Call for POST request with url "extensions/analyzers/start/LocalNode/dataanalyzer/NotebookAnalyzer/NB"
#    And Status code 200 must be returned
#    And configure a new REST API for the service "IDC"
#    And sync the test execution for "25" seconds
#    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
#      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
#      | Content-Type  | application/octet-stream           |
#      | Accept        | application/octet-stream           |
#    And user makes a REST Call for Get request with url "datasets/DataSets.Notebook%3A%3A%3A" and file Name "/Analysis.py/content?deletetempfiles=true"
#    And Status code 200 must be returned
#    And sync the test execution for "15" seconds
#    Then user should able to download the file in "DOWNLOAD_FILE_PATH" and save it as "Analysis.py"
#

#  @MLP-3808 @sanity @regression @datasets
#  Scenario: MLP-3808 Verification of deleting dataset
#    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
#    When user get the column "NewDataSet" id from the following query
#      | description | schemaName | tableName | columnName | criteriaName |
#      | SELECT      | DataSets   | V_DataSet | ID         | name         |
#    Then user makes a REST Call to DELETE dataset "datasets/DataSets.DataSet:::"
#    And Status code 200 must be returned