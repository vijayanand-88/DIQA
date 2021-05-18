@MLP-5471
Feature: MLP-5471: This feature is for verifying workflow tagapproval history

  Description:
  To verify the security services GET /user and GET /tenant return a simple string

  @positive @webtest
  Scenario:MLP-5471: Verification of getting history of workflow instances after suggesting a tag
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Consumer" role
    When user selects "BigData" catalog from catalog list
    And user selects the "Table" from the Type
    And user clicks on first item on the item list page
    And user "click" on "add tag button" in Item view page
    And user click on create new tag in the Add tags panel
    And user enters the new tag name as "Tag!"
    And user clicks on save button in the edit properties page
    And user clicks on save button
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/workflows/definitions/tagapproval/instances"
    Then Status code 200 must be returned
    And response message contains value "id"
    And response message contains value "definitionKey"

  @positive @webtest
  Scenario:MLP-5471: Verification of getting instances for multiple dataset
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Consumer" role
    When user selects "BigData" catalog from catalog list
    And user enters the search text "customerID" and clicks on search
    And user selects the "Column" from the Type
    And user enables the following item checkboxes
      | itemName   |
      | customerID |
    And user creates a dataset with name "Sales Fact Test Data Sets 1" and description "Sales Fact Test Data Sets description"
    And user clicks on home button
    And user clicks on DataSet dashboard
    And user clicks on "SALES FACT TEST DATA SETS 1" data set
    And user navigate to data tab
    And user clicks on "customerID" data item checkbox from the list
    And user clicks on Order List
    And user clicks on submit order button
    And user enters the search text "customerID" and clicks on search
    And user selects the "Column" from the Type
    And user enables the following item checkboxes
      | itemName   |
      | customerID |
    And user creates a dataset with name "Sales Fact Test Data Sets 2" and description "Sales Fact Test Data Sets description"
    And user clicks on home button
    And user clicks on DataSet dashboard
    And user clicks on "SALES FACT TEST DATA SETS 2" data set
    And user navigate to data tab
    And user clicks on "customerID" data item checkbox from the list
    And user clicks on Order List
    And user clicks on submit order button
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/workflows/definitions/dataset_access_request_voting/instances"
    Then Status code 200 must be returned
    And response message contains value "id"
    And response message contains value "definitionKey"

  @positive
  Scenario:MLP-5471: Verification of getting history of particular instance
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "/workflows/definitions/tagapproval/instances" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path "/history"
    Then Status code 200 must be returned
    And response message contains value "Send Task"
    And response message contains value "StartEvent"
    And response message contains value "Receive Task"

  @positive
  Scenario:MLP-5471: Verification of activity instance for the instance id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "/workflows/definitions/tagapproval/instances" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path "/variables"
    Then Status code 200 must be returned
    And response returns with the following items
      | description                    | searchItems        | expectedResults    |
      | Status Code                    |                    | 200                |
      | ResponseBody_ReturnSingleValue | id                 | id                 |
      | ResponseBody_ReturnSingleValue | typename           | typename           |
      | ResponseBody_ReturnSingleValue | activityInstanceID | activityInstanceID |
      | ResponseBody_ReturnSingleValue | executionId        | executionId        |
      | ResponseBody_ReturnSingleValue | processInstanceId  | processInstanceId  |
      | ResponseBody_ReturnSingleValue | value              | value              |
      | ResponseBody_ReturnSingleValue | valueType          | valueType          |
    Then user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues  |
      | catalogName |
      | tagName     |
      | userName    |
      | tagId       |
      | WorkflowRef |

  @positive
  Scenario:MLP-5471:Verification of getting history of all activity instances
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "/workflows/definitions/tagapproval/instances" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path "/history/variables"
    Then Status code 200 must be returned
    And response returns with the following items
      | description                    | searchItems          | expectedResults      |
      | Status Code                    |                      | 200                  |
      | ResponseBody_ReturnSingleValue | id                   | id                   |
      | ResponseBody_ReturnSingleValue | typename             | typename             |
      | ResponseBody_ReturnSingleValue | activityInstanceID   | activityInstanceID   |
      | ResponseBody_ReturnSingleValue | executionId          | executionId          |
      | ResponseBody_ReturnSingleValue | processInstanceId    | processInstanceId    |
      | ResponseBody_ReturnSingleValue | processDefinitionId  | processDefinitionId  |
      | ResponseBody_ReturnSingleValue | processDefinitionKey | processDefinitionKey |
      | ResponseBody_ReturnSingleValue | state                | state                |
      | ResponseBody_ReturnSingleValue | valueType            | valueType            |
      | ResponseBody_ReturnSingleValue | valueType            | valueType            |
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues  |
      | catalogName |
      | tagName     |
      | userName    |
      | tagId       |
      | WorkflowRef |
      | event       |

  @positive
  Scenario:MLP-5471: Verification of getting all history of workflow  instances
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for Get request with url "/workflows/definitions/tagapproval/history"
    Then Status code 200 must be returned
    And response message contains value "id"

  @positive @webtest
  Scenario:MLP-5471:Verification of getting workflow instances after creating a dataset access request
    Given User launch browser and traverse to login page
    And user enter credentials for "Data Consumer" role
    When user selects "BigData" catalog from catalog list
    And user enters the search text "customerid" and clicks on search
    And user selects the "Column" from the Type
    And user enables the following item checkboxes
      | itemName   |
      | customerid |
    And user creates a dataset with name "Sales Fact Test Data Sets 3" and description "Sales Fact Test Data Sets description"
    And user clicks on home button
    And user clicks On DataSet Dashboard And navigates to The "SALES FACT TEST DATA SETS 3" Dataset "Data" Tab
    And user clicks on "customerid" data item checkbox from the list
    And user clicks on Order List
    And user clicks on submit order button
    And A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a REST Call for Get request with url "/workflows/definitions/dataset_access_request_voting/instances"
    Then Status code 200 must be returned
    And response message contains value "id"
    And response message contains value "definitionKey"

  @positive
  Scenario:MLP-5471: Verification of activity instance  graph for the instance id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "/workflows/definitions/tagapproval/instances" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path ""
    Then Status code 200 must be returned
    And response message contains value "Receive Task"
    And response message contains value "tagapproval"

  @positive
  Scenario:MLP-5471: Verification of getting history of particular instance for dataset
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "/workflows/definitions/dataset_access_request_voting/instances" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path "/history"
    Then Status code 200 must be returned
    And user verifies whether the value is present in response using json path "$..['activityName']"
      | jsonValues                    |
      | Start                         |
      | Start voting on Order         |
      | Mark Order Detail in Progress |


  @positive
  Scenario:MLP-5471: Verification of getting history of all activity instances for dataset
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "/workflows/definitions/dataset_access_request_voting/instances" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path "/history/variables"
    And response returns with the following items
      | description                    | searchItems        | expectedResults    |
      | Status Code                    |                    | 200                |
      | ResponseBody_ReturnSingleValue | id                 | id                 |
      | ResponseBody_ReturnSingleValue | typename           | typename           |
      | ResponseBody_ReturnSingleValue | activityInstanceID | activityInstanceID |
      | ResponseBody_ReturnSingleValue | executionId        | executionId        |
      | ResponseBody_ReturnSingleValue | processInstanceId  | processInstanceId  |
      | ResponseBody_ReturnSingleValue | value              | value              |
      | ResponseBody_ReturnSingleValue | valueType          | valueType          |
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues  |
      | catalogName |
      | requestedBy |
      | dataSetId   |
      | orderId     |
      | WorkflowRef |
      | dataSetName |
      | detailId    |
      | userName    |


  @postive @webtest
  Scenario:MLP-5471: Verification of getting history of particular instance after approving a tag
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "/workflows/definitions/tagapproval/instances" and retrieves value from using jsonpath "$.[-1:].id"
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user clicks on notification icon in the left panel
#    And user clicks on Requests tab
    And user opens the notification cotaining "Tag TAG! suggested"
    And user "APROVE" the suggested tag
    When user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path "/history"
    Then Status code 200 must be returned
    And response message contains value "activityName"


  @postive
  Scenario:MLP-5471: Verification of getting history of all activity instances after approving a tag
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "/workflows/definitions/tagapproval/instances" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path "/history/variables"
    Then Status code 200 must be returned
    And response returns with the following items
      | description                    | searchItems        | expectedResults    |
      | Status Code                    |                    | 200                |
      | ResponseBody_ReturnSingleValue | id                 | id                 |
      | ResponseBody_ReturnSingleValue | typename           | typename           |
      | ResponseBody_ReturnSingleValue | activityInstanceID | activityInstanceID |
      | ResponseBody_ReturnSingleValue | executionId        | executionId        |
      | ResponseBody_ReturnSingleValue | processInstanceId  | processInstanceId  |
      | ResponseBody_ReturnSingleValue | value              | value              |
      | ResponseBody_ReturnSingleValue | valueType          | valueType          |
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues  |
      | catalogName |
      | tagName     |
      | userName    |
      | tagId       |
      | WorkflowRef |
      | event       |


  @postive @webtest
  Scenario:MLP-5471: Verification of getting history of particular instance after approving a dataset access request
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes REST call for Get "/workflows/definitions/dataset_access_request_voting/instances" and retrieves value from using jsonpath "$.[-1:].id"
    Then User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    And user clicks on notification icon in the left panel
