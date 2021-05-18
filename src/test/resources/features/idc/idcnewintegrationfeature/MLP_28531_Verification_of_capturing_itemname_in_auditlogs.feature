@MLP-28531:
Feature: MLP-28531: Verification of capturing item name in audit logs


  @MLP-28531 @regression @positive @dashboard
  Scenario Outline: SC#1:MLP-28531:Create a business application
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                                   | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP_28531\BusinessApplication.json | 200           |                  |          |

  Scenario Outline: SC#1:MLP-28531:Get ID of business application
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type                | name         | asg_scopeid | targetFile                          | jsonpath  |
      | APPDBPOSTGRES | ID      | Default | BusinessApplication | TestAudit_BA |             | payloads\idc\MLP_28531\itemIds.json | $.classID |


  Scenario Outline:SC#1:MLP-28531:Get attributes of business application
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                                 | responseCode | inputJson | inputFile                           | outPutFile                           | outPutJson |
      | items/Default/Default.BusinessApplication:::dynamic | 200          | $.classID | payloads\idc\MLP_28531\itemIds.json | payloads\idc\MLP_28531\Expected.json |            |


  Scenario Outline:SC#1:MLP-28531:Update attributes of business application
    Given user update the json file "idc/MLP_28531/Expected.json" file for following values
      | jsonPath          | jsonValues |
      | $..asg_modifiedby | TestSystem |
    And user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type | url                                                 | body                        | responseCode | inputJson | inputFile                           | responseMessage |
      | application/json | application/json | Put  | items/Default/Default.BusinessApplication:::dynamic | idc/MLP_28531/Expected.json | 204          | $.classID | payloads/idc/MLP_28531/itemIds.json |                 |


  Scenario Outline:SC#1:MLP-28531:Verification of name in component column in API
    Given user update the json file "idc/MLP_28531/AuditRecords.json" file for following values
      | jsonPath     | jsonValues       |
      | $..eventType | ItemUpdatedEvent |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    And user verifies whether the value is present in response using json path "$..['component']"
      | jsonValues   |
      | TestAudit_BA |
    And user verifies whether the value is present in response using json path "$..['eventType']"
      | jsonValues       |
      | ItemUpdatedEvent |
    And user verifies whether the value is present in response using json path "$..['itemType']"
      | jsonValues          |
      | BusinessApplication |
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url          | body                                     | response code | response message | filePath                             | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | auditrecords | payloads/idc/MLP_28531/AuditRecords.json | 200           |                  | payloads/idc/MLP_28531/Expected.json |          |


  Scenario Outline:SC1:Store the item ID to a file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive      | catalog | type                | name         | asg_scopeid | targetFile                         | jsonpath  |
      | APPDBPOSTGRES | ItemIDFormat | Default | BusinessApplication | TestAudit_BA |             | payloads\idc\MLP_28531\Sample.json | $..itemID |


  @MLP-28531 @positive
  Scenario Outline:SC1:Compare itemID value from Audit records API and DB
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                       | actualValues                       | valueType     | expectedJsonPath | actualJsonPath |
      | payloads\idc\MLP_28531\Expected.json | payloads\idc\MLP_28531\Sample.json | stringCompare | $..itemID        | $..itemID      |

    #7243305#
  @webtest @MLP-28531
  Scenario: SC#1:28531: Verification of ItemUpdatedEvent component value for business application
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "View Audit Log" in "Landing page"
    And users performs following actions in Audit Log page
      | Actiontype               | ActionItem       | ItemName            | Section   |
      | Enter Text in Search box |                  | TestAudit_BA        |           |
      | Verifies Section Values  | ItemUpdatedEvent | BusinessApplication | ItemType  |
      | Verifies Section Values  | ItemUpdatedEvent | TestAudit_BA        | Component |

######################################################################################################

  ###MLP-28531: SC2#Verification of component value for ItemCreatedEvent

