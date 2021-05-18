@MLP-3579
Feature:MLP-3579: IDA Node Status validation from API
  Description:  Validate the IDA Node Status from API

  @MLP-3579 @positive @regression @sanity
  Scenario: MLP-3579:Verify the status of the IDA Node when the IDA Node is Up and running.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    When user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo"
    Then Status code 200 must be returned
    And response message contains value "UP"
    And The criteria values for the below query in Postgres should be "Cluster Demo" and the expected output is "UP"
      | description | schemaName | tableName  | columnName | criteriaName |
      | SELECT      | public     | V_Ingester | status     | nodeName     |

  @MLP-3579 @positive @regression
  Scenario: MLP-3579:Verify when user tries to set the status other than UP, DOWN, ERROR, UNKNOWN.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "ida/Invalid_Node_Status.txt"
    When user makes a REST Call for PUT request with url "extensions/analyzers/status/Cluster Demo"
    Then Status code 400 must be returned

  @MLP-3579 @positive @regression
  Scenario: MLP-3579:Verify the status of the IDA Node when the call back URL is changed in the IDA Node Configuration.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "ida/Invalid_Callback_URL.json"
    When user makes a REST Call for PUT request with url "extensions/analyzers/callback/Cluster Demo"
    Then Status code 204 must be returned
    When user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo"
    Then Status code 200 must be returned
    And response message contains value "ERROR"
    And The criteria values for the below query in Postgres should be "Cluster Demo" and the expected output is "ERROR"
      | description | schemaName | tableName  | columnName | criteriaName |
      | SELECT      | public     | V_Ingester | status     | nodeName     |

  @MLP-3579 @positive @regression
  Scenario: MLP-3579:Verify the status of the IDA Node when the call back URL is changed to default in the IDA Node Configuration.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And default hostname is modified to exact environment in the file name "ida/Valid_Callback_URL.json"
    And supply payload with file name "ida/Valid_Callback_URL.json"
    When user makes a REST Call for PUT request with url "extensions/analyzers/callback/Cluster Demo"
    Then Status code 204 must be returned
    When user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo"
    Then Status code 200 must be returned
    And response message contains value "UP"
    And The criteria values for the below query in Postgres should be "Cluster Demo" and the expected output is "UP"
      | description | schemaName | tableName  | columnName | criteriaName |
      | SELECT      | public     | V_Ingester | status     | nodeName     |

  @MLP-3579 @positive @regression @sanity
  Scenario: MLP-3579:Verify whether the status of the IDA Node when the status is modified to "DOWN" manually using SET call.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "ida/Valid_Node_Status_DOWN.txt"
    When user makes a REST Call for PUT request with url "extensions/analyzers/status/Cluster Demo"
    Then Status code 204 must be returned
    When user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo"
    Then Status code 200 must be returned
    And response message contains value "DOWN"
    And The criteria values for the below query in Postgres should be "Cluster Demo" and the expected output is "DOWN"
      | description | schemaName | tableName  | columnName | criteriaName |
      | SELECT      | public     | V_Ingester | status     | nodeName     |

  @MLP-3579 @positive @regression @sanity
  Scenario: MLP-3579:Verify whether the status of the IDA Node when the status is modified to "ERROR" manually using SET call.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "ida/Valid_Node_Status_ERROR.txt"
    When user makes a REST Call for PUT request with url "extensions/analyzers/status/Cluster Demo"
    Then Status code 204 must be returned
    When user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo"
    Then Status code 200 must be returned
    And response message contains value "ERROR"
    And The criteria values for the below query in Postgres should be "Cluster Demo" and the expected output is "ERROR"
      | description | schemaName | tableName  | columnName | criteriaName |
      | SELECT      | public     | V_Ingester | status     | nodeName     |

  @MLP-3579 @positive @regression @sanity
  Scenario: MLP-3579:Verify whether the status of the IDA Node when the status is modified to "UNKNOWN" manually using SET call.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "ida/Valid_Node_Status_UNKNOWN.txt"
    When user makes a REST Call for PUT request with url "extensions/analyzers/status/Cluster Demo"
    Then Status code 204 must be returned
    When user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo"
    Then Status code 200 must be returned
    And response message contains value "UNKNOWN"
    And The criteria values for the below query in Postgres should be "Cluster Demo" and the expected output is "UNKNOWN"
      | description | schemaName | tableName  | columnName | criteriaName |
      | SELECT      | public     | V_Ingester | status     | nodeName     |

  @MLP-3579 @positive @regression @sanity
  Scenario: MLP-3579:Verify whether the status of the IDA Node when the status is modified to "UP" manually using SET call.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And supply payload with file name "ida/Valid_Node_Status_UP.txt"
    When user makes a REST Call for PUT request with url "extensions/analyzers/status/Cluster Demo"
    Then Status code 204 must be returned
    When user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo"
    Then Status code 200 must be returned
    And response message contains value "UP"
    And The criteria values for the below query in Postgres should be "Cluster Demo" and the expected output is "UP"
      | description | schemaName | tableName  | columnName | criteriaName |
      | SELECT      | public     | V_Ingester | status     | nodeName     |

  @MLP-3579 @positive @regression
  Scenario: MLP-3579:To make the status of IDA Node as down from Ambari.
    Given configure a new REST API for the service "Ambari"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
      | X-Requested-By | ambari                     |
    And supply payload with file name "ida/IDANODEStopServiceComponent.json"
    When user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE/"
    Then Status code 202 must be returned

  @MLP-3579 @positive @regression
  Scenario: MLP-3579:Verify the status of the IDA Node after brought DOWN from Ambari.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user waits for the final status to be reflected after "30000" milliseconds
    And user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo"
    Then Status code 200 must be returned
    And response message contains value "DOWN"
    And The criteria values for the below query in Postgres should be "Cluster Demo" and the expected output is "DOWN"
      | description | schemaName | tableName  | columnName | criteriaName |
      | SELECT      | public     | V_Ingester | status     | nodeName     |

  @MLP-3579 @positive @regression
  Scenario: MLP-3579:To make the status of IDA Node as UP from Ambari.
    Given configure a new REST API for the service "Ambari"
    And To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Authorization  | Basic cmFqX29wczpyYWpfb3Bz |
      | X-Requested-By | ambari                     |
    And supply payload with file name "ida/IDANODEStartServiceComponent.json"
    And user makes a REST Call for PUT request with url "clusters/Sandbox/services/IDANODE/"
    And Status code 202 must be returned

  @MLP-3579 @positive @regression
  Scenario: MLP-3579:Verify the status of the IDA Node after brought UP from Ambari.
    Given To configure multiple headers and Authorization dynamically for Rest Endpoint
      | Content-Type  | application/json                   |
      | Accept        | application/json                   |
      | Authorization | Basic VGVzdFNlcnZpY2U6U2VydmljZQ== |
    And user waits for the final status to be reflected after "30000" milliseconds
    And user makes a REST Call for Get request with url "extensions/analyzers/status/Cluster Demo"
    Then Status code 200 must be returned
    And response message contains value "UP"
    And The criteria values for the below query in Postgres should be "Cluster Demo" and the expected output is "UP"
      | description | schemaName | tableName  | columnName | criteriaName |
      | SELECT      | public     | V_Ingester | status     | nodeName     |