#    And user clicks on Requests tab
    And user opens the notification cotaining "Request for Access"
    And user "APPROVE" the suggested tag
    When user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path "/history"
    Then Status code 200 must be returned
    And response message contains value "Start"

  @postive
  Scenario:MLP-5471: Verification of getting history of all activity instances after approving a dataset access request
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "/workflows/definitions/dataset_access_request_voting/instances" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path "/history/variables"
    And response returns with the following items
      | description                    | searchItems        | expectedResults    |
      | Status Code                    |                    | 200                |
      | ResponseBody_ReturnSingleValue | id                 | id                 |
      | ResponseBody_ReturnSingleValue | typename           | typename           |
      | ResponseBody_ReturnSingleValue | activityInstanceID | activityInstanceID |
      | ResponseBody_ReturnSingleValue | executionId        | executionId        |
      | ResponseBody_ReturnSingleValue | processInstanceId  | processInstanceId  |
      | ResponseBody_ReturnSingleValue | value              | value              |
      | ResponseBody_ReturnSingleValue | valueType          | valueType          |
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues  |
      | catalogName |
      | requestedBy |
      | dataSetId   |
      | userName    |
      | WorkflowRef |
      | event       |
      | orderId     |

  @postive @webtest
  Scenario:MLP-5471: Verification of getting history of all activity instances after rejecting  a dataset access request
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "/workflows/definitions/dataset_access_request_voting/instances" and retrieves value from using jsonpath "$.[-1:].id"
    And User launch browser and traverse to login page
    And user enter credentials for "Data Administrator" role
    And user clicks on notification icon in the left panel