#7243304#
  @webtest @MLP-28531
  Scenario: SC#2:28531: Verification of component value for ItemCreatedEvent
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "View Audit Log" in "Landing page"
    And users performs following actions in Audit Log page
      | Actiontype               | ActionItem       | ItemName            | Section   |
      | Enter Text in Search box |                  | TestAudit_BA        |           |
      | Verifies Section Values  | ItemCreatedEvent | BusinessApplication | ItemType  |
      | Verifies Section Values  | ItemCreatedEvent | TestAudit_BA        | Component |


  Scenario Outline:SC#2:MLP-28531:Verification of ItemCreatedEvent component value for business application
    Given user update the json file "idc/MLP_28531/AuditRecords.json" file for following values
      | jsonPath     | jsonValues       |
      | $..eventType | ItemCreatedEvent |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    And user verifies whether the value is present in response using json path "$..['component']"
      | jsonValues   |
      | TestAudit_BA |
    And user verifies whether the value is present in response using json path "$..['eventType']"
      | jsonValues       |
      | ItemCreatedEvent |
    And user verifies whether the value is present in response using json path "$..['itemType']"
      | jsonValues          |
      | BusinessApplication |
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url          | body                                     | response code | response message | filePath                             | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | auditrecords | payloads/idc/MLP_28531/AuditRecords.json | 200           |                  | payloads/idc/MLP_28531/Expected.json |          |


  Scenario Outline:SC2:Store the item ID to a file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive      | catalog | type                | name         | asg_scopeid | targetFile                         | jsonpath  |
      | APPDBPOSTGRES | ItemIDFormat | Default | BusinessApplication | TestAudit_BA |             | payloads\idc\MLP_28531\Sample.json | $..itemID |


  @MLP-28531 @positive
  Scenario Outline:SC2:Compare itemID value from Audit records API and DB
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                       | actualValues                       | valueType     | expectedJsonPath | actualJsonPath |
      | payloads\idc\MLP_28531\Expected.json | payloads\idc\MLP_28531\Sample.json | stringCompare | $..itemID        | $..itemID      |


    ######################################################################################################

  ###MLP-28531: SC3#Verification of component value for ItemDeletedEvent

  Scenario Outline:SC3:Store the item ID to a file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive      | catalog | type                | name         | asg_scopeid | targetFile                         | jsonpath  |
      | APPDBPOSTGRES | ItemIDFormat | Default | BusinessApplication | TestAudit_BA |             | payloads\idc\MLP_28531\Sample.json | $..itemID |

    #7243306#
  @webtest @MLP-28531
  Scenario: SC#3:28531: Verification of ItemDeletedEvent component value for business application
    Given Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name         | type                | query | param |
      | SingleItemDelete | Default | TestAudit_BA | BusinessApplication |       |       |
    And User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "View Audit Log" in "Landing page"
    And users performs following actions in Audit Log page
      | Actiontype               | ActionItem       | ItemName            | Section   |
      | Enter Text in Search box |                  | TestAudit_BA        |           |
      | Verifies Section Values  | ItemDeletedEvent | BusinessApplication | ItemType  |
      | Verifies Section Values  | ItemDeletedEvent | TestAudit_BA        | Component |

  Scenario Outline:SC#3:MLP-28531:Verification of name in component column in API
    Given user update the json file "idc/MLP_28531/AuditRecords.json" file for following values
      | jsonPath     | jsonValues       |
      | $..eventType | ItemDeletedEvent |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    And user verifies whether the value is present in response using json path "$..['component']"
      | jsonValues   |
      | TestAudit_BA |
    And user verifies whether the value is present in response using json path "$..['eventType']"
      | jsonValues       |
      | ItemDeletedEvent |
    And user verifies whether the value is present in response using json path "$..['itemType']"
      | jsonValues          |
      | BusinessApplication |
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url          | body                                     | response code | response message | filePath                             | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | auditrecords | payloads/idc/MLP_28531/AuditRecords.json | 200           |                  | payloads/idc/MLP_28531/Expected.json |          |

  @MLP-28531 @positive
  Scenario Outline:SC3:Compare itemID value from Audit records API and DB
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                       | actualValues                       | valueType     | expectedJsonPath | actualJsonPath |
      | payloads\idc\MLP_28531\Expected.json | payloads\idc\MLP_28531\Sample.json | stringCompare | $..itemID        | $..itemID      |


      ######################################################################################################

  ###MLP-28531: SC4#Verification of ItemUpdatedEvent component value for column item

  @MLP-28531 @regression @positive @dashboard
  Scenario Outline: SC#4:MLP-28531:Create a column item
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                              | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP_28531\ColumnCreation.json | 200           |                  |          |

  Scenario Outline: SC#4:MLP-28531:Get ID of business application
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type   | name            | asg_scopeid | targetFile                          | jsonpath  |
      | APPDBPOSTGRES | ID      | Default | Column | TestAuditColumn |             | payloads\idc\MLP_28531\itemIds.json | $.classID |


  Scenario Outline:SC#4:MLP-28531:Get attributes of column item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                    | responseCode | inputJson | inputFile                           | outPutFile                           | outPutJson |
      | items/Default/Default.Column:::dynamic | 200          | $.classID | payloads\idc\MLP_28531\itemIds.json | payloads\idc\MLP_28531\Expected.json |            |


  Scenario Outline:SC#4:MLP-28531:Update attributes of column item
    Given user update the json file "idc/MLP_28531/Expected.json" file for following values
      | jsonPath          | jsonValues |
      | $..asg_modifiedby | TestSystem |
    And user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type | url                                    | body                        | responseCode | inputJson | inputFile                           | responseMessage |
      | application/json | application/json | Put  | items/Default/Default.Column:::dynamic | idc/MLP_28531/Expected.json | 204          | $.classID | payloads/idc/MLP_28531/itemIds.json |                 |

 #7243307#
  Scenario Outline:SC#4:MLP-28531:Verification of name in component column in API
    Given user update the json file "idc/MLP_28531/AuditRecordsColumn.json" file for following values
      | jsonPath     | jsonValues       |
      | $..eventType | ItemUpdatedEvent |
      | $..component | TestAuditColumn  |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    And user verifies whether the value is present in response using json path "$..['component']"
      | jsonValues      |
      | TestAuditColumn |
    And user verifies whether the value is present in response using json path "$..['eventType']"
      | jsonValues       |
      | ItemUpdatedEvent |
    And user verifies whether the value is present in response using json path "$..['itemType']"
      | jsonValues |
      | Column     |
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url          | body                                           | response code | response message | filePath                             | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | auditrecords | payloads/idc/MLP_28531/AuditRecordsColumn.json | 200           |                  | payloads/idc/MLP_28531/Expected.json |          |


  Scenario Outline:SC4:Store the item ID to a file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive      | catalog | type   | name            | asg_scopeid | targetFile                         | jsonpath  |
      | APPDBPOSTGRES | ItemIDFormat | Default | Column | TestAuditColumn |             | payloads\idc\MLP_28531\Sample.json | $..itemID |


  @MLP-28531 @positive
  Scenario Outline:SC4:Compare itemID value from Audit records API and DB
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                       | actualValues                       | valueType     | expectedJsonPath | actualJsonPath |
      | payloads\idc\MLP_28531\Expected.json | payloads\idc\MLP_28531\Sample.json | stringCompare | $..itemID        | $..itemID      |

  @webtest @MLP-28531
  Scenario: SC#4:28531:Verification of ItemUpdatedEvent component value for column item
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "View Audit Log" in "Landing page"
    And users performs following actions in Audit Log page
      | Actiontype               | ActionItem       | ItemName        | Section   |
      | Enter Text in Search box |                  | TestAuditColumn |           |
      | Verifies Section Values  | ItemUpdatedEvent | Column          | ItemType  |
      | Verifies Section Values  | ItemUpdatedEvent | TestAuditColumn | Component |

  @webtest @MLP-28531
  Scenario: SC#4:28531:Deleting created item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name            | type   | query | param |
      | SingleItemDelete | Default | TestAuditColumn | Column |       |       |

      ######################################################################################################

  ###MLP-28531: SC5#Verification of ItemUpdatedEvent component value for Table item

  @MLP-28531 @regression @positive @dashboard
  Scenario Outline: SC#5:MLP-28531:Create a Table item
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP_28531\TableCreation.json | 200           |                  |          |

  Scenario Outline: SC#5:MLP-28531:Get ID of Table
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type  | name           | asg_scopeid | targetFile                          | jsonpath  |
      | APPDBPOSTGRES | ID      | Default | Table | TestAuditTable |             | payloads\idc\MLP_28531\itemIds.json | $.classID |


  Scenario Outline:SC#5:MLP-28531:Get attributes of Table item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                   | responseCode | inputJson | inputFile                           | outPutFile                           | outPutJson |
      | items/Default/Default.Table:::dynamic | 200          | $.classID | payloads\idc\MLP_28531\itemIds.json | payloads\idc\MLP_28531\Expected.json |            |


  Scenario Outline:SC#5:MLP-28531:Update attributes of Table item
    Given user update the json file "idc/MLP_28531/Expected.json" file for following values
      | jsonPath          | jsonValues |
      | $..asg_modifiedby | TestSystem |
    And user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type | url                                   | body                        | responseCode | inputJson | inputFile                           | responseMessage |
      | application/json | application/json | Put  | items/Default/Default.Table:::dynamic | idc/MLP_28531/Expected.json | 204          | $.classID | payloads/idc/MLP_28531/itemIds.json |                 |


  Scenario Outline:SC#5:MLP-28531:Verification of name in component column in API
    Given user update the json file "idc/MLP_28531/AuditRecordsColumn.json" file for following values
      | jsonPath     | jsonValues       |
      | $..eventType | ItemUpdatedEvent |
      | $..component | TestAuditTable   |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    And user verifies whether the value is present in response using json path "$..['component']"
      | jsonValues     |
      | TestAuditTable |
    And user verifies whether the value is present in response using json path "$..['eventType']"
      | jsonValues       |
      | ItemUpdatedEvent |
    And user verifies whether the value is present in response using json path "$..['itemType']"
      | jsonValues |
      | Table      |
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url          | body                                           | response code | response message | filePath                             | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | auditrecords | payloads/idc/MLP_28531/AuditRecordsColumn.json | 200           |                  | payloads/idc/MLP_28531/Expected.json |          |


  Scenario Outline:SC5:Store the item ID to a file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive      | catalog | type  | name           | asg_scopeid | targetFile                         | jsonpath  |
      | APPDBPOSTGRES | ItemIDFormat | Default | Table | TestAuditTable |             | payloads\idc\MLP_28531\Sample.json | $..itemID |


  @MLP-28531 @positive
  Scenario Outline:SC5:Compare itemID value from Audit records API and DB
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                       | actualValues                       | valueType     | expectedJsonPath | actualJsonPath |
      | payloads\idc\MLP_28531\Expected.json | payloads\idc\MLP_28531\Sample.json | stringCompare | $..itemID        | $..itemID      |

    #7243308#
  @webtest @MLP-28531
  Scenario: SC#5:28531:Verification of ItemUpdatedEvent component value for Table item
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "View Audit Log" in "Landing page"
    And users performs following actions in Audit Log page
      | Actiontype               | ActionItem       | ItemName       | Section   |
      | Enter Text in Search box |                  | TestAuditTable |           |
      | Verifies Section Values  | ItemUpdatedEvent | Table          | ItemType  |
      | Verifies Section Values  | ItemUpdatedEvent | TestAuditTable | Component |

  @webtest @MLP-28531
  Scenario: SC#5:28531:Deleting created item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name           | type  | query | param |
      | SingleItemDelete | Default | TestAuditTable | Table |       |       |


     ######################################################################################################

  ###MLP-28531: SC6#Verification of ItemUpdatedEvent component value for File item

  @MLP-28531 @regression @positive @dashboard
  Scenario Outline: SC#6:MLP-28531:Create a File item
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                            | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP_28531\FileCreation.json | 200           |                  |          |

  Scenario Outline: SC#6:MLP-28531:Get ID of File
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type | name          | asg_scopeid | targetFile                          | jsonpath  |
      | APPDBPOSTGRES | ID      | Default | File | TestAuditFile |             | payloads\idc\MLP_28531\itemIds.json | $.classID |


  Scenario Outline:SC#6:MLP-28531:Get attributes of File item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                  | responseCode | inputJson | inputFile                           | outPutFile                           | outPutJson |
      | items/Default/Default.File:::dynamic | 200          | $.classID | payloads\idc\MLP_28531\itemIds.json | payloads\idc\MLP_28531\Expected.json |            |


  Scenario Outline:SC#6:MLP-28531:Update attributes of File item
    Given user update the json file "idc/MLP_28531/Expected.json" file for following values
      | jsonPath          | jsonValues |
      | $..asg_modifiedby | TestSystem |
    And user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type | url                                  | body                        | responseCode | inputJson | inputFile                           | responseMessage |
      | application/json | application/json | Put  | items/Default/Default.File:::dynamic | idc/MLP_28531/Expected.json | 204          | $.classID | payloads/idc/MLP_28531/itemIds.json |                 |


  Scenario Outline:SC#6:MLP-28531:Verification of name in component column in API
    Given user update the json file "idc/MLP_28531/AuditRecordsColumn.json" file for following values
      | jsonPath     | jsonValues       |
      | $..eventType | ItemUpdatedEvent |
      | $..component | TestAuditFile    |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    And user verifies whether the value is present in response using json path "$..['component']"
      | jsonValues    |
      | TestAuditFile |
    And user verifies whether the value is present in response using json path "$..['eventType']"
      | jsonValues       |
      | ItemUpdatedEvent |
    And user verifies whether the value is present in response using json path "$..['itemType']"
      | jsonValues |
      | File       |
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url          | body                                           | response code | response message | filePath                             | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | auditrecords | payloads/idc/MLP_28531/AuditRecordsColumn.json | 200           |                  | payloads/idc/MLP_28531/Expected.json |          |

  Scenario Outline:SC6:Store the item ID to a file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive      | catalog | type | name          | asg_scopeid | targetFile                         | jsonpath  |
      | APPDBPOSTGRES | ItemIDFormat | Default | File | TestAuditFile |             | payloads\idc\MLP_28531\Sample.json | $..itemID |


  @MLP-28531 @positive
  Scenario Outline:SC6:Compare itemID value from Audit records API and DB
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                       | actualValues                       | valueType     | expectedJsonPath | actualJsonPath |
      | payloads\idc\MLP_28531\Expected.json | payloads\idc\MLP_28531\Sample.json | stringCompare | $..itemID        | $..itemID      |

    #7243309#
  @webtest @MLP-28531
  Scenario: SC#6:28531:Verification of ItemUpdatedEvent component value for File item
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "View Audit Log" in "Landing page"
    And users performs following actions in Audit Log page
      | Actiontype               | ActionItem       | ItemName      | Section   |
      | Enter Text in Search box |                  | TestAuditFile |           |
      | Verifies Section Values  | ItemUpdatedEvent | File          | ItemType  |
      | Verifies Section Values  | ItemUpdatedEvent | TestAuditFile | Component |

  @webtest @MLP-28531
  Scenario: SC#6:28531:Deleting created item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name          | type | query | param |
      | SingleItemDelete | Default | TestAuditFile | File |       |       |

 ######################################################################################################

  ###MLP-28531: SC7#Verification of ItemUpdatedEvent component value for Field item

  @MLP-28531 @regression @positive @dashboard
  Scenario Outline: SC#7:MLP-28531:Create a Field item
    Given endpoint for "<ServiceName>" for "<ServiceUser>" having "<Header>" and query param with "<Query>" "<Param>" for request type "<type>" with url "<url>" and body "<body>" and verify "<response code>" and "<response message>" using "<jsonPath>"
    Examples:
      | ServiceName | ServiceUser    | Header           | Query | Param | type | url                | body                             | response code | response message | jsonPath |
      | IDC         | TestSystemUser | application/json |       |       | Post | items/Default/root | idc\MLP_28531\FieldCreation.json | 200           |                  |          |

  Scenario Outline: SC#7:MLP-28531:Get ID of Field
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive | catalog | type  | name           | asg_scopeid | targetFile                          | jsonpath  |
      | APPDBPOSTGRES | ID      | Default | Field | TestAuditField |             | payloads\idc\MLP_28531\itemIds.json | $.classID |


  Scenario Outline:SC#7:MLP-28531:Get attributes of Field item
    Given A query param with "" and "" and supply authorized users, contentType and Accept headers
    And user makes a Get request with "<url>" and verify "<responseCode>" using "<inputJson>" from "<inputFile>" and write to "<outPutFile>" using "<outPutJson>"
    Examples:
      | url                                   | responseCode | inputJson | inputFile                           | outPutFile                           | outPutJson |
      | items/Default/Default.Field:::dynamic | 200          | $.classID | payloads\idc\MLP_28531\itemIds.json | payloads\idc\MLP_28531\Expected.json |            |


  Scenario Outline:SC#7:MLP-28531:Update attributes of File item
    Given user update the json file "idc/MLP_28531/Expected.json" file for following values
      | jsonPath          | jsonValues |
      | $..asg_modifiedby | TestSystem |
    And user makes request with "<url>" and type "<type>" to verify "<responseCode>" and "<responseMessage>" using "<inputJson>" from "<inputFile>" with body "<body>" for "TestSystemUser" user and with "<contentType>" and "<acceptType>"
    Examples:
      | contentType      | acceptType       | type | url                                   | body                        | responseCode | inputJson | inputFile                           | responseMessage |
      | application/json | application/json | Put  | items/Default/Default.Field:::dynamic | idc/MLP_28531/Expected.json | 204          | $.classID | payloads/idc/MLP_28531/itemIds.json |                 |


  Scenario Outline:SC#7:MLP-28531:Verification of name in component column in API
    Given user update the json file "idc/MLP_28531/AuditRecordsColumn.json" file for following values
      | jsonPath     | jsonValues       |
      | $..eventType | ItemUpdatedEvent |
      | $..component | TestAuditField   |
    Given user hits "<ServiceName>" for "<user>" with "<Header>" and "<Query>" "<Param>" for request "<type>" with "<url>" and "<body>" and verify "<response code>" and "<response message>" and store value in "<filePath>" using "<jsonPath>"
    And user verifies whether the value is present in response using json path "$..['component']"
      | jsonValues     |
      | TestAuditField |
    And user verifies whether the value is present in response using json path "$..['eventType']"
      | jsonValues       |
      | ItemUpdatedEvent |
    And user verifies whether the value is present in response using json path "$..['itemType']"
      | jsonValues |
      | Field      |
    Examples:
      | ServiceName | user       | Header           | Query | Param | type | url          | body                                           | response code | response message | filePath                             | jsonPath |
      | IDC         | TestSystem | application/json |       |       | Post | auditrecords | payloads/idc/MLP_28531/AuditRecordsColumn.json | 200           |                  | payloads/idc/MLP_28531/Expected.json |          |


  Scenario Outline:SC7:Store the item ID to a file
    And user connects "<database>" and "<retrive>" by running query with "<catalog>""<type>""<name>""<asg_scopeid>" and store the item id results in "<targetFile>" using "<jsonpath>"
    Examples:
      | database      | retrive      | catalog | type  | name           | asg_scopeid | targetFile                         | jsonpath  |
      | APPDBPOSTGRES | ItemIDFormat | Default | Field | TestAuditField |             | payloads\idc\MLP_28531\Sample.json | $..itemID |


  @MLP-28531 @positive
  Scenario Outline:SC7:Compare itemID value from Audit records API and DB
    Given user validates "<expectedValues>" with "<actualValues>" for "<valueType>" using "<expectedJsonPath>" and "<actualJsonPath>"
    Examples:
      | expectedValues                       | actualValues                       | valueType     | expectedJsonPath | actualJsonPath |
      | payloads\idc\MLP_28531\Expected.json | payloads\idc\MLP_28531\Sample.json | stringCompare | $..itemID        | $..itemID      |

    #7243310#
  @webtest @MLP-28531
  Scenario: SC#7:28531:Verification of ItemUpdatedEvent component value for Field item
    Given User launch browser and traverse to login page
    And user enter credentials for "System Administrator1" role
    And user "click" on "Admin Link" for "View Audit Log" in "Landing page"
    And users performs following actions in Audit Log page
      | Actiontype               | ActionItem       | ItemName       | Section   |
      | Enter Text in Search box |                  | TestAuditField |           |
      | Verifies Section Values  | ItemUpdatedEvent | Field          | ItemType  |
      | Verifies Section Values  | ItemUpdatedEvent | TestAuditField | Component |

  @webtest @MLP-28531
  Scenario: SC#7:28531:Deleting created item
    And Delete multiple values in IDC UI with below parameters
      | deleteAction     | catalog | name           | type  | query | param |
      | SingleItemDelete | Default | TestAuditField | Field |       |       |


