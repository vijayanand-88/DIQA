@MLP-27018
Feature: MLP_27018 and MLP_27019 and MLP_27206 Audit Event Storing and Viewing Statistics

  ##7184015##7184016##7184017##7184018##
  @MLP-27018  @regression @positive
  Scenario:SC1#: Verify if user can Get the audit configuration from Swagger & view audit table in postgres
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                                           | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | settings?path=com/asg/dis/platform/audit.json |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage           |
      | LoginFailedEvent          |
      | AccessDeniedEvent         |
      | ItemOperationEvent        |
      | AnalysisResultEvent       |
      | ItemsOperationEvent       |
      | AnalysisTriggerEvent      |
      | PermissionDeniedEvent     |
      | TrustPolicyChangeEvent    |
      | ConfigurationChangeEvent  |
      | LicenseCheckFailureEvent  |
      | MaskingPolicyChangeEvent  |
      | TaggingPolicyChangeEvent  |
    And user validates the list of "eventType" available in the database in postgres
      | description | schemaName | tableName | columnName | criteriaName             |
      | SELECT      | public     | audit     | eventType  | TrustUpdatedEvent        |
      | SELECT      | public     | audit     | eventType  | ConfigurationChangeEvent |
      | SELECT      | public     | audit     | eventType  | AnalysisTriggerEvent     |
      | SELECT      | public     | audit     | eventType  | AnalysisCompletionEvent  |
      | SELECT      | public     | audit     | eventType  | ItemDeletedEvent         |
      | SELECT      | public     | audit     | eventType  | ItemCreatedEvent         |

  #######################################################################################################

  ###MLP-27019: This feature is for verifying Audit Retrieval

  ##7184230##7184269##
  @MLP-27019  @regression @positive
  Scenario:SC1#: Verify if user can Post audit records to fetch the audit records based on Name and Event Type
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url          | body                                                              | response code | response message | jsonPath |
      | application/json |       |       | Post | auditrecords | idc\MLP_27019\Filter Audit records using Name and EventType.json  | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage           |
      | TestSystem                |
      | INFO                      |
      | ConfigurationChangeEvent  |

  ##7196493##
  @MLP-27019 @webtest @regression @positive
  Scenario Outline:SC2#: Verify if user can Post audit records to filter events for user name and event - login failure
    Given User launch browser and traverse to login page
    And User type username as "<username>" and Password as "<password>"
    When Execute REST API with following parameters
      | Header           | Query | Param | type | url          | body                                                                            | response code | response message | jsonPath |
      | application/json |       |       | Post | auditrecords | idc\MLP_27019\Filter Audit records using Name and EventType login failure.json  | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage           |
      | TestSystem                |
      | ERROR                     |
      | LoginFailedEvent          |
      | INCORRECT_PASSWORD        |

    Examples:
      | username   | password |
      | TestSystem | Syst     |

  #######################################################################################################

  ###MLP-27206: This feature is for verifying audit statistics for filtering UI

  ##7186663##7186664##7186665##
  @MLP-27206  @regression @positive
  Scenario:SC1#: Verify if user can Get the audit statistics from Swagger
    Given Execute REST API with following parameters
      | Header           | Query | Param | type | url                     | body | response code | response message | jsonPath |
      | application/json |       |       | Get  | auditrecords/statistics |      | 200           |                  |          |
    Then Json response message should contains the following value
      | responseMessage           |
      | userName                  |
      | TestSystem                |
      | eventType                 |
      | ConfigurationChangeEvent  |
      | LoginFailedEvent          |
      | itemType                  |
      | component                 |
      | INCORRECT_PASSWORD        |
      | levels                    |
      | ERROR                     |
      | INFO                      |

