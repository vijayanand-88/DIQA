@MLP-4691
Feature: MLP-4691: Tableau workbook creation using Datasets

  Description:
  Tableau workbook creation using Datasets

  @MLP-4691 @regression @tableau
  Scenario:MLP-4691 Verification of  post /datasets/{id}/actions with column type
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And supply payload with file name "idc/MLP-4691_TableauDataSetsCreation.json"
    When user makes a REST Call for POST request with url "datasets"
    And Status code 200 must be returned
    And verify DataSet is created with name "TableauDataSets", Description "Column items" and status as "PUBLIC" and has data items
      | dataElements         |
      | BigData.Column:::15  |
      | BigData.Table:::1    |
      | BigData.Database:::1 |
      | BigData.Service:::1  |
      | BigData.File:::1     |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And user add "BigData.Column:::15" JsonArray value in payload "idc/MLP-4691_TableauAction.json" to "0" index
    And supply payload with file name "idc/MLP-4691_TableauAction.json"
    When user makes a REST Call for "POST" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path "/actions"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues                              | jsonPath                 |
      | CREATE_WORKBOOK,Pandas                  | $..['actionId']          |
      | TableauConnector,NotebookConnector      | $..['pluginName']        |
      | BigData.Column:::15,BigData.Column:::15 | $..['elementIDs']        |
      | TableauConnector,IDC Local Jupyter      | $..['configurationName'] |

  @MLP-4691 @regression @tableau
  Scenario:MLP-4691 Verification of Post /datasets/{id}/actions for Table and CASK
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And user add "BigData.Table:::1" JsonArray value in payload "idc/MLP-4691_TableauAction.json" to "0" index
    And supply payload with file name "idc/MLP-4691_TableauAction.json"
    When user makes a REST Call for "POST" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path "/actions"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues                                            | jsonPath          |
      | BigData.Table:::1,BigData.Table:::1,BigData.Table:::1 | $..['elementIDs'] |
    And response message contains value ""actionId" : "import""
    And response message contains value ""actionId" : "CREATE_WORKBOOK""
    And response message contains value ""pluginName" : "TableauConnector""
    And response message contains value ""pluginName" : "CdapConnector""
    And response message contains value ""configurationName" : "TableauConnector""
    And response message contains value ""configurationName" : "testCDAP""


  @MLP-4691 @regression @tableau
  Scenario:MLP-4691 Verification of Post /datasets/{id}/actions for Database
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And user add "BigData.Database:::1" JsonArray value in payload "idc/MLP-4691_TableauAction.json" to "0" index
    And supply payload with file name "idc/MLP-4691_TableauAction.json"
    When user makes a REST Call for "POST" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path "/actions"
    And Status code 200 must be returned
    Then empty response body should be displayed


  @MLP-4691 @sanity @regression @tableau
  Scenario:MLP-4691 Verification of post/datasets/{id}/action for incorrect dataset id
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And supply payload with file name "idc/MLP-4691_TableauAction.json"
    When user makes a REST Call for POST request with url "datasets/DataSets.DataSet%3A%3A%3A12345"
    And Status code 404 must be returned
    Then response body should have "DataSet with id DataSets.DataSet:::12345 not found" message

  @MLP-4691 @regression @tableau
  Scenario: MLP-4691 Verification of Post/datasets/{id}/actions for Service type items
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And user add "BigData.Service:::1" JsonArray value in payload "idc/MLP-4691_TableauAction.json" to "0" index
    And supply payload with file name "idc/MLP-4691_TableauAction.json"
    When user makes a REST Call for "POST" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path "/actions"
    And Status code 200 must be returned
    Then empty response body should be displayed


  @MLP-4691 @regression @tableau @webtest
  Scenario: MLP-4691 Verification of POST /datasets/{id}/actions/run for Column type
    Given User launch browser and traverse to login page
    When user enter credentials for "System Administrator1" role
    And User clicks on "About" submenu
    And user gets the version
    And configure a new REST API for the service "IDC"
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user update the json file "idc/MLP-4691_TableauRun.json" for following values using "commonUtil"
      | jsonPath             |
      | $..['pluginVersion'] |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And supply payload with file name "idc/MLP-4691_TableauRun.json"
    When user makes a REST Call for "POST" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path "/actions/run"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | GENERATED  | $..['status'] |
    And response message contains the following values
      | responseMessage                      |
      | select lastname from media.customers |
      | server='sandbox.hortonworks.com'     |


  @MLP-4691 @regression @tableau
  Scenario:MLP-4691 Verification of POST /datasets/{id}/actions/run for Table type
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user update the json file "idc/MLP-4691_TableauRun_Table.json" for following values using "commonUtil"
      | jsonPath             |
      | $..['pluginVersion'] |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And supply payload with file name "idc/MLP-4691_TableauRun_Table.json"
    When user makes a REST Call for "POST" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path "/actions/run"
    And Status code 200 must be returned
    Then user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | GENERATED  | $..['status'] |
    And response message contains the following values
      | responseMessage                                            |
      | select * from exportcustomeraddressdataset.customeraddress |
      | server='sandbox.hortonworks.com'                           |


  @MLP-4691 @regression @tableau
  Scenario: MLP-4691 Verification of POST /datasets/{id}/actions/run for Database type
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user update the json file "idc/MLP-4691_TableauRun_Database.json" for following values using "commonUtil"
      | jsonPath             |
      | $..['pluginVersion'] |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And supply payload with file name "idc/MLP-4691_TableauRun_Database.json"
    When user makes a REST Call for "POST" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path "/actions/run"
    And Status code 200 must be returned
    And response message contains the following values
      | responseMessage                                                                                           |
      | TABLEAU-CONNECTOR-0001: DataSet element:BigData.Database:::1 is not of type column or table hence ignored |


  @MLP-4691 @sanity @regression @tableau
  Scenario: MLP-4691 Verification of POST/datasets/{id}/actions/run for incorrect action id
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user update the json file "idc/MLP-4691_TableauActionIdIncorrectRun.json" for following values using "commonUtil"
      | jsonPath             |
      | $..['pluginVersion'] |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And supply payload with file name "idc/MLP-4691_TableauActionIdIncorrectRun.json"
    When user makes a REST Call for "POST" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path "/actions/run"
    And Status code 200 must be returned
    Then response body should have "Workbook generation failed" message
    Then user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | FAILED     | $..['status'] |

  @MLP-4691 @regression @tableau
  Scenario:MLP-4691 Verification of Post /datasets/{id}/action/run for other items type
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user update the json file "idc/MLP-4691_TableauServiceAndFileRun.json" for following values using "commonUtil"
      | jsonPath             |
      | $..['pluginVersion'] |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And supply payload with file name "idc/MLP-4691_TableauServiceAndFileRun.json"
    When user makes a REST Call for "POST" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path "/actions/run"
    And Status code 200 must be returned
    And response message contains the following values
      | responseMessage                                                                                          |
      | TABLEAU-CONNECTOR-0001: DataSet element:BigData.File:::1 is not of type column or table hence ignored    |
      | TABLEAU-CONNECTOR-0001: DataSet element:BigData.Service:::1 is not of type column or table hence ignored |

  @MLP-4691 @regression @tableau
  Scenario: MLP-4691 Verification of Post/ datasets/{id}/action/run with different table and column type combined
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user update the json file "idc/MLP-4691_TableauCombinedRun.json" for following values using "commonUtil"
      | jsonPath             |
      | $..['pluginVersion'] |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    And supply payload with file name "idc/MLP-4691_TableauCombinedRun.json"
    When user makes a REST Call for "POST" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path "/actions/run"
    And Status code 200 must be returned
    And user compares the following value from response using json path
      | jsonValues | jsonPath      |
      | GENERATED  | $..['status'] |
    And response message contains the following values
      | responseMessage                                            |
      | select * from exportcustomeraddressdataset.customeraddress |
      | select lastname from media.customers                       |
      | server='sandbox.hortonworks.com                            |
#
  @MLP-4691 @regression @tableau
  Scenario: MLP-4691 Deleting the created datasets
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint with false encoding
      | Authorization | Basic VGVzdFN5c3RlbTpTeXN0ZW0= |
      | Content-Type  | application/json               |
      | Accept        | application/json               |
    And user makes REST call for Get "datasets" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "DELETE" request with url "datasets/DataSets.DataSet%3A%3A%3AstoredID" and path ""
    Then Status code 200 must be returned