#    And user clicks on Requests tab
    And user opens the notification cotaining "Request for Access"
    And user "REJECT" the suggested tag
    When user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path "/history/variables"
    Then Status code 200 must be returned
    And response returns with the following items
      | description                    | searchItems        | expectedResults    |
      | Status Code                    |                    | 200                |
      | ResponseBody_ReturnSingleValue | id                 | id                 |
      | ResponseBody_ReturnSingleValue | typename           | typename           |
      | ResponseBody_ReturnSingleValue | activityInstanceID | activityInstanceID |
      | ResponseBody_ReturnSingleValue | executionId        | executionId        |
      | ResponseBody_ReturnSingleValue | processInstanceId  | processInstanceId  |
      | ResponseBody_ReturnSingleValue | value              | value              |
      | ResponseBody_ReturnSingleValue | valueType          | valueType          |
    And user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues  |
      | catalogName |
      | requestedBy |
      | dataSetId   |
      | userName    |
      | WorkflowRef |
      | event       |
      | orderId     |

  @postive
  Scenario:MLP-5471: Verification of activity instance for the instance id for dataset
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "/workflows/definitions/dataset_access_request_voting/instances" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path "/variables"
    Then Status code 200 must be returned
    And response returns with the following items
      | description                    | searchItems        | expectedResults    |
      | Status Code                    |                    | 200                |
      | ResponseBody_ReturnSingleValue | id                 | id                 |
      | ResponseBody_ReturnSingleValue | typename           | typename           |
      | ResponseBody_ReturnSingleValue | activityInstanceID | activityInstanceID |
      | ResponseBody_ReturnSingleValue | executionId        | executionId        |
      | ResponseBody_ReturnSingleValue | processInstanceId  | processInstanceId  |
      | ResponseBody_ReturnSingleValue | value              | value              |
      | ResponseBody_ReturnSingleValue | valueType          | valueType          |
    Then user verifies whether the value is present in response using json path "$..['name']"
      | jsonValues  |
      | catalogName |
      | requestedBy |
      | userName    |
      | dataSetId   |
      | WorkflowRef |
      | dataSetName |

  @postive
  Scenario:MLP-5471: Verification of activity instance  graph for the instance id for dataset
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes REST call for Get "/workflows/definitions/dataset_access_request_voting/instances" and retrieves value from using jsonpath "$.[-1:].id"
    When user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path ""
    Then Status code 200 must be returned
    And  response message contains value "dataset_access_request_voting"

  @postive
  Scenario:MLP-5471: Verification of getting history/Variables of particular instance with invalid id
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    When user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path "/history"
    Then Status code 200 must be returned
    And user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path "/variables"
    And Status code 200 must be returned
    And user makes a REST Call for "GET" request with ID url "/workflows/instances/" and path "/history/variables"
    And Status code 200 must be returned
    And user makes a REST Call for Get request with url "/workflows/definitions/inavlidkey/instances"
    And Status code 200 must be returned




















